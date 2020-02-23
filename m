Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5031C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 20:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75054206E2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 20:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hDP5rY8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgBWUWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 15:22:30 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40558 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBWUWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 15:22:30 -0500
Received: by mail-qk1-f195.google.com with SMTP id b7so6984182qkl.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 12:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lVyMdZhCk+sORVIrUQaBVSmaLB9ffzyY3HC5ai8Eoms=;
        b=hDP5rY8TIoLw6Jo6H42eHUp9TSa+DpqwknE0lBMKpV5egFdFq8VKo71g057hDFfAkQ
         z44PkvJJYcbkFwPkHGZiatzUXFV5yhSDDHrMru0Z98EtNsKe5SmXAGia76o9EAegKUGc
         v8acKrc4K/7mV3p6BXQl2j6/np1XIuvYLc7rqckAsx2xWBXYNfaVq4kTyGkRnK4w2RXx
         je4S7tHExunR+6aEpQxSRh0XYrm36XTsssugCKONyCHXk2gLrBUW7gdyciZhl8tcLNIB
         JczKJG97toLd/VYICNXHXAT7e607XOTenDr3cuKtE/hLrrpNtLSbEQbdYVRXd4qTx3se
         u7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lVyMdZhCk+sORVIrUQaBVSmaLB9ffzyY3HC5ai8Eoms=;
        b=iAHZlVTCDTBQElLPR0YU8CPT/NnIejRRCY0ljNVyfDln5oaO1p4l3VJx5nAV11kQ/P
         i9X1nVY7jyI+uMHOd2eR+kBa2f5t7apVkozzUDG7j0u1SwcnGQwV0hkVwvkNnGve8xg9
         tHbCkoYcJf0Y1fgG6LJkWjyILfgOueyF0+OE2YDgfx7k2LNV4IQT6wuEo9No8VHsAPnH
         7WI9amcPosKHCxIYuH9yLn8T/ZJCMjOsdsWnzG6BxHfxZAMn/INQ351C+NlWsE8o1TLM
         P3NIiAsdVcHrIMTU6sGN9I/U9YW/q2dqGcgDt//vZJwtK/zdIsXzRpvfdKvwm8UMncHV
         W4BA==
X-Gm-Message-State: APjAAAXZafgPJRlz8F1rXGMomyN3p6XshX/HRbRTuA5ysPAVYlAVnJy6
        +fjSDVSP6NPqJRssdfPUXJlxD+6ycE39Fu92sZ+CHg==
X-Google-Smtp-Source: APXvYqxW2o35WeeSHbRu9o3bme64N+2sQl4PTvPjNiDoHlNHfcCUAX/+j6mq1xRGvd3x1xws7ROQ+jm1IesYZfOuLVY=
X-Received: by 2002:a37:9e51:: with SMTP id h78mr44838191qke.323.1582489349108;
 Sun, 23 Feb 2020 12:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20200220100141.5905-4-brgl@bgdev.pl> <202002221921.euxJGwes%lkp@intel.com>
In-Reply-To: <202002221921.euxJGwes%lkp@intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sun, 23 Feb 2020 21:22:18 +0100
Message-ID: <CAMpxmJVmp-=WiNQXu-dQzP+9D5ipv6muSd-auwzeZSV0e9+jgA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] nvmem: increase the reference count of a gpio
 passed over config
To:     kbuild test robot <lkp@intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, kbuild-all@lists.01.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 22 lut 2020 o 12:54 kbuild test robot <lkp@intel.com> napisa=C5=82(a)=
:
>
> Hi Bartosz,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on next-20200221]
> [also build test ERROR on v5.6-rc2]
> [cannot apply to gpio/for-next linus/master v5.6-rc2 v5.6-rc1 v5.5]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system. BTW, we also suggest to use '--base' option to specif=
y the
> base tree in git format-patch, please see https://stackoverflow.com/a/374=
06982]
>
> url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/nvme=
m-gpio-fix-resource-management/20200222-054341
> base:    bee46b309a13ca158c99c325d0408fb2f0db207f
> config: sparc-defconfig (attached as .config)
> compiler: sparc-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=3D7.5.0 make.cross ARCH=3Dsparc
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/nvmem/core.c: In function 'nvmem_register':
> >> drivers/nvmem/core.c:352:20: error: implicit declaration of function '=
gpiod_ref'; did you mean 'gpiod_get'? [-Werror=3Dimplicit-function-declarat=
ion]
>       nvmem->wp_gpio =3D gpiod_ref(config->wp_gpio);
>                        ^~~~~~~~~
>                        gpiod_get
>    drivers/nvmem/core.c:352:18: warning: assignment makes pointer from in=
teger without a cast [-Wint-conversion]
>       nvmem->wp_gpio =3D gpiod_ref(config->wp_gpio);
>                      ^
>    cc1: some warnings being treated as errors
>
> vim +352 drivers/nvmem/core.c
>

Of course I forgot to add the stub...

Will fix in next iteration.

Bart
