Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2825C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 19:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE250206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 19:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592162455;
	bh=OOnqXwNCBJ9kLzw8YsaSmckVTLZFijQ8oadVhzEGspI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JN77YrX9H5PoyDCoVut4Q2G9gYtOuuLut/Jw+8wEwJwH2ND5vbfOWSgvC95mCUAUg
	 zuIYIdFD3nSJ+p/Mb0602a7/xvzNhQo7Z7WiivF2N9Spdo6yI3LnkfrFNg+fl4OG6T
	 mbmSoJQOlQiHCU4LtD4iUM3jQiArEY7cE+FgEV+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgFNTUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 15:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgFNTUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 15:20:52 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84068C08C5C3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 12:20:50 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u16so8251006lfl.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YkTGwKN0ehW6UgG74U5MQE/8rHA2ql2TaHXg1+0uOrI=;
        b=B86RJ5yIdsHeQw1NF5tFw3EA4BEodeMzh/BTlJMf7Hy2cC5soKyh29KcDJszKuXFNm
         9GQC3DN3W1Yyj4HAXH4pOSNrTX+5ETIIyNm2eTLHJU6AfMJp4OF6duVNkmwpqYZ7l8kr
         6DfwIL53hjj0LgWaWs+M6ny80fcmdlssZmgao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YkTGwKN0ehW6UgG74U5MQE/8rHA2ql2TaHXg1+0uOrI=;
        b=dRQ4V2U/ShDVngD/K15khRfQ0+AMWq0mHVc/Ydd1qxm86mYSP4TX6skq2LOs070qK4
         2p6J/jycaEblMW6bkqGQwIDtUxeok3xKrv39wBFg/FPtT+b1h4GOYA8GE/ohnJCFNewb
         +xspQtWITc0wJ5VEgZ3PTE68Xd5q5JjGwgCdNs1qW+P5G0V8qrzXc7gOBa2ElO3xkcE9
         P9Ds57bU54dGS0dEB8i3YPOx3o+askgI2yA+K1jAqeWH1A593KICVNZeu0/Nx7UetOyl
         2KrHh8MSS4Hy5XL2+Wrc/QXfNjhvh/u2ZxEHUsoEQ9Twgw35ibe4f2paTTIANyJLEHlU
         7ASQ==
X-Gm-Message-State: AOAM533HB+Orppj3YerG7lgDmPF2szgU3Egs75B0ETxNFT2O+P6b/H2a
        LMq5UJ95e0gymHX0MpSrDXdPsdGJ4Ng=
X-Google-Smtp-Source: ABdhPJwuT+UyRiYNshUr0jthyQ+fzGKb4Kgoaply+Bbhl1bM0uXtTrG3TY1FuBih2v+/hGHjFU1hog==
X-Received: by 2002:ac2:499a:: with SMTP id f26mr11841967lfl.76.1592162448372;
        Sun, 14 Jun 2020 12:20:48 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id i23sm3414512ljh.56.2020.06.14.12.20.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 12:20:47 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id s1so16628347ljo.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 12:20:47 -0700 (PDT)
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr12147800ljn.285.1592162446763;
 Sun, 14 Jun 2020 12:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com>
 <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com>
 <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com>
 <CAHk-=whZz_E+Bu1L6YTxtDQu_piBjUBoULW7vkKxNux54kwFAA@mail.gmail.com> <CAJ-EccP-MW3MZ3n=u-CoPD1nL73paLUSP3v5dQu+iiQLAtaZfQ@mail.gmail.com>
In-Reply-To: <CAJ-EccP-MW3MZ3n=u-CoPD1nL73paLUSP3v5dQu+iiQLAtaZfQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Jun 2020 12:20:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipG5Wpfydn7YUbahDV_G0GZqeUqEWax_mSLBuVeiT0yg@mail.gmail.com>
Message-ID: <CAHk-=wipG5Wpfydn7YUbahDV_G0GZqeUqEWax_mSLBuVeiT0yg@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for v5.8
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 12:12 PM Micah Morton <mortonm@chromium.org> wrote:
>
> That said I'm a little fuzzy on where to draw the line for which kinds
> of changes really should be required to have bake time in -next. If
> you think this is one of those cases, we can hold off on this until we
> have some bake time for v5.9.

It's merged, but in general the rule for "bake in -next" should be
absolutely everything.

The only exception is just pure and plain fixes.

This SafeSetID change should in fact have been there for two different
reasons: not only was it a new feature rather than a fix (in
linux-next just for testing), it was one that crossed subsystem
borders (should be in linux-next just for cross-subsystem testing). It
touched files that very much aren't touched by just you.

"Looks obvious" has nothing to do with avoiding linux-next.

I suspect most of the bugs we have tend to be in code that "looked
obvious" to somebody.

                     Linus
