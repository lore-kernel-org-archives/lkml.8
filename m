Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03014C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D464720692
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U7ikXblV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbgDMQZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731515AbgDMQZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:25:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E37C0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 09:25:33 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k18so3550401pll.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 09:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JwAO8xsQIwVha/87e1cz/mK2hxAGtEnUvhnRC7uNihg=;
        b=U7ikXblVAvb3djXivI6h+WdkdCl/w8DkMjW+939N5zQqYiKTgapLFuvy+uKG1MN+A+
         uOZtiYYZ46ikWI4iaUGn7ossQ/xj/GtPFiJhl2cvQGymKMCkKVshu9pKlH/w40kUlf2I
         uRCYO2+Lju8w6ys525kr+p7h3t3GZ11fpR6ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JwAO8xsQIwVha/87e1cz/mK2hxAGtEnUvhnRC7uNihg=;
        b=fYLEokfOjXfHGIipOL/00YIZiJiDat9B7clRpU0UhM73Qeag9whznbo/Z2iSPt/G1w
         pI7NZFJB+VEuQ2gvhpRQeNnSNKtWI16NjO2hT6zIYcgpXdyHql3may7hQh6VbAlg2tV7
         4MYfOAiZl/zl6zLvH2ziF+VL0FxcBeA0satGDvKxOyRw5qkAg+73JRX5w1m1ay3LsDI6
         vRhUhdDztotA2IlMiRNCRirzqfuowG9tPfekt3jT1s48Mu4PxyZn+yXPgsAIGp6aVZ38
         zvIB1T0qfGh1djZgob8c4UfWqX3dzQ5wP+UoZgYXg6P6/XihYdxcsiVVyIXUkPEBC6yh
         LRoA==
X-Gm-Message-State: AGi0Puahoi7kdS2dlS4Ak0VwuNEQ8mLoaEhlBa4VDbtXtQ4doXg6rQ6n
        JG5X6ZAihMZSnHeomIcgDQOY4J9Owng=
X-Google-Smtp-Source: APiQypK3pOQisc1e6Bfnk05jixfozTyE2Vw3OJ+nvZ31oIa0sQ+YeHv9MnXlWjairAS3SwoxJBbtzQ==
X-Received: by 2002:a17:90a:757:: with SMTP id s23mr22619308pje.166.1586795132812;
        Mon, 13 Apr 2020 09:25:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 71sm9372363pfw.180.2020.04.13.09.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 09:25:32 -0700 (PDT)
Date:   Mon, 13 Apr 2020 09:25:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, macro@linux-mips.org,
        clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Borislav Petkov <bp@suse.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] MIPS: Truncate link address into 32bit for 32bit
 kernel
Message-ID: <202004130925.F1B57BC7@keescook>
References: <20200413062651.3992652-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413062651.3992652-1-jiaxun.yang@flygoat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 02:26:49PM +0800, Jiaxun Yang wrote:
> LLD failed to link vmlinux with 64bit load address for 32bit ELF
> while bfd will strip 64bit address into 32bit silently.
> To fix LLD build, we should truncate load address provided by platform
> into 32bit for 32bit kernel.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Link: https://github.com/ClangBuiltLinux/linux/issues/786
> Link: https://sourceware.org/bugzilla/show_bug.cgi?id=25784
> Cc: Fangrui Song <maskray@google.com>
> Cc: Nathan Chancellor <natechancellor@gmail.com>
> --
> V2: Take MaskRay's shell magic.
> 
> V3: After spent an hour on dealing with special character issue in
> Makefile, I gave up to do shell hacks and write a util in C instead.
> Thanks Maciej for pointing out Makefile variable problem.
> 
> v4: Finally we managed to find a Makefile method to do it properly
> thanks to Kees. As it's too far from the initial version, I removed
> Review & Test tag from Nick and Fangrui and Cc instead.
> ---
>  arch/mips/Makefile             | 12 +++++++++++-
>  arch/mips/kernel/vmlinux.lds.S |  2 +-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index e1c44aed8156..18495568f03e 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -288,9 +288,19 @@ ifdef CONFIG_64BIT
>    endif
>  endif
>  
> +# When linking a 32-bit executable the LLVM linker cannot cope with a
> +# 32-bit load address that has been sign-extended to 64 bits.  Simply
> +# remove the upper 32 bits then, as it is safe to do so with other
> +# linkers.
> +ifdef CONFIG_64BIT
> +	load-ld			= $(load-y)
> +else
> +	load-ld			= $(subst 0xffffffff,0x,$(load-y))
> +endif
> +
>  KBUILD_AFLAGS	+= $(cflags-y)
>  KBUILD_CFLAGS	+= $(cflags-y)
> -KBUILD_CPPFLAGS += -DVMLINUX_LOAD_ADDRESS=$(load-y)
> +KBUILD_CPPFLAGS += -DVMLINUX_LOAD_ADDRESS=$(load-y) -DVMLINUX_LINK_ADDRESS=$(load-ld)
>  KBUILD_CPPFLAGS += -DDATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)
>  
>  bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y) \
> diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
> index a5f00ec73ea6..5226cd8e4bee 100644
> --- a/arch/mips/kernel/vmlinux.lds.S
> +++ b/arch/mips/kernel/vmlinux.lds.S
> @@ -55,7 +55,7 @@ SECTIONS
>  	/* . = 0xa800000000300000; */
>  	. = 0xffffffff80300000;
>  #endif
> -	. = VMLINUX_LOAD_ADDRESS;
> +	. = VMLINUX_LINK_ADDRESS;
>  	/* read-only */
>  	_text = .;	/* Text and read-only data */
>  	.text : {
> -- 
> 2.26.0.rc2
> 

-- 
Kees Cook
