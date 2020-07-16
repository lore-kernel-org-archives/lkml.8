Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF167C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0772074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eu3ev43G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgGPMyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgGPMyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:54:49 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B82C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 05:54:49 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so6952651ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 05:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQI1oerBg67N/QEQ4aYPTUgh5UH04z0Y8Afk15C7qQo=;
        b=Eu3ev43Gj+jFZ2Micy2fEmYcl8drBi0P/k/9dv3SJQ4hIaFztEB8MVkTm9Vf8Jfplc
         qbLNBdkRs2Rk1t+yOtcwehSChqOf0ny/lQ8WDZIDEE1hcG5Y14IuhmaFdU7YqPLLr0e+
         BUFc/1uHgHz4ualc+bbUUcCjcirrrqOVDccm4Xmj1/PKO9sJeTBfoaA3WetpeWkKlGTh
         BmZQF40QA1eaBxTLgTWGabGh/zNYdBZtXokRESDLph9PxguKWlWEkmPE/BOrQLj0xWTF
         Df80+y3wSEDjPmXHrMnxo2L6/NzK0qjjzs5GY5IcLb975Rpo4uPmsKIFW/d3KsYjiZxe
         kqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQI1oerBg67N/QEQ4aYPTUgh5UH04z0Y8Afk15C7qQo=;
        b=McqVdw/yVhpvVq0ipEbTHWiIFzTb8Ysu25PWslGrAkEQQfOUzuL6rP6MeJ4q5zRo4p
         81zW0psyYscLGCRmer21sBK+qo/KWVU5jW+21jc3JW1un4IVUhhIDA7tXTQX01QW8U/D
         SopD0bAzJtfyksRru6p8jD683YysbgbJ9K9GWwEoXuO05NigrdOYbTZNllq/+XEnKjtS
         sWrM+/cJYO0A5VBig8rd/SctF66pEiGXxFmspj7TWxhvMXrIbXHYpKjZzXPdfxprxzaI
         i7c8NCXcIpsamoJGVwPNg3CNTlFDnBG0WMaJnWFZGpHVsgH7wR6lT+xWo4I1QAwAwqqv
         hGFQ==
X-Gm-Message-State: AOAM531Ea50mIFdKBor3xp3YliiJhYyHrTc551nO8mPjb/lAmDoJpwnW
        KlaRl7evq9GGwge04mvEset9xdwntSyZ7/KcUD52Ag==
X-Google-Smtp-Source: ABdhPJzQ+xr8K7uDdKRcwbGwycJoaG1dk8RlTTlU7MSPc38Pa89AEeS/T5p7WQEQhf+wQvhNQTS/GOwfO/JIzrmKYOA=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr1812907lji.338.1594904087965;
 Thu, 16 Jul 2020 05:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200711035544.2832154-1-palmer@dabbelt.com> <20200711035544.2832154-3-palmer@dabbelt.com>
In-Reply-To: <20200711035544.2832154-3-palmer@dabbelt.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Jul 2020 14:54:37 +0200
Message-ID: <CACRpkdY6TxH0rAY5Kn8MsM8RhN1hR-_RYkoUuCpqf9W0D8+0OA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm: Use the new generic copy_oldmem_page()
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     mick@ics.forth.gr, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Gregory Fong <gregory.0xf0@gmail.com>, masahiroy@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>, willy@infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>, paulmck@kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>, elver@google.com,
        David Gow <davidgow@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 5:59 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:

> From: Palmer Dabbelt <palmerdabbelt@google.com>
>
> This is exactly the same as the arm64 code, which I just into lib/ to
> avoid copying it into the RISC-V port.  This builds with defconfig and with
> CRASH_DUMP=y.
>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

Looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
