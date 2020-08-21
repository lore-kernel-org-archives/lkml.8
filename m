Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBC9C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D367C22EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHJhuIII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHUSaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgHUSaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:30:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04371C06179B;
        Fri, 21 Aug 2020 11:30:16 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h12so1390317pgm.7;
        Fri, 21 Aug 2020 11:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zP47110S/VhRjoKqw44D0J+M/2tpqI2WT8Gl3dFgMLU=;
        b=FHJhuIIIl2pjvt5gC0n9ebYyiLz7oPCyOoZ204GanM2l+Dt/AZK351tSCFaXcetIgB
         B0QuwgtbOLYh3yinGuPNmEMuTnVlomUiZvIknKW5OINsVq95f5P/8IfYpOvTztpQk7wj
         5rKQx4S3UkuY6qUu7yzqikp5pMBrC0C27wlZZgHZ0vmAdgusHDxAyG5sy7EtJNqSH6Wl
         OQ9tZfCKlVWZju4ne50ug0G12g6VyTIGBO2fmhyEgM8OAZohfuG6Zn2pIJdtYfRPmDME
         ho6FzKYOww8DX4s00jUzULiSihELcvDbmTArHDtqj9RyazRKS6cbNpGU0eNKfS/zzlyr
         dl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zP47110S/VhRjoKqw44D0J+M/2tpqI2WT8Gl3dFgMLU=;
        b=YDEg1cIfjTG4m+gm5YVQ7pZEt2GVuNbk4TlbNx9FXbo5qDz1aVaui1WD4KHp58iBNp
         vXRVh9ktSHODWT9txJCt4VTECC23BjFhjTCKFa5+5t7TUEK104LamnXe3NTmYK7WKshw
         wp33tg58VJm6/huMU3dgAIrkePAm+oPmXL/B8b54co2QZnzCrXZTMnO9RhP5N8n0SS01
         k0XwBKXaEKPqpvy4fKWto3X/LWTe322gwc6bP40m2EpDLNKL3PGHOKBiygo5aQJHDHA4
         t6ft3B7Fu2rwcy7ZiqtfvmbIzE4U1F3apgVVCf85+EjRp/ZfOu09DA/X70epAswKm2gF
         xxyg==
X-Gm-Message-State: AOAM531rZzvKfXFmXGHjsOTYo5agichd/C7YEdgMRTv9hcq82c0NbnG8
        OJen07qGX3g4wqmnMbvVRVw=
X-Google-Smtp-Source: ABdhPJxp1f9fXlscpv6Qe1ELd6qPs9/3TfsCbJWXquPOKCpMw0FIPwawnTMfQ9II/Phab4f9G10iHw==
X-Received: by 2002:aa7:8b18:: with SMTP id f24mr3453731pfd.301.1598034615578;
        Fri, 21 Aug 2020 11:30:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c207sm3072159pfc.64.2020.08.21.11.30.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Aug 2020 11:30:15 -0700 (PDT)
Date:   Fri, 21 Aug 2020 11:30:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (tmp513) use simple i2c probe
Message-ID: <20200821183013.GA61218@roeck-us.net>
References: <20200821160231.592571-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821160231.592571-1-steve@sk2.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 06:02:31PM +0200, Stephen Kitt wrote:
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/tmp513.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
> index df66e0bc1253..9f5885b0eb74 100644
> --- a/drivers/hwmon/tmp513.c
> +++ b/drivers/hwmon/tmp513.c
> @@ -709,8 +709,7 @@ static int tmp51x_configure(struct device *dev, struct tmp51x_data *data)
>  	return 0;
>  }
>  
> -static int tmp51x_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id)
> +static int tmp51x_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct tmp51x_data *data;
> @@ -724,7 +723,7 @@ static int tmp51x_probe(struct i2c_client *client,
>  	if (client->dev.of_node)
>  		data->id = (enum tmp51x_ids)device_get_match_data(&client->dev);
>  	else
> -		data->id = id->driver_data;
> +		data->id = i2c_match_id(tmp51x_id, client)->driver_data;
>  
>  	ret = tmp51x_configure(dev, data);
>  	if (ret < 0) {
> @@ -751,7 +750,7 @@ static int tmp51x_probe(struct i2c_client *client,
>  	if (IS_ERR(hwmon_dev))
>  		return PTR_ERR(hwmon_dev);
>  
> -	dev_dbg(dev, "power monitor %s\n", id->name);
> +	dev_dbg(dev, "power monitor %s\n", client->name);
>  
>  	return 0;
>  }
> @@ -761,7 +760,7 @@ static struct i2c_driver tmp51x_driver = {
>  		.name	= "tmp51x",
>  		.of_match_table = of_match_ptr(tmp51x_of_match),
>  	},
> -	.probe		= tmp51x_probe,
> +	.probe_new	= tmp51x_probe,
>  	.id_table	= tmp51x_id,
>  };
>  
