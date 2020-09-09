Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565E1C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006C321D79
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 20:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CUY7NClC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgIIUs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgIIUsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 16:48:54 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B25C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 13:48:53 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w1so4086350edr.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 13:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Ho+RQLq845v428NKgs2gT6gc1TpTRun0PL9t1RRTJ4=;
        b=CUY7NClC4AVTENYXJOqwM/yovaMyJYdCwjMmaa0bEIn9DzjuW+pbmK1je7FspveBQ5
         CDt0GpKWuO20gfRhZI9AbTAthmPdunuDI9zm1J/3PPZGYpZvvmztw72klAoYTJdse6hA
         N8LFmRhAGCz/VvISPVKfVYDQLh6ElFmosIhUQdOFbYx3qidPFM2qXTYiD/mX6uYST7nk
         bEi/CYlQjSCaK300/g8DEPXhGGSXtK89taCsBBqkyixuEXu3Qg/7ZCtIX9LRsFmmplVE
         1SJVaCJKOtC6YuwjuAgJHWDhpFoauOg8Fcz3dSBs382LDe7Or7EUQNFnqcRJWVT70PSX
         p+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Ho+RQLq845v428NKgs2gT6gc1TpTRun0PL9t1RRTJ4=;
        b=nFtppDBGI4wDIQ/Ll4Ba6Z/DhOljBELaIzW6/wGOg/18RZzBsbo5totk8MRCNaNrkp
         Buz7gbnWcERDLpWZgP/w8YLIcJJT0yuhli6hM8HuQOtMu/jFngMyuT8Y9KmykXyyRnN4
         YN0QDvnsKSTAqiQlPTpcGUc9KLXbFhIbEg5Yj27tFnAAXPmmVHaXD9cEStipiCObLhbH
         QJ9v+g7AjzWn+4S0c4FOQhUSSwbKGPv16v05ku9WHBHSsgr5qbM8RLiwjBdKCYx4gBk8
         aQ56k4Ub7UDQPUHSQqvA+BszJyL5FRpIgKbYgWdf6+0h+YeR0on6CclzauTpj6YQXTXg
         I0uQ==
X-Gm-Message-State: AOAM5318kgXG0/ayRVWRGvQUcXmwzs1N2E2DekZXC0QawTB6BwSEntfK
        RQ79CxwgsJqqpftbd/Auaqmw5LduC8R4p6Rtea4s7Q==
X-Google-Smtp-Source: ABdhPJxatKzRHEhhMTJ3u7ukoo4+9T/y/HLjZVYIY5BwbsWo3q+gDFDFhoact97duGGwSpWLmipE1ywNBXzdgUEhEpg=
X-Received: by 2002:aa7:c0d3:: with SMTP id j19mr6263351edp.40.1599684532312;
 Wed, 09 Sep 2020 13:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200909202609.1630698-1-swboyd@chromium.org>
In-Reply-To: <20200909202609.1630698-1-swboyd@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 9 Sep 2020 13:48:41 -0700
Message-ID: <CABXOdTdYJs4_nS=Oj5J=_Y0Q34Uo_i0mY=KKkr0PvUOjOOxG-w@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Don't populate lightbar device if it
 isn't there
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 1:26 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The cros ec lightbar driver has a check in probe to fail early if the ec
> device isn't the cros_ec one or if it can't read the lightbar version
> from the EC. Let's move this check to the place where the lightbar
> device is registered. This way we don't expose devices that aren't
> actually there on devices that don't have a lightbar.
>
> This should improve memory and possibly performance too because struct
> devices don't exactly have a small memory footprint and they contribute
> to suspend/resume regardless of driver attachment.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/mfd/cros_ec_dev.c                   |  16 +++-
>  drivers/platform/chrome/cros_ec_lightbar.c  | 100 ++------------------
>  drivers/platform/chrome/cros_ec_proto.c     |  82 ++++++++++++++++
>  include/linux/platform_data/cros_ec_proto.h |   4 +
>  4 files changed, 109 insertions(+), 93 deletions(-)
>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index d07b43d7c761..9e98b2ec5d92 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -74,6 +74,10 @@ static const struct mfd_cell cros_ec_cec_cells[] = {
>         { .name = "cros-ec-cec", },
>  };
>
> +static const struct mfd_cell cros_ec_lightbar_cells[] = {
> +       { .name = "cros-ec-lightbar", },
> +};
> +
>  static const struct mfd_cell cros_ec_rtc_cells[] = {
>         { .name = "cros-ec-rtc", },
>  };
> @@ -112,7 +116,6 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
>  static const struct mfd_cell cros_ec_platform_cells[] = {
>         { .name = "cros-ec-chardev", },
>         { .name = "cros-ec-debugfs", },
> -       { .name = "cros-ec-lightbar", },
>         { .name = "cros-ec-sysfs", },
>  };
>
> @@ -206,6 +209,17 @@ static int ec_device_probe(struct platform_device *pdev)
>                 }
>         }
>
> +       if (!strcmp(ec_platform->ec_name, CROS_EC_DEV_NAME) &&
> +           !cros_ec_get_lightbar_version(ec, NULL, NULL)) {
> +               retval = mfd_add_hotplug_devices(ec->dev,
> +                               cros_ec_lightbar_cells,
> +                               ARRAY_SIZE(cros_ec_lightbar_cells));
> +               if (retval)
> +                       dev_err(ec->dev,
> +                               "failed to add lightbar device: %d\n",
> +                               retval);
> +       }
> +
>         /*
>          * The PD notifier driver cell is separate since it only needs to be
>          * explicitly added on platforms that don't have the PD notifier ACPI
> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
> index b59180bff5a3..95e2e62bea9b 100644
> --- a/drivers/platform/chrome/cros_ec_lightbar.c
> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> @@ -82,75 +82,6 @@ static int lb_throttle(void)
>         return ret;
>  }
>
> -static struct cros_ec_command *alloc_lightbar_cmd_msg(struct cros_ec_dev *ec)
> -{
> -       struct cros_ec_command *msg;
> -       int len;
> -
> -       len = max(sizeof(struct ec_params_lightbar),
> -                 sizeof(struct ec_response_lightbar));
> -
> -       msg = kmalloc(sizeof(*msg) + len, GFP_KERNEL);
> -       if (!msg)
> -               return NULL;
> -
> -       msg->version = 0;
> -       msg->command = EC_CMD_LIGHTBAR_CMD + ec->cmd_offset;
> -       msg->outsize = sizeof(struct ec_params_lightbar);
> -       msg->insize = sizeof(struct ec_response_lightbar);
> -
> -       return msg;
> -}
> -
> -static int get_lightbar_version(struct cros_ec_dev *ec,
> -                               uint32_t *ver_ptr, uint32_t *flg_ptr)
> -{
> -       struct ec_params_lightbar *param;
> -       struct ec_response_lightbar *resp;
> -       struct cros_ec_command *msg;
> -       int ret;
> -
> -       msg = alloc_lightbar_cmd_msg(ec);
> -       if (!msg)
> -               return 0;
> -
> -       param = (struct ec_params_lightbar *)msg->data;
> -       param->cmd = LIGHTBAR_CMD_VERSION;
> -       ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> -       if (ret < 0) {

I am quite sure this conflicts against the patch series I submitted
earlier, specifically "cros_ec_lightbar: Accept more error codes from
cros_ec_cmd_xfer_status".

Guenter

> -               ret = 0;
> -               goto exit;
> -       }
> -
> -       switch (msg->result) {
> -       case EC_RES_INVALID_PARAM:
> -               /* Pixel had no version command. */
> -               if (ver_ptr)
> -                       *ver_ptr = 0;
> -               if (flg_ptr)
> -                       *flg_ptr = 0;
> -               ret = 1;
> -               goto exit;
> -
> -       case EC_RES_SUCCESS:
> -               resp = (struct ec_response_lightbar *)msg->data;
> -
> -               /* Future devices w/lightbars should implement this command */
> -               if (ver_ptr)
> -                       *ver_ptr = resp->version.num;
> -               if (flg_ptr)
> -                       *flg_ptr = resp->version.flags;
> -               ret = 1;
> -               goto exit;
> -       }
> -
> -       /* Anything else (ie, EC_RES_INVALID_COMMAND) - no lightbar */
> -       ret = 0;
> -exit:
> -       kfree(msg);
> -       return ret;
> -}
> -
>  static ssize_t version_show(struct device *dev,
>                             struct device_attribute *attr, char *buf)
>  {
> @@ -163,7 +94,7 @@ static ssize_t version_show(struct device *dev,
>                 return ret;
>
>         /* This should always succeed, because we check during init. */
> -       if (!get_lightbar_version(ec, &version, &flags))
> +       if (cros_ec_get_lightbar_version(ec, &version, &flags))


>                 return -EIO;
>
>         return scnprintf(buf, PAGE_SIZE, "%d %d\n", version, flags);
> @@ -182,7 +113,7 @@ static ssize_t brightness_store(struct device *dev,
>         if (kstrtouint(buf, 0, &val))
>                 return -EINVAL;
>
> -       msg = alloc_lightbar_cmd_msg(ec);
> +       msg = cros_ec_alloc_lightbar_cmd_msg(ec);
>         if (!msg)
>                 return -ENOMEM;
>
> @@ -220,7 +151,7 @@ static ssize_t led_rgb_store(struct device *dev, struct device_attribute *attr,
>         unsigned int val[4];
>         int ret, i = 0, j = 0, ok = 0;
>
> -       msg = alloc_lightbar_cmd_msg(ec);
> +       msg = cros_ec_alloc_lightbar_cmd_msg(ec);
>         if (!msg)
>                 return -ENOMEM;
>
> @@ -287,7 +218,7 @@ static ssize_t sequence_show(struct device *dev,
>         int ret;
>         struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>
> -       msg = alloc_lightbar_cmd_msg(ec);
> +       msg = cros_ec_alloc_lightbar_cmd_msg(ec);
>         if (!msg)
>                 return -ENOMEM;
>
> @@ -324,7 +255,7 @@ static int lb_send_empty_cmd(struct cros_ec_dev *ec, uint8_t cmd)
>         struct cros_ec_command *msg;
>         int ret;
>
> -       msg = alloc_lightbar_cmd_msg(ec);
> +       msg = cros_ec_alloc_lightbar_cmd_msg(ec);
>         if (!msg)
>                 return -ENOMEM;
>
> @@ -352,7 +283,7 @@ static int lb_manual_suspend_ctrl(struct cros_ec_dev *ec, uint8_t enable)
>         struct cros_ec_command *msg;
>         int ret;
>
> -       msg = alloc_lightbar_cmd_msg(ec);
> +       msg = cros_ec_alloc_lightbar_cmd_msg(ec);
>         if (!msg)
>                 return -ENOMEM;
>
> @@ -399,7 +330,7 @@ static ssize_t sequence_store(struct device *dev, struct device_attribute *attr,
>                         return ret;
>         }
>
> -       msg = alloc_lightbar_cmd_msg(ec);
> +       msg = cros_ec_alloc_lightbar_cmd_msg(ec);
>         if (!msg)
>                 return -ENOMEM;
>
> @@ -444,7 +375,7 @@ static ssize_t program_store(struct device *dev, struct device_attribute *attr,
>                 return -EINVAL;
>         }
>
> -       msg = alloc_lightbar_cmd_msg(ec);
> +       msg = cros_ec_alloc_lightbar_cmd_msg(ec);
>         if (!msg)
>                 return -ENOMEM;
>
> @@ -531,24 +462,9 @@ static struct attribute_group cros_ec_lightbar_attr_group = {
>  static int cros_ec_lightbar_probe(struct platform_device *pd)
>  {
>         struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
> -       struct cros_ec_platform *pdata = dev_get_platdata(ec_dev->dev);
>         struct device *dev = &pd->dev;
>         int ret;
>
> -       /*
> -        * Only instantiate the lightbar if the EC name is 'cros_ec'. Other EC
> -        * devices like 'cros_pd' doesn't have a lightbar.
> -        */
> -       if (strcmp(pdata->ec_name, CROS_EC_DEV_NAME) != 0)
> -               return -ENODEV;
> -
> -       /*
> -        * Ask then for the lightbar version, if it's 0 then the 'cros_ec'
> -        * doesn't have a lightbar.
> -        */
> -       if (!get_lightbar_version(ec_dev, NULL, NULL))
> -               return -ENODEV;
> -
>         /* Take control of the lightbar from the EC. */
>         lb_manual_suspend_ctrl(ec_dev, 1);
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 8d52b3b4bd4e..7a297a527f8d 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -887,3 +887,85 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
>         return sensor_count;
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
> +
> +struct cros_ec_command *cros_ec_alloc_lightbar_cmd_msg(struct cros_ec_dev *ec)
> +{
> +       struct cros_ec_command *msg;
> +       int len;
> +
> +       len = max(sizeof(struct ec_params_lightbar),
> +                 sizeof(struct ec_response_lightbar));
> +
> +       msg = kmalloc(sizeof(*msg) + len, GFP_KERNEL);
> +       if (!msg)
> +               return NULL;
> +
> +       msg->version = 0;
> +       msg->command = EC_CMD_LIGHTBAR_CMD + ec->cmd_offset;
> +       msg->outsize = sizeof(struct ec_params_lightbar);
> +       msg->insize = sizeof(struct ec_response_lightbar);
> +
> +       return msg;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_alloc_lightbar_cmd_msg);
> +
> +/**
> + * cros_ec_get_lightbar_version() - Get the EC lightbar version
> + *
> + * @ec: EC device, does not have to be connected directly to the AP,
> + *      can be daisy chained through another device.
> + * @ver_ptr: Detected lightbar version number
> + * @flag_ptr: Detected lightbar flags
> + *
> + * Call this function to determine the EC's lightbar version and flags
> + * information. If it doesn't exist then this function returns a negative
> + * error value.
> + *
> + * Return: 0 on success, negative errno on failure to detect a lightbar.
> + */
> +int cros_ec_get_lightbar_version(struct cros_ec_dev *ec, uint32_t *ver_ptr,
> +                                uint32_t *flg_ptr)
> +{
> +       struct ec_params_lightbar *param;
> +       struct ec_response_lightbar *resp;
> +       struct cros_ec_command *msg;
> +       int ret;
> +
> +       msg = cros_ec_alloc_lightbar_cmd_msg(ec);
> +       if (!msg)
> +               return -ENOMEM;
> +
> +       param = (struct ec_params_lightbar *)msg->data;
> +       param->cmd = LIGHTBAR_CMD_VERSION;
> +       ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> +       if (ret < 0)
> +               goto exit;
> +
> +       switch (msg->result) {
> +       case EC_RES_INVALID_PARAM:
> +               /* Pixel had no version command. */
> +               if (ver_ptr)
> +                       *ver_ptr = 0;
> +               if (flg_ptr)
> +                       *flg_ptr = 0;
> +               ret = 0;
> +               break;
> +       case EC_RES_SUCCESS:
> +               resp = (struct ec_response_lightbar *)msg->data;
> +
> +               /* Future devices w/lightbars should implement this command */
> +               if (ver_ptr)
> +                       *ver_ptr = resp->version.num;
> +               if (flg_ptr)
> +                       *flg_ptr = resp->version.flags;
> +               ret = 0;
> +               break;
> +       default:
> +               /* Anything else (ie, EC_RES_INVALID_COMMAND) - no lightbar */
> +               ret = -ENODEV;
> +       }
> +exit:
> +       kfree(msg);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_get_lightbar_version);
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index 4a415ae851ef..50221254956c 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -229,6 +229,10 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
>
>  int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
>
> +struct cros_ec_command *cros_ec_alloc_lightbar_cmd_msg(struct cros_ec_dev *ec);
> +int cros_ec_get_lightbar_version(struct cros_ec_dev *ec, uint32_t *ver_ptr,
> +                                uint32_t *flg_ptr);
> +
>  int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
>
>  /**
> --
> Sent by a computer, using git, on the internet
>
