Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512C5C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F962078A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgHQKVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgHQKU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:20:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B471CC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:20:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 6D157277952
Subject: Re: mainline/master bisection: baseline.login on mt8173-elm-hana
To:     Hanks Chen <hanks.chen@mediatek.com>,
        Marc Zyngier <maz@kernel.org>,
        Saravana Kannan <saravanak@google.com>
References: <5f391c17.1c69fb81.ef475.be70@mx.google.com>
Cc:     kernelci-results@groups.io, Jason Cooper <jason@lakedaemon.net>,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <e1e21bc9-75a8-e0f7-7b87-57b147962115@collabora.com>
Date:   Mon, 17 Aug 2020 11:20:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5f391c17.1c69fb81.ef475.be70@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please see the bisection report below about a boot failure.

Reports aren't automatically sent to the public while we're
trialing new bisection features on kernelci.org but this one
looks valid.

The log doesn't appear to be showing anything from the kernel, so
it's likely to be crashing very early.  Please let us know if you
need some help with investigating this issue, to try booting with
earlyprintk or anything.

Hope this helps.

Thanks,
Guillaume

On 16/08/2020 12:44, KernelCI bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> mainline/master bisection: baseline.login on mt8173-elm-hana
> 
> Summary:
>   Start:      a1d21081a60d Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
>   Plain log:  https://storage.kernelci.org/mainline/master/v5.8-13249-ga1d21081a60d/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-collabora/baseline-mt8173-elm-hana.txt
>   HTML log:   https://storage.kernelci.org/mainline/master/v5.8-13249-ga1d21081a60d/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-collabora/baseline-mt8173-elm-hana.html
>   Result:     f97dbf48ca43 irqchip/mtk-sysirq: Convert to a platform driver
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       mainline
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>   Branch:     master
>   Target:     mt8173-elm-hana
>   CPU arch:   arm64
>   Lab:        lab-collabora
>   Compiler:   gcc-8
>   Config:     defconfig+CONFIG_RANDOMIZE_BASE=y
>   Test case:  baseline.login
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit f97dbf48ca43009e8b8bcdf07f47fc9f06149b36
> Author: Saravana Kannan <saravanak@google.com>
> Date:   Fri Jul 17 17:06:36 2020 -0700
> 
>     irqchip/mtk-sysirq: Convert to a platform driver
>     
>     This driver can work as a platform driver. So covert it to a platform
>     driver.
>     
>     Signed-off-by: Saravana Kannan <saravanak@google.com>
>     Signed-off-by: Marc Zyngier <maz@kernel.org>
>     Reviewed-by: Hanks Chen <hanks.chen@mediatek.com>
>     Link: https://lore.kernel.org/r/20200718000637.3632841-4-saravanak@google.com
> 
> diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
> index 6ff98b87e5c0..7299c5ab4d10 100644
> --- a/drivers/irqchip/irq-mtk-sysirq.c
> +++ b/drivers/irqchip/irq-mtk-sysirq.c
> @@ -231,4 +231,6 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
>  	kfree(chip_data);
>  	return ret;
>  }
> -IRQCHIP_DECLARE(mtk_sysirq, "mediatek,mt6577-sysirq", mtk_sysirq_of_init);
> +IRQCHIP_PLATFORM_DRIVER_BEGIN(mtk_sysirq)
> +IRQCHIP_MATCH("mediatek,mt6577-sysirq", mtk_sysirq_of_init)
> +IRQCHIP_PLATFORM_DRIVER_END(mtk_sysirq)
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [e4cbce4d131753eca271d9d67f58c6377f27ad21] Merge tag 'sched-core-2020-08-03' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good e4cbce4d131753eca271d9d67f58c6377f27ad21
> # bad: [a1d21081a60dfb7fddf4a38b66d9cef603b317a9] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> git bisect bad a1d21081a60dfb7fddf4a38b66d9cef603b317a9
> # skip: [47ec5303d73ea344e84f46660fff693c57641386] Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> git bisect skip 47ec5303d73ea344e84f46660fff693c57641386
> # good: [99f0975d760b6320dd5490bd0bc3a31900284757] dt-bindings: i2c: renesas,iic: Document r8a774e1 support
> git bisect good 99f0975d760b6320dd5490bd0bc3a31900284757
> # good: [641ca08547f83bd265477150a66cf2378bc98ed7] nfp: convert to new udp_tunnel_nic infra
> git bisect good 641ca08547f83bd265477150a66cf2378bc98ed7
> # good: [38c392cef19019457ddcfb197ff3d9c5267698e6] powerpc/pseries: remove dlpar_cpu_readd()
> git bisect good 38c392cef19019457ddcfb197ff3d9c5267698e6
> # skip: [cc3365bbd07c26aa2e4c7435068292e03116d4e7] perf tools: Add clockid_name function
> git bisect skip cc3365bbd07c26aa2e4c7435068292e03116d4e7
> # good: [1ea528b0963040273471dc904bf8b0a243741d9f] drm/komeda: Use GEM CMA object functions
> git bisect good 1ea528b0963040273471dc904bf8b0a243741d9f
> # good: [afae47af0cb73e36d61b61c8d93cb9d755853050] drm: msm_drm.h: delete duplicated words in comments
> git bisect good afae47af0cb73e36d61b61c8d93cb9d755853050
> # good: [e752ec8e9216fd72bc2528297b7606071fb60d29] Merge series "spi: bcm2835/bcm2835aux: support effective_speed_hz" from Marc Kleine-Budde <mkl@pengutronix.de>:
> git bisect good e752ec8e9216fd72bc2528297b7606071fb60d29
> # good: [90fc73928fec2f62bbee1476781754c7392a7b61] x86/ioperm: Initialize pointer bitmap with NULL rather than 0
> git bisect good 90fc73928fec2f62bbee1476781754c7392a7b61
> # good: [e0eb34810113dbbf1ace57440cf48d514312a373] media: venus: fix multiple encoder crash
> git bisect good e0eb34810113dbbf1ace57440cf48d514312a373
> # good: [02772fbfcba8597eef9d5c5f7f94087132d0c1d4] f2fs: compress: fix to avoid memory leak on cc->cpages
> git bisect good 02772fbfcba8597eef9d5c5f7f94087132d0c1d4
> # good: [f65e1311e9c6c69bb886bd3333577f85d9eeddbc] tools/power/x86/intel-speed-select: Update version for v5.9
> git bisect good f65e1311e9c6c69bb886bd3333577f85d9eeddbc
> # good: [bf8fba45983b0a44db0d5d208d2faab4164cc3bf] memory: mvebu-devbus: Add missing braces to all arms of if statement
> git bisect good bf8fba45983b0a44db0d5d208d2faab4164cc3bf
> # good: [07e571ea59eef518730f983f4203651ea413f2cf] powerpc/64e: Drop dead BOOK3E_MMU_TLB_STATS code
> git bisect good 07e571ea59eef518730f983f4203651ea413f2cf
> # good: [2bb3c32c5c5fe98b7407a0befc32f16c959a0a92] RDMA/bnxt_re: Change wr posting logic to accommodate variable wqes
> git bisect good 2bb3c32c5c5fe98b7407a0befc32f16c959a0a92
> # good: [817ef1a456da7ffbc680763180f23af1fc05815f] ARM: dts: aspeed: rainier: System has one SPI NOR
> git bisect good 817ef1a456da7ffbc680763180f23af1fc05815f
> # good: [2cde6410c13d63cc306f395d9fa4b72605468061] staging: dpaa2-ethsw: ignore state interrupts when the interface is not running
> git bisect good 2cde6410c13d63cc306f395d9fa4b72605468061
> # bad: [086ba2ec163b638abd2a90ef3e8bab0238d02e56] Merge tag 'f2fs-for-5.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs
> git bisect bad 086ba2ec163b638abd2a90ef3e8bab0238d02e56
> # skip: [8186749621ed6b8fc42644c399e8c755a2b6f630] Merge tag 'drm-next-2020-08-06' of git://anongit.freedesktop.org/drm/drm
> git bisect skip 8186749621ed6b8fc42644c399e8c755a2b6f630
> # skip: [4a93025cbe4a0b19d1a25a2d763a3d2018bad0d9] mm/shuffle: don't move pages between zones and don't read garbage memmaps
> git bisect skip 4a93025cbe4a0b19d1a25a2d763a3d2018bad0d9
> # good: [f2db5efefa8979fa891597c6abd42191f3cb6939] scsi: fcoe: Correct some kernel-doc issues
> git bisect good f2db5efefa8979fa891597c6abd42191f3cb6939
> # good: [b90a1269184a3ff374562d243419ad2fa9d3b1aa] Merge branch 'net-openvswitch-masks-cache-enhancements'
> git bisect good b90a1269184a3ff374562d243419ad2fa9d3b1aa
> # good: [0f69dae4d1069963fdcc16e63655927d83281006] trace : Have tracing buffer info use kvzalloc instead of kzalloc
> git bisect good 0f69dae4d1069963fdcc16e63655927d83281006
> # good: [f4e9654a79ca015f041cb8b3848d6557309a9ba1] media: dt-bindings: media: renesas,fdp1: Make power-domains mandatory
> git bisect good f4e9654a79ca015f041cb8b3848d6557309a9ba1
> # good: [aa639e4437046a2519779932d8aa8842b517e20f] pinctrl: aspeed: Improve debug output
> git bisect good aa639e4437046a2519779932d8aa8842b517e20f
> # skip: [49e917deeb81e263bcdb4b20e61ca18111995ffe] Merge tag 'selinux-pr-20200803' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux
> git bisect skip 49e917deeb81e263bcdb4b20e61ca18111995ffe
> # good: [7f07c35fe63bc9563237436cb07bcc28f82a45b7] drm/vblank: Use spin_(un)lock_irq() in drm_queue_vblank_event()
> git bisect good 7f07c35fe63bc9563237436cb07bcc28f82a45b7
> # good: [bab9693a9a8c6dd19f670408ec1e78e12a320682] net: thunderx: use spin_lock_bh in nicvf_set_rx_mode_task()
> git bisect good bab9693a9a8c6dd19f670408ec1e78e12a320682
> # skip: [e4a7b2dc35d9582c253cf5e6d6c3605aabc7284d] Merge tag 'leds-5.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds
> git bisect skip e4a7b2dc35d9582c253cf5e6d6c3605aabc7284d
> # skip: [0b93d59e90d4403dd7c6bccaf27bd5bc91396866] mm/debug: print head flags in dump_page
> git bisect skip 0b93d59e90d4403dd7c6bccaf27bd5bc91396866
> # good: [176cf704425f3d22603d379ffa4a1033a24a779d] regulator: cros-ec-regulator: Fix double free of desc->name.
> git bisect good 176cf704425f3d22603d379ffa4a1033a24a779d
> # good: [62a30a292a8283b3022b602964ff7484d5824841] iio: buffer: fix attach/detach pollfunc order
> git bisect good 62a30a292a8283b3022b602964ff7484d5824841
> # good: [6c06333073acf8b5cac4b11ecc7170ee98e9b8e7] drm/amdgpu/gfx10: add support for sienna_cichlid firmware
> git bisect good 6c06333073acf8b5cac4b11ecc7170ee98e9b8e7
> # good: [1b0443b11530c1fac9d8d2a71032291d05e91be4] drm/amdgpu: fix coding error of mmhub pg enablement
> git bisect good 1b0443b11530c1fac9d8d2a71032291d05e91be4
> # good: [f30ef3e8376380c5be9de121517c713527cf0813] gpiolib: cdev: fix minor race in GET_LINEINFO_WATCH
> git bisect good f30ef3e8376380c5be9de121517c713527cf0813
> # good: [fd01cc590357df1da6e3ec8c9947ee15a83a40ec] virt: vbox: Rename guest_caps struct members to set_guest_caps
> git bisect good fd01cc590357df1da6e3ec8c9947ee15a83a40ec
> # good: [e6873087cce622bf5af5b519bdf781d086f6b2f4] ARM: dts: aspeed: wedge40: Enable pwm_tacho device
> git bisect good e6873087cce622bf5af5b519bdf781d086f6b2f4
> # skip: [e3243e2a273d79c69d821e27cd246089638c472a] Merge branch 'for-5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/jlawall/linux
> git bisect skip e3243e2a273d79c69d821e27cd246089638c472a
> # good: [135961e0a7d555fc8f1d7c89ad44a94dffa5dcd8] x86/kvm/svm: Move guest enter/exit into .noinstr.text
> git bisect good 135961e0a7d555fc8f1d7c89ad44a94dffa5dcd8
> # good: [37ae231554f401104bf21847f9093d647a47faa4] USB: serial: only set sysrq timestamp for consoles
> git bisect good 37ae231554f401104bf21847f9093d647a47faa4
> # skip: [79e3ea5aab48c83de9410e43b52895406847eca7] tools/: replace HTTP links with HTTPS ones
> git bisect skip 79e3ea5aab48c83de9410e43b52895406847eca7
> # good: [3499f9ad5d78375856f692ae86e9f5fc50a08993] ASoC: amd: Removing unnecessary instance initialization
> git bisect good 3499f9ad5d78375856f692ae86e9f5fc50a08993
> # good: [0ed9498f9ecfde50c93f3f3dd64b4cd5414d9944] USB: Simplify USB ID table match
> git bisect good 0ed9498f9ecfde50c93f3f3dd64b4cd5414d9944
> # good: [a52c809769d3b4d5c94c96e9b49d898ce17128f0] misc: Replace HTTP links with HTTPS ones
> git bisect good a52c809769d3b4d5c94c96e9b49d898ce17128f0
> # good: [950a3a7951cdeb908798a49d57e5303ad7afd05a] arm64: dts: renesas: r8a774e1: Add I2C and IIC-DVFS support
> git bisect good 950a3a7951cdeb908798a49d57e5303ad7afd05a
> # skip: [dabc3e291d56e3125113101bc6d53d1a1738294d] mm/slab: add naive detection of double free
> git bisect skip dabc3e291d56e3125113101bc6d53d1a1738294d
> # good: [033555f6eb60787bd40e34d7abeacaebdcd4c54e] MIPS: KVM: Fix build error caused by 'kvm_run' cleanup
> git bisect good 033555f6eb60787bd40e34d7abeacaebdcd4c54e
> # good: [c5b6c914d2f3755426b9c68ed6ddd8f917d9be9e] drm/amdgpu: enable cp_fw_write_wait for navy_flounder
> git bisect good c5b6c914d2f3755426b9c68ed6ddd8f917d9be9e
> # good: [56643d9ad2b4933d55f872f61195c1650f9958e9] clk: bcm: rpi: Remove the quirks for the CPU clock
> git bisect good 56643d9ad2b4933d55f872f61195c1650f9958e9
> # good: [d777960e8f7268f82806451065f84ea3b05a3ea3] dt-bindings: microchip: atmel,at91rm9200-tcb: add sama5d2 compatible
> git bisect good d777960e8f7268f82806451065f84ea3b05a3ea3
> # good: [f639fb66d17e2e25049503b7c2c568457a9b5c6f] dt-bindings: power: renesas,rcar-sysc: Document r8a774e1 SYSC binding
> git bisect good f639fb66d17e2e25049503b7c2c568457a9b5c6f
> # good: [84520c02026174f2db61d40d461b3b0e4a890ea8] Documentation: PCI: pci-error-recovery: drop doubled words
> git bisect good 84520c02026174f2db61d40d461b3b0e4a890ea8
> # good: [c569e805c7bcebdd069e5c97ce5f8543f6d02433] thermal: intel: intel_pch_thermal: Add Cannon Lake Low Power PCH support
> git bisect good c569e805c7bcebdd069e5c97ce5f8543f6d02433
> # good: [d33cfc2e591a90f540cd696240ff953b8aaba17d] dt-bindings: pinctrl: sh-pfc: Document r8a774e1 PFC support
> git bisect good d33cfc2e591a90f540cd696240ff953b8aaba17d
> # good: [0c56c862e712001e4d86bc4f43d74f2425c010c2] drm/amd/powerplay: fix a crash when overclocking Vega M
> git bisect good 0c56c862e712001e4d86bc4f43d74f2425c010c2
> # good: [a535aa677521f63acbca3804ae42e062a912add0] drm/nouveau/fbcon: convert copyarea() to new push macros
> git bisect good a535aa677521f63acbca3804ae42e062a912add0
> # skip: [40ddad19131999161c39564815b8df2faff0fc7c] Merge tag 'for-linus' of git://git.armlinux.org.uk/~rmk/linux-arm
> git bisect skip 40ddad19131999161c39564815b8df2faff0fc7c
> # good: [5759ff1131cd420aad7eae639719a473154b2e37] scsi: hpsa: Correct ctrl queue depth
> git bisect good 5759ff1131cd420aad7eae639719a473154b2e37
> # good: [29ace860ecdf716164d9059545bbaae14cced901] drm/nouveau/kms/nv50-: use NVIDIA's headers for core head_procamp()
> git bisect good 29ace860ecdf716164d9059545bbaae14cced901
> # skip: [9ab9bc5115c9a1a57ed83a143c601c31488eadd9] Merge tag 'hyperv-next-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux
> git bisect skip 9ab9bc5115c9a1a57ed83a143c601c31488eadd9
> # good: [e6827bc3faa4da29ddbf48f48d04e87ca7c1c3c7] gpio: max77620: Initialize hardware state of interrupts
> git bisect good e6827bc3faa4da29ddbf48f48d04e87ca7c1c3c7
> # skip: [bbcf9cd1576752ebe8d618ad8c6500b7e262ffac] Merge tag 'xtensa-20200805' of git://github.com/jcmvbkbc/linux-xtensa
> git bisect skip bbcf9cd1576752ebe8d618ad8c6500b7e262ffac
> # skip: [7b4ea9456dd3f73238408126ab00f1d906963d81] Revert "x86/mm/64: Do not sync vmalloc/ioremap mappings"
> git bisect skip 7b4ea9456dd3f73238408126ab00f1d906963d81
> # good: [ba2def29285282f535f41acf9aac849553b71f25] ALSA: firewire: fix kernel-doc
> git bisect good ba2def29285282f535f41acf9aac849553b71f25
> # good: [8a473c39ae54c27e694a131c34a739d0f8aa5300] ASoC: Intel: Boards: cml_rt1011_rt5682: use statically define codec config
> git bisect good 8a473c39ae54c27e694a131c34a739d0f8aa5300
> # good: [bf6af17065079d29b9bd4e59de27cc2965e6fabf] bcache: handle cache set verify_ondisk properly for bucket size > 8MB
> git bisect good bf6af17065079d29b9bd4e59de27cc2965e6fabf
> # good: [eaad981291ee36efee15a5e515d4598ae94ace07] x86/entry/64: Introduce the FIND_PERCPU_BASE macro
> git bisect good eaad981291ee36efee15a5e515d4598ae94ace07
> # good: [dd4eddc4ba31fbf4554fc5fa12d3a553b50e1469] media: mtk-mdp: Fix a refcounting bug on error in init
> git bisect good dd4eddc4ba31fbf4554fc5fa12d3a553b50e1469
> # good: [95b1469e5cbaad02bc48043d4e159c6562b556b4] drm/nouveau/fbcon/nv50-: use NVIDIA's headers for copyarea()
> git bisect good 95b1469e5cbaad02bc48043d4e159c6562b556b4
> # good: [418370ff2231b7db5abf59b8faec911e6fc44d96] of: reserved_mem: Fix typo in the too-many-regions message
> git bisect good 418370ff2231b7db5abf59b8faec911e6fc44d96
> # good: [3b8bee2a96ce7a5e47239f3a0cb39caffa8358a4] dmaengine: ti: k3-udma: Do not use ring_get_occ in udma_pop_from_ring
> git bisect good 3b8bee2a96ce7a5e47239f3a0cb39caffa8358a4
> # good: [be3afa120c5f8131ff835a270247b0a9cca0138a] ASoC: Intel: sdw_max98373: add card_late_probe support
> git bisect good be3afa120c5f8131ff835a270247b0a9cca0138a
> # good: [bdcd178ada90d2413bcc9df4211dcdd511a47586] x86/entry: Use generic interrupt entry/exit code
> git bisect good bdcd178ada90d2413bcc9df4211dcdd511a47586
> # good: [ee4bf86c69d1e86ee0505f4824b95a74704d433f] erofs: fold in used-once helper erofs_workgroup_unfreeze_final()
> git bisect good ee4bf86c69d1e86ee0505f4824b95a74704d433f
> # good: [f959b5d037e71a4d69b5bf71faffa065d9269b4a] xfs: fix inode quota reservation checks
> git bisect good f959b5d037e71a4d69b5bf71faffa065d9269b4a
> # skip: [7a3767f83f173f9df9af9eb04959abe2966d4cc8] kasan: improve and simplify Kconfig.kasan
> git bisect skip 7a3767f83f173f9df9af9eb04959abe2966d4cc8
> # good: [169efc3bf4dde79a8e15d71f45f1150bec46b663] pinctrl: merrifield: Add I²S bus 2 pins to groups and functions
> git bisect good 169efc3bf4dde79a8e15d71f45f1150bec46b663
> # good: [1bc734759f284eb531dd474c72ce59874649a254] drm/amdgpu/navi1x: add SMU i2c support (v2)
> git bisect good 1bc734759f284eb531dd474c72ce59874649a254
> # good: [8c37ad2f523396e15cf002b29f8f796447c71932] cpufreq: ap806: fix cpufreq driver needs ap cpu clk
> git bisect good 8c37ad2f523396e15cf002b29f8f796447c71932
> # skip: [27ec4878df7bdffa4667f41d3830520597679a74] mm: swap: fix kerneldoc of swap_vma_readahead()
> git bisect skip 27ec4878df7bdffa4667f41d3830520597679a74
> # good: [f8951902b9daa65ba240ce8a054c727748df2147] MTD: mtd-abi.h: drop a duplicated word
> git bisect good f8951902b9daa65ba240ce8a054c727748df2147
> # good: [d1e2a97b36131607d33ac3d02e569b494900f1bd] Merge series "ASoC: add asoc_substream_to_rtd() macro" from Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>:
> git bisect good d1e2a97b36131607d33ac3d02e569b494900f1bd
> # good: [cea0f76a483d1270ac6f6513964e3e75193dda48] dt-bindings: phy: Add DT bindings for Xilinx ZynqMP PSGTR PHY
> git bisect good cea0f76a483d1270ac6f6513964e3e75193dda48
> # good: [86b224beea5faf6b18204e5e324bcde472488096] ARM: tegra: Use numeric unit-addresses
> git bisect good 86b224beea5faf6b18204e5e324bcde472488096
> # bad: [71fa1a4489ff93ac4acd7e6c5b00098ba53a4485] thunderbolt: merge fix for kunix_resource changes
> git bisect bad 71fa1a4489ff93ac4acd7e6c5b00098ba53a4485
> # skip: [9aebd3254c184fb6c731548b8347193bf882b6f7] Merge tag 'hwmon-for-v5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
> git bisect skip 9aebd3254c184fb6c731548b8347193bf882b6f7
> # good: [c8f3446c66d810e21af61cf889e7b0e3bc921b9d] inotify: report both events on parent and child with single callback
> git bisect good c8f3446c66d810e21af61cf889e7b0e3bc921b9d
> # good: [d0c72c7759d463e31b4ef8937af1df61b513fc2c] arm64: dts: ti: k3-j721e-main: rename smmu node to iommu
> git bisect good d0c72c7759d463e31b4ef8937af1df61b513fc2c
> # skip: [1d9cfee7535c213038a615f112c900c2d0ba8f54] mm/sparsemem: enable vmem_altmap support in vmemmap_populate_basepages()
> git bisect skip 1d9cfee7535c213038a615f112c900c2d0ba8f54
> # good: [f1e51e99ed498d4aa9ae5df28e43d558ea627781] usb: mtu3: clear dual mode of u3port when disable device
> git bisect good f1e51e99ed498d4aa9ae5df28e43d558ea627781
> # good: [0f63ef1dd581de1655075e2dbdf2ef302514a983] RDMA/core: Align abort/commit object scheme for write() and ioctl() paths
> git bisect good 0f63ef1dd581de1655075e2dbdf2ef302514a983
> # good: [ce79097a8f8391fdec835d1deaa112fba4b18362] selftests: Remove unneeded selftest API headers
> git bisect good ce79097a8f8391fdec835d1deaa112fba4b18362
> # good: [341a8f866e7252e7c0410fdd53fe513a9c12f3d2] Staging: rtl8712: Fixed a coding sytle issue
> git bisect good 341a8f866e7252e7c0410fdd53fe513a9c12f3d2
> # skip: [1d8ce0e09301920454234a4096dee96a670a8e32] Merge tag 'gpio-v5.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio
> git bisect skip 1d8ce0e09301920454234a4096dee96a670a8e32
> # good: [c9fadf212afd4f924a3502e3904917ee280854c0] Merge remote-tracking branch 'regmap/for-5.9' into regmap-next
> git bisect good c9fadf212afd4f924a3502e3904917ee280854c0
> # skip: [eda330e57b26df8fabce184736ae3d11e7a104bd] mm: kmem: switch to static_branch_likely() in memcg_kmem_enabled()
> git bisect skip eda330e57b26df8fabce184736ae3d11e7a104bd
> # good: [393a403ed87ee43d23fe1b075ff52826c6e74a53] arm64: tegra: Remove simple clocks bus
> git bisect good 393a403ed87ee43d23fe1b075ff52826c6e74a53
> # skip: [441977979a78bffe51b13932d353919b1fb20c14] Merge tag 'devicetree-for-5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
> git bisect skip 441977979a78bffe51b13932d353919b1fb20c14
> # good: [e0f1a30cf184821499eeb67daedd7a3f21bbcb0b] firmware: arm_scmi: Fix SCMI genpd domain probing
> git bisect good e0f1a30cf184821499eeb67daedd7a3f21bbcb0b
> # good: [6760a29c8817769bfc754bf76899a153451433dc] Merge tag 'renesas-dt-bindings-for-v5.9-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/dt
> git bisect good 6760a29c8817769bfc754bf76899a153451433dc
> # good: [3d702d06cb3c06b34a58f01471e094d8156181ad] drm/i915/tgl: Implement WAs 18011464164 and 22010931296
> git bisect good 3d702d06cb3c06b34a58f01471e094d8156181ad
> # skip: [6dc5ea16c86f753951f53085aa04df49cf17cb50] mm, dump_page: do not crash with bad compound_mapcount()
> git bisect skip 6dc5ea16c86f753951f53085aa04df49cf17cb50
> # good: [72f70c159b53e1363191953875e0223ed959e143] selftests: rtnetlink: make kci_test_encap() return sub-test result
> git bisect good 72f70c159b53e1363191953875e0223ed959e143
> # good: [0b8f96be9bd41521b6379b403cfce78934f8274c] dyndbg: fix pr_err with empty string
> git bisect good 0b8f96be9bd41521b6379b403cfce78934f8274c
> # good: [bf9b82b7fe4d3c7d4d432ef80b4299c9b6b4a1f8] kobject: remove unused KOBJ_MAX action
> git bisect good bf9b82b7fe4d3c7d4d432ef80b4299c9b6b4a1f8
> # good: [93ca8ac2e8fcea6feb02a40edd2334144b62fc6e] arm64: dts: rockchip: Add PCIe for RockPI N10
> git bisect good 93ca8ac2e8fcea6feb02a40edd2334144b62fc6e
> # good: [24194a7e03f46f08579e3094417e448a92aff2b4] ACPI: tables: Remove the duplicated checks for acpi_parse_entries_array()
> git bisect good 24194a7e03f46f08579e3094417e448a92aff2b4
> # good: [8807e15597492331992a0d749a90a291afa1ed7b] EDAC, {skx,i10nm}: Use CPU stepping macro to pass configurations
> git bisect good 8807e15597492331992a0d749a90a291afa1ed7b
> # bad: [5b6570bbb26f1dfad5663d99351820865e8c5c7e] irqchip/imx-intmux: Fix irqdata regs save in imx_intmux_runtime_suspend()
> git bisect bad 5b6570bbb26f1dfad5663d99351820865e8c5c7e
> # good: [66a535c495f72e1deacc37dfa34acca2a06e3578] irqchip/loongson-pch-pic: Check return value of irq_domain_translate_twocell()
> git bisect good 66a535c495f72e1deacc37dfa34acca2a06e3578
> # good: [9808357ff2e5bfe1e0dcafef5e78cc5b617a7078] irqchip/irq-bcm7038-l1: Guard uses of cpu_logical_map
> git bisect good 9808357ff2e5bfe1e0dcafef5e78cc5b617a7078
> # bad: [920ecb8c35cb2e114858606c9a17e8e679a25454] irqchip/mtk-cirq: Convert to a platform driver
> git bisect bad 920ecb8c35cb2e114858606c9a17e8e679a25454
> # good: [f8410e626569324cfe831aaecc0504cafc12b471] irqchip: Add IRQCHIP_PLATFORM_DRIVER_BEGIN/END and IRQCHIP_MATCH helper macros
> git bisect good f8410e626569324cfe831aaecc0504cafc12b471
> # good: [5be57099d44550d2c4cf44a86c44df87edb79a57] irqchip/qcom-pdc: Switch to using IRQCHIP_PLATFORM_DRIVER helper macros
> git bisect good 5be57099d44550d2c4cf44a86c44df87edb79a57
> # bad: [f97dbf48ca43009e8b8bcdf07f47fc9f06149b36] irqchip/mtk-sysirq: Convert to a platform driver
> git bisect bad f97dbf48ca43009e8b8bcdf07f47fc9f06149b36
> # first bad commit: [f97dbf48ca43009e8b8bcdf07f47fc9f06149b36] irqchip/mtk-sysirq: Convert to a platform driver
> -------------------------------------------------------------------------------
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> 
> View/Reply Online (#590): https://groups.io/g/kernelci-results/message/590
> Mute This Topic: https://groups.io/mt/76222198/924702
> Group Owner: kernelci-results+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci-results/unsub  [guillaume.tucker@collabora.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

