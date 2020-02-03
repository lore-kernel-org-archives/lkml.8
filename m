Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267D3C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFB520838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Y9Om/v/I";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="SASyOHAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgBCVTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:19:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22298 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726331AbgBCVTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 16:19:35 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013LEulW021997;
        Mon, 3 Feb 2020 13:19:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ij3FvUX+CAfVcMdkiVNzUugSMtZnOBDUmHdRQ3srovI=;
 b=Y9Om/v/IIoqqXXAmuOIqlJu2GMAYpPKGKGrk6DvTNBgbf5DNPCHoKEjgYdlxwdVLFhu9
 WyukcLL5p46p4Ju51TQwsszXtUTidIbTHxpLw5hfhgEE07JqazjFrLnHuuvr3VlJqk9m
 Mlu32ha1b48edPp5sNRlpzrlwZ4+FV6JCn8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xxt4f8bbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 03 Feb 2020 13:19:25 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 3 Feb 2020 13:19:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoLIyOWcl8gIAalzz4VbMOcSu9p4n8cEff4wzf5bYq5LrsZhgLHmI82NDe4Us1QEmyQYLowTq8RMZI98ydsuwPO2yxOUB72vx/DAFvIu7dPvwH/5iDmbR3Tgz9VMxp2W3UfymxwV2dsdlMRM3iNlJqmdPZeVS5Gm4S+cdZ1gOMO5FDtZQuG60iu/43JNbMYKSLVJGSjOsCeKHEcFKVCH4Egpm61Y1q3wa+sHijl8KUdgPLaDEM7pwMqODnYUy5B1QDYDGyEuerFNe3S9zmdzrq57m0lp5LTGaUaz+5ItUg8c4fFePnkgTolqotnkuJV58/lgai4xC6bpTPbqyxEUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ij3FvUX+CAfVcMdkiVNzUugSMtZnOBDUmHdRQ3srovI=;
 b=khrbRG5Nxf/0XmAkD8VYJuSPavSGyrz0Ok2GgtgxRigMsOhRWMLbvsPdsHOe+8cK8PHZrkWEzZLP4qkmy4lrM44GQ8S2J1sdh/zzjAx6gyGGWhPelH9fX6Zq3DFAZ6QtJ2+6EpqetR2RxKMvaa1qf9ftFYC2N4r5suADzaL8fIPUMxP0H6q3in6cUKPEXpv5GrXodFpUjh6oalkt9VtYEtmSsWTpSduvC0b/xALpic6VSNRyJf9TzAQL7FmYH+epEGhPVXXY5NBqXf3aG6l3S8SNfsbACHvTo3BrdaMb4HkYa6/4U+XUp/4xusjlIKV/iiyo+zWG8LlcKVd40La5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ij3FvUX+CAfVcMdkiVNzUugSMtZnOBDUmHdRQ3srovI=;
 b=SASyOHAlSlmfg5z4zpY+/KBgo9mpO9HsPeluHRzbQ3TlVZUi3KWxAwjNrc3qvKauPgnghxNletQujP5+YZ5apE7xCVeB2VYzPo5GrkC3Ge8ZwF5SWJxHQdcaVOCK8ST6kvK0+AIkpgBvV+2doPvcaQo9L3LDEQ5WXPsM6JDAdAI=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2854.namprd15.prod.outlook.com (20.178.206.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Mon, 3 Feb 2020 21:19:23 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 21:19:22 +0000
Date:   Mon, 3 Feb 2020 13:19:15 -0800
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
Message-ID: <20200203211915.GB6781@xps.dhcp.thefacebook.com>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-17-guro@fb.com>
 <20200203182756.GG1697@cmpxchg.org>
 <20200203183452.GB3700@xps.dhcp.thefacebook.com>
 <20200203204627.GB6380@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203204627.GB6380@cmpxchg.org>
X-ClientProxiedBy: MN2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::32) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
Received: from xps.dhcp.thefacebook.com (2620:10d:c091:480::55b0) by MN2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:208:1a0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29 via Frontend Transport; Mon, 3 Feb 2020 21:19:20 +0000
X-Originating-IP: [2620:10d:c091:480::55b0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 910d3db2-cdb4-4e78-6913-08d7a8eebd3e
X-MS-TrafficTypeDiagnostic: BYAPR15MB2854:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB28545E2519D5F45AB34B4BE7BE000@BYAPR15MB2854.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(136003)(39860400002)(199004)(189003)(6916009)(6506007)(7696005)(1076003)(52116002)(4326008)(478600001)(55016002)(9686003)(8936002)(81166006)(81156014)(86362001)(66946007)(2906002)(5660300002)(54906003)(16526019)(316002)(66476007)(186003)(33656002)(8676002)(66556008)(6666004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2854;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7mhTfvG58TIQSSpjv7iHsdJCWh8AnWpz29bcF2GRY+cresPGyXfJ31Gamha6cZIapx4tMoj+UNw5rnxQShN2a2jzd0gjXUUc8oGWq4f/FtbSgwuAaA0+Jg7ww8B/sQHh/O9gcjLCSTdjJbSRazhQVdVJdzD05V22sImcQONq6jlA+YeB4LkCSaRXqD0VaeL53qO8soY7upKCRuVfuvx831guuWN39bpC1KYR46ok5qa3uX+ddQiFWsPh44mVaK6dzcMQX6HTMo8NNyxu51NjU5i6fjbyvW7Hy3NbKKD5G/x0wBH1Y4yBUfng1w1OlMckiqJrmu7PeAZ1iVtjju3I/i+APTzZVdoetVJ/Lt8Zr/fnNO2TXGdk5sEFXJzngFY7Aim4m5ByeqdhzxP/mEJiMUTvTyP0aPv7vVT2p9FbK77K6TqnZkm40cUzCPlwH6js
X-MS-Exchange-AntiSpam-MessageData: X+qm4F1VbbmqaL3NVxXWhO3v/aTVNon2Wl9EEAKj7UMQp6gbggCgFeR7zV04aT9xe1wv7EyYQr0tHHgoH17b8eLp24f/xASTmavrpHPZyzRCp/YlRzFxgJpU0wNMEyYEJro4brAmFUc1pfKtFPbcZWnvBP1O7ZW5pswZ5FBDQ8o=
X-MS-Exchange-CrossTenant-Network-Message-Id: 910d3db2-cdb4-4e78-6913-08d7a8eebd3e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 21:19:22.8540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nb1VA0Il+XZyuVJzhRkFw9/+SgE70uFqPjbuqr8x7lOiWgWvB5Tse05wLjazlErF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2854
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_07:2020-02-02,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=997
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 mlxscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002030154
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 03:46:27PM -0500, Johannes Weiner wrote:
> On Mon, Feb 03, 2020 at 10:34:52AM -0800, Roman Gushchin wrote:
> > On Mon, Feb 03, 2020 at 01:27:56PM -0500, Johannes Weiner wrote:
> > > On Mon, Jan 27, 2020 at 09:34:41AM -0800, Roman Gushchin wrote:
> > > > Allocate and release memory to store obj_cgroup pointers for each
> > > > non-root slab page. Reuse page->mem_cgroup pointer to store a pointer
> > > > to the allocated space.
> > > > 
> > > > To distinguish between obj_cgroups and memcg pointers in case
> > > > when it's not obvious which one is used (as in page_cgroup_ino()),
> > > > let's always set the lowest bit in the obj_cgroup case.
> > > > 
> > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > ---
> > > >  include/linux/mm.h       | 25 ++++++++++++++++++--
> > > >  include/linux/mm_types.h |  5 +++-
> > > >  mm/memcontrol.c          |  5 ++--
> > > >  mm/slab.c                |  3 ++-
> > > >  mm/slab.h                | 51 +++++++++++++++++++++++++++++++++++++++-
> > > >  mm/slub.c                |  2 +-
> > > >  6 files changed, 83 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > index 080f8ac8bfb7..65224becc4ca 100644
> > > > --- a/include/linux/mm.h
> > > > +++ b/include/linux/mm.h
> > > > @@ -1264,12 +1264,33 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
> > > >  #ifdef CONFIG_MEMCG
> > > >  static inline struct mem_cgroup *page_memcg(struct page *page)
> > > >  {
> > > > -	return page->mem_cgroup;
> > > > +	struct mem_cgroup *memcg = page->mem_cgroup;
> > > > +
> > > > +	/*
> > > > +	 * The lowest bit set means that memcg isn't a valid memcg pointer,
> > > > +	 * but a obj_cgroups pointer. In this case the page is shared and
> > > > +	 * isn't charged to any specific memory cgroup. Return NULL.
> > > > +	 */
> > > > +	if ((unsigned long) memcg & 0x1UL)
> > > > +		memcg = NULL;
> > > > +
> > > > +	return memcg;
> > > 
> > > That should really WARN instead of silently returning NULL. Which
> > > callsite optimistically asks a page's cgroup when it has no idea
> > > whether that page is actually a userpage or not?
> > 
> > For instance, look at page_cgroup_ino() called from the
> > reading /proc/kpageflags.
> 
> But that checks PageSlab() and implements memcg_from_slab_page() to
> handle that case properly. And that's what we expect all callsites to
> do: make sure that the question asked actually makes sense, instead of
> having the interface paper over bogus requests.
> 
> If that function is completely racy and PageSlab isn't stable, then it
> should really just open-code the lookup, rather than require weakening
> the interface for everybody else.

Why though?

Another example: process stack can be depending on the machine config and
platform a vmalloc allocation, a slab allocation or a "high-order slab allocation",
which is executed by the page allocator directly.

It's kinda nice to have a function that hides accounting details
and returns a valid memcg pointer for any kind of objects.

To me it seems to be a valid question:
for a given kernel object give me a pointer to the memory cgroup.

Why it's weakening?

Moreover, open-coding of this question leads to bugs like one fixed by
ec9f02384f60 ("mm: workingset: fix vmstat counters for shadow nodes").

> 
> > > >  static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
> > > >  {
> > > > +	struct mem_cgroup *memcg = READ_ONCE(page->mem_cgroup);
> > > > +
> > > >  	WARN_ON_ONCE(!rcu_read_lock_held());
> > > > -	return READ_ONCE(page->mem_cgroup);
> > > > +
> > > > +	/*
> > > > +	 * The lowest bit set means that memcg isn't a valid memcg pointer,
> > > > +	 * but a obj_cgroups pointer. In this case the page is shared and
> > > > +	 * isn't charged to any specific memory cgroup. Return NULL.
> > > > +	 */
> > > > +	if ((unsigned long) memcg & 0x1UL)
> > > > +		memcg = NULL;
> > > > +
> > > > +	return memcg;
> > > 
> > > Same here.
> > > 
> > > >  }
> > > >  #else
> > > >  static inline struct mem_cgroup *page_memcg(struct page *page)
> > > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > > index 270aa8fd2800..5102f00f3336 100644
> > > > --- a/include/linux/mm_types.h
> > > > +++ b/include/linux/mm_types.h
> > > > @@ -198,7 +198,10 @@ struct page {
> > > >  	atomic_t _refcount;
> > > >  
> > > >  #ifdef CONFIG_MEMCG
> > > > -	struct mem_cgroup *mem_cgroup;
> > > > +	union {
> > > > +		struct mem_cgroup *mem_cgroup;
> > > > +		struct obj_cgroup **obj_cgroups;
> > > > +	};
> > > 
> > > Since you need the casts in both cases anyway, it's safer (and
> > > simpler) to do
> > > 
> > > 	unsigned long mem_cgroup;
> > > 
> > > to prevent accidental direct derefs in future code.
> > 
> > Agree. Maybe even mem_cgroup_data?
> 
> Personally, I don't think the suffix adds much. The type makes it so
> the compiler catches any accidental use, and access is very
> centralized so greppability doesn't matter much.
