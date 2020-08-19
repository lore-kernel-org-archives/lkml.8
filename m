Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57713C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 01:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391542078B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 01:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E80VCHyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgHSBNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 21:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgHSBND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 21:13:03 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31782C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 18:13:03 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id cq28so16753246edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 18:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kva/k1UFU9lX2N7TTtpIgvJkFqnuUIPtW/9Hq387vwc=;
        b=E80VCHyqzl3gqdes4ecq90ED7Teoc8Dly2yf/OW0+jZosjYQ4+6IbmLNkza5ENUV9a
         00LaDl0rnvLZt0T5tfVqRCNtSE/Yh9uc6E9qUIp+85Ib+GYsKoV6YQWx7z68iwkuMKq1
         uYDb1yLguz82kKnD0amyvpIB/Lkwomyrz4KElJuECYSvodnqlEHSInELcYYMFUr/mk3v
         tANj3qbpj3nRf7thLtCmPp+/OC6WpjkgRG03JKejP4BapuV3GDWK4MzisB2zyv097I8P
         l1aZBFgoeDfOYzZUoK+Wf413zbD4QjmhOqvJnHuJ7IkXHgeGhK94aXq4gd0Q2nYEuYnh
         tUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kva/k1UFU9lX2N7TTtpIgvJkFqnuUIPtW/9Hq387vwc=;
        b=pQQM2dfLXgzZLXnTA6G4+RhGe/iTuF+u9Ugdfu2u1PWAXyDS3EAlWlVsHggET9m3nX
         cR4qEc795aYrtkkRgwzPAzoQ+wQnZ153AMhUjjeS5NA1OxW6OHIgw3OJnC0GdPTDYLZi
         M/yTljEyOOnc2wYfeEmk3dGsh0OhDFsNV+KyF1tBZSiyHO71RGrqvGojMC+x6v7ebc8v
         F7VqEH5W6VZ3nMjFZthk1zuo2vom+8E6GAvEn/QJNGhVeIy4M3IsdMCX0pgaGdwAhaFA
         RDr+hz/WBLFxPqRMl1P1jn/dqfO+IYOzUeUvhjbjuVJr82mG3Wq33PWJdUKyqps9jtlc
         nGLQ==
X-Gm-Message-State: AOAM531qFPl/w5/EuxtR0cZRzL8gpRqJJSNi7kRFerJAbDhS+uVraWPB
        YxXzjVubl20aTnoRKXv71If1fI6sisHWj59W/3A=
X-Google-Smtp-Source: ABdhPJw/E2soj0fKW/huWNagmPnn6FvooCTxqFBO86xFYeA9eId5qxqcTlM7QtwRbaUuORA3KNbPfZXftYphQAe6stY=
X-Received: by 2002:a05:6402:2069:: with SMTP id bd9mr21969357edb.127.1597799581776;
 Tue, 18 Aug 2020 18:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200817161132.GA4711@amd> <CAHk-=wh6_eWwvpL=AhOeY0btf_dkpu+0joNzPZWfbBWgAeAhMA@mail.gmail.com>
In-Reply-To: <CAHk-=wh6_eWwvpL=AhOeY0btf_dkpu+0joNzPZWfbBWgAeAhMA@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 19 Aug 2020 11:12:50 +1000
Message-ID: <CAPM=9tw8LVWsuA6m_nkUDgm00iz2txYRNZY0b0WWZbyiUVzLEw@mail.gmail.com>
Subject: Re: [Intel-gfx] 5.9-rc1: graphics regression moved from -next to mainline
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 at 10:38, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ping on this?
>
> The code disassembles to
>
>   24: 8b 85 d0 fd ff ff    mov    -0x230(%ebp),%eax
>   2a:* c7 03 01 00 40 10    movl   $0x10400001,(%ebx) <-- trapping instruction
>   30: 89 43 04              mov    %eax,0x4(%ebx)
>   33: 8b 85 b4 fd ff ff    mov    -0x24c(%ebp),%eax
>   39: 89 43 08              mov    %eax,0x8(%ebx)
>   3c: e9                    jmp ...
>
> which looks like is one of the cases in __reloc_entry_gpu(). I *think*
> it's this one:
>
>         } else if (gen >= 3 &&
>                    !(IS_I915G(eb->i915) || IS_I915GM(eb->i915))) {
>                 *batch++ = MI_STORE_DWORD_IMM | MI_MEM_VIRTUAL;
>                 *batch++ = addr;
>                 *batch++ = target_addr;
>
> where that "batch" pointer is 0xf8601000, so it looks like it just
> overflowed into the next page that isn't there.
>
> The cleaned-up call trace is
>
>   drm_ioctl+0x1f4/0x38b ->
>     drm_ioctl_kernel+0x87/0xd0 ->
>       i915_gem_execbuffer2_ioctl+0xdd/0x360 ->
>         i915_gem_do_execbuffer+0xaab/0x2780 ->
>           eb_relocate_vma
>
> but there's a lot of inling going on, so..
>
> The obvious suspect is commit 9e0f9464e2ab ("drm/i915/gem: Async GPU
> relocations only") but that's going purely by "that seems to be the
> main relocation change this mmrge window".

I think there's been some discussion about reverting that change for
other reasons, but it's quite likely the culprit.

Maybe we can push for a revert sooner, (cc'ing more of i915 team).

Dave.
