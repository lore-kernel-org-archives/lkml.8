Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8797DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F5D62063A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgY4g9AW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgHXNjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgHXNgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:36:31 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA89C061575;
        Mon, 24 Aug 2020 06:36:30 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h2so4249527plr.0;
        Mon, 24 Aug 2020 06:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OX/tEnyjSmwGO4+KS6mzwn4tJQebtMgLhSch/JL2IRM=;
        b=YgY4g9AWE7wkBUJ+6Bf8PTo2HfGCgsisPerswcPcqSi/emZ9+xqtqeo6kDSojs2Nci
         xMHxtKpRM5BgmePzHVWrsJphTMmQiTEVMoamCCm4rhq52qOYlu8TSr3Xxggj/Am7uxtD
         C/sDn5mDyoi2T1Rv/B00wimWfrscHaNiSpD/J2osgfKAdQPED4tCgneR/AaXt2ClloIQ
         iW04vPxCyZg0wuC9IZB1kfDa1cpDviG5g8vvKDXjncCS0NC6FFOS1ZM7coRsqG7xqjrU
         WhslmvoXvOUHiN/uUVYQ6JQe53Plu8Ih4GJf/RpepETw6QnVAF4XGL5Nv9OoYzdkMLdY
         tk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OX/tEnyjSmwGO4+KS6mzwn4tJQebtMgLhSch/JL2IRM=;
        b=l2CwcHFCnoK92h0UBlkqOHUbJYg1qlwEn0lFW2is8/zEt0vt6MOkbLMyGBfgN43g3I
         lppGD/CdJD/llmkENY3aK+PItCISvj0IefdKUCi2kbRcTYOTpzKo760wX+4RzUmblRay
         hGBmrNG6DiDwGq2lsvc/RChW1k+tGqABefshBeeXEkMSZKpseZVp4mgaZ4sSvPbiz6aO
         EPRbpT5zhxpJ13+hoiSRE8cl5Q5Xg9OHIRtT0oGBci15nyufUQOt9xRf6tAfKwEjjvY/
         Um4JPApnMJLtxC3wSOtxlneIxa0GZHvTHYkzoXYGKpQX6UUHvTIh+JYlbF8nbe8vbOeE
         2i3A==
X-Gm-Message-State: AOAM532d1tpBm2iTzXF2oRz60zNXkKZNZN2+BZ8xlumUpaRPyFHoRQVk
        dwNIblnqtemdXRlJHXt/Xf0=
X-Google-Smtp-Source: ABdhPJwNiclDtaHm9q/6xG/LP5er2egSMJnBPp2GEBHh6ZJ7bqNxBq38jDW7fJbbrTKUSTRMADDrwQ==
X-Received: by 2002:a17:90b:3641:: with SMTP id nh1mr4634389pjb.157.1598276190300;
        Mon, 24 Aug 2020 06:36:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k5sm10215204pgk.78.2020.08.24.06.36.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 06:36:29 -0700 (PDT)
Date:   Mon, 24 Aug 2020 06:36:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?utf-8?B?WGlhby5NWC5NYSDppqzpqY0=?= <Xiao.MX.Ma@deltaww.com>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [PATCH] hwmon/pmbus/delta:new driver for Delta modules
 Q54SJ108A2 The driver is used for Q54SJ108A2 series of Delta. Signed-off-by:
 xiao.mx.ma <734056705@qq.com>
Message-ID: <20200824133628.GA192024@roeck-us.net>
References: <65d67bfd3f704d33a02d20f515a183b1@deltaww.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65d67bfd3f704d33a02d20f515a183b1@deltaww.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 08:51:38AM +0000, Xiao.MX.Ma 馬驍 wrote:
> The driver is used for Q54SJ108A2 series of Delta.
> Signed-off-by: xiao.mx.ma <xiao.mx.ma@deltaww.com>

Submission on top of the previous patch instead of a clean v2,
subject still starting with [PATCH]{PATCH], no change log,
delta_read_word_data() and delta_read_byte_data() still as
unnecessary as before, and, worst of all, "is for the sole use
of the intended recipient(s) and may contain confidential and
privileged information" trailer.

I should not even reply to this e-mail. Please study and follow
Documentation/hwmon/submitting-patches.rst and documents referenced
therein before resubmitting.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/Kconfig                   | 18 +++---
>  drivers/hwmon/pmbus/Makefile                  |  2 +-
>  drivers/hwmon/pmbus/{Q54SJ108A2.c => delta.c} | 57 +------------------
>  3 files changed, 12 insertions(+), 65 deletions(-)
>  rename drivers/hwmon/pmbus/{Q54SJ108A2.c => delta.c} (83%)
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index b4bd6ac491c8..9057459bc31d 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -45,6 +45,15 @@ config SENSORS_BEL_PFE
>     This driver can also be built as a module. If so, the module will
>     be called bel-pfe.
> 
> +config SENSORS_DELTA
> + tristate "Delta Q54SJ108A2"
> + help
> +   If you say yes here you get hardware monitoring support for Delta modules
> +   Q54SJ108A2.
> +
> +   This driver can also be built as a module. If so, the module will
> +   be called delta.
> +
>  config SENSORS_IBM_CFFPS
>   tristate "IBM Common Form Factor Power Supply"
>   depends on LEDS_CLASS
> @@ -209,15 +218,6 @@ config SENSORS_PXE1610
>     This driver can also be built as a module. If so, the module will
>     be called pxe1610.
> 
> -config SENSORS_Q54SJ108A2
> - tristate "Delta Q54SJ108A2"
> - help
> -   If you say yes here you get hardware monitoring support for Delta modules
> -   Q54SJ108A2.
> -
> -   This driver can also be built as a module. If so, the module will
> -   be called Q54SJ108A2.
> -
>  config SENSORS_TPS40422
>   tristate "TI TPS40422"
>   help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 4536c57ef1a4..7da971e2143c 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -30,4 +30,4 @@ obj-$(CONFIG_SENSORS_UCD9000) += ucd9000.o
>  obj-$(CONFIG_SENSORS_UCD9200) += ucd9200.o
>  obj-$(CONFIG_SENSORS_XDPE122) += xdpe12284.o
>  obj-$(CONFIG_SENSORS_ZL6100) += zl6100.o
> -obj-$(CONFIG_SENSORS_Q54SJ108A2) += Q54SJ108A2.o
> +obj-$(CONFIG_SENSORS_DELTA) += delta.o
> diff --git a/drivers/hwmon/pmbus/Q54SJ108A2.c b/drivers/hwmon/pmbus/delta.c
> similarity index 83%
> rename from drivers/hwmon/pmbus/Q54SJ108A2.c
> rename to drivers/hwmon/pmbus/delta.c
> index 67fac5506763..ccef5704920f 100644
> --- a/drivers/hwmon/pmbus/Q54SJ108A2.c
> +++ b/drivers/hwmon/pmbus/delta.c
> @@ -40,13 +40,10 @@ enum chips {
>  static int delta_read_word_data(struct i2c_client *client, int page, int phase, int reg)
>  {
>   int ret = 0;
> - u16 temp;
> -
> - temp = pmbus_read_word_data(client, page, phase, reg);
> 
>   switch (reg) {
>   case PMBUS_STATUS_WORD:
> - ret = temp;
> + ret = pmbus_read_word_data(client, page, phase, reg);
>   break;
>   default:
>   ret = -ENODATA;
> @@ -56,30 +53,9 @@ static int delta_read_word_data(struct i2c_client *client, int page, int phase,
> 
>  }
> 
> -static int delta_write_word_data(struct i2c_client *client, int page, int reg, u16 word)
> -{
> - u8 value;
> -
> - switch (reg) {
> - case PMBUS_OPERATION:
> - case PMBUS_WRITE_PROTECT:
> - case PMBUS_VOUT_OV_FAULT_RESPONSE:
> - case PMBUS_IOUT_OC_FAULT_RESPONSE:
> - value = (u8)word;
> - return pmbus_write_byte_data(client, page, reg, value);
> -
> - default:
> - return -ENODATA;
> - }
> -
> -}
> -
>  static int delta_read_byte_data(struct i2c_client *client, int page, int reg)
>  {
>   int ret = 0;
> - u16 temp;
> -
> - temp = pmbus_read_byte_data(client, page, reg);
> 
>   switch (reg) {
>   case PMBUS_OPERATION:
> @@ -93,7 +69,7 @@ static int delta_read_byte_data(struct i2c_client *client, int page, int reg)
>   case PMBUS_STATUS_TEMPERATURE:
>   case PMBUS_STATUS_CML:
>   case PMBUS_REVISION:
> - ret = temp;
> + ret = pmbus_read_byte_data(client, page, reg);
>   break;
> 
>   default:
> @@ -104,20 +80,6 @@ static int delta_read_byte_data(struct i2c_client *client, int page, int reg)
> 
>  }
> 
> -static int delta_write_byte(struct i2c_client *client, int page, u8 value)
> -{
> - switch (value) {
> - case PMBUS_CLEAR_FAULTS:
> - ret = pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
> - break;
> -
> - default:
> - ret = -ENODATA;
> - break;
> - }
> - return ret;
> -}
> -
>  static const struct pmbus_driver_info delta_info[] = {
> 
>  [Q54SJ108A2] = {
> @@ -126,13 +88,8 @@ static const struct pmbus_driver_info delta_info[] = {
> 
>  .read_word_data = delta_read_word_data,
> 
> -.write_word_data = delta_write_word_data,
> -
>  .read_byte_data = delta_read_byte_data,
> 
> -.write_byte = delta_write_byte,
> -
> -
>  /* Source : Delta Q54SJ108A2 */
> 
>  .format[PSC_TEMPERATURE] = linear,
> @@ -160,13 +117,8 @@ PMBUS_HAVE_STATUS_INPUT,
> 
>  .read_word_data = delta_read_word_data,
> 
> -.write_word_data = delta_write_word_data,
> -
>  .read_byte_data = delta_read_byte_data,
> 
> -.write_byte = delta_write_byte,
> -
> -
>  /* Source : Delta Q50SN12050 */
> 
>  .format[PSC_TEMPERATURE] = linear,
> @@ -195,13 +147,8 @@ PMBUS_HAVE_STATUS_INPUT,
> 
>  .read_word_data = delta_read_word_data,
> 
> -.write_word_data = delta_write_word_data,
> -
>  .read_byte_data = delta_read_byte_data,
> 
> -.write_byte = delta_write_byte,
> -
> -
>  /* Source : Delta Q50SN12072 */
> 
>  .format[PSC_TEMPERATURE] = linear,
> --
> 2.20.1
> 
> *************************************************************************
> This email message, including any attachments, is for the sole
> use of the intended recipient(s) and may contain confidential and
> privileged information. Any unauthorized review, use, disclosure or
> distribution is prohibited. If you are not the intended recipient, please
> contact the sender by reply e-mail and destroy all copies of the original
> message. [Delta Electronics, INC. China]
> *************************************************************************
