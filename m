Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CFFC5321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1470421841
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0lqQZIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgDSPhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 11:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgDSPhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 11:37:06 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA1DC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:37:06 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id j4so5805975otr.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5HPkHkilPOStTzSXVFfPa6HLneZJ21Zsjdgq+nilkL4=;
        b=V0lqQZIHRClIouuiv23kabocfPPwew/MbrlMwaTf6BSgRjqx78x+A23spcrNOdFLdF
         rd+IofAHhan+XUkGuqna8/jgl6Emm4QjB3KwTfAzo3JwxChC0hgmlKoc+/SH5BcTLgg6
         g7m99/WPg2vT7fczC3Imxr3/oQOIu05OUy3IxypHcjXvOeQZhuivi8Vnct/kQ2JFEy+4
         suI0HzGCZj389zGJQsZw2gGBo4XSHic3l+ZptKWnfj5zJgkAl6J1bCSrSx8Z+3BmgM73
         HVxBnwKJz7nnqaEVfYDJHQxTH5arphxYMotF9ah2Q4sa6HxP7JjaTcwSYIK96/UfIVwf
         G16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5HPkHkilPOStTzSXVFfPa6HLneZJ21Zsjdgq+nilkL4=;
        b=IK058yzSgDbRXUkIXLX3aD8dY5a327H2moRLe0mDBSWRknWHUfwJH+BhWR7J+drmgB
         Vk7X9b5xgHUYCNQvmnkWAZviE0OGlhvdfXjrmkGQ+r5pFb+nRwDLZ6prY7zpHxl5acgD
         VFkvDCPrz5BhpBC9TD5xEvelutsoSZR6qyZHK9H3DMh03/f5lIYg3SqpGE0REE2huAAv
         I3jQSpeDlL9AtSkr7lun5cIlSuUzl6Vn5juLVDT/F+u3zXlMF1S2sgOSESP9LGuglMPQ
         fRBr72rkzD3M6GA/N1GHCOHWwpuozZZl6Dwu8G20OU+58KhlSyaWoC2n0SjoF1yGd13o
         TqpA==
X-Gm-Message-State: AGi0PuY4um92bLe6kGXFRoqOExOw5mAvcZf1FvkwH/jpEC3sfYu+Mh+d
        GeosvK/sBKEtlSmU9wd6mXM=
X-Google-Smtp-Source: APiQypJ4OTXmUT4H5orAHesfhbel+Qm1LfCizO7KwfZJZy2Mej3jk8Dt88rnYsKAjGjG8RjHc97IZA==
X-Received: by 2002:a9d:728e:: with SMTP id t14mr6631841otj.63.1587310625625;
        Sun, 19 Apr 2020 08:37:05 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id m12sm173807oov.41.2020.04.19.08.37.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Apr 2020 08:37:04 -0700 (PDT)
Date:   Sun, 19 Apr 2020 08:37:03 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tejun Heo <tj@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] kbuild: Set CLANG_VERSION only when Clang is used
Message-ID: <20200419153703.GA41789@ubuntu-s3-xlarge-x86>
References: <20200419123612.173187-1-sedat.dilek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419123612.173187-1-sedat.dilek@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 02:36:12PM +0200, Sedat Dilek wrote:
> Do like GCC_VERSION is set when GCC (see CC_IS_GCC) is used.
> 
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> ---
>  init/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 9e22ee8fbd75..c23f9d3d6d6c 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -25,7 +25,7 @@ config CC_IS_CLANG
>  
>  config CLANG_VERSION
>  	int
> -	default $(shell,$(srctree)/scripts/clang-version.sh $(CC))
> +	default $(shell,$(srctree)/scripts/clang-version.sh $(CC)) if CC_IS_CLANG
>  
>  config CC_CAN_LINK
>  	def_bool $(success,$(srctree)/scripts/cc-can-link.sh $(CC))
> -- 
> 2.26.1
> 

I don't understand the motivation behind this. The commit message needs
to be expanded upon or further clarification is needed.

CONFIG_GCC_VERSION is always set, either to 0 if using clang or the
actual version spit out by GCC so the commit message is not entirely
accurate.

It is done in the

    default $(shell,$(srctree)/scripts/gcc-version.sh $(CC)) if CC_IS_GCC
    default 0

way because it relies on the __GNUC__, __GNUC_MINOR__, and
__GNUC_PATCHLEVEL__ preprocessor macros to figure out the verison, which
clang also defines (to 4, 2, and 1 respectively) so it has to be done
this way to avoid confusing clang for GCC.

We can handle this in clang-version.sh so that CONFIG_CLANG_VERSION is
set to zero if CONFIG_CC_IS_GCC is set, just like CONFIG_GCC_VERSION:

if ! ( $compiler --version | grep -q clang) ; then
    echo 0
    exit 1
fi

CONFIG_CLANG_VERSION needs to be defined, otherwise we are breaking the
assumption that I made in commit df3da04880b4 ("mips: Fix unroll macro
when building with Clang").

With your patch and GCC 9.3.0 building malta_defconfig:

arch/mips/include/asm/r4kcache.h: In function 'blast_scache64_node':
arch/mips/include/asm/unroll.h:29:9: error: 'CONFIG_CLANG_VERSION' undeclared (first use in this function); did you mean 'CONFIG_LD_VERSION'?
   29 |         CONFIG_CLANG_VERSION >= 80000) &&  \
      |         ^~~~~~~~~~~~~~~~~~~~
/home/nathan/src/linux/include/linux/compiler.h:330:9: note: in definition of macro '__compiletime_assert'
  330 |   if (!(condition))     \
      |         ^~~~~~~~~
/home/nathan/src/linux/include/linux/compiler.h:350:2: note: in expansion of macro '_compiletime_assert'
  350 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |  ^~~~~~~~~~~~~~~~~~~
/home/nathan/src/linux/include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
/home/nathan/src/linux/include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
      |  ^~~~~~~~~~~~~~~~
/home/nathan/src/linux/arch/mips/include/asm/unroll.h:28:2: note: in expansion of macro 'BUILD_BUG_ON'
   28 |  BUILD_BUG_ON((CONFIG_GCC_VERSION >= 40700 ||  \
      |  ^~~~~~~~~~~~
/home/nathan/src/linux/arch/mips/include/asm/r4kcache.h:203:2: note: in expansion of macro 'unroll'
  203 |  unroll(times, _cache_op, insn, op, (addr) + (i++ * (lsize))); \
      |  ^~~~~~
/home/nathan/src/linux/arch/mips/include/asm/r4kcache.h:370:4: note: in expansion of macro 'cache_unroll'
  370 |    cache_unroll(32, kernel_cache, indexop,  \
      |    ^~~~~~~~~~~~
/home/nathan/src/linux/arch/mips/include/asm/r4kcache.h:376:1: note: in expansion of macro '__BUILD_BLAST_CACHE_NODE'
  376 | __BUILD_BLAST_CACHE_NODE(s, scache, Index_Writeback_Inv_SD, Hit_Writeback_Inv_SD, 64)
      | ^~~~~~~~~~~~~~~~~~~~~~~~

Cheers,
Nathan
