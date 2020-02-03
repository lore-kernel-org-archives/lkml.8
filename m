Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4769CC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187D22086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hsTYo4/p";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BZzCQgRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgBCSfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:35:10 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4338 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727257AbgBCSfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:35:10 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 013INhtl008216;
        Mon, 3 Feb 2020 10:35:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=jEjKrAZrtlL68j/Icqc6iUbaSUPfLEmYJfKhf2e8yQs=;
 b=hsTYo4/pp2Vvdz5V/hPyxRH3cguuYjN4g0Q0MSjSTigwbNdadKS4b2J8GWkpK/fHsj9O
 c4Xzdl+D3Bjq50564gR0D3DA/WOhi+U7xyZPyBf1lwf6+yXlvKGmLa/zpF9lJhxvB+tE
 VIG2Abi/Ap6GnCGut7CIBC7RqOqQ5OTl8yA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2xw5vsrqtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 03 Feb 2020 10:35:02 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 3 Feb 2020 10:35:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HO4BbSFuLiMpQgPu6q45m0UlIrsFIKDVmKr9GExWqd5xRWl3u/9aql0nVtTofU1TZd4Y/PjpG5B4LCRzsqKCetAaP+8B3tqiU7iaKf3xUfmQd7z8qMaX1ptxJi/rn0lg4sd5JmW+HC2alFuLz6D1tajmMt2FL4yScr459xlKqNCxJNU8gJjY9w6MTVwi/c31ehyoihboaezADHobaERBJc/SVKG5WYbxPXnK5OT3uJjDsFi42sz58xB/CLjye6yamCRR2Tgj6YRu2YPoZeWUOpCnS71/9XLY1TzLQAayh3h4Mtv60gmdpk9U/TLroWoxx07xVHuBmRjmJQAZApL3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEjKrAZrtlL68j/Icqc6iUbaSUPfLEmYJfKhf2e8yQs=;
 b=IBH7z5WpcDC9C6NsTD3piF8YepyW5t8g3OPcJcEpOWuMmXjovUvnhtgr/nhu3YsIQlxYR4UUDaWUK0pisYoRrCWV8ra5WfRuutY+FnGqop5lVUgfM7Dvc/Zgwk7yyBwSoOYvWz2d/myc22gOGL25xTnKBFoKyOWAQzBkU1RFdtPhiiTtLp6wQNP4+3P4ZR6det4AGFBjSg6Z54R8AogZYF1gqpRNHtxvBkjek7yvgbPY1xCx/SFBdR+8Ft2fPS7tFXcFugRSEYa598V9epW2FzdMboQyvSc4lkMjothvF9UhamGYv6AoykXWB7nMWuI9AYbSWoHcOQL+HjgblQubrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEjKrAZrtlL68j/Icqc6iUbaSUPfLEmYJfKhf2e8yQs=;
 b=BZzCQgRor/o/RlD57M8b2DlUYBobD5RNG04xGtwpJ6zZlSDoJER7JF0iir2Hhe6e1zkzk3lrfxI71eKIQPAMcYHybZVH1iRjG91EHS9J1j7HYi1a7jndd+oZPWzPTwqHGW5dQYSscMZzBTKaa+qXu15VS4tazMru4fm3jGmgtHQ=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2918.namprd15.prod.outlook.com (20.178.239.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Mon, 3 Feb 2020 18:35:00 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 18:35:00 +0000
Date:   Mon, 3 Feb 2020 10:34:52 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 16/28] mm: memcg/slab: allocate obj_cgroups for
 non-root slab pages
Message-ID: <20200203183452.GB3700@xps.dhcp.thefacebook.com>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-17-guro@fb.com>
 <20200203182756.GG1697@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203182756.GG1697@cmpxchg.org>
X-ClientProxiedBy: MN2PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:208:236::15) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
Received: from xps.dhcp.thefacebook.com (2620:10d:c091:480::3075) by MN2PR05CA0046.namprd05.prod.outlook.com (2603:10b6:208:236::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.15 via Frontend Transport; Mon, 3 Feb 2020 18:34:58 +0000
X-Originating-IP: [2620:10d:c091:480::3075]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d00b02fa-c381-4ce8-a632-08d7a8d7c6d4
X-MS-TrafficTypeDiagnostic: BYAPR15MB2918:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2918FBBBE97EF083E81E098BBE000@BYAPR15MB2918.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(6916009)(1076003)(4326008)(55016002)(9686003)(86362001)(6506007)(52116002)(7696005)(316002)(16526019)(186003)(8936002)(33656002)(54906003)(81166006)(81156014)(5660300002)(478600001)(8676002)(6666004)(66946007)(2906002)(66556008)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2918;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1GpwrjS4NKqNEPGNQUSLxIFtLKK/NFQqwppC+b0RJn1az7N2lkVisiRyI+ZECfD4HIShbT0nLI7QmaJX9vijj4otQ2jJ0d/4puOLEFy4zH+ksZ6qBLxf2YU/gLY9Ipz6l8uFOunrE4rVXWk4zGJGY+sYqjJPij9YT3qxeBcvxr7k2ue+39JC+rl9Aq2HPh9VBScqNrGkvSXrryoFgH7jKS1mgFjV1FWzr59rNgOfdHtUIoZ2IJ6bn7H95D3KlNvEqtfeZ3AdvHouyT0xHddk3T1WhorqsU4uvZi08N25y1OJk/KrdiOiIqpqqSYiZuAHA+czfBFye2lzN54ywbDGqdPrUXvVms7I+J6aAbrNJ7zWz4lB9IPJVb/Vm9qxeqyW9THUJF33CW0OLlgwN/Hk9ebAYOdq2bwUR+5O6Rq9sTRkyXgM99vognxYl/mwYxRT
X-MS-Exchange-AntiSpam-MessageData: jU3UTmaJ1rZmEv3Ufol1pGs33vsiyMLnxv6P/okywgzdAseEoMsU/r1Ka93ibBZT9AptF1NRYg42EfNjKHi9xeFt7jElw/WKDZilRJ0OnB63dMYHM9nyd92y6Rfc4YUY7mwciPLSfs2OyYRma04bMuQi84iERU4uZa/l88Gtgjw=
X-MS-Exchange-CrossTenant-Network-Message-Id: d00b02fa-c381-4ce8-a632-08d7a8d7c6d4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 18:35:00.4343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOjGLd45+rKALOOKJEOzWWba1G+mvUK61q6s4787gge5FcJC7mP6opiYn1fwNG0N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2918
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_06:2020-02-02,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 suspectscore=1 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1911200001 definitions=main-2002030134
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 01:27:56PM -0500, Johannes Weiner wrote:
> On Mon, Jan 27, 2020 at 09:34:41AM -0800, Roman Gushchin wrote:
> > Allocate and release memory to store obj_cgroup pointers for each
> > non-root slab page. Reuse page->mem_cgroup pointer to store a pointer
> > to the allocated space.
> > 
> > To distinguish between obj_cgroups and memcg pointers in case
> > when it's not obvious which one is used (as in page_cgroup_ino()),
> > let's always set the lowest bit in the obj_cgroup case.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  include/linux/mm.h       | 25 ++++++++++++++++++--
> >  include/linux/mm_types.h |  5 +++-
> >  mm/memcontrol.c          |  5 ++--
> >  mm/slab.c                |  3 ++-
> >  mm/slab.h                | 51 +++++++++++++++++++++++++++++++++++++++-
> >  mm/slub.c                |  2 +-
> >  6 files changed, 83 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 080f8ac8bfb7..65224becc4ca 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1264,12 +1264,33 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
> >  #ifdef CONFIG_MEMCG
> >  static inline struct mem_cgroup *page_memcg(struct page *page)
> >  {
> > -	return page->mem_cgroup;
> > +	struct mem_cgroup *memcg = page->mem_cgroup;
> > +
> > +	/*
> > +	 * The lowest bit set means that memcg isn't a valid memcg pointer,
> > +	 * but a obj_cgroups pointer. In this case the page is shared and
> > +	 * isn't charged to any specific memory cgroup. Return NULL.
> > +	 */
> > +	if ((unsigned long) memcg & 0x1UL)
> > +		memcg = NULL;
> > +
> > +	return memcg;
> 
> That should really WARN instead of silently returning NULL. Which
> callsite optimistically asks a page's cgroup when it has no idea
> whether that page is actually a userpage or not?

For instance, look at page_cgroup_ino() called from the
reading /proc/kpageflags.

> 
> >  static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
> >  {
> > +	struct mem_cgroup *memcg = READ_ONCE(page->mem_cgroup);
> > +
> >  	WARN_ON_ONCE(!rcu_read_lock_held());
> > -	return READ_ONCE(page->mem_cgroup);
> > +
> > +	/*
> > +	 * The lowest bit set means that memcg isn't a valid memcg pointer,
> > +	 * but a obj_cgroups pointer. In this case the page is shared and
> > +	 * isn't charged to any specific memory cgroup. Return NULL.
> > +	 */
> > +	if ((unsigned long) memcg & 0x1UL)
> > +		memcg = NULL;
> > +
> > +	return memcg;
> 
> Same here.
> 
> >  }
> >  #else
> >  static inline struct mem_cgroup *page_memcg(struct page *page)
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 270aa8fd2800..5102f00f3336 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -198,7 +198,10 @@ struct page {
> >  	atomic_t _refcount;
> >  
> >  #ifdef CONFIG_MEMCG
> > -	struct mem_cgroup *mem_cgroup;
> > +	union {
> > +		struct mem_cgroup *mem_cgroup;
> > +		struct obj_cgroup **obj_cgroups;
> > +	};
> 
> Since you need the casts in both cases anyway, it's safer (and
> simpler) to do
> 
> 	unsigned long mem_cgroup;
> 
> to prevent accidental direct derefs in future code.

Agree. Maybe even mem_cgroup_data?

> 
> Otherwise, this patch looks good to me!

Thanks!
