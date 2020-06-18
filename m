Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0918C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A795520663
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cx1luB+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgFRKPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgFRKPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:15:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ADFC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 03:15:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d128so5054599wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 03:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qg9tEPVUfxnFCIrhq6Cxtm2xq+K41ta0C1KawN8gvHM=;
        b=cx1luB+7YGehI94Iy1BhgMiMrmFysQYJiLKsYuiOmDAB+3AKeMO0DjkOYboqILxEqC
         DBfoUR5CqCHqVAuv41ZNBwqb2NVc2JZW3upewmiGh8rRh5Ri2ne3kuFFfTL78uqz7Bzf
         x7shGbSJ4KWrsbfsy2EArTf/m+Io6mvPxvPWcH2cxG5qz+UzJtd1WujRxu/A7qUSVFKL
         8fJVUkyxN4GFHAw/IK8W0uq0E4SXE5AON3vtx/oKxGX/V3mvjaufe3u7FJOvsvx5XVd1
         GOrsGqSzF4VD3m76NFntyGfiW9RIQO7iYTB4JhEUJNn0v9RrVtwYV9TmXi+Ei1EoWpkJ
         tiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qg9tEPVUfxnFCIrhq6Cxtm2xq+K41ta0C1KawN8gvHM=;
        b=K/egVsula4/t3ixI2UoSXj+JKtiBkUjSULIMX3K7BwApEW3WIYdJNnNBb7hZrGpDnr
         B000ZYzlEyFNh5Y1lwn9QAOBdZoEjH8baIW94gUKn/XI+JQOFoJdvkhLHXKnkwQ2qjaI
         NhCud0eW2xvS9rBc3JsKgsJHmOHHO9K3E6Zv36YE92R1C3J9watwx7ZFEfSheTb1/dX1
         Uw7a9T9k/JGOOV8T6mhs2Zn4hFWEX8x1fYxASKpGV3C+O1B4dUDVAKk8DhhF9xRHureC
         XVW9/AqF4/GSmYyIkPz8LkEsnxNQPM7Bq2MdkgUXZNNJz8ZOx1aM6vq3Chl8010+9K/B
         +MOQ==
X-Gm-Message-State: AOAM533YQKBLr/UDSdNT0SkSb6auvSBtMJVKGy/bTdkjZ26nAD25GwXg
        i01oEWfIN1MuCtnE3ykEzFeTRQ==
X-Google-Smtp-Source: ABdhPJxDK9q7lH9/km9dGYIMG4MjnuKBpjrcajobyuwibEEhSUcleagUuGL1d0twW7vuzE1hOH6njQ==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr3400539wmi.126.1592475314881;
        Thu, 18 Jun 2020 03:15:14 -0700 (PDT)
Received: from dell ([95.149.164.118])
        by smtp.gmail.com with ESMTPSA id y14sm2767123wma.25.2020.06.18.03.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 03:15:14 -0700 (PDT)
Date:   Thu, 18 Jun 2020 11:15:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH v3 1/2] mfd: da9063: Fix revision handling to correctly
 select reg tables
Message-ID: <20200618101511.GE954398@dell>
References: <cover.1587120185.git.Adam.Thomson.Opensource@diasemi.com>
 <a019b698f0c643455e07e7a94dcf0478b1b1f4d4.1587120185.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a019b698f0c643455e07e7a94dcf0478b1b1f4d4.1587120185.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020, Adam Thomson wrote:

> The current implementation performs checking in the i2c_probe()
> function of the variant_code but does this immediately after the
> containing struct has been initialised as all zero. This means the
> check for variant code will always default to using the BB tables
> and will never select AD. The variant code is subsequently set
> by device_init() and later used by the RTC so really it's a little
> fortunate this mismatch works.
> 
> This update adds raw I2C read access functionality to read the chip
> and variant/revision information (common to all revisions) so that
> it can subsequently correctly choose the proper regmap tables for
> real initialisation.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  drivers/mfd/da9063-core.c            |  31 ------
>  drivers/mfd/da9063-i2c.c             | 184 +++++++++++++++++++++++++++++++----
>  include/linux/mfd/da9063/registers.h |  15 ++-
>  3 files changed, 177 insertions(+), 53 deletions(-)

[...]

> + * Raw I2C access required for just accessing chip and variant info before we
> + * know which device is present. The info read from the device using this
> + * approach is then used to select the correct regmap tables.
> + */
> +
> +#define DA9063_REG_PAGE_SIZE		0x100
> +#define DA9063_REG_PAGED_ADDR_MASK	0xFF
> +
> +enum da9063_page_sel_buf_fmt {
> +	DA9063_PAGE_SEL_BUF_PAGE_REG = 0,
> +	DA9063_PAGE_SEL_BUF_PAGE_VAL,
> +	DA9063_PAGE_SEL_BUF_SIZE,
> +};
> +
> +enum da9063_paged_read_msgs {
> +	DA9063_PAGED_READ_MSG_PAGE_SEL = 0,
> +	DA9063_PAGED_READ_MSG_REG_SEL,
> +	DA9063_PAGED_READ_MSG_DATA,
> +	DA9063_PAGED_READ_MSG_CNT,
> +};
> +
> +static int da9063_i2c_blockreg_read(struct i2c_client *client, u16 addr,
> +				    u8 *buf, int count)
> +{
> +	struct i2c_msg xfer[DA9063_PAGED_READ_MSG_CNT];
> +	u8 page_sel_buf[DA9063_PAGE_SEL_BUF_SIZE];
> +	u8 page_num, paged_addr;
> +	int ret;
> +
> +	/* Determine page info based on register address */
> +	page_num = (addr / DA9063_REG_PAGE_SIZE);
> +	if (page_num > 1) {
> +		dev_err(&client->dev, "Invalid register address provided\n");
> +		return -EINVAL;
> +	}
> +
> +	paged_addr = (addr % DA9063_REG_PAGE_SIZE) & DA9063_REG_PAGED_ADDR_MASK;
> +	page_sel_buf[DA9063_PAGE_SEL_BUF_PAGE_REG] = DA9063_REG_PAGE_CON;
> +	page_sel_buf[DA9063_PAGE_SEL_BUF_PAGE_VAL] =
> +		(page_num << DA9063_I2C_PAGE_SEL_SHIFT) & DA9063_REG_PAGE_MASK;
> +
> +	/* Write reg address, page selection */
> +	xfer[DA9063_PAGED_READ_MSG_PAGE_SEL].addr = client->addr;
> +	xfer[DA9063_PAGED_READ_MSG_PAGE_SEL].flags = 0;
> +	xfer[DA9063_PAGED_READ_MSG_PAGE_SEL].len = DA9063_PAGE_SEL_BUF_SIZE;
> +	xfer[DA9063_PAGED_READ_MSG_PAGE_SEL].buf = page_sel_buf;
> +
> +	/* Select register address */
> +	xfer[DA9063_PAGED_READ_MSG_REG_SEL].addr = client->addr;
> +	xfer[DA9063_PAGED_READ_MSG_REG_SEL].flags = 0;
> +	xfer[DA9063_PAGED_READ_MSG_REG_SEL].len = sizeof(paged_addr);
> +	xfer[DA9063_PAGED_READ_MSG_REG_SEL].buf = &paged_addr;
> +
> +	/* Read data */
> +	xfer[DA9063_PAGED_READ_MSG_DATA].addr = client->addr;
> +	xfer[DA9063_PAGED_READ_MSG_DATA].flags = I2C_M_RD;
> +	xfer[DA9063_PAGED_READ_MSG_DATA].len = count;
> +	xfer[DA9063_PAGED_READ_MSG_DATA].buf = buf;
> +
> +	ret = i2c_transfer(client->adapter, xfer, DA9063_PAGED_READ_MSG_CNT);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Paged block read failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (ret != DA9063_PAGED_READ_MSG_CNT) {
> +		dev_err(&client->dev, "Paged block read failed to complete\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}

Rather than open coding this, does it make sense to register a small
(temporary?) Device ID Regmap to read from?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
