Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174CAC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C02A320BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsvnH5BH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbgIJPZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 11:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730321AbgIJOwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:52:22 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C30C061756
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:52:21 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q13so9127616ejo.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dJNpd1k/iXy/9vDDM1M28W1JVEcIvh8oM+RnMoJEaDg=;
        b=KsvnH5BHQ1Uy6iuofqukywM5klP+kHns60Qe3eVgcntRLLC/K7Mkb2kEPEytUlk5bu
         fQ5PqD0adoFZPG7M2OlOzej5ZKAAzj7vOdRR8OJnhM9W9oVo7j3fY9nUljOsYegnhOPE
         5aEUK4f/umAuynJgaBjLjBsiE/Nu0yhZ3sBoWvptQNmGHE0k40STcoXTiOOFc1vxmssr
         G7tRwGh/xmRZifCB/8xERtpTakorgUGQ4Qhpxnq+P2y8tTEwqj3JCv0qGu6nMynUshAM
         UzGBZ69QKAs6XzQCZhXj3mqZnYlpEUtmIIVbYBUEoC+BWtQ48wEAJeva+AJB324nx26q
         hoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJNpd1k/iXy/9vDDM1M28W1JVEcIvh8oM+RnMoJEaDg=;
        b=MNMlwXy/s9fUILVdI4FLXc2DzBxjtP/xBHtHIK8j03bRQ+Yt5MnCsmUc12fg3hxqlK
         MY7zkjmqS9b49pH3JLs7a3b3GiCmZmR2W2nwOWt5Cve5AdDgqxQZle3YJ3VaJZyqcufj
         eQqVH3XlxPnX36FSQ6IcTOliBt6Aw1FQIlOD5wFlHxSVst22oNhwnXmgSyZRwbzHv5/9
         iW26QM2lpU6/QvhT+AaDB4yaOz/5kBiTJfZxRBx3AIfzjfjD3wJcTv8Oh36PqglT7/pJ
         sd3iWlXdwJcuyMp269mRz262OAshFx10sFIeyAXx3OrSwCRmBZh928YP32Xgg2CN+aZ6
         iD7Q==
X-Gm-Message-State: AOAM533OmLnia1FAqRYZfTTrB9e6/uhXqZujaMsGZfZrUA/oWYdsLe2e
        9HQV41V3NzdZWuWJNPDMWNGdpB93psJrFXnMQ1MjcQ==
X-Google-Smtp-Source: ABdhPJx0KOv5hjFNV+JKZVJF3x+RtceP+aJ7B3sF18ElqWV3pnh4IpgxrrcPLOMIqDjkgYuIHIQEdHSXc6UXnGc6zhk=
X-Received: by 2002:a17:906:1e11:: with SMTP id g17mr8738428ejj.298.1599749539289;
 Thu, 10 Sep 2020 07:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200909224226.2177401-1-swboyd@chromium.org> <CABXOdTeWfuZHLywMU1d+No-NSZ4uusAgkhs=2hNZGFM-uYz2wA@mail.gmail.com>
 <c3ba5d92-8bfe-30d7-44f0-c8a3e40d1906@collabora.com>
In-Reply-To: <c3ba5d92-8bfe-30d7-44f0-c8a3e40d1906@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 10 Sep 2020 07:52:08 -0700
Message-ID: <CABXOdTdsVyae9oHKEMSbXOsi5VWUZhLbKVxeNVedc4redZineQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: Don't populate lightbar device if it
 isn't there
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 7:32 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi,
>
> On 10/9/20 16:18, Guenter Roeck wrote:
> > On Wed, Sep 9, 2020 at 3:42 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >>
> >> The cros ec lightbar driver has a check in probe to fail early if the ec
> >> device isn't the cros_ec one or if it can't read the lightbar version
> >> from the EC. Let's move this check to the place where the lightbar
> >> device is registered. This way we don't expose devices that aren't
> >> actually there on devices that don't have a lightbar.
> >>
> >> This should improve memory and possibly performance too because struct
> >> devices don't exactly have a small memory footprint and they contribute
> >> to suspend/resume regardless of driver attachment.
> >>
> >> Cc: Gwendal Grignou <gwendal@chromium.org>
> >> Cc: Guenter Roeck <groeck@chromium.org>
> >> Cc: Lee Jones <lee.jones@linaro.org>
> >> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> >> ---
> >>
> >> Changes from v1:
> >>  * Rebased on linux-next patches to this file
> >>
> >>  drivers/mfd/cros_ec_dev.c                   |  16 ++-
> >>  drivers/platform/chrome/cros_ec_lightbar.c  | 102 ++------------------
> >>  drivers/platform/chrome/cros_ec_proto.c     |  84 ++++++++++++++++
> >>  include/linux/platform_data/cros_ec_proto.h |   4 +
> >>  4 files changed, 111 insertions(+), 95 deletions(-)
> >>
> >> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> >> index d07b43d7c761..9e98b2ec5d92 100644
> >> --- a/drivers/mfd/cros_ec_dev.c
> >> +++ b/drivers/mfd/cros_ec_dev.c
> >> @@ -74,6 +74,10 @@ static const struct mfd_cell cros_ec_cec_cells[] = {
> >>         { .name = "cros-ec-cec", },
> >>  };
> >>
> >> +static const struct mfd_cell cros_ec_lightbar_cells[] = {
> >> +       { .name = "cros-ec-lightbar", },
> >> +};
> >> +
> >>  static const struct mfd_cell cros_ec_rtc_cells[] = {
> >>         { .name = "cros-ec-rtc", },
> >>  };
> >> @@ -112,7 +116,6 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
> >>  static const struct mfd_cell cros_ec_platform_cells[] = {
> >>         { .name = "cros-ec-chardev", },
> >>         { .name = "cros-ec-debugfs", },
> >> -       { .name = "cros-ec-lightbar", },
> >>         { .name = "cros-ec-sysfs", },
> >>  };
> >>
> >> @@ -206,6 +209,17 @@ static int ec_device_probe(struct platform_device *pdev)
> >>                 }
> >>         }
> >>
> >> +       if (!strcmp(ec_platform->ec_name, CROS_EC_DEV_NAME) &&
> >> +           !cros_ec_get_lightbar_version(ec, NULL, NULL)) {
> >
> > Any idea why the lightbar code doesn't use cros_ec_check_features() ?
> > There is a definition for EC_FEATURE_LIGHTBAR, but it doesn't seem to
> > be used. It would be much more convenient if that feature check could
> > be used instead of moving the get_lightbar_version command and its
> > helper function around.
> >
>
> IIRC it was to support a very old device, the Pixel Chromebook (Link). This flag
> is not set in this device but has a lightbar, hence we had this 'weird' way to
> detect the lightbar.
>

If that is the only reason, wouldn't it be better to use something
else (eg dmi_match) to determine if the system in question is a  Pixel
Chromebook (Link) ?

             if (!strcmp(ec_platform->ec_name, CROS_EC_DEV_NAME) &&
                 (cros_ec_check_features(ec, EC_FEATURE_LIGHTBAR) ||
                  dmi_match(DMI_PRODUCT_NAME, "Link")) {

Thanks,
Guenter

> > Thanks,
> > Guenter
> >
> >> +               retval = mfd_add_hotplug_devices(ec->dev,
> >> +                               cros_ec_lightbar_cells,
> >> +                               ARRAY_SIZE(cros_ec_lightbar_cells));
> >> +               if (retval)
> >> +                       dev_err(ec->dev,
> >> +                               "failed to add lightbar device: %d\n",
> >> +                               retval);
> >> +       }
> >> +
> >>         /*
> >>          * The PD notifier driver cell is separate since it only needs to be
> >>          * explicitly added on platforms that don't have the PD notifier ACPI
> >> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
> >> index de8dfb12e486..a7cfde90c8e5 100644
> >> --- a/drivers/platform/chrome/cros_ec_lightbar.c
> >> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> >> @@ -82,77 +82,6 @@ static int lb_throttle(void)
> >>         return ret;
> >>  }
> >>
> >> -static struct cros_ec_command *alloc_lightbar_cmd_msg(struct cros_ec_dev *ec)
> >> -{
> >> -       struct cros_ec_command *msg;
> >> -       int len;
> >> -
> >> -       len = max(sizeof(struct ec_params_lightbar),
> >> -                 sizeof(struct ec_response_lightbar));
> >> -
> >> -       msg = kmalloc(sizeof(*msg) + len, GFP_KERNEL);
> >> -       if (!msg)
> >> -               return NULL;
> >> -
> >> -       msg->version = 0;
> >> -       msg->command = EC_CMD_LIGHTBAR_CMD + ec->cmd_offset;
> >> -       msg->outsize = sizeof(struct ec_params_lightbar);
> >> -       msg->insize = sizeof(struct ec_response_lightbar);
> >> -
> >> -       return msg;
> >> -}
> >> -
> >> -static int get_lightbar_version(struct cros_ec_dev *ec,
> >> -                               uint32_t *ver_ptr, uint32_t *flg_ptr)
> >> -{
> >> -       struct ec_params_lightbar *param;
> >> -       struct ec_response_lightbar *resp;
> >> -       struct cros_ec_command *msg;
> >> -       int ret;
> >> -
> >> -       msg = alloc_lightbar_cmd_msg(ec);
> >> -       if (!msg)
> >> -               return 0;
> >> -
> >> -       param = (struct ec_params_lightbar *)msg->data;
> >> -       param->cmd = LIGHTBAR_CMD_VERSION;
> >> -       msg->outsize = sizeof(param->cmd);
> >> -       msg->result = sizeof(resp->version);
> >> -       ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> >> -       if (ret < 0 && ret != -EINVAL) {
> >> -               ret = 0;
> >> -               goto exit;
> >> -       }
> >> -
> >> -       switch (msg->result) {
> >> -       case EC_RES_INVALID_PARAM:
> >> -               /* Pixel had no version command. */
> >> -               if (ver_ptr)
> >> -                       *ver_ptr = 0;
> >> -               if (flg_ptr)
> >> -                       *flg_ptr = 0;
> >> -               ret = 1;
> >> -               goto exit;
> >> -
> >> -       case EC_RES_SUCCESS:
> >> -               resp = (struct ec_response_lightbar *)msg->data;
> >> -
> >> -               /* Future devices w/lightbars should implement this command */
> >> -               if (ver_ptr)
> >> -                       *ver_ptr = resp->version.num;
> >> -               if (flg_ptr)
> >> -                       *flg_ptr = resp->version.flags;
> >> -               ret = 1;
> >> -               goto exit;
> >> -       }
> >> -
> >> -       /* Anything else (ie, EC_RES_INVALID_COMMAND) - no lightbar */
> >> -       ret = 0;
> >> -exit:
> >> -       kfree(msg);
> >> -       return ret;
> >> -}
> >> -
> >>  static ssize_t version_show(struct device *dev,
> >>                             struct device_attribute *attr, char *buf)
> >>  {
> >> @@ -165,7 +94,7 @@ static ssize_t version_show(struct device *dev,
> >>                 return ret;
> >>
> >>         /* This should always succeed, because we check during init. */
> >> -       if (!get_lightbar_version(ec, &version, &flags))
> >> +       if (cros_ec_get_lightbar_version(ec, &version, &flags))
> >>                 return -EIO;
> >>
> >>         return scnprintf(buf, PAGE_SIZE, "%d %d\n", version, flags);
> >> @@ -184,7 +113,7 @@ static ssize_t brightness_store(struct device *dev,
> >>         if (kstrtouint(buf, 0, &val))
> >>                 return -EINVAL;
> >>
> >> -       msg = alloc_lightbar_cmd_msg(ec);
> >> +       msg = cros_ec_alloc_lightbar_cmd_msg(ec);
> >>         if (!msg)
> >>                 return -ENOMEM;
> >>
> >> @@ -222,7 +151,7 @@ static ssize_t led_rgb_store(struct device *dev, struct device_attribute *attr,
> >>         unsigned int val[4];
> >>         int ret, i = 0, j = 0, ok = 0;
> >>
> >> -       msg = alloc_lightbar_cmd_msg(ec);
> >> +       msg = cros_ec_alloc_lightbar_cmd_msg(ec);
> >>         if (!msg)
> >>                 return -ENOMEM;
> >>
> >> @@ -289,7 +218,7 @@ static ssize_t sequence_show(struct device *dev,
> >>         int ret;
> >>         struct cros_ec_dev *ec = to_cros_ec_dev(dev);
> >>
> >> -       msg = alloc_lightbar_cmd_msg(ec);
> >> +       msg = cros_ec_alloc_lightbar_cmd_msg(ec);
> >>         if (!msg)
> >>                 return -ENOMEM;
> >>
> >> @@ -324,7 +253,7 @@ static int lb_send_empty_cmd(struct cros_ec_dev *ec, uint8_t cmd)
> >>         struct cros_ec_command *msg;
> >>         int ret;
> >>
> >> -       msg = alloc_lightbar_cmd_msg(ec);
> >> +       msg = cros_ec_alloc_lightbar_cmd_msg(ec);
> >>         if (!msg)
> >>                 return -ENOMEM;
> >>
> >> @@ -352,7 +281,7 @@ static int lb_manual_suspend_ctrl(struct cros_ec_dev *ec, uint8_t enable)
> >>         struct cros_ec_command *msg;
> >>         int ret;
> >>
> >> -       msg = alloc_lightbar_cmd_msg(ec);
> >> +       msg = cros_ec_alloc_lightbar_cmd_msg(ec);
> >>         if (!msg)
> >>                 return -ENOMEM;
> >>
> >> @@ -399,7 +328,7 @@ static ssize_t sequence_store(struct device *dev, struct device_attribute *attr,
> >>                         return ret;
> >>         }
> >>
> >> -       msg = alloc_lightbar_cmd_msg(ec);
> >> +       msg = cros_ec_alloc_lightbar_cmd_msg(ec);
> >>         if (!msg)
> >>                 return -ENOMEM;
> >>
> >> @@ -444,7 +373,7 @@ static ssize_t program_store(struct device *dev, struct device_attribute *attr,
> >>                 return -EINVAL;
> >>         }
> >>
> >> -       msg = alloc_lightbar_cmd_msg(ec);
> >> +       msg = cros_ec_alloc_lightbar_cmd_msg(ec);
> >>         if (!msg)
> >>                 return -ENOMEM;
> >>
> >> @@ -531,24 +460,9 @@ static struct attribute_group cros_ec_lightbar_attr_group = {
> >>  static int cros_ec_lightbar_probe(struct platform_device *pd)
> >>  {
> >>         struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
> >> -       struct cros_ec_platform *pdata = dev_get_platdata(ec_dev->dev);
> >>         struct device *dev = &pd->dev;
> >>         int ret;
> >>
> >> -       /*
> >> -        * Only instantiate the lightbar if the EC name is 'cros_ec'. Other EC
> >> -        * devices like 'cros_pd' doesn't have a lightbar.
> >> -        */
> >> -       if (strcmp(pdata->ec_name, CROS_EC_DEV_NAME) != 0)
> >> -               return -ENODEV;
> >> -
> >> -       /*
> >> -        * Ask then for the lightbar version, if it's 0 then the 'cros_ec'
> >> -        * doesn't have a lightbar.
> >> -        */
> >> -       if (!get_lightbar_version(ec_dev, NULL, NULL))
> >> -               return -ENODEV;
> >> -
> >>         /* Take control of the lightbar from the EC. */
> >>         lb_manual_suspend_ctrl(ec_dev, 1);
> >>
> >> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> >> index dda182132a6a..a08747eec36a 100644
> >> --- a/drivers/platform/chrome/cros_ec_proto.c
> >> +++ b/drivers/platform/chrome/cros_ec_proto.c
> >> @@ -922,3 +922,87 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
> >>         return sensor_count;
> >>  }
> >>  EXPORT_SYMBOL_GPL(cros_ec_get_sensor_count);
> >> +
> >> +struct cros_ec_command *cros_ec_alloc_lightbar_cmd_msg(struct cros_ec_dev *ec)
> >> +{
> >> +       struct cros_ec_command *msg;
> >> +       int len;
> >> +
> >> +       len = max(sizeof(struct ec_params_lightbar),
> >> +                 sizeof(struct ec_response_lightbar));
> >> +
> >> +       msg = kmalloc(sizeof(*msg) + len, GFP_KERNEL);
> >> +       if (!msg)
> >> +               return NULL;
> >> +
> >> +       msg->version = 0;
> >> +       msg->command = EC_CMD_LIGHTBAR_CMD + ec->cmd_offset;
> >> +       msg->outsize = sizeof(struct ec_params_lightbar);
> >> +       msg->insize = sizeof(struct ec_response_lightbar);
> >> +
> >> +       return msg;
> >> +}
> >> +EXPORT_SYMBOL_GPL(cros_ec_alloc_lightbar_cmd_msg);
> >> +
> >> +/**
> >> + * cros_ec_get_lightbar_version() - Get the EC lightbar version
> >> + *
> >> + * @ec: EC device, does not have to be connected directly to the AP,
> >> + *      can be daisy chained through another device.
> >> + * @ver_ptr: Detected lightbar version number
> >> + * @flag_ptr: Detected lightbar flags
> >> + *
> >> + * Call this function to determine the EC's lightbar version and flags
> >> + * information. If it doesn't exist then this function returns a negative
> >> + * error value.
> >> + *
> >> + * Return: 0 on success, negative errno on failure to detect a lightbar.
> >> + */
> >> +int cros_ec_get_lightbar_version(struct cros_ec_dev *ec, uint32_t *ver_ptr,
> >> +                                uint32_t *flg_ptr)
> >> +{
> >> +       struct ec_params_lightbar *param;
> >> +       struct ec_response_lightbar *resp;
> >> +       struct cros_ec_command *msg;
> >> +       int ret;
> >> +
> >> +       msg = cros_ec_alloc_lightbar_cmd_msg(ec);
> >> +       if (!msg)
> >> +               return -ENOMEM;
> >> +
> >> +       param = (struct ec_params_lightbar *)msg->data;
> >> +       param->cmd = LIGHTBAR_CMD_VERSION;
> >> +       msg->outsize = sizeof(param->cmd);
> >> +       msg->result = sizeof(resp->version);
> >> +       ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
> >> +       if (ret < 0 && ret != -EINVAL)
> >> +               goto exit;
> >> +
> >> +       switch (msg->result) {
> >> +       case EC_RES_INVALID_PARAM:
> >> +               /* Pixel had no version command. */
> >> +               if (ver_ptr)
> >> +                       *ver_ptr = 0;
> >> +               if (flg_ptr)
> >> +                       *flg_ptr = 0;
> >> +               ret = 0;
> >> +               break;
> >> +       case EC_RES_SUCCESS:
> >> +               resp = (struct ec_response_lightbar *)msg->data;
> >> +
> >> +               /* Future devices w/lightbars should implement this command */
> >> +               if (ver_ptr)
> >> +                       *ver_ptr = resp->version.num;
> >> +               if (flg_ptr)
> >> +                       *flg_ptr = resp->version.flags;
> >> +               ret = 0;
> >> +               break;
> >> +       default:
> >> +               /* Anything else (ie, EC_RES_INVALID_COMMAND) - no lightbar */
> >> +               ret = -ENODEV;
> >> +       }
> >> +exit:
> >> +       kfree(msg);
> >> +       return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(cros_ec_get_lightbar_version);
> >> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> >> index 4a415ae851ef..50221254956c 100644
> >> --- a/include/linux/platform_data/cros_ec_proto.h
> >> +++ b/include/linux/platform_data/cros_ec_proto.h
> >> @@ -229,6 +229,10 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
> >>
> >>  int cros_ec_check_features(struct cros_ec_dev *ec, int feature);
> >>
> >> +struct cros_ec_command *cros_ec_alloc_lightbar_cmd_msg(struct cros_ec_dev *ec);
> >> +int cros_ec_get_lightbar_version(struct cros_ec_dev *ec, uint32_t *ver_ptr,
> >> +                                uint32_t *flg_ptr);
> >> +
> >>  int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
> >>
> >>  /**
> >>
> >> base-commit: 1e7913ff5f9f1b73146ad8522958bd266f22a510
> >> --
> >> Sent by a computer, using git, on the internet
> >>
