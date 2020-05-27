Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A5DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F12320899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K56l5RKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbgE0NXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbgE0NXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:23:02 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E99C08C5C1;
        Wed, 27 May 2020 06:23:01 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y11so1839858plt.12;
        Wed, 27 May 2020 06:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WMCAGgctWQCI4EOH1o7VYJ6D7UfFFBGz8Ga+d8PohkQ=;
        b=K56l5RKgeNZ4eDsd1Kt3Osm1mrwCSi5hQWk/fmWaC9bVi9wN8SP34jato8aOnPrAFv
         HYRh1X2i9I1a/pxLHv/g230yf9Pkd4h2sNxfWVH7wcDEcI+DSkdOX3SmoQ9ZcnjMyn4A
         fP0IdneURtjwmjpicPR8LwaRrOecY9sn6R+RP4q58zJHOY5b6eydLFEzI+cwePgKIH0G
         E3AMCy2QrnMt59AuPheZQhzwKoxPX9VPCgwV8QPb63D0jw/mantJtrGp8dfAaByxqLSQ
         B/shyDbp7EDtskpxrG8Lz0HNGeGhG9jgAJdLQTj1JQD7QQjQRDcy6WOK/wT14IEsMKJ6
         NUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WMCAGgctWQCI4EOH1o7VYJ6D7UfFFBGz8Ga+d8PohkQ=;
        b=RGocqUK41wb0AuhqYMqYhG/yGu+uysm/3WhaC927nnrk2wxfbIFA6O2TGqtgOCYkqO
         cFBJ4R4DxDVAcZ15O5+j9QAGE8RwU4RlNZ8TZ4GPN6ZNcpriUtX1gYHA9dHzLwZCSLeH
         jAbbzH6QOn1YW0Gp3igqY5wF0e1HHQQ4Kb42IBEOpQdKZ8xS8CiM0g521G8dDqaphR0M
         Zz79n4qVkVoQe5XVu9ajMib7Bf42W04O9y0e8g9ZUhb5USf3zdCyUwv3JqhGv+m8osNQ
         hDHu/RhVdqVzsrzTrA4Sv6d5dJH57f1uC4pKvVElAVyAmaUM1Jr7dmkKV5WF/rYmhzzv
         PdgQ==
X-Gm-Message-State: AOAM532w42OqxxZQYIGV/eO+kxtDlzZCE5x5Yz6tkVYmaeoqHhTP6sBq
        UzI+jtgVDqd+rv/aM8uFcjtaQQr8
X-Google-Smtp-Source: ABdhPJy1YQFXp2/h3iVVskQ03PN/RmwLpTuks7RWeVmcCu95CWIOO1Z5NGQeqY8fAfJYyrXXkqWAmA==
X-Received: by 2002:a17:90b:ed2:: with SMTP id gz18mr5123782pjb.22.1590585780415;
        Wed, 27 May 2020 06:23:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j18sm694072pfd.91.2020.05.27.06.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 06:22:59 -0700 (PDT)
Subject: Re: [PATCH -next] hwmon: (amd_energy) Fix build error
To:     YueHaibing <yuehaibing@huawei.com>, nchatrad@amd.com,
        jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200527130241.58468-1-yuehaibing@huawei.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <bfcd6504-c717-8e60-a1ad-d173f3bea02f@roeck-us.net>
Date:   Wed, 27 May 2020 06:22:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527130241.58468-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/20 6:02 AM, YueHaibing wrote:
> If CONFIG_NEED_MULTIPLE_NODES is n, building fails:
> 
> drivers/hwmon/amd_energy.c: In function ‘amd_energy_read’:
> ./include/asm-generic/topology.h:51:36: error: void value not ignored as it ought to be
>      #define cpumask_of_node(node) ((void)node, cpu_online_mask)
> ./include/linux/cpumask.h:618:72: note: in definition of macro ‘cpumask_first_and’
>  #define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p), (src2p))
>                                                                         ^~~~~
> drivers/hwmon/amd_energy.c:194:6: note: in expansion of macro ‘cpumask_of_node’
>       cpumask_of_node
>       ^~~~~~~~~~~~~~~
> ./include/asm-generic/topology.h:51:46: warning: left-hand operand of comma expression has no effect [-Wunused-value]
>      #define cpumask_of_node(node) ((void)node, cpu_online_mask)
>                                               ^
> ./include/linux/cpumask.h:618:72: note: in definition of macro ‘cpumask_first_and’
>  #define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p), (src2p))
>                                                                         ^~~~~
> drivers/hwmon/amd_energy.c:194:6: note: in expansion of macro ‘cpumask_of_node’
>       cpumask_of_node
>       ^~~~~~~~~~~~~~~
> 
> Fixes: 8abee9566b7e ("hwmon: Add amd_energy driver to report energy counters")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/hwmon/amd_energy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/amd_energy.c b/drivers/hwmon/amd_energy.c
> index bc8b643a37d5..9d5cd3057866 100644
> --- a/drivers/hwmon/amd_energy.c
> +++ b/drivers/hwmon/amd_energy.c
> @@ -192,7 +192,7 @@ static int amd_energy_read(struct device *dev,
>  	if (channel >= data->nr_cpus) {
>  		cpu = cpumask_first_and(cpu_online_mask,
>  					cpumask_of_node
> -					(channel - data->nr_cpus));
> +					((channel - data->nr_cpus)));

Wrong fix. The correct fix is to fix the macro, not its caller.
A patch to fix the macro has been submitted.

Guenter


>  		amd_add_delta(data, channel, cpu, val, false);
>  	} else {
>  		cpu = channel;
> 

