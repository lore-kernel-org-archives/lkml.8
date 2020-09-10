Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1569CC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF0AA21556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RC+ZT7Bv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgIJTl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731359AbgIJPgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:36:15 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBF3C061342
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:35:51 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id z22so9353105ejl.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BXTkxBrQX1Fi6aDdkjMID82XurVAmc4lBQFLUMsq2gk=;
        b=RC+ZT7BvjK4qq6hzJuqwm9x4XRFN9jn8PQza2KtLx6+jWuCwMd7udqz44TwyD9yVSO
         kPrQAbKYUZIW9n3CsPJYJzGDD+7AVpScWFtUiMCyzA3UVRNehD1IWKW+vNJ24OpzdCWP
         jKxHfR2U05e6Y9vHrg3q2/z03OYSlUnBbcCWoMS5lh7EXBEtTxFVljeHIlQjoWg/pnwp
         B43hyi7EbRftVn0jkpXIuQIktY1+nYHJTrGca5Q/s1iQphnAihtcIXwt/S4bXrzQjB/w
         +gjawcC6zPhW8xHCzMDcYomenWpV06AjP3EY1pL5GzwesGsA9RlXJyovLGuY2SA9IiN7
         dO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BXTkxBrQX1Fi6aDdkjMID82XurVAmc4lBQFLUMsq2gk=;
        b=EZ535XltXv0DJ5X9OzJiKnII7KUIKY3y9W0coxtFBHbSleJByNJYEd+MRPePuGoSyy
         AYKDlgTyvOrlSMP7F27luJ8/bxGJdGChx2YU3xPdMc1NuJQQf31C5PDjcFJuj7QYHYpi
         E3a6Hms1hCqS6KAnT8JqB9wuv4onrgsfJV1rC0qfpq5EKaxYKBUnhHFY7FQaAzGwhiUs
         FDiL4ibYnAiXLJjJgrkSJ3VSmufr7k287r+1kNdxgnbU7mZgtFFLeD58yKFppq9G3XtT
         fI0lQWB5Yo/Do6f/pKMywIXPs3jXVCfv54os+YC7CvYgBTCXU1ZaayDftAeC8xxAOxmj
         IaLQ==
X-Gm-Message-State: AOAM531DFcMdlO6u0GnHRAcSosO4MD2goMtJTesOhMWdzObAbra2EviS
        FONcha2jBUzlfpMW/oGIPAXCwjOz4HNGBA+eNfsuwQ==
X-Google-Smtp-Source: ABdhPJx7Mv8T/HQTpG7Qvas8LgnYGmAQQFvExnKZdjcXfZJH7JQDNYWAh9qsaxWtv/Kp4041pJErzuu/1P5IeK2hr9I=
X-Received: by 2002:a17:906:11d2:: with SMTP id o18mr9182631eja.420.1599752150402;
 Thu, 10 Sep 2020 08:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200910134239.192030-1-jonathanh@nvidia.com> <20200910134239.192030-2-jonathanh@nvidia.com>
In-Reply-To: <20200910134239.192030-2-jonathanh@nvidia.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 10 Sep 2020 17:35:39 +0200
Message-ID: <CAMpxmJXbhrmJJn4f3zk4=Y2tCwLzpFc+c6NbxcqVe8eaLSRvtw@mail.gmail.com>
Subject: Re: [PATCH 1/5] misc: eeprom: at24: Initialise AT24 NVMEM ID field
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 3:43 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>
> The AT24 EEPROM driver does not initialise the 'id' field of the
> nvmem_config structure and because the entire structure is not
> initialised, it ends up with a random value. This causes the NVMEM
> driver to append the device 'devid' value to name of the NVMEM
> device. Although this is not a problem per-se, for I2C devices such as
> the AT24, that already have a device unique name, there does not seem
> much value in appending an additional 0 to the I2C name. For example,
> appending a 0 to an I2C device name such as 1-0050 does not seem
> necessary and maybe even a bit confusing. Therefore, fix this by
> setting the NVMEM config.id to NVMEM_DEVID_NONE for AT24 EEPROMs.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/misc/eeprom/at24.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index e9df1ca251df..3f7a3bb6a36c 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -715,6 +715,7 @@ static int at24_probe(struct i2c_client *client)
>
>         nvmem_config.name = dev_name(dev);
>         nvmem_config.dev = dev;
> +       nvmem_config.id = NVMEM_DEVID_NONE;
>         nvmem_config.read_only = !writable;
>         nvmem_config.root_only = !(flags & AT24_FLAG_IRUGO);
>         nvmem_config.owner = THIS_MODULE;
> --
> 2.25.1
>

This patch is correct and thanks for catching it. I vaguely recall
wondering at some point why the appended 0 in the nvmem name for at24.
Unfortunately this change would affect how the device is visible in
user-space in /sys/bus/nvmem/devices/ and this could break existing
users. Also: there are many in-kernel users that would need to be
updated. I'm afraid we'll need some sort of backward compatibility.

Bartosz
