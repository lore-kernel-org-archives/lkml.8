Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9945C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F722064B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgGHSoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:44:30 -0400
Received: from foss.arm.com ([217.140.110.172]:58652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGHSo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:44:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AC6731B;
        Wed,  8 Jul 2020 11:44:28 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85E6F3F68F;
        Wed,  8 Jul 2020 11:44:26 -0700 (PDT)
Subject: Re: [PATCH] clk: rockchip: mark pclk_uart2 as critical on rk3328
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     sboyd@kernel.org, mturquette@baylibre.com,
        zhangqing@rock-chips.com, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200708144528.20465-1-jbx6244@gmail.com>
 <074d8691-2d88-4520-1e43-8c7eb5b82680@arm.com>
 <0fccae1f-a62a-13fe-0aba-7bbae597d5c7@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a45a756a-1a47-df39-315a-91c547e2a293@arm.com>
Date:   Wed, 8 Jul 2020 19:44:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0fccae1f-a62a-13fe-0aba-7bbae597d5c7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-08 17:28, Johan Jonker wrote:
> Hi Robin and others,
> 
> Just a clarification.
> Test is done on rk3318 A95X Z2 that uses rk3328.dtsi.
> Almost everything works fine now except for uart2.
> Front display also works now with ported custom vfd driver for the
> SM1628 clone used.
> 
> When I include a printk function for debugging in
> clk_disable_unused_subtree I get this list of disabled clocks below.
> Could you list the rk3328 clocks that are turned off? Is there a difference?

I couldn't be bothered to rebuild a modified kernel package, so I just
rebooted with "trace_event=clk_disable,clk_enable":

[robin@nemulon-9 ~]$ sudo grep uart /sys/kernel/debug/tracing/trace
          <idle>-0     [000] d...     0.000000: clk_enable: clk_uart2_div
          <idle>-0     [000] d...     0.000000: clk_enable: clk_uart2_frac
          <idle>-0     [000] d...     0.000000: clk_disable: clk_uart2_frac
          <idle>-0     [000] d...     0.000000: clk_disable: clk_uart2_div
          <idle>-0     [000] d...     0.000000: clk_enable: clk_uart1_div
          <idle>-0     [000] d...     0.000000: clk_enable: clk_uart1_frac
          <idle>-0     [000] d...     0.000000: clk_disable: clk_uart1_frac
          <idle>-0     [000] d...     0.000000: clk_disable: clk_uart1_div
          <idle>-0     [000] d...     0.000000: clk_enable: clk_uart0_div
          <idle>-0     [000] d...     0.000000: clk_enable: clk_uart0_frac
          <idle>-0     [000] d...     0.000000: clk_disable: clk_uart0_frac
          <idle>-0     [000] d...     0.000000: clk_disable: clk_uart0_div
       swapper/0-1     [002] d...     5.397599: clk_enable: sclk_uart2
       swapper/0-1     [002] d...     5.397619: clk_enable: pclk_uart2
       swapper/0-1     [002] d...     5.398056: clk_disable: sclk_uart2
       swapper/0-1     [002] d...     5.398081: clk_enable: sclk_uart2
       swapper/0-1     [003] d...     5.716848: clk_disable: pclk_uart1
       swapper/0-1     [003] d...     5.716850: clk_disable: pclk_uart0
       swapper/0-1     [003] d...     5.718596: clk_disable: sclk_uart2
       swapper/0-1     [003] d...     5.718612: clk_enable: sclk_uart2
        (agetty)-554   [003] d...    12.662968: clk_disable: sclk_uart2
        (agetty)-554   [003] d...    12.662995: clk_enable: sclk_uart2

This looks as I would expect - UART2 is the only one enabled in DT, so
pclk_uart2 gets enabled when the driver loads and stays that way, while
the events for pclk_uart{0,1} correlate with clk_disable_unused()
running at the final round of initcalls:

[    5.398003] ff130000.serial: ttyS2 at MMIO 0xff130000 (irq = 14, base_baud = 1500000) is a 16550A
[    5.470655] printk: console [ttyS2] enabled
...
[    5.756099] Run /init as init process

FWIW I have "earlycon=uart8250,mmio32,0xff130000" on my command line,
but no explicit console argument - that's going to ttyS2 by virtue of
the DT "stdout-path".

Robin.

> boot options including:
> earlycon=uart8250,mmio32,0xff130000,keep
> console=ttyS2,1500000n8
> 
> But the real console in which one can type ends up on ttyUSB0.
> Without console defined in the command line it's only usb keyboard and
> hdmi monitor. Output on ttyS2 stops right after:
> 
> [    1.309231] C:pclk_uart2 -> pclk_bus
> 
> To see more I have to include clk_ignore_unused to the command line.
> In clk-px30.c they also included pclk_uart2 to the critical list.
> Could Elaine Zhang give more info on that?
> 
> Kind regards,
> 
> Johan Jonker
> 
> static void __init clk_disable_unused_subtree(struct clk_core *core)
> {
> 	struct clk_core *child;
> 	unsigned long flags;
> 
> 	lockdep_assert_held(&prepare_lock);
> 
> 	hlist_for_each_entry(child, &core->children, child_node)
> 		clk_disable_unused_subtree(child);
> 
> 	if (core->flags & CLK_OPS_PARENT_ENABLE)
> 		clk_core_prepare_enable(core->parent);
> 
> 	if (clk_pm_runtime_get(core))
> 		goto unprepare_out;
> 
> 	flags = clk_enable_lock();
> 
> 	if (core->enable_count)
> 		goto unlock_out;
> 
> 	if (core->flags & CLK_IGNORE_UNUSED)
> 		goto unlock_out;
> 
> 	/*
> 	 * some gate clocks have special needs during the disable-unused
> 	 * sequence.  call .disable_unused if available, otherwise fall
> 	 * back to .disable
> 	 */
> 	if (clk_core_is_enabled(core)) {
> 		trace_clk_disable(core);
> 
> ////////////
> // >>> Include debug here <<<
> 
> 		printk("C:%s -> %s\n", core->name, core->parent ? core->parent->name :
> "*");
> 
> ////////////
> 		if (core->ops->disable_unused)
> 			core->ops->disable_unused(core->hw);
> 		else if (core->ops->disable)
> 			core->ops->disable(core->hw);
> 		trace_clk_disable_complete(core);
> 	}
> 
> unlock_out:
> 	clk_enable_unlock(flags);
> 	clk_pm_runtime_put(core);
> unprepare_out:
> 	if (core->flags & CLK_OPS_PARENT_ENABLE)
> 		clk_core_disable_unprepare(core->parent);
> }
> 
> 
> label kernel
>      kernel /Image-CLK
>      fdt /rk3318-a95x-z2-CYX-led.dtb
>      append root=/dev/mmcblk0p5 console=tty0 console=ttyUSB0,115200n8
> console=ttyS2,1500000n8 initcall_debug=1 debug drm.debug=0xe
> earlycon=uart8250,mmio32,0xff130000,keep swiotlb=1 kpti=0
> no_console_suspend=1 consoleblank=0 rootwait
> 
> 
> [    1.282096] calling  clk_disable_unused+0x0/0x110 @ 1
> [    1.282705] C:sclk_timer5 -> xin24m
> [    1.283115] C:sclk_timer4 -> xin24m
> [    1.283524] C:sclk_timer3 -> xin24m
> [    1.283932] C:sclk_timer2 -> xin24m
> [    1.284340] C:sclk_timer1 -> xin24m
> [    1.284748] C:sclk_timer0 -> xin24m
> [    1.285158] C:clk_otp -> xin24m
> [    1.285536] C:aclk_mac2io -> aclk_gmac
> [    1.286035] C:pclk_mac2io -> pclk_gmac
> [    1.286483] C:clk_rga -> gpll
> [    1.286834] C:aclk_gpu -> aclk_gpu_pre
> [    1.287284] C:aclk_tsp -> aclk_bus_pre
> [    1.287723] C:aclk_dcf -> aclk_bus_pre
> [    1.288162] C:pclk_acodecphy -> pclk_phy_pre
> [    1.295372] C:pclk_dcf -> pclk_bus
> [    1.309231] C:pclk_uart2 -> pclk_bus
> [    1.322902] C:pclk_uart1 -> pclk_bus
> [    1.329133] C:pclk_uart0 -> pclk_bus
> [    1.335230] C:pclk_spi -> pclk_bus
> [    1.341538] C:pclk_stimer -> pclk_bus
> [    1.341543] C:pclk_i2c3 -> pclk_bus
> [    1.341547] C:pclk_i2c2 -> pclk_bus
> [    1.341551] C:pclk_i2c1 -> pclk_bus
> [    1.341554] C:pclk_i2c0 -> pclk_bus
> [    1.341562] C:hclk_pdm -> hclk_bus_pre
> [    1.341566] C:hclk_crypto_slv -> hclk_bus_pre
> [    1.341574] C:hclk_crypto_mst -> hclk_bus_pre
> [    1.395518] C:hclk_tsp -> hclk_bus_pre
> [    1.401131] C:hclk_spdif_8ch -> hclk_bus_pre
> [    1.406791] C:hclk_i2s2_2ch -> hclk_bus_pre
> [    1.421229] C:hclk_i2s1_8ch -> hclk_bus_pre
> [    1.426642] C:hclk_i2s0_8ch -> hclk_bus_pre
> [    1.431878] C:clk_wifi -> cpll
> [    1.436987] C:sclk_vdec_core -> cpll
> [    1.442045] C:sclk_vdec_cabac -> cpll
> [    1.446982] C:aclk_rga -> aclk_rga_pre
> [    1.451825] C:aclk_hdcp -> aclk_vio_pre
> [    1.456574] C:aclk_cif -> aclk_vio_pre
> [    1.461226] C:aclk_iep -> aclk_vio_pre
> [    1.465794] C:pclk_hdcp -> hclk_vio_pre
> [    1.470401] C:hclk_hdcp -> hclk_vio_pre
> [    1.470406] C:hclk_rga -> hclk_vio_pre
> [    1.470411] C:hclk_cif -> hclk_vio_pre
> [    1.470415] C:hclk_iep -> hclk_vio_pre
> [    1.470424] C:clk_mac2io_out -> cpll
> [    1.470432] C:clk_mac2io_ref -> clk_mac2io
> [    1.470440] C:clk_mac2io_rx -> clk_mac2io
> [    1.507448] C:clk_mac2io_tx -> clk_mac2io
> [    1.511778] C:clk_mac2io_refout -> clk_mac2io
> [    1.516094] C:clk_mac2io_src -> cpll
> [    1.520315] C:clk_ref_usb3otg_src -> cpll
> [    1.524560] C:clk_sdmmc_ext -> cpll
> [    1.528701] C:hclk_sdmmc_ext -> hclk_peri
> [    1.532850] C:clk_cif_src -> cpll
> [    1.536945] C:sclk_venc_dsp -> cpll
> [    1.541006] C:sclk_venc_core -> cpll
> [    1.544972] C:aclk_h264 -> aclk_rkvenc
> [    1.548936] C:aclk_h265 -> aclk_rkvenc
> [    1.552794] C:hclk_h264 -> hclk_rkvenc
> [    1.556580] C:pclk_h265 -> hclk_rkvenc
> [    1.560373] C:aclk_rkvdec -> aclk_rkvdec_pre
> [    1.564227] C:hclk_rkvdec -> hclk_rkvdec_pre
> [    1.568096] C:clk_spi -> cpll
> [    1.571981] C:clk_crypto -> cpll
> [    1.575897] C:clk_i2c3 -> cpll
> [    1.579795] C:clk_i2c2 -> cpll
> [    1.583657] C:clk_i2c1 -> cpll
> [    1.587521] C:clk_i2c0 -> cpll
> [    1.591357] C:i2s2_out -> clk_i2s2
> [    1.595170] C:clk_i2s2 -> i2s2_pre
> [    1.599020] C:i2s1_out -> clk_i2s1
> [    1.602893] C:clk_i2s1 -> i2s1_pre
> [    1.606749] C:clk_i2s0 -> i2s0_pre
> [    1.610519] C:clk_tsp -> cpll
> [    1.614239] C:clk_pdm -> apll
> [    1.617877] C:clk_hsadc_tsp -> *
> [    1.621718] initcall clk_disable_unused+0x0/0x110 returned 0 after
> 331056 usecs
> 
> 
> On 7/8/20 5:34 PM, Robin Murphy wrote:
>> On 2020-07-08 15:45, Johan Jonker wrote:
>>> The rk3328 uart2 port is used as boot console and to debug.
>>> During the boot pclk_uart2 is disabled by a clk_disable_unused
>>> initcall. Fix the uart2 function by marking pclk_uart2
>>> as critical on rk3328. Also add sclk_uart2 as that is needed
>>> for the same DT node.
>>
>> Hmm, given that those are named in the DT as the "baudclk" and
>> "apb_pclk" that dw8250_probe() explicitly claims, they really
>> shouldn't be unused :/
>>
>> On my RK3328 box they appear to be prepared and enabled OK:
>>
>> [robin@nemulon-9 ~]$ sudo grep uart2 /sys/kernel/debug/clk/clk_summary
>>      sclk_uart2                        1        1        0    24000000          0     0  50000
>>                     pclk_uart2         1        1        0    75000000          0     0  50000
>> ...
>>
>> Robin.
>>
>>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>>> ---
>>>    drivers/clk/rockchip/clk-rk3328.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
>>> index c186a1985..cb7749cb7 100644
>>> --- a/drivers/clk/rockchip/clk-rk3328.c
>>> +++ b/drivers/clk/rockchip/clk-rk3328.c
>>> @@ -875,6 +875,8 @@ static const char *const rk3328_critical_clocks[] __initconst = {
>>>    	"aclk_gmac_niu",
>>>    	"pclk_gmac_niu",
>>>    	"pclk_phy_niu",
>>> +	"pclk_uart2",
>>> +	"sclk_uart2",
>>>    };
>>>    
>>>    static void __init rk3328_clk_init(struct device_node *np)
>>>
> 
