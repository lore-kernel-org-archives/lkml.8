Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50A6C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 07:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5732070A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 07:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgGRHvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 03:51:03 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32964 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbgGRHvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 03:51:02 -0400
Received: by mail-oi1-f194.google.com with SMTP id k22so10026857oib.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 00:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEEvd4u3UvGoBQRrd8r0flfbXnRfcEtkikuqiW2DLRE=;
        b=VdTIISXYSJnmOV2gsSCROT3wTZXARF83gJrNzaUzgyN1WMKHb297dFeCI+3jbL0sWQ
         kvKJ2ZphK6B8ZFRg/cBAwF8XGIPG0unxVid8XzW+dpRhVDsHGatlBvsb1PeyuWTfAyhs
         tERnrcjCJoAtKrZ5jgvHb9tcY+ndaPj5X8xe8CxlVRDJPa2SHyJ7vexUkgHSFsiX+YCF
         4yaEss/1lTfZt8HofrkoiFvkiGGMQCj5GWrd/xNtRMLvPtxLes9uICvMfy+9NLIh6TM8
         mvAJvDUCd1fCkoykBiCveBtYfwuM8bMGmWv9v0IDy6Q6LCFZEykGEAsyIRufCQtGqSrh
         BG9w==
X-Gm-Message-State: AOAM531mzzAHRJb8U55+OUyPGKi8TfFAc7e+6hnghfOnepRuv50xOlTY
        pdU24h+K6qVv6vN8V+tzUR3Olrj+KRBRtDWDYF4=
X-Google-Smtp-Source: ABdhPJxokjFbAWf+q0y5gqswRgTgqjSY2nJ72G0Xlm5f/Wi/zUxXQcPf5Sb1C4Z8wFeq+35XMwAnzo2pM2Pox1D/rpY=
X-Received: by 2002:a05:6808:64a:: with SMTP id z10mr10530650oih.54.1595058661714;
 Sat, 18 Jul 2020 00:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200624035920.835571-1-natechancellor@gmail.com>
In-Reply-To: <20200624035920.835571-1-natechancellor@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 18 Jul 2020 09:50:50 +0200
Message-ID: <CAMuHMdU_KfQ-RT_nev5LgN=Vj_P97Fn=nwRoC6ZREFLa3Ysj7w@mail.gmail.com>
Subject: Re: [PATCH] powerpc/boot: Use address-of operator on section symbols
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Geoff Levand <geoff@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Wed, Jun 24, 2020 at 6:02 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> arch/powerpc/boot/main.c:107:18: warning: array comparison always
> evaluates to a constant [-Wtautological-compare]
>         if (_initrd_end > _initrd_start) {
>                         ^
> arch/powerpc/boot/main.c:155:20: warning: array comparison always
> evaluates to a constant [-Wtautological-compare]
>         if (_esm_blob_end <= _esm_blob_start)
>                           ^
> 2 warnings generated.
>
> These are not true arrays, they are linker defined symbols, which are
> just addresses.  Using the address of operator silences the warning
> and does not change the resulting assembly with either clang/ld.lld
> or gcc/ld (tested with diff + objdump -Dr).
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/212
> Reported-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/powerpc/boot/main.c | 4 ++--
>  arch/powerpc/boot/ps3.c  | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
> index a9d209135975..cae31a6e8f02 100644
> --- a/arch/powerpc/boot/main.c
> +++ b/arch/powerpc/boot/main.c
> @@ -104,7 +104,7 @@ static struct addr_range prep_initrd(struct addr_range vmlinux, void *chosen,
>  {
>         /* If we have an image attached to us, it overrides anything
>          * supplied by the loader. */
> -       if (_initrd_end > _initrd_start) {
> +       if (&_initrd_end > &_initrd_start) {
>

Are you sure that fix is correct?

    extern char _initrd_start[];
    extern char _initrd_end[];
    extern char _esm_blob_start[];
    extern char _esm_blob_end[];

Of course the result of their comparison is a constant, as the addresses
are constant.  If clangs warns about it, perhaps that warning should be moved
to W=1?

But adding "&" is not correct, according to C.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
