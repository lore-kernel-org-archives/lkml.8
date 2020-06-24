Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E528C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F55B2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeh0OUFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403856AbgFXV2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403837AbgFXV2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:28:21 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C981CC061573;
        Wed, 24 Jun 2020 14:28:20 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u5so1825868pfn.7;
        Wed, 24 Jun 2020 14:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZQxYRtrdi9vMsm5/HU8dIzNpM/BIdYP813BZZqvCjg0=;
        b=eeh0OUFGL1szB4i5Su7T59EnhhWG8V4dnvFfAmXwesd39jBEk1e5aJgu6jLpCvibqR
         lrDvI83l3+BoneNtxiWzBbWW/w7nIJfZ91hBWtMKoVGK2SIMc7vzfDKERDp1O72Zqpb1
         SAznuYITDSjcYHM9yVCk7+6GU+dqic8dbw/5h2/aSIPpN/yPyMuw3jlQHAURBHi9pe0U
         A9blCDohZsgC95jEKcdmPGBn7Y+R7qN8cQts/CyrgGNWTTMLftGZhJywH9r5+md6xEk4
         qLW5bsR1zhwq04slrMF72XhuDYcVUDd7ldUAUX7bdbO/hJZLe16c4tli0YrDTxxWAG68
         xUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZQxYRtrdi9vMsm5/HU8dIzNpM/BIdYP813BZZqvCjg0=;
        b=Ws+Y+Ov+vaZuduSd6F8X9NM4DBat4rMcedp1/SU2UqPZ1ZxTtMBExHaNpEJuLLER9v
         RDtVkdNDpakdJTMwoAstA7BSTeTC0JWbvahQCs7JqB7gr6974oPZCj9ivGEqq6tgDMuq
         5RGU9cxD/NdvGd5eXqWK1q8FbTAfXVFqfXpa9Gnd2HQB4mE9BFcux5sKSihc2dMRgKQf
         QVGJgONbYEqFhOYl4Ceacnuq1hsQXhmLy6pnEuxGMLSIb1cDEthlFOoOmnxQl0vWZ9oy
         CseIiB5TnbZbHkFo4FRk95UAErw87wnUirMftaRpNcUUcdrTyoCI3CZkiqGue/miFdwZ
         CdSg==
X-Gm-Message-State: AOAM532xch8Mp++ES4nlmgMfSjSG+qvk2PsJb5SOl6Fq41/PFKlqayJZ
        l4XaCpfbD1XrnskdbZsK7kA=
X-Google-Smtp-Source: ABdhPJwOtNYzpuiQLvOOi783XQ5IsW5kFW5cCx0iaESxphTAfmmd9rqiD8gUnZXdENB+Ac1a24XG9Q==
X-Received: by 2002:aa7:8d07:: with SMTP id j7mr978970pfe.125.1593034100358;
        Wed, 24 Jun 2020 14:28:20 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j16sm217410pfr.100.2020.06.24.14.28.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jun 2020 14:28:19 -0700 (PDT)
Date:   Wed, 24 Jun 2020 14:28:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v4 2/7] hwmon: pmbus: adm1266: Add Block process call
Message-ID: <20200624212818.GA74031@roeck-us.net>
References: <20200623173659.41358-1-alexandru.tachici@analog.com>
 <20200623173659.41358-3-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623173659.41358-3-alexandru.tachici@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 08:36:54PM +0300, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> PmBus devices support Block Write-Block Read Process
> Call described in SMBus specification v 2.0 with the
> exception that Block writes and reads are permitted to
> have up 255 data bytes instead of max 32 bytes (SMBus).
> 
> This patch adds Block WR process call support for ADM1266.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  drivers/hwmon/pmbus/Kconfig   |  1 +
>  drivers/hwmon/pmbus/adm1266.c | 79 +++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index 6949483aa732..dc6971a7c49e 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -28,6 +28,7 @@ config SENSORS_PMBUS
>  
>  config SENSORS_ADM1266
>  	tristate "Analog Devices ADM1266 Sequencer"
> +	select CRC8
>  	help
>  	  If you say yes here you get hardware monitoring support for Analog
>  	  Devices ADM1266 Cascadable Super Sequencer.
> diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
> index a7ef048a9a5c..381d89a8569f 100644
> --- a/drivers/hwmon/pmbus/adm1266.c
> +++ b/drivers/hwmon/pmbus/adm1266.c
> @@ -6,6 +6,7 @@
>   * Copyright 2020 Analog Devices Inc.
>   */
>  
> +#include <linux/crc8.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -14,6 +15,82 @@
>  
>  #include "pmbus.h"
>  
> +#define ADM1266_PMBUS_BLOCK_MAX		255
> +
> +DECLARE_CRC8_TABLE(pmbus_crc_table);
> +
> +/* Different from Block Read as it sends data and waits for the slave to

   /*
    * Proper multi-line comment
    */

> + * return a value dependent on that data. The protocol is simply a Write Block
> + * followed by a Read Block without the Read-Block command field and the
> + * Write-Block STOP bit.
> + */

static

> +int pmbus_block_xfer(struct i2c_client *client, u8 cmd, u8 w_len,
> +		     u8 *data_w, u8 *data_r)
> +{
> +	u8 write_buf[ADM1266_PMBUS_BLOCK_MAX + 2];
> +	struct i2c_msg msgs[2] = {
> +		{
> +			.addr = client->addr,
> +			.flags = 0,
> +			.buf = write_buf,
> +			.len = w_len + 2,
> +		},
> +		{
> +			.addr = client->addr,
> +			.flags = I2C_M_RD,
> +			.len = ADM1266_PMBUS_BLOCK_MAX + 2,
> +		}
> +	};
> +	u8 addr = 0;
> +	u8 crc = 0;

Unnecessary initialization for both variables

> +	int ret;
> +
> +	msgs[0].buf[0] = cmd;
> +	msgs[0].buf[1] = w_len;
> +	memcpy(&msgs[0].buf[2], data_w, w_len);
> +
> +	msgs[0].buf = i2c_get_dma_safe_msg_buf(&msgs[0], 1);
> +	if (!msgs[0].buf)
> +		return -ENOMEM;
> +
> +	msgs[1].buf = i2c_get_dma_safe_msg_buf(&msgs[1], 1);
> +	if (!msgs[1].buf) {
> +		i2c_put_dma_safe_msg_buf(msgs[0].buf, &msgs[0], false);
> +		return -ENOMEM;
> +	}

AFAICS i2c_get_dma_safe_msg_buf() is supposed to be used by i2c bus drivers,
not by device drivers. If this is needed for the target architecture,
it should be implemented in the bus driver, not here.

> +
> +	ret = i2c_transfer(client->adapter, msgs, 2);
> +	if (ret != 2) {
> +		ret = -EPROTO;

Should retain error if ret < 0, and only return EPROTO if the return value
is 0 or 1.

> +		goto cleanup;
> +	}
> +
> +	if (client->flags & I2C_CLIENT_PEC) {
> +		addr = i2c_8bit_addr_from_msg(&msgs[0]);
> +		crc = crc8(pmbus_crc_table, &addr, 1, crc);
> +		crc = crc8(pmbus_crc_table, msgs[0].buf,  msgs[0].len, crc);
> +
> +		addr = i2c_8bit_addr_from_msg(&msgs[1]);
> +		crc = crc8(pmbus_crc_table, &addr, 1, crc);
> +		crc = crc8(pmbus_crc_table, msgs[1].buf,  msgs[1].buf[0] + 1,
> +			   crc);
> +
> +		if (crc != msgs[1].buf[msgs[1].buf[0] + 1]) {
> +			ret = -EBADMSG;
> +			goto cleanup;
> +		}
> +	}
> +
> +	memcpy(data_r, &msgs[1].buf[1], msgs[1].buf[0]);
> +	ret = msgs[1].buf[0];
> +
> +cleanup:
> +	i2c_put_dma_safe_msg_buf(msgs[0].buf, &msgs[0], true);
> +	i2c_put_dma_safe_msg_buf(msgs[1].buf, &msgs[1], true);
> +
> +	return ret;
> +}
    > +
>  static int adm1266_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -24,6 +101,8 @@ static int adm1266_probe(struct i2c_client *client,
>  	info = devm_kzalloc(&client->dev, sizeof(struct pmbus_driver_info),
>  			    GFP_KERNEL);
>  
> +	crc8_populate_msb(pmbus_crc_table, 0x7);
> +
>  	info->pages = 17;
>  	info->format[PSC_VOLTAGE_OUT] = linear;
>  	funcs = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
