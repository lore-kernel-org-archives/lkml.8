Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAFCC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 11:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76CB20732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 11:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586776925;
	bh=LjSW/Ue9I8h7pylDK/tUbDzevLbgM1EFN5Diu4em3R0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w11zet1+GyeXdSVH4SI7HCMmdwvJvWsflLBVSXGAhQNoDN59ig0stRCbTr2BDs1L0
	 KasvpYHlCny6Zl890WER4KaXGloXXSM5iobALIHGkhsXIBC6NTsTtAsqVqY87v0Bjd
	 pq0t2lDFurAhIrW6ka+b/M3/uhQ9T7R2elQY6pDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgDMLWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:22:04 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:27765 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbgDMLWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 07:22:03 -0400
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 03DBLm3q031241
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 20:21:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 03DBLm3q031241
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1586776909;
        bh=SRh+8Znpw6pp1tH1BSalCes/6Y1eOsSFzMJTg0CB2c4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fWlvJeFA0Fn+GyVeE83p5aWw8prnxyHHbzmg2LzyaBlk0SSlUPphRTQ6oS8aFmH78
         AzlthjfwcfdedHfpTS2TvK7abnYqcz0BUO0a6Lo9CRJNHF/cw3E3BvZCSe+hAZk8GB
         1xCg+TCnfWs7H39oxBy4u55xFnKCdJWiRa3rYp5ypztTM5RYUN/VTXur3/J/SlFimH
         i/LAx1NuLdUGThCz89xY3KcpXZNOSBq2g4RIkEHZDxKrU/L4NncN+beBg67N/Hy2RJ
         y/0wnJA5/WLsuIrtQTvguTha2VVdEyr9qvoRUWspQP1FOO8Yw+iCfqI6GulLzbRHC4
         /Nms02BCBnnjg==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id c7so2970451uap.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 04:21:49 -0700 (PDT)
X-Gm-Message-State: AGi0PuYtgRIAYwb7mT/fjq7xnQkfJqq/bKaQpCOmwEIU83s1/KafHrEC
        vGNFfbocW9Mz0JWRwToA7Kqo91WxIkDBpmLkDMI=
X-Google-Smtp-Source: APiQypICbt79R/Z7ZzQGzhFwWLlFDSZ3QFBKv8qcrLpiPtqU6IBHzKFTYanS5UvxfUUwGjBi21OySMZM393b389YiyY=
X-Received: by 2002:ab0:2085:: with SMTP id r5mr11032980uak.95.1586776908098;
 Mon, 13 Apr 2020 04:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200413093552.25102-1-geert@linux-m68k.org>
In-Reply-To: <20200413093552.25102-1-geert@linux-m68k.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 13 Apr 2020 20:21:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNARzn1eOpxA4xS9TkSE9LPMJfv0ByEg8_RNTcY1N-YLWFQ@mail.gmail.com>
Message-ID: <CAK7LNARzn1eOpxA4xS9TkSE9LPMJfv0ByEg8_RNTcY1N-YLWFQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: Drop redundant generic-y += hardirq.h
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 6:42 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> The cleanup in commit 630f289b7114c0e6 ("asm-generic: make more
> kernel-space headers mandatory") did not take into account the recently
> added line for hardirq.h in commit acc45648b9aefa90 ("m68k: Switch to
> asm-generic/hardirq.h"), leading to the following message during the
> build:
>
>     scripts/Makefile.asm-generic:25: redundant generic-y found in arch/m68k/include/asm/Kbuild: hardirq.h
>
> Fix this by dropping the now redundant line.
>
> Fixes: 630f289b7114c0e6 ("asm-generic: make more kernel-space headers mandatory")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>



> ---
> Feel free to take this one directly, as I have no other m68k fixes
> queued for v5.7 yet.
>
>  arch/m68k/include/asm/Kbuild | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
> index a0765aa60ea9aa8d..1bff55aa2d54e2ce 100644
> --- a/arch/m68k/include/asm/Kbuild
> +++ b/arch/m68k/include/asm/Kbuild
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  generated-y += syscall_table.h
>  generic-y += extable.h
> -generic-y += hardirq.h
>  generic-y += kvm_para.h
>  generic-y += local64.h
>  generic-y += mcs_spinlock.h
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
