Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7244C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A05D206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFtzkK0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgGHQ2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbgGHQ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:28:44 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DBFC061A0B;
        Wed,  8 Jul 2020 09:28:44 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n26so37286831ejx.0;
        Wed, 08 Jul 2020 09:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sM1pF2B/Unx9f8bmY4h3t9D1X4mTMrzt35ICJ1QQNqk=;
        b=rFtzkK0YaD+qR+NIKeHNpM+u06Z2ES+Uv03BNA6s/UuR69KcRJIuXDMVcVHPZkb28D
         cUtp8IHUgopZfLcn4wBArHYXuoVC2mOyY9ducE8/zBMAxYjW04Q4IyXQVmPZJR9l//E0
         KKYT/c0iSIm/KI0fl1/ykb6LJ01TaC3bF89NfgwB+XJ21wmDZOJSLhO02w7Krrd4yqqE
         Zc+B7N0tr/r0tgXlTbMwFsTS13j98tv6D05HN3g5w5EKXJb+uREljE1QVTeuk89TyO7S
         JL8NQeFSK3JxgZLwHcZefbPfVUpdne8Vk4Us/rd5xAIhgT+x4J9PweY8yPV2D2g6qqR3
         VwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sM1pF2B/Unx9f8bmY4h3t9D1X4mTMrzt35ICJ1QQNqk=;
        b=aa1kiUG4yPPvVClLflEDyliTMekB+zXepQXlWjrYXI5Xl6VjMu26BGGFffRVUquZSJ
         BFRP+F8hqXzC2m/4xzvJ2EUFcykKBkukLC9XykZubgehzFGoIg5PvD7F+dkuNgXJJpAH
         xoh2jM6FIlFFAF7uuRoNB9fZp3melIh10dhKCbGM2YmdZWc1OrEpcBt26ikxa1sBsycV
         NTgSVH5571pGc92SQ5xanwlYOmL/y+uWwcDIhwhstB+HfNk0Ql+gVW+Y4WyK6NcVwE0l
         jD2Kxn+zi3zatYk29c1XXGpvsbceer5Xr/TjqGvqacPSNl4DJ1uavvXCtB5iybS3rM/f
         RywA==
X-Gm-Message-State: AOAM533FJFCp8hBp8KfYdxko345QA3zgxWHq86UNgSOqImRUsXOqVtXZ
        SsizIDs05QwFIPCu319yqyk=
X-Google-Smtp-Source: ABdhPJxc0Taost+GEv3Vr/vhRWkmc56CbIdjdIwr2r3REAeGzr3uiHiyj8sYKj9F6pFSXn5ojLtMIg==
X-Received: by 2002:a17:906:4942:: with SMTP id f2mr54713676ejt.125.1594225722978;
        Wed, 08 Jul 2020 09:28:42 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i7sm22187eds.91.2020.07.08.09.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 09:28:42 -0700 (PDT)
Subject: Re: [PATCH] clk: rockchip: mark pclk_uart2 as critical on rk3328
To:     Robin Murphy <robin.murphy@arm.com>, heiko@sntech.de
Cc:     sboyd@kernel.org, mturquette@baylibre.com,
        zhangqing@rock-chips.com, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200708144528.20465-1-jbx6244@gmail.com>
 <074d8691-2d88-4520-1e43-8c7eb5b82680@arm.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <0fccae1f-a62a-13fe-0aba-7bbae597d5c7@gmail.com>
Date:   Wed, 8 Jul 2020 18:28:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <074d8691-2d88-4520-1e43-8c7eb5b82680@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin and others,

Just a clarification.
Test is done on rk3318 A95X Z2 that uses rk3328.dtsi.
Almost everything works fine now except for uart2.
Front display also works now with ported custom vfd driver for the
SM1628 clone used.

When I include a printk function for debugging in
clk_disable_unused_subtree I get this list of disabled clocks below.
Could you list the rk3328 clocks that are turned off? Is there a difference?

boot options including:
earlycon=uart8250,mmio32,0xff130000,keep
console=ttyS2,1500000n8

But the real console in which one can type ends up on ttyUSB0.
Without console defined in the command line it's only usb keyboard and
hdmi monitor. Output on ttyS2 stops right after:

[    1.309231] C:pclk_uart2 -> pclk_bus

To see more I have to include clk_ignore_unused to the command line.
In clk-px30.c they also included pclk_uart2 to the critical list.
Could Elaine Zhang give more info on that?

Kind regards,

Johan Jonker

static void __init clk_disable_unused_subtree(struct clk_core *core)
{
	struct clk_core *child;
	unsigned long flags;

	lockdep_assert_held(&prepare_lock);

	hlist_for_each_entry(child, &core->children, child_node)
		clk_disable_unused_subtree(child);

	if (core->flags & CLK_OPS_PARENT_ENABLE)
		clk_core_prepare_enable(core->parent);

	if (clk_pm_runtime_get(core))
		goto unprepare_out;

	flags = clk_enable_lock();

	if (core->enable_count)
		goto unlock_out;

	if (core->flags & CLK_IGNORE_UNUSED)
		goto unlock_out;

	/*
	 * some gate clocks have special needs during the disable-unused
	 * sequence.  call .disable_unused if available, otherwise fall
	 * back to .disable
	 */
	if (clk_core_is_enabled(core)) {
		trace_clk_disable(core);

////////////
// >>> Include debug here <<<

		printk("C:%s -> %s\n", core->name, core->parent ? core->parent->name :
"*");

////////////
		if (core->ops->disable_unused)
			core->ops->disable_unused(core->hw);
		else if (core->ops->disable)
			core->ops->disable(core->hw);
		trace_clk_disable_complete(core);
	}

unlock_out:
	clk_enable_unlock(flags);
	clk_pm_runtime_put(core);
unprepare_out:
	if (core->flags & CLK_OPS_PARENT_ENABLE)
		clk_core_disable_unprepare(core->parent);
}


label kernel
    kernel /Image-CLK
    fdt /rk3318-a95x-z2-CYX-led.dtb
    append root=/dev/mmcblk0p5 console=tty0 console=ttyUSB0,115200n8
console=ttyS2,1500000n8 initcall_debug=1 debug drm.debug=0xe
earlycon=uart8250,mmio32,0xff130000,keep swiotlb=1 kpti=0
no_console_suspend=1 consoleblank=0 rootwait


[    1.282096] calling  clk_disable_unused+0x0/0x110 @ 1
[    1.282705] C:sclk_timer5 -> xin24m
[    1.283115] C:sclk_timer4 -> xin24m
[    1.283524] C:sclk_timer3 -> xin24m
[    1.283932] C:sclk_timer2 -> xin24m
[    1.284340] C:sclk_timer1 -> xin24m
[    1.284748] C:sclk_timer0 -> xin24m
[    1.285158] C:clk_otp -> xin24m
[    1.285536] C:aclk_mac2io -> aclk_gmac
[    1.286035] C:pclk_mac2io -> pclk_gmac
[    1.286483] C:clk_rga -> gpll
[    1.286834] C:aclk_gpu -> aclk_gpu_pre
[    1.287284] C:aclk_tsp -> aclk_bus_pre
[    1.287723] C:aclk_dcf -> aclk_bus_pre
[    1.288162] C:pclk_acodecphy -> pclk_phy_pre
[    1.295372] C:pclk_dcf -> pclk_bus
[    1.309231] C:pclk_uart2 -> pclk_bus
[    1.322902] C:pclk_uart1 -> pclk_bus
[    1.329133] C:pclk_uart0 -> pclk_bus
[    1.335230] C:pclk_spi -> pclk_bus
[    1.341538] C:pclk_stimer -> pclk_bus
[    1.341543] C:pclk_i2c3 -> pclk_bus
[    1.341547] C:pclk_i2c2 -> pclk_bus
[    1.341551] C:pclk_i2c1 -> pclk_bus
[    1.341554] C:pclk_i2c0 -> pclk_bus
[    1.341562] C:hclk_pdm -> hclk_bus_pre
[    1.341566] C:hclk_crypto_slv -> hclk_bus_pre
[    1.341574] C:hclk_crypto_mst -> hclk_bus_pre
[    1.395518] C:hclk_tsp -> hclk_bus_pre
[    1.401131] C:hclk_spdif_8ch -> hclk_bus_pre
[    1.406791] C:hclk_i2s2_2ch -> hclk_bus_pre
[    1.421229] C:hclk_i2s1_8ch -> hclk_bus_pre
[    1.426642] C:hclk_i2s0_8ch -> hclk_bus_pre
[    1.431878] C:clk_wifi -> cpll
[    1.436987] C:sclk_vdec_core -> cpll
[    1.442045] C:sclk_vdec_cabac -> cpll
[    1.446982] C:aclk_rga -> aclk_rga_pre
[    1.451825] C:aclk_hdcp -> aclk_vio_pre
[    1.456574] C:aclk_cif -> aclk_vio_pre
[    1.461226] C:aclk_iep -> aclk_vio_pre
[    1.465794] C:pclk_hdcp -> hclk_vio_pre
[    1.470401] C:hclk_hdcp -> hclk_vio_pre
[    1.470406] C:hclk_rga -> hclk_vio_pre
[    1.470411] C:hclk_cif -> hclk_vio_pre
[    1.470415] C:hclk_iep -> hclk_vio_pre
[    1.470424] C:clk_mac2io_out -> cpll
[    1.470432] C:clk_mac2io_ref -> clk_mac2io
[    1.470440] C:clk_mac2io_rx -> clk_mac2io
[    1.507448] C:clk_mac2io_tx -> clk_mac2io
[    1.511778] C:clk_mac2io_refout -> clk_mac2io
[    1.516094] C:clk_mac2io_src -> cpll
[    1.520315] C:clk_ref_usb3otg_src -> cpll
[    1.524560] C:clk_sdmmc_ext -> cpll
[    1.528701] C:hclk_sdmmc_ext -> hclk_peri
[    1.532850] C:clk_cif_src -> cpll
[    1.536945] C:sclk_venc_dsp -> cpll
[    1.541006] C:sclk_venc_core -> cpll
[    1.544972] C:aclk_h264 -> aclk_rkvenc
[    1.548936] C:aclk_h265 -> aclk_rkvenc
[    1.552794] C:hclk_h264 -> hclk_rkvenc
[    1.556580] C:pclk_h265 -> hclk_rkvenc
[    1.560373] C:aclk_rkvdec -> aclk_rkvdec_pre
[    1.564227] C:hclk_rkvdec -> hclk_rkvdec_pre
[    1.568096] C:clk_spi -> cpll
[    1.571981] C:clk_crypto -> cpll
[    1.575897] C:clk_i2c3 -> cpll
[    1.579795] C:clk_i2c2 -> cpll
[    1.583657] C:clk_i2c1 -> cpll
[    1.587521] C:clk_i2c0 -> cpll
[    1.591357] C:i2s2_out -> clk_i2s2
[    1.595170] C:clk_i2s2 -> i2s2_pre
[    1.599020] C:i2s1_out -> clk_i2s1
[    1.602893] C:clk_i2s1 -> i2s1_pre
[    1.606749] C:clk_i2s0 -> i2s0_pre
[    1.610519] C:clk_tsp -> cpll
[    1.614239] C:clk_pdm -> apll
[    1.617877] C:clk_hsadc_tsp -> *
[    1.621718] initcall clk_disable_unused+0x0/0x110 returned 0 after
331056 usecs


On 7/8/20 5:34 PM, Robin Murphy wrote:
> On 2020-07-08 15:45, Johan Jonker wrote:
>> The rk3328 uart2 port is used as boot console and to debug.
>> During the boot pclk_uart2 is disabled by a clk_disable_unused
>> initcall. Fix the uart2 function by marking pclk_uart2
>> as critical on rk3328. Also add sclk_uart2 as that is needed
>> for the same DT node.
> 
> Hmm, given that those are named in the DT as the "baudclk" and
> "apb_pclk" that dw8250_probe() explicitly claims, they really
> shouldn't be unused :/
> 
> On my RK3328 box they appear to be prepared and enabled OK:
> 
> [robin@nemulon-9 ~]$ sudo grep uart2 /sys/kernel/debug/clk/clk_summary
>     sclk_uart2                        1        1        0    24000000          0     0  50000
>                    pclk_uart2         1        1        0    75000000          0     0  50000
> ...
> 
> Robin.
> 
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>   drivers/clk/rockchip/clk-rk3328.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
>> index c186a1985..cb7749cb7 100644
>> --- a/drivers/clk/rockchip/clk-rk3328.c
>> +++ b/drivers/clk/rockchip/clk-rk3328.c
>> @@ -875,6 +875,8 @@ static const char *const rk3328_critical_clocks[] __initconst = {
>>   	"aclk_gmac_niu",
>>   	"pclk_gmac_niu",
>>   	"pclk_phy_niu",
>> +	"pclk_uart2",
>> +	"sclk_uart2",
>>   };
>>   
>>   static void __init rk3328_clk_init(struct device_node *np)
>>

