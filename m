Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DD0C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811A5206E6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JoEYFdqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCCWUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:20:16 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33658 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCCWUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 17:20:16 -0500
Received: by mail-pf1-f195.google.com with SMTP id n7so2221790pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 14:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0VgoCajNQtcqmr3sAxZ7zwAICIrcd2LUoNAPqwJhMc=;
        b=JoEYFdqH8VMWl/v3oH9VXqNGlxqWFgnorIuL0o80ZngwzS/ndHRTcASbqclRrUjUFS
         JqDXYy6BFgb8RRrFi0Wguy7MFjm1Rx9YwjkChVADEVVdGOzA/Nh6wAc8Fvp7yZSOaCZ4
         cOzTqLmgjn4ShkaCTeB0wEWh3WU2S1mivlUnz8Qn+B2nvfX/AnGjrvd8CNWkq1bd8XQm
         p0PKu/SVvr1mTlYxgKG5QdG7UrmbLeScp3lDEyEy4N7EHsPCemUBKHbsMhp+PqtNrEMC
         iDc3Chr898nqiTtFwHk+hlM7QURM5bO50ptPMclx9dGGCYyAG7mOlQR5af5uVt1+dBGK
         B3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0VgoCajNQtcqmr3sAxZ7zwAICIrcd2LUoNAPqwJhMc=;
        b=o5fNbUNPZcMQSpzJjgj7VYbpzj7z6a18NMRzv3U+tKpxw+PgBqlTrutf4abHgyOtui
         VKuc3ZpJFGeTdM4pwV68WPnc5kcTYFxT5RGmseL0FQE7BotVf7ZmUvAXhhsFhZw29Pvd
         99IuTmLNRvfOmgcI2STlUg3RCHaeBWcW2BMmR4xLFuvh4h1kl1WV+/GazVoYXrYmknYj
         NUSQgl3CR3hAyoHaGBNHUEcKRyzWP1hGl0Co/xd2yLNchvEKNnLnWyIATswREfqpdQkE
         xAxTH5YUEF85suJ2JDl27Zq9xrT9i5H+ZON6qJvfHuFdCI3e45n22uZVh/Ay95G59lpZ
         h5QQ==
X-Gm-Message-State: ANhLgQ0GnZQq/BBkjSHEL9O1AVHX4KmkdYcO8Ceg1QioKAT5LCHIaR2Z
        Ra7SUikrlEQFYPjj4HiLGpdSP7nVlx7BNGXDF31yVQ==
X-Google-Smtp-Source: ADFU+vt4X4Q2+Uu+la/wP/hFUKrg/nR+9uZ1co62ESgEa0STG5Q0XI3VwZlAqZ1ci3kOGA0/3riqiLDrYgRWJ+NHPxM=
X-Received: by 2002:a62:37c7:: with SMTP id e190mr6303201pfa.165.1583274014576;
 Tue, 03 Mar 2020 14:20:14 -0800 (PST)
MIME-Version: 1.0
References: <c41cc67321d0b366e356440e6dbc9eceb1babfe4.1583105749.git.stefan@agner.ch>
In-Reply-To: <c41cc67321d0b366e356440e6dbc9eceb1babfe4.1583105749.git.stefan@agner.ch>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 3 Mar 2020 14:20:03 -0800
Message-ID: <CAKwvOdmvOq9X3zR17TsEZpJ83BYC1vX=pYMPyZ6Db3xeHUxzag@mail.gmail.com>
Subject: Re: [PATCH] crypto: arm/ghash-ce - define fpu before fpu registers
 are referenced
To:     Stefan Agner <stefan@agner.ch>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        Manoj Gupta <manojgupta@google.com>,
        Jian Cai <jiancai@google.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ard.Biesheuvel@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 1, 2020 at 3:37 PM Stefan Agner <stefan@agner.ch> wrote:
>
> Building ARMv7 with Clang's integrated assembler leads to errors such
> as:
> arch/arm/crypto/ghash-ce-core.S:34:11: error: register name expected
>  t3l .req d16
>           ^
>
> Since no FPU has selected yet Clang considers d16 not a valid register.
> Moving the FPU directive on-top allows Clang to parse the registers and
> allows to successfully build this file with Clang's integrated assembler.

Certainly a side effect of having a single pass assembler...This does
fix what otherwise looks like a slew of errors for us, thanks for the
patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>



>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/crypto/ghash-ce-core.S | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/crypto/ghash-ce-core.S b/arch/arm/crypto/ghash-ce-core.S
> index 534c9647726d..9f51e3fa4526 100644
> --- a/arch/arm/crypto/ghash-ce-core.S
> +++ b/arch/arm/crypto/ghash-ce-core.S
> @@ -8,6 +8,9 @@
>  #include <linux/linkage.h>
>  #include <asm/assembler.h>
>
> +       .arch           armv8-a
> +       .fpu            crypto-neon-fp-armv8
> +
>         SHASH           .req    q0
>         T1              .req    q1
>         XL              .req    q2
> @@ -88,8 +91,6 @@
>         T3_H            .req    d17
>
>         .text
> -       .arch           armv8-a
> -       .fpu            crypto-neon-fp-armv8
>
>         .macro          __pmull_p64, rd, rn, rm, b1, b2, b3, b4
>         vmull.p64       \rd, \rn, \rm
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/c41cc67321d0b366e356440e6dbc9eceb1babfe4.1583105749.git.stefan%40agner.ch.



--
Thanks,
~Nick Desaulniers
