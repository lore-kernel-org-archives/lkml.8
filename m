Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B9BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C12214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DSrPBFU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgBGRLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 12:11:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43592 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgBGRK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:10:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so46050ljm.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 09:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kHZ6O3yZLVjr/z8fh4b0NIHRATY9dkwE1ZXn4+1qxmE=;
        b=DSrPBFU89WipvBFWDiBmx1WEfiNz+QcRasIkw0wuHAcsdY2yl/E8Va/dvrOsEis6nU
         ll7iO7+BXahC5Wo35n+CMC/ZJB0BzkIBDQ6bz2oNfA/FfNyePShEo2IjGJMgHw34we6c
         5ENqo4hbOu356FJCONM9PE3UF4X0c5eevOtFWuYJXogW+JEC2BZHyd0R3ME22fbUS4wT
         +sb9wAS2ouuVh7BYly3TCt/391WbB/K3G6bQ90SeHhqyV0gFMGdZpz9qdnibj2WOgQu0
         SPXFPFM3/TPol8Ju+QZsxciJrkYc66/7jrqn/cig1FoJoN7DwxG4mD5ex1K+QSUtP3a9
         DjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kHZ6O3yZLVjr/z8fh4b0NIHRATY9dkwE1ZXn4+1qxmE=;
        b=r5wrrRqUNvWI2n8YAl/m1FTHV3BsF3a6HU8SeEICruqgvmAxV1BWh0J/+HRWrPZNp2
         yyi+gMs+XDMzCAwSxtuay66wxhZjyHaEeWAJKHFFhAetGz+v8xn2tJ7xNvlBaNMcTQL5
         iJzNq6VpJwx/StnqjTgvVqlhQ+PGJ6SA/k5+HUpPIwI5+2sHWeUBrNBV4+NRuicGJttx
         b3BtwwlPylJr5fpYJ5RodzoX2gzn4NXLEV7I+NzWpn82er2jCz2pRg47Mcepmj97sW/R
         mg/VNFLaUUp6UO+eGq8SXu7xqY1qK9XcrJljm4rNIZUmUdwCMY/lBaPc1tf/bytVpQKx
         +0BQ==
X-Gm-Message-State: APjAAAXGNatfJ4l17WCwZSRvGtboUkY7kSz/SFTavvu36x8MZWxhjp1A
        9JNkAGj1mTefXWmHlZIBc9neEiQp3SpT/+SIvgFtLA==
X-Google-Smtp-Source: APXvYqwIYH+HqZ0Lmzv1e+jykQ7bGnALdVo7BFeDQLK5lJfgzAzGTSciQR870PQ0CA55rMLcBTKI8lLCBo6ykwscAmg=
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr147514ljg.168.1581095457580;
 Fri, 07 Feb 2020 09:10:57 -0800 (PST)
MIME-Version: 1.0
References: <20191211214852.26317-1-christopher.s.hall@intel.com> <20191211214852.26317-6-christopher.s.hall@intel.com>
In-Reply-To: <20191211214852.26317-6-christopher.s.hall@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Feb 2020 18:10:46 +0100
Message-ID: <CACRpkdbi7q5Vr2Lt12eirs3Z8GLL2AuLLrAARCHkYEYgKbYkHg@mail.gmail.com>
Subject: Re: [Intel PMC TGPIO Driver 5/5] drivers/ptp: Add PMC Time-Aware GPIO Driver
To:     christopher.s.hall@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        jacob.e.keller@intel.com,
        Richard Cochran <richardcochran@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, sean.v.kelley@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christopher,

thanks for your patch!

On Fri, Jan 31, 2020 at 7:41 AM <christopher.s.hall@intel.com> wrote:

> From: Christopher Hall <christopher.s.hall@intel.com>
>
> Add support for PMC Time-Aware GPIO (TGPIO) hardware that is present on
> upcoming Intel platforms. The hardware logic is driven by the ART clock.
> The current hardware has two GPIO pins. Input interrupts are not
> implemented in hardware.
>
> The driver implements to the expanded PHC interface. Input requires use of
> the user-polling interface. Also, since the ART clock can't be adjusted,
> modulating the output frequency uses the edge timestamp interface
> (EVENT_COUNT_TSTAMP2) and the PEROUT2 ioctl output frequency adjustment
> interface.
>
> Acknowledgment: Portions of the driver code were authored by Felipe
> Balbi <balbi@kernel.org>
>
> Signed-off-by: Christopher Hall <christopher.s.hall@intel.com>

This driver becomes a big confusion for the GPIO maintainer...

> +config PTP_INTEL_PMC_TGPIO
> +       tristate "Intel PMC Timed GPIO"
> +       depends on X86
> +       depends on ACPI
> +       depends on PTP_1588_CLOCK
(...)
> +#include <linux/gpio.h>

Don't use this header in new code, use <linux/gpio/driver.h>

But it looks like you should just drop it because there is no GPIO
of that generic type going on at all?

> +/* Control Register */
> +#define TGPIOCTL_EN                    BIT(0)
> +#define TGPIOCTL_DIR                   BIT(1)
> +#define TGPIOCTL_EP                    GENMASK(3, 2)
> +#define TGPIOCTL_EP_RISING_EDGE                (0 << 2)
> +#define TGPIOCTL_EP_FALLING_EDGE       (1 << 2)
> +#define TGPIOCTL_EP_TOGGLE_EDGE                (2 << 2)
> +#define TGPIOCTL_PM                    BIT(4)

OK this looks like some GPIO registers...

Then there is a bunch of PTP stuff I don't understand I suppose
related to the precision time protocol.

Could you explain to a simple soul like me what is going on?
Should I bother myself with this or is this "some other GPIO,
not what you work on" or could it be that it's something I should
review?

I get the impression that this so-called "general purpose I/O"
isn't very general purpose at all, it seems to be very PTP-purpose
rather, so this confusion needs to be explained in the commit
message and possibly in the code as well.

What is it for really?

Yours,
Linus Walleij
