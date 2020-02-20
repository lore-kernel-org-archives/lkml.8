Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69A7C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769A2207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oh8Ww43w";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BnrXmVp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgBTPlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:41:12 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6148 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728305AbgBTPlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:41:11 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 01KFbuLS006884;
        Thu, 20 Feb 2020 07:40:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=KVZCuSFI8K2grWi1H7cHL6KkJTX844z6Qxg+85P8OgA=;
 b=oh8Ww43whFJ6ZLlWhlI/t4YxUQ+J4eID9FhB9uVBvar4sET7eYPvlHUdCng/qzCVWCzK
 ny9i6zarN0h67u9KB6eDxN6uK3FTjIYO98a0A6BEJkdInuRskRxoqgnuJxfiG0PG6PBC
 JY6avLdMVTeqV5wx5qZHKhFvJVhS8KkWhFI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2y8ub493mj-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 20 Feb 2020 07:40:49 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 20 Feb 2020 07:40:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQQHY9AtZQ9++7MDpsHOhgJL4EiGbdk24DsomvegdBaXyv1nPBZ3PbiZz+tTm6C+gI13my+8DnDqgcghgzSc9tvjS9WCvV7X/uUgzYqL3yMc8qTbHulvAVOvMBSvAy5pcNxus3R2e2TkSUhQG4uEvuwB+nr4xPru0RWoNXnd8dN1hB+pLiNWSd1ozr2sQwUtdBqO+RXsJz4qL/7ZDLNnjNI6SZqFMxWYZhTRLrE+B/QSkU4UCIH2+nlpxJ+Bbtvm9zPAsyiuuLzeC6Vs/1nIqGPQI1jQO94cqRDvKEj/RrCUK/oDxQiRENwSdvJgsMKQw6/Z+zoku7PIcw4NoWV1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVZCuSFI8K2grWi1H7cHL6KkJTX844z6Qxg+85P8OgA=;
 b=gjf24tXVdhTn4FU+IixqaZcsfrYRvu/HLDJgKl2RHyh3y2EcH+NAEAjLYuMjZwkAhHmQbseKMJHtBuiZ4Dy/1EVrGdZ6XErQoE2c2K0t3pHMZrm3nr9TZQRhgnJHwcvI5O9s2OGAWiJEvYc/JETD0yX8EvVdmZv/GRUtiemXyft2UPtnPBx/zwnYwVzDWv8A5EgcF7S8d1C/1xSlKT0MxKBFmqrov/L6LRcXbo1+faFp/K5QQ/ZIZTzPZ4XHLaKz67etYaTwq5vSDu4XU+Yvc0sOUA87OAG55hJWnkodOaDZ8Z4KXcTIBNJqpNC3oWVitAxXh9F31127ZfPnK3Tw1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVZCuSFI8K2grWi1H7cHL6KkJTX844z6Qxg+85P8OgA=;
 b=BnrXmVp5mhXjCZI7nKM9V2WzU8qTOyB8DcnQpF8bRnoXKxAEihOoWJbLeaW8lE6WzqW7IU4nz462gYJuDoacKHCLdXxOW8E6Xfq0umzp8VKwtRXVgopziSqzaivs6jabTtI2CKic1zjWQLuOxSSR50Djb0ILyLkMfVCFIHO2JDo=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2200.namprd15.prod.outlook.com (52.135.196.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Thu, 20 Feb 2020 15:40:46 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 15:40:45 +0000
Date:   Thu, 20 Feb 2020 07:40:36 -0800
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
Message-ID: <20200220154036.GA191388@carbon.dhcp.thefacebook.com>
References: <20200201031502.92218-1-wenyang@linux.alibaba.com>
 <20200212145247.bf89431272038de53dd9d975@linux-foundation.org>
 <b42f7daa-4aea-1cf8-5bbb-2cd5d48b4e9a@linux.alibaba.com>
 <20200218205312.GA3156@carbon>
 <cb36f3e5-c01c-a99d-9230-af52f806e227@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb36f3e5-c01c-a99d-9230-af52f806e227@linux.alibaba.com>
X-ClientProxiedBy: MWHPR1201CA0007.namprd12.prod.outlook.com
 (2603:10b6:301:4a::17) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:500::6:7ecb) by MWHPR1201CA0007.namprd12.prod.outlook.com (2603:10b6:301:4a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Thu, 20 Feb 2020 15:40:44 +0000
X-Originating-IP: [2620:10d:c090:500::6:7ecb]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03172461-a864-423d-cd62-08d7b61b3fe8
X-MS-TrafficTypeDiagnostic: BYAPR15MB2200:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2200F97093C9EBC09E83C8E0BE130@BYAPR15MB2200.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(376002)(396003)(346002)(199004)(189003)(5660300002)(6666004)(4326008)(316002)(81156014)(81166006)(8936002)(2906002)(1076003)(7696005)(52116002)(8676002)(6506007)(478600001)(6916009)(55016002)(9686003)(54906003)(66946007)(66476007)(186003)(66556008)(53546011)(33656002)(16526019)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2200;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ySYzn+JYm6nOoiTfrbmQCPdeSqAxmX8+ifChm8a7gJM+rogt5MwXRO33UQswVRWVcL5NI1Mi+jvFf/54e8DyKbc1VNvaK9VHTwyegyla1SnzoiVYIy+4nvvXMau/uN/3F1Meq2sT+2zi7u4sbSo+0AWhuOsk8XdDFVpm7Uhm+Wvdj3+4eV+DeweqiweKXIPtWMtAV0O+FuO5g0XRI5RuQ7lSujUsVFcZ7CshHfT5UOkbUQVu33ncR4ws6xWxMpQ4NhqOSYPeqQnd7IXu2/8S3IVPrz9mwyiBVCtxqGiVJlUKUOVuFYrq590gN2W2Z0GeKaNotwu8jmTfHQs1vAPBxbjlipiB3o6rWILlk2jjtB9j6Af4xC2z9mmLReCwBMIkMHTmMMs4OQTOtZDw/+14Onmk8qfVBvOfUrpaG+ieu/J6zr94QSmhAtFRjZgyty8
X-MS-Exchange-AntiSpam-MessageData: 30IHJFER42ocxBwiCrXMpC1db74YaMqCSdDIWFMbarMaM+fFG1LcisxIJyQgZ3idLhUGnK5/xdN/xZseO4kCRj5ZzhfEY+m6IEeAwbiYQa3aL/qBInZAs0duLUi2wKI+cNFPSmspZYZIBoJjvQm20gxh9GDY5szToIG8+LOyIW/CnPgHS0UWyHIHK07qREZd
X-MS-Exchange-CrossTenant-Network-Message-Id: 03172461-a864-423d-cd62-08d7b61b3fe8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 15:40:45.8352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 067T3j7famv4FmrdaL2vPVQYLeyLWOizrnEndLdTgtzYKcGnCoqOZ+1i5Tfm+z8g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2200
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_04:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 suspectscore=5 phishscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002200115
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 09:53:26PM +0800, Wen Yang wrote:
> 
> 
> On 2020/2/19 4:53 上午, Roman Gushchin wrote:
> > On Sun, Feb 16, 2020 at 12:15:54PM +0800, Wen Yang wrote:
> > > 
> > > 
> > > On 2020/2/13 6:52 上午, Andrew Morton wrote:
> > > > On Sat,  1 Feb 2020 11:15:02 +0800 Wen Yang <wenyang@linux.alibaba.com> wrote:
> > > > 
> > > > > The lock, protecting the node partial list, is taken when couting the free
> > > > > objects resident in that list. It introduces locking contention when the
> > > > > page(s) is moved between CPU and node partial lists in allocation path
> > > > > on another CPU. So reading "/proc/slabinfo" can possibily block the slab
> > > > > allocation on another CPU for a while, 200ms in extreme cases. If the
> > > > > slab object is to carry network packet, targeting the far-end disk array,
> > > > > it causes block IO jitter issue.
> > > > > 
> > > > > This fixes the block IO jitter issue by caching the total inuse objects in
> > > > > the node in advance. The value is retrieved without taking the node partial
> > > > > list lock on reading "/proc/slabinfo".
> > > > > 
> > > > > ...
> > > > > 
> > > > > @@ -1768,7 +1774,9 @@ static void free_slab(struct kmem_cache *s, struct page *page)
> > > > >    static void discard_slab(struct kmem_cache *s, struct page *page)
> > > > >    {
> > > > > -	dec_slabs_node(s, page_to_nid(page), page->objects);
> > > > > +	int inuse = page->objects;
> > > > > +
> > > > > +	dec_slabs_node(s, page_to_nid(page), page->objects, inuse);
> > > > 
> > > > Is this right?  dec_slabs_node(..., page->objects, page->objects)?
> > > > 
> > > > If no, we could simply pass the page* to inc_slabs_node/dec_slabs_node
> > > > and save a function argument.
> > > > 
> > > > If yes then why?
> > > > 
> > > 
> > > Thanks for your comments.
> > > We are happy to improve this patch based on your suggestions.
> > > 
> > > 
> > > When the user reads /proc/slabinfo, in order to obtain the active_objs
> > > information, the kernel traverses all slabs and executes the following code
> > > snippet:
> > > static unsigned long count_partial(struct kmem_cache_node *n,
> > >                                          int (*get_count)(struct page *))
> > > {
> > >          unsigned long flags;
> > >          unsigned long x = 0;
> > >          struct page *page;
> > > 
> > >          spin_lock_irqsave(&n->list_lock, flags);
> > >          list_for_each_entry(page, &n->partial, slab_list)
> > >                  x += get_count(page);
> > >          spin_unlock_irqrestore(&n->list_lock, flags);
> > >          return x;
> > > }
> > > 
> > > It may cause performance issues.
> > > 
> > > Christoph suggested "you could cache the value in the userspace application?
> > > Why is this value read continually?", But reading the /proc/slabinfo is
> > > initiated by the user program. As a cloud provider, we cannot control user
> > > behavior. If a user program inadvertently executes cat /proc/slabinfo, it
> > > may affect other user programs.
> > > 
> > > As Christoph said: "The count is not needed for any operations. Just for the
> > > slabinfo output. The value has no operational value for the allocator
> > > itself. So why use extra logic to track it in potentially performance
> > > critical paths?"
> > > 
> > > In this way, could we show the approximate value of active_objs in the
> > > /proc/slabinfo?
> > > 
> > > Based on the following information:
> > > In the discard_slab() function, page->inuse is equal to page->total_objects;
> > > In the allocate_slab() function, page->inuse is also equal to
> > > page->total_objects (with one exception: for kmem_cache_node, page-> inuse
> > > equals 1);
> > > page->inuse will only change continuously when the obj is constantly
> > > allocated or released. (This should be the performance critical path
> > > emphasized by Christoph)
> > > 
> > > When users query the global slabinfo information, we may use total_objects
> > > to approximate active_objs.
> > 
> > Well, from one point of view, it makes no sense, because the ratio between
> > these two numbers is very meaningful: it's the slab utilization rate.
> > 
> > On the other side, with enabled per-cpu partial lists active_objs has
> > nothing to do with the reality anyway, so I agree with you, calling
> > count_partial() is almost useless.
> > 
> > That said, I wonder if the right thing to do is something like the patch below?
> > 
> > Thanks!
> > 
> > Roman
> > 
> > --
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 1d644143f93e..ba0505e75ecc 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2411,14 +2411,16 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
> >   static unsigned long count_partial(struct kmem_cache_node *n,
> >                                          int (*get_count)(struct page *))
> >   {
> > -       unsigned long flags;
> >          unsigned long x = 0;
> > +#ifdef CONFIG_SLUB_CPU_PARTIAL
> > +       unsigned long flags;
> >          struct page *page;
> >          spin_lock_irqsave(&n->list_lock, flags);
> >          list_for_each_entry(page, &n->partial, slab_list)
> >                  x += get_count(page);
> >          spin_unlock_irqrestore(&n->list_lock, flags);
> > +#endif
> >          return x;
> >   }
> >   #endif /* CONFIG_SLUB_DEBUG || CONFIG_SYSFS */
> > 
> 
> Hi Roman,
> 
> Thanks for your comments.
> 
> In the server scenario, SLUB_CPU_PARTIAL is turned on by default, and can
> improve the performance of the cloud server, as follows:

Hello, Wen!

That's exactly my point: if CONFIG_SLUB_CPU_PARTIAL is on, count_partial() is useless
anyway because the returned number is far from the reality. So if we define
active_objects == total_objects, as you basically suggest, we do not introduce any
regression. Actually I think it's even preferable to show the unrealistic uniform 100%
slab utilization rather than some very high but incorrect value.

And on real-time systems uncontrolled readings of /proc/slabinfo is less
of a concern, I hope.

Thank you!
