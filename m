Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4543C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B058820716
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmiiafxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgFWFZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 01:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgFWFZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 01:25:30 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68783C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 22:25:29 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g2so10978457lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 22:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJGdd4T1mBh6VgSImvcGDguOX2vlHVdKbQpgCLbiU9k=;
        b=RmiiafxLLKP875OzgpqZ62/Lueewk4AOM3UHierW9MmyLuFOgunQuv2x7ggwJzDS7L
         DqNGoKesY5Am1qhK++Bjesr+thJEeWpG84HNpPFd0faqO5GFMEDVBhZ1Lf2CaZ1USRfx
         2xPufwx2D+kbwV3Q+dFzpaJWkMjW6uyJsdKAFqXba5DBffD2fXJfED/K0QUUY3X3Md34
         3Ztm7/3pga7dWeEZZc7e5AmpDM9WpU7xcwhkCHKnMcypmeHY/AvNbpAQPmRxDtKBkZGM
         u3ZTnFsaC+eJg9b1CORgGXjO1Ri2e3wCTT1gyC/uyyXGTTvNr4Dr9WCn481BkzJr+ATE
         LgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJGdd4T1mBh6VgSImvcGDguOX2vlHVdKbQpgCLbiU9k=;
        b=OPX6bGd3Qziay8ESh7DPlugp//YZBE9glcxkSlsiQ7oD7bJN6yadznXoDGJF0UKNDE
         c7d3viww/0GlzuQcxjCp3wNPqNVIQPKHsW0GXKogKRmt8IvmZxKFFoWQB44oYOm+GZ7n
         THt7ntMWAZ181hnbiMIT6axh5NmYbqiPQsSjsZcB0bU2hQClBlPQpRQv9I2NWNdnQvoE
         pOqL2Ul7MC6g6o9gWFQsv6tOv94umhnwP87gvR9VT5my+D5WnOU+XFjew6r9WipZf5l+
         5oAx723a3aDloZZ4pv2dctU7gPmJdojepqdncjfoiIEkxUNqLXv1yxCszhSFuu6bq3QX
         nCVQ==
X-Gm-Message-State: AOAM530BYJTgipw67lnZIAm1AjCRcKDS8Xu0eb/6nA/ejeay5gbQsTax
        eUmox40zcFT9Y5CjNOFrqPHH6H6uYovD1TPitWqljw==
X-Google-Smtp-Source: ABdhPJz9eBvD8p4BLTBmgJcnnsG76Z1d+HAQFe3qCicUvtbVRXv3IGAHF/rmFO0b3XgwG555GId3UUY2FgJSjUj1C6s=
X-Received: by 2002:a19:11:: with SMTP id 17mr11756487lfa.125.1592889927504;
 Mon, 22 Jun 2020 22:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200623015846.1141975-1-guro@fb.com> <20200623015846.1141975-18-guro@fb.com>
In-Reply-To: <20200623015846.1141975-18-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Jun 2020 22:25:16 -0700
Message-ID: <CALvZod7B3Xw4n9jY-+m-z7-iQ+5uE_WKKOo9YHk4s+ebOyCk5g@mail.gmail.com>
Subject: Re: [PATCH v7 17/19] mm: memcg/slab: use a single set of kmem_caches
 for all allocations
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 6:58 PM Roman Gushchin <guro@fb.com> wrote:
>
> Instead of having two sets of kmem_caches: one for system-wide and
> non-accounted allocations and the second one shared by all accounted
> allocations, we can use just one.
>
> The idea is simple: space for obj_cgroup metadata can be allocated on
> demand and filled only for accounted allocations.
>
> It allows to remove a bunch of code which is required to handle kmem_cache
> clones for accounted allocations.  There is no more need to create them,
> accumulate statistics, propagate attributes, etc.  It's a quite
> significant simplification.
>
> Also, because the total number of slab_caches is reduced almost twice (not
> all kmem_caches have a memcg clone), some additional memory savings are
> expected.  On my devvm it additionally saves about 3.5% of slab memory.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
