Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0DAC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1849E206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioZ5xj2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgGVQV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgGVQV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:21:57 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DB7C0619DC;
        Wed, 22 Jul 2020 09:21:56 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a8so2106947edy.1;
        Wed, 22 Jul 2020 09:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=W2qj1Sf7PcrqUHXAEb/THg9pMML97014ZTi7y/wfL04=;
        b=ioZ5xj2jTbe7BEk/Bqjg2VgBz+XxeUzFPUDEwAk+U+gklxUhzB7JOtM47FKMBzI7/W
         4Xtsw84QyHLJ0S/F/2opJdyiZj987J4IhcHRaYI9EgJBhyQDn514g0HG989uTQr/q5Ll
         b4/oDtkbIZkuF0McM2VEViP0sdubi91rFcStMfdJ4l0hzSyXc6up5wL6FfOXimij0Dnv
         fdcU+G3TD92c77Kvaui4aNVO70yaDmxfSq72sqDqZbGNaw25ajW/zIh6n4JiC7cQrS4D
         i9I0Q+41wubABe2D+7epIOqr+AYYXGxsyHeMKppZ+oM0TKZ/EQNdATDmECFNn1Tl7ZdI
         JRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=W2qj1Sf7PcrqUHXAEb/THg9pMML97014ZTi7y/wfL04=;
        b=dvKY4/K8zRu5AHxrCViJQwlCgIcdLLyPTl8G/xbiavuotoaA+MOe+bNCxS/RfbsIe7
         ixJJWx5fnvwtsu1buXMWK4eVc2e9t1sqJ5sh6MWN/g6DIA78oqybYxE49cgHkTRtKnqd
         6CKNbZuuqolmzl/jsmm0BQ560yXE0sncLHPnusSXz+vSbtcW7tz4dNxO/ncwPnIT+4Ek
         fsOC5YVhJqE/rBBy8EXKLPBsRDydXUazngdT0okOgDV5yiAE+lwTM3oTp5mcz1jaVf6G
         UdwPGmpiZRq/hNu3KUauu0HJt+QLHnhIKQ3l1eymMkxqpU5d9c3F3OkWiO5iOPU51qLd
         rV8Q==
X-Gm-Message-State: AOAM5311Ub4EFPcD3NEKj630EdI9bzTLoXpN+5q9Q9D2Fb6qaz9O0U3y
        udQTT7Z2s+qWhkoJMwEAxel4/biQZQ==
X-Google-Smtp-Source: ABdhPJzxZviNNCmkzibAM7leGeJhF+rekVwrsCPYdkZWiHOdx8u1zheaFmjCV2hc1imeMTTKrBWVxw==
X-Received: by 2002:aa7:c6d3:: with SMTP id b19mr207732eds.207.1595434915199;
        Wed, 22 Jul 2020 09:21:55 -0700 (PDT)
Received: from ?IPv6:2a02:810b:f40:e00:b1ec:e192:dc67:8149? ([2a02:810b:f40:e00:b1ec:e192:dc67:8149])
        by smtp.gmail.com with ESMTPSA id o20sm88850ejr.64.2020.07.22.09.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 09:21:54 -0700 (PDT)
Subject: Re: [PATCH] clk: rockchip: add CLK_IGNORE_UNUSED to RK3188
 sclk_mac_lbtest
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200722143137.863-1-knaerzche@gmail.com>
 <3075813.JVNIx54Eim@diego>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <fb58ddad-7683-3b4a-f99e-d90b86056e1f@gmail.com>
Date:   Wed, 22 Jul 2020 18:21:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3075813.JVNIx54Eim@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Am 22.07.20 um 16:37 schrieb Heiko Stübner:
> Hi,
>
> Am Mittwoch, 22. Juli 2020, 16:31:37 CEST schrieb Alex Bee:
>> Since the loopbacktest clock is not exported and is not touched in the
>> driver, it needs the CLK_IGNORE_UNUSED flag in order to get the emac
>> working.
> could you please add it to the rk3188_critical_clocks array instead.
> CLK_IGNORE_UNUSED only protects it against the clock subsystem
> disabling it on boot, while as critical clock it also gets protected later.
>
> Thanks
> Heiko
>
wasn't aware of that and changed it in v2.
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>> ---
>>   drivers/clk/rockchip/clk-rk3188.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
>> index 77aebfb1d6d5..892b1edc3444 100644
>> --- a/drivers/clk/rockchip/clk-rk3188.c
>> +++ b/drivers/clk/rockchip/clk-rk3188.c
>> @@ -354,7 +354,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
>>   			RK2928_CLKGATE_CON(2), 5, GFLAGS),
>>   	MUX(SCLK_MAC, "sclk_macref", mux_sclk_macref_p, CLK_SET_RATE_PARENT,
>>   			RK2928_CLKSEL_CON(21), 4, 1, MFLAGS),
>> -	GATE(0, "sclk_mac_lbtest", "sclk_macref", 0,
>> +	GATE(0, "sclk_mac_lbtest", "sclk_macref", CLK_IGNORE_UNUSED,
>>   			RK2928_CLKGATE_CON(2), 12, GFLAGS),
>>   
>>   	COMPOSITE(0, "hsadc_src", mux_pll_src_gpll_cpll_p, 0,
>>
>
>
>
Regards,

Alex

