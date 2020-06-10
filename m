Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69E4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3F8207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PKCAOvlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgFJGhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgFJGhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:37:19 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EB8C03E96B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 23:37:19 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s23so670801pfh.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 23:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bdwBSggRu+Z581/Piu8KQ2RjIsACTTLqdaZd8fx9Zps=;
        b=PKCAOvlCIVqaHjPg+Ni+xqo/Pyq3jEZ1sJdWJdc6ZK7JeBzw3e/mkiUA7vFvXg+NRL
         TJg5g8g91N26eJlw/7jpqUMIUWO04c6fANuXmcHg31zoBTm0REpSU7WImlnGFJ80wvq2
         NZ8pr3Wnx7wh44sYKwG6HEcGRo3++agyUXB22ZFLcrE2raVn2j5nuvry2o2Rn02BZipg
         fYvLtlzxt2QSPaoW15FSiUb7buDqzSlEmtuEThjEBZ0lMiwEqY3gf1sJdSAsaijpCEMY
         oOtr4Cd/Sedwjo+qSPUryXOHuOO0xNVa4Bo443p7ln47v+JaeZK8MZ3IYZKS26c0AVLo
         xRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bdwBSggRu+Z581/Piu8KQ2RjIsACTTLqdaZd8fx9Zps=;
        b=AYhcVqSb3usS1O9I5bwlE3ytci5vcy74d+6oYq363RXWapxQzIHDyTkYrMLoHAHV4T
         2CeivNL5zVdZ3/m+xNNcaw8OqOKWaLgf2rT9KO1CmTgrcqNBkfuVR8+uU98SsahB9pyi
         IZHML8evRXniLKVJy+7Rz3MJSmHO3fxBtj1ueevG6gEh+o/IZ7EH6SQdeXgF9n5n+fwv
         +sPLe6tCmTvSsEkr0uh+4q3SycNNW7py3E//OKSYSB8Id0PP9u2N22l7rPdzy8KyQSLp
         mdX2QeC3P2OlUY0lF9CcQ/oOP/arWrlZijDPldW3l9LRbHeziiWwjn6ci0gQY+x9q+BG
         F00w==
X-Gm-Message-State: AOAM532T6q2kl96gxgcj/v8z4MfEPqOp8TmjGPdJpU+ViZHVtAeQW+O6
        9NjcjVWEZCP6hmiMjj/jKBU9yA==
X-Google-Smtp-Source: ABdhPJykZ4nITKTbZ++DR+foccMBiZOMaMyUMMQ+zcdhGOzXFnazBnvYQp5OHrR+J6KlH58s4sSnkg==
X-Received: by 2002:a63:fc0e:: with SMTP id j14mr1486725pgi.264.1591771038506;
        Tue, 09 Jun 2020 23:37:18 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id u128sm11611087pfu.148.2020.06.09.23.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 23:37:17 -0700 (PDT)
Date:   Tue, 9 Jun 2020 23:37:15 -0700
From:   Fangrui Song <maskray@google.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-all] Re: gcc-5: error: -gz is not supported in this
 configuration
Message-ID: <20200610063715.v2qrqvwtegdxdwzl@google.com>
References: <202006092115.nevT7m8D%lkp@intel.com>
 <CAKwvOd=jjFS7XOWyYMZgLTYJtZ7uc=4dP-S4VhuyjNmT=2EcPw@mail.gmail.com>
 <20200609174954.cckelwl6etwztmhv@google.com>
 <05c88916-7d91-ad1a-1ea6-15167a994a0b@intel.com>
 <20200610005830.s6gus7r3umwgzozk@google.com>
 <c2c2c2db-439f-5c60-068d-e53adbe960c1@intel.com>
 <20200610031225.GA1917869@rani.riverdale.lan>
 <20200610032331.GA1928844@rani.riverdale.lan>
 <20200610042624.GA1950488@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200610042624.GA1950488@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> But if that gcc was originally
> _configured_ with a version of binutils that doesn't support -gz=zlib,

I agree with this theory :)

On 2020-06-10, Arvind Sankar wrote:
>On Tue, Jun 09, 2020 at 11:23:31PM -0400, Arvind Sankar wrote:
>> On Tue, Jun 09, 2020 at 11:12:25PM -0400, Arvind Sankar wrote:
>> > The output of gcc-5 -dumpspecs may also be useful.
>> >
>> > The exact Kconfig check should have been
>> > 	gcc-5 -Werror -gz=zlib -S -x c /dev/null -o /dev/null
>> >
>> > I can't see how that would succeed if the a.c test didn't but maybe just
>> > in case?
>>
>> Oh wait, -S instead of -c. Which means it runs neither the assembler nor
>> the linker, so gcc won't error out. But if that gcc was originally
>> _configured_ with a version of binutils that doesn't support -gz=zlib,
>> it will give an error on -c regardless of whether the runtime binutils
>> would actually support it or not.
>
>I think the below might be better than passing the option via -Wa, since
>gcc will translate -gz=zlib into the right assembler option anyway, and
>it will also generate an error if the compiler driver was misconfigured
>and won't support the option even if the rest of the toolchain does,
>fixing the config dependency.
>
>Unless this doesn't work with Clang?

Clang>=6 supports -gz=zlib

>Alternatively (or even in addition), we should redefine cc-option to use
>-c, it uses -S in the Kconfig version, apparently for speed, but -c in
>the Kbuild version.

Unifying cc-option in scripts/Kbuild.include & scripts/Kconfig.include
sounds good.

>diff --git a/Makefile b/Makefile
>index 839f9fee22cb..cb29e56f227a 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -842,7 +842,7 @@ endif
>
> ifdef CONFIG_DEBUG_INFO_COMPRESSED
> DEBUG_CFLAGS	+= -gz=zlib
>-KBUILD_AFLAGS	+= -Wa,--compress-debug-sections=zlib
>+KBUILD_AFLAGS	+= -gz=zlib
> KBUILD_LDFLAGS	+= --compress-debug-sections=zlib
> endif
>
>diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>index cb98741601bd..94ce36be470c 100644
>--- a/lib/Kconfig.debug
>+++ b/lib/Kconfig.debug
>@@ -229,7 +229,7 @@ config DEBUG_INFO_COMPRESSED
> 	bool "Compressed debugging information"
> 	depends on DEBUG_INFO
> 	depends on $(cc-option,-gz=zlib)
>-	depends on $(as-option,-Wa$(comma)--compress-debug-sections=zlib)
>+	depends on $(as-option,-gz=zlib)
> 	depends on $(ld-option,--compress-debug-sections=zlib)
> 	help
> 	  Compress the debug information using zlib.  Requires GCC 5.0+ or Clang

This patch looks good.

(clang cc1as only supports(hardcodes) a limited number of -Wa, options
(it parses the options by itself, rather than delegating to GNU as like
GCC). If there is a compiler driver option, that is usually preferable)
