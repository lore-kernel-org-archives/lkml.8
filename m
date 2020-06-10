Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A90C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FBDB206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CF/wuS5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgFJLCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgFJLCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:02:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F49C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:02:18 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u26so4378555wmn.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7rhDhb7XG1irEJ3s4PZgrsrHfWLraefC8nvpXB2M8Mc=;
        b=CF/wuS5VIaKoRFRb1edURv8iEQYjyR3CNEeytRlAMvA21wqwMjjYcRQRDMcvSaZUt5
         sIxLF4nAiFukzYUzqFoM9F0M6EEuJnIeUdTzfS0wbtKfeKBl+oMFBvPxFZSnGFuGTJLn
         SLTnN0OH3CuV5KXtb4twhKhkNGT2rkhLsQdYrg4ECSvDpDw3KYMeiCGxsBnH7TBD/r9B
         VzJkPzGsPN92P+dzDdnjqTGCgJtXDQyDWZZlbW01anZrpC2hZ6eMvX8D1mJRHzoVfodx
         i01NcDUjuR3gVvm8teMjg8uDLv1MVDoe2pkZwjgDi1Sx4EmzwBMadua3PgiovyaVXVdW
         VbvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rhDhb7XG1irEJ3s4PZgrsrHfWLraefC8nvpXB2M8Mc=;
        b=kJ+pnEzAr4hE/Bq0uYfNIFffYum64KfhgH/00yV62A6zix2e3c+2KzuGQIGJzLo9Ag
         moxJ9Qdy9ehR4kxygieCHMrIDkt2t6hvdfp5lp0q+bSzUIGZOBAAcXUCZOra/gdVfkdW
         wEHi3kU6AzZYpxFEclpAt2F01aocidP5IEBOXpb8mumZPXBfetV7BTJZOq5Yvxs4g8ND
         zm4UDUtEkgj7/nwG84oSf3zEnrgpu+AwdJMpEfg/LqnVa71OQC8NdCkyXXzyeqqjC80G
         hp54gJxbGHMnBe662RQgf6DHzDxk0Uc7BFUmeUD6a7HtmM8zzesuaawyQ0li4tRtkPZY
         H3uA==
X-Gm-Message-State: AOAM531e9h2QSD5nx+XogTXw/b/7eVpLbrctKvyKWHC8qYQG25XOe8KF
        nFPH4bi50ux9tyPWzXOuihUFPVFWU9jeyFxhaclgQg==
X-Google-Smtp-Source: ABdhPJxWkdQzPjV7iJo60NGhf0b8aUxJU7l5zHaNMqK0GiMoKSAB8Ny3tlpYWzYCUR5SkGOV1LyzRNZv8bHwF8oZDuo=
X-Received: by 2002:a1c:2082:: with SMTP id g124mr2706952wmg.21.1591786936358;
 Wed, 10 Jun 2020 04:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200610052154.5180-1-cai@lca.pw> <CACT4Y+Ze=cddKcU_bYf4L=GaHuJRUjY=AdFFpM7aKy2+aZrmyQ@mail.gmail.com>
In-Reply-To: <CACT4Y+Ze=cddKcU_bYf4L=GaHuJRUjY=AdFFpM7aKy2+aZrmyQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 10 Jun 2020 13:02:04 +0200
Message-ID: <CAG_fn=X-da3V0OC-Bzd2rmkNuZ_bVpH_n7Sp5P_hSGXD4ryyBA@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: silence a KASAN false positive
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 7:55 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Jun 10, 2020 at 7:22 AM Qian Cai <cai@lca.pw> wrote:
> >
> > kernel_init_free_pages() will use memset() on s390 to clear all pages
> > from kmalloc_order() which will override KASAN redzones because a
> > redzone was setup from the end of the allocation size to the end of the
> > last page. Silence it by not reporting it there. An example of the
> > report is,
>
> Interesting. The reason why we did not hit it on x86_64 is because
> clear_page is implemented in asm (arch/x86/lib/clear_page_64.S) and
> thus is not instrumented. Arm64 probably does the same. However, on
> s390 clear_page is defined to memset.

Can we define it to __memset() instead?
__memset() is supposed to be ignored by KASAN, e.g. KASAN runtime uses
it in the places where we don't care about bugs.
