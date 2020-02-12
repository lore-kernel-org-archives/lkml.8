Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85832C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADAE2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtezE3UK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgBLRbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:31:02 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38223 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgBLRbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:31:02 -0500
Received: by mail-vs1-f68.google.com with SMTP id r18so2030375vso.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 09:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgpctoHh6dg1wxvj3BzSThVl8kpcEhXa3sNGXPcFbT4=;
        b=BtezE3UKOP32S7Hgi6uAZOCn9BCk1YLzZTI/31neMRdDIAastd/PkKexEg5uWIeSlq
         /hFI/msrF2GQcVhisW/RaJNrJGmFkKA4SeD0lHwdM4ey9ghkS/K+yx90I62OEmTesdwF
         xzMU/2Mq+v9/Okdl/2mUjBYKqE6P9vJw2KVomx5TFhjbaK/lu0Q6tw2rFDTRVzvD2KxL
         boPGPbPxe+RpyEehZt6ohw9y9NodMcdQmgyDLVMfAAlCQ41OBvoUAldOafMsvbSOhhvM
         Ujf9+E+XNGlSxbjxgY5T1BHWqvckIdfOYnsyRjOxsWx6G6V+xqkaOcye9xpAB/GIw4Zn
         EW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgpctoHh6dg1wxvj3BzSThVl8kpcEhXa3sNGXPcFbT4=;
        b=BTtNqvPUhg+LpmzaHm/rHRHIwky3dnp2bqcXfZr32ZREQgpIAl4Zvc3i87VoSCYcKN
         KJa+ywz+S5k4tPtt59375NEhAFYpZ13pUObnzYoI2zR60iyTt/GUrabPp+XgjijhZ5L7
         BeE50TnXAv7sgkymTjZ0Vsnj1Jpq3Jm0zj3QMZAPkXnlfqaPkTzTgm93i1C6ap4EP1EY
         +Ix59rKLD1wpuaWLNdl0EYDBDrZOP+aFzBCEyK57EDpGHAduHD5kMJy7hW9H2w3uUCBb
         QWxNqWNAZeA8xt02WarocaMPQ/BkY1R0N0vvH01QuGHEzo8wP1IBZ0jzHGtv8zhgxz3v
         2emg==
X-Gm-Message-State: APjAAAWnG2x7CvzcO63KuiWkEjSYjjbcQ3aK56vyZPA9ria1uu0abH6G
        OoIoLYU0kaBLgEAMLgS4deu54gb1omr6Wgo4AyQZzA==
X-Google-Smtp-Source: APXvYqyjKo/YFw4KoPFfCCWJOIKf5+SsU5ZWgCMmPdEkaicagM609YliueP7WkCTKw6TDAOHNRXlU3z7/h7iIoQqHFg=
X-Received: by 2002:a67:f4d2:: with SMTP id s18mr12516774vsn.15.1581528660711;
 Wed, 12 Feb 2020 09:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200128184934.77625-1-samitolvanen@google.com> <20200128184934.77625-10-samitolvanen@google.com>
 <6f62b3c0-e796-e91c-f53b-23bd80fcb065@arm.com> <20200210175214.GA23318@willie-the-truck>
 <20200210180327.GB20840@lakrids.cambridge.arm.com> <20200210180740.GA24354@willie-the-truck>
 <20200210182431.GC20840@lakrids.cambridge.arm.com> <20200211095401.GA8560@willie-the-truck>
In-Reply-To: <20200211095401.GA8560@willie-the-truck>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 12 Feb 2020 09:30:49 -0800
Message-ID: <CABCJKucpq=zu7ikf+Q-f-v+6T-cbQCEb1setiZfFvHa8iw3erg@mail.gmail.com>
Subject: Re: [PATCH v7 09/11] arm64: disable SCS for hypervisor code
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 1:54 AM Will Deacon <will@kernel.org> wrote:
> Thanks, I missed that. It's annoying that we'll end up needing /both/
> -ffixed-x18 *and* the save/restore around guest transitions, but if we
> actually want to use SCS for the VHE code then I see that it will be
> required.
>
> Sami -- can you restore -ffixed-x18 and then try the function attribute
> as suggested by James, please?

Sure. Adding __noscs to __hyp_text and not filtering out any of the
flags in the Makefile appears to work. I'll update this in the next
version.

Sami
