Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DE8C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1ED52067D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKMkfiD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgBWDIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 22:08:09 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35670 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgBWDIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 22:08:09 -0500
Received: by mail-pg1-f195.google.com with SMTP id 7so1071040pgr.2;
        Sat, 22 Feb 2020 19:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L8rbrZA8d9M2bUXip/mtfy2g9mjJeidmY8X9/9kPSJM=;
        b=JKMkfiD0UFIxKKhXqwLNb79QW1bAmKWH9ZhcG/YFnRrqINosVquTBsdBog839oSz3Q
         sL1CckOy2+OSIiyQto9bWM/OrZPOJJ9OdF2/Qs/fY7AasanKWWqR4c3ssheRU8szMNX1
         X9YPKgzcHMV5x97gFbvg4mKqz4YTt4JkT4vy4VjLB+jCzaZAk1lnVpViJ/0mCbumHzqV
         ebD48b8laRFaZ8ZWzvF38Z0+1rz2b1DzhAF2klJyUBbdNcT4lmVp/CcGFISiXmG8D8Q9
         NbDplUqrVNfJd/KqKvt4olvTqfN1nOjC+rjV8YWTLvvjyDT1bvKJUEdUm0K1O85Jhrh5
         m1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L8rbrZA8d9M2bUXip/mtfy2g9mjJeidmY8X9/9kPSJM=;
        b=j1t/62FPmNmC2dZ9zTs6gvmJiEFaXYAh4i+UDWEDv0WqDYOY644XgbLqNqU60lhqFR
         EdCUYxLr1XjcR8hbL2q0Mr7JpysQm90vfqHSDVw4Ctv/rtbA2YoV3aDyvrv+gmjOIW8A
         8f5IU5FUf6dl3KmHA/z0Uq5VKVTa6zm5S3mYxRWL5DseOHIZgYjh14/RRvPN58kPFwAa
         D47DnW356K5fxqnM5BAjmeLOaEwJNCm2KG43+ccJEaKy8VH5Pzb8Gprc6gH9ECqHaHyL
         zEDA+GjhT1oRB2shGiMS+OiaXeUnIAJgGt25SKWpc1YBvIAJ0DH8NFziIo7G9ETV1AW1
         p4iA==
X-Gm-Message-State: APjAAAWBRCoNXwx32ZeXZSoZd5RCNKz1TY9K5Tkp2n5JACaK91Im1CVG
        KVKMI0JEFrbfyuMyWti0/cYllWccIhY=
X-Google-Smtp-Source: APXvYqz14HB6+ohogoFMvLIOf5V9rLoSIvKeD9epby/QGvO8EEdyBRjgAJoTJ3H1YR1apy+9ncw6ig==
X-Received: by 2002:a62:7945:: with SMTP id u66mr45890032pfc.82.1582427288589;
        Sat, 22 Feb 2020 19:08:08 -0800 (PST)
Received: from [192.168.1.5] ([110.77.154.179])
        by smtp.googlemail.com with ESMTPSA id gc1sm7277305pjb.20.2020.02.22.19.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 19:08:07 -0800 (PST)
Subject: Re: [PATCH] Support Castles Vega5000 PoS terminal USB
To:     Ondrej Jirman <megous@megous.com>, linux-usb@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200222233202.237967-1-megous@megous.com>
From:   Lars Melin <larsm17@gmail.com>
Message-ID: <9d9263a0-cddb-0efb-46a5-1d223a8232e3@gmail.com>
Date:   Sun, 23 Feb 2020 10:08:04 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200222233202.237967-1-megous@megous.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/2020 06:32, Ondrej Jirman wrote:
> This terminal's USB port needs NO_UNION_NORMAL quirk to work with
> cdc-acm driver.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>   drivers/usb/class/cdc-acm.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> index 62f4fb9b362f1..8577441c81a4d 100644
> --- a/drivers/usb/class/cdc-acm.c
> +++ b/drivers/usb/class/cdc-acm.c
> @@ -1739,6 +1739,9 @@ static const struct usb_device_id acm_ids[] = {
>   	{ USB_DEVICE(0x22b8, 0x2d9a),   /* modem + AT port + diagnostics + NMEA */
>   	.driver_info = NO_UNION_NORMAL, /* handle only modem interface          */
>   	},
> +	{ USB_DEVICE(0x0ca6, 0xa050), /* Castles Technology VEGA 5000 */
> +	.driver_info = NO_UNION_NORMAL, /* reports zero length descriptor */
> +	},
>   
>   	{ USB_DEVICE(0x0572, 0x1329), /* Hummingbird huc56s (Conexant) */
>   	.driver_info = NO_UNION_NORMAL, /* union de

This quirk is in the driver since almost a year ago.

br
/Lars

