Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082E2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF8520644
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgDGLOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 07:14:19 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36739 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbgDGLOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 07:14:19 -0400
Received: by mail-oi1-f195.google.com with SMTP id k18so1129161oib.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 04:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6LFIhFPtPPKJ3ndghHuNkRs8YK+fMEM1IjmTl+p5MPs=;
        b=iYuJbmqJH5abSIKPAw4GCnRAu5+28RRuPDmyExIN43517PnZYuwuzZQVcznQYuH4S9
         w/sH3PWiCT5U8qZvhPnsyg+MoPMSaODv2i6uWnfPtk0UJjC+BtC6wmFvtokqoIWBYgQL
         rAn3TGHsV0a+3euIpsi3s/osOOz3d9JdlmLWp4iEI4HLzWzKKB7eDfaNifA1x0g2bFRA
         277R5KIdUUAhl9Lg2WJiCfSKp53dkkZXZrzf5nFVaQjFkBNmuYMHj+BQ3pJGkN5svyGH
         pZJZgjNi0ooN3uB1uV4yY4ceIr1JWUmXJyEKOTjaSJ6TPbwj0+HonLGbumSmuim+ZfvW
         GuPg==
X-Gm-Message-State: AGi0PuZYAbRh9u/6cB8/2nbBhergwAK/8kqmdz67eBl+7VMMvTrNqKzq
        USJfJVELf6WzdgsU77s1sWnWYqQgiYqXwpSJRnI=
X-Google-Smtp-Source: APiQypLaq1/7PvbU+aucJpFvKxhOnhbk0dV8Qd3pppkFhUN10n44mcY0arNBmKRwHIkNZilLzSf/4/95JSUapvY/ftg=
X-Received: by 2002:aca:4e57:: with SMTP id c84mr1165333oib.148.1586258058642;
 Tue, 07 Apr 2020 04:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200407103537.4138-1-max.krummenacher@toradex.com> <20200407103537.4138-4-max.krummenacher@toradex.com>
In-Reply-To: <20200407103537.4138-4-max.krummenacher@toradex.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Apr 2020 13:14:07 +0200
Message-ID: <CAMuHMdUBMwwBNhBABu-9=oz02hO2=vPkMjUyG=Q43FPTPMxJjg@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: defconfig: ARCH_R8A7795: follow changed config
 symbol name
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Olof Johansson <olof@lixom.net>, Li Yang <leoyang.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Tue, Apr 7, 2020 at 12:36 PM Max Krummenacher <max.oss.09@gmail.com> wrote:
> Completes commit b925adfceb52 ("soc: renesas: Add ARCH_R8A7795[01] for
> existing R-Car H3") and commit 361c5dbb446e ("arm64: dts: renesas:
> Remove use of ARCH_R8A7795").
>
> CONFIG_ARCH_R8A7795 was split in CONFIG_ARCH_R8A77950 and
> CONFIG_ARCH_R8A77951.
>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Thanks, as I was going to send a similar patch after v5.7-rc1:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
