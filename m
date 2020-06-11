Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218BAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC85120842
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QKdoB7s1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgFKXjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgFKXjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:39:11 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA3BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 16:39:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w20so3225628pga.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 16:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PAjCKI6MqDjh7P5uPdXryvnaGEeCq7TVMpet7FGoy7Q=;
        b=QKdoB7s1+c8y2Lyhx08PCcM6Gcaw6bPOWK/e9Jiepq4rBTgxC5nMaP7TcdbWuSRXuW
         te0kUNV9bMonftlvXz3t3rcfAXpW0K1z+7V7ixOeYKrJdkiME0OkIofwFHG4VGcRhUiC
         hAynZbVWESietV+w+To5TffLKBTwo+s77moHX0cptXFVq61e0C/q3qj2uTlOUbspDSOX
         kWQpix3Z3HjZKTlRar8x7dMUKWPtgGX0DZuUPxs7pkyUy+BVTUIaWIaPdiOR+6p63k4E
         FIz4zqLQcleeox8S0uPSSA+Hr9tQrKxdQO43VmwOdULjZnO1N+JuSwvSz7Oe1FpY6e2X
         S7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PAjCKI6MqDjh7P5uPdXryvnaGEeCq7TVMpet7FGoy7Q=;
        b=KD6F9P7Z+Rza9NGNRNlzLWXDhUI0eTuA3QAGzvHIs3XsmyQIt4pnep1e5H0aaqc5R/
         pNPVoWTPp5kp+VK7R8gccmPj9J5hUZhE673+Cyemiy6AO9HcfKR8iLc0S1ksxfRUMhm/
         csuD/Cb5d4zGoMaEmo2sqEtGWNVjNi8Z5QtIDR7477rjOA9CtVFTghDV35kBjsoOE4cd
         AMOi6cv2AHT5211IJkjxK9uZtT3ItX+yRENRMYng+C5+9I+G/80Y5gKKL16c8VxrT15l
         ZpSccvFnBFuN4/ro83sn7LyzIh5142md7cPqQpWpnfldgn0HlhDUSnwBI9gpxmz19UK5
         0LuQ==
X-Gm-Message-State: AOAM531SjmLsf5TwvnYycu5cw3UDsiKd9MIG6kjJj6+ezwUvo1Pc6nUm
        HLtkCqvhNiUlh6esTbghtgqLQYYUi+My9lmEte3e2Q==
X-Google-Smtp-Source: ABdhPJy6hNjsNqidbhfXdErSRf/X1ikfRmzNDY2AL6v9WPM6/vkCqSK+yLSSmr4DMu1dRhtrOiu1xpk8HZ+zvaIctZI=
X-Received: by 2002:a63:a119:: with SMTP id b25mr8467715pgf.10.1591918748974;
 Thu, 11 Jun 2020 16:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnddAjiXDKA8fp3n2NN+R=Syp2N5DHbp1j=VRzM1dNnRw@mail.gmail.com>
 <20200611220339.3971675-1-nivedita@alum.mit.edu>
In-Reply-To: <20200611220339.3971675-1-nivedita@alum.mit.edu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 11 Jun 2020 16:38:57 -0700
Message-ID: <CAKwvOdksFqf11-sdLrvNe4wrRvyAB2mVfwKU4KkNsapSnN_tRw@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: Improve compressed debug info support detection
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 3:03 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Commit
>   10e68b02c861 ("Makefile: support compressed debug info")
> added support for compressed debug sections.
>
> Support is detected by checking
> - does the compiler support -gz=zlib
> - does the assembler support --compressed-debug-sections=zlib
> - does the linker support --compressed-debug-sections=zlib
>
> However, the gcc driver's support for this option is somewhat
> convoluted. The driver's builtin specs are set based on the version of
> binutils that it was configured with. It reports an error if the
> configure-time linker/assembler (i.e., not necessarily the actual
> assembler that will be run) do not support the option, but only if the
> assembler (or linker) is actually invoked when -gz=zlib is passed.
>
> The cc-option check in scripts/Kconfig.include does not invoke the
> assembler, so the gcc driver reports success even if it does not support
> the option being passed to the assembler.
>
> Because the as-option check passes the option directly to the assembler
> via -Wa,--compressed-debug-sections=zlib, the gcc driver does not see
> this option and will never report an error.

Thanks for expanding on the failure.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Combined with an installed version of binutils that is more recent than
> the one the compiler was built with, it is possible for all three tests
> to succeed, yet an actual compilation with -gz=zlib to fail.
>
> Moreover, it is unnecessary to explicitly pass
> --compressed-debug-sections=zlib to the assembler via -Wa, since the
> driver will do that automatically when it supports -gz=zlib.
>
> Convert the as-option to just -gz=zlib, simplifying it as well as
> performing a better test of the gcc driver's capabilities.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  Makefile          | 2 +-
>  lib/Kconfig.debug | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 839f9fee22cb..cb29e56f227a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -842,7 +842,7 @@ endif
>
>  ifdef CONFIG_DEBUG_INFO_COMPRESSED
>  DEBUG_CFLAGS   += -gz=zlib
> -KBUILD_AFLAGS  += -Wa,--compress-debug-sections=zlib
> +KBUILD_AFLAGS  += -gz=zlib
>  KBUILD_LDFLAGS += --compress-debug-sections=zlib
>  endif
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index cb98741601bd..94ce36be470c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -229,7 +229,7 @@ config DEBUG_INFO_COMPRESSED
>         bool "Compressed debugging information"
>         depends on DEBUG_INFO
>         depends on $(cc-option,-gz=zlib)
> -       depends on $(as-option,-Wa$(comma)--compress-debug-sections=zlib)
> +       depends on $(as-option,-gz=zlib)
>         depends on $(ld-option,--compress-debug-sections=zlib)
>         help
>           Compress the debug information using zlib.  Requires GCC 5.0+ or Clang
> --
> 2.26.2
>


-- 
Thanks,
~Nick Desaulniers
