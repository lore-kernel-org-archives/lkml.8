Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CA1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77582076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuC2z0b6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgFHNtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 09:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgFHNtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 09:49:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48DAC08C5C2;
        Mon,  8 Jun 2020 06:49:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bg4so6691945plb.3;
        Mon, 08 Jun 2020 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PdG0oNGn7FG+/hSQEMAZ7pVX77sUEfgasl/r1hDzL9o=;
        b=GuC2z0b6alnpf2CnKyaDXckZ/Yp4DXQCqmCbKfLobPk3QAoJdXLmAc6sxfj4Ed98m6
         ARfxhDaKoKSjCN7bXW283zdQbC3lCs8JWhoL6i0D4vMxH998TNGx0A0FLdhDlicR4W5p
         lpBJ8cBa0jC0+voY2oBAoc+1nOwc++lGXUCP3003ldoHcAEp1YrJG2qq7/61vnoDH4jQ
         IggRS6NGmsCNWLhwfV9ZCJKrvtG7ZS/ZLKLy4mkJD8RIfyMaEp/aNu+cEcZpDcb75LQS
         9RkHVWBjO3W3RDZrj/Ce/BD92hPj3KgMAZJCvCHcvgwt+jkhIA61wVPv5GNAgvF+bZNC
         k6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PdG0oNGn7FG+/hSQEMAZ7pVX77sUEfgasl/r1hDzL9o=;
        b=KiesZTF+/6ndAKTLwCSPwf3hSisQpd3SaRzBhsuoxRYDX1kvvW7k3wFRCvsNykl9t3
         /zHQxfkQe8oiuFbulHzCWp0BJL802b2LIKqaKJNo5dLhaZf6GKBE+lwDZZT1DShDJfM3
         KBPIE+Ukd6ABrfA+94eNVREQFH8ibVFcTjwE4L0rGcX6ev9K3XoG4gn0dP+xMGb4UA0c
         6kVKv8AJkzB9awIVCQmmSzVz/n2QchyX/tG9AFerBTnbABVOedVM6HBd+KURyDvC+1/P
         LwrKtODUF5mttaY75bHVGhypjPXehMo2dTolCWeITmGbHrOgCHatni49i7M9dnHBqrRm
         Nv7g==
X-Gm-Message-State: AOAM530o+uQQk2UJBJEpsXtAF8W8bF9p+AbETMFXfuerfZMUT6fsP9b8
        RtLbEduBmq8CARI8I/kefMg=
X-Google-Smtp-Source: ABdhPJw6Et1OyLjyOOXvyCqwQQAEFGfb5iKa3FEHEMNV1o3wX0ejamNifzUDmvrQXQolYSiuFenmMQ==
X-Received: by 2002:a17:90a:1e:: with SMTP id 30mr3620199pja.25.1591624187425;
        Mon, 08 Jun 2020 06:49:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 63sm7397424pfd.65.2020.06.08.06.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 06:49:46 -0700 (PDT)
Subject: Re: [PATCH v3] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
To:     Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     saipsdasari@fb.com, patrickw3@fb.com, vijaykhemka@fb.com,
        linux-aspeed@lists.ozlabs.org, manikandan.e@hcl.com
References: <20200608104349.GA10918@cnn>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <23597b7b-de89-2911-092e-f3e1ad4884f5@roeck-us.net>
Date:   Mon, 8 Jun 2020 06:49:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200608104349.GA10918@cnn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/20 3:43 AM, Manikandan Elumalai wrote:
> The adm1278 temp attribute need it for openbmc platform .
> This feature not enabled by default, so PMON_CONFIG needs to enable it.
> 
> v3:
> ----
> fix invalid signed-off.
> removed checkpath warnings.
> write ADM1278_TEMP1_EN and ADM1278_VOUT_EN conf in single line operation.
> 
> v2:
> ----
> add Signed-off-by.
> removed ADM1278_TEMP1_EN check.
> 
> Signed-off-by: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
> ---
>  drivers/hwmon/pmbus/adm1275.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
> index 5caa37fb..4782e31 100644
> --- a/drivers/hwmon/pmbus/adm1275.c
> +++ b/drivers/hwmon/pmbus/adm1275.c
> @@ -666,11 +666,12 @@ static int adm1275_probe(struct i2c_client *client,
>  		tindex = 3;
>  
>  		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
> -			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> +			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
> +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  
> -		/* Enable VOUT if not enabled (it is disabled by default) */
> +		/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
>  		if (!(config & ADM1278_VOUT_EN)) {

This if statement needs to be
		if (config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN) != ADM1278_VOUT_EN | ADM1278_TEMP1_EN)

> -			config |= ADM1278_VOUT_EN;
> +			config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
>  			ret = i2c_smbus_write_byte_data(client,
>  							ADM1275_PMON_CONFIG,
>  							config);
> @@ -681,9 +682,6 @@ static int adm1275_probe(struct i2c_client *client,
>  			}
>  		}
>  
> -		if (config & ADM1278_TEMP1_EN)
> -			info->func[0] |=
> -				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>  		if (config & ADM1278_VIN_EN)
>  			info->func[0] |= PMBUS_HAVE_VIN;
>  		break;
> 

