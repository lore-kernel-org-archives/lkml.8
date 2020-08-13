Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4930C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF5B20768
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597298610;
	bh=c2JkQY/iLy3UWqdaj6GyTFr2kN3ZzRXR970lGVv3ZKY=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=jNb5agVnNOrkm4OIPtTKk56ID6MJ+x9ss3eBcM3w20COSTB0OgmIsbYnhqwSrY1AK
	 d66mQV4U3DZPC3jJ0cJGS4ZwW5NCAyPR3dUC6xjOeM+NyOCARQWxLku5D8tBQiQ1uy
	 SP/UcQNnLGIhZmgS/XzyX3/o8MRYzbpDlWq4tWLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgHMGD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 02:03:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40296 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgHMGD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 02:03:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id a14so3272332edx.7;
        Wed, 12 Aug 2020 23:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Khf/VMAB3uYm/74V7OIX0V2t5P5w/qRvI1RZJAgPegY=;
        b=QmEBrRnajjGNj0+5CakUMQDv3Nu5Ws9t5L4iLCjYNHhL+Tf7AOI9yN0K/+vC9lN1Ug
         KJnjb9HLGsZZNCxhHKYuNABYBhHFJBIHHQh4B+4qb9SYeld4k3YwmRPD2Tq6Wa6Ao0iD
         rsj6/r+6N/fFrZHIwDZCje5eh/lVxQEFcMS+t83PVNbvg3SZiaSUi0bh++9PVzXOt9p9
         iFjvSoGE2pj/ck+d5kv0nf7IV8cVYxKjXaiup0forc0WzksKUHKi9qEtJWNCDsJwkODM
         OqwDYw58vCiG4FRl4TRut5EfRo5URZsKcFW4eoOxoHHt6Mp0dBgjGkyCO0VVPyI6RUXf
         2wiQ==
X-Gm-Message-State: AOAM533KQuaK+6ltN/RstGHnMhiryMSpzVqr+R6pO3gi5lO8XOweEGFM
        4feLTax3QRoO06HkeuQqkcw=
X-Google-Smtp-Source: ABdhPJwOzOwEmTFJgDCy1OB+MdFnxkfB3YGk5CkSfIdGYb4ISCePBiIc2MZsVy2En9mkEJjWvft70Q==
X-Received: by 2002:a50:d697:: with SMTP id r23mr3155650edi.223.1597298606788;
        Wed, 12 Aug 2020 23:03:26 -0700 (PDT)
Received: from pi3 ([194.230.155.117])
        by smtp.googlemail.com with ESMTPSA id pj19sm3027363ejb.66.2020.08.12.23.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 23:03:26 -0700 (PDT)
Date:   Thu, 13 Aug 2020 08:03:24 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 08/11] extcon: ptn5150: Check current USB mode when
 probing
Message-ID: <20200813060324.GA16245@pi3>
References: <20200812162958.6180-1-krzk@kernel.org>
 <20200812162958.6180-8-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200812162958.6180-8-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 06:29:55PM +0200, Krzysztof Kozlowski wrote:
> When machine boots up, the USB could be already in OTG mode.  In such
> case there will be no interrupt coming to ptn5150 device and driver will
> report default state of nothing connected.  Detection of USB connection
> would happen on first unplug of the cable.
> 
> Factor out code for checking current connection mode and call it right
> after probe so the existing USB mode will be properly reported.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/extcon/extcon-ptn5150.c | 93 ++++++++++++++++++---------------
>  1 file changed, 50 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> index a57fef384a29..bbb185378e4b 100644
> --- a/drivers/extcon/extcon-ptn5150.c
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -5,6 +5,7 @@
>  // Based on extcon-sm5502.c driver
>  // Copyright (c) 2018-2019 by Vijai Kumar K
>  // Author: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
> +// Copyright (c) 2020 Krzysztof Kozlowski <krzk@kernel.org>
>  
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> @@ -83,12 +84,50 @@ static const struct regmap_config ptn5150_regmap_config = {
>  	.max_register	= PTN5150_REG_END,
>  };
>  
> +static void ptn5150_check_state(struct ptn5150_info *info)
> +{
> +	unsigned int port_status, reg_data, vbus;
> +	int ret;
> +
> +	ret = regmap_read(info->regmap, PTN5150_REG_CC_STATUS, &reg_data);
> +	if (ret) {
> +		dev_err(info->dev, "failed to read CC STATUS %d\n", ret);
> +		mutex_unlock(&info->mutex);

There is a double mutex unlock here, I'll send a v2.

Best regards,
Krzysztof
