Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73FCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9081420734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Grf9txbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgFJC1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 22:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFJC1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 22:27:22 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77B1C05BD1E;
        Tue,  9 Jun 2020 19:27:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e9so289514pgo.9;
        Tue, 09 Jun 2020 19:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=M3n1PIZINjO5wXKsa5OsSBOrWdpmZl2e0Ljs5D4+x+A=;
        b=Grf9txboa2IHZWpL56f3G236b2zzXxsyPUf7W0zbQ4JQqgtOb/2j8pF5p8XDi2lhDc
         +bHUHezXWBwxlg5tS58L0s+L7l4DfJ6V/WDjgxXFlOZrSqm0qMvu6g8SSgfMEIG+6T5K
         goV1umFTBNl5gOZUHMQyZhg6kxanUmOdF5fAV3nQualNIXtbnIjQikmGayVLqd7lWuFk
         x8rThK1h92gRxNw6M4lyeph1pYbq9h2AcQLLON93csttKipWHM72au9TF4eLkevCpBOv
         68KyOkQqNDP53818jfNn7GjSDL6zhQQQV9WbrD2svDHnA6mz3N5IjE9i5MPd6Z9aBJff
         9Aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M3n1PIZINjO5wXKsa5OsSBOrWdpmZl2e0Ljs5D4+x+A=;
        b=RsdraxkOGsKwULWMXPky4cNoOSzU4N/11IRUEnZvZk8qt8QQnyWObzhsquuY2OWjjK
         Ecz7rTeTgWb/NV8Bzl+V4YzLppUujLUOUg+EHvKGj8U8/w6XG6R9lOJ7PxPw8WqgjEuc
         mBb/WfiD6j9qjCYlNe4HlgujyigJUmGiMNtA7BZTCLob3/+PkvI0sTFG9SO8jM0+J/MY
         zLIaNQFNcJSbp8+9swmL7E1Ejk9U1EIOuQHOQCJPiSK0JzuCxxd0wXBJFuyx7kJO0yxv
         uiOU6u1YiVB/bMSw+d7bj8FgVk/t2LDfY4Pt/KL0eaz0tRLflqpktBHJnim0HiQxe5ff
         a84A==
X-Gm-Message-State: AOAM532929/p89Ja6259gC0IN67FIM/JD8uxcwJA72ZLuVUunURFmVR+
        4haBgZggGBltkpAS/gntIpuwMiVc
X-Google-Smtp-Source: ABdhPJwVOTx0//wDjSMoRutArPa8yG+dfKYWbsQpdSTjM57l0uKCbObERZ6HKGhi0jUVczW58BR1YA==
X-Received: by 2002:a63:3347:: with SMTP id z68mr843497pgz.61.1591756039687;
        Tue, 09 Jun 2020 19:27:19 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 85sm11089397pfz.145.2020.06.09.19.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 19:27:18 -0700 (PDT)
Subject: Re: [PATCH 2/2] clk: bcm63xx-gate: add BCM6318 support
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        julia.lawall@lip6.fr, f4bug@amsat.org, jonas.gorski@gmail.com,
        lkp@intel.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200609113049.4035426-1-noltari@gmail.com>
 <20200609113049.4035426-3-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1367fcf3-24ed-9106-a329-da5f8e168e17@gmail.com>
Date:   Tue, 9 Jun 2020 19:27:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609113049.4035426-3-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/2020 4:30 AM, Álvaro Fernández Rojas wrote:
> +static const struct clk_bcm63xx_table_entry bcm6318_clocks[] = {
> +	{ .name = "adsl_asb", .bit = 0, },
> +	{ .name = "usb_asb", .bit = 1, },
> +	{ .name = "mips_asb", .bit = 2, },
> +	{ .name = "pcie_asb", .bit = 3, },
> +	{ .name = "phymips_asb", .bit = 4, },
> +	{ .name = "robosw_asb", .bit = 5, },
> +	{ .name = "sar_asb", .bit = 6, },
> +	{ .name = "sdr_asb", .bit = 7, },
> +	{ .name = "swreg_asb", .bit = 8, },
> +	{ .name = "periph_asb", .bit = 9, },
> +	{ .name = "cpubus160", .bit = 10, },
> +	{ .name = "adsl", .bit = 11, },
> +	{ .name = "sar124", .bit = 12, },

Nit: this should be sar125

> +	{ .name = "mips", .bit = 13, .flags = CLK_IS_CRITICAL, },
> +	{ .name = "pcie", .bit = 14, },
> +	{ .name = "robosw250", .bit = 16, },
> +	{ .name = "robosw025", .bit = 17, },
> +	{ .name = "sdr", .bit = 19, .flags = CLK_IS_CRITICAL, },
> +	{ .name = "usb", .bit = 20, },

This should probably be "usbd" to indicate this is the USB device clock
(not host)

With that fixed:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
