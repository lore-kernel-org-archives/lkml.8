Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86CCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75AED206A1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbJaNpSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgGFWqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 18:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGFWqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 18:46:33 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC1FC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 15:46:32 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id e15so21501404vsc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 15:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sNVF5CnZpEvopFse1SwVYmRIleMP+fZOOsgSF4ZS0Cg=;
        b=gbJaNpSHJHBNYV5rcLWWNW9JMOgIXeGHA91mk/6x0gAWV/cWxBjKDmM7dzUBJ0ggoL
         eg8nomVe4v5GyF/bUgEHwLBVDuD9s9fesTZTw+/TupESCIVgDrmkoHmLp40qVvHcrFGp
         8ZTJMH64+P0sJ+1ZkLllZPoZmORrnrnS8DIKXhUvJeZqEL/o+I/WvnZ42nr8mcpDA5OC
         Mf+hzJE+OwGNmboTJlvhKeyg6+J008aFj5E6SxoEueAIkejHeDwYryRY7I0uUVy+61NE
         uk+yzQWUhu8HlVRK8BzKTGxsfhbQysaKLtq40vbkUDf8pbbxprZw2lCufrpTvpOUIKh0
         vQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNVF5CnZpEvopFse1SwVYmRIleMP+fZOOsgSF4ZS0Cg=;
        b=lScoM/0DLKSyF9lGwjojGk0vGVnp3KZJrcXXYHIWlhV9feh8tPNhA9tqw7H01dXiy5
         EFrQsmnDSHxkKnAkt3XimxuOIDJl1IVP8yZBQuuhzBsEgUmZJzpDx6+rrpCRlWmSGtjw
         sQPC1XeADVIBVO+C8oDiMFm0NsJDK9Hh6dNb+eHKKKkE0do0U/a3KMPdke1L3b8vjjNm
         CsrujqHB9g3fvKyMCQBZifdMgXFNecHLjziWdkGp9RAvszpO6SrClNbeZtnBgPxgvhJJ
         d6dOcTyIGnjLI1pN1jn7cQQt45pSR3766irGb1+k7+0B+EH0NAtN1g8MoAdndlG51RU/
         pDew==
X-Gm-Message-State: AOAM533utdtyWe8WthQOzTXlii04qXmG0reGYDHh+ztscHWDEP13xVlW
        +5lob4KVkmrltH81mOUbrp6Amce2gCBCvmGvdKK2xg==
X-Google-Smtp-Source: ABdhPJyS6D/b191B6sm6EQ58qcL8cGprivYEEHcEhBD9BDY8C5Sze8VX2wqz8ZLPTQ9GYLyhqrZI3GeGAXF7pv+oSI4=
X-Received: by 2002:a05:6102:126a:: with SMTP id q10mr19841580vsg.35.1594075591757;
 Mon, 06 Jul 2020 15:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200706221001.1996816-1-linchuyuan@google.com> <20200706221001.1996816-2-linchuyuan@google.com>
In-Reply-To: <20200706221001.1996816-2-linchuyuan@google.com>
From:   Chu Lin <linchuyuan@google.com>
Date:   Mon, 6 Jul 2020 15:46:20 -0700
Message-ID: <CAKCA56BUZ29ahLDPN_Atqn_PGUn5hA7FoVAC08qYnXwOzOuRwg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] hwmon:max6697: Allow max6581 to create tempX_offset
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kais Belgaied <belgaied@google.com>,
        Jason Ling <jasonling@google.com>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhongqi Li <zhongqil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 3:10 PM Chu Lin <linchuyuan@google.com> wrote:
>
> ---
>  drivers/hwmon/max6697.c | 100 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 96 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
> index 64122eb38060..8c814c544116 100644
> --- a/drivers/hwmon/max6697.c
> +++ b/drivers/hwmon/max6697.c
> @@ -57,6 +57,9 @@ static const u8 MAX6697_REG_CRIT[] = {
>  #define MAX6581_REG_IDEALITY_SELECT    0x4c
>  #define MAX6581_REG_OFFSET             0x4d
>  #define MAX6581_REG_OFFSET_SELECT      0x4e
> +#define MAX6581_OFFSET_MIN             -31750
> +#define MAX6581_OFFSET_MAX             31750
> +
>
>  #define MAX6697_CONV_TIME              156     /* ms per channel, worst case */
>
> @@ -172,6 +175,11 @@ static const struct max6697_chip_data max6697_chip_data[] = {
>         },
>  };
>
> +static inline int max6581_offset_to_millic(int val)
> +{
> +       return val & (1 << 7) ? (val | 0xffffff00) * 250 : val * 250;
> +}
> +
>  static struct max6697_data *max6697_update_device(struct device *dev)
>  {
>         struct max6697_data *data = dev_get_drvdata(dev);
> @@ -317,6 +325,69 @@ static ssize_t temp_store(struct device *dev,
>         return ret < 0 ? ret : count;
>  }
>
> +static ssize_t offset_store(struct device *dev,
> +                           struct device_attribute *devattr, const char *buf,
> +                           size_t count)
> +{
> +       long temp;
> +       u8 val, select;
> +       int ret, index;
> +       struct max6697_data *data;
> +
> +       index = to_sensor_dev_attr(devattr)->index;
> +       data = dev_get_drvdata(dev);
> +       select = i2c_smbus_read_byte_data(data->client,
> +                                         MAX6581_REG_OFFSET_SELECT);
> +       if (select < 0)
> +               return select;
This is always false due to its type. This error is caught by the
kernel test robot.
I will submit a new version to address this issue.

> +       ret = kstrtol(buf, 10, &temp);
> +       if (ret < 0)
> +               return ret;
> +       /* disable the offset for channel */
> +       if (temp == 0) {
> +               ret = i2c_smbus_write_byte_data(data->client,
> +                                               MAX6581_REG_OFFSET_SELECT,
> +                                               select & ~(1 << (index - 1)));
> +               return ret < 0 ? ret : count;
> +       }
> +       temp = clamp_val(temp, MAX6581_OFFSET_MIN, MAX6581_OFFSET_MAX);
> +       val = DIV_ROUND_CLOSEST(temp, 250);
> +       mutex_lock(&data->update_lock);
> +       ret = i2c_smbus_write_byte_data(data->client,
> +                                       MAX6581_REG_OFFSET_SELECT,
> +                                       select | (1 << (index - 1)));
> +       if (ret < 0)
> +               return ret;
> +       ret = i2c_smbus_write_byte_data(data->client,
> +                                       MAX6581_REG_OFFSET,
> +                                       val);
> +       mutex_unlock(&data->update_lock);
> +       return ret < 0 ? ret : count;
> +}
> +
> +static ssize_t offset_show(struct device *dev, struct device_attribute *devattr,
> +                          char *buf)
> +{
> +       int select, ret, index;
> +       struct max6697_data *data;
> +
> +       index = to_sensor_dev_attr(devattr)->index;
> +       data = dev_get_drvdata(dev);
> +       select = i2c_smbus_read_byte_data(data->client,
> +                                         MAX6581_REG_OFFSET_SELECT);
> +       if (select < 0)
> +               return select;
> +       if (select & (1 << (index - 1))) {
> +               ret = i2c_smbus_read_byte_data(data->client,
> +                                              MAX6581_REG_OFFSET);
> +               if (ret < 0)
> +                       return ret;
> +       } else {
> +               return sprintf(buf, "%d\n", 0);
> +       }
> +       return sprintf(buf, "%d\n", max6581_offset_to_millic(ret));
> +}
> +
>  static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
>  static SENSOR_DEVICE_ATTR_2_RW(temp1_max, temp, 0, MAX6697_TEMP_MAX);
>  static SENSOR_DEVICE_ATTR_2_RW(temp1_crit, temp, 0, MAX6697_TEMP_CRIT);
> @@ -375,6 +446,15 @@ static SENSOR_DEVICE_ATTR_RO(temp6_fault, alarm, 5);
>  static SENSOR_DEVICE_ATTR_RO(temp7_fault, alarm, 6);
>  static SENSOR_DEVICE_ATTR_RO(temp8_fault, alarm, 7);
>
> +/* There is no offset for local temperature so starting from temp2 */
> +static SENSOR_DEVICE_ATTR_RW(temp2_offset, offset, 1);
> +static SENSOR_DEVICE_ATTR_RW(temp3_offset, offset, 2);
> +static SENSOR_DEVICE_ATTR_RW(temp4_offset, offset, 3);
> +static SENSOR_DEVICE_ATTR_RW(temp5_offset, offset, 4);
> +static SENSOR_DEVICE_ATTR_RW(temp6_offset, offset, 5);
> +static SENSOR_DEVICE_ATTR_RW(temp7_offset, offset, 6);
> +static SENSOR_DEVICE_ATTR_RW(temp8_offset, offset, 7);
> +
>  static DEVICE_ATTR(dummy, 0, NULL, NULL);
>
>  static umode_t max6697_is_visible(struct kobject *kobj, struct attribute *attr,
> @@ -383,8 +463,8 @@ static umode_t max6697_is_visible(struct kobject *kobj, struct attribute *attr,
>         struct device *dev = container_of(kobj, struct device, kobj);
>         struct max6697_data *data = dev_get_drvdata(dev);
>         const struct max6697_chip_data *chip = data->chip;
> -       int channel = index / 6;        /* channel number */
> -       int nr = index % 6;             /* attribute index within channel */
> +       int channel = index / 8;        /* channel number */
> +       int nr = index % 7;             /* attribute index within channel */
>
>         if (channel >= chip->channels)
>                 return 0;
> @@ -393,6 +473,10 @@ static umode_t max6697_is_visible(struct kobject *kobj, struct attribute *attr,
>                 return 0;
>         if (nr == 5 && !(chip->have_fault & (1 << channel)))
>                 return 0;
> +       /* offset reg is only supported on max6581 remote channels */
> +       if (nr == 6)
> +               if (data->type != max6581 || channel == 0)
> +                       return 0;
>
>         return attr->mode;
>  }
> @@ -409,6 +493,7 @@ static struct attribute *max6697_attributes[] = {
>         &sensor_dev_attr_temp1_crit.dev_attr.attr,
>         &sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
>         &dev_attr_dummy.attr,
> +       &dev_attr_dummy.attr,
>
>         &sensor_dev_attr_temp2_input.dev_attr.attr,
>         &sensor_dev_attr_temp2_max.dev_attr.attr,
> @@ -416,6 +501,7 @@ static struct attribute *max6697_attributes[] = {
>         &sensor_dev_attr_temp2_crit.dev_attr.attr,
>         &sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
>         &sensor_dev_attr_temp2_fault.dev_attr.attr,
> +       &sensor_dev_attr_temp2_offset.dev_attr.attr,
>
>         &sensor_dev_attr_temp3_input.dev_attr.attr,
>         &sensor_dev_attr_temp3_max.dev_attr.attr,
> @@ -423,6 +509,7 @@ static struct attribute *max6697_attributes[] = {
>         &sensor_dev_attr_temp3_crit.dev_attr.attr,
>         &sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
>         &sensor_dev_attr_temp3_fault.dev_attr.attr,
> +       &sensor_dev_attr_temp3_offset.dev_attr.attr,
>
>         &sensor_dev_attr_temp4_input.dev_attr.attr,
>         &sensor_dev_attr_temp4_max.dev_attr.attr,
> @@ -430,6 +517,7 @@ static struct attribute *max6697_attributes[] = {
>         &sensor_dev_attr_temp4_crit.dev_attr.attr,
>         &sensor_dev_attr_temp4_crit_alarm.dev_attr.attr,
>         &sensor_dev_attr_temp4_fault.dev_attr.attr,
> +       &sensor_dev_attr_temp4_offset.dev_attr.attr,
>
>         &sensor_dev_attr_temp5_input.dev_attr.attr,
>         &sensor_dev_attr_temp5_max.dev_attr.attr,
> @@ -437,6 +525,7 @@ static struct attribute *max6697_attributes[] = {
>         &sensor_dev_attr_temp5_crit.dev_attr.attr,
>         &sensor_dev_attr_temp5_crit_alarm.dev_attr.attr,
>         &sensor_dev_attr_temp5_fault.dev_attr.attr,
> +       &sensor_dev_attr_temp5_offset.dev_attr.attr,
>
>         &sensor_dev_attr_temp6_input.dev_attr.attr,
>         &sensor_dev_attr_temp6_max.dev_attr.attr,
> @@ -444,6 +533,7 @@ static struct attribute *max6697_attributes[] = {
>         &sensor_dev_attr_temp6_crit.dev_attr.attr,
>         &sensor_dev_attr_temp6_crit_alarm.dev_attr.attr,
>         &sensor_dev_attr_temp6_fault.dev_attr.attr,
> +       &sensor_dev_attr_temp6_offset.dev_attr.attr,
>
>         &sensor_dev_attr_temp7_input.dev_attr.attr,
>         &sensor_dev_attr_temp7_max.dev_attr.attr,
> @@ -451,6 +541,7 @@ static struct attribute *max6697_attributes[] = {
>         &sensor_dev_attr_temp7_crit.dev_attr.attr,
>         &sensor_dev_attr_temp7_crit_alarm.dev_attr.attr,
>         &sensor_dev_attr_temp7_fault.dev_attr.attr,
> +       &sensor_dev_attr_temp7_offset.dev_attr.attr,
>
>         &sensor_dev_attr_temp8_input.dev_attr.attr,
>         &sensor_dev_attr_temp8_max.dev_attr.attr,
> @@ -458,6 +549,7 @@ static struct attribute *max6697_attributes[] = {
>         &sensor_dev_attr_temp8_crit.dev_attr.attr,
>         &sensor_dev_attr_temp8_crit_alarm.dev_attr.attr,
>         &sensor_dev_attr_temp8_fault.dev_attr.attr,
> +       &sensor_dev_attr_temp8_offset.dev_attr.attr,
>         NULL
>  };
>
> @@ -494,8 +586,8 @@ static void max6697_get_config_of(struct device_node *node,
>         }
>         prop = of_get_property(node, "transistor-ideality", &len);
>         if (prop && len == 2 * sizeof(u32)) {
> -                       pdata->ideality_mask = be32_to_cpu(prop[0]);
> -                       pdata->ideality_value = be32_to_cpu(prop[1]);
> +               pdata->ideality_mask = be32_to_cpu(prop[0]);
> +               pdata->ideality_value = be32_to_cpu(prop[1]);
>         }
>  }
>
> --
> 2.27.0.383.g050319c2ae-goog
>
