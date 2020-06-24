Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A87C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4B72082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2pAbu44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404941AbgFXQi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404107AbgFXQi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:38:26 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3433C061573;
        Wed, 24 Jun 2020 09:38:25 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d12so1272909ply.1;
        Wed, 24 Jun 2020 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WjBSvIESIlBFwXybQQC+lA/YuWEUcT/s5uupLCvE9QQ=;
        b=H2pAbu44bwW7Kbn0oKlERjuJJGpE98Q6Ix082Ul/bqmIuqYxdw4dP02XIRJG9uFD9R
         hBUIaHpE0YT9sqRZyMcrH5pHDfciIPp6E71vEaJfW2arP6HQKO34Ax0UnZXJ2If5GM+5
         Y1BOnh36LSfNuVwADNVBWC0ltbSe0AFmj+yPvUBeFMzDf29d1GPYPpHrLAS59C+heNmx
         GMkWo9eT76G+F5eCOVi+I4IyHDMNfh6Q1PO0n2U1gw1RwiIKQo1As1MIQgS/QVpnUdWi
         S9/7SOsvFFTpyn8oYT9CiMcCssZ1WxGnnYrv/nN/4mTbbuk9ZinmyCjWHfZqdoKdzDeH
         3q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=WjBSvIESIlBFwXybQQC+lA/YuWEUcT/s5uupLCvE9QQ=;
        b=EtFNwHOZbHNYYI980Wu4n96e84w7gGPcw+cDZVjhTZR3d6W2VJhHjs/uQ9imn7Gd4V
         74Kki9i5X0kQzn/IJSY/R1nQVq+WFEYGxAJw6FwfTPN2jjGBAYwE3VKSjBygVZgG+up8
         gM29DO1lbIhEE+nzy67oOqbxRU23cRkSf2B1d1y9mhwLkf2cxxyTMGHrPDgM1C9u8ucF
         pNl/tUe0Druy+OtmLwlfTPx3CL6I4aC9sJmO01kEp0Aco6ngRizFfv9eHljwerddRPSW
         Yz6RkqAMjOuYJpJo6N0cS+cKkf/xVZpbrZvx5TvKNZcxi2BYwPG/LGC6Dpvs5G/n0shm
         3FCg==
X-Gm-Message-State: AOAM530Tpn45CfQLsDQRcoKb3G8+EzlePVsvWsYRbFbjHvMYTWmKhA6v
        PSnG0/f8frye9fjjacbJKfmDqj2u
X-Google-Smtp-Source: ABdhPJxbhilHC7OCkFvNZ12wGkdVygkLZHkXDUU/ZXdRSKmel5DBsxUd81gUaKqZ+XXqG8PzhDdCWw==
X-Received: by 2002:a17:90a:d809:: with SMTP id a9mr30783941pjv.212.1593016705408;
        Wed, 24 Jun 2020 09:38:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h13sm20493323pfk.25.2020.06.24.09.38.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jun 2020 09:38:24 -0700 (PDT)
Date:   Wed, 24 Jun 2020 09:38:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chu Lin <linchuyuan@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Jason Ling <jasonling@google.com>,
        Kais Belgaied <belgaied@google.com>,
        Zhongqi Li <zhongqil@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon:max6697: Make sure the OVERT mask is set correctly
Message-ID: <20200624163823.GA215518@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:13:08PM +0000, Chu Lin wrote:
> Per the datasheet for max6697, OVERT mask and ALERT mask is different.
> For example, the 7th bit of OVERT is the local channel but for alert
> mask, the 6th bit is the local channel. Therefore, we can't apply the
> same mask for both reg. In addition to that, max6697 driver is suppose
> to be compatibale with different models. I mannually went over all the
> listed chip and made sure all the chip type has the same layout.
> 
> Testing;
>     mask value of 0x9 should map to 0x44 for ALERT and 0x84 for OVERT.
> I used iotool to read the reg value back to verify. I only tested this
> change on max6581
> 
> Reference:
> https://datasheets.maximintegrated.com/en/ds/MAX6581.pdf
> https://datasheets.maximintegrated.com/en/ds/MAX6697.pdf
> https://datasheets.maximintegrated.com/en/ds/MAX6699.pdf
> 
> Signed-off-by: Chu Lin <linchuyuan@google.com>

Nice catch.

Applied, thanks

Guenter

> ---
>  drivers/hwmon/max6697.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
> index 743752a2467a..64122eb38060 100644
> --- a/drivers/hwmon/max6697.c
> +++ b/drivers/hwmon/max6697.c
> @@ -38,8 +38,9 @@ static const u8 MAX6697_REG_CRIT[] = {
>   * Map device tree / platform data register bit map to chip bit map.
>   * Applies to alert register and over-temperature register.
>   */
> -#define MAX6697_MAP_BITS(reg)	((((reg) & 0x7e) >> 1) | \
> +#define MAX6697_ALERT_MAP_BITS(reg)	((((reg) & 0x7e) >> 1) | \
>  				 (((reg) & 0x01) << 6) | ((reg) & 0x80))
> +#define MAX6697_OVERT_MAP_BITS(reg) (((reg) >> 1) | (((reg) & 0x01) << 7))
>  
>  #define MAX6697_REG_STAT(n)		(0x44 + (n))
>  
> @@ -562,12 +563,12 @@ static int max6697_init_chip(struct max6697_data *data,
>  		return ret;
>  
>  	ret = i2c_smbus_write_byte_data(client, MAX6697_REG_ALERT_MASK,
> -					MAX6697_MAP_BITS(pdata->alert_mask));
> +				MAX6697_ALERT_MAP_BITS(pdata->alert_mask));
>  	if (ret < 0)
>  		return ret;
>  
>  	ret = i2c_smbus_write_byte_data(client, MAX6697_REG_OVERT_MASK,
> -				MAX6697_MAP_BITS(pdata->over_temperature_mask));
> +			MAX6697_OVERT_MAP_BITS(pdata->over_temperature_mask));
>  	if (ret < 0)
>  		return ret;
>  
> -- 
> 2.27.0.111.gc72c7da667-goog
> 
