Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F081C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461A8246AB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DytT3aj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgBLUn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:43:26 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33204 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBLUn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:43:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so1836360pgk.0;
        Wed, 12 Feb 2020 12:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d8raYA2U8NHy+i0YP44rQhzEQ4l87sJ/u6a7isIV0dQ=;
        b=DytT3aj+ejmTlv3SwFQTus74drk/f/yKVxfJ0H5BgH7J4jtkAJSyGWZRSiSICDXqZP
         TVREodoR7KFwovelFeU+00kROq3sxO3r6cG2JeBSHyuIpCp21uXGCYUNq+kBOepP23KX
         qus7Rmwxs8No6GpH8xgg4uQKX1uHitCqS1XR1ZWx9qZCVR8r0z6OilU/eppiTL1OE9S2
         Dsf7lWOCpk4DMAPMciWOwmbS6WN080PQRW7F2FDSInpHBhJQY1ICtNZzxr6uYQmRbwn5
         zmiKuMDj4Xzs3agog11qkmDUvbgNi4wP55gyzZ8vnlznhBNGxDfl3j3VMycdfuuVXIql
         u5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=d8raYA2U8NHy+i0YP44rQhzEQ4l87sJ/u6a7isIV0dQ=;
        b=mW7ti0VO1Jv2bZlntx+sGxjNfrjVT2c7JdfcsF7OgsEgBWJYFwBwWM31iIDEPohILx
         lUKhziZTGqne7NNSa0R8NR9exUzZwONvHlkQiVg0xGAr/dJytwsoZ0ZWAowegiA9XqUO
         U8C1Zr1vKnB2bngnxoN2l2DH0uzsDxlIAT6TPLN/LduNAjzn9iahUyF1AcL/drLD8Oiu
         Sr2TtzzC44tjBGZhr1qIuwKXrRVNlnbneliUNLYlBZWu4LA8DVmoH0iHmc+GZhtkbURI
         Qd7N9GyvXWFH57NVl3xYajFODOcizG5Ah56WgnTCLNbOuT47SLyZ4yjKjGXNXKwQD9Zu
         bUzg==
X-Gm-Message-State: APjAAAUcSz3hcAUbXOcvKRK618O7A9VO1aMPlBo6IS1JZhIJ3eoQOn1f
        v0Kncw7OwEttkZ5v0R33HvjA4z7M
X-Google-Smtp-Source: APXvYqyqQcjZj46BabcxFEe4W4htaAy+lMWGakEh1TAVciTCIg7ra3RT2/Qn3leqoLH8jXg7Te73Ig==
X-Received: by 2002:a63:3c08:: with SMTP id j8mr14329831pga.223.1581540204184;
        Wed, 12 Feb 2020 12:43:24 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 64sm127034pfd.48.2020.02.12.12.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 12:43:22 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:43:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: Re: [PATCH] hwmon: (pmbus/xdpe12284): fix typo in compatible strings
Message-ID: <20200212204320.GA7035@roeck-us.net>
References: <20200212092426.24012-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212092426.24012-1-johan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 10:24:26AM +0100, Johan Hovold wrote:
> Make sure that the driver compatible strings matches the binding by
> removing the space between the manufacturer and model.
> 
> Fixes: aaafb7c8eb1c ("hwmon: (pmbus) Add support for Infineon Multi-phase xdpe122 family controllers")
> Cc: Vadim Pasternak <vadimp@mellanox.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/xdpe12284.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/xdpe12284.c b/drivers/hwmon/pmbus/xdpe12284.c
> index 3d47806ff4d3..ecd9b65627ec 100644
> --- a/drivers/hwmon/pmbus/xdpe12284.c
> +++ b/drivers/hwmon/pmbus/xdpe12284.c
> @@ -94,8 +94,8 @@ static const struct i2c_device_id xdpe122_id[] = {
>  MODULE_DEVICE_TABLE(i2c, xdpe122_id);
>  
>  static const struct of_device_id __maybe_unused xdpe122_of_match[] = {
> -	{.compatible = "infineon, xdpe12254"},
> -	{.compatible = "infineon, xdpe12284"},
> +	{.compatible = "infineon,xdpe12254"},
> +	{.compatible = "infineon,xdpe12284"},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, xdpe122_of_match);
