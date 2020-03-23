Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0297BC10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C221020663
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUNBTWdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCWUYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:24:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35130 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgCWUYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:24:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id g6so6417929plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 13:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0LsAz70o8cEG4Nw2F0iYGNC/gi7roMlmMUaydZViic=;
        b=mUNBTWdVOxOOX6AMAo6cgRH71ec0iV+SXDJ6JsA+ueMI12basjiumCLVcRvtdlfVsg
         OTGqufJENljEUWV9yNfmo/oi9+1JriOXNQdBg/sXHGWN4vH//BMyk3nxzIbD2bQw5sH6
         tFIP6XXBPMynW6Y4IHYYXZ8z4OQmViSCCKsxQKz1ZrOST7+Y6566R7oaniScAQNGHGvS
         sH3Wqn8bYzirLfVOTEuifD2Gt8kYBDBm1u4ydEfERAmCLUnrZLxYlspAAJnDpZb3rmO9
         O0zv3rUMz9wFk8HU9iqqIIbSnNC05bHEyosNyru1FjiuEL7939BWs3Qv2uU5oDKR+WnF
         TUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0LsAz70o8cEG4Nw2F0iYGNC/gi7roMlmMUaydZViic=;
        b=ZwjLtikDXilcOwZWyTJae6DzAQ9QqJSZyQdJJ2LhJlB7LQ0Ml6ilfafHTVw59h2dzo
         vPho6PrPnwLzAP9wUmHDs+1aXsSlIGjf7ByZTyLUhhgkStxtEVf/YC1IPfp6KXtSeawF
         iLPVEESO1qCJV79bMomHC4Um1AOQa2ubD5ThFjK17YdFrqcHJw6nuMUCPvlDSGhQr4H/
         W4VTZt0Te4F0bcfiDdPeipj3nm1TTv4XJ3b5xnmOIyuigS+sgRMq/LPW20raTWggBHvo
         6QCacE6uiLgGTFwlXjoLczZaVITpbIqUm82QS6CF4ggLq//FRzLrd6sLeeyQrOucRYDl
         1Gcg==
X-Gm-Message-State: ANhLgQ2UuHnnC2PalBOfm42ZiLmB15hSX2TFygUOoiGjYXmO6o17l17J
        g3jzzf9zChLb6zVOzWDk+EC+ikJ3P2jK4FPN4LhzhkwzHwk=
X-Google-Smtp-Source: ADFU+vvYNOQvMVU8ZpcPZT3z+xHkhnMEd5HXpvvnpiNRLlGKXz7Ftce1nGRjzBbLh0Jk2Evgw+d0jvM44zxx6FFA7Rg=
X-Received: by 2002:a17:90b:8d2:: with SMTP id ds18mr1099401pjb.186.1584995052592;
 Mon, 23 Mar 2020 13:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200323021053.17319-1-masahiroy@kernel.org>
In-Reply-To: <20200323021053.17319-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 23 Mar 2020 13:24:01 -0700
Message-ID: <CAKwvOdk3g0HzU1r90oRm46ACwfr=CwYjYxUs8w_x47n_sRsVTQ@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: remove always-defined CONFIG_AS_MOVNTDQA
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 7:12 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> CONFIG_AS_MOVNTDQA was introduced by commit 0b1de5d58e19 ("drm/i915:
> Use SSE4.1 movntdqa to accelerate reads from WC memory").
>
> We raise the minimal supported binutils version from time to time.
> The last bump was commit 1fb12b35e5ff ("kbuild: Raise the minimum
> required binutils version to 2.21").

Indeed, I see 2.21 was released in 2010, and I see a commit modifying
existing support for movntdqa in 2008; it looks like these have been
supported for a while.  Thanks for this cleanup; the less we have to
invoke tools during make invocation, to lower the overhead of Kbuild.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> I confirmed the code in $(call as-instr,...) can be assembled by the
> binutils 2.21 assembler and also by Clang's integrated assembler.
>
> Remove CONFIG_AS_MOVNTDQA, which is always defined.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  drivers/gpu/drm/i915/Makefile      | 3 ---
>  drivers/gpu/drm/i915/i915_memcpy.c | 5 -----
>  2 files changed, 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index a1f2411aa21b..e559e53fc634 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -28,9 +28,6 @@ subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
>  CFLAGS_i915_pci.o = $(call cc-disable-warning, override-init)
>  CFLAGS_display/intel_fbdev.o = $(call cc-disable-warning, override-init)
>
> -subdir-ccflags-y += \
> -       $(call as-instr,movntdqa (%eax)$(comma)%xmm0,-DCONFIG_AS_MOVNTDQA)
> -
>  subdir-ccflags-y += -I$(srctree)/$(src)
>
>  # Please keep these build lists sorted!
> diff --git a/drivers/gpu/drm/i915/i915_memcpy.c b/drivers/gpu/drm/i915/i915_memcpy.c
> index fdd550405fd3..7b3b83bd5ab8 100644
> --- a/drivers/gpu/drm/i915/i915_memcpy.c
> +++ b/drivers/gpu/drm/i915/i915_memcpy.c
> @@ -35,7 +35,6 @@
>
>  static DEFINE_STATIC_KEY_FALSE(has_movntdqa);
>
> -#ifdef CONFIG_AS_MOVNTDQA
>  static void __memcpy_ntdqa(void *dst, const void *src, unsigned long len)
>  {
>         kernel_fpu_begin();
> @@ -93,10 +92,6 @@ static void __memcpy_ntdqu(void *dst, const void *src, unsigned long len)
>
>         kernel_fpu_end();
>  }
> -#else
> -static void __memcpy_ntdqa(void *dst, const void *src, unsigned long len) {}
> -static void __memcpy_ntdqu(void *dst, const void *src, unsigned long len) {}
> -#endif
>
>  /**
>   * i915_memcpy_from_wc: perform an accelerated *aligned* read from WC
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200323021053.17319-1-masahiroy%40kernel.org.



-- 
Thanks,
~Nick Desaulniers
