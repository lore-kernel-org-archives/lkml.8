Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ED0C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5439F20708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZkeFAxUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgEFQaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727984AbgEFQah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:30:37 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987CBC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 09:30:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so700318plt.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 09:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSjnrz5Vzljlo+S0Gi3AV1DTWDDAqSfmJlTYocyrdsk=;
        b=ZkeFAxUbekfJwC2o06fNIeey9P7PB2Qx6C1+Qrildh1CFbeFrtdTEjhXY/ZMNwFvna
         d0XF81yNlhn2n0F+SH2RxmoN+HIQfXvvtqRabHX/97UW5SVsZJKDKDRq94BMEiLZWr1i
         53fMZxke9i6N6mBIPdYWM8w6BMDgXW+0Ft/SVgX2NDmLxAKDhFN51BzwbETYTfbe76mm
         HHUicr0w8Mi3f8bA3EvYUeUrw16iFKZXr04RHyqjzvL+M3bhGWk/TIXEbZef71tthlA2
         gIMh/ZFnZ0RoNxAnLLwtK9CiwPIH1s1Gub5YxtHC6ydbaldo2QESOisz2MAuBBg8+Bav
         VMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSjnrz5Vzljlo+S0Gi3AV1DTWDDAqSfmJlTYocyrdsk=;
        b=Wm/yrDV8cmtFk26zpI+D3mTG4p1OHmp1pjvg/uOg4JFREExAseKCiRCEJdiolJpttR
         lwJIzpPQN8Yls8CfInbHWznws8EJATHsD0G1kLbUzuQRw6H7ncZtmZNMwhfPXt6l9Ev7
         4/U/yprbYYrlNv/oYX3IpVHw8B3ZssYcOVMP8f2y4FcZpkiKEzNcD5nBbZJJ+gad+7vi
         kXSYmYNzrBfbiBAbTg7Cw1e0aO3VIy37+BDtnnCDqyTes84r0OjhRhnHjt9JSS++aBoE
         B54ou0eNLBE7Diha7IrgopZywAvgXp4k4c+mtO5fBNsIPEg5/sRgHCHHekiojQ+ED9Jt
         2HLA==
X-Gm-Message-State: AGi0PuaawiHmkL8fkC5tmYtwJ1U8E8idRtAZwxF/lFV9LtgwymzktT9P
        xMjwyhm7qKOYe9+vwT6+cLiyijrLqBBj7IYAX1vShQ==
X-Google-Smtp-Source: APiQypI/2tUEf/LWuDyr+l3pch7HVeD/FvpgS6/HbKXsqYXckx9cygldYoN8f/BE+1kjhtulXGXT5y/a8FmNpOUa1jk=
X-Received: by 2002:a17:90a:6488:: with SMTP id h8mr10301547pjj.51.1588782636724;
 Wed, 06 May 2020 09:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200505141257.707945-1-arnd@arndb.de> <20200505142556.GF82823@C02TD0UTHF1T.local>
 <20200505194243.5bfc6ec6@blackhole> <20200506034523.GA564255@ubuntu-s3-xlarge-x86>
 <CAK8P3a24EiEvGAenL0FdgGakmwWi=giReOJuiisnzkgC_SuhZg@mail.gmail.com>
 <20200506153156.GA1213645@ubuntu-s3-xlarge-x86> <20200506154556.5fsxzs3vbfwixggd@google.com>
In-Reply-To: <20200506154556.5fsxzs3vbfwixggd@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 6 May 2020 09:30:25 -0700
Message-ID: <CAKwvOdnKn0AZTdaesEqG=uEJXzK+rQK=KJxqDQCFqAMFrPKWkg@mail.gmail.com>
Subject: Re: [PATCH] arm64: disable patchable function entry on big-endian
 clang builds
To:     Fangrui Song <maskray@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Torsten Duwe <duwe@lst.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Torsten Duwe <duwe@suse.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Julien Thierry <jthierry@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 8:46 AM 'Fangrui Song' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
> Created https://reviews.llvm.org/D79495 to allow the function attribute
> 'patchable_function_entry' on aarch64_be.
> I think -fpatchable-function-entry= just works.
>
> Note, LLD does not support aarch64_be
> (https://github.com/ClangBuiltLinux/linux/issues/380).

I've approved the patch. Thanks for the quick fix.  Looks like we
backported -fpatchable-function-entry= to the clang-10 release, so we
should cherry pick your fix to the release-10 branch for the clang
10.1 release.

I'd rather have this fixed on the toolchain side.

-- 
Thanks,
~Nick Desaulniers
