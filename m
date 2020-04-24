Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26405C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F9F2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587695964;
	bh=3XofbPImmjDSk5ArvXWyZQJQDj8runMsYJmFIgh3Uow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wvP9JhNPABt8wzNDLqiTIWH0mIikZHUD9cd2YQWMPIYoo1+88ZVHbUWmxnoCXSkyb
	 RPL+ww4qHiz2xppyQ5+vXteiEmny6S23oTmE4y0790lagSUXCbXje9OLtLQ4S/Ei0z
	 qpW12wqW+qBe7yfFBgF8eDzjmSZECLv2M8qRDLC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgDXCjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:39:23 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:55401 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgDXCjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:39:22 -0400
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 03O2d0QZ016819
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:39:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 03O2d0QZ016819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587695941;
        bh=K0CCqutUEwkhzK4mn2L62I8lFdwRFAH0wGb3WIospz4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ck/myLmrRNZ+S45Ipn0CD50jejBv1AjUxvBn5zmfcEP4GNXa37pzqQOHf/MU7EUMv
         DeDnuNHSx6OJ3F9TpTwGkfCNG1tX/hAnbzkWSgnckcU0UGEzZ1ByFbdpkNZXOThHhM
         Ab8S+RRI10ew3f+WrQImdKP9gr48PkqtYMrFtl7LFNWbZ2pwU2QPuykmdOUq5iLpmC
         H2JVNVulPKgbAFy5ejnSS+EAm5CcdWXRN0C91By1cBAlsHY1zsnJVYJVQp7EaOPF5q
         WEFpPPY0+cFM8+prh+IX5UOGlTZ/fGgJsd9yWDB/v+63CHYTmm/jrfsLsN1UfOuL6F
         CuvUvdU9CkBeQ==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id g10so8024866uae.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 19:39:01 -0700 (PDT)
X-Gm-Message-State: AGi0PuYujIwjSRhoQHILp/Mgu5ncP1C//HewDYKmnD5HN44mPitvJApm
        jz3Do/qy7nRVw+vFgWo2qJ9Fh7lpDA/5tbjOoJw=
X-Google-Smtp-Source: APiQypJk0Gh5f5oZqDVtQhaq5o+g301yOxcn+U2MXZ7yT9vJGWYvQrdurQcUiyuZoWHIwai292ZEsN79Bjr42VsdtFU=
X-Received: by 2002:a67:6542:: with SMTP id z63mr6187125vsb.179.1587695940134;
 Thu, 23 Apr 2020 19:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200419132142.173861-1-sedat.dilek@gmail.com>
In-Reply-To: <20200419132142.173861-1-sedat.dilek@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 24 Apr 2020 11:38:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNATk1yfHdmGLvS2vwew1MgX2nFupgW7ZqHuk7ragBX5VQA@mail.gmail.com>
Message-ID: <CAK7LNATk1yfHdmGLvS2vwew1MgX2nFupgW7ZqHuk7ragBX5VQA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] kbuild: Rename and use BINUTILS_VERSION where needed
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 10:21 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> In the first patch I introduced LD_IS_BINUTILS Kconfig.
>
> To be consistent in naming convention I renamed from LD_VERSION
> to BINUTILS_VERSION.
>
> So, we have the double "LD_IS_BINUTILS" and "BINUTILS_VERSION"
> like "CC_IS_GCC" and "GCC_VERSION".
>
> For the same reason I renamed the shell script to detect the GNU ld
> linker version.
>
> In Documentation/process/changes.rst we use "binutils" and GNU ld
> binary is part of it (see [3]).
>
> The patches "init/kconfig: Add LD_VERSION Kconfig" (see [1]) and
> "arm64: Kconfig: ptrauth: Add binutils version check to fix mismatch"
> (see [2]) added checks for binutils >=2.23.1 whereas binutils
> version 2.23 is minimum supported version (see [3]).
>
> I have renamed to BINUTILS_VERSION where needed.



I do not think this is the right thing to do.

As the doc implies
https://lore.kernel.org/lkml/20200224174129.2664-1-ndesaulniers@google.com/T/
we support overriding CC, LD, ... etc. individually.
(such a usage might be rare with LLVM=1 syntax supported, though)



I'd rather want to stick to LD_VERSION
instead of the version of the tool suite.



config BINUTILS_VERSION
       int
       default $(shell,$(LD) --version |
$(srctree)/scripts/binutils-version.sh) if LD_IS_BINUTILS


This will leave BINUTILS_VERSION empty when LD=ld.lld,
but it looks strange if binutils is still used for other tools.




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
>         depends on (CC_HAS_SIGN_RETURN_ADDRESS || CC_HAS_BRANCH_PROT_PAC_RET) && AS_HAS_PAC
>         # GCC 9.1 and later inserts a .note.gnu.property section note for PAC
>         # which is only understood by binutils starting with version 2.33.1.
> -       depends on !CC_IS_GCC || GCC_VERSION < 90100 || LD_VERSION >= 233010000
> +       depends on !CC_IS_GCC || GCC_VERSION < 90100 || BINUTILS_VERSION >= 233010000
>         depends on !CC_IS_CLANG || AS_HAS_CFI_NEGATE_RA_STATE
>         depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_REGS)
>         help
> diff --git a/init/Kconfig b/init/Kconfig
> index 520116efea0f..946db4786951 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -19,9 +19,9 @@ config GCC_VERSION
>  config LD_IS_BINUTILS
>         def_bool $(success,$(LD) -v | head -n 1 | grep -q 'GNU ld')
>
> -config LD_VERSION
> +config BINUTILS_VERSION
>         int
> -       default $(shell,$(LD) --version | $(srctree)/scripts/ld-version.sh) if LD_IS_BINUTILS
> +       default $(shell,$(LD) --version | $(srctree)/scripts/binutils-version.sh) if LD_IS_BINUTILS
>
>  config CC_IS_CLANG
>         def_bool $(success,$(CC) --version | head -n 1 | grep -q clang)
> diff --git a/scripts/ld-version.sh b/scripts/binutils-version.sh
> similarity index 100%
> rename from scripts/ld-version.sh
> rename to scripts/binutils-version.sh
> --
> 2.26.1
>


-- 
Best Regards
Masahiro Yamada
