Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F27C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0BD82076A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="e2BMbFDo";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Q10edHGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbgFVV6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:58:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41182 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbgFVV6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:58:21 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MLoHXn024162;
        Mon, 22 Jun 2020 14:58:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=0QzbNMOm6LaFQ+3iNqdK9II2eZ2Z52nVHm4OxEw4U88=;
 b=e2BMbFDo5A0LHA49PtHE3uDqHlBcH/4GU82eQWeSsj7hCVx/ulYawHQHd9ELNWb/Uy/z
 7vjQaHHn2Ls8M7Uwc7774zj6XhPO6YoOchUKaGuSxm2ieX4N97tlcwrpQIMsklXHw+b9
 pJ/u+eNX42PPhduJpuPY8GtKJEhHKzk2fzA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31sfyktjaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Jun 2020 14:58:08 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 14:58:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aztIpEforZbtHElC+FYq6wEYBucSdSUyO3GUCAl/SkWsP3teasGNCKwOGxzgeDayD16FRaNpmdFo1k55iKjWrGsfJ7y8qe7Sz1pXNRmQLB851C/EjBva/lJ+LvAPxgBcdkpAvVYb3IZH+TBY0OiWjV2wDMc1Y5FjtrChEwF/vjS0KaAYyn0f1BbPci/WJ6kUcJjxK4HtjUD4CuGo+jov7hiD6HHlWGA6+M5ahPa89rX/GoIrxP02CvS9neTipz5CGW9WRnPJBLvzKzZTBtIHRK8rx+k037QRQ4a8zvujieMWRoPhMBAlz+lUtRPBgEJMlL0bKH6Huju7OnByY33Vrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QzbNMOm6LaFQ+3iNqdK9II2eZ2Z52nVHm4OxEw4U88=;
 b=LJDD5nTT6fGnCNzQpIqmf2XHLy5M1x510rdCokGkVYStXULSsc3iqCNSM22PwLIW50ydncq2SDIQinysFKrJGwkeJGHdnK4uuVPH4GomUnbquEgfDiNMqwEji1VQ65UbDNz3HpTl/dQRLFpTrxpP1iOvyXyPwr6wE8xK7KclA2hoslTtJv9EdQ01thtrIVuO32Aj1JQJZZVF7ztE6etm/bRHScyj5x0obB2IFeBdgvWv/nZTVxLmP5w1qz4ICCqa7WbIAqxMBlGf7it6Zc8uewS4rwgb2nMQUBK3PPtxVAiKqPCpRrwMYka8KCJm72BbrFFtGwxxTiVFVlsao5d4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QzbNMOm6LaFQ+3iNqdK9II2eZ2Z52nVHm4OxEw4U88=;
 b=Q10edHGLFLnyNzuKSlHBbFrd6c9gB8AgknsNYjPXRyCuX7cungT/hUmdSzLNP/PoK0gXUAD2zxRqj6KKRE71v84yu4TcDhy/GWp+zvsi8TfJThV7gV9eyptnTaWEEkWv7CM+bj8aMsqWLa/72SC5QPsJy7EbKzknKQNi4cEvGp4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3682.namprd15.prod.outlook.com (2603:10b6:a03:1fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 21:58:03 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::48e3:c159:703d:a2f1%5]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 21:58:03 +0000
Date:   Mon, 22 Jun 2020 14:58:00 -0700
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
Message-ID: <20200622215800.GA326762@carbon.DHCP.thefacebook.com>
References: <20200608230654.828134-1-guro@fb.com>
 <20200608230654.828134-18-guro@fb.com>
 <CALvZod5NCCpt2rkyXXr69OnVXb9ew7875vAV=iWZdqJhXcKEWQ@mail.gmail.com>
 <20200622203739.GD301338@carbon.dhcp.thefacebook.com>
 <CALvZod5powO1Zph0+iO+=gtNb7=MQqfHwYkdb-+PkaVCGhuf=g@mail.gmail.com>
 <20200622211356.GF301338@carbon.dhcp.thefacebook.com>
 <CALvZod4aEgbP-CPd3=dC3922SGiYBdEMCm_tsGt5xZUx1ekTDQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4aEgbP-CPd3=dC3922SGiYBdEMCm_tsGt5xZUx1ekTDQ@mail.gmail.com>
X-ClientProxiedBy: BY3PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:a03:255::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:c7f8) by BY3PR10CA0019.namprd10.prod.outlook.com (2603:10b6:a03:255::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 21:58:02 +0000
X-Originating-IP: [2620:10d:c090:400::5:c7f8]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcdf79d4-2a33-4c62-922b-08d816f7563f
X-MS-TrafficTypeDiagnostic: BY5PR15MB3682:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB3682862B78272BEB53493F7EBE970@BY5PR15MB3682.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rm7hVmQLq1WiKMjC6BA+xUPw12+4wDPB/lQOKxrq2SLgVKs8H9QeAlsT2Uxeby8Exo2uS8h6XFPKikRDWBb905rn/CChufb61aCw1rB0c/vatMoa4WR7flDBvSMqF8wsVfcPgIM4RGoDIMN69w2tZvDpFr4bXk4mqfp2vvF5JjckUYwqMmGttyXPHwd7DPzWoum/XXvYdhpyXgeICbSQZo148iwaEutr7LZ7bnLYYWzrmIEBvh6ri0iBUKdT3C5Yp4cDLHyLRy7ZrM9vOPvoDj+01mO++pwnerKLoD7lJKKs53Eyse21arKeOgH0fZPRTxp2lK5px/vAqst8shT0Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(136003)(376002)(39860400002)(366004)(83380400001)(52116002)(7696005)(86362001)(55016002)(6916009)(33656002)(53546011)(8936002)(5660300002)(6506007)(8676002)(1076003)(16526019)(186003)(316002)(4326008)(54906003)(66556008)(66476007)(66946007)(9686003)(2906002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 1kMhzpqnQexVegSoKCpQvEcLygjQrzkKxeupidnTB4zmUGD/Taey4zOOpN+fglX5LUo0+vw+NjMzw4r/iKhRlwCzHDRjGDBOLY2+qTmJcwH2b7I2qNtSqVKwxvIJZl9Tgv2p9j3Z4a4iEz2qRk/wAewhPuqz5/+NT4hHjY168SjYAKIaOtw00gLwBykVCHdHFusDzPOB4RXv1dehZcGZJMcjr8HIm7tRnBuVyOK/ZPar4/nmCHUeLin/VwsCFy/Izuw2U25fDs8tfNs4uHaiQwYCCVbAD/G8GbX5GKWrzMyAmCsjPXn0rPJzdO1qZPnh2Yl0JO2gk233SDTiMKJVnmCi+r7JH24LR1jsFZbgbCGCNr75CCgZ0wbelp6giNBVxrU8ikTjUGBIJYjYtCDYv67nYd61ZBvFiPw6xbT05hzpePaFDTKcBN7/s1WN6nWY5cO8dPtY/+AL0zrey1fj9pz41ylS3c/hPN9HcLmkg72eQvGMCW/OFUhoVo8MGLo+hRSxWx1erikUDnr5G1sBHQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdf79d4-2a33-4c62-922b-08d816f7563f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 21:58:03.4566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rmh8lEvDsYcHr8iCmNqeEuSYSmMFpM40vPVGsaVNYeGLk0ZtOAChaS/KaoZS3pH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3682
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_15:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=5 adultscore=0 cotscore=-2147483648 impostorscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220141
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 02:28:54PM -0700, Shakeel Butt wrote:
> On Mon, Jun 22, 2020 at 2:15 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Mon, Jun 22, 2020 at 02:04:29PM -0700, Shakeel Butt wrote:
> > > On Mon, Jun 22, 2020 at 1:37 PM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > On Mon, Jun 22, 2020 at 12:21:28PM -0700, Shakeel Butt wrote:
> > > > > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> > > > > >
> > > > > > Instead of having two sets of kmem_caches: one for system-wide and
> > > > > > non-accounted allocations and the second one shared by all accounted
> > > > > > allocations, we can use just one.
> > > > > >
> > > > > > The idea is simple: space for obj_cgroup metadata can be allocated
> > > > > > on demand and filled only for accounted allocations.
> > > > > >
> > > > > > It allows to remove a bunch of code which is required to handle
> > > > > > kmem_cache clones for accounted allocations. There is no more need
> > > > > > to create them, accumulate statistics, propagate attributes, etc.
> > > > > > It's a quite significant simplification.
> > > > > >
> > > > > > Also, because the total number of slab_caches is reduced almost twice
> > > > > > (not all kmem_caches have a memcg clone), some additional memory
> > > > > > savings are expected. On my devvm it additionally saves about 3.5%
> > > > > > of slab memory.
> > > > > >
> > > > > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > > > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > > > > ---
> > > > > [snip]
> > > > > >  static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> > > > > >                                               struct obj_cgroup *objcg,
> > > > > > -                                             size_t size, void **p)
> > > > > > +                                             gfp_t flags, size_t size,
> > > > > > +                                             void **p)
> > > > > >  {
> > > > > >         struct page *page;
> > > > > >         unsigned long off;
> > > > > >         size_t i;
> > > > > >
> > > > > > +       if (!objcg)
> > > > > > +               return;
> > > > > > +
> > > > > > +       flags &= ~__GFP_ACCOUNT;
> > > > > >         for (i = 0; i < size; i++) {
> > > > > >                 if (likely(p[i])) {
> > > > > >                         page = virt_to_head_page(p[i]);
> > > > > > +
> > > > > > +                       if (!page_has_obj_cgroups(page) &&
> > > > >
> > > > > The page is already linked into the kmem_cache, don't you need
> > > > > synchronization for memcg_alloc_page_obj_cgroups().
> > > >
> > > > Hm, yes, in theory we need it. I guess the reason behind why I've never seen any issues
> > > > here is the SLUB percpu partial list.
> > > >
> > > > So in theory we need something like:
> > > >
> > > > diff --git a/mm/slab.h b/mm/slab.h
> > > > index 0a31600a0f5c..44bf57815816 100644
> > > > --- a/mm/slab.h
> > > > +++ b/mm/slab.h
> > > > @@ -237,7 +237,10 @@ static inline int memcg_alloc_page_obj_cgroups(struct page *page,
> > > >         if (!vec)
> > > >                 return -ENOMEM;
> > > >
> > > > -       page->obj_cgroups = (struct obj_cgroup **) ((unsigned long)vec | 0x1UL);
> > > > +       if (cmpxchg(&page->obj_cgroups, 0,
> > > > +                   (struct obj_cgroup **) ((unsigned long)vec | 0x1UL)))
> > > > +               kfree(vec);
> > > > +
> > > >         return 0;
> > > >  }
> > > >
> > > >
> > > > But I wonder if we might put it under #ifdef CONFIG_SLAB?
> > > > Or any other ideas how to make it less expensive?
> > > >
> > > > > What's the reason to remove this from charge_slab_page()?
> > > >
> > > > Because at charge_slab_page() we don't know if we'll ever need
> > > > page->obj_cgroups. Some caches might have only few or even zero
> > > > accounted objects.
> > > >
> > >
> > > If slab_pre_alloc_hook() returns a non-NULL objcg then we definitely
> > > need page->obj_cgroups.  The charge_slab_page() happens between
> > > slab_pre_alloc_hook() & slab_post_alloc_hook(), so, we should be able
> > > to tell if page->obj_cgroups is needed.
> >
> > Yes, but the opposite is not always true: we can reuse the existing page
> > without allocated page->obj_cgroups. In this case charge_slab_page() is
> > not involved at all.
> >
> 
> Hmm yeah, you are right. I missed that.
> 
> >
> > Or do you mean that we can minimize the amount of required synchronization
> > by allocating some obj_cgroups vectors from charge_slab_page()?
> 
> One optimization would be to always pre-allocate page->obj_cgroups for
> kmem_caches with SLAB_ACCOUNT.

Even this is not completely memory overhead-free, because processes belonging
to the root cgroup and kthreads might allocate from such cache.

Anyway, I think I'll go with cmpxchg() for now and will think about possible
optimizations later. Because the allocation happens only once per the lifetime
of a slab page, and is very unlikely racing with a concurrent one on the same page,
the penalty shouldn't be that big.

Thanks!
