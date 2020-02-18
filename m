Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C487C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0E9206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XAnghUAE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QaGLgDBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgBRUxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:53:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22470 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726384AbgBRUxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:53:37 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IKnivZ003632;
        Tue, 18 Feb 2020 12:53:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=ktI5qN853tuvj28oDz14ao7IsEFpf1M/e2VybvC0t5s=;
 b=XAnghUAEYq8qm2gaI8wIdC5vMxexuHBEIamnSp4zL4c4SLQLaPnZU2Ng518jXGWsJz1D
 qJ1ULu45V2lVjN8r18THRDBRSgf+v7pVLxmm3+Pv9g/rTLnf3o/t+6hR6xLPhNQcR/93
 WzCzF4Vwc0mzFxSUe5sRjuN1JtORkkx+IvE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2y6f8vwprm-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 18 Feb 2020 12:53:20 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 18 Feb 2020 12:53:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGwNjVfNSjm9jbviKDjEpUuNzNPS2y+YsdQII77nRIoPgwG2bSjwoDRZdbXuNVWJgxMCs2StQQQVNJY5t25zyn2I0t74e7GT+dqW3+WO3t2jaAjplFc+K+KH3xY9e02F5ECyEViMU9Ce3cmk5l2Kn+T3CVC1vwOSosfCl5nUG2LmILqQAMRx1Hi8u+fwH99/c1NkeXeeOlODYzZbd5R2hwanM/3vddH1wK6664XTx+z2I4+X3WAQAB0vBBPOY5AIHX5a8AwqtJoZdsAdfl5+YByGvBfDfsW1nVF5ox0t7uFIRMnJVL8WFBoey8yfgcH+ySle3ajBp++qjMAcutt7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktI5qN853tuvj28oDz14ao7IsEFpf1M/e2VybvC0t5s=;
 b=Pyc20xEfLRjWl7Pzyj5GjHqRoDQ0ot/jFYznCg+M8ZOd27axDM9QUoI5VUZljrMLY2a02D/XvLJ6ueNCzgn3SGDWfX0LUem4ICga+PXvEZl10GFpWxDzgMCJfOvy362rDJ/fy6ZVHsTOcUfJNLhljR0vu4ggjNXiRFSEEb9Rd3jpcT3/A29B01qlcXRcRq5Xoqc0X2aGhNPNxM+hzlGIc/8Vx4j6FBfh7hoqiPGwWNnlqpEXBquyU2xhhN0f96slJG1B/GHTdlOoc2baakVfbzL1URx/DsBpgW6WAmvhA5XXPM1gnsX+tr1jQcCnZUh0pKB0NC/KaK9z2XtU4rbDnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktI5qN853tuvj28oDz14ao7IsEFpf1M/e2VybvC0t5s=;
 b=QaGLgDBy6gQL2s9TLBueyxuJaS2OphwGXrzGm+OWLT9ZgKLZt6OzjFcQTrg9gQCCG8Clh/aWJhtXxmJcmlb21ePNV0z04HaVgCTwTukvrkbjrBJY6Y/2NwLElS0Gl6kbU+HgiBobkBB9f1hpEcYR0VWlDxCEqtUnEk5P2N+caIU=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB3189.namprd15.prod.outlook.com (20.179.56.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Tue, 18 Feb 2020 20:53:17 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 20:53:17 +0000
Date:   Tue, 18 Feb 2020 12:53:12 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Wen Yang <wenyang@linux.alibaba.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/slub: Detach node lock from counting free objects
Message-ID: <20200218205312.GA3156@carbon>
References: <20200201031502.92218-1-wenyang@linux.alibaba.com>
 <20200212145247.bf89431272038de53dd9d975@linux-foundation.org>
 <b42f7daa-4aea-1cf8-5bbb-2cd5d48b4e9a@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b42f7daa-4aea-1cf8-5bbb-2cd5d48b4e9a@linux.alibaba.com>
X-ClientProxiedBy: CO2PR07CA0053.namprd07.prod.outlook.com (2603:10b6:100::21)
 To BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
MIME-Version: 1.0
Received: from carbon (2620:10d:c090:500::4:238) by CO2PR07CA0053.namprd07.prod.outlook.com (2603:10b6:100::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend Transport; Tue, 18 Feb 2020 20:53:16 +0000
X-Originating-IP: [2620:10d:c090:500::4:238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94ae379e-6254-4b21-2ce1-08d7b4b49463
X-MS-TrafficTypeDiagnostic: BYAPR15MB3189:
X-Microsoft-Antispam-PRVS: <BYAPR15MB318963581E6C7344D7E93553BE110@BYAPR15MB3189.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(66476007)(66556008)(4326008)(66946007)(53546011)(2906002)(186003)(33716001)(16526019)(55016002)(86362001)(54906003)(1076003)(9686003)(5660300002)(8676002)(6666004)(478600001)(8936002)(52116002)(6496006)(81156014)(6916009)(316002)(9576002)(33656002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3189;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KLSejzSeFUIoUrDw56PnTCI07agx4SQmZd80eoOH+6IT2Ha/FSnkdYenFX+w2mw10GyxoCzPWdscU17pTGMbqMrayOKZbftYSMMuoaXqQDWu/4/VbXlKTaKlfNZh2R70+TYDMVKKMfThs0XfWGAjL/v+SqJkADpzbWV7SbVYkbN6LyE3P2vXu3gRJksWS3+siORcbGQB3CwQ0E6HFYF7H9RbUofnrtjDJQ7nlhuAQGG6Bup1Hi05HBtUk5cCCeCRfJ0tHdfidCrl8UscFmABOWtL7ZBp/9Yz2dF5mL4v7yruX5V+10zNfkC6b+GDtUJ9BJDs75GJhgNKht5QAeUPieDplot5GwarcFPwt/rKnh4MVmNqDt57qGv7jhod1DDKILjdmi4lzNnSDZrMCQKuDKu4KYrmTgesdeq2/ojJfMKJbZi81MivP4/xX20pAIMg
X-MS-Exchange-AntiSpam-MessageData: 725vWGf83iTqpZjphBLZ/GZiF7rkH/D/BYVmpHSM+9JFkiDxtC4F9QgMEXi1T1+YN8AAw+4C6sAzwu5R1szMpWJwm3uY7VUokk6yQ1QA+7o7SO12/qvqVK3iJL1XglFm49SsHeta0Ggy5UsBnSAlAjAsV2jakMpEW7AzSor5tKN/lvJwMHNrl9mIi+yjKpBN
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ae379e-6254-4b21-2ce1-08d7b4b49463
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 20:53:17.6043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3x1E+oxa5QGnRA4QHu6DYz7O0+fM9oZLLLOSJQIieMpes7oVets7rAavD8UiRm+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3189
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_06:2020-02-18,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 clxscore=1011 spamscore=0 impostorscore=0 suspectscore=5
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180137
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 12:15:54PM +0800, Wen Yang wrote:
> 
> 
> On 2020/2/13 6:52 上午, Andrew Morton wrote:
> > On Sat,  1 Feb 2020 11:15:02 +0800 Wen Yang <wenyang@linux.alibaba.com> wrote:
> > 
> > > The lock, protecting the node partial list, is taken when couting the free
> > > objects resident in that list. It introduces locking contention when the
> > > page(s) is moved between CPU and node partial lists in allocation path
> > > on another CPU. So reading "/proc/slabinfo" can possibily block the slab
> > > allocation on another CPU for a while, 200ms in extreme cases. If the
> > > slab object is to carry network packet, targeting the far-end disk array,
> > > it causes block IO jitter issue.
> > > 
> > > This fixes the block IO jitter issue by caching the total inuse objects in
> > > the node in advance. The value is retrieved without taking the node partial
> > > list lock on reading "/proc/slabinfo".
> > > 
> > > ...
> > > 
> > > @@ -1768,7 +1774,9 @@ static void free_slab(struct kmem_cache *s, struct page *page)
> > >   static void discard_slab(struct kmem_cache *s, struct page *page)
> > >   {
> > > -	dec_slabs_node(s, page_to_nid(page), page->objects);
> > > +	int inuse = page->objects;
> > > +
> > > +	dec_slabs_node(s, page_to_nid(page), page->objects, inuse);
> > 
> > Is this right?  dec_slabs_node(..., page->objects, page->objects)?
> > 
> > If no, we could simply pass the page* to inc_slabs_node/dec_slabs_node
> > and save a function argument.
> > 
> > If yes then why?
> > 
> 
> Thanks for your comments.
> We are happy to improve this patch based on your suggestions.
> 
> 
> When the user reads /proc/slabinfo, in order to obtain the active_objs
> information, the kernel traverses all slabs and executes the following code
> snippet:
> static unsigned long count_partial(struct kmem_cache_node *n,
>                                         int (*get_count)(struct page *))
> {
>         unsigned long flags;
>         unsigned long x = 0;
>         struct page *page;
> 
>         spin_lock_irqsave(&n->list_lock, flags);
>         list_for_each_entry(page, &n->partial, slab_list)
>                 x += get_count(page);
>         spin_unlock_irqrestore(&n->list_lock, flags);
>         return x;
> }
> 
> It may cause performance issues.
> 
> Christoph suggested "you could cache the value in the userspace application?
> Why is this value read continually?", But reading the /proc/slabinfo is
> initiated by the user program. As a cloud provider, we cannot control user
> behavior. If a user program inadvertently executes cat /proc/slabinfo, it
> may affect other user programs.
> 
> As Christoph said: "The count is not needed for any operations. Just for the
> slabinfo output. The value has no operational value for the allocator
> itself. So why use extra logic to track it in potentially performance
> critical paths?"
> 
> In this way, could we show the approximate value of active_objs in the
> /proc/slabinfo?
> 
> Based on the following information:
> In the discard_slab() function, page->inuse is equal to page->total_objects;
> In the allocate_slab() function, page->inuse is also equal to
> page->total_objects (with one exception: for kmem_cache_node, page-> inuse
> equals 1);
> page->inuse will only change continuously when the obj is constantly
> allocated or released. (This should be the performance critical path
> emphasized by Christoph)
> 
> When users query the global slabinfo information, we may use total_objects
> to approximate active_objs.

Well, from one point of view, it makes no sense, because the ratio between
these two numbers is very meaningful: it's the slab utilization rate.

On the other side, with enabled per-cpu partial lists active_objs has
nothing to do with the reality anyway, so I agree with you, calling
count_partial() is almost useless.

That said, I wonder if the right thing to do is something like the patch below?

Thanks!

Roman

--

diff --git a/mm/slub.c b/mm/slub.c
index 1d644143f93e..ba0505e75ecc 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2411,14 +2411,16 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
 static unsigned long count_partial(struct kmem_cache_node *n,
                                        int (*get_count)(struct page *))
 {
-       unsigned long flags;
        unsigned long x = 0;
+#ifdef CONFIG_SLUB_CPU_PARTIAL
+       unsigned long flags;
        struct page *page;
 
        spin_lock_irqsave(&n->list_lock, flags);
        list_for_each_entry(page, &n->partial, slab_list)
                x += get_count(page);
        spin_unlock_irqrestore(&n->list_lock, flags);
+#endif
        return x;
 }
 #endif /* CONFIG_SLUB_DEBUG || CONFIG_SYSFS */

