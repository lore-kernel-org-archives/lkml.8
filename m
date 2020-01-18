Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F1FC33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 09:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2065B24689
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 09:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgARJgc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 04:36:32 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41487 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgARJgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 04:36:31 -0500
Received: by mail-oi1-f194.google.com with SMTP id i1so24456462oie.8;
        Sat, 18 Jan 2020 01:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nIAP5cG6K/C2mCPjVg0E+T86a04ru5M9t7rhH6PyWlM=;
        b=ZxKQbqMhHlD5AyZl3tOtIQaUaQffq21bJ8XoCgzUylybTQ7R4xRcKS5DusHx1wmPNZ
         J6IZqJ4aDlXEbXHB5S6UO/xK52Rnl6WeObsEzFWNYAyYJxCXZG2OPIbBVSQJaM2SoJD0
         wZ/RcvyUJFs9aj7cj/sfz4aNgn7aIJxOwwGM+hEFmc2rpXUkE3wRpHTh81bOGj8tkNtB
         CUviALAKxzC4jnYPJpdDHSyYP+1Vd1W6wVCDowZHo2SKqcdvMkpk3/Vex7lYjFxvsmjF
         RSpG6723TaznP4xcoxzFqP0N6+hw5QM4HbIseCgXYwcyygUXti7U9tVEYL7FDGQU6dZF
         8hCw==
X-Gm-Message-State: APjAAAXctmwC8yugBA8fp/DF149ESGexF0tD13+FR0BhEyqI1j1oKYai
        WZJnT4Pdw1GvZagpq4IIPI8tPNUAFjH2fojrlyw=
X-Google-Smtp-Source: APXvYqxF+VrrePZ2atzzLogO5TIEFetNA0fD2qRqEjpTJE6Tki/uYIIRcD71LLw38+H+wtjqoVVnBKmMWBRYrlt/8XQ=
X-Received: by 2002:aca:1a06:: with SMTP id a6mr6308768oia.148.1579340190993;
 Sat, 18 Jan 2020 01:36:30 -0800 (PST)
MIME-Version: 1.0
References: <20200118081356.22167-1-krzk@kernel.org>
In-Reply-To: <20200118081356.22167-1-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 18 Jan 2020 10:36:17 +0100
Message-ID: <CAMuHMdVTg+Amw6Epuqhd60pdUDeCbTzJ=7TNDLE0BQRgCLQHPQ@mail.gmail.com>
Subject: Re: [PATCH v2] sh: sh4a: Bring back tmu3_device early device
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2020 at 9:14 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Commit 1399c195ef50 ("sh: Switch to new style TMU device") converted
> tmu3_device platform device to new style of platform data but removed it
> from sh7786_early_devices array effectively removing last three timers
> and causing a warning:
>
>     arch/sh/kernel/cpu/sh4a/setup-sh7786.c:243:31:
>         warning: ‘tmu3_device’ defined but not used [-Wunused-variable]
>
> Fixes: 1399c195ef50 ("sh: Switch to new style TMU device")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
