Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73B6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F6320720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNQWA3G8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHUSby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgHUSbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:31:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4594FC061573;
        Fri, 21 Aug 2020 11:31:49 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s14so1266789plp.4;
        Fri, 21 Aug 2020 11:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tKZ8vcbZDG4vgWba/lOpSaCf6LLl5HRskbjkaHOg2aw=;
        b=CNQWA3G8KHbyL27ElRqsO+M0tjlNk69l2E6h2/05zQRkzKdEdNx1Z8Eqd8I3fmX13P
         PHaj0ToHpXu+eJTKQdT5OD/H7Hy31oUY+58HLvQ7or3ufyYob+E9HMAKfr0hV4TnwcZv
         ERXzqbcwJeN1q2RMsW9YJv3prmufCgI5YTkdK/Nz6+oTJTaQfi7hmWVFI2y55edbrKJS
         swvjDZ5Y3YXHZR/tv4CH5z42NlPk+HkPhF2X1LVO/a5B+yKONbJ9i45IM+PDQx0hT+SB
         H72CjcWQujJEpZJhK2Luud5qR8rlZbNJ09p8CzMEMIawTw4Hv/u0U37Yw0p470Egn+cW
         GD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tKZ8vcbZDG4vgWba/lOpSaCf6LLl5HRskbjkaHOg2aw=;
        b=Y1OhifOK7lftnA8cp+hz9mp25KusMAPMKfhVnY0u57KnGD50KPrNcM2Pj4Rq2r7sci
         XTQHYfd+oBS8+h1qUOF+xU/vWlqwaTOuyAPy2HDQ8njvaGCCvXM/9Z5VcgHif5QT8j0g
         b5e6R9WGufVOZXzk6Rx9jKnaOQKw0Tn/zGk1E88KBofn+8/fB/FDSaE8yCEykBM4MXEh
         nRo9B86nVH5GP5BROwwl2AgPkh82QmXKhAEBiO5mQ6aE/kfhLwvWFGLdApgNF8kFHFpl
         zFatrNaow6veVT+zlajzOtu4Uc/RBsJrFZhH23Ibr+t8pQSj46mkFCjLx/rDRRtFjxm0
         3u7g==
X-Gm-Message-State: AOAM532Pa5zZM9pGQ6OodSTGE26+tIySLcBWLReDqHE4TPm9xmFC2WQu
        Gg5dcSsT6HHSrMrA6KSRYn4=
X-Google-Smtp-Source: ABdhPJyeyI99v87syfF2yh2gCVztBTtvL8TjtWEYuav1KpnRbjvE51/I4Dz5U7CDN+pZdmpvqcOsAA==
X-Received: by 2002:a17:90a:bf93:: with SMTP id d19mr3610854pjs.82.1598034708879;
        Fri, 21 Aug 2020 11:31:48 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y7sm2705227pjm.3.2020.08.21.11.31.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Aug 2020 11:31:48 -0700 (PDT)
Date:   Fri, 21 Aug 2020 11:31:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Juerg Haefliger <juergh@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dme1737) use simple i2c probe
Message-ID: <20200821183147.GA104874@roeck-us.net>
References: <20200821160035.590142-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821160035.590142-1-steve@sk2.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 06:00:35PM +0200, Stephen Kitt wrote:
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
>  drivers/hwmon/dme1737.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
> index c3472b73fa79..c1e4cfb40c3d 100644
> --- a/drivers/hwmon/dme1737.c
> +++ b/drivers/hwmon/dme1737.c
> @@ -2461,8 +2461,9 @@ static int dme1737_i2c_detect(struct i2c_client *client,
>  	return 0;
>  }
>  
> -static int dme1737_i2c_probe(struct i2c_client *client,
> -			     const struct i2c_device_id *id)
> +static const struct i2c_device_id dme1737_id[];
> +
> +static int dme1737_i2c_probe(struct i2c_client *client)
>  {
>  	struct dme1737_data *data;
>  	struct device *dev = &client->dev;
> @@ -2473,7 +2474,7 @@ static int dme1737_i2c_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	i2c_set_clientdata(client, data);
> -	data->type = id->driver_data;
> +	data->type = i2c_match_id(dme1737_id, client)->driver_data;
>  	data->client = client;
>  	data->name = client->name;
>  	mutex_init(&data->update_lock);
> @@ -2529,7 +2530,7 @@ static struct i2c_driver dme1737_i2c_driver = {
>  	.driver = {
>  		.name = "dme1737",
>  	},
> -	.probe = dme1737_i2c_probe,
> +	.probe_new = dme1737_i2c_probe,
>  	.remove = dme1737_i2c_remove,
>  	.id_table = dme1737_id,
>  	.detect = dme1737_i2c_detect,
