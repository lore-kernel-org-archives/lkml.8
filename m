Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCE0C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899A820719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgDGNQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:16:27 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33393 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgDGNQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:16:27 -0400
Received: by mail-oi1-f193.google.com with SMTP id m14so1451068oic.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 06:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPDKx3oSRt9Y7X4bWqhfNeKSwWIUsvZI1ClXBkig7os=;
        b=Wu1UfZYHGPAXzaVdZpciVen+ZgF6JiRlGKPoxOiNrLShHXP1l2yhsDS1K4QcKxDlkH
         s/uMAR0ryseBoErZbfaHNrriqZ5EuByprURHU1ag/zwB1UJBI/6+hnPuac3rzC5w2NFC
         ek/TdSC80cdAlXPaH1fzDYFizgK+O1U7ZUDe0KBjqitWM/0py7lKnYqceNg3pjS0b1g3
         tYbctDnQSi2o1soQtVfchc7wKC6oxjh84FRGNGTMXEafwMApQnOCRd8mdXfK/RKakchZ
         MKUFI3V2G1nL0ymuphA9d/YX6LOu3BXwz8s3nbmskpEA5eJ5QiOhLsABJ+WCjcheK6D9
         1Nug==
X-Gm-Message-State: AGi0PuYPAW2GRX3YMQ1wDtNZI6TArAG4f03+B8dfi0ldu7Y8YZGd1VeU
        Ft2NYGqAEZBCWkMWfL7+/9IzkFy9DyF4wd9op0U=
X-Google-Smtp-Source: APiQypLG5uAh4zlD6yhUFCYUK18eL9OcJRZ0sLvd60tTXtYDdxd3jG6DqxcxL+LEDKwxJRKuEyPr6H6evLUmTJr8ALw=
X-Received: by 2002:aca:ad93:: with SMTP id w141mr1676490oie.54.1586265386476;
 Tue, 07 Apr 2020 06:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200407103537.4138-1-max.krummenacher@toradex.com>
In-Reply-To: <20200407103537.4138-1-max.krummenacher@toradex.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Apr 2020 15:16:14 +0200
Message-ID: <CAMuHMdWrekHiADkMmgO5nDxFNYjLud7FD=7ArMZNQire_+7TQg@mail.gmail.com>
Subject: Re: [PATCH 0/4] defconfig: fix changed configs and refresh
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Tue, Apr 7, 2020 at 12:36 PM Max Krummenacher <max.oss.09@gmail.com> wrote:
> Three configs have been renamed and/or changed behaviour.
> Clean that by using the new config name.
> Then refresh the defconfig with make defconfig savedefconfig.
>
> The refreshed defconfig does result in a not changed .config.
>
> Applies on linux-next/master tag: next-20200407
>
> Max Krummenacher (4):
>   arm64: defconfig: DRM_DUMB_VGA_DAC: follow changed config symbol name
>   arm64: defconfig: PCIE_TEGRA194: follow changed config symbol name
>   arm64: defconfig: ARCH_R8A7795: follow changed config symbol name
>   arm64: defconfig: refresh

Probably CONFIG_DRM_DISPLAY_CONNECTOR should also be enabled for HDMI,
VGA, and composite display connectors on various boards since commit
0c275c30176b2e78 ("drm/bridge: Add bridge driver for display
connectors"), but it's not clear to me when exactly this became a
requirement, as before there was no code that looked for e.g.
vga-connector.
Laurent?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
