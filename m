Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74898C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C572074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2BEBkT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgGAGB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgGAGB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:01:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CA7C03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:01:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so22497306wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jYGdmK8Hzy+XdCP9J+mTabkdqEvz+CIYMp3kTcsPvHQ=;
        b=G2BEBkT6z2+PUweXjVNPwRj+A/ZL1LKXQRAI1NEZa/K7KwlNd31RowXCK+Zg+CARBm
         kSos7gxoJ2u9ktQlEDp5YctX8lIqA9bLW+ZnMzi4fTQFYAn7ysbZXAyo0neRHHKAgejF
         lCqFVRMHyhCX1O9mnv0py2lDjbGpYS6V0Jdf1AH2iEnJlNCtJw/IDw+LRXGniMVcL/aU
         OVkC20doGshligmWkjyE0RRkBdvC/dlz7PHgNGfmoxz/2M/dGSbSerLMASGp4XQGstZh
         D1XoD6i39t+kgCuTxiYSRN8Z9Wo3Ejmf3Szc1nui2IhtMDdYx2QD1hybyT6hQkxPl5Rc
         KnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jYGdmK8Hzy+XdCP9J+mTabkdqEvz+CIYMp3kTcsPvHQ=;
        b=oUqqpCIBfE3CHb0k/hoWUfQVuyT6JWVxdJ/349Fxy0JbrtbVSeeW+6rGamSp/75WIP
         fLWB6v2wpGzDidQPOPW4XjhX1PZ0UMsvWIfARC8RSnh9Vsa0Jop3A02PYOBqjdrG5KGA
         jsjucxHHRqFKLBjjA/CWsZJzBd30yIfYyqiQySqXrrnTBTARNfg3hR+U1fhycE+HlFqt
         lCOC+d5LGXeOrOAGe59UGyQX06KtYsXOVSr8zNl934RA6noPO/P3UKe11cEmCfGdUbwm
         vF7tn88N4ovPeENTSFksgbhR+iMI3+LPv55FqBWnsn7gO+9Hy3dZInK13AeU9NKvx2C6
         SLwg==
X-Gm-Message-State: AOAM533YSLXqf/Tnhrg1Q+S4zkSD+spcGfZ2bssVu/CdonvaYw7RfHq8
        LwKRtyTlJcyPgeA/IKeSp3dv+Q==
X-Google-Smtp-Source: ABdhPJyvzOBMPXBjEsrcPyOHGRd/yWk3oIUkZv8ncYvGDQ2tGTErYhNWIxT64gAX4UdYzMsG5R7jvw==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr23153721wrv.380.1593583316491;
        Tue, 30 Jun 2020 23:01:56 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id v66sm6100197wme.13.2020.06.30.23.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 23:01:55 -0700 (PDT)
Date:   Wed, 1 Jul 2020 08:01:50 +0200
From:   Marco Elver <elver@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        x86@kernel.org, linux-efi@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, paulmck@kernel.org
Subject: Re: [PATCH 1/2] kbuild: remove cc-option test of -fno-stack-protector
Message-ID: <20200701060150.GA1181113@elver.google.com>
References: <20200626185913.92890-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626185913.92890-1-masahiroy@kernel.org>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 03:59AM +0900, Masahiro Yamada wrote:
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
> ---
> 
>  Documentation/kbuild/kconfig-language.rst | 4 ++--
>  Makefile                                  | 2 +-
>  arch/Kconfig                              | 3 ---
>  arch/arm/boot/compressed/Makefile         | 3 +--
>  arch/mips/vdso/Makefile                   | 3 +--
>  arch/powerpc/kernel/Makefile              | 2 +-
>  arch/powerpc/platforms/powermac/Makefile  | 2 +-
>  arch/sparc/vdso/Makefile                  | 4 ++--
>  arch/um/Makefile                          | 3 +--
>  arch/x86/Makefile                         | 2 +-
>  arch/x86/boot/compressed/Makefile         | 2 +-
>  arch/x86/entry/vdso/Makefile              | 4 ++--
>  arch/x86/kernel/cpu/Makefile              | 3 +--
>  arch/x86/lib/Makefile                     | 2 +-
>  arch/x86/mm/Makefile                      | 7 +++----
>  arch/x86/power/Makefile                   | 3 +--
>  arch/x86/purgatory/Makefile               | 2 +-
>  arch/x86/um/vdso/Makefile                 | 2 +-
>  arch/x86/xen/Makefile                     | 5 ++---
>  drivers/firmware/efi/libstub/Makefile     | 2 +-
>  drivers/xen/Makefile                      | 3 +--
>  kernel/kcsan/Makefile                     | 3 +--

Is it possible that this patch drops the KCSAN portion? We have a patch
that is part of a series intended for 5.9 that also removes the
cc-option from -fno-stack-protector, but can't easily be dropped from
the surrounding series.

Please see: https://lkml.kernel.org/r/20200624190236.GA6603@paulmck-ThinkPad-P72

Thanks,
-- Marco
