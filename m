Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE5EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F94246B6
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 21:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="q7FGa1aq";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="S3jygSpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgFTVMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 17:12:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62494 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728913AbgFTVM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 17:12:29 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05KL5WH2014836;
        Sat, 20 Jun 2020 14:12:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=WXbV9uwuTC/4T/AkoqG+eyr6qNRMyJSwg3kcosuoF7w=;
 b=q7FGa1aqtK5TqR4a7ztVz95phuzCCHAsjjQONM8BDF5edUCflTFsOPq7fvAkCxbhIrOi
 yQmeOXoHOcBqRI2AU+gSzX5/TWTM76k1x4vL5fRjQikTZyjrGzZ4OBKbAmgJCEYgyHKL
 X4Vqg+4XPSvAj20RHO++/s8o13T13pLUKfw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31sfjh1mty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 20 Jun 2020 14:12:15 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 20 Jun 2020 14:12:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQ20U+beftjeH91S2lUhHz/NZgmym3mxC1MfNbi5W4XXZwB1ihPHwoJO7WfS8xhJWiwjPaNV0jiXbYVUzttKM/s9W7pH8jtwWc5olq8RKK32opzDY3c/9P82JdncOvlps05Kp+unmcxSrOGO/XdD84pOXjlDxm0gH1vi1O2a72HZxxCwAkxmBDi3MpjDO8lfJTmv+QtwpJHVdsD4KfwrhCzVbJvPc1pBBDSTZDs4sigj6eHyiBiee6Jm3jW3/Rw9FNRGE5+CFu14xbJNYAKuK2r6dTu1whe9uDYpDfNwKUwsOlGlzILJ3878VvBaE3hCdzH54IvM9EJULuvBWBRU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXbV9uwuTC/4T/AkoqG+eyr6qNRMyJSwg3kcosuoF7w=;
 b=P4Rz8fu+MhSiIsZmk+Vc+V3dY1NpRHNXFBux+AzQwCPulvx+v/dob0Sup6AjW6ONVPrbgW2wLIpzEzOpX+g8ca3np4GFwvW+vgAkOi9sYU41lpnIV3GQlo/bbhmqR9a3zxcjb1LqQXiU92l7B5PHvnUdgOzHp4S1qf9wU83amflY+Wu5RbR06lpprQmx+xjQ747FeUoj6PwXVqbvJhWz7/q0yTQGOygDN2iupqnbtQ4QZo/BRnkFqcSMMoH1GVyYK2B1STXbm9/GaH+8jwO39LdckU6kSEcbcu8w1WUmqUeee8ys2E0K7tYk/1VdCA73gJUYhfGtrk01sSXO+3VRow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXbV9uwuTC/4T/AkoqG+eyr6qNRMyJSwg3kcosuoF7w=;
 b=S3jygSpKAkjv0sSCGHIL5VkX+LemnhhHsrXOq4StppvLVFezC4VLJnTpQq6ueTfNtRLExlxPYm66tpqOxLiaLBMeDQJD89Ud0434Vb8XXWs8UUJXsFleMjcfb11Z3ISTp688/og33he+O9IE+YUmVNQV7UsHmIQs2Wh2DPTgN2U=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2871.namprd15.prod.outlook.com (2603:10b6:a03:b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Sat, 20 Jun
 2020 21:12:13 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.021; Sat, 20 Jun 2020
 21:12:13 +0000
Date:   Sat, 20 Jun 2020 14:12:10 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Waiman Long <longman@redhat.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, slab: Fix sign conversion problem in
 memcg_uncharge_slab()
Message-ID: <20200620211210.GA288820@carbon.dhcp.thefacebook.com>
References: <20200620184719.10994-1-longman@redhat.com>
 <20200620140018.a305aebd01b2cf4226547944@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620140018.a305aebd01b2cf4226547944@linux-foundation.org>
X-ClientProxiedBy: BY3PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:217::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:89b1) by BY3PR04CA0022.namprd04.prod.outlook.com (2603:10b6:a03:217::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Sat, 20 Jun 2020 21:12:12 +0000
X-Originating-IP: [2620:10d:c090:400::5:89b1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fc70645-623e-46a1-f3f1-08d8155e9a36
X-MS-TrafficTypeDiagnostic: BYAPR15MB2871:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2871384D87F957DE11D191E6BE990@BYAPR15MB2871.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0440AC9990
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQjPxmrTCGo3UfU4TIoKzrO96EG6LzG0vKP4Mt4Pn7Luumg4UfPokGLzBHpdz6Yeh0/ShLVB7aOKmRMzwHsQfb1aaYiLQNVpvNU2Z4G3Hu9iIfH0emMXZJSCyyc75bzunYcrZzrofHMGVeOlniGDr2YJ/54xLZGKnRteWVioIsLpP2HF1K/w8aBX+bYGFIjwzVLnWHrAVqc6hQLVluHDvmEi2B9SeY2XT/4mVzD2izmlAbUKnyHPZJoP74xEGSMejAcXbsc1giGNvnj+wm+EPQEO0bh9x98jZ/fUSHXLKGkrOfxnb9WhwzuieXTKTnLKHrIf1VCUlxcv6raAg/uZ9lDAMqykD/UHJ5KudBpltjjZFUl3h9w1zY39XzBnN3YWa10ur2A/s7tkmpz21ZKn9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(39860400002)(376002)(396003)(346002)(316002)(186003)(16526019)(83380400001)(2906002)(33656002)(4326008)(54906003)(8936002)(5660300002)(7696005)(6506007)(52116002)(9686003)(55016002)(66476007)(66556008)(1076003)(6916009)(478600001)(8676002)(7416002)(86362001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: AyfYZMFy7wQGPtcp6MoWXRCp6XZOA1VQon9QkdaOVzlElCIiVRfkTjOB2z8WMvn8jhT1IER0Kn8lHg62/rjRr6daK7vYacLRhUunmWPURtnkUoDsJIBUpz/SvSL7/LacQnZqtvmaM2tJ7jzCx6zsEGClCuKtgU7+iLSvnddbKNhInw/EtDLtH7nk2+bDGCNTWO1ZHfz4tEWyNbX401WV9hWoElF65ETe2RrQlE4ab3DkgoW8v+6zf/NSBkEZPexiK6WgzX0JcU5w5TxHLiQHtH/JSp4saKV9drPW5m8YsKAscGf+uSl2V9IK1EYAVJFs+mhxuiQO+RBnFr9j3qusvFk+hrCgTPf/6rGAJlvKchxgKv3iMSKWn8EEqzOm2yceBtzb3qK4hFISXkgZRm10DpCBs+I1kROe895PiRUTOefNqbhcErDxqxNUzVirjyLQhcZW/biEjDX6qcXkycRgfKK6SHpptiqV/+zrQOPU66aUSEeFWY3qeGOASo4VtRuPm9o1tYcwR4XVv9/e4Z+cew==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc70645-623e-46a1-f3f1-08d8155e9a36
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2020 21:12:13.3043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCea/rHGB0VdDVYQnf7PgEsxQzuqD2x6jNE4MVpdRRzdXXSpfTOyLuYZb6BQKF/8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2871
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-20_13:2020-06-19,2020-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=7 bulkscore=0 mlxlogscore=999 spamscore=0
 cotscore=-2147483648 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006200159
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 02:00:18PM -0700, Andrew Morton wrote:
> On Sat, 20 Jun 2020 14:47:19 -0400 Waiman Long <longman@redhat.com> wrote:
> 
> > It was found that running the LTP test on a PowerPC system could produce
> > erroneous values in /proc/meminfo, like:
> > 
> >   MemTotal:       531915072 kB
> >   MemFree:        507962176 kB
> >   MemAvailable:   1100020596352 kB
> > 
> > Using bisection, the problem is tracked down to commit 9c315e4d7d8c
> > ("mm: memcg/slab: cache page number in memcg_(un)charge_slab()").
> > 
> > In memcg_uncharge_slab() with a "int order" argument:
> > 
> >   unsigned int nr_pages = 1 << order;
> >     :
> >   mod_lruvec_state(lruvec, cache_vmstat_idx(s), -nr_pages);
> > 
> > The mod_lruvec_state() function will eventually call the
> > __mod_zone_page_state() which accepts a long argument.  Depending on
> > the compiler and how inlining is done, "-nr_pages" may be treated as
> > a negative number or a very large positive number. Apparently, it was
> > treated as a large positive number in that PowerPC system leading to
> > incorrect stat counts. This problem hasn't been seen in x86-64 yet,
> > perhaps the gcc compiler there has some slight difference in behavior.
> > 
> > It is fixed by making nr_pages a signed value. For consistency, a
> > similar change is applied to memcg_charge_slab() as well.
> 
> This is somewhat disturbing.
> 
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -348,7 +348,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
> >  					     gfp_t gfp, int order,
> >  					     struct kmem_cache *s)
> >  {
> > -	unsigned int nr_pages = 1 << order;
> > +	int nr_pages = 1 << order;
> >  	struct mem_cgroup *memcg;
> >  	struct lruvec *lruvec;
> >  	int ret;
> > @@ -388,7 +388,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
> >  static __always_inline void memcg_uncharge_slab(struct page *page, int order,
> >  						struct kmem_cache *s)
> >  {
> > -	unsigned int nr_pages = 1 << order;
> > +	int nr_pages = 1 << order;
> >  	struct mem_cgroup *memcg;
> >  	struct lruvec *lruvec;
> >  
> 
> I grabbed the patch, but Roman's "mm: memcg/slab: charge individual
> slab objects instead of pages"
> (http://lkml.kernel.org/r/20200608230654.828134-10-guro@fb.com) deletes
> both these functions.

It looks like Waiman's patch should be backported to stable.
So if you can queue it before my series, that would be nice.

> 
> It replaces the offending code with, afaict,
> 
> 
> static inline void memcg_slab_free_hook(struct kmem_cache *s, struct page *page,
> 					void *p)
> {
> 	struct obj_cgroup *objcg;
> 	unsigned int off;
> 
> 	if (!memcg_kmem_enabled() || is_root_cache(s))
> 		return;
> 
> 	off = obj_to_index(s, page, p);
> 	objcg = page_obj_cgroups(page)[off];
> 	page_obj_cgroups(page)[off] = NULL;
> 
> 	obj_cgroup_uncharge(objcg, obj_full_size(s));
> 	mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
> >>>			-obj_full_size(s));
> 
> 	obj_cgroup_put(objcg);
> }
> 
> -obj_full_size() returns size_t so I guess that's OK.
> 
> 
> 
> Also
> 
> 
> static __always_inline void uncharge_slab_page(struct page *page, int order,
> 					       struct kmem_cache *s)
> {
> #ifdef CONFIG_MEMCG_KMEM
> 	if (memcg_kmem_enabled() && !is_root_cache(s)) {
> 		memcg_free_page_obj_cgroups(page);
> 		percpu_ref_put_many(&s->memcg_params.refcnt, 1 << order);
> 	}
> #endif
> 	mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
> >>>			    -(PAGE_SIZE << order));
> }
> 
> PAGE_SIZE is unsigned long so I guess that's OK as well.
> 
> 
> Still, perhaps both could be improved.  Negating an unsigned scalar is
> a pretty ugly thing to do.
> 
> Am I wrong in thinking that all those mod_foo() functions need careful
> review?
> 

I'll take a look too.


Thanks!
