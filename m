Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD71C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D3620738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7sMELSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbgFWODz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732657AbgFWODz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:03:55 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA3DC061573;
        Tue, 23 Jun 2020 07:03:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e18so9917968pgn.7;
        Tue, 23 Jun 2020 07:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6R83pORfdf/wJr8RyQJOxegbwUgKh9RS022V0+W7EBQ=;
        b=o7sMELSCYSiWeznPvJwXMW7LjkWfDlhuw9OemNl9zxUAoLe2n3Qp4k9CtsU1UQ3Klx
         VBpjv+gh1vVH8eIMcJdQ0OU+w21KMtKOA3YbM1ldme6n3K9pho4k2uzJA5BdFd0kyN+s
         U/JYcUQxZb3MgCrvWIOwu0nPwrOCgHJarb2kaTGnHo2z9vRZl7Ospdqhyb09aQV51yhs
         3Yzs5GIPfAG2XveIHXCk5DSr52k/1am0Y/mAyoZJaAiary4pgHg+Y0n1rqfinJXPHP6M
         4pqxl/u5VkjBLjUXXV4SwIEq5JD0l234vcgEGep5ZZo/CAOi0xJpXOYXnOsBIPGlym1j
         zhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6R83pORfdf/wJr8RyQJOxegbwUgKh9RS022V0+W7EBQ=;
        b=EhvpH5fmsVCwZ8bi61UrXHr4Rg7L+5KOp+r97FhRQa8o9szjzp6kc+pFBjJ0FuFdIS
         MjbESleIDkw9q9dHPZ3TA1dzhfOnHNBfTNjHMiXilsO7NEDo0FPgb0bwjod2m851ykwz
         b1YE8TIEym9f3JXRhBq1tOH679DcQ8Our28J5wbWb7tix9wbuWivWMbttnTqIlQktslu
         zkCQ+SaJuNkI4eP2jY6vcEjszXlmWW7Ozvv+8tDHH/D+IiCq0Ns5jcVfF5RlvTFrD83h
         EksuAYZBijJAxYC7tKWHu2JiGQD3H6kRWK3u2yEQjugdO5vSLYT4RV+4W/istGt/yZKM
         Gvfg==
X-Gm-Message-State: AOAM531ZPAXBc/0235rFjiuh97e80itAYlSWb31XZRogQQI09hGCKmnb
        rFINiFgdoqmJjN4NSLTpfV0=
X-Google-Smtp-Source: ABdhPJymarHvJTFBEOBMvtrsO2v/8zYDPFqPpK5YPPLjKkwlLG3nLnJn8YfU18YeJIdkxBRZhqX11g==
X-Received: by 2002:a63:e00f:: with SMTP id e15mr17918347pgh.447.1592921034470;
        Tue, 23 Jun 2020 07:03:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a17sm2561681pjh.31.2020.06.23.07.03.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jun 2020 07:03:53 -0700 (PDT)
Date:   Tue, 23 Jun 2020 07:03:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jeffrey Lin <jeffrey@icurse.nl>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH v2] hwmon: (dell-smm) Add Latitude 5480 to fan control
 whitelist
Message-ID: <20200623140352.GA101658@roeck-us.net>
References: <20200621045246.929649-1-jeffrey@icurse.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200621045246.929649-1-jeffrey@icurse.nl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 12:52:48AM -0400, Jeffrey Lin wrote:
> This allows manual PWM control without the BIOS fighting back on Dell
> Latitude 5480.
> 
> Signed-off-by: Jeffrey Lin <jeffrey@icurse.nl>
> Acked-by: Pali Rohár <pali@kernel.org>

Applied.

Thanks,
Guenter

> ---
> 
> The last email should have been labeled v2, apologies for the noise.
> 
> Changes in v2:
> - Added Pali's Acked-by
> 
>  drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 16be012a95ed..ec448f5f2dc3 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1187,6 +1187,14 @@ static struct dmi_system_id i8k_whitelist_fan_control[] __initdata = {
>  		},
>  		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
>  	},
> +	{
> +		.ident = "Dell Latitude 5480",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude 5480"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +	},
>  	{
>  		.ident = "Dell Latitude E6440",
>  		.matches = {
