Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908AEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DEDC207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3DiPkhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgHQIpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgHQIpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:45:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E15BC061388;
        Mon, 17 Aug 2020 01:45:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 3so13215560wmi.1;
        Mon, 17 Aug 2020 01:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gy5UHS1fMumIwQbUn2ngdWfpQe9mWv4iZvUxVAFlM0Y=;
        b=I3DiPkhV7gQOS3DppleGZtO3ailEghtHTzQgocm9hG7okEnXITNLsPnq4jMwoFt5sB
         +npvCjxLR1ntsR+wBM3uGqRGX/59E9Z/qfWQyNkaLDdSsw8iK0JddxuifDiPb8vW3R86
         PYWegUNzv7mXAjI6gs8Wekos5jvxOmgbkDD1UpbdUOlmbgCiWCuiYpNtyWPXDfFbSMRa
         p/vQOgHz37il38Fe1JLFazzlvCuqGrEddFsPrO3UaN4Lbn1k/93gpDRXDw2agxVV2a38
         8bKqzlMQfLI/xcR6sSAJ0GXyRGphkBXQOJmMPhC32WgJJK2+r7FFbf8+7mUC9BuR21WF
         ybTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gy5UHS1fMumIwQbUn2ngdWfpQe9mWv4iZvUxVAFlM0Y=;
        b=XvY+5PIdlxRNIKsD6whvxcJAZuTXKGa3GfrbcbEwPgDYN64OlulZY2o4P36BaZYRLN
         aQrShe8cZkZmLPmS8qzFF99l415O38TBIKiBsjEX55YaIjfVtzIzOgkaXQdrbRM+gnn2
         XUgzLkqNEsv/fdZ1ECpkHMMid3Te9TGx9UhTYHgONuPm77P7cyFDwu72WBrRhkMJow5Q
         EMUIEXAlz75KdoY+/pdaz+XGTr4e6aBzydq5JNg8l568Kg3lgNOllU9lbcJkEmsLsfIX
         /3xXY7LBH4XTF3Rq9rVCvBJJoS3AnmdxgV9Y/FUYaKI8eAsFgXfRoohK0F6eQ25Qi6Za
         dTmA==
X-Gm-Message-State: AOAM531bppidA2OQ0/0Y8w7w7NZaz/98aUwx2WsbWGiD5WD9TTJ6PBWG
        GYU/5qCvHiy/Ig9c8UgDipQ6ggE891M=
X-Google-Smtp-Source: ABdhPJx5KkuyBA4y+6nDyD95M440Ad/ITmWsDgtXh7Kr+7+a3azL6Z2IoPexVJszFj30q9T0GMs/cQ==
X-Received: by 2002:a1c:998c:: with SMTP id b134mr13441758wme.59.1597653911208;
        Mon, 17 Aug 2020 01:45:11 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id g3sm32750455wrb.59.2020.08.17.01.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:45:10 -0700 (PDT)
Date:   Mon, 17 Aug 2020 10:45:08 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/hwmon/adm1029.c: use simple i2c probe
Message-ID: <20200817084508.GA15571@Red>
References: <20200813161129.1507599-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813161129.1507599-1-steve@sk2.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 06:11:29PM +0200, Stephen Kitt wrote:
> This driver doesn't use the id information provided by the old i2c
> probe function, so it can trivially be converted to the simple
> ("probe_new") form.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  drivers/hwmon/adm1029.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
> index f7752a5bef31..50b1df7b008c 100644
> --- a/drivers/hwmon/adm1029.c
> +++ b/drivers/hwmon/adm1029.c
> @@ -352,8 +352,7 @@ static int adm1029_init_client(struct i2c_client *client)
>  	return 1;
>  }
>  
> -static int adm1029_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int adm1029_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct adm1029_data *data;
> @@ -390,7 +389,7 @@ static struct i2c_driver adm1029_driver = {
>  	.driver = {
>  		.name = "adm1029",
>  	},
> -	.probe		= adm1029_probe,
> +	.probe_new	= adm1029_probe,
>  	.id_table	= adm1029_id,
>  	.detect		= adm1029_detect,
>  	.address_list	= normal_i2c,
> -- 
> 2.25.4
> 

Hello

Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Thanks
