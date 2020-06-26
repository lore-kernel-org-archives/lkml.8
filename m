Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6FDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0B72075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tm6uhy3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgFZUTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgFZUS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:18:58 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DFDC03E97B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:18:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j1so5095389pfe.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SjdKzeH7GW9tQGsunBGfIcgoB4TuWBhVIwFN+ncvBXE=;
        b=Tm6uhy3i8keuHafctoH4MuP4dZ5blfAOikPg1Mlf5CHLIkopdkpyAFZI/u9bZwoURX
         X8shbqeQOPfH5Iyo1VLp9cMkDG+LeyHP3Oql7Nx4R5FFtRn/PB796zbp39sRouaHkGdj
         6eSxAbjnscbgL3gC9uEKsB4QlM7SqUZHn8pGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SjdKzeH7GW9tQGsunBGfIcgoB4TuWBhVIwFN+ncvBXE=;
        b=DLpiP7Nr1+BPHql+q2QNPKa5QE5tETwDk6Uby1LdSQtPEM3tYKjC+JGG4gEqFvJ/Od
         O/xJeh4kXFGRrS14jgl8rehYC2vpC8MEwuAlB8X0ZFYTU2K6fXfna4Di7QTbzoMOxpbW
         igIbhovyOGWw7Z/KgobAXdsO2brMdvZN3mae+EzYN9PMSCzL1aB3VgSaY+dlItj2TRve
         E5ZWaMPIky1nnnpxb/br9LIHLgsxwjr18M0EwQgoMXsqEXLUHlKarAt9W59XOWibToHI
         MiiN7qJ09rN63yBJlk7PJ8V5OSfYjw9Pb/B7qfJ2E8FMDjtjUyCeUjDIfn/n+WCkRa4X
         FBaA==
X-Gm-Message-State: AOAM533cKQaLtKayD+5MdvYoaMJ+aiqNJ0lFP8h42mi0E280HgOdG3LF
        NeO/5KYEzA8Ynw0hIngaKqY3Wg==
X-Google-Smtp-Source: ABdhPJzRLB1VAhnTAH//Vf34hhnhLIcox6EcBAnKlJDtzGp+8PwlZspufe0ZqKpRpx5poWE80d8uJA==
X-Received: by 2002:a65:4c4b:: with SMTP id l11mr411781pgr.123.1593202738300;
        Fri, 26 Jun 2020 13:18:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p12sm23389172pgk.40.2020.06.26.13.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 13:18:57 -0700 (PDT)
Date:   Fri, 26 Jun 2020 13:18:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kbuild: remove cc-option test of -fno-stack-protector
Message-ID: <202006261318.75C7FE339@keescook>
References: <20200626185913.92890-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626185913.92890-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 03:59:12AM +0900, Masahiro Yamada wrote:
> Some Makefiles already pass -fno-stack-protector unconditionally.
> For example, arch/arm64/kernel/vdso/Makefile, arch/x86/xen/Makefile.
> No problem report so far about hard-coding this option. So, we can
> assume all supported compilers know -fno-stack-protector.
> 
> GCC 4.8 and Clang support this option (https://godbolt.org/z/_HDGzN)
> 
> Get rid of cc-option from -fno-stack-protector.
> 
> Remove CONFIG_CC_HAS_STACKPROTECTOR_NONE, which should always be 'y'.
> 
> Note:
> arch/mips/vdso/Makefile adds -fno-stack-protector twice, first
> unconditionally, and second conditionally. I removed the second one.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
