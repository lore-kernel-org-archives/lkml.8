Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7357C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A121C20706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgHYEQL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:16:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52649 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgHYEQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:16:08 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1kAQNR-0002fh-BH
        for linux-kernel@vger.kernel.org; Tue, 25 Aug 2020 04:16:05 +0000
Received: by mail-wr1-f69.google.com with SMTP id z12so4606370wrl.16
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kgxbRmIP6R0ErtpJAkJRBnuc548uo/ekMXqpfcr3m4g=;
        b=RUw16ZEcdPt8QQZyPb/dY6LcfFKvOj/TgHodxvooyN2FyS3VyL7tdC2giE5k5Xoe2z
         lH6yzeCOYul48B3ZiHJowI3DdT1urIdFwTH4Z937xCZ+y7poOZDpYKcgDUdh14Wd8p0K
         6bNrZUmp5cU0hgGEafcVFr1otOcMLfb8LB2cwSmX3QTmVUf7f6CFlqM5ZxL1yuYR59DZ
         f67U3PzU+ACOPjX6pBxMQuyyF29eUqxPkq9Xacq7erYdCvJRig2zmREvdnVfzA7B2DtA
         PRgAe4WmSEaazhVP/cHW0eIUg+x9ligyb1SYfhWZ7U26AptOfTIGXvSxQv6+PGlrWRHC
         CoPw==
X-Gm-Message-State: AOAM531hr5XeGvONCFlNJhPjOFriL7304+tGD3bkblCsGZd4UZa8llMn
        rts0Cz3uIJFi57Q+2029iELNkoBsJTOgorEp88P0JXgw8xwF1QC+3ZzddA/bamAXIzZ8ZZzghN/
        /mnbJP8OcrXmMeFim7ZTy5nhx2itBeZU1w78T9u5dYP0h3Jb8+LKrdAxMCw==
X-Received: by 2002:adf:fb87:: with SMTP id a7mr9230472wrr.390.1598328964557;
        Mon, 24 Aug 2020 21:16:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyatEwbKLBBPHhrGzPreNFFZtCXEQIf642F8YgpSExvdf9Zs5RBjfvRO1dVNop6l5sVdNvpAElASgqD7joY+yw=
X-Received: by 2002:adf:fb87:: with SMTP id a7mr9230454wrr.390.1598328964278;
 Mon, 24 Aug 2020 21:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200824054347.3805-1-william.sung@advantech.com.tw>
In-Reply-To: <20200824054347.3805-1-william.sung@advantech.com.tw>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Tue, 25 Aug 2020 12:15:53 +0800
Message-ID: <CAFv23Q=CtNO9+sJzp2gtsRmRs79vidCWroBe3iQiUpqDyVULfA@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5593r: Dynamically set AD5593R channel modes
To:     William Sung <william.sung@advantech.com.tw>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Campion Kang <Campion.Kang@advantech.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

Please read my comment below.

William Sung <william.sung@advantech.com.tw> 於 2020年8月24日 週一 下午1:43寫道：
>
> To use ad5593r more flexibly, we use the module parameter to setting the
> channel modes dynamically whenever the module probe up. Users can pass
> the channel modes to the module parameter for allocating the
> functionality of channels as desired.
>
> For example:
> * Use in the kernel command line:
> Users can add the module parameter in the kernel command line such as
>
>     "ad5593r.ch_mode_cmdline=88001122"
>
> "88001122" means the channel mode setting for each channel. The most
> left side indicates the mode of channel 7, and the most right side
> indicates the mode of channel 0.
>
> * Use when manually probe the module:
> Similar to the kernel command line usage, users can enter
>
>     "modprobe ad5593r ch_mode_probe=88001122"
The usage of the parameters do not match the one written in the code,
which is "ch_mode"

>
> to start the ad5593r module with the desired channel mode setting.
>
> Signed-off-by: William Sung <william.sung@advantech.com.tw>
> ---
>  drivers/iio/dac/ad5592r-base.c | 33 ++++++++++++++++++--
>  drivers/iio/dac/ad5592r-base.h |  4 +++
>  drivers/iio/dac/ad5593r.c      | 55 ++++++++++++++++++++++++++++++++++
>  3 files changed, 89 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
> index cc4875660a69..cd69a34fa21e 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -21,6 +21,10 @@
>
>  #include "ad5592r-base.h"
>
> +/* Parameters for dynamic channel mode setting */
> +static u8 update_channel_mode;
> +static u8 new_channel_modes[AD559XR_CHANNEL_NR];
> +
>  static int ad5592r_gpio_get(struct gpio_chip *chip, unsigned offset)
>  {
>         struct ad5592r_state *st = gpiochip_get_data(chip);
> @@ -132,7 +136,7 @@ static int ad5592r_gpio_init(struct ad5592r_state *st)
>
>         st->gpiochip.label = dev_name(st->dev);
>         st->gpiochip.base = -1;
> -       st->gpiochip.ngpio = 8;
> +       st->gpiochip.ngpio = AD559XR_CHANNEL_NR;
>         st->gpiochip.parent = st->dev;
>         st->gpiochip.can_sleep = true;
>         st->gpiochip.direction_input = ad5592r_gpio_direction_input;
> @@ -287,6 +291,14 @@ static int ad5592r_set_channel_modes(struct ad5592r_state *st)
>         return ret;
>  }
>
> +static void ad5592r_set_def_channel_modes(struct ad5592r_state *st)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(st->channel_modes); i++)
> +               st->channel_modes[i] = new_channel_modes[i];
> +}
> +
>  static int ad5592r_reset_channel_modes(struct ad5592r_state *st)
>  {
>         int i;
> @@ -532,6 +544,10 @@ static int ad5592r_alloc_channels(struct iio_dev *iio_dev)
>                         st->channel_offstate[reg] = tmp;
>         }
>
> +       /* Update default channel modes set by external module */
> +       if (update_channel_mode == 1)
> +               ad5592r_set_def_channel_modes(st);
> +
>         channels = devm_kcalloc(st->dev,
>                         1 + 2 * num_channels, sizeof(*channels),
>                         GFP_KERNEL);
> @@ -567,7 +583,7 @@ static int ad5592r_alloc_channels(struct iio_dev *iio_dev)
>         }
>
>         channels[curr_channel].type = IIO_TEMP;
> -       channels[curr_channel].channel = 8;
> +       channels[curr_channel].channel = AD559XR_CHANNEL_NR;
>         channels[curr_channel].info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>                                    BIT(IIO_CHAN_INFO_SCALE) |
>                                    BIT(IIO_CHAN_INFO_OFFSET);
> @@ -589,6 +605,17 @@ static void ad5592r_init_scales(struct ad5592r_state *st, int vref_mV)
>                 div_s64_rem(tmp * 2, 1000000000LL, &st->scale_avail[1][1]);
>  }
>
> +void ad5592r_update_default_channel_modes(u8 *new_modes)
> +{
> +       int idx = 0;
> +
> +       update_channel_mode = 1;
> +       for (idx = 0; idx < AD559XR_CHANNEL_NR; idx++)
> +               new_channel_modes[idx] = new_modes[idx];
> +
> +}
> +EXPORT_SYMBOL_GPL(ad5592r_update_default_channel_modes);
> +
>  int ad5592r_probe(struct device *dev, const char *name,
>                 const struct ad5592r_rw_ops *ops)
>  {
> @@ -603,7 +630,7 @@ int ad5592r_probe(struct device *dev, const char *name,
>         st = iio_priv(iio_dev);
>         st->dev = dev;
>         st->ops = ops;
> -       st->num_channels = 8;
> +       st->num_channels = AD559XR_CHANNEL_NR;
>         dev_set_drvdata(dev, iio_dev);
>
>         st->reg = devm_regulator_get_optional(dev, "vref");
> diff --git a/drivers/iio/dac/ad5592r-base.h b/drivers/iio/dac/ad5592r-base.h
> index 23dac2f1ff8a..40ad6369e660 100644
> --- a/drivers/iio/dac/ad5592r-base.h
> +++ b/drivers/iio/dac/ad5592r-base.h
> @@ -39,6 +39,9 @@ enum ad5592r_registers {
>  #define AD5592R_REG_CTRL_ADC_RANGE     BIT(5)
>  #define AD5592R_REG_CTRL_DAC_RANGE     BIT(4)
>
> +/* Define quantity of channels of AD5592R/AD5593R */
> +#define AD559XR_CHANNEL_NR             8
> +
>  struct ad5592r_rw_ops {
>         int (*write_dac)(struct ad5592r_state *st, unsigned chan, u16 value);
>         int (*read_adc)(struct ad5592r_state *st, unsigned chan, u16 *value);
> @@ -69,6 +72,7 @@ struct ad5592r_state {
>         __be16 spi_msg_nop;
>  };
>
> +void ad5592r_update_default_channel_modes(u8 *new_modes);
>  int ad5592r_probe(struct device *dev, const char *name,
>                 const struct ad5592r_rw_ops *ops);
>  int ad5592r_remove(struct device *dev);
> diff --git a/drivers/iio/dac/ad5593r.c b/drivers/iio/dac/ad5593r.c
> index 1fbe9c019c7f..dfc453a75ad6 100644
> --- a/drivers/iio/dac/ad5593r.c
> +++ b/drivers/iio/dac/ad5593r.c
> @@ -21,6 +21,10 @@
>  #define AD5593R_MODE_GPIO_READBACK     (6 << 4)
>  #define AD5593R_MODE_REG_READBACK      (7 << 4)
>
> +/* Parameters for dynamic channel mode setting */
> +static char *ch_mode = "";
> +module_param(ch_mode, charp, 0400);
> +
>  static int ad5593r_write_dac(struct ad5592r_state *st, unsigned chan, u16 value)
>  {
>         struct i2c_client *i2c = to_i2c_client(st->dev);
> @@ -92,9 +96,60 @@ static const struct ad5592r_rw_ops ad5593r_rw_ops = {
>         .gpio_read = ad5593r_gpio_read,
>  };
>
> +static void ad5593r_check_new_channel_mode(void)
> +{
> +       char *new_mode[2] = {NULL, NULL}, tmp[2];
> +       u8 new_ch_modes[AD559XR_CHANNEL_NR];
> +       int idx = 0, cnt = 0, i;
> +
> +       if (strlen(ch_mode) == AD559XR_CHANNEL_NR)
> +               new_mode[cnt++] = ch_mode;
> +
> +       for (i = 0; i < cnt; i++) {
> +               /* Check if all channel modes are valid */
> +               for (idx = 0; idx < AD559XR_CHANNEL_NR; idx++) {
> +                       switch (new_mode[i][idx]) {
> +                       case '0':
> +                       case '1':
> +                       case '2':
> +                       case '3':
> +                       case '8':
> +                               continue;
> +                       default:
> +                               /* There is invalid mode exist, ignore the settings */
> +                               pr_err("%s: invalid(%c) in index(%d)\n",
> +                                       __func__, new_mode[i][idx], idx);
> +                               goto inval_para;
> +                       }
> +               }
It looks like the for loop is redundant, the cnt is 1 or 0, you can
return it directly if cnt equals to 0

> +
> +inval_para:
> +               /* There is invalid parameters setting in current parameter, so ignore it */
> +               if (idx < AD559XR_CHANNEL_NR)
> +                       continue;
> +
> +               /* Set the new modes to ad5592r-base driver to setup the new channe modes */
> +               memset(tmp, 0, 2);
> +               for (idx = 0; idx < AD559XR_CHANNEL_NR; idx++) {
> +                       tmp[0] = new_mode[i][idx];
> +                       if (kstrtou8(tmp, 10, &new_ch_modes[AD559XR_CHANNEL_NR - idx - 1])) {
> +                               pr_err("%s: kstr error idx(%d)\n", __func__, idx);
> +                               break;
> +                       }
> +               }
> +               /* Something error when convering the string to integer, ignore the settings */
> +               if (idx < AD559XR_CHANNEL_NR)
> +                       continue;
> +
> +               ad5592r_update_default_channel_modes(new_ch_modes);
> +               break;
> +       }
> +}
> +
>  static int ad5593r_i2c_probe(struct i2c_client *i2c,
>                 const struct i2c_device_id *id)
>  {
> +       ad5593r_check_new_channel_mode();
>         return ad5592r_probe(&i2c->dev, id->name, &ad5593r_rw_ops);
>  }
>
> --
> 2.17.1
>
