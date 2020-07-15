Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAF4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83EDD20658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="EWwLkljz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGOP4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgGOP4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:56:18 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D785C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:56:18 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w2so3273811pgg.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VoLrAtt1VyxuFNU8R+bL89rZwqBhfdjM3HwRVlNo+Sg=;
        b=EWwLkljz1VAM7yL27jdXj31g9KL4DV/W+V32rYb7qrevaLYYLinozQdpR6f0DJVC7W
         NBt/g0/RJs44i1CYCqPFyL4YSJhgXu+LDp7VhUJRQMKi/rcmcWNomspHlxE+RDZgIscf
         7dGi8dIzEYzm25OK1Seqoi4zjh+niQ70jVGh3HEQdPoIbJWkBeif8fD9UPLdEFAN1pqZ
         qiahVa0hqI2ZDeh8ROJkgaq5Osn0QYnrKHAvG0tVQUBq4lW4IKRxrh+sC2WqNc/qY8Vw
         v5yb5yhDdTtjytfM/q3IwdtK1DEsGmBhvW1gqQN1pxBdtmSC5HPlr7bfE9typ0scTTmO
         Bc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VoLrAtt1VyxuFNU8R+bL89rZwqBhfdjM3HwRVlNo+Sg=;
        b=r82Ri3TdkuLgHgKUhrg1om+ovP7L0OvjMGOlq+IfbUwGKNb8IIgBc4MjCzDVRcjWqE
         LYWgF2KwomnCIH7rcbn2zrhs8nNbPfneKrWbOs9BW2DFqtUp2Qqh+S5d8LpMJZI3ZmjB
         sUhtRED/Vwnr3pAZK+/Rao5Y1PRBH2Ijl5LBvOnIQeuh1Ye3Z5LnGaHtBOr2eqE9c59d
         xzERus9CL5LnAvFHWOvjLN7nLnOqBGIBecMh1XNSYs/RZ/YwPlWxiJMCfXJ2O4ySaayM
         c6z7D/s/iap8FotVUE5tsI4H4WMbaAleIXn/lXxPyJ4iTFx0a3p73LhfCC0g5ySQEQep
         zgDg==
X-Gm-Message-State: AOAM530ygEBZDYICp3Zqehi6ol4bjg0cyEabZKd6NHb0ztAA89JhoIO9
        evUTbZdgsBvyj8R7GGrf/5yTso3KLmVrrkafk1Q5Kw==
X-Google-Smtp-Source: ABdhPJzATAq/QWB7Ymlgx30NYeVFKy3oLTmS3TSJDTGy8g96MJaUiFfFEyKVmbp43RB1/CiM+nsS0iqHGdg9fDO1Z9M=
X-Received: by 2002:a63:cf49:: with SMTP id b9mr308979pgj.31.1594828577905;
 Wed, 15 Jul 2020 08:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200707062754.8383-1-songmuchun@bytedance.com>
 <3d06418e-e75c-e7b8-91cd-ba56283045be@suse.cz> <CAMZfGtXK9yQOJy7BPnTBzhG4tithRs=9R4O3rDg1Rjz0zUFKnQ@mail.gmail.com>
 <4c1bba23-56c5-f69c-28cb-48dd3db30880@suse.cz>
In-Reply-To: <4c1bba23-56c5-f69c-28cb-48dd3db30880@suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 15 Jul 2020 23:55:42 +0800
Message-ID: <CAMZfGtVEiUmQYX61MT_oCymac+idXy16U8bAQoV21HcFrVXCxg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5.4.y, v4.19.y] mm: memcg/slab: fix memory
 leak at non-root kmem_cache destroy
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 11:43 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 7/15/20 5:13 PM, Muchun Song wrote:
> > On Wed, Jul 15, 2020 at 7:32 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> On 7/7/20 8:27 AM, Muchun Song wrote:
> >> > If the kmem_cache refcount is greater than one, we should not
> >> > mark the root kmem_cache as dying. If we mark the root kmem_cache
> >> > dying incorrectly, the non-root kmem_cache can never be destroyed.
> >> > It resulted in memory leak when memcg was destroyed. We can use the
> >> > following steps to reproduce.
> >> >
> >> >   1) Use kmem_cache_create() to create a new kmem_cache named A.
> >> >   2) Coincidentally, the kmem_cache A is an alias for kmem_cache B,
> >> >      so the refcount of B is just increased.
> >> >   3) Use kmem_cache_destroy() to destroy the kmem_cache A, just
> >> >      decrease the B's refcount but mark the B as dying.
> >> >   4) Create a new memory cgroup and alloc memory from the kmem_cache
> >> >      A. It leads to create a non-root kmem_cache for allocating.
> >> >   5) When destroy the memory cgroup created in the step 4), the
> >> >      non-root kmem_cache can never be destroyed.
> >> >
> >> > If we repeat steps 4) and 5), this will cause a lot of memory leak.
> >> > So only when refcount reach zero, we mark the root kmem_cache as dying.
> >> >
> >> > Fixes: 92ee383f6daa ("mm: fix race between kmem_cache destroy, create and deactivate")
> >> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>
> >> CC Roman, who worked in this area recently.
> >>
> >> Also why is this marked "[PATCH v5.4.y, v4.19.y]"? Has it been fixed otherwise
> >> in 5.5+ ?
> >
> > Because the memcg slab/slub is reworked by Roman since v5.8.
>
> That rework is in mmotm, so scheduled for 5.9, AFAIK. If you mean "The new
> cgroup slab memory controller" series.

Yeah, I mean "The new cgroup slab memory controller".

>
> > Therefore, this problem exists in v5.7 and below.
>
> Even 5.7 has a stable series, so no need to list only the LTS's.
> To sum up, the patch (once reviewed) should be queued for mainline as usual,
> perhaps sent before 5.8 is final, if deemed safe enough, and with added
>
> Cc: <stable@vger.kernel.org>
>
> and the Fixes: tag you provided, the applicable stable versions will pick it.

Got it. Thanks.

>
> Vlastimil



-- 
Yours,
Muchun
