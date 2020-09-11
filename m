Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A22C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0989221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZnHrCo0I";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="cxxT3h13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgIKQIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:08:06 -0400
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:40842
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726308AbgIKQHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gbvhytky6xpx7itkhb67ktsxbiwpnxix; d=codeaurora.org; t=1599836133;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=TcyM3JEZsPTMsOROT6ucshxdgW+PMxcnkDNjHjMIG1E=;
        b=ZnHrCo0Ixrj+w04jVDgQsHPbgOkrLnr7WF6diIQ2ze/pprCXUfr5SzI39Dpkldn3
        OnYS8RhNYPNK//orkNNjbQCtvCqcB25CB8mEAJpftyNKPvRqjURdyWBsrbIlgVsi+SC
        dCN+unBWhgtaxk/L5k8VGiyDWemZW3z/iORpaimM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599836133;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=TcyM3JEZsPTMsOROT6ucshxdgW+PMxcnkDNjHjMIG1E=;
        b=cxxT3h13Oe2baWHtZIH0HlDWSR1r1J9U7UF5QSEyJFgbCrvuQUjDJmfYqv4Es2oE
        /FTdTNcsKPbcbxP4BhotqFgsV8o6sqyzQ9gFCNBBkbAnop0gQ9CAuZxioxAlvXI6Mih
        lSTxin1Y2CAGMwLA6o5xh5ILVWKFbC/l0fCqgFEI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D595BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>,
        Bhagavathi Perumal S <bperumal@codeaurora.org>,
        Ganesh Sesetti <gseset@codeaurora.org>,
        Govindaraj Saminathan <gsamin@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>,
        ath11k@lists.infradead.org
Subject: Re: drivers/net/wireless/ath/ath11k/ahb.c:919:15: warning: cast to smaller integer type 'enum ath11k_hw_rev' from 'const void
References: <202009110445.WqWCY2F0%lkp@intel.com>
Date:   Fri, 11 Sep 2020 14:55:33 +0000
In-Reply-To: <202009110445.WqWCY2F0%lkp@intel.com> (kernel test robot's
        message of "Fri, 11 Sep 2020 04:52:50 +0800")
Message-ID: <010101747daa1692-fd5e413c-b3ab-41b1-8d57-cc9ad7e0a429-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.11-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ ath11k

Hi,

can someone look at the ath11k warnings below and send fixes, please?
Some of them might be already fixed, like the one about enum
scan_priority.

Kalle

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7fe10096c1508c7f033d34d0741809f8eecc1ed4
> commit: d5c65159f2895379e11ca13f62feabe93278985d ath11k: driver for
> Qualcomm IEEE 802.11ax devices
> date:   10 months ago
> config: x86_64-randconfig-a015-20200910 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project
> 0a5dc7effb191eff740e0e7ae7bd8e1f6bdb3ad9)
> reproduce (this is a W=1 build):
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         git checkout d5c65159f2895379e11ca13f62feabe93278985d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> drivers/net/wireless/ath/ath11k/ahb.c:919:15: warning: cast to
>>> smaller integer type 'enum ath11k_hw_rev' from 'const void *'
>>> [-Wvoid-pointer-to-enum-cast]
>            ab->hw_rev = (enum ath11k_hw_rev)of_id->data;
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1 warning generated.
> --
>>> drivers/net/wireless/ath/ath11k/wmi.c:142:8: warning: format
>>> specifies type 'unsigned char' but the argument has type 'u16' (aka
>>> 'unsigned short') [-Wformat]
>                                       tlv_tag, ptr - begin, len, tlv_len);
>                                       ^~~~~~~
>    drivers/net/wireless/ath/ath11k/wmi.c:142:35: warning: format specifies type 'unsigned char' but the argument has type 'u16' (aka 'unsigned short') [-Wformat]
>                                       tlv_tag, ptr - begin, len, tlv_len);
>                                                                  ^~~~~~~
>    drivers/net/wireless/ath/ath11k/wmi.c:150:8: warning: format specifies type 'unsigned char' but the argument has type 'u16' (aka 'unsigned short') [-Wformat]
>                                       tlv_tag, ptr - begin, tlv_len,
>                                       ^~~~~~~
>    drivers/net/wireless/ath/ath11k/wmi.c:150:30: warning: format specifies type 'unsigned char' but the argument has type 'u16' (aka 'unsigned short') [-Wformat]
>                                       tlv_tag, ptr - begin, tlv_len,
>                                                             ^~~~~~~
>    drivers/net/wireless/ath/ath11k/wmi.c:1812:23: warning: implicit conversion from enumeration type 'enum wmi_scan_priority' to different enumeration type 'enum scan_priority' [-Wenum-conversion]
>            arg->scan_priority = WMI_SCAN_PRIORITY_LOW;
>                               ~ ^~~~~~~~~~~~~~~~~~~~~
>    5 warnings generated.
> --
>>> drivers/net/wireless/ath/ath11k/mac.c:3970:6: warning: format
>>> specifies type 'unsigned short' but the argument has type 'u32'
>>> (aka 'unsigned int') [-Wformat]
>                       ctx->def.chan->center_freq, ctx->def.width, ctx);
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/net/wireless/ath/ath11k/debug.h:275:37: note: expanded from macro 'ath11k_dbg'
>                    __ath11k_dbg(ar, dbg_mask, fmt, ##__VA_ARGS__); \
>                                               ~~~    ^~~~~~~~~~~
>    drivers/net/wireless/ath/ath11k/mac.c:3994:6: warning: format specifies type 'unsigned short' but the argument has type 'u32' (aka 'unsigned int') [-Wformat]
>                       ctx->def.chan->center_freq, ctx->def.width, ctx);
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/net/wireless/ath/ath11k/debug.h:275:37: note: expanded from macro 'ath11k_dbg'
>                    __ath11k_dbg(ar, dbg_mask, fmt, ##__VA_ARGS__); \
>                                               ~~~    ^~~~~~~~~~~
>    drivers/net/wireless/ath/ath11k/mac.c:4241:7: warning: format specifies type 'unsigned short' but the argument has type 'u32' (aka 'unsigned int') [-Wformat]
>                               vifs[i].old_ctx->def.chan->center_freq,
>                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/net/wireless/ath/ath11k/debug.h:275:37: note: expanded from macro 'ath11k_dbg'
>                    __ath11k_dbg(ar, dbg_mask, fmt, ##__VA_ARGS__); \
>                                               ~~~    ^~~~~~~~~~~
>    drivers/net/wireless/ath/ath11k/mac.c:4242:7: warning: format specifies type 'unsigned short' but the argument has type 'u32' (aka 'unsigned int') [-Wformat]
>                               vifs[i].new_ctx->def.chan->center_freq,
>                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/net/wireless/ath/ath11k/debug.h:275:37: note: expanded from macro 'ath11k_dbg'
>                    __ath11k_dbg(ar, dbg_mask, fmt, ##__VA_ARGS__); \
>                                               ~~~    ^~~~~~~~~~~
>    drivers/net/wireless/ath/ath11k/mac.c:4337:6: warning: format specifies type 'unsigned short' but the argument has type 'u32' (aka 'unsigned int') [-Wformat]
>                       ctx->def.chan->center_freq, ctx->def.width, ctx, changed);
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/net/wireless/ath/ath11k/debug.h:275:37: note: expanded from macro 'ath11k_dbg'
>                    __ath11k_dbg(ar, dbg_mask, fmt, ##__VA_ARGS__); \
>                                               ~~~    ^~~~~~~~~~~
>>> drivers/net/wireless/ath/ath11k/mac.c:4640:22: warning: format
>>> specifies type 'unsigned char' but the argument has type 'u32' (aka
>>> 'unsigned int') [-Wformat]
>                       arvif->vdev_id, rate, nss, sgi);
>                                       ^~~~
>    drivers/net/wireless/ath/ath11k/debug.h:275:37: note: expanded from macro 'ath11k_dbg'
>                    __ath11k_dbg(ar, dbg_mask, fmt, ##__VA_ARGS__); \
>                                               ~~~    ^~~~~~~~~~~
>    6 warnings generated.
> --
>>> drivers/net/wireless/ath/ath11k/dp_rx.c:977:8: warning: format specifies type 'unsigned char' but the argument has type 'u16' (aka 'unsigned short') [-Wformat]
>                                       tlv_tag, ptr - begin, len, tlv_len);
>                                       ^~~~~~~
>    drivers/net/wireless/ath/ath11k/dp_rx.c:977:35: warning: format specifies type 'unsigned char' but the argument has type 'u16' (aka 'unsigned short') [-Wformat]
>                                       tlv_tag, ptr - begin, len, tlv_len);
>                                                                  ^~~~~~~
>    2 warnings generated.
>
> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5c65159f2895379e11ca13f62feabe93278985d
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git fetch --no-tags linus master
> git checkout d5c65159f2895379e11ca13f62feabe93278985d
> vim +919 drivers/net/wireless/ath/ath11k/ahb.c
>
>    879	
>    880	static int ath11k_ahb_probe(struct platform_device *pdev)
>    881	{
>    882		struct ath11k_base *ab;
>    883		const struct of_device_id *of_id;
>    884		struct resource *mem_res;
>    885		void __iomem *mem;
>    886		int ret;
>    887	
>    888		of_id = of_match_device(ath11k_ahb_of_match, &pdev->dev);
>    889		if (!of_id) {
>    890			dev_err(&pdev->dev, "failed to find matching device tree id\n");
>    891			return -EINVAL;
>    892		}
>    893	
>    894		mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>    895		if (!mem_res) {
>    896			dev_err(&pdev->dev, "failed to get IO memory resource\n");
>    897			return -ENXIO;
>    898		}
>    899	
>    900		mem = devm_ioremap_resource(&pdev->dev, mem_res);
>    901		if (IS_ERR(mem)) {
>    902			dev_err(&pdev->dev, "ioremap error\n");
>    903			return PTR_ERR(mem);
>    904		}
>    905	
>    906		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>    907		if (ret) {
>    908			dev_err(&pdev->dev, "failed to set 32-bit consistent dma\n");
>    909			return ret;
>    910		}
>    911	
>    912		ab = ath11k_core_alloc(&pdev->dev);
>    913		if (!ab) {
>    914			dev_err(&pdev->dev, "failed to allocate ath11k base\n");
>    915			return -ENOMEM;
>    916		}
>    917	
>    918		ab->pdev = pdev;
>  > 919		ab->hw_rev = (enum ath11k_hw_rev)of_id->data;
>    920		ab->mem = mem;
>    921		ab->mem_len = resource_size(mem_res);
>    922		platform_set_drvdata(pdev, ab);
>    923	
>    924		ret = ath11k_hal_srng_init(ab);
>    925		if (ret)
>    926			goto err_core_free;
>    927	
>    928		ret = ath11k_ce_alloc_pipes(ab);
>    929		if (ret) {
>    930			ath11k_err(ab, "failed to allocate ce pipes: %d\n", ret);
>    931			goto err_hal_srng_deinit;
>    932		}
>    933	
>    934		ath11k_ahb_init_qmi_ce_config(ab);
>    935	
>    936		ret = ath11k_ahb_config_irq(ab);
>    937		if (ret) {
>    938			ath11k_err(ab, "failed to configure irq: %d\n", ret);
>    939			goto err_ce_free;
>    940		}
>    941	
>    942		ret = ath11k_core_init(ab);
>    943		if (ret) {
>    944			ath11k_err(ab, "failed to init core: %d\n", ret);
>    945			goto err_ce_free;
>    946		}
>    947	
>    948		return 0;
>    949	
>    950	err_ce_free:
>    951		ath11k_ce_free_pipes(ab);
>    952	
>    953	err_hal_srng_deinit:
>    954		ath11k_hal_srng_deinit(ab);
>    955	
>    956	err_core_free:
>    957		ath11k_core_free(ab);
>    958		platform_set_drvdata(pdev, NULL);
>    959	
>    960		return ret;
>    961	}
>    962	
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
