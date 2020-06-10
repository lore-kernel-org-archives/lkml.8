Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7337C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 04:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90EAD2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 04:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk1wHTwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgFJE03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 00:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgFJE02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 00:26:28 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDCCC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 21:26:28 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c12so745977qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 21:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uuzVjejTljwZyC2LG9O6GmT4fGzCYibABHnoie8L85M=;
        b=Fk1wHTwHVh7QXbz12lBvWLX6om2xfoLmp1npI98BDTSDqgDsmAgnHh3+sXRadE/OK6
         6WArSIYe1lwkEOQpmhKaFqxExmEe+le9Z8Jbvii52sq8z7sxrccGqtxoXdCEC8fiU177
         hHod9ckDhtNKbPpVYHwrW6d0K5wJjEJxZC/uD1jE4BnhpNR7QUmavRQMhtnJXCHbJpK/
         dN1xKTse2Ww7kVcgPRpZeH/EX4e8ychJvhUIYYOtPEmMybCA5cOlpAMN7guDYvwm2Gl8
         LW3hLXFVHaEoNlZkB5bIQH7ABapsjHVQ5PT2/GmSrX1Ib7hqbK/jJmb61SZUqpRcfBCC
         cVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uuzVjejTljwZyC2LG9O6GmT4fGzCYibABHnoie8L85M=;
        b=hWRQh89bM5HVcpDJmXiTS0cipwqy8UD6tEfDpMYEr74IXNP55XL+Uqe6KasP/FASgp
         i+cACyp6oHWEnAx7Z575ShlSDFpDLx5MFOAkSFoOuo0RVkuj0Jz8fx4oig6rT8AzVdun
         8fCReMfuIb1w8kAdtgJxNwz4SBhzRQ8GKb2Qb3mjraX5n43QBeh9KIqID9LnrRJjWAUg
         odxxyf/1Uu/YW3dpSjPJctizzoiXPveRb8nvDm0fhDQ/BBTRCL9EFGpuB7Ayjp4j38Tv
         KU24xGW7tCjX2nL6zar8el5M5PFUqgUxIVqyKCBD0Q+YKKsjHTvPoTX8qtbZoRVDFGBh
         dr5A==
X-Gm-Message-State: AOAM532ldsEd2uFjjHVdFkuaaE+MTXIwzVvZQJ61sC5fN7ERYwU0f3i9
        njrOrrPOz7xOqlv5FMNX2ZejcHnL
X-Google-Smtp-Source: ABdhPJyPvl37MWBPD9JHUwT6iTHj91/2oTYb1aJHmEaf0GrBQjXKuh+jbW327FMPAK6OsWw3tyhu+g==
X-Received: by 2002:ac8:4892:: with SMTP id i18mr1286979qtq.344.1591763187215;
        Tue, 09 Jun 2020 21:26:27 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g51sm12742145qtb.69.2020.06.09.21.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 21:26:26 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 10 Jun 2020 00:26:24 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-all] Re: gcc-5: error: -gz is not supported in this
 configuration
Message-ID: <20200610042624.GA1950488@rani.riverdale.lan>
References: <202006092115.nevT7m8D%lkp@intel.com>
 <CAKwvOd=jjFS7XOWyYMZgLTYJtZ7uc=4dP-S4VhuyjNmT=2EcPw@mail.gmail.com>
 <20200609174954.cckelwl6etwztmhv@google.com>
 <05c88916-7d91-ad1a-1ea6-15167a994a0b@intel.com>
 <20200610005830.s6gus7r3umwgzozk@google.com>
 <c2c2c2db-439f-5c60-068d-e53adbe960c1@intel.com>
 <20200610031225.GA1917869@rani.riverdale.lan>
 <20200610032331.GA1928844@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200610032331.GA1928844@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 11:23:31PM -0400, Arvind Sankar wrote:
> On Tue, Jun 09, 2020 at 11:12:25PM -0400, Arvind Sankar wrote:
> > The output of gcc-5 -dumpspecs may also be useful.
> > 
> > The exact Kconfig check should have been
> > 	gcc-5 -Werror -gz=zlib -S -x c /dev/null -o /dev/null
> > 
> > I can't see how that would succeed if the a.c test didn't but maybe just
> > in case?
> 
> Oh wait, -S instead of -c. Which means it runs neither the assembler nor
> the linker, so gcc won't error out. But if that gcc was originally
> _configured_ with a version of binutils that doesn't support -gz=zlib,
> it will give an error on -c regardless of whether the runtime binutils
> would actually support it or not.

I think the below might be better than passing the option via -Wa, since
gcc will translate -gz=zlib into the right assembler option anyway, and
it will also generate an error if the compiler driver was misconfigured
and won't support the option even if the rest of the toolchain does,
fixing the config dependency.

Unless this doesn't work with Clang?

Alternatively (or even in addition), we should redefine cc-option to use
-c, it uses -S in the Kconfig version, apparently for speed, but -c in
the Kbuild version.

diff --git a/Makefile b/Makefile
index 839f9fee22cb..cb29e56f227a 100644
--- a/Makefile
+++ b/Makefile
@@ -842,7 +842,7 @@ endif
 
 ifdef CONFIG_DEBUG_INFO_COMPRESSED
 DEBUG_CFLAGS	+= -gz=zlib
-KBUILD_AFLAGS	+= -Wa,--compress-debug-sections=zlib
+KBUILD_AFLAGS	+= -gz=zlib
 KBUILD_LDFLAGS	+= --compress-debug-sections=zlib
 endif
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cb98741601bd..94ce36be470c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -229,7 +229,7 @@ config DEBUG_INFO_COMPRESSED
 	bool "Compressed debugging information"
 	depends on DEBUG_INFO
 	depends on $(cc-option,-gz=zlib)
-	depends on $(as-option,-Wa$(comma)--compress-debug-sections=zlib)
+	depends on $(as-option,-gz=zlib)
 	depends on $(ld-option,--compress-debug-sections=zlib)
 	help
 	  Compress the debug information using zlib.  Requires GCC 5.0+ or Clang
