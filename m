Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A3DC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C042468C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SkahghNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbgCJNK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:10:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37065 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731352AbgCJNKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:10:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id 6so15812032wre.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=stwvll2Z0UBciDGqDN3BPXdjztkYAsKlie43tBme5yA=;
        b=SkahghNvvZALFb90kpfwpcpzAUyl5pDoHb70SjCV3iA4YutJUYplbhYlVpKyaVLMdL
         5LIqFP8rbhBVjLrD7xkyGkhxEGQBmhI6VE6LT2IHmbdkTKdvYQvb0+xZT7wtgVonVHq7
         ch4bg5ZA48tL9wEWovL9ra+kFPu7L6FDwLjGbeLqnIzvUfiK884KTc+n5qKHw7X6j4uc
         BDSyXry1sSSRZOsueyVXi2t+LL/plIcMkboBZzybZtfwTSo3ZVxsLRdjmvEcswQX/EvS
         lLktHt6qBQ3pRfTGLLEG2uE/N/LWwApvu+RNA6YLmEO5qeJhX7mdkrfky65YZGMGBv0W
         1wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=stwvll2Z0UBciDGqDN3BPXdjztkYAsKlie43tBme5yA=;
        b=pS0hE9Pc4yPmUWgVAGGsZZpWXSx7GbL/bH5yTP9J/xx436dWYg4v4aztKIx/UpK6Vk
         8ncdYp0xIG0B1MqLq4q+crjYaedrkXg7qUJxMsK6xWs4umKAain9eRC3AntDbAQSrUnU
         W3UI0OutLGPIczaIJFycYbP07q81jm7xZJt+RTvnKU3FrBJAYe5JxJDZmxLqCkWkSbjr
         D4jKU4kR6hYiS/cSXwUCtDqV+LA0XTT6/wSIp1zYbWosBj2IVNlnUNb5E+rrKCNvuZMe
         sL0nNRn9/ew2ICPqfE31I+WJGBPetgzt35EnkhbnJWAV9+SeB3GANajkI5XItFPi0mnT
         mpVw==
X-Gm-Message-State: ANhLgQ2aiIzhEklb/d/HSBND0DqC8/xf3OYM+A+Rk8j8o0FDk3QwtLF2
        S4FnOaned9ec7eTM6J+fl/K85A==
X-Google-Smtp-Source: ADFU+vtv+ocviwwMA8GuKvRJ5+rnYhleqOJVhro+wgnoMNtIf53L9tTB3qbfS/zh9rhfpDxcJ72Nhg==
X-Received: by 2002:a5d:60c2:: with SMTP id x2mr27061532wrt.123.1583845842444;
        Tue, 10 Mar 2020 06:10:42 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id k18sm16130392wru.94.2020.03.10.06.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 06:10:40 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] nvmem: Allow nvmem_sysfs_get_groups() to return
 NULL as error condition
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>
References: <PSXP216MB0438C66F372D62AA71CFC04780FE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <bc9c0714-6e21-4a6c-48ad-df3eb0cbb4a4@linaro.org>
Date:   Tue, 10 Mar 2020 13:10:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <PSXP216MB0438C66F372D62AA71CFC04780FE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/03/2020 17:49, Nicholas Johnson wrote:
> Currently, nvmem_register() does not check for NULL return from
> nvmem_sysfs_get_groups(), and hence nvmem_sysfs_get_groups() has to
> always return a valid group, even if it is given invalid inputs.
> 
> Add check in nvmem_register() to return an error if NULL group is given.
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> ---
>   drivers/nvmem/core.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index ef326f243..f6cd8a56a 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -388,6 +388,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   			   config->read_only || !nvmem->reg_write;
>   
>   	nvmem->dev.groups = nvmem_sysfs_get_groups(nvmem, config);
Code as it today will never return null so this patch belongs to the 
next patch where its possible to return null.

> +	if (!nvmem->dev.groups) {
> +		kfree(nvmem);

This is still leaking few more things here!
> +		return ERR_PTR(-EPERM);

Error code hear does not really reflect why it failed, we should return 
-EINVAL indicating that its invalid configuration.

--srini
> +	}
>   
>   	device_initialize(&nvmem->dev);
>   
> 
