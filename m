Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3AFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37EF206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JRAK1E4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgFNREx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 13:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgFNREw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 13:04:52 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452B3C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 10:04:52 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j4so2551468plk.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 10:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9XxYQzfyqh1q+DYJGCKu/T7lrBYP8XPc9LEF/DP+W54=;
        b=JRAK1E4c3adOkrqVIBNH3KT4f6c8f8eJ2ojJCPdhhl9rTEH5vycY0Sser5IRltp3I0
         QArRfWIw78uKhbD5LKci5O9+0BAcHIDJYjIdD2gsjYf55lq1cvzFjaqwtvuF8fnPj0CO
         T7mYsWKet9WWWqiD2WZ7bTt5ZD1lK8XkGM/08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9XxYQzfyqh1q+DYJGCKu/T7lrBYP8XPc9LEF/DP+W54=;
        b=qU3K6qUhqN+Rsz8hS9h24EcD9Qa4hO5NK/h0wVz74JU27GEIEygQIYynwk4nNGmOig
         Yo+vJuqnNQX+I8khqNa6onCtRsSPil+ifSsMgc/vZ1dm4QEh/LROYIAHkiZsvouWV0Ck
         s0RdZLU35pNlHivfJLOmsw790GVYLqgMOUNVLfIx8igyFeCh1avDDls108eJBjlZOkiK
         SEb1KbeGHAgdU/2+KLmm5n/ZY7soMHrwqSuhH71iHw+hjl+tMD5t7cgcas+iv0cKhBgL
         WuX5sL7MZwonUEdUIUJoFzUtBLuSia6kWH55lXV+ONjfTTY3xwwMouEv9POzvlIQ2x5m
         GYog==
X-Gm-Message-State: AOAM5335glyWbYv+rv6bmwm13Y1YUM6ZUVP5+poxM1cB0Reis56fKZTB
        Y+K52rocd3cAIgspG2QQTRKBEg==
X-Google-Smtp-Source: ABdhPJzvT/iwm1yvnPB7J1tBc7kq4t0yp+JvpQw+DFY/TAlPFnuPobSGN/87J84NDMlPwtq9a+A2JA==
X-Received: by 2002:a17:902:82ca:: with SMTP id u10mr19010820plz.294.1592154291467;
        Sun, 14 Jun 2020 10:04:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j19sm11594466pfn.109.2020.06.14.10.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 10:04:50 -0700 (PDT)
Date:   Sun, 14 Jun 2020 10:04:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     glider@google.com
Cc:     yamada.masahiro@socionext.com, jmorris@namei.org, maze@google.com,
        ndesaulniers@google.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] security: allow using Clang's zero initialization
 for stack variables
Message-ID: <202006141000.B93DF245@keescook>
References: <20200614144534.237035-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200614144534.237035-1-glider@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 04:45:34PM +0200, glider@google.com wrote:
> In addition to -ftrivial-auto-var-init=pattern (used by
> CONFIG_INIT_STACK_ALL now) Clang also supports zero initialization for
> locals enabled by -ftrivial-auto-var-init=zero.
> The future of this flag is still being debated, see
> https://bugs.llvm.org/show_bug.cgi?id=45497
> Right now it is guarded by another flag,
> -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang,
> which means it may not be supported by future Clang releases.
> Another possible resolution is that -ftrivial-auto-var-init=zero will
> persist (as certain users have already started depending on it), but the
> name of the guard flag will change.
> 
> In the meantime, zero initialization has proven itself as a good
> production mitigation measure against uninitialized locals. Unlike
> pattern initialization, which has a higher chance of triggering existing
> bugs, zero initialization provides safe defaults for strings, pointers,
> indexes, and sizes. On the other hand, pattern initialization remains
> safer for return values.
> Performance-wise, the difference between pattern and zero initialization
> is usually negligible, although the generated code for zero
> initialization is more compact.
> 
> The proposed config, CONFIG_USE_CLANG_ZERO_INITIALIZATION, makes
> CONFIG_INIT_STACK_ALL use zero initialization if the corresponding flags
> are supported by Clang.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  Makefile                   | 15 ++++++++++++++-
>  security/Kconfig.hardening | 16 ++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index fd31992bf918..2860bad7e39a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -802,9 +802,22 @@ KBUILD_CFLAGS	+= -fomit-frame-pointer
>  endif
>  endif
>  
> -# Initialize all stack variables with a pattern, if desired.
> +# Initialize all stack variables, if desired.
>  ifdef CONFIG_INIT_STACK_ALL
> +
> +# Use pattern initialization by default.
> +ifndef CONFIG_USE_CLANG_ZERO_INITIALIZATION
>  KBUILD_CFLAGS	+= -ftrivial-auto-var-init=pattern
> +else
> +
> +ifdef CONFIG_CC_HAS_AUTO_VAR_ZERO_INIT
> +# Future support for zero initialization is still being debated, see
> +# https://bugs.llvm.org/show_bug.cgi?id=45497. These flags are subject to being
> +# renamed or dropped.
> +KBUILD_CFLAGS	+= -ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
> +endif
> +
> +endif
>  endif

I'd prefer this be split instead of built as a nested if (i.e. entirely
control section via the Kconfig -- see below).

>  
>  DEBUG_CFLAGS	:= $(call cc-option, -fno-var-tracking-assignments)
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index af4c979b38ee..299d27c6d78c 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -22,6 +22,9 @@ menu "Memory initialization"
>  config CC_HAS_AUTO_VAR_INIT
>  	def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
>  
> +config CC_HAS_AUTO_VAR_ZERO_INIT
> +	def_bool $(cc-option,-ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang)
> +

I'd like to be more specific here. Let's rename CC_HAS_AUTO_VAR_INIT to
CC_HAS_AUTO_VAR_INIT_PATTERN, and change the other to
CC_HAS_AUTO_VAR_INIT_ZERO (they then both match the word order of the
option, and the thing that changes is the last word).

>  choice
>  	prompt "Initialize kernel stack variables at function entry"
>  	default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
> @@ -100,6 +103,19 @@ choice
>  
>  endchoice
>  
> +config USE_CLANG_ZERO_INITIALIZATION
> +	bool "Use Clang's zero initialization for local variables"
> +	depends on CC_HAS_AUTO_VAR_ZERO_INIT
> +	depends on INIT_STACK_ALL
> +	help
> +	  If set, uses zeros instead of 0xAA to initialize local variables in
> +	  INIT_STACK_ALL. Zeroing the stack provides safer defaults for strings,
> +	  pointers, indexes, and sizes. The downsides are less-safe defaults for
> +	  return values, and exposing fewer bugs where the underlying code
> +	  relies on zero initialization.
> +	  The corresponding flag isn't officially supported by Clang and may
> +	  sooner or later go away or get renamed.
> +

Similarly, I'd like to rename INIT_STACK_ALL to INIT_STACK_ALL_PATTERN
and then add INIT_STACK_ALL_ZERO.

>  config GCC_PLUGIN_STRUCTLEAK_VERBOSE
>  	bool "Report forcefully initialized variables"
>  	depends on GCC_PLUGIN_STRUCTLEAK
> -- 
> 2.27.0.290.gba653c62da-goog
> 

But yes, let's get this change implemented. :)

-- 
Kees Cook
