Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD198C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07722083E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nCyoWdwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgDIOZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:25:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41040 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgDIOZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:25:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9so12146854wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 07:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hVgUHgV3VoeLO68SskiDyyikoajLuaasMV5OOMTJ1v4=;
        b=nCyoWdwe3PmkweQA5JMtgtulprc4Mf6In1oBwKbEAER1VXAet8m4/cjlS0eS1lLh1T
         iazUQa5QMi942OTDqTXftjM9q3nxKlb+XM1HZv70Fcus8nTkPF/3374v0ET8RMbtamsP
         2vCXa3P1rEmk9lsGCAIUteUqtlDr4y2ya3tTu7N+x6byrDyGXI1ed3E54P7f+/S/tNol
         D7roPHguIFdPVRBD4cG+ZI0nvXWBLP5FF8PLJ7QGCfEMAhkAJp3aA6sIOjq4i4VlEWHA
         VjwY69EiCjefKOStpyYKkjUVLjrmLA2hW+1YxEh9Lpm5psudmhS8xHUu3dgx+tDXd3Wo
         xqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hVgUHgV3VoeLO68SskiDyyikoajLuaasMV5OOMTJ1v4=;
        b=YrVtuQfAQCRQnX6UMKttNmAdfo0W3dDShspMSicgBzTH9SrjkfTt7hjGPl/qQ38dEl
         wkJoCqkvhIdHlC0p/MFfZ5QVS2lLqOD31CPyqrfCJ8rnugYd/VIcyAgVlox1dIftbpxK
         Inp/wgSJu5PP39kk/I+hT6s87tBb8LBzRkYVf49I0QOqy48IxxC5YLVgXIoyQhs1jppn
         bn96QBefFGY/+YPb5AQlYMVvQsTMDQ9oppoL2qCsWHthVZY0XSNztLO526SqPbatEOky
         1r+9Jmb7xPG4joOAb+ASJAB/4Y2qFUOqsTimPgUxFN/shL5AzffkLQ16kucO6DXMkfPl
         aqDQ==
X-Gm-Message-State: AGi0PuYVgwq+eaQq9EmFL0D9Tr1cVSxwUenZPngjfcF5jvI3s4AJAUYA
        vTrkSsdI7+4SSOkJd+HOPrWqtg==
X-Google-Smtp-Source: APiQypLhIJuLtIm19LGDns/lGF1tq3Yz74jzoz1rFWszqhaKG0wwZZIwzA8p3Yu/IF6CFOmrrGzeYw==
X-Received: by 2002:a5d:69ca:: with SMTP id s10mr14558267wrw.260.1586442316641;
        Thu, 09 Apr 2020 07:25:16 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:4e:2ab3:ef46:7bda? ([2a01:e34:ed2f:f020:4e:2ab3:ef46:7bda])
        by smtp.googlemail.com with ESMTPSA id l185sm3787534wml.44.2020.04.09.07.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 07:25:15 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/imx-tpm: Add support for ARM64
To:     Anson Huang <Anson.Huang@nxp.com>, tglx@linutronix.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
References: <1585715222-24489-1-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0ce6137e-1af3-b867-069d-a070c4afd140@linaro.org>
Date:   Thu, 9 Apr 2020 16:25:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1585715222-24489-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2020 06:27, Anson Huang wrote:
> Allows building and compile-testing the i.MX TPM driver also
> for ARM64. The delay_timer is only supported on ARMv7.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
