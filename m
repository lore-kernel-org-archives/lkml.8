Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BE5C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC6E2078A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgHQKCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:02:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42386 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgHQKCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:02:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 2CE0A2969DF
Subject: Re: mainline/master bisection: baseline.bootrr.rockchip-pcie-probed
 on rk3399-gru-kevin
References: <5f394e3f.1c69fb81.4accc.4cf0@mx.google.com>
Cc:     kernelci-results@groups.io, gtucker@collabora.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        kernel@collabora.com
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Rob Herring <robh@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <0070b9d1-9108-3d26-cb91-bfeb7cb97e9a@collabora.com>
Date:   Mon, 17 Aug 2020 11:02:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5f394e3f.1c69fb81.4accc.4cf0@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please see the bisection report below about a driver probe
regression with rockchip-pcie.

Reports aren't automatically sent to the public while we're
trialing new bisection features on kernelci.org but this one
looks valid.

It seems to be due to this error:

  <6>[   16.842128] rockchip-pcie f8000000.pcie: no vpcie12v regulator found

Full log:

  https://storage.kernelci.org/mainline/master/v5.8-13249-ga1d21081a60d/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html

The issue was not there in v5.8 when the driver was probing fine:

  https://storage.kernelci.org/mainline/master/v5.8/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html

Hope this helps.

Thanks,
Guillaume

On 16/08/2020 16:18, KernelCI bot wrote:
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
> mainline/master bisection: baseline.bootrr.rockchip-pcie-probed on rk3399-gru-kevin
> 
> Summary:
>   Start:      a1d21081a60d Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
>   Plain log:  https://storage.kernelci.org/mainline/master/v5.8-13249-ga1d21081a60d/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
>   HTML log:   https://storage.kernelci.org/mainline/master/v5.8-13249-ga1d21081a60d/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
>   Result:     2f96593ecc37 of_address: Add bus type match for pci ranges parser
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       mainline
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>   Branch:     master
>   Target:     rk3399-gru-kevin
>   CPU arch:   arm64
>   Lab:        lab-collabora
>   Compiler:   gcc-8
>   Config:     defconfig
>   Test case:  baseline.bootrr.rockchip-pcie-probed
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 2f96593ecc37e98bf99525f0629128080533867f
> Author: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Date:   Tue Jul 28 23:36:55 2020 +0800
> 
>     of_address: Add bus type match for pci ranges parser
>     
>     So the parser can be used to parse range property of ISA bus.
>     
>     As they're all using PCI-like method of range property, there is no need
>     start a new parser.
>     
>     Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>     Reviewed-by: Rob Herring <robh@kernel.org>
>     Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 8eea3f6e29a4..813936d419ad 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -49,6 +49,7 @@ struct of_bus {
>  	u64		(*map)(__be32 *addr, const __be32 *range,
>  				int na, int ns, int pna);
>  	int		(*translate)(__be32 *addr, u64 offset, int na);
> +	bool	has_flags;
>  	unsigned int	(*get_flags)(const __be32 *addr);
>  };
>  
> @@ -364,6 +365,7 @@ static struct of_bus of_busses[] = {
>  		.count_cells = of_bus_pci_count_cells,
>  		.map = of_bus_pci_map,
>  		.translate = of_bus_pci_translate,
> +		.has_flags = true,
>  		.get_flags = of_bus_pci_get_flags,
>  	},
>  #endif /* CONFIG_PCI */
> @@ -375,6 +377,7 @@ static struct of_bus of_busses[] = {
>  		.count_cells = of_bus_isa_count_cells,
>  		.map = of_bus_isa_map,
>  		.translate = of_bus_isa_translate,
> +		.has_flags = true,
>  		.get_flags = of_bus_isa_get_flags,
>  	},
>  	/* Default */
> @@ -698,9 +701,10 @@ static int parser_init(struct of_pci_range_parser *parser,
>  
>  	parser->node = node;
>  	parser->pna = of_n_addr_cells(node);
> -	parser->na = of_bus_n_addr_cells(node);
> -	parser->ns = of_bus_n_size_cells(node);
>  	parser->dma = !strcmp(name, "dma-ranges");
> +	parser->bus = of_match_bus(node);
> +
> +	parser->bus->count_cells(parser->node, &parser->na, &parser->ns);
>  
>  	parser->range = of_get_property(node, name, &rlen);
>  	if (parser->range == NULL)
> @@ -732,6 +736,7 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
>  	int na = parser->na;
>  	int ns = parser->ns;
>  	int np = parser->pna + na + ns;
> +	int busflag_na = 0;
>  
>  	if (!range)
>  		return NULL;
> @@ -739,12 +744,13 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
>  	if (!parser->range || parser->range + np > parser->end)
>  		return NULL;
>  
> -	if (parser->na == 3)
> -		range->flags = of_bus_pci_get_flags(parser->range);
> -	else
> -		range->flags = 0;
> +	range->flags = parser->bus->get_flags(parser->range);
> +
> +	/* A extra cell for resource flags */
> +	if (parser->bus->has_flags)
> +		busflag_na = 1;
>  
> -	range->pci_addr = of_read_number(parser->range, na);
> +	range->bus_addr = of_read_number(parser->range + busflag_na, na - busflag_na);
>  
>  	if (parser->dma)
>  		range->cpu_addr = of_translate_dma_address(parser->node,
> @@ -759,11 +765,10 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
>  	/* Now consume following elements while they are contiguous */
>  	while (parser->range + np <= parser->end) {
>  		u32 flags = 0;
> -		u64 pci_addr, cpu_addr, size;
> +		u64 bus_addr, cpu_addr, size;
>  
> -		if (parser->na == 3)
> -			flags = of_bus_pci_get_flags(parser->range);
> -		pci_addr = of_read_number(parser->range, na);
> +		flags = parser->bus->get_flags(parser->range);
> +		bus_addr = of_read_number(parser->range + busflag_na, na - busflag_na);
>  		if (parser->dma)
>  			cpu_addr = of_translate_dma_address(parser->node,
>  					parser->range + na);
> @@ -774,7 +779,7 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
>  
>  		if (flags != range->flags)
>  			break;
> -		if (pci_addr != range->pci_addr + range->size ||
> +		if (bus_addr != range->bus_addr + range->size ||
>  		    cpu_addr != range->cpu_addr + range->size)
>  			break;
>  
> diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> index 763022ed3456..88bc943405cd 100644
> --- a/include/linux/of_address.h
> +++ b/include/linux/of_address.h
> @@ -6,8 +6,11 @@
>  #include <linux/of.h>
>  #include <linux/io.h>
>  
> +struct of_bus;
> +
>  struct of_pci_range_parser {
>  	struct device_node *node;
> +	struct of_bus *bus;
>  	const __be32 *range;
>  	const __be32 *end;
>  	int na;
> @@ -119,6 +122,7 @@ static inline void __iomem *of_iomap(struct device_node *device, int index)
>  	return NULL;
>  }
>  #endif
> +#define of_range_parser_init of_pci_range_parser_init
>  
>  #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_PCI)
>  extern const __be32 *of_get_pci_address(struct device_node *dev, int bar_no,
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
> # good: [5b6570bbb26f1dfad5663d99351820865e8c5c7e] irqchip/imx-intmux: Fix irqdata regs save in imx_intmux_runtime_suspend()
> git bisect good 5b6570bbb26f1dfad5663d99351820865e8c5c7e
> # good: [be577b8125f89af549111a648ed66d63b29c666d] arm64: dts: qcom: msm8992: Add a SCM node
> git bisect good be577b8125f89af549111a648ed66d63b29c666d
> # skip: [8f7be6291529011a58856bf178f52ed5751c68ac] Merge tag 'mmc-v5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
> git bisect skip 8f7be6291529011a58856bf178f52ed5751c68ac
> # good: [4ff8a356daafaafbf90141ee7a3b8fdc18e560a8] ia64: switch to ->regset_get()
> git bisect good 4ff8a356daafaafbf90141ee7a3b8fdc18e560a8
> # good: [79560b8aeb01a715f75060e40085e641248bee51] ASoC: SOF: Intel: disable traces when switching to S0Ix D0I3
> git bisect good 79560b8aeb01a715f75060e40085e641248bee51
> # good: [d7a1a4f47d804b32b3ca7a98b03425cf90cb9098] soc: ux500: Use custom soc attribute group instead of device_create_file
> git bisect good d7a1a4f47d804b32b3ca7a98b03425cf90cb9098
> # good: [80dcf024929788f155aaff3d2cffb4975ce1e3fd] ARM: sunxi: configs: Enable the Mailbox driver
> git bisect good 80dcf024929788f155aaff3d2cffb4975ce1e3fd
> # skip: [605cad8343721c4a53e80f87d5b1161baf1a7d2b] mm: filemap: add missing FGP_ flags in kerneldoc comment for pagecache_get_page
> git bisect skip 605cad8343721c4a53e80f87d5b1161baf1a7d2b
> # good: [c211ab5f5e6e304aee43bb5ef6919fbe4e41ef64] MIPS: ingenic: Add support for the JZ4725B SoC
> git bisect good c211ab5f5e6e304aee43bb5ef6919fbe4e41ef64
> # good: [69094c20323c5efff462a2e02d0bb7b6608779ad] Merge tag 'x86-microcode-2020-08-03' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 69094c20323c5efff462a2e02d0bb7b6608779ad
> # good: [39e5993d0d452b9ef612f2fcf7ca77ff319438f4] ima: Shallow copy the args_p member of ima_rule_entry.lsm elements
> git bisect good 39e5993d0d452b9ef612f2fcf7ca77ff319438f4
> # good: [49dc2fb0e04679422369f54ff3ed720616ee7eb3] hwmon: (ina2xx) Replace HTTP links with HTTPS ones
> git bisect good 49dc2fb0e04679422369f54ff3ed720616ee7eb3
> # skip: [fffe3ae0ee84e25d2befe2ae59bc32aa2b6bc77b] Merge tag 'for-linus-hmm' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
> git bisect skip fffe3ae0ee84e25d2befe2ae59bc32aa2b6bc77b
> # good: [6878ba91ce84f7a07887a0615af70f969508839f] ASoC: meson: axg-tdm-interface: fix link fmt setup
> git bisect good 6878ba91ce84f7a07887a0615af70f969508839f
> # skip: [2c547f9da0539ad1f7ef7f08c8c82036d61b011a] efi: provide empty efi_enter_virtual_mode implementation
> git bisect skip 2c547f9da0539ad1f7ef7f08c8c82036d61b011a
> # good: [54ae1055e55049dc799d02cfc06d2ae7ef2beffc] arm64: defconfig: enable CONFIG_FSL_ENETC_QOS
> git bisect good 54ae1055e55049dc799d02cfc06d2ae7ef2beffc
> # good: [c365ee561ee343b587df9f5ba191c1a090d4f43e] power: supply: test_power: Fix battery_current initial value
> git bisect good c365ee561ee343b587df9f5ba191c1a090d4f43e
> # good: [8902c6f96364d1117236948d6c7b9178f428529c] powerpc/ppc-opcode: Add divde and divdeu opcodes
> git bisect good 8902c6f96364d1117236948d6c7b9178f428529c
> # good: [f62fc08fdc51d18292eb13bd345dfb159f024746] dyndbg: use gcc ?: to reduce word count
> git bisect good f62fc08fdc51d18292eb13bd345dfb159f024746
> # good: [860e73b49cd933c708e3e1e1e07cdea81b6acd1c] Merge tag 'misc-habanalabs-next-2020-07-24' of git://people.freedesktop.org/~gabbayo/linux into char-misc-next
> git bisect good 860e73b49cd933c708e3e1e1e07cdea81b6acd1c
> # good: [786d33c887e15061ff95942db68fe5c6ca98e5fc] mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and enable SSC for GL975x
> git bisect good 786d33c887e15061ff95942db68fe5c6ca98e5fc
> # good: [7c2b325020be7d5ec375501c2aead46fc0496c17] ARM: dts: imx6ul: Add ASRC device node
> git bisect good 7c2b325020be7d5ec375501c2aead46fc0496c17
> # skip: [1fa2c0a0c814fbae0eb3e79a510765225570d043] Merge tag 'seccomp-v5.9-rc1-fix1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
> git bisect skip 1fa2c0a0c814fbae0eb3e79a510765225570d043
> # good: [5128063739d293b9faf8ffaa9a5dfd622bc954f5] fanotify: report events with parent dir fid to sb/mount/non-dir marks
> git bisect good 5128063739d293b9faf8ffaa9a5dfd622bc954f5
> # skip: [4510a5a98aff2d395e67890c480c0665f953ea00] ocfs2: replace HTTP links with HTTPS ones
> git bisect skip 4510a5a98aff2d395e67890c480c0665f953ea00
> # good: [9c3df2b1993da9ab1110702d7b2815d5cd8c02f3] clk: qcom: gcc: Make disp gpll0 branch aon for sc7180/sdm845
> git bisect good 9c3df2b1993da9ab1110702d7b2815d5cd8c02f3
> # good: [694dd304cc294b69db7191cec1d83e5a29c6a4b0] drm/msm/dsi: Add phy configuration for SDM630/636/660
> git bisect good 694dd304cc294b69db7191cec1d83e5a29c6a4b0
> # good: [5ad79c20b6d28467db643ac107bbdaa01aa93a23] leds: trigger: gpio: Avoid warning on update of inverted
> git bisect good 5ad79c20b6d28467db643ac107bbdaa01aa93a23
> # good: [c322fa0b3fa948010a278794e60c45ec860e4a1e] PCI: mvebu: Use struct pci_host_bridge.windows list directly
> git bisect good c322fa0b3fa948010a278794e60c45ec860e4a1e
> # good: [206c01d1ec14b5e238132ce7c8891ba02c3328c8] ARM: dts: ux500: Supply nodes for the other 2 AB8500 PWM devices
> git bisect good 206c01d1ec14b5e238132ce7c8891ba02c3328c8
> # good: [7ecd4a8175104b55de120dd8847e0bfabf7d75aa] PCI: Replace http:// links with https://
> git bisect good 7ecd4a8175104b55de120dd8847e0bfabf7d75aa
> # good: [f69f15a3c3f0f9ad049c5e0ef3f3bfd6c791df06] dt-bindings: mtd: Convert imx nand to json-schema
> git bisect good f69f15a3c3f0f9ad049c5e0ef3f3bfd6c791df06
> # good: [6c17e9dd5cdd352276180f47c0a8b24a1d4661af] ASoC: hda/tegra: Set buffer alignment to 128 bytes
> git bisect good 6c17e9dd5cdd352276180f47c0a8b24a1d4661af
> # good: [0d776e5bede6d375c617a03262eee9d2a8a58b75] mmc: via-sdmmc: use generic power management
> git bisect good 0d776e5bede6d375c617a03262eee9d2a8a58b75
> # bad: [37e5c69ffd4195c35aeb24978701f40ac82af7b1] MIPS: head.S: Init fw_passed_dtb to builtin DTB
> git bisect bad 37e5c69ffd4195c35aeb24978701f40ac82af7b1
> # good: [0d10d17bac3d5d4e97d6f008aa3c329a83d3b283] MIPS: X2000: Add X2000 system type.
> git bisect good 0d10d17bac3d5d4e97d6f008aa3c329a83d3b283
> # good: [64aa9fd01459bbdc51a7400552ba4741df37089d] MIPS: ath79: Remove unused include <asm/mips_machine.h>
> git bisect good 64aa9fd01459bbdc51a7400552ba4741df37089d
> # bad: [21a379a8cf917e4c45a3c50d8203859ea318c450] MIPS: Loongson64: Enlarge IO_SPACE_LIMIT
> git bisect bad 21a379a8cf917e4c45a3c50d8203859ea318c450
> # good: [6bc9c1619de3a8a03b412c925404440566568a64] MIPS: ingenic: Enable JZ4780_NEMC manually
> git bisect good 6bc9c1619de3a8a03b412c925404440566568a64
> # bad: [2f96593ecc37e98bf99525f0629128080533867f] of_address: Add bus type match for pci ranges parser
> git bisect bad 2f96593ecc37e98bf99525f0629128080533867f
> # good: [aa35a5eee58cce7863b7c0d5e94e3e2e6de59d08] memory: jz4780-nemc: Do not build by default
> git bisect good aa35a5eee58cce7863b7c0d5e94e3e2e6de59d08
> # first bad commit: [2f96593ecc37e98bf99525f0629128080533867f] of_address: Add bus type match for pci ranges parser
> -------------------------------------------------------------------------------
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> 
> View/Reply Online (#591): https://groups.io/g/kernelci-results/message/591
> Mute This Topic: https://groups.io/mt/76225213/924702
> Group Owner: kernelci-results+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci-results/unsub  [guillaume.tucker@collabora.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

