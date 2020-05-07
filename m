Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0E3C47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC1220870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aBOCZWpy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JIPQ1ttf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgEGW0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 18:26:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49468 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726579AbgEGW0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:26:44 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047ML9It010911;
        Thu, 7 May 2020 15:26:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=HujoUhfhOJD/O0Ctoz3VKf1kuOWomGPzKxz+CmQERiM=;
 b=aBOCZWpy7lM7NbLCrLr2iz1357Bb6MOypRr9rOMb2co9dl0EUc0yjxmBw5RD3ogtS9xG
 yA8NPYvAKPbOn3FBGwI+4GftrnpEwFTDC+NMuH8wv7QWHaEwinEjRwjVYSpuqNtZIGuw
 t+jkXGHtjqSPPzOHFp95m9Zl+n6QOF2uhpA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 30vtdxr849-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 07 May 2020 15:26:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 7 May 2020 15:26:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0bkM34qqCov6BruB66nnPwvCrpy54MWxheeXgivLG4QbTK0tAA9brnZhVt9HtVpTHeIKlyjvum1W4rNzoWAoAf97pEjMWCz+YcWLbU7zMU1vm9EfDN1a/49baNKyROwIh4/GLNL6piCLxMIzy+8MEhNZCYkZ9+cYilzUhgSDWwwajvaW5F4LPUQ/VauzXMm2iXtNO6ahB52Z/SIr2cYH3CYZUl7U3/Vz8xvhtBRcUFiiVWQzysYWP3ewO0p25oKl2LrZG64TMtcecPLJaQ+mSkKsjjjcYn2loeKbjGQx4yvES86nH/bFqMzEqwciNw5oB/c5U4yipjBFZsKUl80qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HujoUhfhOJD/O0Ctoz3VKf1kuOWomGPzKxz+CmQERiM=;
 b=DZQfrNi5n6QDtLqoNiqfNHYpc0COQgox4LPHLGLCfdyfhmC4MdyEKY0yI04nRNDefg2HB4kiRsKjxYsKEFoXEQQremU+XB6nRD3IZZ8XcknYKl4ZN6zVWd5aGPTY0cEVNjgmMf6zKwa878zZ2pv5K5Hb6iZC9PZpukm14gsHHtVhtdGWFTECKGDLHJFX+C/aMWD3EO5ZWlZItfWVA3M/IUL/sLONBNBjZ1eF0LcV0X95L6HBGmX/opVkgGfajODotUm2X1vT35cJOSkRXJw/G9jqWZM0e8R1bpFzZTNpPddDIAnBX91+PzO2XznMeRGZCj+riezV/4wAgLqHeYNlmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HujoUhfhOJD/O0Ctoz3VKf1kuOWomGPzKxz+CmQERiM=;
 b=JIPQ1ttf/KN+6drftAFoFK2KcL0P/YSI1aweEz4L0SVg78uJzrHfmNrC/D6NZv9UCoYCYLABcpFjmsHST4cyq3R/nbgePXF72fHbOMlYLVyIvxthz26kcy9zVNwiAAlPo7noSVmx9DZ/mD/JmaaRH7Pb/fNFh/fhBrW/dVYxyWw=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2358.namprd15.prod.outlook.com (2603:10b6:a02:8c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Thu, 7 May
 2020 22:26:35 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::bdf9:6577:1d2a:a275%7]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 22:26:34 +0000
Date:   Thu, 7 May 2020 15:26:31 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/19] mm: memcg/slab: obj_cgroup API
Message-ID: <20200507222631.GA81857@carbon.dhcp.thefacebook.com>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-7-guro@fb.com>
 <20200507210314.GD161043@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507210314.GD161043@cmpxchg.org>
X-ClientProxiedBy: BY5PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::35) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:5b44) by BY5PR17CA0022.namprd17.prod.outlook.com (2603:10b6:a03:1b8::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Thu, 7 May 2020 22:26:34 +0000
X-Originating-IP: [2620:10d:c090:400::5:5b44]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9391fa89-b501-4baa-de8e-08d7f2d5b336
X-MS-TrafficTypeDiagnostic: BYAPR15MB2358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2358612285ABCAE487593157BEA50@BYAPR15MB2358.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQvDa7fqWaF3M5rtqI5+LK5cYNoJUJHDFz49P/XjMlM0ppOq2o8/6w5pbIaNVLzB/yzc+iJVbP43nIQA95omC/JSrNMKJsKLZNOViwVsGwy4vaR1x9vQol2HVDN+7hOi7ncKIgiKxzZOlJWTFX13DLWUM6qZLvM0iQxfkv59Z4szrcK0+frGvkbtFAmLlUvRiEy0okj6gtwCArB6XnlHX08xmSqFnVVj78zBM5rTRUI95pZ28t6YgbrfZ3DZjyh9SStnENuEifJBYeK5YFVkHqPyUN9u3wr/Eys+jcYDVUMgmYk7qQhk8a47dAhmNUqlYYavXoWmq/oYN0j3NB6FI1TwW1Ng6ND/P9A+7w5yhQB7R+IdjzriNmjN3ehkVFRpqpR8PmEtNdXGoo921+9D4ycMJtvZAcHRiD02s72mQgwFl01Uqyh7pr8bCk23TXjDiTpD+siMsElTgN0QjFLtpwtzEEznjsBtOwtHh5FYnWo+sAa7VXEK7h+kYQt+E5TlYzHBOfh+SqkmoeOyNTUpjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(376002)(366004)(39860400002)(396003)(33430700001)(33440700001)(66556008)(66476007)(66946007)(8936002)(8676002)(1076003)(2906002)(5660300002)(54906003)(6666004)(6916009)(33656002)(6506007)(9686003)(16526019)(86362001)(55016002)(316002)(7696005)(52116002)(186003)(478600001)(83280400001)(83320400001)(83290400001)(83310400001)(83300400001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6wn++WgBYkQ0rA+N4QITswaB/E89RPpu+xR9zO4ah+8qCHx81GMrzDXfeB9TPKrZudImOLPiZsJsdgQkyZZgE3ohmfDf/wz2fEpOTJFPHg0k2ABUYGlJQqjlKE7c8++P+itl2Zsao1AW9tMcNT9mdDOh78bd49OfIeiekMiJKZp16G4XfqXJJPhy5nAIDugTVCgBgd7SbLWVDvolRcgXCV0Q92U8qGY/qGQyoFk25vAKmYRBsqqp2JKhagBSblh3NQaeOvtruKEw3INOx02a/SlS4K4Z1k9Pe1hISSacXpdA3zjjUBoTkfrXWZ43XHGKsYQJUg9yfKGszE9qL/57kYWeaEZ6gnDHZsXUXrO17TrxJV7zAJe0k1pU/mcRl4mcERGl+MlqrdMxzKl9XpJjw/tKL+6GbWNvOQTrI9q//6VIGz/1pV2//f3JS5sT9QDPWaejAnnXc492WMEcaA4telnJVQkErB8hYVs/qhO+7SSs3rTxl0pIOPepAjXGnfFC/WiurTpiv/liWO4bxLSdQcDdlL9VRdFkFs63kDTHIE0jp+Zgw+T760IMljOix7bZzV73Uc7V1VC37TcpNhTeigQ/IQt+fMQQ3u43F+XYl87E2RgnaSQGQYl4355+UsIUKWbIpJvMPb48FhcMPPEGpgxm4BfR22IIeOHrBhp3vSFKLxDetKpHDZwmcMDPE5m2Lcyg2qzrSmLGs6SMkRvLChyMtRCoCPd2FB/v0XQW/0qvKG5RQSIjUNfjHpPIbmtTRE//oMeK6YAwzKvsA8GZEN61FqTIj53SJKcEHB/z9MbLym9PjoPzfpik1oQLWVYf1x58x6a/AhE3+nxI2ZURMw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9391fa89-b501-4baa-de8e-08d7f2d5b336
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 22:26:34.7796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwRWNExM4fduVfIvAGU2nW6vN/uoZ3ouZB4DEDwvOa4t97h3CANLmamWVl48kuDh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2358
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_16:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 suspectscore=5 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005070178
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 05:03:14PM -0400, Johannes Weiner wrote:
> On Wed, Apr 22, 2020 at 01:46:55PM -0700, Roman Gushchin wrote:
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -257,6 +257,78 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
> >  }
> >  
> >  #ifdef CONFIG_MEMCG_KMEM
> > +extern spinlock_t css_set_lock;
> > +
> > +static void obj_cgroup_release(struct percpu_ref *ref)
> > +{
> > +	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
> > +	struct mem_cgroup *memcg;
> > +	unsigned int nr_bytes;
> > +	unsigned int nr_pages;
> > +	unsigned long flags;
> > +
> > +	nr_bytes = atomic_read(&objcg->nr_charged_bytes);
> > +	WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
> > +	nr_pages = nr_bytes >> PAGE_SHIFT;
> 
> What guarantees that we don't have a partial page in there at this
> point? I guess any outstanding allocations would pin the objcg, so
> when it's released all objects have been freed.

Right, this is exactly the reason why there can't be a partial page
at this point.

> 
> But if that's true, how can we have full pages remaining in there now?

Imagine the following sequence:
1) CPU0: objcg == stock->cached_objcg
2) CPU1: we do a small allocation (e.g. 92 bytes), page is charged
3) CPU1: a process from another memcg is allocating something, stock if flushed,
   objcg->nr_charged_bytes = PAGE_SIZE - 92
5) CPU0: we do release this object, 92 bytes are added to stock->nr_bytes
6) CPU0: stock is flushed, 92 bytes are added to objcg->nr_charged_bytes

In the result, nr_charged_bytes == PAGE_SIZE. This PAGE will be uncharged
in obj_cgroup_release().

I've double checked this, it's actually pretty easy to trigger in the real life.

> 
> > @@ -2723,6 +2820,30 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
> >  	return page->mem_cgroup;
> >  }
> >  
> > +__always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> > +{
> > +	struct obj_cgroup *objcg = NULL;
> > +	struct mem_cgroup *memcg;
> > +
> > +	if (unlikely(!current->mm))
> > +		return NULL;
> > +
> > +	rcu_read_lock();
> > +	if (unlikely(current->active_memcg))
> > +		memcg = rcu_dereference(current->active_memcg);
> > +	else
> > +		memcg = mem_cgroup_from_task(current);
> > +
> > +	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
> > +		objcg = rcu_dereference(memcg->objcg);
> > +		if (objcg && obj_cgroup_tryget(objcg))
> > +			break;
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	return objcg;
> > +}
> 
> Thanks for moving this here from one of the later patches, it helps
> understanding the life cycle of obj_cgroup better.
> 
> > +int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
> > +{
> > +	struct mem_cgroup *memcg;
> > +	unsigned int nr_pages, nr_bytes;
> > +	int ret;
> > +
> > +	if (consume_obj_stock(objcg, size))
> > +		return 0;
> > +
> > +	rcu_read_lock();
> > +	memcg = obj_cgroup_memcg(objcg);
> > +	css_get(&memcg->css);
> > +	rcu_read_unlock();
> > +
> > +	nr_pages = size >> PAGE_SHIFT;
> > +	nr_bytes = size & (PAGE_SIZE - 1);
> > +
> > +	if (nr_bytes)
> > +		nr_pages += 1;
> > +
> > +	ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
> 
> If consume_obj_stock() fails because some other memcg is cached,
> should this try to consume the partial page in objcg->nr_charged_bytes
> before getting more pages?

We can definitely do it, but I'm not sure if it's good for the performance.

Dealing with nr_charged_bytes will require up to two atomic writes,
so calling __memcg_kmem_charge() can be faster if memcg is cached
on percpu stock.

> 
> > +	if (!ret && nr_bytes)
> > +		refill_obj_stock(objcg, PAGE_SIZE - nr_bytes);
> 
> This will put the cgroup into the cache if the allocation resulted in
> a partially free page.
> 
> But if this was a page allocation, we may have objcg->nr_cache_bytes
> from a previous subpage allocation that we should probably put back
> into the stock.

Yeah, we can do this, but I don't know if there will be any benefits.

Actually we don't wanna to touch objcg->nr_cache_bytes too often, as
it can become a contention point if there are many threads allocating
in the memory cgroup.

So maybe we want to do the opposite: relax it a bit and stop flushing
it on every stock refill and flush only if it exceeds a certain value.

> 
> It's not a common case, I'm just trying to understand what
> objcg->nr_cache_bytes holds and when it does so.

So it's actually a centralized leftover from the rounding of the actual
charge to the page size.

> 
> The rest of this patch looks good to me!

Great!

Thank you very much for the review!
