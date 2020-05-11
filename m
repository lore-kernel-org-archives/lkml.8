Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05AAC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF19206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fua0UGkm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbgEKQv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgEKQv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:51:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3FEC061A0C;
        Mon, 11 May 2020 09:51:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m7so4173071plt.5;
        Mon, 11 May 2020 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a45zQ4dwEmlbf8HYJN+kcAE96lnl2unThzvDupXevx4=;
        b=Fua0UGkmeWejN8Fn12t8uUSafJlCMNTP1nHqmy7/90MdxBhm1w9QFKKSV038yuD2xN
         Zz6UO1CA7RwcothBymZil/Bn874WFyOHMw+gP2Iyr/NoDfJwtxx9cYzGaui9y6V3LKlc
         rW+7BB0Tmu5LzHw9micpHmnFwXjzaI5OP6LYKtzmefR9OoezXkrIou+CTLoQzH3xxW3V
         4OzP5NUOg2UJRXenOau8E10zrixIvq1G0tZgLGurR7F9lFETS/CGfJsnb8yx1odekPgt
         VAB9qBW7iuSkUrolosEPOPN5Uw7RjMcS3oUo7LrGq8trz/4lf8faY41b9TK5P486tbSl
         1kEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=a45zQ4dwEmlbf8HYJN+kcAE96lnl2unThzvDupXevx4=;
        b=KcNznYpaDIHdbUj2aC6nhJK9uWvcEPzNSLrg2H2ftVXGxct8AOtG2XRynVqTzBmKf7
         ghVsIJUMsOcg8uu8myjVUw85sXNYYQuWM8RAQRSZQ/Stljmdq0A0tGlSbSaVnS4gfhn8
         Ox84R+YMF3dR/9ZpAalbA29V5frfQnyuqisHilrOxvejiZEByDu9c/ptXEnGGU5WVeHB
         mzpGfxTYCUn06iF9U/1kOkvH7sTz+9J0Bi0Fmy2+txRVX/6iAdoQRyGkJklS3xmybPt9
         qyYhUGmBrMe5obzxD9TeAywA4hS1izAQi8a+qbZPqoQWhEO6gN81GZ6W7a5tNI/dIK9K
         KJzQ==
X-Gm-Message-State: AGi0PubTewBZtcJspCFvzcLiSI7EfIzcj01Xf3LxHoUfFmuU9i9XOjCz
        fcSeOJOPayHrRrbyJJE3oKA=
X-Google-Smtp-Source: APiQypJFL7fF1uxQO/7n7Anfp+584Tz9laM7UvXyaNNNdRz43eN/pHnVtE2LaDEOJM4a+fUEEWCBmg==
X-Received: by 2002:a17:90a:290f:: with SMTP id g15mr23149328pjd.93.1589215886795;
        Mon, 11 May 2020 09:51:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2sm9878709pfc.7.2020.05.11.09.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 09:51:26 -0700 (PDT)
Subject: Re: [PATCH] hwmon: da9052: Synchronize access with mfd
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Samu Nuutamo <samu.nuutamo@vincit.fi>
References: <20200511110219.68188-1-sebastian.reichel@collabora.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <930d27f3-46f8-2e7a-5028-b593f4fe84a3@roeck-us.net>
Date:   Mon, 11 May 2020 09:51:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511110219.68188-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/20 4:02 AM, Sebastian Reichel wrote:
> From: Samu Nuutamo <samu.nuutamo@vincit.fi>
> 
> When tsi-as-adc is configured it is possible for in7[0123]_input read to
> return an incorrect value if a concurrent read to in[456]_input is
> performed. This is caused by a concurrent manipulation of the mux
> channel without proper locking as hwmon and mfd use different locks for
> synchronization.
> 
> Switch hwmon to use the same lock as mfd when accessing the TSI channel.
> 
> Fixes: 4f16cab19a3d5 ("hwmon: da9052: Add support for TSI channel")
> Signed-off-by: Samu Nuutamo <samu.nuutamo@vincit.fi>
> [rebase to current master, reword commit message slightly]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Have you explored calling da9052_adc_manual_read() instead ?
At the very least we should have a comment explaining why that
isn't feasible.

Thanks,
Guenter

> ---
>  drivers/hwmon/da9052-hwmon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
> index 53b517dbe7e6..4af2fc309c28 100644
> --- a/drivers/hwmon/da9052-hwmon.c
> +++ b/drivers/hwmon/da9052-hwmon.c
> @@ -244,9 +244,9 @@ static ssize_t da9052_tsi_show(struct device *dev,
>  	int channel = to_sensor_dev_attr(devattr)->index;
>  	int ret;
>  
> -	mutex_lock(&hwmon->hwmon_lock);
> +	mutex_lock(&hwmon->da9052->auxadc_lock);
>  	ret = __da9052_read_tsi(dev, channel);
> -	mutex_unlock(&hwmon->hwmon_lock);
> +	mutex_unlock(&hwmon->da9052->auxadc_lock);
>  
>  	if (ret < 0)
>  		return ret;
> 

