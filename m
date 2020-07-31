Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A31AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7068F2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rp7h8sZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgGaXPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgGaXPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:15:03 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98286C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:15:03 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o1so18122244plk.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nCQp2XW5TQTnjqYFZHvSZhTVs4EFzc12XTgjSHL4Kg0=;
        b=Rp7h8sZ9xi05gGgZ280TZGiQ12cpSWgXayVUx4WfTYxvj1dlDmfW7HQd9xESPJ4mir
         5X+m4y/W6b/z4DIqJi76VEtMbVpG33aj5njz/Vpw7EIZk2xPrhk1neuXtS0oG4e9zrzG
         /GpZD9HAzKqw8o+LZ5wvMciG9L1pr3Ahjxpf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nCQp2XW5TQTnjqYFZHvSZhTVs4EFzc12XTgjSHL4Kg0=;
        b=emwHwSnaujcO2NxIM1tFB9JBeSubAUeDWDISAmJEhttXK0PmJriJ49h1CtbC5S8tMy
         UXOBvUXakAnDVTqjb3LMM740VKV4GtRa4QiwVXAOmMBWXF+lYaIT1Amyw9loqf9+Rnry
         egtkUQnpznUtLkwU+aQhfEscoIX6NG+1UQVMYEua17H/t7pmaU6TAewK8OHQbKdpLLAI
         WFk4FayMqmLRoKF9PRM5mcWc0AdWe1EcCmqT7yWkH/a4POK3jnewr5JpHnjBPxNnY8O9
         HvOC6DknOxS1FDhM9UBPRHLfTjmIyHq8HUw5g0d2p59No8GRAM3uVn2onne1awULEm5c
         1vhA==
X-Gm-Message-State: AOAM531gaHXamOtVgHiUQufDF5DDESdL1flft5WYAv7YldjF6QvMsnxd
        Y90onnWAEF5LtV7z+KWKjRztQw==
X-Google-Smtp-Source: ABdhPJz7Dtj54wAMOMgS5hq2gpvxvpMJMknzUJD5awaMtOLjI9aGMflLyTLZ/mXlN27J6+1RnxWf1Q==
X-Received: by 2002:a17:90a:ee8d:: with SMTP id i13mr6399550pjz.19.1596237303243;
        Fri, 31 Jul 2020 16:15:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k21sm8109271pgl.0.2020.07.31.16.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:15:02 -0700 (PDT)
Date:   Fri, 31 Jul 2020 16:15:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] x86/boot: Remove run-time relocations from
 compressed kernel
Message-ID: <202007311612.78E132F3A1@keescook>
References: <CA+icZUV2=hj=+9DtbH47wtdE=GM5AZjS1xTgH7PKE+NxsRa2jw@mail.gmail.com>
 <20200731202738.2577854-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731202738.2577854-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 04:27:31PM -0400, Arvind Sankar wrote:
> Changes from v5:
> - Rebase onto v5.8-rc7 to resolve Makefile conflict

Heh, I just merged your series into mine for orphans (just sent it too)
and ironically, I did this too (rebase to rc7) but for ARM fixes on
Clang vs binutils AS.

Regardless, if it goes in separately, please consider this series:

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
