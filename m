Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1EEC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 10:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6301208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 10:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgEBKJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 06:09:52 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41462 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgEBKJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 06:09:51 -0400
Received: by mail-oi1-f195.google.com with SMTP id 19so2094436oiy.8;
        Sat, 02 May 2020 03:09:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GUwikeeiD0FxdkHJ5UwJum79DyedaO/6pvisFtwjhjw=;
        b=b5wBz8TqDacjQU5XN6eo+wEHUuHKJVotjx2iib8pn6GutG6ItMhXhP8b0p0BgyIWsc
         E4CvOdwsNcseDErE+SjWeroSRjiGBrJZqt/5WtiFsabvKPAOCXgCh5Dk4miDRGnGseGD
         CvRuKJa1qzWAxwAPIAQpAMadRp2xikJkzJLCFYClnSJmgB+XBX+GdH5cTAg+AkMNnUs4
         xapwZ0HiDn7XCnZxQ1wKt8hXYcEZ8myT8kojCwbQfiRhSfg1VrHEWf4byWHofB/qvZ/o
         EUL4IlVpyxn8Yj9N07UvPvGcfe77URZ8fl0OrNQCgDlC/831zYwBhhvuNlGTk1Oq/mAg
         D/ZQ==
X-Gm-Message-State: AGi0PubVjcOOC8aLxRvpBb8Kp1Y6cfXpmedehUvGIL4iiAFXjOltFy62
        C1XE1gqkdMlaH1Awbjdd7vkfMhqgjdH9S7CeJJY=
X-Google-Smtp-Source: APiQypL5GS5+2fuMCDY/4vHoYi5iYdfZcf3OhXuD+VLOSMO5MJrHitsRpMjwm05ovQlkrxl/DoowVjaJKd/iOE6uk+o=
X-Received: by 2002:aca:d50f:: with SMTP id m15mr2676982oig.54.1588414190322;
 Sat, 02 May 2020 03:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <1588393643-31499-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1588393643-31499-1-git-send-email-bmeng.cn@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 2 May 2020 12:09:38 +0200
Message-ID: <CAMuHMdVd3s46o5VXZqAHuQt5qYsbDMOonVWjEqd2nu8OON97Xw@mail.gmail.com>
Subject: Re: [PATCH] sh: Drop CONFIG_MTD_M25P80 in sh7757lcr_defconfig
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

On Sat, May 2, 2020 at 6:27 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> From: Bin Meng <bin.meng@windriver.com>
>
> Drop CONFIG_MTD_M25P80 that was removed in
> commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Thanks for your patch!

Blindly removing config options from defconfig files that haven't
received much love for a while is IMHO not such a good idea, as it makes
it harder to see what the affected platform needs, or needed.

> --- a/arch/sh/configs/sh7757lcr_defconfig
> +++ b/arch/sh/configs/sh7757lcr_defconfig
> @@ -36,7 +36,6 @@ CONFIG_IPV6=y
>  # CONFIG_FW_LOADER is not set
>  CONFIG_MTD=y
>  CONFIG_MTD_BLOCK=y
> -CONFIG_MTD_M25P80=y
>  CONFIG_BLK_DEV_RAM=y
>  CONFIG_SCSI=y
>  CONFIG_BLK_DEV_SD=y

MTD_SPI_NOR became a dependency for MTD_M25P80 since commit
03e296f613affcc2671c1e86d8c25ecad867204e ("mtd: m25p80: use the SPI nor
framework") and commit e43b20619bdb6c851dd7b49cbd15e52875a785d4 ("mtd:
spi-nor: shorten Kconfig naming").  Hence CONFIG_MTD_SPI_NOR=y should be
added to avoid breaking the platform's SPI FLASH support.

Just removing CONFIG_MTD_M25P80=y from the defconfig makes this less
visible for someone who wants to build a kernel for this platform using
"make sh7757lcr_defconfig": it can no longer be seen that
CONFIG_MTD_M25P80=y won't be present in the resulting .config file.

I think the platform would be better served with a proper refresh of the
defconfig file.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
