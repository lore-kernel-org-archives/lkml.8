Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71FCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A3D20866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o840jZjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHGPof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 11:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGPoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 11:44:34 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BE3C061756;
        Fri,  7 Aug 2020 08:44:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id f9so1078817pju.4;
        Fri, 07 Aug 2020 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bpWPgHo+wbTkO4hzNmaoNqfR///zXD/EmTDn2T0lrOc=;
        b=o840jZjyS1XFtrHiIHIqHaPMREtWUpAUWR7cD6u9+qKEMzaVI+of3vlHf8VtZbwppk
         R8vpjFB5hgUv96ha9J4aoATF6Qszm2UQMPSYCbK9oFSRKc7OFnaFM83ZjsP8GgWFpqkQ
         KovRUe+h/QOcWG4/MP918sV0lvzT7FkQhxSdDCHLoMimBz161hy8pYLV4wFHukWaDrfD
         xh3KS/4w/kDCWAk5SdC0Hxrpu8C5XqMrcOHn8rwcDb3vgVaHBMC1qjOMWReN0vvqBwpj
         g0FRrTImlYGKFv9qK4UwsIlp+pkUJ+sQp1Kie8uHBkWlT5CVHYuRheJa3/t0zMRxwMt1
         NWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=bpWPgHo+wbTkO4hzNmaoNqfR///zXD/EmTDn2T0lrOc=;
        b=tReU/l8ofP7krc1irTWTkJAUaQHpX7w/6QPfGxzuudilbxfo5LMDq0KUDQeOLEqyGP
         ffPQ9DxbDqyTKxynnn+QeOV+OuCp7tJZCh1YY6NEs7ayK5xPKeK9M9PJmUnA9EXubuJV
         rqgrVuY14HlZDrGINnU+csNRy0c+pFiFXK3bnz86Sb0dVILq3pUq7OhFLDCc1N7dtGPp
         mXp+FsyqNWamiXd+1pDzxhjHHcsS3qRzfOhgqBDk5reWkEda7Zh45Q7VdIdLAINztJbJ
         I9vIIJT17DH51+lgWpn8HH+rUqL6koz/8GsqVD+w93fXcr5JLi0jNUJqGGtRbmxsjcUo
         M1jQ==
X-Gm-Message-State: AOAM533P1JtjbwflPuyGSROg3YqrpDovsqG7YG1n7tNqn24QogE6SF8G
        2HY2ZANnKspDOuijfeNLA4L2sNLr
X-Google-Smtp-Source: ABdhPJzdhEscBspVkYz3YA9Ld0dAxEqTQwfDht/1n9BSwpgwM/MUgWGfX57liX0X9ikOcmhB7ro35Q==
X-Received: by 2002:a17:902:a5cc:: with SMTP id t12mr12087666plq.96.1596815073843;
        Fri, 07 Aug 2020 08:44:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a13sm12814181pfo.49.2020.08.07.08.44.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Aug 2020 08:44:33 -0700 (PDT)
Date:   Fri, 7 Aug 2020 08:44:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v7 8/9] hwmon: pmbus: adm1266: program configuration
Message-ID: <20200807154432.GA39539@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 07:19:27PM +0300, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Writing the configuration Intel hex file to the nvmem,
> of an adm1266, with offset 0x30000, will now
> trigger the configuration programming.
> 
> During this process the adm1266 sequencer will be
> stopped and at the end will be issued a seq reset
> (see AN-1453 Programming the configuration).
> 
Same as writing the firmware: This should be done from userspace,
using i2c-dev, in a controlled environment (eg manufacturing).
It can easily brick the hardware, and should not be done in the driver.

Thanks,
Guenter

> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  drivers/hwmon/pmbus/adm1266.c | 179 +++++++++++++++++++++++++++++++++-
>  1 file changed, 178 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
> index f851c6617870..50386c98d714 100644
> --- a/drivers/hwmon/pmbus/adm1266.c
> +++ b/drivers/hwmon/pmbus/adm1266.c
> @@ -40,7 +40,10 @@
>  #define ADM1266_BLACKBOX_INFO	0xE6
>  #define ADM1266_PDIO_STATUS	0xE9
>  #define ADM1266_GPIO_STATUS	0xEA
> +#define ADM1266_STATUS_MFR_2	0xED
> +#define ADM1266_REFRESH_FLASH	0xF5
>  #define ADM1266_MEMORY_CONFIG	0xF8
> +#define ADM1266_MEMORY_CRC	0xF9
>  #define ADM1266_SWITCH_MEMORY	0xFA
>  #define ADM1266_UPDATE_FW	0xFC
>  #define ADM1266_FW_PASSWORD	0xFD
> @@ -66,6 +69,11 @@
>  
>  /* ADM1266 STATUS_MFR defines */
>  #define ADM1266_STATUS_PART_LOCKED(x)	FIELD_GET(BIT(2), x)
> +#define ADM1266_RUNNING_REFRESH(x)	FIELD_GET(BIT(3), x)
> +#define ADM1266_ALL_CRC_FAULT(x)	FIELD_GET(BIT(5), x)
> +
> +/* ADM1266 STATUS_MFR_2 defines */
> +#define ADM1266_MAIN_CONFIG_FAULT(x)	FIELD_GET(GENMASK(9, 8), x)
>  
>  /* ADM1266 GO_COMMAND defines */
>  #define ADM1266_GO_COMMAND_STOP		BIT(0)
> @@ -74,6 +82,8 @@
>  
>  #define ADM1266_FIRMWARE_OFFSET		0x00000
>  #define ADM1266_FIRMWARE_SIZE		131072
> +#define ADM1266_CONFIG_OFFSET		0x30000
> +#define ADM1266_CONFIG_SIZE		131072
>  #define ADM1266_BLACKBOX_OFFSET		0x7F700
>  #define ADM1266_BLACKBOX_SIZE		64
>  
> @@ -117,6 +127,11 @@ static const struct nvmem_cell_info adm1266_nvmem_cells[] = {
>  		.offset         = ADM1266_FIRMWARE_OFFSET,
>  		.bytes          = ADM1266_FIRMWARE_SIZE,
>  	},
> +	{
> +		.name           = "configuration",
> +		.offset         = ADM1266_CONFIG_OFFSET,
> +		.bytes          = ADM1266_CONFIG_SIZE,
> +	},
>  };
>  
>  DECLARE_CRC8_TABLE(pmbus_crc_table);
> @@ -520,6 +535,9 @@ static int adm1266_read_mem_cell(struct adm1266_data *data, const struct nvmem_c
>  	case ADM1266_FIRMWARE_OFFSET:
>  		/* firmware is write-only */
>  		return 0;
> +	case ADM1266_CONFIG_OFFSET:
> +		/* configuration is write-only */
> +		return 0;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -676,6 +694,7 @@ static int adm1266_write_hex(struct adm1266_data *data,
>  	u8 first_writes[7];
>  	u8 byte_count;
>  	u8 reg_address;
> +	bool to_slaves = false;
>  	int ret;
>  	int i;
>  
> @@ -706,7 +725,10 @@ static int adm1266_write_hex(struct adm1266_data *data,
>  		if (ret < 0)
>  			return ret;
>  
> -		ret = adm1266_group_cmd(data, reg_address, write_buf, byte_count, true);
> +		if (offset == ADM1266_FIRMWARE_OFFSET)
> +			to_slaves = true;
> +
> +		ret = adm1266_group_cmd(data, reg_address, write_buf, byte_count, to_slaves);
>  		if (ret < 0) {
>  			dev_err(&data->client->dev, "Firmware write error: %d.", ret);
>  			return ret;
> @@ -731,6 +753,87 @@ static int adm1266_write_hex(struct adm1266_data *data,
>  	return 0;
>  }
>  
> +static int adm1266_verify_memory(struct adm1266_data *data)
> +{
> +	char cmd[2];
> +	int ret;
> +	int reg;
> +
> +	cmd[0] = 0x1;
> +	cmd[1] = 0x0;
> +	ret = adm1266_group_cmd(data, ADM1266_MEMORY_CRC, cmd,
> +				sizeof(cmd), true);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* after issuing a memory recalculate crc command, wait 1000 ms */
> +	msleep(1000);
> +
> +	reg = pmbus_read_word_data(data->client, 0, 0xFF, ADM1266_STATUS_MFR_2);
> +	if (reg < 0)
> +		return reg;
> +
> +	if (ADM1266_MAIN_CONFIG_FAULT(reg)) {
> +		dev_err(&data->client->dev, "Main memory corrupted.");
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int adm1266_refresh_memory(struct adm1266_data *data)
> +{
> +	unsigned int timeout = 9000;
> +	int ret;
> +	u8 cmd[2];
> +
> +	cmd[0] = 0x2;
> +	ret = adm1266_group_cmd(data, ADM1266_REFRESH_FLASH, cmd, 1, true);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Could not refresh flash.");
> +		return ret;
> +	}
> +
> +	/* after issuing a refresh flash command, wait 9000 ms */
> +	msleep(9000);
> +
> +	do {
> +		msleep(1000);
> +		timeout -= 1000;
> +
> +		ret = pmbus_read_byte_data(data->client, 0, ADM1266_STATUS_MFR);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "Could not read status.");
> +			return ret;
> +		}
> +
> +	} while (ADM1266_RUNNING_REFRESH(ret) && timeout > 0);
> +
> +	if (timeout == 0)
> +		return -ETIMEDOUT;
> +
> +	cmd[0] = 0x1;
> +	cmd[1] = 0x0;
> +	ret = adm1266_group_cmd(data, ADM1266_MEMORY_CRC, cmd,
> +				sizeof(cmd), true);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* after issuing a memory recalculate crc command, wait 1000 ms */
> +	msleep(1000);
> +
> +	ret = pmbus_read_byte_data(data->client, 0, ADM1266_STATUS_MFR);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ADM1266_ALL_CRC_FAULT(ret)) {
> +		dev_err(&data->client->dev, "CRC checks failed.");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int adm1266_program_firmware(struct adm1266_data *data)
>  {
>  	u8 write_data[3];
> @@ -783,6 +886,77 @@ static int adm1266_program_firmware(struct adm1266_data *data)
>  	return ret;
>  }
>  
> +static int adm1266_program_config(struct adm1266_data *data)
> +{
> +	u8 cmd[2];
> +	u8 value;
> +	int ret;
> +
> +	value = ADM1266_GO_COMMAND_STOP | ADM1266_GO_COMMAND_SEQ_RES;
> +	ret = pmbus_write_word_data(data->client, 0, ADM1266_GO_COMMAND, value);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Could not stop sequence.");
> +		return ret;
> +	}
> +
> +	/* after issuing a stop command, wait 100 ms */
> +	msleep(100);
> +
> +	ret = adm1266_unlock_all_dev(data);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Could not unlock dev.");
> +		goto lock_all_devices;
> +	}
> +
> +	value = 0;
> +	ret = i2c_smbus_write_block_data(data->client, ADM1266_SWITCH_MEMORY, 1, &value);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Could not switch to main mem.");
> +		goto lock_all_devices;
> +	}
> +
> +	/* after issuing a SWITCH_MEMORY command, wait 1000 ms */
> +	msleep(1000);
> +
> +	ret = adm1266_write_hex(data, ADM1266_CONFIG_OFFSET, ADM1266_CONFIG_SIZE);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Could not write configuration.");
> +		goto lock_all_devices;
> +	}
> +
> +	ret = pmbus_write_byte(data->client, 0, ADM1266_STORE_USER_ALL);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* after issuing a STORE_USER_ALL command, wait 300 ms */
> +	msleep(300);
> +
> +	if (!data->master_dev)
> +		goto lock_all_devices;
> +
> +	ret = adm1266_verify_memory(data);
> +	if (ret < 0)
> +		goto lock_all_devices;
> +
> +	cmd[0] = 0;
> +	cmd[1] = 0;
> +	ret = adm1266_group_cmd(data, ADM1266_GO_COMMAND, cmd, sizeof(cmd), true);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Could not restart sequence.");
> +		goto lock_all_devices;
> +	}
> +
> +	/* after issuing a restart sequence command, wait 350 ms */
> +	msleep(350);
> +
> +	ret = adm1266_refresh_memory(data);
> +
> +lock_all_devices:
> +	adm1266_lock_all_dev(data);
> +
> +	return ret;
> +}
> +
>  /* check if firmware/config write has ended */
>  static bool adm1266_check_ending(struct adm1266_data *data, unsigned int offset,
>  				 unsigned int size)
> @@ -824,6 +998,9 @@ static int adm1266_write_mem_cell(struct adm1266_data *data,
>  
>  		program_func = &adm1266_program_firmware;
>  		break;
> +	case ADM1266_CONFIG_OFFSET:
> +		program_func = &adm1266_program_config;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
