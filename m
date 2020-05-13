Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77566C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 519CA23126
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="C8etdJIr";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VpNpy9WI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbgEMA55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 20:57:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8780 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728131AbgEMA54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 20:57:56 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04D0qG8G004910;
        Tue, 12 May 2020 17:57:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=i4JG7ujVBrYpnRK1agy3xGTMUxH6kf5bhxbqFopHLjU=;
 b=C8etdJIriSPvaTliYAlIb6FLciR56CtGkav91Eme88ivZ0+eHHAeqHz/YL3pnfUeo/Gi
 S6MXLFVUjPWAuN2/F2jw3SH000OUaefVVYzG7veCa7iSnGRSsBGE9eW3p0O30rAjnnYg
 g1BmlHXmfmW15TEQJf21D81qNDUH+aE5O+s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3100vyhxvf-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 May 2020 17:57:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 12 May 2020 17:57:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPPiI4Pim1/yQWRalcOwlAYgY0wY2YNxYH3GKwodmkhqyqe3olEBkpzmPZcW+DM+PAW7F/hvZIganL68K6FWwfTT8WTmyG5jWENwiZd9tUZVi/gnEHY9R8mkcRJ+spbVDEPlXR2SOGxnhq+PSwvfFaXxR4YPYXy3egDu9apPBDny7n/XReGDmvXpKyTJ16XUMBi6Iia1BJGJCuGYYaI5AvhL8KYyo5JpMsXJr/FGWJuERKEOmESa1Cnc7B16SWwWhyuMZr8PCli+lpWBvFZ2j80C8HNNgUHN+FfsWrZDZhoOzypnRzc1f+VMGPna8x2s6LMOmU+uA77QrQHKuv7epQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4JG7ujVBrYpnRK1agy3xGTMUxH6kf5bhxbqFopHLjU=;
 b=aHURaYA01xpmtPv6CqlehLOJ5qGKStS7/hmLW/jh1VgXGwX4Ew9ogLhOY9k/H3tDGcYla3HjISNgGgJuFVRbpWFYJxN+4a7IhIkwJtxkyjbr7qzBsDK/LKYVN2OgG760F9/mFxwwdTEzg3IpEq+s8YxEJPk4+S8j9vlrMlNZIi4ZpFxaNfYG6+vtTjSdzymbDyo3V6RWYpBh3zY0SsHLzecI3iPk5vmLtDVR3p/4hPe7N7Ga/uJY99ULOReQXn+tJrE2EeXENTUR8e3c5tc2NR72B9gUAuJjx0YU95anhhub1RClurTtxxNJBQvgw48GVDsd2q+/tjQPhZrJ43Y0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4JG7ujVBrYpnRK1agy3xGTMUxH6kf5bhxbqFopHLjU=;
 b=VpNpy9WIO/IrbiJ/oaEnQNkSgy1WcKGF/JzIIiY+HN7ONo5NLX97AOp+ww3MLb8+2lxNwyMKUG488UGC3w0Kl8qOD7ES6RKGsVuVLEyeidnr/M+wXyDTYRmIh1IU5z6KulTFXia+ToAy6OkHqveoKaAUqR9y0syRuT0NmqMbr/A=
Authentication-Results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2359.namprd15.prod.outlook.com (2603:10b6:a02:8d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Wed, 13 May
 2020 00:57:44 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 00:57:44 +0000
Date:   Tue, 12 May 2020 17:57:41 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christopher Lameter <cl@linux.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
Message-ID: <20200513005741.GA67541@carbon.dhcp.thefacebook.com>
References: <20200423000530.GA63356@carbon.lan>
 <alpine.DEB.2.21.2004250208500.7624@www.lameter.com>
 <20200425024625.GA107755@carbon.lan>
 <alpine.DEB.2.21.2004271618340.27701@www.lameter.com>
 <20200427164638.GC114719@carbon.DHCP.thefacebook.com>
 <alpine.DEB.2.21.2004301625490.1693@www.lameter.com>
 <20200430171558.GA339283@carbon.dhcp.thefacebook.com>
 <alpine.DEB.2.22.394.2005022353330.1987@www.lameter.com>
 <20200504182922.GA20009@carbon.dhcp.thefacebook.com>
 <alpine.DEB.2.22.394.2005082130570.65713@www.lameter.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2005082130570.65713@www.lameter.com>
X-ClientProxiedBy: BYAPR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:3a35) by BYAPR07CA0083.namprd07.prod.outlook.com (2603:10b6:a03:12b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Wed, 13 May 2020 00:57:43 +0000
X-Originating-IP: [2620:10d:c090:400::5:3a35]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6928f0f-4102-42fa-d755-08d7f6d8a4eb
X-MS-TrafficTypeDiagnostic: BYAPR15MB2359:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2359ED3703FF009363F0478DBEBF0@BYAPR15MB2359.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+Kd27tFJtVfvtxaNoIDhnsrdJ0D+7KrJgbJDKuLQIY5uSf/0o15T7zwpqTftQf3B006dSD6IQYpwf8tzGNw2xjM+QZ0J8gh+EgkMzUMVnaC6l1EhPLmCfjpHc+uVwysMzE8afmJHwXpnSMGcO0AVLAWJESHPj+iMTEbWRJyaJxdcdm/wyxaOf53K8A1lX+dX0yMz76U4td1/WQ2tRLFr1yksCCK60c3/0VPfeWQm9dtr2Z0pphO9FQEu/+OHRzmuQdzG+7VtXcEsjrdAXXwFfeBzFmlKT+DPgAtQbFF/Mhzld07TMwvH4DYFxqgksUR2SF5njg/uAC7QUgrvznKiTPlNXyYhOPEISG20YR1EDf3GhhOMdlb9O3U/yHLVqaXMYOvaDDbIUEg7k8DhtiZOEwbkT8Cvwh+s5yIp9JYCAOtsSyXOVcd0X9oHCQxSLpwmHKE6rbOaen8kP6nnndwgNmRu3ct0mR1U6a/uqFUlAeDeLmjZykTxFxFXBAJNZAX8A6pydfxnhNOVgkbuELVIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(33430700001)(66946007)(66476007)(5660300002)(7696005)(6916009)(52116002)(2906002)(8676002)(8936002)(33656002)(4326008)(9686003)(66556008)(55016002)(54906003)(86362001)(1076003)(16526019)(6506007)(316002)(478600001)(33440700001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 9cbPfnBxi5hE+pm3RSaw5JuQqX+MF7h9uNn+fqFVX/IEe1pN6JXC1p6zvOo8TUskfqUiUASX9HZbn0Hv/isjVd/rVmCri8JFICDYbPNSKtiQ/yBp8pVuyPAo1TfK/wqyFNViprGAU1D2jNerjPe1FJ5coJl1RBCIH5GDHXeisYTjZ3ikgr19kqRnacf8JNVRSXmknVgoG6okGRoJBzbv8tWcx1pCKgzViIuC4a2y0xlNj5thw4OsenP76KCaE6GHihO+rJuFhN4/OTrMH9kuC0Aeid5mqi3xNOGTlpLQLLCxBf2hOAfOABofecCllNAd4AV2prW+fbbqrqnCV8nIAFjwAQVISOr5aVFiAl295QxBwKQJHsJXsS+5H1InOIqGPhAuV4rfZE+doYPJ6TEeR7KrQKn0Ot1mQtdNZDNGf5KKCn+aZbS6fY8WgSGD7LKL48hEWOXHSd/hDM8DpfXFfUPfE++8bL4iajvqJOEsvkJpSW5orZbr0FPqT16Vr50sSip13RhuWL+48f5vUEpelQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e6928f0f-4102-42fa-d755-08d7f6d8a4eb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 00:57:44.3568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: on5yfMN/ppqXG7nN0Z7kweO9hLBIehCBVIa5134mqecnux0MUwnzXSg8Mt+ms/es
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2359
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_08:2020-05-11,2020-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 cotscore=-2147483648 priorityscore=1501 suspectscore=1
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130006
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 09:35:54PM +0000, Christoph Lameter wrote:
> On Mon, 4 May 2020, Roman Gushchin wrote:
> 
> > On Sat, May 02, 2020 at 11:54:09PM +0000, Christoph Lameter wrote:
> > > On Thu, 30 Apr 2020, Roman Gushchin wrote:
> > >
> > > > Sorry, but what exactly do you mean?
> > >
> > > I think the right approach is to add a pointer to each slab object for
> > > memcg support.
> > >
> >
> > As I understand, embedding the memcg pointer will hopefully make allocations
> > cheaper in terms of CPU, but will require more memory. And you think that
> > it's worth it. Is it a correct understanding?
> 
> It definitely makes the code less complex. The additional memory is
> minimal. In many cases you have already some space wasted at the end of
> the object that could be used for the pointer.
> 
> > Can you, please, describe a bit more detailed how it should be done
> > from your point of view?
> 
> Add it to the metadata at the end of the object. Like the debugging
> information or the pointer for RCU freeing.

Enabling debugging metadata currently disables the cache merging.
I doubt that it's acceptable to sacrifice the cache merging in order
to embed the memcg pointer?

> 
> > I mean where to store the pointer, should it be SLAB/SLUB-specific code
> > or a generic code, what do to with kmallocs alignments, should we
> > merge slabs which had a different size before and now have the same
> > because of the memcg pointer and aligment, etc.
> 
> Both SLAB and SLUB have the same capabilities there. Slabs that had
> different sizes before will now have different sizes as well. So the
> merging does not change.

See above. Or should I add it to the object itself before the metadata?

> 
> > I'm happy to follow your advice and perform some tests to get an idea of
> > how significant the memory overhead is and how big are CPU savings.
> > I guess with these numbers it will be easy to make a decision.
> 
> Sure. The main issue are the power of two kmalloc caches and how to add
> the pointer to these caches in order not to waste memory. SLAB has done
> this in the past by creating additional structues in a page frame.

But isn't it then similar to what I'm doing now?

Btw, I'm trying to build up a prototype with an embedded memcg pointer,
but it seems to be way more tricky than I thought. It requires changes to
shrinkers (as they rely on getting the memcg pointer by an arbitrary
kernel address, not necessarily aligned to the head of slab allocation),
figuring out cache merging, adding SLAB support, natural alignment of
kmallocs etc.

Figuring out all these details will likely take several weeks, so the whole
thing will be delayed for one-two major releases (in the best case). Given that
the current implementation saves ~40% of slab memory, I think there is some value
in delivering it as it is. So I wonder if the idea of embedding the pointer
should be considered a blocker, or it can be implemented of top of the proposed
code (given it's not a user-facing api or something like this)?

Thanks!
