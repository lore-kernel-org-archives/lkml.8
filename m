Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C0DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F352089D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QypkpiSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgFZUVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZUVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:21:52 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FA0C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:21:53 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j1so5098274pfe.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mCCNxLWvOEPbR1jlpJw8AgOuTdUdrqJ6GuWfi7uxTow=;
        b=QypkpiSsx4NUwMWxcUn+8hePyF1+R2042GPj2XUDzNHJadpb6r+7aOaNBGB70MTNuG
         MLJtSscoNogqziRuqfrwx+9ELZoJAm3hPZrH7CiW+G/4HKkqtcUubzBzcLxs9Ny9D6yK
         UZOoZ/Iy2mRWZiJ2nV3raq74FOeM7j5zXApjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mCCNxLWvOEPbR1jlpJw8AgOuTdUdrqJ6GuWfi7uxTow=;
        b=SJr3I1Z6DuY90n99G18Vu9KLoyVnVXBBLS/QROqFHtDMWgsGKVsX9KlK3Vu68R9QAp
         /TAuE39hIMMcEKDcup+OGZ4fo6SOktGAAyQXDt9tyyQ8ljuBzh/0IBO4167ug+6j5VNL
         lFpKLP63Xzs8ldiH77tZdWoQbHCSXEwIko04pwwaY7drMuK1On6gkeqm/yjZcQMfDbwx
         VvmZlPm2btJ6yqFzFWAuJjxcIITPK/0fPYQBYBC952URHV1WiWu3V6RfgZqjK8aAocD0
         M22TCjjhlflP4ATOpN89N4iCg9pcGduZqsh65G/0uzFcsazasZUkEsW++vr3qgU9ueLR
         L32g==
X-Gm-Message-State: AOAM533SDfztcQpmIiGJXOzBwfv6x76gjrry+NpjHUBinBz2yBnjIRNZ
        q9di8IcRHylUIKd+qtwdPiFajA==
X-Google-Smtp-Source: ABdhPJzzKO0Y6uxrVG0V0dlF6eO3WerWosOLQ/7tIGgWjqtKUKIB7ff57STce4b/Hd01Er7roSIa0Q==
X-Received: by 2002:a63:1910:: with SMTP id z16mr441252pgl.50.1593202912639;
        Fri, 26 Jun 2020 13:21:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o8sm15798576pgb.23.2020.06.26.13.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 13:21:51 -0700 (PDT)
Date:   Fri, 26 Jun 2020 13:21:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kbuild: remove cc-option test of -fno-stack-protector
Message-ID: <202006261319.F130204@keescook>
References: <20200626185913.92890-1-masahiroy@kernel.org>
 <CAKwvOd=V_M43CP7G87K3TqSsxua2NcXPz6BnDt-z6167O2WAzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=V_M43CP7G87K3TqSsxua2NcXPz6BnDt-z6167O2WAzQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 01:13:20PM -0700, Nick Desaulniers wrote:
> On Fri, Jun 26, 2020 at 12:00 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > +++ b/Makefile
> > @@ -762,7 +762,7 @@ ifneq ($(CONFIG_FRAME_WARN),0)
> >  KBUILD_CFLAGS += -Wframe-larger-than=$(CONFIG_FRAME_WARN)
> >  endif
> >
> > -stackp-flags-$(CONFIG_CC_HAS_STACKPROTECTOR_NONE) := -fno-stack-protector
> > +stackp-flags-y                                    := -fno-stack-protector
> >  stackp-flags-$(CONFIG_STACKPROTECTOR)             := -fstack-protector
> >  stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
> 
> So it looks like the previous behavior always added
> `-fno-stack-protector` (since CONFIG_CC_HAS_STACKPROTECTOR_NONE was
> always true), but then we append either `-fstack-protector` or
> `-fstack-protector-strong` based on configs.  While that's ok, and you
> patch doesn't change that behavior, and it's good to be explicit to
> set the stack protector or not...it seems weird to have
> `-fno-stack-protector -fstack-protector` in the command line flags.  I
> would prefer if we checked for not having CONFIG_STACKPROTECTOR or
> CONFIG_STACKPROTECTOR_STRONG before adding `-fno-stack-protector`.
> That doesn't have to be done in this patch, per se.

No, it would add only what was latest and most selected. (They're all
":=" assignments.) If CONFIG_STACKPROTECTOR_STRONG, only
-fstack-protector-strong is set. If only CONFIG_STACKPROTECTOR, only
-fstack-protector is set. Otherwise -fno-stack-protector.

-- 
Kees Cook
