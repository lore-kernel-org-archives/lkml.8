Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E2BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F51020771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2+cpT2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgHNLjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNLja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:39:30 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C73C061384;
        Fri, 14 Aug 2020 04:39:30 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t14so7660047wmi.3;
        Fri, 14 Aug 2020 04:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PvaE6Xvjdl4FATqRBfh8A95bTlKRTVItk5/IF9Iibaw=;
        b=C2+cpT2T5s3PRdb1iX1gNsVRN7+bzUvaFphsG2v4A4+u/IgKs/5MzA0CITX++JzJcA
         ARxviUnSCDMZxWnYKfWsqJISab18SwV0zGWnoF9dmGH90QIb2oT5ru4T37dTkC97Utv9
         MY8ZpHnR+dFTb2ykAzedOFZheMFAAn4iCEwvWZ6XYpN+HTN4i9v+YqJsAEfX9Kd/eQo0
         11VZ+PJ+xuZK34tzxYeHm4LZxZL8vXxkWs0DHsYPFs++eVXi+wsdPkIrwu0QLRhl/0bj
         hkyPEopNYgun6Zui5DIgfn2N7H6VaxP0yJVCaRrxHqpW6Y6DUA8tWaLzkYw6DLl+hLxa
         On7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PvaE6Xvjdl4FATqRBfh8A95bTlKRTVItk5/IF9Iibaw=;
        b=rMr0RCYYYuV/QnFOCzeV9RbAgjnAgRflwmUPc3ubiiqv7KWrX2ZyuzLs9tTQmp2f0D
         KR4hhehC35oMqJIKOa8tdoweMviESld6qay2XVfrku5gyWyrmyb0EAbvWKoh6xLHHJ1u
         twlQHc+HJytujpKMfhhZua4/y/OBx/xmdI/AzTDtVLwGNzcsOt2OCM4pqPnB/PVJT8Ee
         KBSMCHOxSoUMXBQJhTlJO5uaDGkyus10DikttVoqmleM2xFExb/bLpow8rGUl35UEnxi
         ESuLIYyC2HsoHdM7j73ldkoWZoHHC6u0KPwLKsfAbrXVP0yN7MvIzjZaPrBjleLHECHh
         TKLA==
X-Gm-Message-State: AOAM530dqFfewse/Ba4fHgPDbnXV9oslDweRbnoozgVsCo01F4Sew47t
        XyHOHwkarXbzyyfJ6i5r/844kmEN2Jk=
X-Google-Smtp-Source: ABdhPJxfBdi37/yRj31u/1yVwVd6B4rPFoZNcM/71Em90ApUpFePmeHl8qrPizZJGJzVOdZ9+Ez4rA==
X-Received: by 2002:a7b:c38e:: with SMTP id s14mr2172037wmj.124.1597405169330;
        Fri, 14 Aug 2020 04:39:29 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id o7sm15093033wrv.50.2020.08.14.04.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:39:28 -0700 (PDT)
Date:   Fri, 14 Aug 2020 13:39:27 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/hwmon/adm1029.c: use simple i2c probe
Message-ID: <20200814113927.GA15832@Red>
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

Acked-by: Corentin LABBE <clabbe.montjoie@gmail.com>

But please give me a few day to test it.
