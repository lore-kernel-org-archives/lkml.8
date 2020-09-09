Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B0BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8DD2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="on1SU9I5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iFuObgFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbgIIQ4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:56:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15732 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730733AbgIIQzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:55:55 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089GtgQB006189;
        Wed, 9 Sep 2020 09:55:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=hc+mPFEDMCdkMnnLRmsZx9vxHJRcBGZjLDFBkN63JP0=;
 b=on1SU9I59O6kWUNJhE06Bn58keO9mUBVgTw3ShGIfI2el/KwpmjeUsQs5tN0U8W8XY6I
 d2AQJBMjvjosqnOIK+77CDQ3YNcv/LZ9ho2/7FrENNArf+kWmoH/JTDxovl/dY+nK134
 LPIFWvCsZVZ3YzpuNcZEk27IvcoF1i3xDWs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33ct69rbdw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Sep 2020 09:55:44 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Sep 2020 09:55:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dS7Os3sUlPHFADeSt4eWfALcBdNCs/BU7KeAoqRqHrfVGzBkWV4WxFT0mBDhLR8J4BRrbaKEYX4fiS9CWH/yzx8CtvJZwS/+BP9Lfqkpfn7OSz68GJyAoEO6INwG3npMq0BjtyfykKPYn3d8atz9dN+LE29l6lR/8sGQlzI6ggzafyTxGPBFVs//9otMNSQDLiXmzTLwz4a7BUOsO0cursqilO3eECDU51W02QJVHW0g1A1ofXnUDz3wqNY+wJng6lmaDQMdkqj1w/wnhUnL6epoiIrsC2+tH9FPv3QALcYIhaU+kajaNECYaCF+WsNucnVC/SC5fwdEk2dAci2ZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc+mPFEDMCdkMnnLRmsZx9vxHJRcBGZjLDFBkN63JP0=;
 b=WYRZraoxfsx2thl4JEDEgNcr/fB4Ouo/nm3E6XfsOhCiD++DLf5QRxuvEHZzKWk0U5aNdXsrc8jUidGVoOtoSaBkO67rEQcvDJ1vXZ/HuKJ7lArk43UdWwkX/uJPT9yOFpdSMdbF85Cq3iEs3xzSMTlpNe6rb56ILwzLjlG3DAiyP0d2J3/a/kYFp4VM7qS/u7bGzMRk6h2MCJ/DV+cEQRHiko6uSwPjrqRbJTdbI1wLsxWX3jMevOerpBse3Tk8LzqnkSy4MbKHSA2d3KXG/hWjtIWuFCChP9FD+rHBfU2wSVfgKMDkvlGK7swxtSyLnWJ7wJ0v7KeKWmE4nykm0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc+mPFEDMCdkMnnLRmsZx9vxHJRcBGZjLDFBkN63JP0=;
 b=iFuObgFNfkKeadTxWpAk85U10liPWsA+sZvABGYSTtP8Pkagjv05TMX8j8WVFac1T1XtRBNf2G5jSl2LL4TAPTIEH++3AIhKa61id4mHfd2H6jxmSyxMut/3WERreufTRtR10s6VTeGsfdBT2HJJT0E87N6F/lFwBgZcFv+wqcA=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2439.namprd15.prod.outlook.com (2603:10b6:a02:8e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Wed, 9 Sep
 2020 16:55:25 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 16:55:25 +0000
Date:   Wed, 9 Sep 2020 09:55:20 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        =Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: workingset: ignore slab memory size when calculating
 shadows pressure
Message-ID: <20200909165520.GA1163084@carbon.dhcp.thefacebook.com>
References: <20200903230055.1245058-1-guro@fb.com>
 <20200909145534.GA100698@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909145534.GA100698@cmpxchg.org>
X-ClientProxiedBy: MWHPR14CA0062.namprd14.prod.outlook.com
 (2603:10b6:300:81::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:8cb5) by MWHPR14CA0062.namprd14.prod.outlook.com (2603:10b6:300:81::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 16:55:23 +0000
X-Originating-IP: [2620:10d:c090:400::5:8cb5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d03beba-d0fe-4462-2397-08d854e12581
X-MS-TrafficTypeDiagnostic: BYAPR15MB2439:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2439EC6EBA79E19DD092DADCBE260@BYAPR15MB2439.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 305sy+EH/4U93NfsvOG9HKo96a1FIGNevCCq5WoZc6Kpb0NUwMoepabWh+FA7gw41M1CXZ0zMDWySUdmsrkAnsh2HlVvqzytf/qq19IRnLdFQZjCZnNSfZdaaKvMEdOBAfIhagxskUxp0aAg7mT/PLFoIgj/OLGaZ/nYqZefxxZv679uQxiY6laULXs+XZqZVHy9S75hVmQrNWboZY4kRx3z2EiPQbaWtUwxPlYxt6ebNtadqsUtkeGEJN2BrJiWaGd35TIPE4azDj6t3jHrEUSmLsiomHD74YZGhCqvk/C2EHUQSbCuIYbg7YDSQU1o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(366004)(136003)(346002)(6506007)(16526019)(66946007)(478600001)(2906002)(9686003)(55016002)(8936002)(52116002)(8676002)(4326008)(54906003)(316002)(7696005)(186003)(33656002)(66556008)(83380400001)(66476007)(1076003)(5660300002)(6916009)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Qrgo1vnJxmhfa9WfmbOf1Xpoz0B3X2s3uCzBSN2UnUrWRrUFaq/W//c6M7k/tYCwt/cyETUQ2Z/Zi2tSqMBet1Q3Ce0nbLYWKR+hxMcu1znPsAadesWiq7Ys6y/2zMrlpPyqhAMpSnFrRuzlpyZSdzwvCVKVKGJOzvfjL6ytqZwaSl4RV5yJNHxo1c8YxKA6BUSLJ6gR3RPQE3elasvP2dTDye7rbJN/SWAaDangK9bGxoX0wjlwyGmeszZNaDLCgO/9tCrtucV/0T68TqrLxVawuvyMgJ4i0/Ny3/J6lKJ+CDZz4jjMgGADIM/TlOVrQiPMeR36+vo2TqI4jeCtS+zCk+vNwdOjKPDg68Ao5sIdKU4qWDXPxeDGR7SCkqAmF8r4M3Sn+dvf6QplpXiq1MQoRAMzh4TzAuUy7se+TvN4k1tOHSkk84IdBpqCRYi6e3kg1RHTuWjnbgA49nfJ1xJXjmkvBrp0Q7UzeiIUMMxfOzl7AOG13oVEOD5wviiWXzL+XrWNYgP+DH1v1c2qeVlM3qE/tyk81G/20IqD/BkzB3aq13w6dklUYRuyBti483IjHrClYiXpPsJ3srAnFnkJtu9lJogy+MC+nqrHLsxlYAhVBWbMMwygXAoKiGemxy85Dz2UgO6D4p4JEBveogcuvc2wjEhtT7vkYslmB6k=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d03beba-d0fe-4462-2397-08d854e12581
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 16:55:24.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VL2/JJnZ8n6iaRpuvtjJ64trO5BBBqhUPN6K4CJu5l1lOVqqkr4dxbrLj0W9x8k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2439
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_12:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 clxscore=1015
 mlxlogscore=554 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090151
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 10:55:34AM -0400, Johannes Weiner wrote:
> On Thu, Sep 03, 2020 at 04:00:55PM -0700, Roman Gushchin wrote:
> > In the memcg case count_shadow_nodes() sums the number of pages in lru
> > lists and the amount of slab memory (reclaimable and non-reclaimable)
> > as a baseline for the allowed number of shadow entries.
> > 
> > It seems to be a good analogy for the !memcg case, where
> > node_present_pages() is used. However, it's not quite true, as there
> > two problems:
> > 
> > 1) Due to slab reparenting introduced by commit fb2f2b0adb98 ("mm:
> > memcg/slab: reparent memcg kmem_caches on cgroup removal") local
> > per-lruvec slab counters might be inaccurate on non-leaf levels.
> > It's the only place where local slab counters are used.
> 
> Hm, that sounds like a bug tbh. We're reparenting the kmem caches and
> the individual objects on the list_lru when a cgroup is removed -
> shouldn't we also reparent the corresponding memory counters?

It's definitely an option too, the question is if the added code complexity
is really worth it. I'd say no had we talk only about slab counters,
but when we'll eventually start reparenting pagecache, we'll need to reparent
other counters as well, so we'll need it anyway. So, ok, let's drop
this patch for now.

> 
> > 2) Shadow nodes by themselves are backed by slabs. So there is a loop
> > dependency: the more shadow entries are there, the less pressure the
> > kernel applies to reclaim them.
> 
> This effect is negligible in practice.
> 
> The permitted shadow nodes are a tiny percentage of memory consumed by
> the cgroup. If shadow nodes make up a significant part of the cgroup's
> footprint, or are the only thing left, they will be pushed out fast.
> 
> The formula is max_nodes = total_pages >> 3, and one page can hold 28
> nodes. So if the cgroup holds nothing but 262,144 pages (1G) of shadow
> nodes, the shrinker target is 32,768 nodes, which is 32,768 pages
> (128M) in the worst packing case and 1,170 pages (4M) at best.
> 
> However, if you don't take slab into account here, it can evict shadow
> entries with undue aggression when they are needed the most. If, say,
> the inode or dentry cache explode temporarily and displace the page
> cache, it would be a big problem to drop the cache's non-resident info
> at the same time! This is when it's at its most important.

Just curious, have you seen this in the real life?
