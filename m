Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E6CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44ED20775
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OhuY/LJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgICH7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgICH7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:59:31 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FFBC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 00:59:29 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q13so2471626ejo.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 00:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=631Dyyj+5J1i4PyIFclIjVjOc2aZH6fWRoROHrNThkE=;
        b=OhuY/LJ9ZXiJdh/h6zxSJ7jWF4WBeWwm7oxf2Bj21hgqvOBHdqyMY3NiFHrYE3jkzq
         cv2PJwXOQ+YuU+W/SvVq3zWMeX+Q+UL3Lb09KAdxxeDEG66pNKXz7svZrTC18ODLIF/m
         u5kI9UIUAkgJfs02/EvDhkayPfxIytG7rbkZzkjgcMDUFu8LqLYuMdWk3ewU967PVUBe
         8QeRiXzsYZOYozH55E1xmt6INtDYVWVR3TEAY9jvqYURMIrq8Kcgbb7sCW6AqEts2mV9
         5/BymYtNy1syz2I/scALDYE7FGXnK/tIKtOK2uHGP7L1HhtquFy+Qd9vOA1sr3nhfysG
         ngPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=631Dyyj+5J1i4PyIFclIjVjOc2aZH6fWRoROHrNThkE=;
        b=sP88qTVQeJ8pSmcym4dM1Darm/DLjVBIAr0sYpbg/0/QQatRs0untHNrjQLgJkkRAk
         BMzHhv4n/GpmPb04PwDZPU5KULM7Io7kGbxHtf6FoXSKdtqu2glnwKvmKrZe3cz1ElqU
         BAPXbjUU5yHAWOLuGAgGYdWA9PZXjxH2wPz3qmrkd3zZUWpEbyWYfMHc+EUi8fzsSn8m
         fm7yVy2iswU67tCnqnaO8Dn5dPyf1sfAJ3fiUtvEV5vbVnd+GKk76kJoPSINOxHbfgPk
         R3Tl2/xSn1lSVAGJoMAX9ull/3ysBULO2CMtaZkQAlZbSnHQmFi5RFlJ35VWJWAV7i5r
         oKkg==
X-Gm-Message-State: AOAM532dMlUwS/IFb4cYW1ZNii+92+JOohAjbeYBwJHq0RMWeWZQmdHN
        RZ9jkbeUBcgWiDR+qfuK0Pc3c/vq8bOHa9i8sND4Jw==
X-Google-Smtp-Source: ABdhPJyBbIUChvvzLiPQLdiZrhe2BSGEnj5NkfhqnqgNeWvbZ7O/IYUicka8eALd6ofrbKtaeTxzOpCHys3x0cJUdSo=
X-Received: by 2002:a17:906:d8ca:: with SMTP id re10mr852855ejb.382.1599119968510;
 Thu, 03 Sep 2020 00:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200831032006.1019978-1-warthog618@gmail.com> <20200831032006.1019978-12-warthog618@gmail.com>
In-Reply-To: <20200831032006.1019978-12-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 3 Sep 2020 09:59:17 +0200
Message-ID: <CAMpxmJWYpDQsvKCsNudb6p3zAey=6EuNpb3wQ3dpCJVCTjjBsg@mail.gmail.com>
Subject: Re: [PATCH v6 11/20] gpiolib: cdev: support GPIO_V2_LINE_SET_VALUES_IOCTL
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 5:23 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> Add support for the GPIO_V2_LINE_SET_VALUES_IOCTL.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 59 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 936b8c9958dd..9f05bbd2161e 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -777,6 +777,63 @@ static long linereq_get_values(struct linereq *lr, void __user *ip)
>         return 0;
>  }
>
> +static long linereq_set_values_unlocked(struct linereq *lr,
> +                                       struct gpio_v2_line_values *lv)
> +{
> +       DECLARE_BITMAP(vals, GPIO_V2_LINES_MAX);
> +       struct gpio_desc **descs;
> +       unsigned int i, didx, num_set;
> +       int ret;
> +
> +       bitmap_zero(vals, GPIO_V2_LINES_MAX);
> +       for (num_set = 0, i = 0; i < lr->num_lines; i++) {
> +               if (lv->mask & BIT_ULL(i)) {
> +                       if (!test_bit(FLAG_IS_OUT, &lr->lines[i].desc->flags))
> +                               return -EPERM;
> +                       if (lv->bits & BIT_ULL(i))
> +                               __set_bit(num_set, vals);
> +                       num_set++;
> +                       descs = &lr->lines[i].desc;
> +               }
> +       }
> +       if (num_set == 0)
> +               return -EINVAL;
> +
> +       if (num_set != 1) {
> +               /* build compacted desc array and values */
> +               descs = kmalloc_array(num_set, sizeof(*descs), GFP_KERNEL);

Missing retval check.

> +               for (didx = 0, i = 0; i < lr->num_lines; i++) {
> +                       if (lv->mask & BIT_ULL(i)) {
> +                               descs[didx] = lr->lines[i].desc;
> +                               didx++;
> +                       }
> +               }
> +       }
> +       ret = gpiod_set_array_value_complex(false, true, num_set,
> +                                           descs, NULL, vals);
> +
> +       if (num_set != 1)
> +               kfree(descs);
> +       return ret;
> +}
> +
> +static long linereq_set_values(struct linereq *lr, void __user *ip)
> +{
> +       struct gpio_v2_line_values lv;
> +       int ret;
> +
> +       if (copy_from_user(&lv, ip, sizeof(lv)))
> +               return -EFAULT;
> +
> +       mutex_lock(&lr->config_mutex);
> +
> +       ret = linereq_set_values_unlocked(lr, &lv);
> +
> +       mutex_unlock(&lr->config_mutex);
> +
> +       return ret;
> +}
> +
>  static long linereq_set_config_unlocked(struct linereq *lr,
>                                         struct gpio_v2_line_config *lc)
>  {
> @@ -853,6 +910,8 @@ static long linereq_ioctl(struct file *file, unsigned int cmd,
>
>         if (cmd == GPIO_V2_LINE_GET_VALUES_IOCTL)
>                 return linereq_get_values(lr, ip);
> +       else if (cmd == GPIO_V2_LINE_SET_VALUES_IOCTL)
> +               return linereq_set_values(lr, ip);
>         else if (cmd == GPIO_V2_LINE_SET_CONFIG_IOCTL)
>                 return linereq_set_config(lr, ip);
>
> --
> 2.28.0
>
