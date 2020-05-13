Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29978C47077
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 456F620657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qE8NAmG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbgEMNof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387791AbgEMNoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:44:34 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DCFC061A0C;
        Wed, 13 May 2020 06:44:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u22so6824839plq.12;
        Wed, 13 May 2020 06:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hsyJheNWdxA6aOfUxXnKVZCW8RsEIJEDZ9+V5bjVfXU=;
        b=qE8NAmG4SDddeXEG8Ni34+LyjW+TU7yalPvz2/F/iDDFJfn38xk6OuSChV2Sv1hgO0
         EAqkJZF7B4WNoGDPvHu+AFq45WO3+5dSqiMC25WYZxpMmS+JHdArNiYG0HG7mRrq0s8C
         EWHIlpwqdnKGiHIjteyOsK5shyC8ztrCljAFC82r1ZdY0sVDJM8NsO9GxeJp6jsSLd6Y
         gNGYs2XpyLBVEZmWnQnjDMSKHmA2epBAg8EPV0hsCNf4Q/aTHVsiYYSLF857q6uO3qOQ
         IlZsrXbuLr+4ezlknqVMoOpGK2NfgbwoWJ2ZpooxhFIBTh+mFeJXoGlUZsDL2HX5sFGf
         nUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hsyJheNWdxA6aOfUxXnKVZCW8RsEIJEDZ9+V5bjVfXU=;
        b=XOeHuh0T++S8ndMGkSnQZIVzz3sfCaa0d9+9/Ppk+JLFL9S/4z3UEhhuZpM15JY/kU
         0+wh34AFitXJkvCGWi9mX9dGOlQPrS7oq4OV5ACRFVljSari//eRhwoIEVr8YwS14t0z
         B1CoiQRAZuf5dO+PykAGowtMS7vhZiR2Z7L7s3koCDWiYpmwxRzKEzyJNiUi5xBZ3NtW
         rRbuLrWcVhFrE6Ou/ipAZjZHpucTZnqOOhMMAFiKmGi0FHtIpRBzek5J91qBqN0hBWn4
         kf7a6eBsxLQB1MuM5fpJnmT4yNEYz6qKpPoqOK5icapHZv7TQnEJHWjD7RWtEPQEbLo0
         UaPw==
X-Gm-Message-State: AGi0PuaXfnVb/dkmmbpZ/zCIZhzts40YvTFFVLuHw61/9TOhlVxtdMH0
        YRSv3K0ml3TTy0LY7H6oNemxrNTq0Cpsew==
X-Google-Smtp-Source: APiQypKMdPeiGgF2UsuarbB3Dq2j7ShHAJsiOc982OlQc55Vj2S1FEvU0PPyJDjpO6jKGd+ipFyq4A==
X-Received: by 2002:a17:902:522:: with SMTP id 31mr24894858plf.68.1589377473881;
        Wed, 13 May 2020 06:44:33 -0700 (PDT)
Received: from [0.0.0.0] (36-239-123-146.dynamic-ip.hinet.net. [36.239.123.146])
        by smtp.gmail.com with ESMTPSA id m63sm15157796pfb.101.2020.05.13.06.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 06:44:33 -0700 (PDT)
Subject: Re: [PATCH] of/fdt: Remove redundant kbasename function call
To:     robh+dt@kernel.org, frowand.list@gmail.com, robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200512154909.279788-1-arch0.zheng@gmail.com>
From:   Qi Zheng <arch0.zheng@gmail.com>
Message-ID: <c8c29efe-a79f-10e6-bb4d-a65f592eb33b@gmail.com>
Date:   Wed, 13 May 2020 21:44:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512154909.279788-1-arch0.zheng@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/12 下午11:49, Qi Zheng wrote:
> For version 1 to 3 of the device tree, this is the node full
> path as a zero terminated string, starting with "/". The
> following equation will not hold, since the node name has
> been processed in the fdt_get_name().
> 
> 	*pathp == '/'
> 
> For version 16 and later, this is the node unit name only
> (or an empty string for the root node). So the above
> equation will still not hold.
> 
> So the kbasename() is redundant, just remove it.
> 
> Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
> ---
>   drivers/of/fdt.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 8a8e07a8f03d..ea31b2ae8474 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -643,8 +643,6 @@ int __init of_scan_flat_dt(int (*it)(unsigned long node,
>   	     offset = fdt_next_node(blob, offset, &depth)) {
>   
>   		pathp = fdt_get_name(blob, offset, NULL);
> -		if (*pathp == '/')
> -			pathp = kbasename(pathp);
>   		rc = it(offset, pathp, depth, data);
>   	}
>   	return rc;
> 

add Rob Herring <robh@kernel.org>.
