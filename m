Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268CAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEBA0207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imeZj4AE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbgGVPWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732716AbgGVPWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:22:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671DFC0619DC;
        Wed, 22 Jul 2020 08:22:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id p14so1908555wmg.1;
        Wed, 22 Jul 2020 08:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UokfCGgQvnD2I8kwHgAfuGQiMzG41Bmy/qva1i+Xr9Q=;
        b=imeZj4AEQyXBwgRrZlJdwAXZqNDjzwecGKQh0aKMXJ1vzp2W0nXKyPJU9w23CE/aFp
         jK95QcRtfBrgTZZXK4f7d3Pq36AwEGyEbyOpZEbQYa0OSAkOALs2OvRxsqhCEU+T2dN0
         BTrCx5VQXaHOKGktrfqurfjLvpU6LM5FxE+n19bEtjpZUHPBrHv5YPT7MGNA5ECQUDmN
         xW4MdCnPNLn6hcnVVdjyxlho0UiRJszsUlxtgjGCXu3iSHdvFM83TAIraQIpLnFVTEwc
         dLvne+O3+bb7jcvCum4AYlmxfNPWDLv36ws1h7TX/EiyZChzZhgV11i+xEGBS+720NCr
         exlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UokfCGgQvnD2I8kwHgAfuGQiMzG41Bmy/qva1i+Xr9Q=;
        b=CEJgLqQfp9iAUCCVd7WCfP2N9sm/DpHFqG/FOR4T9Byjh5e3jU29rmNBhrK33/j9te
         jtGXVT09FnCdD2YumICv5KFryHeV8l5Z1R4huTkMNeZFmZEzyK8mJCmPQZkEErYbvoEd
         OZmU8vt+9N1Jr3geEM+aPcumHqtI6Kkn6SzHC72gVfqDf2WwRCPSz09fXvSWU3Z8ptdN
         HHdL6WImiLsR4EB+Bi37uBSXZpu9w9J9yPNmGLKzR/1xI6eq7tbxeL44RCOKvd+EtomC
         YffQ+KZH0xEOkchW/l2RJhDajjKUQAcCoEbNPQZZfGWXsEzEySYTeWlyidRXyyWUVrJG
         v39A==
X-Gm-Message-State: AOAM530NSMcjdQvtwO/RDMcep+7AUecCZ4IrsCM4B68HSF7O7GV/qzK8
        P4Dfw+QUoKLSPUPeXSLz3M8=
X-Google-Smtp-Source: ABdhPJyAPut+TAg/un14lNKUNan1m8Z2X5FFrV8YS2K81Ftu5MA3wRE94lOSafgYYhDz4Vb0ZrTUcw==
X-Received: by 2002:a1c:7510:: with SMTP id o16mr164221wmc.146.1595431324185;
        Wed, 22 Jul 2020 08:22:04 -0700 (PDT)
Received: from ziggy.stardust ([213.195.122.158])
        by smtp.gmail.com with ESMTPSA id z6sm329784wrs.36.2020.07.22.08.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 08:22:03 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: remove UART3 clock support
To:     Hanks Chen <hanks.chen@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        mtk01761 <wendell.lin@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
References: <1595387397-13110-1-git-send-email-hanks.chen@mediatek.com>
 <1595387397-13110-2-git-send-email-hanks.chen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <fe7cca1e-467e-e693-6d2d-16ffb0954621@gmail.com>
Date:   Wed, 22 Jul 2020 17:22:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1595387397-13110-2-git-send-email-hanks.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/07/2020 05:09, Hanks Chen wrote:
> remove the redundant clk interface of uart.
> 
> Signed-off-by: Hanks Chen <hanks.chen@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   include/dt-bindings/clock/mt6779-clk.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/mt6779-clk.h b/include/dt-bindings/clock/mt6779-clk.h
> index b083139afbd2..2b5f2354d7eb 100644
> --- a/include/dt-bindings/clock/mt6779-clk.h
> +++ b/include/dt-bindings/clock/mt6779-clk.h
> @@ -229,7 +229,6 @@
>   #define CLK_INFRA_UART0			21
>   #define CLK_INFRA_UART1			22
>   #define CLK_INFRA_UART2			23
> -#define CLK_INFRA_UART3			24
>   #define CLK_INFRA_GCE_26M		25
>   #define CLK_INFRA_CQ_DMA_FPC		26
>   #define CLK_INFRA_BTIF			27
> 
