Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0294C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8DF92075B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rWrfGuxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgFDMEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgFDMEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:04:20 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359E2C03E96E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 05:04:20 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id v79so5628275qkb.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 05:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rQACftCBYPdSwAslxUYeMjkisCybiZwNexgueRdL/90=;
        b=rWrfGuxh1OBCcNfYCx/KQCoj8U7TjfmlIzH9M2tjrlAGVdBaMqdqcnRm40jNwO0XOJ
         /3ihEVp12QxXNgJ+ksNYlzlI1IjZpoDFLpq6ZQ7t1ndpxYSyX42xDvltv2DeZoU2GW2s
         1SDD4UsjDDgJBfch2nCATV2IIV8dbDGrnUk2seqzQ1PQpqL+yXGwwOfFp1a5c7IXr3Rm
         OetqKiNJP6iAWXU1mBdDKuSL0qWez5pBrh6Y/yvus5yozK8WWXxly/D2ZHEIi8RcGjZk
         zlsJCULqXmUZgrkD3oCr1krV8M3ZFd2k8UbEqRFTtgOMLW/O/XjfCK4I8NgS2EM0wuUc
         uwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rQACftCBYPdSwAslxUYeMjkisCybiZwNexgueRdL/90=;
        b=XDL51FYY53QwlFwiAeFHT1v8qFy2Jpjyb9uncUe/vnPm48Meu3WFtPLrvMUBeoo6AR
         +Dv7OjOEipWKSv2XKagIy1WParpS43F/z8SogJf+vhfTX/PYLWAgBDj6bB+4DSZ++FQh
         dLJr2+g+VeZtUu/4GpWe6bt1CrC6BpervjJzp5zd/3zTSUVp3T73vojy+zZs0ff0/TgM
         1x1uxjx8Iam4OGYEBg4FXX2qFJg/pkIayBW2DRFtke6H22cw1FohhXELBNYhBxfQsN8U
         XKtSWhqHKDROWDftSO4Yvb/TslOB2guJJmPtgLXM1/3jVuPHsKTjNkTNrD+xVSVGDZYi
         oe6g==
X-Gm-Message-State: AOAM531K+9DzwiqwybEVaJOQ9asTNGTOxwrq6lsTgzMZxYOUdhVFPENv
        riMKn0PJ5IrMEEIhZ+9x3Gc4QxyHKTloBTXfmVdr6dah
X-Google-Smtp-Source: ABdhPJw+gVnIl9ro5623Beo5SlFkBvigm3cQQouSYHWdth7ulCxMWwR0Hs0o07gHCa/+js12enJXUc4bO/DmBRK/pxU=
X-Received: by 2002:a37:5b47:: with SMTP id p68mr4378659qkb.120.1591272259324;
 Thu, 04 Jun 2020 05:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200602141048.1995-1-warthog618@gmail.com>
In-Reply-To: <20200602141048.1995-1-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 4 Jun 2020 14:04:08 +0200
Message-ID: <CAMpxmJUjYn5SHg3BpCeKbYc_OpCjd8d943yfYL_TF15wyTenfA@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: split character device into gpiolib-cdev
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 2 cze 2020 o 16:11 Kent Gibson <warthog618@gmail.com> napisa=C5=82(a):
>
> Split the cdev specific functionality out of gpiolib.c and into
> gpiolib-cdev.c. This improves the readability and maintainability of both
> the cdev and core gpiolib code.
>
> Suggested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
>
> ---
> While this patch is complete and ready for review, I don't expect it to
> be applied as is. There are a few cdev patches pending merge into
> gpio/devel that are sure to conflict, and it makes more sense to
> rebase this on top of them than vice versa. But I thought it would
> be worthwhile to get it out for review so it can be ready to be rebased
> when the time is right.
>
> Also, this is a naive split. That is, if applied as is, it will lose the
> line history of the cdev code.  This is not what I intend, and I
> understand can be avoided by encouraging git to remember the history
> with a few moves, but I'm unsure how the maintainers would prefer that
> to be done.
>
> Bart,
>  As this was your idea, I've taken the liberty of adding the Suggested-by=
.
>  I hope that is ok.
>
> Changes in v2:
>  - rebased to latest gpio/devel and added base-commit to placate the
>   build bot.  The comments above still apply, as there are still a
>   couple of commits in gpio/fixes that will conflict.
>
> Kent.

Thanks for doing this Kent!

This looks mostly good, see a single comment below.

Linus: do you think we can get this in for v5.8? Maybe apply this as
the last patch before your PR?

>
>  drivers/gpio/Makefile       |    1 +
>  drivers/gpio/gpiolib-cdev.c | 1148 +++++++++++++++++++++++++++++++++++
>  drivers/gpio/gpiolib-cdev.h |   11 +
>  drivers/gpio/gpiolib.c      | 1112 +--------------------------------
>  4 files changed, 1164 insertions(+), 1108 deletions(-)
>  create mode 100644 drivers/gpio/gpiolib-cdev.c
>  create mode 100644 drivers/gpio/gpiolib-cdev.h
>
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 65bf3940e33c..b5b58b624f37 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_GPIOLIB)           +=3D gpiolib.o
>  obj-$(CONFIG_GPIOLIB)          +=3D gpiolib-devres.o
>  obj-$(CONFIG_GPIOLIB)          +=3D gpiolib-legacy.o
>  obj-$(CONFIG_GPIOLIB)          +=3D gpiolib-devprop.o
> +obj-$(CONFIG_GPIOLIB)          +=3D gpiolib-cdev.o
>  obj-$(CONFIG_OF_GPIO)          +=3D gpiolib-of.o
>  obj-$(CONFIG_GPIO_SYSFS)       +=3D gpiolib-sysfs.o
>  obj-$(CONFIG_GPIO_ACPI)                +=3D gpiolib-acpi.o
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> new file mode 100644
> index 000000000000..971470bdc9c9
> --- /dev/null
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -0,0 +1,1148 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bitmap.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqreturn.h>
> +#include <linux/spinlock.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/cdev.h>
> +#include <linux/uaccess.h>
> +#include <linux/compat.h>
> +#include <linux/anon_inodes.h>
> +#include <linux/file.h>
> +#include <linux/kfifo.h>
> +#include <linux/poll.h>
> +#include <linux/timekeeping.h>
> +#include <uapi/linux/gpio.h>
> +
> +
> +#include "gpiolib.h"
> +
> +/* Implementation infrastructure for GPIO interfaces.
> + *
> + * The GPIO programming interface allows for inlining speed-critical
> + * get/set operations for common cases, so that access to SOC-integrated
> + * GPIOs can sometimes cost only an instruction or two per bit.
> + */

Is this comment relevant for the character device?

Bartosz
