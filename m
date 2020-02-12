Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17574C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07C821569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTUFnbqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgBLRgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:36:36 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42559 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLRgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:36:35 -0500
Received: by mail-ua1-f65.google.com with SMTP id p2so1172323uao.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 09:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oXC2J3nEK5SwOdFoK4ULqW0570rBTdySIYo3+gIlo9M=;
        b=WTUFnbqwYf+rL57s/FGxM1+vxE9Jz5IK7E+OqB1D8Yag+QT+LdUeuoco6oTC4zgy7L
         TKipBuXtB2O8hn6XUjmdUpdrUfke0F8SCdmbLI53UNP2BplyGiw6vXFuWmFYFzZtLQeN
         5wpar/5ILukP9S05BShLrDSCKEPCKcsSH/oAGyElM1PsKMhn2zidyE008XJx5PD7dUMg
         n4j6E1083epW+BkViMtDeuVftqlXVyhEyjY2m1kZGGBAfrXmhWXYSRy7y6cbm8taKOCJ
         y3l8mKYES7s2h2SOYn+hKiFfdkCBn2+SUUTjhfBmJGbvU+drkZVcb4Ou3zqNKzp4BpKd
         nG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oXC2J3nEK5SwOdFoK4ULqW0570rBTdySIYo3+gIlo9M=;
        b=Y4oVU/AhlH9eO/UCFQvp/cJnN2CK5oC+QwyLjIOd3y2w78QxBwNnnEpeH6OBNrVp+S
         g9udZ0OwZFV+VZpZHamNFprKEv4ow5AQbcxTPmkhgiecaeYRpX7oJfColCAlYhDlKNoH
         mcZxUX6yCc2UulhgSShtsmNtT/bc1AcTWnlMDEHfAYbK0Tu1G06zf5LXIVVnugJ388J8
         uPL+AFNDUitpt4hqsIzr9NM/82aGdjvFAFUxSSlJIFeigz/ovRiMeftauY5+OsuVRB8O
         xGdZ+jJ8LvqqOKgqtZuakFQcTbKhTjleVJy86sGSQSJNZlOTQiGy9XJrY24Cs+Q9hxp1
         gctA==
X-Gm-Message-State: APjAAAXN9pm7NzArLEDnzH5EkHzS8GvXYe4GGnnvfQ1+fVQQrDEH5Op8
        MdKZkejAOquzNJlOiMfXXJEVnoeCkisAoxrKi8dqGA==
X-Google-Smtp-Source: APXvYqySnCPpjBgnelV684/U07lYpWTQs3A+aOrC5t4BnyXhAn03wUz7JH8o/EDUYvzcfRllMDnDJ3B306fqXtaeZDQ=
X-Received: by 2002:ab0:422:: with SMTP id 31mr5283734uav.98.1581528994562;
 Wed, 12 Feb 2020 09:36:34 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200128184934.77625-1-samitolvanen@google.com> <63517cff-4bd6-bb6c-9a54-23de4f5fbb4a@arm.com>
In-Reply-To: <63517cff-4bd6-bb6c-9a54-23de4f5fbb4a@arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 12 Feb 2020 09:36:23 -0800
Message-ID: <CABCJKuff08oGqg-2WO-J=SkGHcX+2KCrqhmgVnQT7ujKGUcvag@mail.gmail.com>
Subject: Re: [PATCH v7 00/11] add support for Clang's Shadow Call Stack
To:     James Morse <james.morse@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Tue, Feb 11, 2020 at 5:57 AM James Morse <james.morse@arm.com> wrote:
> I found I had to add:
> | KBUILD_CFLAGS := $(filter-out -ffixed-x18 $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
>
> to drivers/firmware/efi/libstub/Makefile, to get this going.

Ah, good catch!

> I don't think there is much point supporting SCS for the EFIstub, its already isolated
> from the rest of the kernel's C code by the __efistub symbol prefix machinery, and trying
> to use it would expose us to buggy firmware at a point we can't handle it!

Yes, fully agreed.

> I can send a patch if its easier for you,

It's not a problem, I will include a patch for this in v8.

Sami
