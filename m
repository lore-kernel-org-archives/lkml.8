Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA3BC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794B020838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="S5BqXaDh";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZDHVku9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgBXRBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:01:35 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3982 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726806AbgBXRBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:01:34 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01OGvDjZ014287;
        Mon, 24 Feb 2020 09:01:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=PZKky4MDqFoN13eMlb4EK8/YNe35GigjAbaJBYlp+QQ=;
 b=S5BqXaDhybUtcYTuKAp7YHOWCxmuUVTafGLwxA7uydqxuCY2SuSGdhapKX/XqoaIOOJI
 8Wu84//3/ksT/8xggapPr5ADqYk1/7Ar7wAljrOWu0BqI4rdMQiIpXCLjNXv/WnE2/Qx
 Xu35xcaSztAaenqzvpHSE8UpV+Q/hxg0Shc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2ybmvkdyr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 Feb 2020 09:01:17 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 24 Feb 2020 09:01:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3p3+3655aGR5zzGxzjWidTGrN+3QexZ2F95/x5WpnWUYOEa0JjQJJhWIY524TSZTOwd/AadTJQIqDKua/4DxreVsjJ/f8ScRM+HyLXKescN5oRmQ6NvrD183m4ukXiTAIFyz4kuP9Pgyr8SvTNyKPAr1o8p3nMrrM/7dM5kbL0dsKT5+gpEl43B020jGR6XObX4ZJ8uJBPDejgQBcJpjuY53faDFtzz93Q4TmyHIjdOtn39E5sbLB2Kx3Ed12/DOvj2Nzyt7NKVjxCk/yfrwdCQnhrmjHIxxBaEi30C3dwrvftcvVaZNj7LRXoOIjA+QCFGr2jkrk5c4UgBJjf1Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZKky4MDqFoN13eMlb4EK8/YNe35GigjAbaJBYlp+QQ=;
 b=a01tLtMkTLHzq9PV3/1xPwgOnBD9ucc2LzDitvhwHFaGZDqKhtKs+inuCIV08dLHn95uHmZpGjy3yxAhqwyLXCsKJkfEapKjWqdUa0AQbY4QSuxwDhJFs3q27aq0/1wEOgup8LUiQ7XPIEeGagW3I2RFxKFW+BR03JQ8PnMOSxsjxaKmgdASIfzJgx4moHkCJgN1Jkt2HLVh5jWNTx3SC5HuVNcns/leqto02OqMkjbZ7mToFTTFUQCnK5laQ04QCLWPpAGRRQbKTxatHRVXRnj9ZqZtkUceHzT8r9csF+hIklk0sfJAlK8DiVA0+c3WncWx+6oztesuAnLC17K7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZKky4MDqFoN13eMlb4EK8/YNe35GigjAbaJBYlp+QQ=;
 b=ZDHVku9DABzSZ5aDP7Pdt0ntfCjdqeQITIth+4WWzIppjnlXLkTRbmFKmEh5cByoAdxXJZ45814aWNsRH1tcxDqFcteNWBWcEJQ1VjPSYsyY/212/3K9EoYKUn89MBIaaoWyrRhuy57VJGGNqaYVtNtP6MSDFxGn6TFST5oYPzY=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by BYAPR15MB2472.namprd15.prod.outlook.com (2603:10b6:a02:8b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 17:01:14 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 17:01:14 +0000
Date:   Mon, 24 Feb 2020 09:01:09 -0800
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
Message-ID: <20200224170109.GA484928@carbon.dhcp.thefacebook.com>
References: <20200201031502.92218-1-wenyang@linux.alibaba.com>
 <20200212145247.bf89431272038de53dd9d975@linux-foundation.org>
 <b42f7daa-4aea-1cf8-5bbb-2cd5d48b4e9a@linux.alibaba.com>
 <20200218205312.GA3156@carbon>
 <cb36f3e5-c01c-a99d-9230-af52f806e227@linux.alibaba.com>
 <20200220154036.GA191388@carbon.dhcp.thefacebook.com>
 <98c84f23-0636-a877-a96d-d6e58d540aa4@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98c84f23-0636-a877-a96d-d6e58d540aa4@linux.alibaba.com>
X-ClientProxiedBy: MWHPR18CA0032.namprd18.prod.outlook.com
 (2603:10b6:320:31::18) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:500::5:ee6) by MWHPR18CA0032.namprd18.prod.outlook.com (2603:10b6:320:31::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 17:01:12 +0000
X-Originating-IP: [2620:10d:c090:500::5:ee6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 841b19a0-e382-48af-aa4b-08d7b94b2810
X-MS-TrafficTypeDiagnostic: BYAPR15MB2472:
X-Microsoft-Antispam-PRVS: <BYAPR15MB247258B3F3E2B9D56304B31FBEEC0@BYAPR15MB2472.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(136003)(376002)(189003)(199004)(33656002)(6666004)(6916009)(2906002)(316002)(81166006)(8676002)(54906003)(81156014)(4326008)(86362001)(5660300002)(8936002)(16526019)(186003)(6506007)(9686003)(53546011)(55016002)(1076003)(66556008)(478600001)(66476007)(66946007)(52116002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2472;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0QG3Gy0tu+80FAdn07zZhlDTFvcIbRMVI04c6cmI0lFzenvt1e36H1uYFNItdWkrm/r64gX8rQvNMAwDnTlaTKuQ6OPTJ37ak023PtEQBgXf4Un69BKlMKMar2iOrBtnnUP0pVKatPP+Qlo20ZC8hYmEkxrThJYcc+5307VNQuHjfGNN1dVLYUuSnVvg2RPah/Zrypaxc1bF3Hy5c8PRTq5QRPeObTYcENMS3s3LwMcGuwz/iUrmeGMmibTsNOKmEE6g72u1qdU1X1e8ojs93wsbKue6JMqP4832YvbfFcgYK9UFUmvLlslw6lrnz63IPKcLvVOPu4JqnkfejGB01LRR4N932qSl6rTntTdkUcTtG4ITQuyigyG99BKHKubrhq4juL2KhrAD1nGdj3bBE2IgnzzRRuoAWpSOPneE/uDFAk6kpt/x0xO2QoWpR9I
X-MS-Exchange-AntiSpam-MessageData: ZP/dcLs0UQBusDGtK8YF8CnS0Zzs/5U/BYTlluVeeGUI5hORJRE46iqEtZam+B1MEWxzjYHJ+qRR9sMWUbX+RaaUZ/riO29KR8DozyvimAmbh9huY1s1NCZRcqlBsFW09ZhdCifC+AZdmqleAZDMWd/DQ+dw+cFsfyg9mPUyopntYv3n86rSuH4Al1sTABtJ
X-MS-Exchange-CrossTenant-Network-Message-Id: 841b19a0-e382-48af-aa4b-08d7b94b2810
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 17:01:14.4979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hp5/jkqvrcioMvr4Qoob5LP4MpZUFmf+0wRV5YVlLRAyFOeIFGAn8qYzDolWAkY8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2472
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-24_07:2020-02-21,2020-02-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=5 priorityscore=1501 mlxlogscore=999 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002240130
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 02:55:39PM +0800, Wen Yang wrote:
> 
> 
> On 2020/2/20 11:40 下午, Roman Gushchin wrote:
> > On Thu, Feb 20, 2020 at 09:53:26PM +0800, Wen Yang wrote:
> > > 
> > > 
> > > On 2020/2/19 4:53 上午, Roman Gushchin wrote:
> > > > On Sun, Feb 16, 2020 at 12:15:54PM +0800, Wen Yang wrote:
> > > > > 
> > > > > 
> > > > > On 2020/2/13 6:52 上午, Andrew Morton wrote:
> > > > > > On Sat,  1 Feb 2020 11:15:02 +0800 Wen Yang <wenyang@linux.alibaba.com> wrote:
> > > > > > 
> > > > > > > The lock, protecting the node partial list, is taken when couting the free
> > > > > > > objects resident in that list. It introduces locking contention when the
> > > > > > > page(s) is moved between CPU and node partial lists in allocation path
> > > > > > > on another CPU. So reading "/proc/slabinfo" can possibily block the slab
> > > > > > > allocation on another CPU for a while, 200ms in extreme cases. If the
> > > > > > > slab object is to carry network packet, targeting the far-end disk array,
> > > > > > > it causes block IO jitter issue.
> > > > > > > 
> > > > > > > This fixes the block IO jitter issue by caching the total inuse objects in
> > > > > > > the node in advance. The value is retrieved without taking the node partial
> > > > > > > list lock on reading "/proc/slabinfo".
> > > > > > > 
> > > > > > > ...
> > > > > > > 
> > > > > > > @@ -1768,7 +1774,9 @@ static void free_slab(struct kmem_cache *s, struct page *page)
> > > > > > >     static void discard_slab(struct kmem_cache *s, struct page *page)
> > > > > > >     {
> > > > > > > -	dec_slabs_node(s, page_to_nid(page), page->objects);
> > > > > > > +	int inuse = page->objects;
> > > > > > > +
> > > > > > > +	dec_slabs_node(s, page_to_nid(page), page->objects, inuse);
> > > > > > 
> > > > > > Is this right?  dec_slabs_node(..., page->objects, page->objects)?
> > > > > > 
> > > > > > If no, we could simply pass the page* to inc_slabs_node/dec_slabs_node
> > > > > > and save a function argument.
> > > > > > 
> > > > > > If yes then why?
> > > > > > 
> > > > > 
> > > > > Thanks for your comments.
> > > > > We are happy to improve this patch based on your suggestions.
> > > > > 
> > > > > 
> > > > > When the user reads /proc/slabinfo, in order to obtain the active_objs
> > > > > information, the kernel traverses all slabs and executes the following code
> > > > > snippet:
> > > > > static unsigned long count_partial(struct kmem_cache_node *n,
> > > > >                                           int (*get_count)(struct page *))
> > > > > {
> > > > >           unsigned long flags;
> > > > >           unsigned long x = 0;
> > > > >           struct page *page;
> > > > > 
> > > > >           spin_lock_irqsave(&n->list_lock, flags);
> > > > >           list_for_each_entry(page, &n->partial, slab_list)
> > > > >                   x += get_count(page);
> > > > >           spin_unlock_irqrestore(&n->list_lock, flags);
> > > > >           return x;
> > > > > }
> > > > > 
> > > > > It may cause performance issues.
> > > > > 
> > > > > Christoph suggested "you could cache the value in the userspace application?
> > > > > Why is this value read continually?", But reading the /proc/slabinfo is
> > > > > initiated by the user program. As a cloud provider, we cannot control user
> > > > > behavior. If a user program inadvertently executes cat /proc/slabinfo, it
> > > > > may affect other user programs.
> > > > > 
> > > > > As Christoph said: "The count is not needed for any operations. Just for the
> > > > > slabinfo output. The value has no operational value for the allocator
> > > > > itself. So why use extra logic to track it in potentially performance
> > > > > critical paths?"
> > > > > 
> > > > > In this way, could we show the approximate value of active_objs in the
> > > > > /proc/slabinfo?
> > > > > 
> > > > > Based on the following information:
> > > > > In the discard_slab() function, page->inuse is equal to page->total_objects;
> > > > > In the allocate_slab() function, page->inuse is also equal to
> > > > > page->total_objects (with one exception: for kmem_cache_node, page-> inuse
> > > > > equals 1);
> > > > > page->inuse will only change continuously when the obj is constantly
> > > > > allocated or released. (This should be the performance critical path
> > > > > emphasized by Christoph)
> > > > > 
> > > > > When users query the global slabinfo information, we may use total_objects
> > > > > to approximate active_objs.
> > > > 
> > > > Well, from one point of view, it makes no sense, because the ratio between
> > > > these two numbers is very meaningful: it's the slab utilization rate.
> > > > 
> > > > On the other side, with enabled per-cpu partial lists active_objs has
> > > > nothing to do with the reality anyway, so I agree with you, calling
> > > > count_partial() is almost useless.
> > > > 
> > > > That said, I wonder if the right thing to do is something like the patch below?
> > > > 
> > > > Thanks!
> > > > 
> > > > Roman
> > > > 
> > > > --
> > > > 
> > > > diff --git a/mm/slub.c b/mm/slub.c
> > > > index 1d644143f93e..ba0505e75ecc 100644
> > > > --- a/mm/slub.c
> > > > +++ b/mm/slub.c
> > > > @@ -2411,14 +2411,16 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
> > > >    static unsigned long count_partial(struct kmem_cache_node *n,
> > > >                                           int (*get_count)(struct page *))
> > > >    {
> > > > -       unsigned long flags;
> > > >           unsigned long x = 0;
> > > > +#ifdef CONFIG_SLUB_CPU_PARTIAL
> > > > +       unsigned long flags;
> > > >           struct page *page;
> > > >           spin_lock_irqsave(&n->list_lock, flags);
> > > >           list_for_each_entry(page, &n->partial, slab_list)
> > > >                   x += get_count(page);
> > > >           spin_unlock_irqrestore(&n->list_lock, flags);
> > > > +#endif
> > > >           return x;
> > > >    }
> > > >    #endif /* CONFIG_SLUB_DEBUG || CONFIG_SYSFS */
> > > > 
> > > 
> > > Hi Roman,
> > > 
> > > Thanks for your comments.
> > > 
> > > In the server scenario, SLUB_CPU_PARTIAL is turned on by default, and can
> > > improve the performance of the cloud server, as follows:
> > 
> > Hello, Wen!
> > 
> > That's exactly my point: if CONFIG_SLUB_CPU_PARTIAL is on, count_partial() is useless
> > anyway because the returned number is far from the reality. So if we define
> > active_objects == total_objects, as you basically suggest, we do not introduce any
> > regression. Actually I think it's even preferable to show the unrealistic uniform 100%
> > slab utilization rather than some very high but incorrect value.
> > 
> > And on real-time systems uncontrolled readings of /proc/slabinfo is less
> > of a concern, I hope.
> > 
> > Thank you!
> > 
> 
> Great！
> We only need to correct a typo to achieve this goal, as follows:
> Change #ifdef CONFIG_SLUB_CPU_PARTIAL to #ifndef CONFIG_SLUB_CPU_PARTIAL

Yes, you're obviously right.

Thanks!
