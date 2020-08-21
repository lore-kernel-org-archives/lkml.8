Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEDCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D87320724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJQpigmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHUSg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUSgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:36:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E777C061797;
        Fri, 21 Aug 2020 11:27:47 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mw10so1174829pjb.2;
        Fri, 21 Aug 2020 11:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8xc10arX40icxxQcUsOxR4h/Lwk3EmXkYYk/LGjN5Rs=;
        b=LJQpigmSBCDcm8qAm0XRvGg/2ZtEUEX0Y0+v2XbGnMiD6A464yzdzhMlozIAzPUQea
         WMwKak5n1qFA3dLoijjuE4mvSqWexBb6pEw+926GqFZwvdw3ku5NAWYsT7VI5SIpNUbI
         uNQQEmr6U+9/Aq3xirXEtUU2g0Cco+jxv9I+oDr8H5XCK9Yu1rG3Knh6t+4L5OfGAAKb
         8han44H2xAlv0XcQ80XBDQ6dnEabrxQk1/Q26YleBMQRGYLp8ly34OR5d7PFm9OyxPcF
         PjLKydbgvxngq7hPGv+PRZ/xHhxFVKmX40rM8y8z+AOB0KW+sJ/CDA05cSVl0GgmMW13
         xCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8xc10arX40icxxQcUsOxR4h/Lwk3EmXkYYk/LGjN5Rs=;
        b=PkuHIKzCwL0OAKOxyX9V4lpA68Gk7ct8qokaQVEE+/LfSoloG5fCJ17vmFiB+LyQt1
         9GI8AQ7qtJBm68vn7tt6WBVyEsQdVec/4BXKa2WAjAWJR+5urtlhiZTA/Q2PRslkf46l
         z8/guzCRUxYfPWMEyTAA77WpMHtYgdvmp25NVppGMB1DBaDjxKjji0Vi19e25W7ohxfY
         sbIuYDv9JRJHFiYV54VRVRkjzNbvy45V4f/6u5iOvwQNLYqG02ivqd0L5VKJAeG/Z1yV
         mMyxfoM1m/g5WKkvRzqj1RqqcrVCz7kYOfggSCtLGillI1zH0Q6rS3qBXoHpv35zaMao
         ZvbQ==
X-Gm-Message-State: AOAM530NaSirGjyadw3iPQBcWS9vQOGvd7GW3+MwR8xScxmAhlWsozZf
        ykdjHxRjWsGGzloy08azN/w=
X-Google-Smtp-Source: ABdhPJzONm6RAFMCRqyPKAERTFjMbnDq63hbFRpSlL8f3fkbfMyAJgQGgrBGSKC2NyF9Jy0JwbUESw==
X-Received: by 2002:a17:90b:110a:: with SMTP id gi10mr3477473pjb.206.1598034467071;
        Fri, 21 Aug 2020 11:27:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v11sm2648184pgs.22.2020.08.21.11.27.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Aug 2020 11:27:46 -0700 (PDT)
Date:   Fri, 21 Aug 2020 11:27:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jason Baron <jbaron@akamai.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct7904) Correct divide by 0
Message-ID: <20200821182745.GA236235@roeck-us.net>
References: <1598026814-2604-1-git-send-email-jbaron@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598026814-2604-1-git-send-email-jbaron@akamai.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 12:20:14PM -0400, Jason Baron wrote:
> We hit a kernel panic due to a divide by 0 in nct7904_read_fan() for
> the hwmon_fan_min case. Extend the check to hwmon_fan_input case as well
> for safety.
> 
> [ 1656.545650] divide error: 0000 [#1] SMP PTI
> [ 1656.545779] CPU: 12 PID: 18010 Comm: sensors Not tainted 5.4.47 #1
> [ 1656.546065] RIP: 0010:nct7904_read+0x1e9/0x510 [nct7904]
> ...
> [ 1656.546549] RAX: 0000000000149970 RBX: ffffbd6b86bcbe08 RCX: 0000000000000000
> ...
> [ 1656.547548] Call Trace:
> [ 1656.547665]  hwmon_attr_show+0x32/0xd0 [hwmon]
> [ 1656.547783]  dev_attr_show+0x18/0x50
> [ 1656.547898]  sysfs_kf_seq_show+0x99/0x120
> [ 1656.548013]  seq_read+0xd8/0x3e0
> [ 1656.548127]  vfs_read+0x89/0x130
> [ 1656.548234]  ksys_read+0x7d/0xb0
> [ 1656.548342]  do_syscall_64+0x48/0x110
> [ 1656.548451]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/nct7904.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index b042569..242ff8b 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -231,7 +231,7 @@ static int nct7904_read_fan(struct device *dev, u32 attr, int channel,
>  		if (ret < 0)
>  			return ret;
>  		cnt = ((ret & 0xff00) >> 3) | (ret & 0x1f);
> -		if (cnt == 0x1fff)
> +		if (cnt == 0 || cnt == 0x1fff)
>  			rpm = 0;
>  		else
>  			rpm = 1350000 / cnt;
> @@ -243,7 +243,7 @@ static int nct7904_read_fan(struct device *dev, u32 attr, int channel,
>  		if (ret < 0)
>  			return ret;
>  		cnt = ((ret & 0xff00) >> 3) | (ret & 0x1f);
> -		if (cnt == 0x1fff)
> +		if (cnt == 0 || cnt == 0x1fff)
>  			rpm = 0;
>  		else
>  			rpm = 1350000 / cnt;
