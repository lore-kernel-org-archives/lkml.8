Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00258C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF13420730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FRCfecG5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VyYUR6Cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgD1RHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:07:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4772 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728212AbgD1RHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:07:08 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03SH6qaa014126;
        Tue, 28 Apr 2020 10:07:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=xSD8Z7qeTmhvISYDtQK+LA7qGZcUpQtZKpz0jQBf6xI=;
 b=FRCfecG5Kzj2J6vyFe/R2pDOxLwEXh5QZdVrlzLbIgXB2HIxJ/5FnInt0ABwwV4o2iIF
 1FgGAe4rQ1GwHCqFhwKtW5jHOQxig6fp4DRHPXRx2XbDtPuTD8snVwd15bScJzU++sh6
 q7o26dcgeYroYiF/vfItxpdJslwo2hwxuHY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30n57q88by-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 28 Apr 2020 10:07:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 28 Apr 2020 10:06:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZznA3O4MkGd+4h43cdkg+7XoP0ZXFeaeM/q4/kNvSl9mjCrrZIZLId28v6fqIP4v7fnGjI4zNo9b22nvfx2Bb4H4I8oMZLz93Lml4Nu+bUXMK2ctB5v8vfA4rjW63pIlvAvB9qtxlmtjwArpyST90Okaf3mbbkH8ICztNkrIR7UASdayIKVg0hoCqg3H7/TzyiyUrFA32NW+sy0HUO1MSKx9Khzh870HLze0NTtRdBZ+rjKrfClFCL4KpuAk4iCNKV3q8KrUmgTr+Ks9bVh3G+fTJ5YebLP5aph5tST70CqK+Qs2blBLjDPhPcVo5Nto6Sw1l2Lwcfl/fYiJu/OceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSD8Z7qeTmhvISYDtQK+LA7qGZcUpQtZKpz0jQBf6xI=;
 b=LMMi65imbWaxxZqd3d9d83KDJ0T/8cxlGe1EU5/UnsvmrQoDDZH7XTnuJyqcP9O6bwpU8V8M+d8XZSYSgKxeN/+mb5o0Qij32gGec4jRZZ+2pvjBVTFeyXczZQxA5oXmO0lpspQNNBkW1tdBDtMgElboJhMj6Fe/MGtcegHLEiCcT7ufhzNGLBusKI3Ex9AGrN1usXEQwSkS7s/fQFPWP6d+5ZQjbk1lLtXw85NEedYb6CXzt0LS86AhaM5ZttyY2qW7+od69Tra00yQU1K2o6WivkzoDzxClBqPJN4IWb84GEpZDDK9l+uJqIIy387cxS9riQ/7YMveBsQZE9/U7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSD8Z7qeTmhvISYDtQK+LA7qGZcUpQtZKpz0jQBf6xI=;
 b=VyYUR6CzF+fq+XQKjTa4Bm2yfkcWdDCqjQVfEZ8tbu1RFQlPxSvdYUzWCgzherXGIyGAqeTcIeHTfk2cxOij54z7Wgl9ERXrbWbRGPB6EkKD/3hfQ7gT8nhX0dIWUtrPisdJKgFbeUqLdxa4UEZlL7dGwf0lbiSLShgJ+y38l9Q=
Authentication-Results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2374.namprd15.prod.outlook.com (2603:10b6:a02:8b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 17:06:49 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 17:06:49 +0000
Date:   Tue, 28 Apr 2020 10:06:45 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Christopher Lameter <cl@linux.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
Message-ID: <20200428170645.GA158422@carbon.dhcp.thefacebook.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-5-guro@fb.com>
 <alpine.DEB.2.21.2004222349280.20021@www.lameter.com>
 <20200423000530.GA63356@carbon.lan>
 <alpine.DEB.2.21.2004250208500.7624@www.lameter.com>
 <20200425024625.GA107755@carbon.lan>
 <alpine.DEB.2.21.2004271618340.27701@www.lameter.com>
 <20200427164638.GC114719@carbon.DHCP.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427164638.GC114719@carbon.DHCP.thefacebook.com>
X-ClientProxiedBy: MWHPR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:300:16::17) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:e200) by MWHPR13CA0007.namprd13.prod.outlook.com (2603:10b6:300:16::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Tue, 28 Apr 2020 17:06:48 +0000
X-Originating-IP: [2620:10d:c090:400::5:e200]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa14b42b-e6b3-43fc-1655-08d7eb968a14
X-MS-TrafficTypeDiagnostic: BYAPR15MB2374:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2374DA990415CD7ADBB7072ABEAC0@BYAPR15MB2374.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(136003)(366004)(39860400002)(346002)(6916009)(8936002)(2906002)(66946007)(66556008)(1076003)(16526019)(33656002)(6666004)(66476007)(54906003)(52116002)(6506007)(86362001)(7696005)(966005)(8676002)(478600001)(9686003)(186003)(4326008)(316002)(55016002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQ80H6XvvsyeMJxjK2hXq9QJB67SI9qXX7l72l1O+bVfqt0HucoH2VT5AwRglHbnEHbgX5uvCpm+p1BTsff/cQTCGhhaWYvdTcPU8knT9fGUx3PWHlymc/NiiyKf61Xog3+aPzYQpkWhFxLju3kobVKFghAPFkskeTKZLtIYobkDNVXPj1WP73MLkNBw0+MmQQ/+Ld1x0OSm99XJm+Xwvg3mtnfN1amcLph5pQUilERb/hDqAcEraUEG/jMGm/L36zsRR4wnz9y0vm8hBO1H96cD8x9jLYQpRpAAhQiSmc5xImp6QIaSalNItdOzdG4XWwy533dcQkJGcFFx3kFgU5UWoNMUeJoCaMwnaefKUu70rg903qWT9G9adS0vyZ9h+6tDXI4Rkfso2ZyPQsf9eiUq4DX+qCuDozFm8dF9YhFaI8FQ6nd+y6nyF2rnXuYdb+aCx2nij+zfG70z2PXxnJeHR88ZQ1o0dxFIxYbyw8l3GfG/hrsGxDtJvuVVXNgOXcrKI5HmFsEu0phY3eGUJg==
X-MS-Exchange-AntiSpam-MessageData: jgMlfZf7XH6yxGTLixV2ou6Jf2ypm6GDMXnVfBI1dM/J+poYP+qiKu9PcGR7Ti3yMttm5W222Slm/M7HElMmgquS2Wj6WZVPElBvueeud7dzoiOYZ6ud4Zoru93Qj+XEvx7PRI4YSardSSXMtGUKuyjerfh5JXZfs7hNCuMj/sPrNFlQB8SnwxXo7yne9k977WoFrmospNPLnufUUna1PYKpXKeymy6pmzwLJlA6AGGZ2VYDklOfg4zYYUiN8tDVy/sLtUtrnqJ9TxOQW2ivpn6Lyw7pe2WiwODCZD2XHjip8dQQliuKL1DFoWT1l72q09Y0srBEuXhABfqeUuhikqAbGMQrw4PwpriC4Go6KMPHN9aSMF3pbs3jOjUyhhRMy4wpxLff4FKkccuwqUoZZR54egUd/KIy66fvdlmRDNZ5jXMIEWZkkRqBoJpNbrELcA1yN443/5hOQ1sQlA2zL4hHFunu5yac/KWjDwSHyVH9FU9EJ6N9V9UW1PhB76OV/9mr+cXnX5Mxvdes7Jh3BPxit7M7+p2NA7i2jIUwR4pK4RGEAb3yaw3WngcpfuZWwb8830u7eA9D1KmVhGOvANHzLcnngDuhmVA4M6ZtIXasMzIDpqXuEAhG4f+ooaYu4mRM1EF45zuJrU5paGeIpH+cDIqwa2MV0GsdidMQyBekrA5DcDAWr1eDT5e8x0KAXM4M8Kybba/FWrYl2WVjx8Ti8Bw7JfeMdUKAca4IhhKQAKnvF6xd2nfoBbZCkBKK76h9Fk2guKRDaFLwQ8UT5yMofE4SDDdKjKGsy2n+v5AHY4jIYl3WgWwO3HQDF2hcUEuqLl0rk/j5w8c2FBsDZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: aa14b42b-e6b3-43fc-1655-08d7eb968a14
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 17:06:49.3866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iU85e8Bi01KuG1X/Aogb2cMcNRJA8o7f2ZqAB0JXhvJvqkHUKIobpM61rMqnTfIm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2374
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_12:2020-04-28,2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004280135
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 09:46:38AM -0700, Roman Gushchin wrote:
> On Mon, Apr 27, 2020 at 04:21:01PM +0000, Christoph Lameter wrote:
> > On Fri, 24 Apr 2020, Roman Gushchin wrote:
> > 
> > > > The patch seems to only use it for setup and debugging? It is used for
> > > > every "accounted" allocation???? Where? And what is an "accounted"
> > > > allocation?
> > > >
> > > >
> > >
> > > Please, take a look at the whole series:
> > > https://lore.kernel.org/linux-mm/20200422204708.2176080-1-guro@fb.com/T/#t
> > >
> > > I'm sorry, I had to cc you directly for the whole thing. Your feedback
> > > will be highly appreciated.
> > >
> > > It's used to calculate the offset of the memcg pointer for every slab
> > > object which is charged to a memory cgroup. So it must be quite hot.
> > 
> > 
> > Ahh... Thanks. I just looked at it.
> > 
> > You need this because you have a separate structure attached to a page
> > that tracks membership of the slab object to the cgroup. This is used to
> > calculate the offset into that array....
> > 
> > Why do you need this? Just slap a pointer to the cgroup as additional
> > metadata onto the slab object. Is that not much simpler, safer and faster?
> > 
> 
> So, the problem is that not all slab objects are accounted, and sometimes
> we don't know if advance if they are accounted or not (with the current semantics
> of __GFP_ACCOUNT and SLAB_ACCOUNT flags). So we either have to increase
> the size of ALL slab objects, either create a pair of slab caches for each size.
> 
> The first option is not that cheap in terms of the memory overhead. Especially
> for those who disable cgroups using a boot-time option.
> The second should be fine, but it will be less simple in terms of the code complexity
> (in comparison to the final result of the current proposal).
> 
> I'm not strictly against of either approach, but I'd look for a broader consensus
> on what's the best approach here.

To be more clear here: in my original version (prior to v3) I had two sets
of kmem_caches: one for root- and other non accounted allocations, and the
other was shared by all non-root memory cgroups. With this approach it's
easy to switch to your suggestion and put the memcg pointer nearby the object.

Johannes persistently pushed on the design with a single set of kmem_caches,
shared by *all* allocations. I've implemented this approach as a separate patch
on top of the series and added to v3. It allows to dramatically simplify the code
and remove ~0.5k sloc, but with this approach it's not easy to implement what
you're suggesting without increasing the size of *all* slab objects, which is
sub-optimal.

So it looks like there are two options:
1) switch back to a root- and memcg sets of kmem_caches, put the memcg pointer
   just behind the slab object
2) stick with what we've in v3

I guess the first option might be better from the performance POV, the second
is simpler/cleaner in terms of the code. So I'm ok to switch to 1) if there is
a consensus on what's better.

Thanks!
