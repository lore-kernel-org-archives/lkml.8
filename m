Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54804C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39DB420720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOjcfMhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgHUSbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgHUSbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:31:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075B2C06179B;
        Fri, 21 Aug 2020 11:31:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y10so1250470plr.11;
        Fri, 21 Aug 2020 11:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fs0kdQgLFops5C+Q5YuWanPWdeCPY1nAvwr21o3lh9E=;
        b=pOjcfMhi9NIQKBZ6ypeUifTHdrqrhUSBM3X5AWK9Xkbjel5xQNQqGuLm2C3t3TN9bj
         Zx44C4kaA3IAUpB4bbXgTLb62Evet1+fBdUCP2hRLkKFk7y9iUmSxrM2xA6LiUThJL+I
         mf2ov2uLvp3U7KW+u+USVo/RUcUeBcCSLPuR+eKnRQBtJ/owkHll6SSQoYnb40dkMkvx
         B24HSyxoeJgCgRrOzrAi2hfzZLsmj3Y03XZ0W+B9fmO38hNUv6CD8O0oKVs6xbWJCxO1
         HRqBuoQITmR/GejEbp2QaJIp2c+3qIpb3YFvhMZadjDRghJoyR6fAQMDEiCwrtRwj2hi
         Wq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fs0kdQgLFops5C+Q5YuWanPWdeCPY1nAvwr21o3lh9E=;
        b=NSEu42qUdPx/3sGjFwzFW1+nqJ7J9SSGFR1f1mDO5UjEgI9qpu9xtEFXyEXg5hPTfW
         9NWRi+qXpHulq2J33tCyyZ6RgxxNkdyOUP2tnyseWV5C5eq5CvRgPnVWkieXsHWx69Aa
         h8PgjCvGhgScLjOKfv1QqbOMgV8CuwLIVu1jpj9E4mcgEaBmSpntv/n2gcuCZKmhtwOH
         VfGK6R9U2He9Od/r1qWVIRnaXZK3oR7XMnnUCUpoBIjeQ8ykKWlRy/DJ39Hpdq1FsyoU
         1RNyxJj6cugZM0uZtV51qFJpFewzCNQpJ5FG3wfgeIhpF3S8lW9rZDFe7hOIi1FW2gqG
         Zhdw==
X-Gm-Message-State: AOAM533q1TbV7bDjkmTxe20/YAOhQPe4OkCTKz4LB1SGLB/WSY6druaA
        cpIOr2+VIlO/e+G2PEfjE+4=
X-Google-Smtp-Source: ABdhPJwCMvLZ8gso1ZPwMBsuitV3m26hGK4fikp7rhuUhZwxSIsy7HDZtvYonJj2lr4Lti1NSyuH/g==
X-Received: by 2002:a17:902:728c:: with SMTP id d12mr3300178pll.141.1598034666575;
        Fri, 21 Aug 2020 11:31:06 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k125sm2848682pga.48.2020.08.21.11.31.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Aug 2020 11:31:06 -0700 (PDT)
Date:   Fri, 21 Aug 2020 11:31:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Riku Voipio <riku.voipio@iki.fi>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (f75375s) use simple i2c probe
Message-ID: <20200821183105.GA74215@roeck-us.net>
References: <20200821160159.591293-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821160159.591293-1-steve@sk2.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 06:01:59PM +0200, Stephen Kitt wrote:
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
>  drivers/hwmon/f75375s.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
> index eb847a7d6b83..3e567be60fb1 100644
> --- a/drivers/hwmon/f75375s.c
> +++ b/drivers/hwmon/f75375s.c
> @@ -113,8 +113,7 @@ struct f75375_data {
>  
>  static int f75375_detect(struct i2c_client *client,
>  			 struct i2c_board_info *info);
> -static int f75375_probe(struct i2c_client *client,
> -			const struct i2c_device_id *id);
> +static int f75375_probe(struct i2c_client *client);
>  static int f75375_remove(struct i2c_client *client);
>  
>  static const struct i2c_device_id f75375_id[] = {
> @@ -130,7 +129,7 @@ static struct i2c_driver f75375_driver = {
>  	.driver = {
>  		.name = "f75375",
>  	},
> -	.probe = f75375_probe,
> +	.probe_new = f75375_probe,
>  	.remove = f75375_remove,
>  	.id_table = f75375_id,
>  	.detect = f75375_detect,
> @@ -814,8 +813,7 @@ static void f75375_init(struct i2c_client *client, struct f75375_data *data,
>  
>  }
>  
> -static int f75375_probe(struct i2c_client *client,
> -		const struct i2c_device_id *id)
> +static int f75375_probe(struct i2c_client *client)
>  {
>  	struct f75375_data *data;
>  	struct f75375s_platform_data *f75375s_pdata =
> @@ -832,7 +830,7 @@ static int f75375_probe(struct i2c_client *client,
>  
>  	i2c_set_clientdata(client, data);
>  	mutex_init(&data->update_lock);
> -	data->kind = id->driver_data;
> +	data->kind = i2c_match_id(f75375_id, client)->driver_data;
>  
>  	err = sysfs_create_group(&client->dev.kobj, &f75375_group);
>  	if (err)
