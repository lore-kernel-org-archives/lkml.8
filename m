Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C79C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C70C920737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="B9o9qaJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgGWKA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgGWKA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:00:28 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E4EC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 03:00:28 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q4so5720377lji.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 03:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HrbYk4F6BiU7qem6PjGJVBGaHMs1d/veVa02py3tg7c=;
        b=B9o9qaJuicQJ2qsQkihdmy34rpXY1VeRtcFr+plwnR7HpNQMr6HSNrw+g7yamjxfNQ
         gZA9bp4Z9v4qrITsTl9OVZ9H0KTCP1FeyBK5YRuUE/1fa1rfC1DX+4+h0GtwKPPXOdXl
         6miY+01Vh8r5WmHot+riaztuwm77sTCPjxhOqoRkc4YrxNtV0ShA5fmocyFOlUeEUM79
         z+HoRlj3IzjM0HmBkgfgzslA4bGyyaJCrq7FjfrlYRPQRKo4bRTua9giUB5ABsysB5w8
         xZ+bwOS7VBS0kOjp/tVT137CID4wkm83mtBAkRrtLvLmxER3bJjaOxYhblQ5ScESeXDP
         IAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HrbYk4F6BiU7qem6PjGJVBGaHMs1d/veVa02py3tg7c=;
        b=bwHB1N11RxcB8dQVXsvCk+OjFjsjR14spKVEfDIFmQvt/Sw8OVw9UeB2EWbhE1VRbi
         asYLuYOSQ9ymDCfoBC1+0MRQ+0IcvhJXmmHUKfsPc6ojOYI9luuqc1zeTcEjfD5A9Az2
         W3OYOVC7CYFEnN0QrbJcVl3jXZFN47FNbVXlIY0VVl9JIB3L3pHHVfLN9s4x1+2Jjk7w
         1Uhlarpr6hqwEwjObfzSmncaWBUfCn/9dhIPJP/Ib877UzfqG0RYvonjYCUfzsqVnK9J
         dF1+aQNa+0r9MDzsgV/tT1EdeWiVLZddzFxBF/kmI/mcj8gQpmWWK0vlZLedKxzDO7/A
         PUZg==
X-Gm-Message-State: AOAM531v7jHQScldvoaxARtC8Ykl9keUb2hfZU0gsvgHKkU/Ld0ungjr
        kaWPCk3DQKtljAxwkeYH9f5Zcw==
X-Google-Smtp-Source: ABdhPJw/oMsAA+OlV/VLPwHyjW2JxV3TAlZQg+zmuCePnVD68oRkQgXVu2xZ9VZvASbD/2RTobFLFA==
X-Received: by 2002:a2e:8758:: with SMTP id q24mr1503960ljj.109.1595498426684;
        Thu, 23 Jul 2020 03:00:26 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:42af:e693:70ac:4b21:9cec:e4c7? ([2a00:1fa0:42af:e693:70ac:4b21:9cec:e4c7])
        by smtp.gmail.com with ESMTPSA id q3sm2316049ljm.22.2020.07.23.03.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 03:00:25 -0700 (PDT)
Subject: Re: [PATCH] mips: traps, add __init to parity_protection_init
To:     Jiri Slaby <jslaby@suse.cz>, tsbogend@alpha.franken.de
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
References: <20200723094235.12706-1-jslaby@suse.cz>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <252bf1ae-6c1d-463e-a035-debb119fa83d@cogentembedded.com>
Date:   Thu, 23 Jul 2020 13:00:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723094235.12706-1-jslaby@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 23.07.2020 12:42, Jiri Slaby wrote:

> It references __initdata and is called only from an __init function:
> trap_init. This avoids section mismatches (which I am seeing with gcc
> 10).
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> ---
>   arch/mips/kernel/traps.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index f655af68176c..702143ad7b47 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1680,7 +1680,7 @@ __setup("nol2par", nol2parity);
>    * Some MIPS CPUs can enable/disable for cache parity detection, but do
>    * it different ways.
>    */
> -static inline void parity_protection_init(void)
> +static inline __init void parity_protection_init(void)

    *inline* in a .c file? Perhaps gcc-10 has it out-of-line?

[...]

MBR, Sergei
