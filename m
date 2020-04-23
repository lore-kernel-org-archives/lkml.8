Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EACAC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475F520704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nf99pkAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgDWSoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgDWSoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:44:10 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1745C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:44:08 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d184so3409587pfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0juQPPe5rfRYSQ0Sh7WpR1oaLBLNzpfp7k0pnwTsjA=;
        b=nf99pkAuh1886jnD1pD9AAVRyG01kUAF5rURTolpq38wDz4htD37J1PDSYZTjVI2Or
         lGHHWJpYCL9unS7mj3upVRBLf6J0jmaeHYX+0X/XOm5h4CBATvpeJJPFt09a3nluPDcp
         9BtcSYLdnbf4rkv+Ialeojr3kWeqoUIpJm6supGekPtN5G1Hib8EXwCTIzR6QTjdwF8g
         oJu4pHvkh0mnwFvkzy4WjEwp9ekcLekzPGNCtW6BkJTU71xrKpgIJ3TrnCKyz7gGl0qJ
         rL6DiuJS21xAreoN9xSXCRaP8ZQKF0L9SgVlA8L6w/zeOAmxpPAeW1OKag/qCPsvFIG2
         fhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0juQPPe5rfRYSQ0Sh7WpR1oaLBLNzpfp7k0pnwTsjA=;
        b=sF7ErhK5/P0HXnIIX+JBRJlbnjZGOCe7I7ETlB0ggmzEGZaGTOcZnz15oQMB8ekhJW
         KhOFiSNPFK+aKZNZdycAWR6pByJYc+jGiMRS4XLfUIlZTSxxVfwVYkeBJltkIkgkt7eH
         G3UKXc+uN4PjJegWQeQzHk7pT9iSV7WEe1aXv7z7ZqShzsZpxAoD+v1xS2K2PPRV4OZS
         OBAfCnvJKueomuCjq2uu3wC+9z37Y5Y89FzmLW6de7KNfI21Md8OwYTUmheMhoaKrtw7
         wPcRehANeY+7+Cdxy7XaXFeNpKB6DBHzzo4wNKKYK+2ZqBJWj8sBzrVgegu9hv707gXV
         PH9A==
X-Gm-Message-State: AGi0PuY02X7n7xvOge7lBaghKQ5K7x7Wkeg7f7iu6PgtuD9Xlaq13K9y
        RNtna3ElvG6P2i4Jzg1JPLIas0uuVISMV4G73iOX0A==
X-Google-Smtp-Source: APiQypLxhNHAyFaOMhFQH7PUIEWWQyowerZtHbxmvOrYczfM6Zupu2DMZMEabFtaU4B1kJHOts++WJdYzXy/14KY0p4=
X-Received: by 2002:a62:146:: with SMTP id 67mr5168262pfb.169.1587667447736;
 Thu, 23 Apr 2020 11:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200419131947.173685-1-sedat.dilek@gmail.com>
In-Reply-To: <20200419131947.173685-1-sedat.dilek@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 23 Apr 2020 11:43:56 -0700
Message-ID: <CAKwvOd=Rt0q0+nRJasc8GzOXSj1_-jZGNc2bAWJkmd7Vzr8FFw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] kbuild: add CONFIG_LD_IS_BINUTILS
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 6:19 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> This patch is currently not mandatory but a prerequisites for the second one.
>
> Folks from ClangBuiltLinux project like the combination of Clang compiler
> and LLD linker from LLVM project to build their Linux kernels.
>
> Sami Tolvanen <samitolvanen@google.com> has a patch for using LD_IS_LLD (see [1]).
>
> Documentation/process/changes.rst says and uses "binutils" that's why I called
> it LD_IS_BINUTILS (see [2] and [3]).
>
> The second patch will rename existing LD_VERSION to BINUTILS_VERSION to have
> a consistent naming convention like:
>
> 1. CC_IS_GCC and GCC_VERSION
> 2. CC_IS_CLANG and CLANG_VERSION
> 3. LD_IS_BINUTILS and BINUTILS_VERSION
>
> [1] https://github.com/samitolvanen/linux/commit/61889e01f0ed4f07a9d631f163bba6c6637bfa46
> [2] https://git.kernel.org/linus/tree/Documentation/process/changes.rst#n34
> [3] https://git.kernel.org/linus/tree/Documentation/process/changes.rst#n76
>
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>

Just some background on Sami's patch.  Originally we were using
ld.gold (for LTO for Pixel 3) before moving to ld.lld (for LTO for
Pixel 4 and later).  Not sure if Kconfig would be a better place to
check if gold is used, then warn?  I kind of prefer the distinction
that binutils contains two different linkers, though if no one is
supporting ld.gold, and it doesn't work for the kernel, then maybe
that preference is moot?

> ---
>  init/Kconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 9e22ee8fbd75..520116efea0f 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -16,9 +16,12 @@ config GCC_VERSION
>         default $(shell,$(srctree)/scripts/gcc-version.sh $(CC)) if CC_IS_GCC
>         default 0
>
> +config LD_IS_BINUTILS
> +       def_bool $(success,$(LD) -v | head -n 1 | grep -q 'GNU ld')
> +
>  config LD_VERSION
>         int
> -       default $(shell,$(LD) --version | $(srctree)/scripts/ld-version.sh)
> +       default $(shell,$(LD) --version | $(srctree)/scripts/ld-version.sh) if LD_IS_BINUTILS
>
>  config CC_IS_CLANG
>         def_bool $(success,$(CC) --version | head -n 1 | grep -q clang)
> --
> 2.26.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200419131947.173685-1-sedat.dilek%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
