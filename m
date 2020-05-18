Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1784CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1513207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pr11FLB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgEROKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgEROKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:10:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6D1C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:10:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i15so11999019wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YOX5omhjS6MVlVcf1+HCfCPScUqqHJPHWXBPkBcw5Vc=;
        b=pr11FLB44dXeVmCeFhm2kLkFcvKq9R1XNel9RqCmjIlLXf0NHXh6N5q4lTtqlw5X9w
         cjSPv7a4yMeGc9wjJ2F8rvDIQhV71OTBcLFzQlpADwWjShR9B0tFPaAIOQ3TEpvZzdFf
         e/ocfgaiWvxjWSsBYLxLVPd/9XwKGNsybHU8G0tzfY4VlTpMEzwLr9g8ksvjvQJol/tY
         STPPgPKt6uJ0zpHN1W4BpzP4mDBghiaQKAwWnF0T984l2Iyw8HO3GQmrflBpHYhzs3Cs
         4xqMfF1fIvjzG+gDh/P7w/e3bwVd5C181Xi0SPFo9ZQzGpUb9QH0sGQwlS3/x+dk9qMO
         pWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YOX5omhjS6MVlVcf1+HCfCPScUqqHJPHWXBPkBcw5Vc=;
        b=joRS/mJ/i5QDyFJkC6lE9MbdC4Ns7jbBEIH7zhobNb1IrpJcNImHsnjZII32CRxnOb
         3kpnTLAATaqH7Xh7uzKM4fwVOgNGFZd1JJh2XKidLMM6M+bOt+JXqh34ONbBKqbgQVW/
         Go3sNwqyh4a6giKucTHY2uWquKhRiVjTuhNYBj2IdwNlnNHWbWILliFpD5TbGH1+cjmo
         Sc2EvvwjPiiH67fC5cMHBchYiZrcLgb4yvcTrKA8DHhGSZQcqpyzZXdD1gFeT31QPIhp
         KDPt43Aj/AZBL1On6gEP2ejgvsYOW+YWPoChqr8M3UQNlDXou1r8xfkZDuutrckb04a7
         WQvQ==
X-Gm-Message-State: AOAM5308cSE+EmZ9zH2Pc9vviaVh3Ox1jth+LYHAOkKRwiQg0ST+Bv28
        +R1McTMdoMfEJkm/fo7sgbJzeMFebTk=
X-Google-Smtp-Source: ABdhPJzcFC8CwNoJQSsfOQ5xRC8i89rNRcwlP5YZ49Uavu9W/QxSd4XUPAMDyAQu6K4U8v/XWvb9lA==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr20442390wrn.109.1589811049905;
        Mon, 18 May 2020 07:10:49 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8? ([2a01:e34:ed2f:f020:9e7:3ac5:a930:2cd8])
        by smtp.googlemail.com with ESMTPSA id l13sm16393070wrm.55.2020.05.18.07.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 07:10:49 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/rda: drop redundant Kconfig
 dependency
To:     Johan Hovold <johan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
References: <20200513122548.16974-1-johan@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2871e212-c360-9d9c-a4aa-46fcd8867140@linaro.org>
Date:   Mon, 18 May 2020 16:10:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513122548.16974-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2020 14:25, Johan Hovold wrote:
> Since commit 2f8a26c166eb ("clocksource: Improve GENERIC_CLOCKEVENTS
> dependency") all clocksource drivers depend on GENERIC_CLOCKEVENTS so
> drop the redundant attribute from the RDA-timer entry which was added
> later.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied, thanks
> ---
>  drivers/clocksource/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index f2142e6bbea3..ef5331ce5fda 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -120,7 +120,6 @@ config OWL_TIMER
>  
>  config RDA_TIMER
>  	bool "RDA timer driver" if COMPILE_TEST
> -	depends on GENERIC_CLOCKEVENTS
>  	select CLKSRC_MMIO
>  	select TIMER_OF
>  	help
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
