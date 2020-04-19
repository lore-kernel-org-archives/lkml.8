Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058BCC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6EA2051A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 16:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKzTphq3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgDSQkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 12:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725793AbgDSQkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 12:40:18 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338FBC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 09:40:18 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m13so5916340otf.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9QGokbASH+rRhSFAtXBE2GuLj7uGicKVjdMS2NUclOc=;
        b=UKzTphq3hRxCj5bRykdrj49SrMU7pVT8Zd5h5xoVItv5Jnkf4jnIRoqom8oXaV9Iok
         /5eACl5Ocyc1MoBfEoNhVl/cks+iPGKAGwN2CWHKxY8Ys6LuKxb9iKHCZiVRI89p/M5Z
         m0XSOt/MB/qqhgcP3qzPfmv1/+PZqfOmDY1udPw+CzjQPYN9P4mIKl7Ef8q7WohE73R+
         1pOPRilJ9laWW6AzkgOiB5FqiN1icAF5cyBR98n1P3/mCt9McUvX9fCfET48uglFg9mH
         dZeUYejE21w+ePrKjcQkmEyxxVTKiP3cHxfgb9EqjO7mwurvCPnW2EDTcg2GIBSJFobl
         QGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9QGokbASH+rRhSFAtXBE2GuLj7uGicKVjdMS2NUclOc=;
        b=hEr82CXWDGUL9L2nQR6jsaDIXUNqroCzmD4kVVNzRw7Oh/MjKQA1pat/w9901sapjq
         7/vdq1zd317nC76qXhlT8H7h0GW6UEArYrPvokrctSWL2bc+7kyygd2IGAv9F5hG2lOM
         Klht1YeNHkw/FvFXSOR/orz/HZqoWS/B+4dK232YxWQyWaoYeW0M9+/MzeCa5MipaFuf
         SX4lfSQxJD+rktUOg5kXuI0hnjmr86a/N77p7CSsg8hPBZVTXx+tesbeZEMjtjkQZaAC
         kbrPkkwb9kV7L6YcG3ZIWIol/yNoP5X6QOjqiws7ARz0iSPGE4mbXUP+F+TQ8luD5HsF
         W3ZA==
X-Gm-Message-State: AGi0PuYTIFlpui9vltz1avuxe7bTJWboZYeVjWtAq5GHMx2K8yU8ksd+
        0dXrSFc0PcGHp+ebLFyqxWY=
X-Google-Smtp-Source: APiQypL/ytvdDK8FE6DvTrupkUsiz9U2ok9G/h/20DsGS14Daf6gx+QN52j+ES2uzjmaOxHzL2r4LA==
X-Received: by 2002:a9d:7558:: with SMTP id b24mr6721457otl.273.1587314417520;
        Sun, 19 Apr 2020 09:40:17 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id k26sm967539ots.3.2020.04.19.09.40.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Apr 2020 09:40:17 -0700 (PDT)
Date:   Sun, 19 Apr 2020 09:40:15 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jessica Yu <jeyu@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] kbuild: Rename and use BINUTILS_VERSION where
 needed
Message-ID: <20200419164015.GA7783@ubuntu-s3-xlarge-x86>
References: <20200419132142.173861-1-sedat.dilek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419132142.173861-1-sedat.dilek@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sedat,

On Sun, Apr 19, 2020 at 03:21:42PM +0200, Sedat Dilek wrote:
> In the first patch I introduced LD_IS_BINUTILS Kconfig.

This sentence can removed, this offers no context when applied to the
git tree.

> To be consistent in naming convention I renamed from LD_VERSION
> to BINUTILS_VERSION.

Is this the only motivation behind this patch? Is this fixing a bug that
you have notice or is it just because there is a linker aside from GNU
ld that works with the kernel?

> So, we have the double "LD_IS_BINUTILS" and "BINUTILS_VERSION"
> like "CC_IS_GCC" and "GCC_VERSION".
> 
> For the same reason I renamed the shell script to detect the GNU ld
> linker version.
> 
> In Documentation/process/changes.rst we use "binutils" and GNU ld
> binary is part of it (see [3]).

                            ^ Kind of weird to have 3 come before 1 and 2

I also don't think that linking to the documentation like that is
necessary.

> The patches "init/kconfig: Add LD_VERSION Kconfig" (see [1]) and
> "arm64: Kconfig: ptrauth: Add binutils version check to fix mismatch"
> (see [2]) added checks for binutils >=2.23.1 whereas binutils

                                       ^2.33.1

> version 2.23 is minimum supported version (see [3]).

I am not sure what relevance this parapgraph has to the patch?

If it is indeed relevant, it should be reworked to use the standard
kernel way of referring to commits:

    9553d16fa671 ("init/kconfig: Add LD_VERSION Kconfig")
    15cd0e675f3f ("arm64: Kconfig: ptrauth: Add binutils version check to fix mismatch")

instead of the title of the patch with a link to the web interface.

> I have renamed to BINUTILS_VERSION where needed.
> 
> [1] https://git.kernel.org/linus/9553d16fa671b9621c5e2847d08bd90d3be3349c
> [2] https://git.kernel.org/linus/15cd0e675f3f76b4d21c313795fe0c23df0ee20f
> [3] https://git.kernel.org/linus/Documentation/process/changes.rst#n79
> 
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> ---
>  arch/arm64/Kconfig                             | 2 +-
>  init/Kconfig                                   | 4 ++--
>  scripts/{ld-version.sh => binutils-version.sh} | 0
>  3 files changed, 3 insertions(+), 3 deletions(-)
>  rename scripts/{ld-version.sh => binutils-version.sh} (100%)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 40fb05d96c60..274ba9b3ac95 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1504,7 +1504,7 @@ config ARM64_PTR_AUTH
>  	depends on (CC_HAS_SIGN_RETURN_ADDRESS || CC_HAS_BRANCH_PROT_PAC_RET) && AS_HAS_PAC
>  	# GCC 9.1 and later inserts a .note.gnu.property section note for PAC
>  	# which is only understood by binutils starting with version 2.33.1.
> -	depends on !CC_IS_GCC || GCC_VERSION < 90100 || LD_VERSION >= 233010000
> +	depends on !CC_IS_GCC || GCC_VERSION < 90100 || BINUTILS_VERSION >= 233010000
>  	depends on !CC_IS_CLANG || AS_HAS_CFI_NEGATE_RA_STATE
>  	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_REGS)
>  	help
> diff --git a/init/Kconfig b/init/Kconfig
> index 520116efea0f..946db4786951 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -19,9 +19,9 @@ config GCC_VERSION
>  config LD_IS_BINUTILS
>  	def_bool $(success,$(LD) -v | head -n 1 | grep -q 'GNU ld')
>  
> -config LD_VERSION
> +config BINUTILS_VERSION
>  	int
> -	default $(shell,$(LD) --version | $(srctree)/scripts/ld-version.sh) if LD_IS_BINUTILS
> +	default $(shell,$(LD) --version | $(srctree)/scripts/binutils-version.sh) if LD_IS_BINUTILS

This is not the only place that ld-version.sh is used, all of these
spots need to be updated with the move.

$ rg --no-heading "ld-version.sh"
scripts/coccicheck:SPATCH_VERSION_NUM=$(echo $SPATCH_VERSION | ${DIR}/scripts/ld-version.sh)
scripts/coccicheck:    REQ_NUM=$(echo $REQ | ${DIR}/scripts/ld-version.sh)
scripts/nsdeps:SPATCH_REQ_VERSION_NUM=$(echo $SPATCH_REQ_VERSION | ${DIR}/scripts/ld-version.sh)
scripts/nsdeps:SPATCH_VERSION_NUM=$(echo $SPATCH_VERSION | ${DIR}/scripts/ld-version.sh)
scripts/Kbuild.include:ld-version = $(shell $(LD) --version | $(srctree)/scripts/ld-version.sh)
init/Kconfig:	default $(shell,$(LD) --version | $(srctree)/scripts/ld-version.sh)

>  config CC_IS_CLANG
>  	def_bool $(success,$(CC) --version | head -n 1 | grep -q clang)
> diff --git a/scripts/ld-version.sh b/scripts/binutils-version.sh
> similarity index 100%
> rename from scripts/ld-version.sh
> rename to scripts/binutils-version.sh
> -- 
> 2.26.1
> 

For what it's worth, I think the idea behind this patch is fine but I do
not think the first patch in the series is necessary. The only reason
that LD_IS_BINUTILS even exists is to hide BINUTILS_VERSION. However,
the only reason I have seen from you to do this is to match GCC_VERSION.
The reason that CONFIG_GCC_VERSION does not run gcc-version.sh is to
avoid mistaking clang for gcc due to the use of the __GNUC*__ macros.
scripts/ld-version.sh already returns zero for ld.lld so I think that
it is just sufficient to add CONFIG_LD_IS_LLD whenever we are ready for
it (I might have a reason to send it out today, we'll see).

$ ld.lld --version | ./scripts/ld-version.sh
0

Cheers,
Nathan
