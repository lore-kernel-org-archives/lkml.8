Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2801CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0495F206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 21:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ov00EPcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgG2VSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2VSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 17:18:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F16DC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:18:20 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k71so2648097pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 14:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g0KUC06W8wfVDa5/aZnaCNDXj9N7Ln444BL6AjoPMxY=;
        b=Ov00EPcpcds4iXOLfFieegwR7hRlUtJeKUY5QQkoF0Jh9tZT4y47ON4fxaZEsShZVi
         fUtVBaFg6UI206ysebvZU7XlJKrNCGUtO3b3dYfZbBpeEv2+k58TFlsv9W2l+H5RlU/x
         xMnrIcH5vYD2zHkhisMgP8KYicUzt69+3EeaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g0KUC06W8wfVDa5/aZnaCNDXj9N7Ln444BL6AjoPMxY=;
        b=JrV1n4IjJAfZfNIEdfwCtn9nXmYNmPZ2AyaFFPjG3rpt6xstSQoqyQ00U75xUhZRef
         mcPYNuiSb6LtQiIZfBExvX8h89u6f09yC5dJA+N62B++lL/rWTThy9qEP5NQXzYwHBCX
         HC50lNwAAYFvySmmcXfUBMd6453sbQdLdfV2DdU2H4KHMETR2HqkrXo7fffKULoGXLYG
         6rDgNRdTxp7SxOyzsAOalg69n9RgCkA8gb9hGq/numAr2WPY0y2uH7h+vRoq+i8O0Vcf
         EN22ZL7A4QxtAmgKjMkQXY8fjWFRj2P2b0GzQ5w5Njmrrm+/vMqWN+BiK9fCumY1R2oY
         HySw==
X-Gm-Message-State: AOAM530Gu/Wgjyo8rgzGJ20EY7bqUp70kFSDc2sklrJF33lBEkXZvoqE
        u55aTOYHv4gua70XBFCbfSEnPg==
X-Google-Smtp-Source: ABdhPJwi4J+xm/nvozPDUCQnat7NJCVcTCoGI36EfCZlyYLjp9/7AClfhzP1RAFLsh2ytY1lCy1vVg==
X-Received: by 2002:a17:90a:3488:: with SMTP id p8mr12222748pjb.211.1596057499443;
        Wed, 29 Jul 2020 14:18:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h63sm2367630pjb.29.2020.07.29.14.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 14:18:18 -0700 (PDT)
Date:   Wed, 29 Jul 2020 14:18:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Emese Revfy <re.emese@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kbuild: move shared library build rules to
 scripts/gcc-plugins/Makefile
Message-ID: <202007291401.A50E25BB@keescook>
References: <20200729031537.37926-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729031537.37926-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 12:15:36PM +0900, Masahiro Yamada wrote:
> The shared library build rules are currently implemented in
> scripts/Makefile.host, but actually GCC-plugin is the only user of
> them. Hence, they do not need to be treewide available.

Are none of the VDSOs intending to use these rules?

> Move all the relevant build rules to scripts/gcc-plugins/Makefile.
> 
> I also optimized the build steps so *.so is directly built from .c
> because every upstream plugin is compiled from a single source file.
> 
> I am still keeping the infrastructure to build a plugin from multiple
> files because Kees suggested to do so in my previous attempt.
> (https://lkml.org/lkml/2019/1/11/1107)
> 
> If the plugin, foo.so, is compiled from two files foo.c and foo2.c,
> then you can do like follows:
> 
>   foo-objs := foo.o foo2.o
> 
> Single-file plugins do not need the *-objs notation.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

But, yeah, sure!

Acked-by: Kees Cook <keescook@chromium.org>

Unrelated, but I do note that objtool maybe has the wrong indentation,
path name reporting, and tool names (HOSTLD vs CC)?

...
  HOSTCC  scripts/asn1_compiler
  HOSTCC  scripts/extract-cert
  HOSTCC  scripts/genksyms/genksyms.o
  YACC    scripts/genksyms/parse.tab.[ch]
  LEX     scripts/genksyms/lex.lex.c
  DESCEND  objtool
  HOSTCXX scripts/gcc-plugins/cyc_complexity_plugin.so
  HOSTCXX scripts/gcc-plugins/latent_entropy_plugin.so
  HOSTCXX scripts/gcc-plugins/structleak_plugin.so
  GENSEED scripts/gcc-plugins/randomize_layout_seed.h
  HOSTCXX scripts/gcc-plugins/stackleak_plugin.so
  HOSTCC  scripts/genksyms/parse.tab.o
  HOSTCC  scripts/genksyms/lex.lex.o
  HOSTCC   /home/kees/src/linux-build/plugins/tools/objtool/fixdep.o
  HOSTLD  arch/x86/tools/relocs
  HOSTLD   /home/kees/src/linux-build/plugins/tools/objtool/fixdep-in.o
  LINK     /home/kees/src/linux-build/plugins/tools/objtool/fixdep
  CC       /home/kees/src/linux-build/plugins/tools/objtool/exec-cmd.o
  CC       /home/kees/src/linux-build/plugins/tools/objtool/help.o
  CC       /home/kees/src/linux-build/plugins/tools/objtool/weak.o
...

-- 
Kees Cook
