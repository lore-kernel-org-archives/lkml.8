Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBFBC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 14:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB9C20657
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 14:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TEBqmj38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgHPOkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 10:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgHPOkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 10:40:20 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2891C061385
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 07:40:17 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id m7so12788517qki.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4p5hG5/Sei/XlVH2zj6AeBSvaVMbXHhbmDmsLtAkcC0=;
        b=TEBqmj389cJKLROjNWabxTnj+YFfcMSNpTI9tvBOFnZdQCHwbAf05Gn39b5lAfcvbD
         wvNmSlb+VGMURLSK1B8bznW1xyXG5VmDf4KkhVQ02q387aWnu7CAF8pSuy2H/DhGPEIx
         FYRVubzr++9zoKuz2njcR4sYC4GgAjpuvg9XtOpNUhHkl+ixecBFjffGnP0BteMBRumx
         7vSOfENsPBpoFp5tW3lQ3o3RDzG0Xwd3qGh1u5BRJIQ+XE7D/X/im2lzWursnIcxyCa/
         ffAG2ssQ1yPo1GlDmaoaJNO4lO7MhNXcn/JvQPs55j5kbKPvLyrZH1b1knrDWj2QfF/7
         M3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4p5hG5/Sei/XlVH2zj6AeBSvaVMbXHhbmDmsLtAkcC0=;
        b=bhNjhfyaIE4n2agQiOA4oOxm3Y2tr8TsPK5G1FDCztRyiVjrdrDC/C/6wnSFjTSYHP
         ibSNvYEIhNR7IS1zH5m5v3MSr+KodUzUVlagGCsFYFyNQEpgBgf+oyMAj1QspAmkVaXa
         rEXckXovRVMGfg3frgiL2RSNvjBH4urPbAaiznENvLo7IFJcRJbdrYx3PYq3HK7C4GGO
         OtMycG3nJxgLY80n+/BuBBuj4LEjWQVDKMvMtPJFvGIYq3S2la84Drddg39zU4X6Rrm7
         LDG4HsHoriXby4HbYFf97zXmYaWagjJfoUA9indSAr5ISXQno6NVfWmRe4HN5jCRcElJ
         1ISA==
X-Gm-Message-State: AOAM532nJCsiUGI9AcRg+z830ztbOb+mAfioSnprHbodwc9yzpGDEJeK
        shTWBYATTp41D7nbkBHbn7up+mt35IOjomn1noK4xQ==
X-Google-Smtp-Source: ABdhPJy6h0u6nQm9IyWSLLAuykHxhnjvFmMK+wZuc0V/5SN5YBvcfgj9ynR0eCkNJRgBGS1e5v7WSHhSLKsFn9IlUl8=
X-Received: by 2002:a37:a495:: with SMTP id n143mr9673976qke.330.1597588812631;
 Sun, 16 Aug 2020 07:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200814030257.135463-1-warthog618@gmail.com> <20200814030257.135463-11-warthog618@gmail.com>
In-Reply-To: <20200814030257.135463-11-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sun, 16 Aug 2020 16:40:01 +0200
Message-ID: <CAMpxmJXS1C7Cgk+Cd-k7DpU=58kAJGD4KrujW2Rjq1scu_Tv4Q@mail.gmail.com>
Subject: Re: [PATCH v4 10/20] gpiolib: cdev: support GPIO_V2_LINE_SET_CONFIG_IOCTL
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 5:04 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> Add support for GPIO_V2_LINE_SET_CONFIG_IOCTL, the uAPI v2
> line set config ioctl.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 92 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 1d42a01f5414..04472c2b6678 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/kfifo.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/poll.h>
>  #include <linux/spinlock.h>
> @@ -418,6 +419,8 @@ struct edge_detector {
>   * @seqno: the sequence number for edge events generated on all lines in
>   * this line request.  Note that this is not used when @num_descs is 1, as
>   * the line_seqno is then the same and is cheaper to calculate.
> + * @config_mutex: mutex for serializing ioctl() calls to ensure consistency
> + * of configuration, particularly multi-step accesses to desc flags.
>   * @edets: an array of edge detectors, of size @num_descs
>   * @descs: the GPIO descriptors held by this line request, with @num_descs
>   * elements.
> @@ -429,6 +432,7 @@ struct line {
>         wait_queue_head_t wait;
>         DECLARE_KFIFO_PTR(events, struct gpio_v2_line_event);
>         atomic_t seqno;
> +       struct mutex config_mutex;
>         struct edge_detector *edets;
>         struct gpio_desc *descs[];
>  };
> @@ -703,6 +707,30 @@ static int gpio_v2_line_config_validate(struct gpio_v2_line_config *lc,
>         return 0;
>  }
>
> +static int gpio_v2_line_config_change_validate(struct line *line,
> +                                              struct gpio_v2_line_config *lc)
> +{
> +       int i;
> +       u64 flags;
> +       struct gpio_desc *desc;
> +
> +       for (i = 0; i < line->num_descs; i++) {
> +               desc = line->descs[i];
> +               flags = gpio_v2_line_config_flags(lc, i);
> +               /* disallow edge detection changes */
> +               if (line->edets[i].flags != (flags & GPIO_V2_LINE_EDGE_FLAGS))
> +                       return -EINVAL;
> +
> +               if (line->edets[i].flags) {
> +                       /* disallow polarity changes */
> +                       if (test_bit(FLAG_ACTIVE_LOW, &desc->flags) !=
> +                           ((flags & GPIO_V2_LINE_FLAG_ACTIVE_LOW) != 0))
> +                               return -EINVAL;
> +               }
> +       }
> +       return 0;
> +}
> +
>  static void gpio_v2_line_config_flags_to_desc_flags(u64 flags,
>                                                     unsigned long *flagsp)
>  {
> @@ -783,6 +811,67 @@ static long line_get_values(struct line *line, void __user *ip)
>         return 0;
>  }
>
> +static long line_set_config_locked(struct line *line,
> +                                  struct gpio_v2_line_config *lc)

I think that the general consensus in the kernel is to suffix
functions that need to be called with some lock taken outside them
with _unlocked (as in: the function is unlocked on its own).
Alternatively such routines are prefixed with __ (__line_set_config())
but I know Linus prefers the former.

Bart

> +{
> +       struct gpio_desc *desc;
> +       int i, ret;
> +       u64 flags;
> +
> +       ret = gpio_v2_line_config_change_validate(line, lc);
> +       if (ret)
> +               return ret;
> +
> +       for (i = 0; i < line->num_descs; i++) {
> +               desc = line->descs[i];
> +               flags = gpio_v2_line_config_flags(lc, i);
> +
> +               gpio_v2_line_config_flags_to_desc_flags(flags, &desc->flags);
> +               /*
> +                * Lines have to be requested explicitly for input
> +                * or output, else the line will be treated "as is".
> +                */
> +               if (flags & GPIO_V2_LINE_FLAG_OUTPUT) {
> +                       int val = gpio_v2_line_config_output_value(lc, i);
> +
> +                       edge_detector_stop(&line->edets[i]);
> +                       ret = gpiod_direction_output(desc, val);
> +                       if (ret)
> +                               return ret;
> +               } else if (flags & GPIO_V2_LINE_FLAG_INPUT) {
> +                       ret = gpiod_direction_input(desc);
> +                       if (ret)
> +                               return ret;
> +               }
> +
> +               blocking_notifier_call_chain(&desc->gdev->notifier,
> +                                            GPIO_V2_LINE_CHANGED_CONFIG,
> +                                            desc);
> +       }
> +       return 0;
> +}
> +
> +static long line_set_config(struct line *line, void __user *ip)
> +{
> +       struct gpio_v2_line_config lc;
> +       int ret;
> +
> +       if (copy_from_user(&lc, ip, sizeof(lc)))
> +               return -EFAULT;
> +
> +       ret = gpio_v2_line_config_validate(&lc, line->num_descs);
> +       if (ret)
> +               return ret;
> +
> +       mutex_lock(&line->config_mutex);
> +
> +       ret = line_set_config_locked(line, &lc);
> +
> +       mutex_unlock(&line->config_mutex);
> +
> +       return ret;
> +}
> +
>  static long line_ioctl(struct file *file, unsigned int cmd,
>                        unsigned long arg)
>  {
> @@ -791,6 +880,8 @@ static long line_ioctl(struct file *file, unsigned int cmd,
>
>         if (cmd == GPIO_V2_LINE_GET_VALUES_IOCTL)
>                 return line_get_values(line, ip);
> +       else if (cmd == GPIO_V2_LINE_SET_CONFIG_IOCTL)
> +               return line_set_config(line, ip);
>
>         return -EINVAL;
>  }
> @@ -964,6 +1055,7 @@ static int line_create(struct gpio_device *gdev, void __user *ip)
>                 }
>         }
>
> +       mutex_init(&line->config_mutex);
>         init_waitqueue_head(&line->wait);
>         if (has_edge_detection) {
>                 size = lr.event_buffer_size;
> --
> 2.28.0
>
