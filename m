Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68533C54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4155B20714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 19:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJwuHni+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCXTjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:39:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39857 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgCXTjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 15:39:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id b22so9553969pgb.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 12:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FqoMGUJll9Veg+MpF7sippdoesIw0FFxb5gCdl/JcEs=;
        b=EJwuHni+oQ+OeokhHY9gt6Q8ZdryeMdfB7u++030DzDcuw1WPX98OZn3DFqtn5duew
         OkmR0nDFow+56mh1f+ZQ9+Rv+WbcAjhJII/oEoSC9rXixsk/WADTgV4/d/c5x0UWNHEO
         VYONcP9gnCTPA9oS+Yx8evMkSLdjLOKrYuePBVZHCcepkppIXY//vJCUZievm3oxeZNB
         cgtFFnC9j7wUiEPodlBB2YdgCThG4sgw85gWFPUGffcIIcjfiNSyjKF6gnvHIiazV/oL
         U+/vvuNAWx7IjMD/XJd4ZqNn6mTMnS9LaL7ziCQotnTUXXcfkQlSyav2aWMeSftTB1D+
         jaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqoMGUJll9Veg+MpF7sippdoesIw0FFxb5gCdl/JcEs=;
        b=jIv2xH37+Vvjl89be4TuNsWTVec5q9OfofsJ9GZiSJRiCxpgMuCU3iiZPuGiRNi9Vj
         1KySSAWEUIuP+quR7CYbrpKSlc+p91dOqy+2OEBSUAI4DOt4AZudbSByqFEACi0ZnCrv
         t8wNP/TehYBB/426wnfr87q56nDkf5OjG0tVBf4qnokONcufHwoTsvfgBS4fLPNb9S8P
         I40ImDURCQKyX11/pSd0NFj1jVZPzJ3Lp/BYryb2u/yEKgPG12kQyuEYE2TIpjtjyZhR
         N6RwT5fB5LDw9k76qUrICTzQrJqMU9+nsjbQmqcc+wFd0M/oRsa56JbkFbwFb2dyFqlv
         SB0Q==
X-Gm-Message-State: ANhLgQ0fM+sYZa4c0ARErb6vZsVid0qj3YS/3Sf/i3HIcnZ9FIudB0rZ
        JQaBonUCfO0m9aMNjYUQDCtd8sPPfyLR7/zr4gWdZg==
X-Google-Smtp-Source: ADFU+vuHCD6vCekZmASrJxBY4B7NrbsOlMmxgEx10j62oseaS81t5zvPERXGOe/446iPRII0JyXqNAJUBjBWa9/qJmE=
X-Received: by 2002:a63:a34d:: with SMTP id v13mr7687220pgn.10.1585078741157;
 Tue, 24 Mar 2020 12:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200324161539.7538-1-masahiroy@kernel.org> <20200324161539.7538-3-masahiroy@kernel.org>
In-Reply-To: <20200324161539.7538-3-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 24 Mar 2020 12:38:50 -0700
Message-ID: <CAKwvOdkjiyyt8Ju2j2O4cm1sB34rb_FTgjCRzEiXM6KL4muO_w@mail.gmail.com>
Subject: Re: [PATCH 3/3] kbuild: remove AS variable
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 9:16 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> As commit 5ef872636ca7 ("kbuild: get rid of misleading $(AS) from
> documents") noted, we rarely use $(AS) in the kernel build.
>
> Now that the only/last user of $(AS) in drivers/net/wan/Makefile was
> converted to $(CC), $(AS) is no longer used in the build process.

TIL that we don't actually invoke the assembler at all for out of line
assembly files, but rather use the compiler as the "driver".
scripts/Makefile.build:
329 quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
330       cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $<

Though I am personally conflicted, as
commit 055efab3120b ("kbuild: drop support for cc-ldoption")
since we do the opposite for the linker (we do not use the compiler as
the driver for the linker using -Wl,-foo flags).  I wish we were
consistent in this regard (and not using the compiler as the driver),
but that is a yak-shave+bikeshed (I typed out yakshed without
thinking; maybe a new entry for Linux kernel urban dictionary or The
Jargon File) for another day.

$ grep -nR --include="Makefile" '(AS)' .
Turned up only this change and the above referenced wan driver.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>


>
> You can still pass in AS=clang, which is just a switch to turn on
> the LLVM integrated assembler.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 16d8271192d1..339e8c51a10b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -405,7 +405,6 @@ KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
>  KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
>
>  # Make variables (CC, etc...)
> -AS             = $(CROSS_COMPILE)as
>  LD             = $(CROSS_COMPILE)ld
>  CC             = $(CROSS_COMPILE)gcc
>  CPP            = $(CC) -E
> @@ -472,7 +471,7 @@ KBUILD_LDFLAGS :=
>  GCC_PLUGINS_CFLAGS :=
>  CLANG_FLAGS :=
>
> -export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
> +export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC
>  export CPP AR NM STRIP OBJCOPY OBJDUMP OBJSIZE READELF PAHOLE LEX YACC AWK INSTALLKERNEL
>  export PERL PYTHON PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
>  export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
> --

-- 
Thanks,
~Nick Desaulniers
