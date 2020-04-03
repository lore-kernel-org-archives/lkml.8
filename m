Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5D2C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 22:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FF82078C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 22:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OKwXzGMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgDCWpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 18:45:05 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36564 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgDCWpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 18:45:05 -0400
Received: by mail-pj1-f68.google.com with SMTP id nu11so3644096pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 15:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dh/YzwcmTNEGeHjfzHpzt3+RVjAmlGCyq1UYQzxyT7s=;
        b=OKwXzGMXRPUowM4ABa1P1uclRN312qDo0rkVMaxCnf//bzaQk0hTNa4VSw7AKcTaMe
         NBvdo/yL8y3JSLsBpOZkG4L0cy6JcxsIOqb2KZQUghuixheFfu9xWqNHpqzTvApWeK6n
         rGHvNIf6rcWOjII10ibRZ/BMIG0fZJkQ5Tg2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dh/YzwcmTNEGeHjfzHpzt3+RVjAmlGCyq1UYQzxyT7s=;
        b=TTOb0JU7ygJJZydn373bpAysq70/N9rfcJfprpEobNvlPGxoORNJFO8s6Q3z9/Ly6R
         g2wdnFfY4rCmZqwUmWUe3o7oFxAOyKZtoRYyu9FSzP6iQQxrP5m1gpIIjPzVVuKMB05Y
         4Q60Hra7J/0ZdSJu0r2hWTp9zOmCEQi5k3b9EZr3lcM5Z/LyGv/dFRyHmJROSBU8V7jk
         9JAm2nIw0Fp+yNhrwiKHDC5gBmueEI/9x0/jv0kl2Mbol9FkvD85ylqqJkXeT1sqiqzk
         XnKCYGInJTBzMNJt3yjw/Oo215EDtbdW95IWlRRCQARazvZ/dx3UQxH4LBYZ4ikNlnbS
         ErSw==
X-Gm-Message-State: AGi0PuYeQawxmHsm+qgjlFDXE2Be1QKm3yQo4KmCsbwge80xmjQ4C3Lb
        3GN6mNeQCaio8IBXLns85VTiXA==
X-Google-Smtp-Source: APiQypLzpCCsWiQ/lFaeewHX9vuuuIEqsKxPFJbCGqChBNQwRFmwfICRd70XwZr6HeooQ2rNiYBH/A==
X-Received: by 2002:a17:90a:9b17:: with SMTP id f23mr12281284pjp.118.1585953902199;
        Fri, 03 Apr 2020 15:45:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o14sm6399628pfh.147.2020.04.03.15.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 15:45:01 -0700 (PDT)
Date:   Fri, 3 Apr 2020 15:45:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] kbuild: do not pass $(KBUILD_CFLAGS) to
 scripts/mkcompile_h
Message-ID: <202004031544.FEFA2BF@keescook>
References: <20200403212459.13914-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403212459.13914-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 04, 2020 at 06:24:59AM +0900, Masahiro Yamada wrote:
> scripts/mkcompile_h uses $(CC) only for getting the version string.
> 
> I suspected there was a specific reason why the additional flags were
> needed, and dug the commit history. This code dates back to at least
> 2002 [1], but I could not get any more clue.

I would be alarmed to find it changing the version string with flags. ;)

> Just get rid of it.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=29f3df7eba8ddf91a55183f9967f76fbcc3ab742
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> 
>  init/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/Makefile b/init/Makefile
> index 30aa8ab11120..d45e967483b2 100644
> --- a/init/Makefile
> +++ b/init/Makefile
> @@ -35,4 +35,4 @@ include/generated/compile.h: FORCE
>  	@$($(quiet)chk_compile.h)
>  	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@	\
>  	"$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT)"	\
> -	"$(CONFIG_PREEMPT_RT)" "$(CC) $(KBUILD_CFLAGS)" "$(LD)"
> +	"$(CONFIG_PREEMPT_RT)" "$(CC)" "$(LD)"
> -- 
> 2.17.1
> 

-- 
Kees Cook
