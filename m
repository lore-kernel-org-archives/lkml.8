Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4B2C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06493206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sS5qUOfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgDURVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbgDURVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:21:21 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2927BC061A41;
        Tue, 21 Apr 2020 10:21:20 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j7so3486957pgj.13;
        Tue, 21 Apr 2020 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ugtg5hHpJFG35qHHQCnbS1MFWmfROkCZGRcRHzPASYg=;
        b=sS5qUOfbkv48i8UKD7QbuYoz6NO+vv9wkELxwAJNYaaOFnRNYBrlUwNjqqBxAtawwA
         YbRUyrffYN1I5K5cEg8/h7z2cXlMx7mD5xjMsKQ5oJwhR3gbl8/QxSEMMj+6iNLlcOmS
         6bKSCqcAgi7QciaGB+uRCBUnSMQwAlSIjdfbOq3iqWxwQnEfCOke72xy5YBlzG0qK7sI
         O/6Nr2nrAsBs5IFMONeB5zzVr680L5JLuSUXf/umCgpNP3HZFqiBDACXlQ/1q1ON8jnA
         hiFHbOsz5gJK9d+mgC71tEgcnKt0ZFZGK3xKExFvI2EHHt4oEGjS3jqEzUFnZrUkULgB
         YL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ugtg5hHpJFG35qHHQCnbS1MFWmfROkCZGRcRHzPASYg=;
        b=J00CT+5tKYvaNujKL15BKtfoCIoc2uJ9hGdIMqccv6XMMr/Ef1Htn2O28Hr3lUJYpk
         dZQzedYFan0uO2ujwZh16K6ez+JsGHRVulOErVWDSx4T/B/sCd0otk9V4dST1B4fylJv
         ZN3AKOXxtE4zy+10tCdEfsFIHAko/AhmLyjb4eeNcvEju+1kQNDfiJSxZKNUtNDA4Orq
         On8B/IDdBLJhB4EkFP98ixb+1AeEcZxs1FJ3B+xW8uNayydU2moyqm4unxjtS3mEXgcO
         /A5qiJvQuBs44IbxD0CsmxqP9LP/bSLGtuVzltEkv7jAYPO/F4SWMShUZBq2N2lLC8Bu
         HjEg==
X-Gm-Message-State: AGi0Publ23AVmSRFmcmKprG9c4YoQyB9OajeR+/fx7y4mQb3lgUU4l6M
        4iI45vKOox85tOhS0VHBnCA=
X-Google-Smtp-Source: APiQypJ93iOmcQRIEJQVE+px4eeCYWBzb9IOA+IXbz+Gzs3J+soATOjbpmk8tT2rvNN53eTJEfwUbg==
X-Received: by 2002:a63:d454:: with SMTP id i20mr22228409pgj.209.1587489679728;
        Tue, 21 Apr 2020 10:21:19 -0700 (PDT)
Received: from [10.230.188.26] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 23sm2871247pjb.11.2020.04.21.10.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 10:21:18 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] net: macb: fix call to pm_runtime in the
 suspend/resume functions
To:     nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        harini.katakam@xilinx.com
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        sergio.prado@e-labworks.com, antoine.tenart@bootlin.com,
        linux@armlinux.org.uk, andrew@lunn.ch, michal.simek@xilinx.com
References: <cover.1587463802.git.nicolas.ferre@microchip.com>
 <1c537d1287aaf57b8b20a923686dbb551e1727f0.1587463802.git.nicolas.ferre@microchip.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1bd761fc-5eeb-bef5-5a6b-86d67fed3a7f@gmail.com>
Date:   Tue, 21 Apr 2020 10:21:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1c537d1287aaf57b8b20a923686dbb551e1727f0.1587463802.git.nicolas.ferre@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/2020 3:41 AM, nicolas.ferre@microchip.com wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> The calls to pm_runtime_force_suspend/resume() functions are only
> relevant if the device is not configured to act as a WoL wakeup source.
> Add the device_may_wakeup() test before calling them.
> 
> Fixes: 3e2a5e153906 ("net: macb: add wake-on-lan support via magic packet")
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Cc: Harini Katakam <harini.katakam@xilinx.com>
> Cc: Sergio Prado <sergio.prado@e-labworks.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
> Changes in v2:
> - new in v2 serries
> 
>   drivers/net/ethernet/cadence/macb_main.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 72b8983a763a..8cf8e21fbb07 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4564,7 +4564,8 @@ static int __maybe_unused macb_suspend(struct device *dev)
>   
>   	if (bp->ptp_info)
>   		bp->ptp_info->ptp_remove(netdev);
> -	pm_runtime_force_suspend(dev);
> +	if (!(device_may_wakeup(dev)))
> +		pm_runtime_force_suspend(dev);

Only if you need to respin, the parenthesis around device_may_wakeup() 
are not required:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
