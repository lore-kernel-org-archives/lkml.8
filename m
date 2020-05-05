Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1DBC47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945702078C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbgEEQqG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:46:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45215 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbgEEQqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:46:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id e20so2190974otk.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 09:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z6UHvy2bHC+nGKEgleyx66e5s4xYSM4ddKdZ92ukujI=;
        b=siK8bPzfROX0AjrH1UleE6OS55wpdhfE8IUETg4oP8MG7M8cFx+D/tw7DOokqnUObo
         gZmaahIH0tGA/npUxU6NztaBVvTyfGsLHwRPevZZIiHD13qOnrtr7YiF3nCzwrLMN4ac
         5J9Zw42khdSbZvjw0UV4tvuTmEFTtLLZ6t29YD+yZ0o8QtKzOZcGEFvOx01PGx8iO+TY
         iFLqXdFFA8mkFWZyCfixTchN+3rjAu1AiLtg6Mdxhk8ExZhwlcv1ACywZiSPMMTMZ82B
         NKz3rX9+H9r1Ddxk+s2NooxwtdDEOcaRhO7ygSVY3loZfipqRXwCELkSyjRTf7cymVua
         dfrw==
X-Gm-Message-State: AGi0Pub1KKreePHLuCwYMVIXjc6hrnI9qiwVoYAvZMQH0oNpbO2g+cF7
        Pad1wHBJtuNFzngICmi0j4POehgfoqUPR19nKKU=
X-Google-Smtp-Source: APiQypKn5MJKeov3FJiyGU/+h6MprJimE68UiK/y9uNzlvdl+FAS/+uz04/AP2C7f04oGFlgotwushGAOdc5bpFUhLY=
X-Received: by 2002:a9d:7d85:: with SMTP id j5mr2786941otn.107.1588697164048;
 Tue, 05 May 2020 09:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200505150722.1575-1-geert+renesas@glider.be>
 <20200505150722.1575-3-geert+renesas@glider.be> <89ad77c9-4bc8-039e-1ba5-e8eb67734597@suse.de>
In-Reply-To: <89ad77c9-4bc8-039e-1ba5-e8eb67734597@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 May 2020 18:45:52 +0200
Message-ID: <CAMuHMdV=+J0_d0bUSKtfhkAqDy02aGZwm9fgO2rMpF1rVBTPiA@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] ARM: actions: Drop unneeded select of COMMON_CLK
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
List-Id: <soc.lore.kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        arm-soc <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Tue, May 5, 2020 at 6:04 PM Andreas Färber <afaerber@suse.de> wrote:
> Am 05.05.20 um 17:07 schrieb Geert Uytterhoeven:
> > Support for Actions Semi SoCs depends on ARCH_MULTI_V7, and thus on
> > ARCH_MULTIPLATFORM.
> > As the latter selects COMMON_CLK, there is no need for ARCH_ACTIONS to
> > select COMMON_CLK.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Andreas Färber <afaerber@suse.de>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Reviewed-by: Andreas Färber <afaerber@suse.de>
> > ---
> > v2:
> >    - Add Acked-by, Reviewed-by.
> > ---
> >   arch/arm/mach-actions/Kconfig | 1 -
> >   1 file changed, 1 deletion(-)
>
> Do you intend to apply the whole series through soc (my assumption due
> to soc in To), or should I pick this one up as maintainer?

Through soc.  This series contains all the patches from v1 that weren't
picked up.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
