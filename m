Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6A5C55191
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18D020704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 17:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tce4E8Hp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgDYRnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 13:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726145AbgDYRnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 13:43:20 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41005C09B04D;
        Sat, 25 Apr 2020 10:43:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t40so5257687pjb.3;
        Sat, 25 Apr 2020 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bLqcX5Fj4pW2thvwUP8PivGetMN8e8e3pxGwORfwkh4=;
        b=tce4E8HpMgZSsJN7XvOy50RbSVkBWESC0MTvnIuoWaE94Ngxe/AStRO95YJ9AAp8RY
         E+UvthngfX4Ncnnhmv9k1/Ol2686SNihZ00Yc3hjxKr2Tfwn6J1T1b80MOBFJxgh7w1N
         U5YPVJrNQsI1NB6MKN7FPkyPlX65Z61oKDNQi7vNiYRvBEuGWtfDXuS/PKpQorXPZc1F
         wzwnfmETlfx1kM9kGfQ1OEHNhc84y6jG1DYlZv+dBzw8FeI7mYXbfm3cd3gFQ2yP7Twv
         +OkJy1aCtknQPrX8n803xuXC/eJCQyt2SnH+J9o7yBoi6825AZpn0bbnlFPkm8NCl2md
         b03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bLqcX5Fj4pW2thvwUP8PivGetMN8e8e3pxGwORfwkh4=;
        b=H6YQhq/f2h77++2i+dz40lI/0OweNgtcD5Cu/xPDARFSOhBfGFOszWLPPMGdWo4sxL
         ay5gvPDVrrRJjZV6smg0VluVfhKp0I2duJ0axDuQNdqvLn/MsNc5ODEaB5iTd80+gWnB
         2A/+BqxF05iS5GTDnhTjY7/JlAiUZ2GImzVAO+ZbSCuA0WcwlCXGSXNkMBgXcx2775/P
         mlx8wJ7TSz09+FgbxaFXUGmp9OKt7wRqdgRM4EAeS0UI0yY9nqz77+fLtBvkzTm0CKSf
         dBnKSeeUgD6uFPcMKQrts4hBwuaUlAWVU8y0TfnN0MwTdZokifOATD4wH+zrdtbAuDln
         Wujw==
X-Gm-Message-State: AGi0Pua9Kecw05u2DcVOisvKYddagrj60JUMtGVtbtQvTur++H/nDst2
        hFN8p1uX9uEcv2pzt7t8G2o=
X-Google-Smtp-Source: APiQypKd71HLJXPWdwWo9tHWLE36CIWnshm64ymcpGe4p4v4DNqlP90JI8y1vI+/t4yiTzKY63ZZpA==
X-Received: by 2002:a17:902:6bc1:: with SMTP id m1mr15029471plt.90.1587836599646;
        Sat, 25 Apr 2020 10:43:19 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f3sm7458610pjo.24.2020.04.25.10.43.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Apr 2020 10:43:19 -0700 (PDT)
Date:   Sat, 25 Apr 2020 10:43:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Grant Peltier <grantpeltier93@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        adam.vaughn.xh@renesas.com, grant.peltier.jg@renesas.com
Subject: Re: [PATCH v2 1/2] hwmon: (pmbus/isl68137) add debugfs config and
 black box endpoints
Message-ID: <20200425174318.GA40266@roeck-us.net>
References: <cover.1587572415.git.grantpeltier93@gmail.com>
 <acbdc26389b6ab5f5f4536de7332b03c45a95f00.1587572415.git.grantpeltier93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acbdc26389b6ab5f5f4536de7332b03c45a95f00.1587572415.git.grantpeltier93@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 12:27:14PM -0500, Grant Peltier wrote:
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

Comments inline.

However, the more I look into this, the more concerns I have.
I think we should limit debugfs functions, if they are needed,
to reporting detailed device status. Can you consider handling
configuration from userspace using i2cget / i2cset commands ?

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/isl68137.c | 460 ++++++++++++++++++++++++++++++++-
>  1 file changed, 457 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
> index 0c622711ef7e..455235a7a56b 100644
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
> @@ -157,6 +188,395 @@ static const struct attribute_group *isl68137_attribute_groups[] = {
>  	NULL,
>  };
>  
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

The return value from this function is not checked. Either check it,
or don't return a value.

> +}
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

The length check here only ensures that a single call to snprintf() doesn't add
more data to the buffer than available. However, since optr is advanced, there
is no practical limit on the total data written.

I understand that the maximum amount of data written in practice
is RAA_DMPVR2_BB_WCNT * ((RAA_DMPVR2_BB_WSIZE * 2) + 1), or 
32 * ((4 * 2) + 1) = 288, meaning the buffer is large enough, but
using snprintf() with sizeof(out) to limit the length of data written
is pretty pointless. Somewhat cleaner code might keep track of the length
written, write to out + length, and pass sizeof(out) - length as parameter.

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

Please don't mix c++ comments into a driver using c style comments.

> +	for (i = 0; i < strlen(buf); i++) {
> +		if (buf[i] == '\n' && i < strlen(buf)-2) {
> +			lcnt++;
> +			if (buf[i+1] != '4' || buf[i+2] != '9')

Space around operators, please.

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
> +	int res;
> +
> +	res = i2c_smbus_read_i2c_block_data(ctrl->client, PMBUS_IC_DEVICE_ID,
> +					    5, dev_id);
> +	if (res != 5)
> +		return -EIO;

The calling code returns this as error code.

> +
> +	res = i2c_smbus_read_i2c_block_data(ctrl->client, PMBUS_IC_DEVICE_REV,
> +					    5, dev_rev);

It still puzzles me, quite frankly, why i2c_smbus_read_block_data()
would not work here.

> +	if (res != 5)
> +		return -EIO;
> +
> +	return memcmp(cfg->dev_id, dev_id+1, 4)
> +		| memcmp(cfg->dev_rev+3, dev_rev+4, 1);

Please no arithmetic or of return codes. Besides, this is dangerous:
A mismatch returns a value <0 or >0 depending on the match, and this
is then returned as valid (and pretty much random) error code.
This function should return -ENODEV on error.

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

If raa_dmpvr2_smbus_read32 returns an error, the content of data[] is
random. In that case, this code is checking a random value.

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

Are you sure ? Normally I would expect ETIMEDOUT.

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
> +	// Verify enough NVM slots available
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

That comment is a bit useless.

> +	kfree(cbuf);
> +	kfree(cfg->cmds);
> +	kfree(cfg);
> +	return ret;
> +
> +	// Handle Errors

Another useless comment.

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
> @@ -220,7 +640,11 @@ static struct pmbus_driver_info raa_dmpvr_info = {
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
> @@ -262,7 +686,37 @@ static int isl68137_probe(struct i2c_client *client,
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

Why not do the version check and return here ?

	if (ret || id->driver_data == raa_dmpvr1_2rail)
		return ret;

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
