Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F31C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EF652064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L0pRlBCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgGOIiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbgGOIiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:38:24 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAD7C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:38:24 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m16so2100143pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TbJ/+ucYAYXSyy1FqmpSCm01BvP6FkdKr9JPVe9GaUg=;
        b=L0pRlBCRfUah0I4nLTsTC/5bv4ktc+BBmfCp6T4csHEtDtfAWLOgbeZW4Bn68P3Mao
         zEltQ6EKuI39ADl6Bd7eMem4iWEgCvj4H+xSIPzU9722c0kTQrVLOqE1H/UeFH3Xx7tO
         K1+rMFQbYBqLwwKrmRKDwMP9C5AK9HR6oz3QDlCVjoihNrO0V3QJxpTm7HzGEo4bWKa+
         yD6xSMWacEH9z2oxtwNfhmE1dyNRMOxtbLP2sdhLXnH7Hm8UiNrBx7zM5R7gdzXDsEQr
         CKV88k3iqYvf8mz+EUQv0blZ5MAQFv792N7CKYU9apHXNuqw/NA+8732rWdUvYWO0zOW
         WoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TbJ/+ucYAYXSyy1FqmpSCm01BvP6FkdKr9JPVe9GaUg=;
        b=Z783HrFNVJMilYptp06Y3O65+t0meDoWdLuhClIUeaMBNoW4dzExoZH+8CTeli2wzX
         hOLZx5Nisz4XOlhefdKJ/INV9cVpdjvvNKtruoeba/5LhY5SvmI5Rec8V9vkJQr8o8A8
         meVy6Z7q/BcqmfB38AzGMFZtpsc0xeU7f2gFzRMdkqeSRQCNFjVtWAmmASQjLKhXW/Dz
         0b7fSRv1gSXNP3FvvuMUCjlqJqKmcYoaQmhTRnV03uT1thi+i1wAOzyZLnRfjesXs0Ox
         E9V40wH+FUO7Lyx0DIEJ7V9E3PeUpGtA3tpOYEp/zzhDJAYkyCZL4n+44wP1ijv9mvsI
         07pA==
X-Gm-Message-State: AOAM533GAB85ZON75cJaQV6fiPJI4NWljRqGWekm+OZ74HK/mw/Adufh
        DjPb8ZijqNlNGLo8C3lEcXJC+MUKbYdUm741MGbo+Q==
X-Google-Smtp-Source: ABdhPJwYyn9g4MTK+w+66YEWHyngcaSRZXVufsH+Vtuz+n2tEnKccXdTiDptiWqLYywvLUAfuZ8kOijAqHnOrcK1b/8=
X-Received: by 2002:a17:90a:cc03:: with SMTP id b3mr8256003pju.80.1594802303432;
 Wed, 15 Jul 2020 01:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200704085213.444645-1-ignat@cloudflare.com> <20200704085213.444645-2-ignat@cloudflare.com>
In-Reply-To: <20200704085213.444645-2-ignat@cloudflare.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 15 Jul 2020 01:38:12 -0700
Message-ID: <CAFd5g45jR3tRfWhGiX931xh4=aScrfp0buHyRSWWH78NdTHSVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] um/kconfig: introduce CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 4, 2020 at 1:52 AM Ignat Korchagin <ignat@cloudflare.com> wrote:
>
> For statically linked UML build it is important to take into account the
> standard C-library implementation. Some implementations, notably glibc have
> caveats: even when linked statically, the final program might require some
> runtime dependencies, if certain functions are used within the code.
>
> Consider the following program:
> int main(void)
> {
>         getpwent();
>         return 0;
> }
>
> Compiling this program and linking statically with glibc produces the following
> warning from the linker:
> /usr/sbin/ld: /tmp/ccuthw1o.o: in function `main':
> test.c:(.text+0x5): warning: Using 'getpwent' in statically linked
> applications requires at runtime the shared libraries from the glibc version
> used for linking
>
> We will use the flag to detect such C-library implementation build time and
> possibly disable static linking for UML to avoid producing a binary with
> unexpected behaviour and dependencies.
>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>

Nice.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
