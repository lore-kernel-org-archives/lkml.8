Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2BFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205A820768
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFe9eDvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHNPOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgHNPOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:14:00 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326F1C061384;
        Fri, 14 Aug 2020 08:14:00 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h12so4673936pgm.7;
        Fri, 14 Aug 2020 08:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XSS7WdL7dEt4UqGKCmBkFa5bvmRGZIDyUv0fFwrbFAk=;
        b=IFe9eDvLv9A9WCmAt+4OWHCaSPRxZrlhITfTFpa0LyTKXV2WkVTDBJnz79jmDJ/K2t
         jUswjK3E816rd8x5TzCEXBvggIIgqCMqPScBHu0tmEVhayY4Cyaqm1Zy04W5dDr/H+oy
         Ime2KL2luXnL7KvNlsnpbvFfYNQhkt1c+YjMXaBAhNVflOTuDItBoOMf1AraiDYtsLVc
         YtYJ8wx7NC1DZwLSKGM/yZeyN2cAxZYf5LkAMOHRgn2HV/BvQAjgnQX0F9AXbfEkwJNE
         PL1Vsz/5zAfae+iN2xglr+Q/jWn0mwyYAA1b/rNlmvNpuU17tn6639Vt1lxj2MrXt1Jq
         XpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XSS7WdL7dEt4UqGKCmBkFa5bvmRGZIDyUv0fFwrbFAk=;
        b=EfkCyryuJtXhsiGKYMzmYAiVk6vyd325FHoCXvtYqgiv0dzQiQqZNGL0EUnw8EQjnX
         lf1AjtJNoXO925inSHZIr8qt/3F1DlAbqvv7KnTHwYLMLqe5vnReT8XFC4zqDWhdY18Z
         QQtZN57fQCQj8Hd9mtEtVIFqCY/AR75cZC0tVtn3KcJGNPzy6ivrhEqaa6AwIUBoISl7
         51A84q2g7QnwJKI2VCRu4sC5rHg/FT17ff4z4a+0oN2/VAPRO0dwh9IoF+ImrIoiRW4W
         HrlR9henMW208OljrgQJgfrLIEQ7VpdOQWv5tpOTcRPFH5AStb8pAlZBYvzb24c3FBjU
         CEag==
X-Gm-Message-State: AOAM531HBchI5R5/DpXm9abMImP0BrD91RBw4LK/fGhHgEgJkkACRlO6
        BRCuWbV1pRSa6jds4BwnEc9ZcbGqXk4=
X-Google-Smtp-Source: ABdhPJx/R839VL0IRTIO5koe08YOukeU6NP2R9Yn5mq5Y5Lc2LzBxq6geUhYOanzZzNbvMAdbCxDgQ==
X-Received: by 2002:a63:1a49:: with SMTP id a9mr2079119pgm.110.1597418039768;
        Fri, 14 Aug 2020 08:13:59 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f13sm9381927pfd.215.2020.08.14.08.13.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Aug 2020 08:13:59 -0700 (PDT)
Date:   Fri, 14 Aug 2020 08:13:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Beniamin Bia <beniamin.bia@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/hwmon/adm1177.c: use simple i2c probe
Message-ID: <20200814151358.GA256451@roeck-us.net>
References: <20200813160958.1506536-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813160958.1506536-1-steve@sk2.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 06:09:58PM +0200, Stephen Kitt wrote:
> This driver doesn't use the id information provided by the old i2c
> probe function, so it can trivially be converted to the simple
> ("probe_new") form.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

I'll apply the entire series, but please don't use entire path names
as tag in the future but follow bubsystem rules.

Thanks,
Guenter

> ---
>  drivers/hwmon/adm1177.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/adm1177.c b/drivers/hwmon/adm1177.c
> index d314223a404a..6e8bb661894b 100644
> --- a/drivers/hwmon/adm1177.c
> +++ b/drivers/hwmon/adm1177.c
> @@ -196,8 +196,7 @@ static void adm1177_remove(void *data)
>  	regulator_disable(st->reg);
>  }
>  
> -static int adm1177_probe(struct i2c_client *client,
> -			 const struct i2c_device_id *id)
> +static int adm1177_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct device *hwmon_dev;
> @@ -277,7 +276,7 @@ static struct i2c_driver adm1177_driver = {
>  		.name = "adm1177",
>  		.of_match_table = adm1177_dt_ids,
>  	},
> -	.probe = adm1177_probe,
> +	.probe_new = adm1177_probe,
>  	.id_table = adm1177_id,
>  };
>  module_i2c_driver(adm1177_driver);
