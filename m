Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7B9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 03:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3144520885
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 03:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bz66Q8Av"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgHQDJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 23:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgHQDJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 23:09:09 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A05FC061388
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 20:09:09 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x25so7538453pff.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 20:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k0k1ufswwvQqlhfc5nLZm/JdhT9rudIpJBeiiTryuvI=;
        b=bz66Q8Av14jmfKp4MtM8VmcuJu3xbFqx+cwOenX2OPH0WxtKGARCq3MHKtfnePrfko
         NPNRFZSrlZaqgj0i35VnkZE7Q4S6qJsGq7OSumaMjorNdX2uYarD8dE89Pk20Z2W3tO4
         eDW4NijWVHK6LB6JeTg7/wj59gk8ZblIq/UTEXvzEpHD3VhzlDVPs0mFVY9bvC3oUHkr
         I91gKr3zbf24z1VESIv+TgOCTYispv9r+II3V01sxKp3x9szhVU0eSLvHMJVu8Blg2do
         ZQ60uvWD/9Qk2FLNyhcAeuKIrDDhMvwsdXjW+5dq6ii1SK5oHgO0gVLb4rWqS0dQx9Hi
         NaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k0k1ufswwvQqlhfc5nLZm/JdhT9rudIpJBeiiTryuvI=;
        b=NSA+lwdz1FxOtfsoFnhAijZ3qiBiLnz+aD2hJuA3T9Xw5rJ6d4BXf2ZdSznegl4w+Z
         nqQgQNT48EZhsxCYGbzaoyUdMbEiIJkIJ7sxgYCpuarZHqBUgBI4mnX9WXnoavjHl/ai
         8CewMAvjPLKNr13Z+BKI2e2bN+ZiMf6PdbErJLGbPs8LQpRfKhT0oDoViHPmXI7J2YOO
         i+FBDvJNXl+1NGPXBNNvHdHdWEsbhiZKBR42S4u6uQzOLANqNJDIl5cYB76dCJxwOXjW
         LX96Ru7pVgHaXYV5vnOFz/Vzd0wOsmgIucB9uSKz3mErm5ooyJCTc8HR1FiqTpjkdPPf
         WAag==
X-Gm-Message-State: AOAM530mjnxIeGVrOiCJpWz68E5w6O49jD9tBS2NWLaa9t/TUqVqa7gr
        pihh3dOMb//PhjH7lyA/v4MiBxVJsR9cLg==
X-Google-Smtp-Source: ABdhPJz/bi2nU4yddK5D5WoB9ZR5r+QGieKD/y6Z9tJUYP1qdCQuJXA//jJNqogDDY0Ut6KtcpQtLw==
X-Received: by 2002:a05:6a00:150c:: with SMTP id q12mr9844126pfu.296.1597633748519;
        Sun, 16 Aug 2020 20:09:08 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ea1b:63b0:364:3a3b? ([2605:e000:100e:8c61:ea1b:63b0:364:3a3b])
        by smtp.gmail.com with ESMTPSA id jb1sm15850532pjb.9.2020.08.16.20.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2020 20:09:07 -0700 (PDT)
Subject: Re: [PATCH] ata: ahci: use ata_link_info() instead of
 ata_link_printk()
To:     Xu Wang <vulab@iscas.ac.cn>, linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200817011854.9668-1-vulab@iscas.ac.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e64e363a-55e5-7a71-ced7-fd28fc32aaa8@kernel.dk>
Date:   Sun, 16 Aug 2020 20:09:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817011854.9668-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/20 6:18 PM, Xu Wang wrote:
> Using ata_link_info() instead of ata_link_printk().
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/ata/ahci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 0c0a736eb861..9d72d907b4ee 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -807,7 +807,7 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
>  				(sstatus & 0xf) != 1)
>  			break;
>  
> -		ata_link_printk(link, KERN_INFO, "avn bounce port%d\n",
> +		ata_link_info(link,  "avn bounce port%d\n",
>  				port);

Why not collapse that into one line as well when making that change, as
it now fits just fine?

Apart from that, looks fine to me.

-- 
Jens Axboe

