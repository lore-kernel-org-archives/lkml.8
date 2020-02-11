Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07E3C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CBA20848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy4ePc0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbgBKQjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:39:13 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37333 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbgBKQjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:39:12 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so1464591pjb.2;
        Tue, 11 Feb 2020 08:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b5SWMMkJOd/6WCjohw4ec3oXVDA3cc/tfQSWjqNAn/k=;
        b=Vy4ePc0nmBwtSpe2cs/4Ul4iDsNg6N7bc/SK+figGy/l9SVtogqnjXYvGTLXsmyo40
         jRzkP6aTk4echAqPd+Fux6uExsVWmnMLF/jp2JgtPGp46Bf7g6MUc1IjDAzonEosGVwH
         ZA1joxtUK61iXCKj2amtxUCvCJYT/vNMc+OhdA5FRKeCOD1qurIPhGmRXc4N0YOXqLgj
         JPvmtw10jYDSXnCvKcaDK7Gn5PI/w6LN8tLnA8lfKr8lD5SaCGrm1HjpyC5zM9DBq8k6
         zEjc91Qop2Fnl32R69LsJusylLG+gRjdQHPFqFzbyqsumXe+v2DxK/Cc871C984jbVKk
         JmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=b5SWMMkJOd/6WCjohw4ec3oXVDA3cc/tfQSWjqNAn/k=;
        b=ZfhoH6wLwfShINRIQFNNvPqqATA1ShiPXyTaikU4tsonFkiPhTRKG7j/UEBhRer204
         ICv34dB4aHjx/O6YxTRKfl6kWmsK/LI/uI0uV6+jzr9h18jtPO8N5MqTX9xz/jaaraei
         FzoBv2exrztcSoGxyWHtBrF9E0/4NV4yLYKz1Cp4mHcbMzpPYbPFp1Ll8CenEzXZb0Vo
         A7Z+9nMplyeMTe6g6QThdfdTuuLqt/9wZLiPxb0qpzSpM92m5gzgnQGZ+kosGO3tjkBd
         LUNudPvEzblFyb6tlIE+SQRPF1S+tKXbeqMKEjQ52a6/twVHsPTpLAT4Ie4KOh8MRiZz
         82uw==
X-Gm-Message-State: APjAAAWK9YBfCWwz9RxFaggp7413Y/z4IhA2u55ky+veNmE+gOUgZ1E0
        Evgq4Nag9DqRhaT5SbgmyTikK0Bp
X-Google-Smtp-Source: APXvYqwIewJIKXckCSq0MvZkIQaU4p16PRmxkgrFLcOQqIkZOG0FcWhRxrjqw+6XMtCu19kM5aQjtg==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr4487379pjz.135.1581439151751;
        Tue, 11 Feb 2020 08:39:11 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s124sm5086820pfc.57.2020.02.11.08.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 08:39:10 -0800 (PST)
Date:   Tue, 11 Feb 2020 08:39:10 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] hwmon: axi-fan-control: fix uninitialized
 dereference of pointer res
Message-ID: <20200211163910.GA2975@roeck-us.net>
References: <20200211162059.94233-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211162059.94233-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 04:20:59PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the resource pointer ret is uninitialized and it is
> being dereferenced when printing out a debug message. Fix this
> by fetching the resource and assigning pointer res.  It is
> a moot point that we sanity check for a null res since a successful
> call to devm_platform_ioremap_resource has already occurred so
> in theory it should never be non-null.
> 
> Addresses-Coverity: ("Uninitialized pointer read")
> Fixes: 690dd9ce04f6 ("hwmon: Support ADI Fan Control IP")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

This has already been fixed by removing the message (and the
then unused variable). The message was useless anyway since
it printed the remapped address with %p.

Guenter

> ---
>  drivers/hwmon/axi-fan-control.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hwmon/axi-fan-control.c b/drivers/hwmon/axi-fan-control.c
> index 8041ba7cc152..36e0d060510a 100644
> --- a/drivers/hwmon/axi-fan-control.c
> +++ b/drivers/hwmon/axi-fan-control.c
> @@ -415,6 +415,9 @@ static int axi_fan_control_probe(struct platform_device *pdev)
>  	if (!ctl->clk_rate)
>  		return -EINVAL;
>  
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
>  	dev_dbg(&pdev->dev, "Re-mapped from 0x%08llX to %p\n",
>  		(unsigned long long)res->start, ctl->base);
>  
> -- 
> 2.25.0
> 
