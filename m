Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91669C55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6971C2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czFjsroh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDUS6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbgDUS6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:58:53 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F0BC0610D5;
        Tue, 21 Apr 2020 11:58:53 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k18so5604766pll.6;
        Tue, 21 Apr 2020 11:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hh7n7KOJXkXyQG53rPy4bGmJAuphglg6FVDhiHbxqqs=;
        b=czFjsroh0ep+dQRYPc/av7aYhh2dTOX0qAHWebyxO1HYsuk+izD8EwqcOHXaxkldnE
         Do4SmbP6vlA+/RkVsQawgTr7wpZVlbDRU/9b78ozu0obW5EvBshAKxWYZ9s6Xn/0+TOg
         lyy1FUX8CgMBoDQSUFDbHxlL3oLjiV/JVmKP3PJIFUEaBX4k6CxLpFXa97DqgoRC5w1F
         KLlAq358UwMKYtQ8gwlML7i3U4ysPBjAMUQDSW0bTbiszd4IHRd+52nNJGY349g3Kwmu
         Wn6y9cfeoHWS73zMwoDlbwwVu7i14aeZlSrnOd7O7gdP8nwBnw7IJOHsV/084XpzXnQR
         DE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hh7n7KOJXkXyQG53rPy4bGmJAuphglg6FVDhiHbxqqs=;
        b=jBPjrbWill+EQ9eOa1UH+9uhaKV7Vd54/hSer/miXxrHwsSL6IYwN7hPThRGMUm5hx
         MPutWgYRPK/l65iVUhdwxPY04T6Am06/69myqPtg84I3NwoEmNqQ/zGn32PJBcfRjKIy
         MGV1jXrY/v8jDpIt+0gLrhIlth53yDcOylVlNn4GzDew/x0259ETrc0jP8jfPe+GGmBN
         K4QgJo7p6xoLFX4Jgu7zOB0KA29GpsSepr0TBAkheLiaARbxnWOeeV7vgkYKmVltZOi8
         qZc7ns+bB9qsPsi0XmZ6gnIt0E87O65qKTWzT/DezuJor+LuFx1NzVG98U55oUSSj39l
         gI4A==
X-Gm-Message-State: AGi0PuZzkvV9cabEv6ghzY9K4yPpgyVOYJl9PKKHufKUhUmGF/i12Tor
        uaypSb0wkWWUq+sUBwBY+voRxqR9
X-Google-Smtp-Source: APiQypIaaKCmamkm0/O/wkHPjmcIHeOIAEGKO+968TCMyPa9R9AT3vAN5YXCDvmFGmQHU7gbdIFteQ==
X-Received: by 2002:a17:90a:37c4:: with SMTP id v62mr4493867pjb.177.1587495533040;
        Tue, 21 Apr 2020 11:58:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a17sm3067114pfr.24.2020.04.21.11.58.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Apr 2020 11:58:52 -0700 (PDT)
Date:   Tue, 21 Apr 2020 11:58:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Grant Peltier <grantpeltier93@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        adam.vaughn.xh@renesas.com, grant.peltier.jg@renesas.com
Subject: Re: [PATCH 1/2] hwmon: (pmbus/isl68137) add debugfs config and black
 box endpoints
Message-ID: <20200421185851.GA95204@roeck-us.net>
References: <cover.1587408025.git.grantpeltier93@gmail.com>
 <203a7cd37dd95a0127cc06de14986721ab621e93.1587408025.git.grantpeltier93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <203a7cd37dd95a0127cc06de14986721ab621e93.1587408025.git.grantpeltier93@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 02:03:36PM -0500, Grant Peltier wrote:
> Add debugfs endpoints to support features of 2nd generation Renesas
> digital multiphase voltage regulators that are not compatible with
> sysfs.
> 
> The read_black_box endpoint allows users to read the contents of a
> RAM segment used to record fault conditions within Gen 2 devices.
> 
> The write_config endpoint allows users to write configuration hex
> files to Gen 2 devices which modify how they operate.
> 
> Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>
> ---
>  drivers/hwmon/pmbus/isl68137.c | 490 ++++++++++++++++++++++++++++++++-
>  1 file changed, 487 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
> index 0c622711ef7e..24af016729a3 100644
> --- a/drivers/hwmon/pmbus/isl68137.c
> +++ b/drivers/hwmon/pmbus/isl68137.c
> @@ -7,10 +7,12 @@
>   *
>   */
>  
> +#include <linux/debugfs.h>
>  #include <linux/err.h>
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> +#include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/string.h>
> @@ -18,8 +20,22 @@
>  
>  #include "pmbus.h"
>  
> -#define ISL68137_VOUT_AVS	0x30
> -#define RAA_DMPVR2_READ_VMON	0xc8
> +#define ISL68137_VOUT_AVS		0x30
> +#define RAA_DMPVR2_DMA_FIX		0xc5
> +#define RAA_DMPVR2_DMA_SEQ		0xc6
> +#define RAA_DMPVR2_DMA_ADDR		0xc7
> +#define RAA_DMPVR2_READ_VMON		0xc8
> +#define RAA_DMPVR2_BB_BASE_ADDR		0xef80
> +#define RAA_DMPVR2_BB_WSIZE		4
> +#define RAA_DMPVR2_BB_WCNT		32
> +#define RAA_DMPVR2_BB_BUF_SIZE		288
> +#define RAA_DMPVR2_NVM_CNT_ADDR		0x00c2
> +#define RAA_DMPVR2_PRGM_STATUS_ADDR	0x0707
> +#define RAA_DMPVR2_BANK0_STATUS_ADDR	0x0709
> +#define RAA_DMPVR2_BANK1_STATUS_ADDR	0x070a
> +#define RAA_DMPVR2_CFG_MAX_SLOT		16
> +#define RAA_DMPVR2_CFG_HEAD_LEN		290
> +#define RAA_DMPVR2_CFG_SLOT_LEN		358
>  
>  enum chips {
>  	isl68137,
> @@ -71,6 +87,21 @@ enum variants {
>  	raa_dmpvr2_hv,
>  };
>  
> +enum {
> +	RAA_DMPVR2_DEBUGFS_CFG_W = 0,
> +	RAA_DMPVR2_DEBUGFS_BB_R,
> +	RAA_DMPVR2_DEBUGFS_NUM_ENTRIES,
> +};
> +
> +struct raa_dmpvr2_ctrl {
> +	enum chips part;
> +	struct i2c_client *client;
> +	int debugfs_entries[RAA_DMPVR2_DEBUGFS_NUM_ENTRIES];
> +};
> +
> +#define to_ctrl(x, y) container_of((x), struct raa_dmpvr2_ctrl, \
> +				   debugfs_entries[(y)])
> +
>  static ssize_t isl68137_avs_enable_show_page(struct i2c_client *client,
>  					     int page,
>  					     char *buf)
> @@ -157,6 +188,425 @@ static const struct attribute_group *isl68137_attribute_groups[] = {
>  	NULL,
>  };
>  
> +/**
> + * Non-standard SMBus read function to account for I2C controllers that
> + * do not support SMBus block reads. Reads 5 bytes from client (length + 4 data
> + * bytes)
> + */

Normally this is emulated for such controllers. I don't recall seeing
such a need before. The code below duplicates similar code in
i2c_smbus_xfer_emulated(), which is much more sophisticated.
Are you sure this is needed ? Can you point me to an affected
controller ?

> +static s32 raa_smbus_read40(const struct i2c_client *client, u8 command,
> +			    unsigned char *data)
> +{
> +	int status;
> +	unsigned char msgbuf[1];
> +	struct i2c_msg msg[2] = {
> +		{
> +			.addr = client->addr,
> +			.flags = client->flags,
> +			.len = 1,
> +			.buf = msgbuf,
> +		},
> +		{
> +			.addr = client->addr,
> +			.flags = client->flags | I2C_M_RD,
> +			.len = 5,
> +			.buf = data,
> +		},
> +	};
> +
> +	msgbuf[0] = command;
> +	status = i2c_transfer(client->adapter, msg, 2);
> +	if (status != 2)
> +		return status;

i2c_transfer() can return 1 if only one of the two messages was sent.

> +	return 0;
> +}
> +
> +/**
> + * Helper function required since linux SMBus implementation does not currently
> + * (v5.6) support the SMBus 3.0 "Read 32" protocol
> + */
> +static s32 raa_dmpvr2_smbus_read32(const struct i2c_client *client, u8 command,
> +				   unsigned char *data)
> +{
> +	int status;
> +	unsigned char msgbuf[1];
> +	struct i2c_msg msg[2] = {
> +		{
> +			.addr = client->addr,
> +			.flags = client->flags,
> +			.len = 1,
> +			.buf = msgbuf,
> +		},
> +		{
> +			.addr = client->addr,
> +			.flags = client->flags | I2C_M_RD,
> +			.len = 4,
> +			.buf = data,
> +		},
> +	};
> +
> +	msgbuf[0] = command;
> +	status = i2c_transfer(client->adapter, msg, 2);
> +	if (status != 2)
> +		return status;
> +	return 0;
> +}

Maybe it would be worthwhile to consider implementing it ?

> +
> +/**
> + * Helper function required since linux SMBus implementation does not currently
> + * (v5.6) support the SMBus 3.0 "Write 32" protocol
> + */
> +static s32 raa_dmpvr2_smbus_write32(const struct i2c_client *client,
> +				    u8 command, u32 value)
> +{
> +	int status;
> +	unsigned char msgbuf[5];
> +	struct i2c_msg msg[1] = {
> +		{
> +			.addr = client->addr,
> +			.flags = client->flags,
> +			.len = 5,
> +			.buf = msgbuf,
> +		},
> +	};
> +	msgbuf[0] = command;
> +	msgbuf[1] = value & 0x0FF;
> +	msgbuf[2] = (value >> 8) & 0x0FF;
> +	msgbuf[3] = (value >> 16) & 0x0FF;
> +	msgbuf[4] = (value >> 24) &  0x0FF;
> +	status = i2c_transfer(client->adapter, msg, 1);
> +	if (status != 1)
> +		return status;
> +	return 0;
> +}
> +
> +static ssize_t raa_dmpvr2_read_black_box(struct raa_dmpvr2_ctrl *ctrl,
> +					 char __user *buf, size_t len,
> +					 loff_t *ppos)
> +{
> +	int i, j;
> +	u16 addr = RAA_DMPVR2_BB_BASE_ADDR;
> +	unsigned char data[RAA_DMPVR2_BB_WSIZE] = { 0 };
> +	char out[RAA_DMPVR2_BB_BUF_SIZE] = { 0 };
> +	char *optr = out;
> +
> +	i2c_smbus_write_word_data(ctrl->client, RAA_DMPVR2_DMA_ADDR, addr);
> +	for (i = 0; i < RAA_DMPVR2_BB_WCNT; i++) {
> +		raa_dmpvr2_smbus_read32(ctrl->client, RAA_DMPVR2_DMA_SEQ,
> +					data);
> +		for (j = 0; j < RAA_DMPVR2_BB_WSIZE; j++)
> +			optr += snprintf(optr, sizeof(out), "%02X", data[j]);
> +		*optr = '\n';
> +		optr++;
> +	}
> +
> +	return simple_read_from_buffer(buf, len, ppos, &out, sizeof(out));
> +}
> +
> +struct raa_dmpvr_cfg_cmd {
> +	u8 cmd;
> +	u8 len;
> +	u8 data[4];
> +};
> +
> +struct raa_dmpvr2_cfg {
> +	u8 dev_id[4];
> +	u8 dev_rev[4];
> +	int slot_cnt;
> +	int cmd_cnt;
> +	struct raa_dmpvr_cfg_cmd *cmds;
> +	u8 crc[4];
> +};
> +
> +/**
> + * Helper function to handle hex string to byte conversions
> + */
> +static int raa_dmpvr2_hextou8(char *buf, u8 *res)
> +{
> +	char s[3];
> +
> +	s[0] = buf[0];
> +	s[1] = buf[1];
> +	s[2] = '\0';
> +	return kstrtou8(s, 16, res);
> +}
> +
> +static int raa_dmpvr2_parse_cfg(char *buf, struct raa_dmpvr2_cfg *cfg)
> +{
> +	const int lsta = 2;
> +	const int csta = 6;
> +	const int dsta = 8;
> +	char *cptr, *line;
> +	int lcnt = 1;
> +	int ccnt = 0;
> +	int i, j, ret;
> +	u8 b;
> +
> +	// Ensure there is enough memory for the file
> +	for (i = 0; i < strlen(buf); i++) {
> +		if (buf[i] == '\n' && i < strlen(buf)-2) {
> +			lcnt++;
> +			if (buf[i+1] != '4' || buf[i+2] != '9')
> +				ccnt++;
> +		}
> +	}
> +	cfg->slot_cnt = (lcnt-RAA_DMPVR2_CFG_HEAD_LEN)/RAA_DMPVR2_CFG_SLOT_LEN;
> +	if (cfg->slot_cnt < 1 || cfg->slot_cnt > RAA_DMPVR2_CFG_MAX_SLOT)
> +		return -EINVAL;
> +	cfg->cmd_cnt = ccnt;
> +	cfg->cmds = kmalloc_array(ccnt, sizeof(struct raa_dmpvr_cfg_cmd),
> +				  GFP_KERNEL);
> +	if (!cfg->cmds)
> +		return -ENOMEM;
> +
> +	// Parse header
> +	for (i = 0; i < 2; i++) {
> +		line = strsep(&buf, "\n");
> +		cptr = line + dsta;
> +		for (j = 3; j >= 0; j--) {
> +			ret = raa_dmpvr2_hextou8(cptr, &b);
> +			if (ret)
> +				goto parse_err;
> +			if (i == 0)
> +				cfg->dev_id[j] = b;
> +			else
> +				cfg->dev_rev[j] = b;
> +			cptr += 2;
> +		}
> +	}
> +
> +	// Parse cmds
> +	i = 0;
> +	while (line != NULL && strlen(line) > (dsta + 2)) {
> +		if (strncmp(line, "49", 2) != 0) {
> +			ret = raa_dmpvr2_hextou8(line+lsta, &b);
> +			if (ret)
> +				goto parse_err;
> +			cfg->cmds[i].len = b - 3;
> +			ret = raa_dmpvr2_hextou8(line+csta, &b);
> +			if (ret)
> +				goto parse_err;
> +			cfg->cmds[i].cmd = b;
> +			for (j = 0; j < cfg->cmds[i].len; j++) {
> +				cptr = line + dsta + (2 * j);
> +				ret = raa_dmpvr2_hextou8(cptr, &b);
> +				if (ret)
> +					goto parse_err;
> +				cfg->cmds[i].data[j] = b;
> +			}
> +			i++;
> +		}
> +		line = strsep(&buf, "\n");
> +	}
> +	return 0;
> +
> +parse_err:
> +	kfree(cfg->cmds);
> +	return ret;
> +}
> +
> +static int raa_dmpvr2_verify_device(struct raa_dmpvr2_ctrl *ctrl,
> +				    struct raa_dmpvr2_cfg *cfg)
> +{
> +	u8 dev_id[5];
> +	u8 dev_rev[5];
> +	int status;
> +
> +	status = raa_smbus_read40(ctrl->client, PMBUS_IC_DEVICE_ID, dev_id);
> +	if (status)
> +		return status;
> +
> +	status = raa_smbus_read40(ctrl->client, PMBUS_IC_DEVICE_REV, dev_rev);
> +	if (status)
> +		return status;
> +
> +	return memcmp(cfg->dev_id, dev_id+1, 4)
> +		| memcmp(cfg->dev_rev+3, dev_rev+4, 1);
> +}
> +
> +static int raa_dmpvr2_check_cfg(struct raa_dmpvr2_ctrl *ctrl,
> +				struct raa_dmpvr2_cfg *cfg)
> +{
> +	u8 data[4];
> +
> +	i2c_smbus_write_word_data(ctrl->client, RAA_DMPVR2_DMA_ADDR,
> +				  RAA_DMPVR2_NVM_CNT_ADDR);
> +	raa_dmpvr2_smbus_read32(ctrl->client, RAA_DMPVR2_DMA_SEQ, data);
> +	if (cfg->slot_cnt > data[0])
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static int raa_dmpvr2_send_cfg(struct raa_dmpvr2_ctrl *ctrl,
> +			       struct raa_dmpvr2_cfg *cfg)
> +{
> +	int i, status;
> +	u16 word;
> +	u32 dbl_word;
> +
> +	for (i = 0; i < cfg->cmd_cnt; i++) {
> +		if (cfg->cmds[i].len == 2) {
> +			word = cfg->cmds[i].data[0]
> +				| (cfg->cmds[i].data[1] << 8);
> +			status = i2c_smbus_write_word_data(ctrl->client,
> +							   cfg->cmds[i].cmd,
> +							   word);
> +			if (status < 0)
> +				return status;
> +		} else if (cfg->cmds[i].len == 4) {
> +			dbl_word = cfg->cmds[i].data[0]
> +				| (cfg->cmds[i].data[1] << 8)
> +				| (cfg->cmds[i].data[2] << 16)
> +				| (cfg->cmds[i].data[3] << 24);
> +			status = raa_dmpvr2_smbus_write32(ctrl->client,
> +							  cfg->cmds[i].cmd,
> +							  dbl_word);
> +			if (status < 0)
> +				return status;
> +		} else {
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int raa_dmpvr2_cfg_write_result(struct raa_dmpvr2_ctrl *ctrl,
> +				       struct raa_dmpvr2_cfg *cfg)
> +{
> +	u8 data[4] = {0};
> +	u8 data1[4];
> +	u8 *dptr;
> +	unsigned long start;
> +	int i, j, status;
> +
> +	// Check programmer status
> +	start = jiffies;
> +	i2c_smbus_write_word_data(ctrl->client, RAA_DMPVR2_DMA_ADDR,
> +				  RAA_DMPVR2_PRGM_STATUS_ADDR);
> +	while (data[0] == 0 && !time_after(jiffies, start + HZ + HZ)) {
> +		raa_dmpvr2_smbus_read32(ctrl->client, RAA_DMPVR2_DMA_FIX,
> +					data);
> +	}
> +	if (data[0] != 1)
> +		return -ETIME;
> +
> +	// Check bank statuses
> +	i2c_smbus_write_word_data(ctrl->client, RAA_DMPVR2_DMA_ADDR,
> +				  RAA_DMPVR2_BANK0_STATUS_ADDR);
> +	raa_dmpvr2_smbus_read32(ctrl->client, RAA_DMPVR2_DMA_FIX, data);
> +	i2c_smbus_write_word_data(ctrl->client, RAA_DMPVR2_DMA_ADDR,
> +				  RAA_DMPVR2_BANK1_STATUS_ADDR);
> +	raa_dmpvr2_smbus_read32(ctrl->client, RAA_DMPVR2_DMA_FIX, data1);
> +
> +	for (i = 0; i < cfg->slot_cnt; i++) {
> +		if (i < 8) {
> +			j = i;
> +			dptr = data;
> +		} else {
> +			j = i - 8;
> +			dptr = data1;
> +		}
> +		status = (dptr[j/2] >> (4 * (j % 2))) & 0x0F;
> +		if (status != 1)
> +			return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t raa_dmpvr2_write_cfg(struct raa_dmpvr2_ctrl *ctrl,
> +				    const char __user *buf, size_t len,
> +				    loff_t *ppos)
> +{
> +	char *cbuf;
> +	int ret, status;
> +	struct raa_dmpvr2_cfg *cfg;
> +
> +	cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
> +	if (!cfg)
> +		return -ENOMEM;
> +
> +	cbuf = kmalloc(len, GFP_KERNEL);
> +	if (!cbuf) {
> +		status = -ENOMEM;
> +		goto buf_err;
> +	}
> +	ret = simple_write_to_buffer(cbuf, len, ppos, buf, len);
> +
> +	// Parse file
> +	status = raa_dmpvr2_parse_cfg(cbuf, cfg);
> +	if (status)
> +		goto parse_err;
> +	// Verify device and file IDs/revs match
> +	status = raa_dmpvr2_verify_device(ctrl, cfg);
> +	if (status)
> +		goto dev_err;
> +	// Verify enough of NVM slots available
> +	status = raa_dmpvr2_check_cfg(ctrl, cfg);
> +	if (status)
> +		goto dev_err;
> +	// Write CFG to device
> +	status = raa_dmpvr2_send_cfg(ctrl, cfg);
> +	if (status)
> +		goto dev_err;
> +	// Verify programming success
> +	status = raa_dmpvr2_cfg_write_result(ctrl, cfg);
> +	if (status)
> +		goto dev_err;
> +	// Free memory
> +	kfree(cbuf);
> +	kfree(cfg->cmds);
> +	kfree(cfg);
> +	return ret;
> +
> +	// Handle Errors
> +dev_err:
> +	kfree(cfg->cmds);
> +parse_err:
> +	kfree(cbuf);
> +buf_err:
> +	kfree(cfg);
> +	return status;
> +}
> +
> +static ssize_t raa_dmpvr2_debugfs_read(struct file *file, char __user *buf,
> +				       size_t len, loff_t *ppos)
> +{
> +	int *idxp = file->private_data;
> +	int idx = *idxp;
> +	struct raa_dmpvr2_ctrl *ctrl = to_ctrl(idxp, idx);
> +
> +	switch (idx) {
> +	case RAA_DMPVR2_DEBUGFS_BB_R:
> +		return raa_dmpvr2_read_black_box(ctrl, buf, len, ppos);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t raa_dmpvr2_debugfs_write(struct file *file,
> +					const char __user *buf, size_t len,
> +					loff_t *ppos)
> +{
> +	int *idxp = file->private_data;
> +	int idx = *idxp;
> +	struct raa_dmpvr2_ctrl *ctrl = to_ctrl(idxp, idx);
> +
> +	switch (idx) {
> +	case RAA_DMPVR2_DEBUGFS_CFG_W:
> +		return raa_dmpvr2_write_cfg(ctrl, buf, len, ppos);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct file_operations raa_dmpvr2_debugfs_fops = {
> +	.llseek = noop_llseek,
> +	.read = raa_dmpvr2_debugfs_read,
> +	.write = raa_dmpvr2_debugfs_write,
> +	.open = simple_open,
> +};
> +
>  static int raa_dmpvr2_read_word_data(struct i2c_client *client, int page,
>  				     int phase, int reg)
>  {
> @@ -220,7 +670,11 @@ static struct pmbus_driver_info raa_dmpvr_info = {
>  static int isl68137_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> +	int i, ret;
>  	struct pmbus_driver_info *info;
> +	struct dentry *debugfs;
> +	struct dentry *debug_dir;
> +	struct raa_dmpvr2_ctrl *ctrl;
>  
>  	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
>  	if (!info)
> @@ -262,7 +716,37 @@ static int isl68137_probe(struct i2c_client *client,
>  		return -ENODEV;
>  	}
>  
> -	return pmbus_do_probe(client, id, info);
> +	// No debugfs features for Gen 1
> +	if (id->driver_data == raa_dmpvr1_2rail)
> +		return pmbus_do_probe(client, id, info);
> +
> +	ret = pmbus_do_probe(client, id, info);
> +	if (ret != 0)
> +		return ret;
> +
> +	ctrl = devm_kzalloc(&client->dev, sizeof(*ctrl), GFP_KERNEL);
> +	if (!ctrl)
> +		return 0;
> +
> +	ctrl->client = client;
> +	debugfs = pmbus_get_debugfs_dir(client);
> +	if (!debugfs)
> +		return 0;
> +
> +	debug_dir = debugfs_create_dir(client->name, debugfs);
> +	if (!debug_dir)
> +		return 0;
> +
> +	for (i = 0; i < RAA_DMPVR2_DEBUGFS_NUM_ENTRIES; i++)
> +		ctrl->debugfs_entries[i] = i;
> +
> +	debugfs_create_file("write_config", 0220, debug_dir,
> +			    &ctrl->debugfs_entries[RAA_DMPVR2_DEBUGFS_CFG_W],
> +			    &raa_dmpvr2_debugfs_fops);
> +	debugfs_create_file("read_black_box", 0440, debug_dir,
> +			    &ctrl->debugfs_entries[RAA_DMPVR2_DEBUGFS_BB_R],
> +			    &raa_dmpvr2_debugfs_fops);
> +	return 0;
>  }
>  
>  static const struct i2c_device_id raa_dmpvr_id[] = {
> -- 
> 2.20.1
> 
