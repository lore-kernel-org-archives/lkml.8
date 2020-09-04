Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6521C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9731C2064E
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYMIgsum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgIDQk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgIDQkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:40:51 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167DEC061244;
        Fri,  4 Sep 2020 09:40:51 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u128so4899344pfb.6;
        Fri, 04 Sep 2020 09:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wxaOHZ/W1bVPPlxPYI5KsnVzXfiQ47igg0n361NfZVU=;
        b=YYMIgsumLdhBj/Uz4ivpuN1T8qckEYHF5ibmSzT6XM8nIJeoLtEfMPAwstTBRyx8ux
         XzRWyjQsIDt1vRYxng/Kb4Q4jaMy8HWc+0LYoEgbGY7qvRxh2MI7prC+4B7wX/LPK2Bf
         5EhGX0jH48u9WUNq2eo7zEOYU9VhKlSaMTnLsojzC8CUnK9hogywvDpdQco0tdkSi6An
         LqFNvRaOo36VBS4w6mpwOM92+J5i1dolqU0jO3dmLbMzSj4uU1XZ71BYAV8Xyxttv4LY
         KAwcI569arZ6HeP++Atg/6h9k5GKUD7GIxKCFwHMLaxZbvocWcWn7SDBEWihIwZ/0nxn
         VjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wxaOHZ/W1bVPPlxPYI5KsnVzXfiQ47igg0n361NfZVU=;
        b=FasfeJF3U2l5dt9y8Y4Ba7301hU6v9D2pM3gtFkEvJBUvKALBWGQkOEg0wPOn4Hq4n
         ZSo4WknWA28vtC0nj8zqDKUtggZHiRb7cZo62wfgHocB7dlCs4VMI021g+bA2JQecCIP
         voJ6bu2dxhnRMBtxB1viNCKA4d6p026kkv6fobHPXeGo0WtRDLIZACFH69EYFe+1rLhH
         9tp/TRK7g0DMztYw3iNImlcJXaB1zM6e3D+uI/UzivQCwOapEQjYt561l3LzDBXsiYIb
         DwfZehPlL0Bq802aPX1Trl5sGGWywc/+wFA6xjMuxTx5Wx8m+AVtcqxstxEfHU9dN0bj
         6DmQ==
X-Gm-Message-State: AOAM530vwSTT/FAXoiZyTvCbUjqrHtPbEPGjpj1nps8LsqiC8NKpVlDn
        sqbL+HCxA77wfVLzSC8+Om8=
X-Google-Smtp-Source: ABdhPJyxnXlyyApI5AYlSrIq+cwIZjdS/B/NM81GNpsZ9HImOzNeZz5Q3xFV/SocTAxCWUFC6shKug==
X-Received: by 2002:a63:f09:: with SMTP id e9mr7987808pgl.334.1599237650528;
        Fri, 04 Sep 2020 09:40:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j19sm7105220pfi.51.2020.09.04.09.40.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Sep 2020 09:40:49 -0700 (PDT)
Date:   Fri, 4 Sep 2020 09:40:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: sparx5: Fix initial reading of temperature
Message-ID: <20200904164048.GA74175@roeck-us.net>
References: <20200903134704.8949-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903134704.8949-1-lars.povlsen@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 03:47:04PM +0200, Lars Povlsen wrote:
> If the temperature is read before the internal calibration is
> completed, the driver returns -EIO. Instead it should return -EAGAIN
> to encourage repeating the operation.
> 
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>

Applied. I added a note stating that I would prefer -ENODATA, and why,
but that this is not feasible due to thermal subsystem requirements. 

Thanks,
Guenter

> ---
>  drivers/hwmon/sparx5-temp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --
> 2.27.0
> 
> diff --git a/drivers/hwmon/sparx5-temp.c b/drivers/hwmon/sparx5-temp.c
> index 1a2b1026b026..98be48e3a22a 100644
> --- a/drivers/hwmon/sparx5-temp.c
> +++ b/drivers/hwmon/sparx5-temp.c
> @@ -56,7 +56,7 @@ static int s5_read(struct device *dev, enum hwmon_sensor_types type,
>  	case hwmon_temp_input:
>  		stat = readl_relaxed(hwmon->base + TEMP_STAT);
>  		if (!(stat & TEMP_STAT_VALID))
> -			return -EIO;
> +			return -EAGAIN;
>  		value = stat & TEMP_STAT_TEMP;
>  		/*
>  		 * From register documentation:
