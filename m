Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF56C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26795207FC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn4Hv+hl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgGSWNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 18:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgGSWNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 18:13:04 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E39C0619D2;
        Sun, 19 Jul 2020 15:13:04 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o22so9025456pjw.2;
        Sun, 19 Jul 2020 15:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FfxiFcQic3U+Bod+D7CAdetU6QuGApoDXaR9ARS5JcU=;
        b=Bn4Hv+hlqhJAVlE22JO/nvwK+I2WzcabEUXHd868L51x6doN/GmfiaWKSrbUtj4RVE
         0dg5XgEfHgbxW5d5S6K+yIXZwe5Fu/ubDzpjTvoeYxTzoLIknRcpZmd+C7KLVi4BbjRg
         QSk1pml2RB+qr8uiZevNiWfgb/sOIZDQyGh6sArTCkxvzlkjL0VAQPY4N/difQzef5sG
         EVYD8D37Tw7lVzRZ7YCr+pMScf/sNbJQNt4ODyZfNX4Knk152dTnm/C6QdFuShrfRO1Y
         EnCFbl1ScEUtwTNPz0934SHbmWz6GbUcOgIHEmBbgbvkx8S9UTwW625vjWDDcHkQZkEM
         ZnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FfxiFcQic3U+Bod+D7CAdetU6QuGApoDXaR9ARS5JcU=;
        b=prs2uNoWpAJBTsCgmf8FxvxALw5cR0ub/TyI1iZMk58V5AMZ4U0TW1lV/oo4UW0GEg
         GxQBOq/AJ714l3Y4WXDfmKs8JCcAcuLANTfxk+A7IE9tvS+OLI/fRZx5mYTGw5y0+QfB
         4MIaP5q9WZ+ZS83OtJOvjZP37XS3fSVDRKF6Fvnbc0o/uSY6y+WPn9ZgdeN6IcO++8rJ
         QYh5ghCY+ZReQ+WwQwV8CkLCRSrWFVxa6agPLHHoiVU9IczVnLiMP/xzgY4fkGTCPxRj
         GONujs1Ce67R5bP5LDXE+7pUQ7+/RAkTQQORjjM/Wy8ArC4knwh/ZPcs+AbcVffzYxVd
         2BSA==
X-Gm-Message-State: AOAM530kimnv+L2Ug+3ypW+jf/rgOYbmBHbNDtw14fOccZfzjwGLf013
        atwRg4b3aRlVbuonRytJaVwj6XDY
X-Google-Smtp-Source: ABdhPJyUpOf3CBoiry/JvPsprWU1LN2VaNJMKECuTGRF16BsWiVW/la9/DVsbiMkIudEYE50m5mUww==
X-Received: by 2002:a17:902:446:: with SMTP id 64mr15877894ple.157.1595196783795;
        Sun, 19 Jul 2020 15:13:03 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h194sm14568015pfe.201.2020.07.19.15.13.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Jul 2020 15:13:03 -0700 (PDT)
Date:   Sun, 19 Jul 2020 15:13:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-fsi@lists.ozlabs.org, devicetree@vger.kernel.org,
        jdelvare@suse.com, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/3] fsi: occ: Add support for P10
Message-ID: <20200719221302.GA78557@roeck-us.net>
References: <20200501150833.5251-1-eajames@linux.ibm.com>
 <20200501150833.5251-3-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501150833.5251-3-eajames@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 10:08:32AM -0500, Eddie James wrote:
> The P10 OCC has a different SRAM address for the command and response
> buffers. In addition, the SBE commands to access the SRAM have changed
> format. Add versioning to the driver to handle these differences.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

I don't recall seeing a maintainer Ack for this patch, nor any response
at all. I'd be happy to apply the patch through hwmon, but I would need
an Ack from a maintainer.

Thanks,
Guenter

> ---
>  drivers/fsi/fsi-occ.c | 126 ++++++++++++++++++++++++++++++------------
>  1 file changed, 92 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> index 7da9c81759ac..942eff4032b0 100644
> --- a/drivers/fsi/fsi-occ.c
> +++ b/drivers/fsi/fsi-occ.c
> @@ -14,6 +14,7 @@
>  #include <linux/mutex.h>
>  #include <linux/fsi-occ.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> @@ -24,8 +25,13 @@
>  #define OCC_CMD_DATA_BYTES	4090
>  #define OCC_RESP_DATA_BYTES	4089
>  
> -#define OCC_SRAM_CMD_ADDR	0xFFFBE000
> -#define OCC_SRAM_RSP_ADDR	0xFFFBF000
> +#define OCC_P9_SRAM_CMD_ADDR	0xFFFBE000
> +#define OCC_P9_SRAM_RSP_ADDR	0xFFFBF000
> +
> +#define OCC_P10_SRAM_CMD_ADDR	0xFFFFD000
> +#define OCC_P10_SRAM_RSP_ADDR	0xFFFFE000
> +
> +#define OCC_P10_SRAM_MODE	0x58	/* Normal mode, OCB channel 2 */
>  
>  /*
>   * Assume we don't have much FFDC, if we do we'll overflow and
> @@ -37,11 +43,14 @@
>  #define OCC_TIMEOUT_MS		1000
>  #define OCC_CMD_IN_PRG_WAIT_MS	50
>  
> +enum versions { occ_p9, occ_p10 };
> +
>  struct occ {
>  	struct device *dev;
>  	struct device *sbefifo;
>  	char name[32];
>  	int idx;
> +	enum versions version;
>  	struct miscdevice mdev;
>  	struct mutex occ_lock;
>  };
> @@ -235,29 +244,43 @@ static int occ_verify_checksum(struct occ_response *resp, u16 data_length)
>  	return 0;
>  }
>  
> -static int occ_getsram(struct occ *occ, u32 address, void *data, ssize_t len)
> +static int occ_getsram(struct occ *occ, u32 offset, void *data, ssize_t len)
>  {
>  	u32 data_len = ((len + 7) / 8) * 8;	/* must be multiples of 8 B */
> -	size_t resp_len, resp_data_len;
> -	__be32 *resp, cmd[5];
> -	int rc;
> +	size_t cmd_len, resp_len, resp_data_len;
> +	__be32 *resp, cmd[6];
> +	int idx = 0, rc;
>  
>  	/*
>  	 * Magic sequence to do SBE getsram command. SBE will fetch data from
>  	 * specified SRAM address.
>  	 */
> -	cmd[0] = cpu_to_be32(0x5);
> +	switch (occ->version) {
> +	default:
> +	case occ_p9:
> +		cmd_len = 5;
> +		cmd[2] = cpu_to_be32(1);	/* Normal mode */
> +		cmd[3] = cpu_to_be32(OCC_P9_SRAM_RSP_ADDR + offset);
> +		break;
> +	case occ_p10:
> +		idx = 1;
> +		cmd_len = 6;
> +		cmd[2] = cpu_to_be32(OCC_P10_SRAM_MODE);
> +		cmd[3] = 0;
> +		cmd[4] = cpu_to_be32(OCC_P10_SRAM_RSP_ADDR + offset);
> +		break;
> +	}
> +
> +	cmd[0] = cpu_to_be32(cmd_len);
>  	cmd[1] = cpu_to_be32(SBEFIFO_CMD_GET_OCC_SRAM);
> -	cmd[2] = cpu_to_be32(1);
> -	cmd[3] = cpu_to_be32(address);
> -	cmd[4] = cpu_to_be32(data_len);
> +	cmd[4 + idx] = cpu_to_be32(data_len);
>  
>  	resp_len = (data_len >> 2) + OCC_SBE_STATUS_WORDS;
>  	resp = kzalloc(resp_len << 2, GFP_KERNEL);
>  	if (!resp)
>  		return -ENOMEM;
>  
> -	rc = sbefifo_submit(occ->sbefifo, cmd, 5, resp, &resp_len);
> +	rc = sbefifo_submit(occ->sbefifo, cmd, cmd_len, resp, &resp_len);
>  	if (rc)
>  		goto free;
>  
> @@ -287,20 +310,21 @@ static int occ_getsram(struct occ *occ, u32 address, void *data, ssize_t len)
>  	return rc;
>  }
>  
> -static int occ_putsram(struct occ *occ, u32 address, const void *data,
> -		       ssize_t len)
> +static int occ_putsram(struct occ *occ, const void *data, ssize_t len)
>  {
>  	size_t cmd_len, buf_len, resp_len, resp_data_len;
>  	u32 data_len = ((len + 7) / 8) * 8;	/* must be multiples of 8 B */
>  	__be32 *buf;
> -	int rc;
> +	int idx = 0, rc;
> +
> +	cmd_len = (occ->version == occ_p10) ? 6 : 5;
>  
>  	/*
>  	 * We use the same buffer for command and response, make
>  	 * sure it's big enough
>  	 */
>  	resp_len = OCC_SBE_STATUS_WORDS;
> -	cmd_len = (data_len >> 2) + 5;
> +	cmd_len += data_len >> 2;
>  	buf_len = max(cmd_len, resp_len);
>  	buf = kzalloc(buf_len << 2, GFP_KERNEL);
>  	if (!buf)
> @@ -312,11 +336,23 @@ static int occ_putsram(struct occ *occ, u32 address, const void *data,
>  	 */
>  	buf[0] = cpu_to_be32(cmd_len);
>  	buf[1] = cpu_to_be32(SBEFIFO_CMD_PUT_OCC_SRAM);
> -	buf[2] = cpu_to_be32(1);
> -	buf[3] = cpu_to_be32(address);
> -	buf[4] = cpu_to_be32(data_len);
>  
> -	memcpy(&buf[5], data, len);
> +	switch (occ->version) {
> +	default:
> +	case occ_p9:
> +		buf[2] = cpu_to_be32(1);	/* Normal mode */
> +		buf[3] = cpu_to_be32(OCC_P9_SRAM_CMD_ADDR);
> +		break;
> +	case occ_p10:
> +		idx = 1;
> +		buf[2] = cpu_to_be32(OCC_P10_SRAM_MODE);
> +		buf[3] = 0;
> +		buf[4] = cpu_to_be32(OCC_P10_SRAM_CMD_ADDR);
> +		break;
> +	}
> +
> +	buf[4 + idx] = cpu_to_be32(data_len);
> +	memcpy(&buf[5 + idx], data, len);
>  
>  	rc = sbefifo_submit(occ->sbefifo, buf, cmd_len, buf, &resp_len);
>  	if (rc)
> @@ -356,21 +392,35 @@ static int occ_putsram(struct occ *occ, u32 address, const void *data,
>  static int occ_trigger_attn(struct occ *occ)
>  {
>  	__be32 buf[OCC_SBE_STATUS_WORDS];
> -	size_t resp_len, resp_data_len;
> -	int rc;
> +	size_t cmd_len, resp_len, resp_data_len;
> +	int idx = 0, rc;
>  
> -	BUILD_BUG_ON(OCC_SBE_STATUS_WORDS < 7);
> +	BUILD_BUG_ON(OCC_SBE_STATUS_WORDS < 8);
>  	resp_len = OCC_SBE_STATUS_WORDS;
>  
> -	buf[0] = cpu_to_be32(0x5 + 0x2);        /* Chip-op length in words */
> +	switch (occ->version) {
> +	default:
> +	case occ_p9:
> +		cmd_len = 7;
> +		buf[2] = cpu_to_be32(3); /* Circular mode */
> +		buf[3] = 0;
> +		break;
> +	case occ_p10:
> +		idx = 1;
> +		cmd_len = 8;
> +		buf[2] = cpu_to_be32(0xd0); /* Circular mode, OCB Channel 1 */
> +		buf[3] = 0;
> +		buf[4] = 0;
> +		break;
> +	}
> +
> +	buf[0] = cpu_to_be32(cmd_len);		/* Chip-op length in words */
>  	buf[1] = cpu_to_be32(SBEFIFO_CMD_PUT_OCC_SRAM);
> -	buf[2] = cpu_to_be32(0x3);              /* Mode: Circular */
> -	buf[3] = cpu_to_be32(0x0);              /* Address: ignore in mode 3 */
> -	buf[4] = cpu_to_be32(0x8);              /* Data length in bytes */
> -	buf[5] = cpu_to_be32(0x20010000);       /* Trigger OCC attention */
> -	buf[6] = 0;
> +	buf[4 + idx] = cpu_to_be32(8);		/* Data length in bytes */
> +	buf[5 + idx] = cpu_to_be32(0x20010000);	/* Trigger OCC attention */
> +	buf[6 + idx] = 0;
>  
> -	rc = sbefifo_submit(occ->sbefifo, buf, 7, buf, &resp_len);
> +	rc = sbefifo_submit(occ->sbefifo, buf, cmd_len, buf, &resp_len);
>  	if (rc)
>  		goto error;
>  
> @@ -429,7 +479,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>  
>  	/* Extract the seq_no from the command (first byte) */
>  	seq_no = *(const u8 *)request;
> -	rc = occ_putsram(occ, OCC_SRAM_CMD_ADDR, request, req_len);
> +	rc = occ_putsram(occ, request, req_len);
>  	if (rc)
>  		goto done;
>  
> @@ -440,7 +490,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>  	/* Read occ response header */
>  	start = jiffies;
>  	do {
> -		rc = occ_getsram(occ, OCC_SRAM_RSP_ADDR, resp, 8);
> +		rc = occ_getsram(occ, 0, resp, 8);
>  		if (rc)
>  			goto done;
>  
> @@ -476,8 +526,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>  	/* Grab the rest */
>  	if (resp_data_length > 1) {
>  		/* already got 3 bytes resp, also need 2 bytes checksum */
> -		rc = occ_getsram(occ, OCC_SRAM_RSP_ADDR + 8,
> -				 &resp->data[3], resp_data_length - 1);
> +		rc = occ_getsram(occ, 8, &resp->data[3], resp_data_length - 1);
>  		if (rc)
>  			goto done;
>  	}
> @@ -508,6 +557,7 @@ static int occ_probe(struct platform_device *pdev)
>  	struct occ *occ;
>  	struct platform_device *hwmon_dev;
>  	struct device *dev = &pdev->dev;
> +	const void *md =  of_device_get_match_data(dev);
>  	struct platform_device_info hwmon_dev_info = {
>  		.parent = dev,
>  		.name = "occ-hwmon",
> @@ -517,6 +567,7 @@ static int occ_probe(struct platform_device *pdev)
>  	if (!occ)
>  		return -ENOMEM;
>  
> +	occ->version = (enum versions)md;
>  	occ->dev = dev;
>  	occ->sbefifo = dev->parent;
>  	mutex_init(&occ->occ_lock);
> @@ -575,7 +626,14 @@ static int occ_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id occ_match[] = {
> -	{ .compatible = "ibm,p9-occ" },
> +	{
> +		.compatible = "ibm,p9-occ",
> +		.data = (void *)occ_p9
> +	},
> +	{
> +		.compatible = "ibm,p10-occ",
> +		.data = (void *)occ_p10
> +	},
>  	{ },
>  };
>  
