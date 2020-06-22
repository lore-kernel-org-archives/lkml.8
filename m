Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF046C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60C82076A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ghlyKfPW";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Wb3QIWi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbgFVVPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:15:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64542 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730295AbgFVVPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:15:11 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MLAeXa017603;
        Mon, 22 Jun 2020 14:14:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=eqPuHQ/AHnDRgXYhyFw+u4vzG2AfCNFTV8EKl40fIHQ=;
 b=ghlyKfPWy7jSx6NPquQndVkz3smhQmzmd/D5+fa7zw0nczYWFzMPS/I/MhprRqAEYZhP
 qYYHaVHA8NrwDxHPzJn/eSzNPyDSUi7d92U+27Amy1sVIm5ejzl1QL25INmS8CjFFtkd
 w/M+XR5Qm6OVNKwJEOHEofXU48w3R4ATzmc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31sfyktcst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Jun 2020 14:14:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 14:14:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvInoHNYyIRWYRJav7wnlYer30p4D7vAKDWCsINyUa3a8jvcNRXx+0U97deSwAJ3euA6E9yVcAbN2fb1Ma4MdbLNp3lib/khy8KPPNDN1k/B8Bm16IE1RBZhpuVGgkRtAAY2Bj03XfKeBXDH8k+iJfb0qSSI3FPZZNVAkamb/aHjgpifsnAk8jaqYWC3GfbnUJEozpWZLsPSx70T/5bMp51P6aHv0h6qxb44hdSQSKEAhFGOvCi3cJnn9ee79UOLXI9PNMafuY1I0UPy8N3BoJM9Mja6PXG2D4LiC63F9mr8gs0gH0X+idYjbqt2R7OPo7IUpfscxsuRaYEe/0YuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqPuHQ/AHnDRgXYhyFw+u4vzG2AfCNFTV8EKl40fIHQ=;
 b=PHbZ+6iTJJfkOA0wJ5Il5adwGHanKbn0UNhfprccphaLILVQoAK2GCep5hFKgxDmy9FlP3Wq5NoztOisUIjQtP4vKEAUZoU1d0VNEbnFRLsEHWuUs5FXwGhXKwif6ILc6zlj883GqsjbByDI9sotmT2T06UHO3XD9rshUn68veb6T1AS4Osgb4qfQpHTRrBYV4lNpq5vXe9PwDia+CF7cigdMI9ECRqFZaiu1rrT/HacmrO0I1WMpzP7K9zm7ADD9mp7lEd8dKwtEOKCUjVv7HKBFedzt/UZHeyEkFAxszKOuok5VYsUCqF2D6rqzBjCytrTSDXHex/J/+11FwHnXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqPuHQ/AHnDRgXYhyFw+u4vzG2AfCNFTV8EKl40fIHQ=;
 b=Wb3QIWi1yUAkFin+k7y4VQEJzKR+xJwjuxse+MNTpsEalO9OLzUjHnjejk314KxsghKiGtBHXboRBFTZL+6rAOxuMOkB+RbZpikwkQEKbFUe/sYyRbSLoU8VDflZxlQDKH08eDYNuyAUyL6WXJ7fyY83scaElHj8bNG4g6lBaQ0=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2664.namprd15.prod.outlook.com (2603:10b6:a03:15a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 21:13:58 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 21:13:58 +0000
Date:   Mon, 22 Jun 2020 14:13:56 -0700
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
Subject: Re: [PATCH v6 17/19] mm: memcg/slab: use a single set of kmem_caches
 for all allocations
Message-ID: <20200622211356.GF301338@carbon.dhcp.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-18-guro@fb.com>
 <CALvZod5NCCpt2rkyXXr69OnVXb9ew7875vAV=iWZdqJhXcKEWQ@mail.gmail.com>
 <20200622203739.GD301338@carbon.dhcp.thefacebook.com>
 <CALvZod5powO1Zph0+iO+=gtNb7=MQqfHwYkdb-+PkaVCGhuf=g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5powO1Zph0+iO+=gtNb7=MQqfHwYkdb-+PkaVCGhuf=g@mail.gmail.com>
X-ClientProxiedBy: BYAPR08CA0067.namprd08.prod.outlook.com
 (2603:10b6:a03:117::44) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:c7f8) by BYAPR08CA0067.namprd08.prod.outlook.com (2603:10b6:a03:117::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 21:13:58 +0000
X-Originating-IP: [2620:10d:c090:400::5:c7f8]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05852074-3bc3-4352-0694-08d816f12ddf
X-MS-TrafficTypeDiagnostic: BYAPR15MB2664:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB26648F786A3E90F9BECFF573BE970@BYAPR15MB2664.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p8Cg94f56GU0BPyrap5uvUxnDmgd55CJBeznHuIOvFxAHPyT/MCzClibx4xqbq3NZMGzwBX2k/W+kMlEuvpZcWPV1mOXuMYHztGGP1/yLMwZZ8a/Hub6Rv0TKiClEesArAH2zM3pF2ceQsteGxJ/v0gZlBnjUYMfqW4JywVlAEfFsZizl8edKwwlp3/8untw9PAuyzu0DTE3VZTvEHplQblC/P8K5UWS/F6SXbcJn4UhjUKiB/tUZ4hCTB5eDyGsZnCwwCWCtH9Izudg7zctPRsIF/u0yTGmawchcrF1jCYT2pUNKLxIKm/lcj/37KYGgHo46cNXY9Oj36mZD9vL0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(366004)(396003)(39860400002)(86362001)(6916009)(8936002)(1076003)(5660300002)(8676002)(66476007)(83380400001)(33656002)(66946007)(66556008)(16526019)(186003)(6506007)(53546011)(4326008)(2906002)(9686003)(55016002)(478600001)(52116002)(316002)(7696005)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: fwkF7/NdA0LVaMh7IKH1XjIQV6k+3tgoQDR4dcFeBBpwQDG8xrwgptgJTd1ztPqQdQyCGmAeSLbHuZFk2u1RzC4lOSwtK30XMgIebT2sSni/J2MzNvGu0+UA6+bcA+wE0gqd8dS9efuPYL2M0voc9GPzBKVGSH4o1Erk/5dM0C7EdWRsqjJk8wg0xQt/di24dkEs0WLhh3QFkFtGuiWkRRsE5AQijygILDoE1kKcqRuea/lRSOFpPEkTw6tIQXMrcGkY74LxuHllLUabxQGStZH7itJrQz7iokhbxMJh3Hsh6Rk3C9j0vqfsS9ZxJfMbDepWT/owsvIpIkDfmZH5P5dZZJ0ox0WFLobJMv/fM31VRa4X6Dj6GsET6DjrQieWIqFNKbeS9pv3lond5xfKB6SlHXljOfoX3TB4gnK+Cro1PsGoXu8O9E9t8/PMgbqwOccPP8XgGzvy49sT3EfvIWsIuTJdxFxyO5eAL1LdZvVdywEJFr7J88cvnL793jG7Eq9TirzMNAz4knhE6ZCEpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 05852074-3bc3-4352-0694-08d816f12ddf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 21:13:58.7406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4y8oosNWv59epo8Vh5sU0LLX9PH9/M+lOgQ6lmk42dGKoydGvGZQ88ES8OTZG+q0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2664
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_12:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=1 adultscore=0 cotscore=-2147483648 impostorscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=792 spamscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220137
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 02:04:29PM -0700, Shakeel Butt wrote:
> On Mon, Jun 22, 2020 at 1:37 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Mon, Jun 22, 2020 at 12:21:28PM -0700, Shakeel Butt wrote:
> > > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > Instead of having two sets of kmem_caches: one for system-wide and
> > > > non-accounted allocations and the second one shared by all accounted
> > > > allocations, we can use just one.
> > > >
> > > > The idea is simple: space for obj_cgroup metadata can be allocated
> > > > on demand and filled only for accounted allocations.
> > > >
> > > > It allows to remove a bunch of code which is required to handle
> > > > kmem_cache clones for accounted allocations. There is no more need
> > > > to create them, accumulate statistics, propagate attributes, etc.
> > > > It's a quite significant simplification.
> > > >
> > > > Also, because the total number of slab_caches is reduced almost twice
> > > > (not all kmem_caches have a memcg clone), some additional memory
> > > > savings are expected. On my devvm it additionally saves about 3.5%
> > > > of slab memory.
> > > >
> > > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > > ---
> > > [snip]
> > > >  static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> > > >                                               struct obj_cgroup *objcg,
> > > > -                                             size_t size, void **p)
> > > > +                                             gfp_t flags, size_t size,
> > > > +                                             void **p)
> > > >  {
> > > >         struct page *page;
> > > >         unsigned long off;
> > > >         size_t i;
> > > >
> > > > +       if (!objcg)
> > > > +               return;
> > > > +
> > > > +       flags &= ~__GFP_ACCOUNT;
> > > >         for (i = 0; i < size; i++) {
> > > >                 if (likely(p[i])) {
> > > >                         page = virt_to_head_page(p[i]);
> > > > +
> > > > +                       if (!page_has_obj_cgroups(page) &&
> > >
> > > The page is already linked into the kmem_cache, don't you need
> > > synchronization for memcg_alloc_page_obj_cgroups().
> >
> > Hm, yes, in theory we need it. I guess the reason behind why I've never seen any issues
> > here is the SLUB percpu partial list.
> >
> > So in theory we need something like:
> >
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 0a31600a0f5c..44bf57815816 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -237,7 +237,10 @@ static inline int memcg_alloc_page_obj_cgroups(struct page *page,
> >         if (!vec)
> >                 return -ENOMEM;
> >
> > -       page->obj_cgroups = (struct obj_cgroup **) ((unsigned long)vec | 0x1UL);
> > +       if (cmpxchg(&page->obj_cgroups, 0,
> > +                   (struct obj_cgroup **) ((unsigned long)vec | 0x1UL)))
> > +               kfree(vec);
> > +
> >         return 0;
> >  }
> >
> >
> > But I wonder if we might put it under #ifdef CONFIG_SLAB?
> > Or any other ideas how to make it less expensive?
> >
> > > What's the reason to remove this from charge_slab_page()?
> >
> > Because at charge_slab_page() we don't know if we'll ever need
> > page->obj_cgroups. Some caches might have only few or even zero
> > accounted objects.
> >
> 
> If slab_pre_alloc_hook() returns a non-NULL objcg then we definitely
> need page->obj_cgroups.  The charge_slab_page() happens between
> slab_pre_alloc_hook() & slab_post_alloc_hook(), so, we should be able
> to tell if page->obj_cgroups is needed.

Yes, but the opposite is not always true: we can reuse the existing page
without allocated page->obj_cgroups. In this case charge_slab_page() is
not involved at all.

Or do you mean that we can minimize the amount of required synchronization
by allocating some obj_cgroups vectors from charge_slab_page()?
