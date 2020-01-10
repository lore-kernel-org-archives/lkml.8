Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF41EC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA622072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgAJKjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:39:12 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:52245 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgAJKjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:39:11 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MCKJw-1izFd60Fak-009PCq for <linux-kernel@vger.kernel.org>; Fri, 10 Jan
 2020 11:39:10 +0100
Received: by mail-qk1-f175.google.com with SMTP id z14so1344987qkg.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 02:39:09 -0800 (PST)
X-Gm-Message-State: APjAAAUwcezGeZjYn5sVcxFp1taYKToqyRUyP65IFejkNRtcuVEZwLVn
        6NtL6ZhD47P9jKS3OJWZpID9ImAmzyRZb0fAmYQ=
X-Google-Smtp-Source: APXvYqyMjVVSmapAqsj//2kM/mVvl/4A/mbE9YNiMhmY9VW+W5aDIjEJsqICoh8t6bHpRs35xTIAnKoMz+ijna0GhT4=
X-Received: by 2002:a05:620a:cef:: with SMTP id c15mr2494811qkj.352.1578652748961;
 Fri, 10 Jan 2020 02:39:08 -0800 (PST)
MIME-Version: 1.0
References: <20200110101510.87311-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200110101510.87311-1-andriy.shevchenko@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 10 Jan 2020 11:38:52 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1ruyzoMb18yNWdEn20sv+Sum4FW0AYqmD-SfyR28OygA@mail.gmail.com>
Message-ID: <CAK8P3a1ruyzoMb18yNWdEn20sv+Sum4FW0AYqmD-SfyR28OygA@mail.gmail.com>
Subject: Re: [PATCH v1] mfd: syscon: Switch to use devm_ioremap_resource()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9lVbm9754X4X7JsHNGnoRcblq870MskI9KK5P/+cX0qjfqwiQSE
 m5ufo1ib+GLG9wO4TQ0aI52evGYVGGYtQZQyvuD9ncSFu7TKlXEmB1Ilbqx7H3snwHXCXpS
 OkgRMcEr87CtaPK6nVMPcCytOcwCLA0G1mgGSAXYPH5kY/gWsI5NVmaRk99jutqa28xVBuH
 ai9B0EtVEzmpSDA3XUzvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m2M/Lm0v7HU=:L8b00bT1DE96kjISlyjmDC
 fytgc4GG1mdS9Auky+mshxRcAwGDpsUYdNCwIryP8mFLJN/kx3ULoz0KYrAXOXLL41CSCripc
 XAx2TZxLvHsumkCoo05pcD9uJCD858G+nTdsxCKnCMqlQiGoG64NObuZKLwdoEtLMZ1aDldXS
 88bKx7y+7RisPvlUhMv53k0iQI6bMLILNOCAdV9w8hOwmPxtxlhSmpNlVSBJK2M5VOby/v3oL
 1RMpKVqDWXMXtk4mZYXZqxDX8gOVOwwm+W261smf7BmlcsIr1qEq1215oyAAqiRSzO7Vaz1s5
 +e00zlfzC/Eh3MBS0fmiZJLntEpsVBOALBQUXmGCoJTHjZibP7KY6Lsfn3oKSMhP+uJwbdhPV
 icWq181yyl63mVgmgaSThWP9zl0vwf1b6XFR2IKKYpqgNch9sFieF1JukwyX1PiP5rWxK9P6W
 J8N50LbMZMTJZETmuPC2vMCmGhQLQ483MVmPHupndUZzkEJjkZHKwOdV4AdRqY4cfLlwj0p1b
 IfAAtOXYwLEpZN9N5GHZEOuEINXKLZbDELhVSaQdBLhbqJ9sZGVs52CdetaLcuKjM1Xob3kZa
 VGQADeV+82MTezCtMkEkbAX0osEsXeyoAde1rUdqlDy+47POv6LKKbimsF8DmaOeQuOlqeUQZ
 1d+Fym40OfLTqZQPwNnOFwmS3F5mNiqwYMT1ZDMd/azg7nzqul2gyQDv7aNbaNhhzJQI1O0rM
 ieQ/ZEZoM8jvqGhx3NRVWawWq93Q/Ktp/WqxmO8asPyK/k0IyigeMXY8Ln0HX1086Ce7Xr4hb
 q+XKl2D5vvvLg2sa5CdT5mpGNK1TOpQtGSI2has2qTps0UUuWJ9bxAgTp3SsrvLwTP6dYVzxz
 YBiPW+LE1L+dbVn/JY8A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 11:15 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Instead of checking resource pointer for being NULL and
> report some not very standard error codes in this case,
> switch to devm_ioremap_resource() API.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

With syscon, I'm worried there are users that map the same region in another
driver, so doing devm_ioremap_resource() here will make another driver fail.

Maybe just change the error code and add a comment warning about that
instead?

      Arnd

> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 13626bb2d432..fad961b2e4a5 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -238,12 +238,9 @@ static int syscon_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res)
> -               return -ENOENT;
> -
> -       base = devm_ioremap(dev, res->start, resource_size(res));
> -       if (!base)
> -               return -ENOMEM;
> +       base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
