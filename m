Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81301C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C206208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lAoQHWLL";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AgfhqfTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgFQCmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 22:42:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9710 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726494AbgFQCmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 22:42:07 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05H2d2ng027633;
        Tue, 16 Jun 2020 19:41:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=fnbo8KlB1PdOUadUu5uaeyTQp9H5hCxc95hRZ0OrYUU=;
 b=lAoQHWLL1/AeQaU+5A0WB5dZ/nrDWaBotDi3ZtdVlZQLJRXxa8gHLGhUab0u1Xp5oMpa
 U00kUjgjW6evo0fcg6SvbPvvvyct4FQUrFlKbHttOv8q+8PTS2xfgZV6m9lKj8AgXPgK
 hAHtFpMacLhvKsdwdHmjaNr070gPi7VUZIY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31q8u68bc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Jun 2020 19:41:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Jun 2020 19:41:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkjKhyS32cZ6iOgX30WQKVlYznxJ2eUF7A6gUmsEG+XD3iAYvONBEs3bi44Wd1XIOnd6llJ52Cjseu8g5c/LYQC7PIo1Glbtmpji0EbrQ1Na84HUb3wZygkEBBYexUJcxdk10purAL5vM2FEghKNVUuRWNaydEyDOeu6t7cuRChidvmv9TeouwaMdI1mAdrqlcvDvaxOTRJ+zT4HkzVgDpczyNn4tCxAi6igeATEJUicoZi4w+48lQVqO+v2cRUJelsFhJ+TFTW9gg85WJkmYzf8PIsEzxRsLGrOcqCQsN8fRtCxhrPOhZu0khWo3xkVPodDx6rZtH2IMOzTytgCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnbo8KlB1PdOUadUu5uaeyTQp9H5hCxc95hRZ0OrYUU=;
 b=WuHleGgh9me7FZQQJHPeGBcnCFgk7IgBJHBJ3rZJ+l3M+9vzngZt9v3ebUaueXtqdayo/NLa1kvXEyYLqdRcofWZLJqHw9b/V5fQ3F13iLj0cH3z612xFFYzbZAszV1xXKdqKcLmfSRV7KigLVDZMFnFtS1PoE8krbYdTaLGxG8j8al4ddZb9FFZI5Bbynew5+5X3icNTSCRkitNizs+62eK22TITTC2ya/F3X+GC5wpYWs5yXzyB+B35y+dM9UdPjEGHzhLY/HHcc8+VGMPdAMtYDCoabGt8fws2acllcE8mb+YCOx3rUp4fteEYHyGjDz7ekRQOW7RMMQ4PgrcFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnbo8KlB1PdOUadUu5uaeyTQp9H5hCxc95hRZ0OrYUU=;
 b=AgfhqfTo3du5MT4DwCzjMtbNhawaMddzGDFafc/mKRnnzWnqqjY4wFMuX4Tj3UKvmsZIiamPPhi3MT0fm5T8xdSELSnf2prr4h2LUCwPc9Gaxc3ssFyIJBz8O3WoXxHIqUXR5MmzOWMSLOiF7xxCNYQvLMqBEraedHtjwnXIGp8=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3159.namprd15.prod.outlook.com (2603:10b6:a03:101::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 02:41:50 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 02:41:50 +0000
Date:   Tue, 16 Jun 2020 19:41:47 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
Message-ID: <20200617024147.GA10812@carbon.lan>
References: <20200608230654.828134-1-guro@fb.com>
 <CALvZod7ThL=yMwxzCLvrTtq=+Dr5ooUSX-iFP8AhiAGURByFBA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7ThL=yMwxzCLvrTtq=+Dr5ooUSX-iFP8AhiAGURByFBA@mail.gmail.com>
X-ClientProxiedBy: BYAPR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::33) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.lan (2620:10d:c090:400::5:818f) by BYAPR05CA0092.namprd05.prod.outlook.com (2603:10b6:a03:e0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.9 via Frontend Transport; Wed, 17 Jun 2020 02:41:49 +0000
X-Originating-IP: [2620:10d:c090:400::5:818f]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e996079b-b7af-41b9-e079-08d81267fcaf
X-MS-TrafficTypeDiagnostic: BYAPR15MB3159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3159E36ED09669EE09BF9700BE9A0@BYAPR15MB3159.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdSRMLOvfQ3PBq58IZIOWS3XDCsZ8ye/xF7AsK4ri0CaQ6t8ONo3npALLTAMenzg82j0BT2KmqbUevs4D29YZTLG1ZkVq5buWaN7n1IVuoQy8Ew4WV8HFojCMeJC0sKixKemDP+6q4i7cKgmx+uIV/h2PUyTxKJuSc+jwXDeXETgD04Ank8O96XvVBb82s2KQAcWJ65yNBZlmOqbNgx56HUqapck3JiSYGTFhfIt3Hlu2tosXp9+GsITjT/lzBOlUYLyJQbDyVffyGsR7bvnv5Ufs0Nm2w48b+aLNIDpytZ8Kt41Y/Y8Xl2EdvJokwkCzd1cEu2xQcqkFlYrDdDllQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(396003)(136003)(366004)(346002)(66556008)(66946007)(66476007)(186003)(16526019)(33656002)(52116002)(7696005)(54906003)(316002)(86362001)(83380400001)(6506007)(53546011)(8936002)(478600001)(1076003)(8676002)(2906002)(8886007)(36756003)(5660300002)(4326008)(9686003)(55016002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: WCqg9yEjvLhu3EEjfFGZMom3/dbxodBV9g5dpL7QM6fQV/S5NSbUxjeBkiU7QgfpaU71BF19Ou8pem39KYNwYP0LaSfdSveF4nV0iDJHI+UxxuRmo5Nd8CbaxD4H+x3f90/KMggpJe8N5lDWKxyXqmzKDAD1L1M3cYZ9VZmawQCEB/QC55SK81fLuw5Ws86ubVZyBDl9yJifJFCg8sGLP/bui4n8j9e7nPvhojTVQ7PXjLoCk0MhQZBfy85EQJnJ9Jvhl0rweQPNM2eJEwoCw03Sawz6qeXbOioFQgZv8oHLMeVyjVBxa/CTMtuD5XUy/JPHgSqgcrF+ZlcQrAxyNfbUkCRYDvDMhkQGCcu0prFISXxi+/BHWG/0y+QmbyLd2Gg6C8ZF3rnLW1gxDKmuv1iwgjo/CqstvlOZrQaMhuS4vkxW2jsSi+Sw6qA9Wsw4sAHbYmwJKotLci/AmJPtn4oRMTW9xVBBiBS9WKfSMymV1CGXkh6adQe8EyeKUeuWPKQgLLIo+XraPYV3A/GxDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e996079b-b7af-41b9-e079-08d81267fcaf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 02:41:50.6059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ylur3EGxtsqq9qnS558tLc+jpNcUsvYG4xEP2lrpFCqHv4Xgu38w7XcLGwK7tGzj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3159
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_13:2020-06-16,2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 cotscore=-2147483648 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=1 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170020
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 06:46:56PM -0700, Shakeel Butt wrote:
> On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > This is v6 of the slab cgroup controller rework.
> >
> > The patchset moves the accounting from the page level to the object
> > level. It allows to share slab pages between memory cgroups.
> > This leads to a significant win in the slab utilization (up to 45%)
> > and the corresponding drop in the total kernel memory footprint.
> 
> Is this based on just SLUB or does this have a similar impact on SLAB as well?

The numbers for SLAB are less impressive than for SLUB (I guess per-cpu partial
lists add to the problem), but also in double digits of percents.

> 
> > The reduced number of unmovable slab pages should also have a positive
> > effect on the memory fragmentation.
> 
> That would be awesome. We have seen fragmentation getting very bad on
> system (or node) level memory pressure. Is that the same for you?

Well, we didn't have any specific problems with the fragmentation,
but generally speaking reducing the size of unmovable memory by ~40%
should have a positive effect.

> 
> >
> > The patchset makes the slab accounting code simpler: there is no more
> > need in the complicated dynamic creation and destruction of per-cgroup
> > slab caches, all memory cgroups use a global set of shared slab caches.
> > The lifetime of slab caches is not more connected to the lifetime
> > of memory cgroups.
> >
> > The more precise accounting does require more CPU, however in practice
> > the difference seems to be negligible. We've been using the new slab
> > controller in Facebook production for several months with different
> > workloads and haven't seen any noticeable regressions. What we've seen
> > were memory savings in order of 1 GB per host (it varied heavily depending
> > on the actual workload, size of RAM, number of CPUs, memory pressure, etc).
> >
> > The third version of the patchset added yet another step towards
> > the simplification of the code: sharing of slab caches between
> > accounted and non-accounted allocations. It comes with significant
> > upsides (most noticeable, a complete elimination of dynamic slab caches
> > creation) but not without some regression risks, so this change sits
> > on top of the patchset and is not completely merged in. So in the unlikely
> > event of a noticeable performance regression it can be reverted separately.
> >
> 
> Have you performed any [perf] testing on SLAB with this patchset?

The accounting part is the same for SLAB and SLUB, so there should be no
significant difference. I've checked that it compiles, boots and passes
kselftests. And that memory savings are there.

Thanks!
