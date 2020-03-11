Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DD3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080AA2074F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="V04T8xuU";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XnU7Kghz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387550AbgCKW7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:59:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5926 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387481AbgCKW7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:59:03 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BMsljR020796;
        Wed, 11 Mar 2020 15:58:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ZH9dCZnD+LY7SV6c4Nic5MxJHjDyvd9xLfa+UMLWMRM=;
 b=V04T8xuU1HfkC4nE4tJ5VsdvcAYPzOzAfu65HZeGC62VR9Y+xRwxG/rPF+QIElcK9Ono
 WKPo2hxuEGlW/fi+mjnwiHasMSKXBuMXWJAGvGsYjtEz0YUPTNX2CLZpi0cXepNsTfF5
 IPlt+Hhtb+22EN4Mmev2nKXBeoAl7UezEOI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ypr7svrae-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Mar 2020 15:58:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 11 Mar 2020 15:58:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZ6BIxPhsk+1/e195D/je79Uge2W7jtPocLDavmCsmhqESCAOLFu77r2QQkRKhX0ylmtiEYeRARLVd2HOmUpFd1d3vfMGprgi79qpI8n2NbSpmL+cEVDU2+Pk11dY3B3ZnwOGrWsC6XOS1C9F6oZih1OzgOr+RyyW8T6YpUaT5Y+m8O7J9TlALnmuesDyAf45g9KTEFlTktd6sOpe3NbZF6DhiI5dlvN8AQ4ZDuluJRlKKTJtdvdLMwitJgcWrNwbjZk/svPEu8vReQB7WQGXuBFWkv1KYg8C4cFTlZ1VW83e3gnbplb94jTvxF5x/176/lACB3s2fVwCuxwunxYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH9dCZnD+LY7SV6c4Nic5MxJHjDyvd9xLfa+UMLWMRM=;
 b=D587MYfgV/Zqp2tKVn0ka1vOPPM4Iy9NKerGdkxn1D1QLDwcstmReFDQXBojyPxr9CsMTOWs+HjLeuKrttMGqViOiF00oFVI1nW+YcDYGRdKZdw1jmZIsEonii6L0sHtmpkyXG8+TxCs7C3Hte8l61Bca3iO6/VpWolT+szfl/yT4Fw7YbNI09n3dhXDUF5QCXzlo6dcTSHdufbGCFGuXI9APalOsklleSt+bYTj3yqUfEljd5L7mOx71vWWDg1fedO4iskIIWcDaoCkAJSrHVXD2JY3k0U9ZGzd3f/qc+cSGsrsoEhVLq9SyIiLqzcxxvJUlLxFSeZICSZvqJ5L1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH9dCZnD+LY7SV6c4Nic5MxJHjDyvd9xLfa+UMLWMRM=;
 b=XnU7KghzU/OZU7kzr5U4r9K+rsuIiLYKFTZ2N0xaKnxMZkUvnd3IXa+Dj7CXEuhC6erD1LuJUTsQGMZbEFm4HANdHruSwvKZ78ZYfFYmyZ3PJwxQYETYGgAJWLEfoe1Om07jKsDDZK9kplLkyfaN2uLE8HIpCmJjSYSWVrODZjw=
Received: from DM5PR15MB1659.namprd15.prod.outlook.com (2603:10b6:3:124::22)
 by DM5PR15MB1692.namprd15.prod.outlook.com (2603:10b6:3:11b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Wed, 11 Mar
 2020 22:58:43 +0000
Received: from DM5PR15MB1659.namprd15.prod.outlook.com
 ([fe80::c4cb:24b7:22b8:811d]) by DM5PR15MB1659.namprd15.prod.outlook.com
 ([fe80::c4cb:24b7:22b8:811d%12]) with mapi id 15.20.2793.013; Wed, 11 Mar
 2020 22:58:43 +0000
Date:   Wed, 11 Mar 2020 15:58:32 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@techsingularity.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] mm,page_alloc,cma: conditionally prefer cma pageblocks
 for movable allocations
Message-ID: <20200311225832.GA178154@carbon.DHCP.thefacebook.com>
References: <20200306150102.3e77354b@imladris.surriel.com>
 <20200307143849.a2fcb81a9626dad3ee46471f@linux-foundation.org>
 <2f3e2cde7b94dfdb8e1f0532d1074e07ef675bc4.camel@surriel.com>
 <5ed7f24b-d21b-75a1-ff74-49a9e21a7b39@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed7f24b-d21b-75a1-ff74-49a9e21a7b39@suse.cz>
X-ClientProxiedBy: MWHPR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:300:4b::14) To DM5PR15MB1659.namprd15.prod.outlook.com
 (2603:10b6:3:124::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:f36d) by MWHPR02CA0004.namprd02.prod.outlook.com (2603:10b6:300:4b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend Transport; Wed, 11 Mar 2020 22:58:42 +0000
X-Originating-IP: [2620:10d:c090:400::5:f36d]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b49f3d91-e494-4eb8-dc87-08d7c60fbf3e
X-MS-TrafficTypeDiagnostic: DM5PR15MB1692:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR15MB16923EBA20A619B9A268C38FBEFC0@DM5PR15MB1692.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(4326008)(33656002)(81166006)(6506007)(316002)(54906003)(53546011)(8676002)(1076003)(2906002)(478600001)(52116002)(8936002)(81156014)(5660300002)(7696005)(86362001)(16526019)(9686003)(55016002)(66556008)(6916009)(6666004)(66946007)(186003)(66476007)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1692;H:DM5PR15MB1659.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y4j/ARAIX0pVeMYo8X2HVhXOKnJMWaluOSQgtVM91+pV+rCkDmD3xD6bherbumZLJV0m9UPV2RtlWcuCsl2wDt54qG3y0BLmw6OGCLrm+GqsvljQ8xP1dx/RZpNT8xubf9gl8D+6gtHYnQiM8ePKkbLYguDckPyIKAtSGG4GdHiqbvstayFjgrXjkxo7iMJ5MX6lfP5wOZNEylFP+Emiiv83E1i8jHSVwaTTnIgRkv2aJE/GRX3jnKelSMFt0xB2PeWPB0hStARoaML0eDkww6vT44s9xu+I6cMZH9yVvR2w2//fkXJR7hv1iyKVl5TKdxERsv2VlOTh+JHKZgQhUl8mRwj9nXSG48aQFb8G9zO1GHO+eI6A6jDhMAv6B/wGgbp6Qii+BwjWwF82ZkZX6dd+RI4z6EXmQcyeHPZWsgM3zjPeOEs9l6oKNDFU3nd64qrzcvjKSzACz779Y1iISNzilKqin8LOtmU0CElTwtAKlkRySSeqjKCAXPTTeqgQ
X-MS-Exchange-AntiSpam-MessageData: n72OASJEnCgyZlFfTvF+2+dQqwQ5hfzDB2G1XaZ98Jt/80AltEugiVAcWfBvRSwAUltjRXFXpI5Xah/i8uVqh8WEIzY26N+mhaujWFhzYp/B44IvTyg/M3WM6pOEqL3/38KAgXu21ib8yMfwK+BJdsvs8HQ0Rir41Yi3aMpyW+VLihp9nPGItz6mFsJ2i4BW
X-MS-Exchange-CrossTenant-Network-Message-Id: b49f3d91-e494-4eb8-dc87-08d7c60fbf3e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 22:58:43.5509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ySwPqk/gBNd+TmTlUyQv8+zXuom4K9CQhPnoJNMZYdRvTRnuLrHXjne55FPhii6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1692
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_11:2020-03-11,2020-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=5 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110129
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 06:58:00PM +0100, Vlastimil Babka wrote:
> On 3/8/20 2:23 PM, Rik van Riel wrote:
> > On Sat, 2020-03-07 at 14:38 -0800, Andrew Morton wrote:
> >> On Fri, 6 Mar 2020 15:01:02 -0500 Rik van Riel <riel@surriel.com>
> >> wrote:
> > 
> >> > --- a/mm/page_alloc.c
> >> > +++ b/mm/page_alloc.c
> >> > @@ -2711,6 +2711,18 @@ __rmqueue(struct zone *zone, unsigned int
> >> > order, int migratetype,
> >> >  {
> >> >  	struct page *page;
> >> >  
> >> > +	/*
> >> > +	 * Balance movable allocations between regular and CMA areas by
> >> > +	 * allocating from CMA when over half of the zone's free memory
> >> > +	 * is in the CMA area.
> >> > +	 */
> >> > +	if (migratetype == MIGRATE_MOVABLE &&
> >> > +	    zone_page_state(zone, NR_FREE_CMA_PAGES) >
> >> > +	    zone_page_state(zone, NR_FREE_PAGES) / 2) {
> >> > +		page = __rmqueue_cma_fallback(zone, order);
> >> > +		if (page)
> >> > +			return page;
> >> > +	}
> >> >  retry:
> >> >  	page = __rmqueue_smallest(zone, order, migratetype);
> >> >  	if (unlikely(!page)) {
> >> 
> >> __rmqueue() is a hot path (as much as any per-page operation can be a
> >> hot path).  What is the impact here?
> > 
> > That is a good question. For MIGRATE_MOVABLE allocations,
> > most allocations seem to be order 0, which go through the
> > per cpu pages array, and rmqueue_pcplist, or be order 9.
> > 
> > For order 9 allocations, other things seem likely to dominate
> > the allocation anyway, while for order 0 allocations the
> > pcp list should take away the sting?
> 
> I agree it should be in the noise. But please do put it behind CONFIG_CMA
> #ifdef. My x86_64 desktop distro kernel doesn't have CONFIG_CMA. Even if this is
> effectively no-op with __rmqueue_cma_fallback() returning NULL immediately, I
> think the compiler cannot eliminate the two zone_page_state()'s which are
> atomic_long_read(), even if it's just ultimately READ_ONCE() here, that's a
> volatile cast which means elimination not possible AFAIK? Other architectures
> might be even more involved.

I agree.

Andrew,
can you, please, squash the following diff into the patch?

Thank you!

--

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7d9067b75dcb..bc65931b3901 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2767,6 +2767,7 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 {
        struct page *page;
 
+#ifdef CONFIG_CMA
        /*
         * Balance movable allocations between regular and CMA areas by
         * allocating from CMA when over half of the zone's free memory
@@ -2779,6 +2780,7 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
                if (page)
                        return page;
        }
+#endif
 retry:
        page = __rmqueue_smallest(zone, order, migratetype);
        if (unlikely(!page)) {

