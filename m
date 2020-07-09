Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DA6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C81206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz9/FrdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgGIME4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 08:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgGIME4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:04:56 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF14C061A0B;
        Thu,  9 Jul 2020 05:04:55 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lx13so2002271ejb.4;
        Thu, 09 Jul 2020 05:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0zImYmeVH2cb5ZKZAWLVklettku0gl+82cmF9xIzIxc=;
        b=Oz9/FrdYqRRn8i0zwob8qJNoewkLGHF/55gRHywFIp6s8QpbqYCLHc657OVkO8xlqe
         +GPUnF4hQSerKpxB2QgaeOIxQUN1L8oty3gXG1qc1wcbAPVo3vOICqd3wakjp/Nk348z
         7NRwy2m1h8z/V/Umxpi9my+ViWqlu7bBXM2KZkkDXsuYciM/+2FT+mhEDPpcZWdlRt1n
         klrrK9fF/Gim6Ao9WT7UpHaIV/JIdSGVpRRx3dWWg9HyplMjuDgziRGIBLX0W0GLWz1P
         li2WTT+0wTl+B85xHlIEee08IKSzXcWJdRz2sreqC8XSj8n62Ecas2ExC2ecBbCaSIc0
         /MNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0zImYmeVH2cb5ZKZAWLVklettku0gl+82cmF9xIzIxc=;
        b=L01N78OStyivScWmMbJXG+GnM9CK3uSv0SIo164poELK/AFkB0vTb5CKRlD+MPUpqA
         2oKAI9Lpu+4hRVMub2eliU/r997mUSsDha5+TyMarT69UMaP8V5knqpg7mFbML8+1Ibl
         c6YRxOR9lIGLzSU8H8qXp8EEVowg9MPxlY/T1W0JshVvVO2zaiaHH2/IUgPUn72RE7EA
         rS3/SScuV9NZ3ZyqvSKjubOW85ZpSMkTWW2k1vTSQ1eGm+jviB2XgRUNfjKrK5tnlaaM
         U5IGR86CeFjIO8yOeJSLSP6eB/rRHir/DjO/UfHw6aJmXocmB+7Yko7Q9xspxsaeY5db
         5B5g==
X-Gm-Message-State: AOAM532F76doOmVM5vREdFjZ/wIabBw+b1E4vponRuEh5RODEi8sK26W
        fYEHCXBQIpqor0KugX6inOr5jj0ue1M=
X-Google-Smtp-Source: ABdhPJwMt1uac/fO7xYUSf/Fv6CBZwDYVGcxGtSHD48eVkRoL6aGBpsYAkRI/YRFUxMwbmOvMLzocQ==
X-Received: by 2002:a17:906:2b52:: with SMTP id b18mr57784048ejg.158.1594296294559;
        Thu, 09 Jul 2020 05:04:54 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v3sm1888683edj.89.2020.07.09.05.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 05:04:54 -0700 (PDT)
Subject: Re: [PATCH] clk: rockchip: mark pclk_uart2 as critical on rk3328
To:     "elaine.zhang" <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
References: <20200708144528.20465-1-jbx6244@gmail.com>
 <2f58b9df-9bcd-5639-65cc-306a6d36b310@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <68073138-1f94-9d5b-ad48-e82bc538c915@gmail.com>
Date:   Thu, 9 Jul 2020 14:04:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2f58b9df-9bcd-5639-65cc-306a6d36b310@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine, Robin,

Thank you for your help!
This patch can go in the garbage bin.
It turns out that with SERIAL_8250 also SERIAL_8250_DW must be
selected... ;)

It's not in the Kconfig help description.
Shouldn't that be automatically be included for Rockchip?
Example:

config SERIAL_8250
	tristate "8250/16550 and compatible serial support"
	depends on !S390
	select SERIAL_CORE
	select SERIAL_MCTRL_GPIO if GPIOLIB
	select SERIAL_8250_DW if ARCH_ROCKCHIP

Thank Robin for the introduction to FTRACE!

mount -t tracefs tracefs /sys/kernel/tracing

cd /sys/kernel/tracing

# Without SERIAL_8250_DW

/sys/kernel/tracing # cat trace | grep uart2
          <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart2_div
          <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart2_frac
          <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart2_frac
          <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart2_div
       swapper/0-1     [002] d..1     1.916746: clk_disable: pclk_uart2


/sys/kernel/tracing # cat trace | grep uart
          <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart2_div
          <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart2_frac
          <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart2_frac
          <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart2_div
          <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart1_div
          <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart1_frac
          <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart1_frac
          <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart1_div
          <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart0_div
          <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart0_frac
          <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart0_frac
          <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart0_div
       swapper/0-1     [002] d..1     1.916746: clk_disable: pclk_uart2
       swapper/0-1     [002] d..1     1.923959: clk_disable: pclk_uart1
       swapper/0-1     [002] d..1     1.930741: clk_disable: pclk_uart0

# With SERIAL_8250_DW

/sys/kernel/tracing # cat trace | grep uart2
          <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart2_div
          <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart2_frac
          <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart2_frac
          <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart2_div
       swapper/0-1     [002] d..1     0.923180: clk_enable: sclk_uart2
       swapper/0-1     [002] d..1     0.923224: clk_enable: pclk_uart2
       swapper/0-1     [002] d..1     0.925259: clk_disable: sclk_uart2
       swapper/0-1     [002] d..1     0.925295: clk_enable: sclk_uart2
       swapper/0-1     [003] d..1     2.208605: clk_disable: sclk_uart2
       swapper/0-1     [003] d..1     2.208646: clk_enable: sclk_uart2

/sys/kernel/tracing # cat trace | grep uart
          <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart2_div
          <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart2_frac
          <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart2_frac
          <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart2_div
          <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart1_div
          <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart1_frac
          <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart1_frac
          <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart1_div
          <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart0_div
          <idle>-0     [000] d..2     0.000000: clk_enable: clk_uart0_frac
          <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart0_frac
          <idle>-0     [000] d..2     0.000000: clk_disable: clk_uart0_div
       swapper/0-1     [002] d..1     0.920034: clk_enable: sclk_uart0
       swapper/0-1     [002] d..1     0.920085: clk_enable: pclk_uart0
     kworker/2:1-32    [002] d..1     0.922596: clk_disable: sclk_uart0
     kworker/2:1-32    [002] d..1     0.922613: clk_disable: pclk_uart0
       swapper/0-1     [002] d..1     0.923180: clk_enable: sclk_uart2
       swapper/0-1     [002] d..1     0.923224: clk_enable: pclk_uart2
       swapper/0-1     [002] d..1     0.925259: clk_disable: sclk_uart2
       swapper/0-1     [002] d..1     0.925295: clk_enable: sclk_uart2
       swapper/0-1     [003] d..1     1.914158: clk_disable: pclk_uart1
       swapper/0-1     [003] d..1     2.208605: clk_disable: sclk_uart2
       swapper/0-1     [003] d..1     2.208646: clk_enable: sclk_uart2



On 7/9/20 3:32 AM, elaine.zhang wrote:
> 在 2020/7/8 下午10:45, Johan Jonker 写道:
>> The rk3328 uart2 port is used as boot console and to debug.
>> During the boot pclk_uart2 is disabled by a clk_disable_unused
>> initcall. Fix the uart2 function by marking pclk_uart2
>> as critical on rk3328. Also add sclk_uart2 as that is needed
>> for the same DT node.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>   drivers/clk/rockchip/clk-rk3328.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/clk/rockchip/clk-rk3328.c
>> b/drivers/clk/rockchip/clk-rk3328.c
>> index c186a1985..cb7749cb7 100644
>> --- a/drivers/clk/rockchip/clk-rk3328.c
>> +++ b/drivers/clk/rockchip/clk-rk3328.c
>> @@ -875,6 +875,8 @@ static const char *const rk3328_critical_clocks[]
>> __initconst = {
>>       "aclk_gmac_niu",
>>       "pclk_gmac_niu",
>>       "pclk_phy_niu",
>> +    "pclk_uart2",
>> +    "sclk_uart2",
>>   };
>>   
> 
> Not need to mark the uart2 as critical clocks, the uart clk will enabled
> by uart driver probe(dw8250_probe()).
> 
> For your question,  Please check the uart2 dts node "status = okay".
> 
> Or You can send me the complete log, I check the status of uart2.
> 
>>   static void __init rk3328_clk_init(struct device_node *np)
> 
> 

