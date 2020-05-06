Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3346BC47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 119C620753
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BS21sHH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgEFW2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 18:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbgEFW2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 18:28:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F74C061A0F;
        Wed,  6 May 2020 15:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=WRT8zecINQ4TfsGBK/5Thu+/n6sZfvk/O+ayHUpUAJ8=; b=BS21sHH0tt0oR4lqM/Tx/zhNwF
        H3AIJTLYqVop0wNFaor6qz22KPX5DqURcTeAQVpHgYqDqnNnQ1cnfQ7PI5ENTIm0j7rO33VPEseEn
        B16QeyKIxiuAfnqGzF5DHCoA3s2Wl2UmgHhCl/rILZWwS3N1TWWWP1s59qwtpDE+aqnN9imyVqJVk
        sGUeoqi9D0dSPA5Cmh5PUN+bl/bZxPEuc7lkxU7RkoK5jsG6fK1B3zvF7CkI9XfwoonQQdYHVAW7C
        /eFSzPRR9nMX/ahh8AHTcePoxVq00jTSfo92JOmqh+U3My29Rks2pPhnlO52cwkJj/AwDFyYbSzT7
        c6q8htCQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWSWG-0001zQ-Aw; Wed, 06 May 2020 22:28:00 +0000
Subject: Re: [PATCH v2 3/4] clk: Add Baikal-T1 CCU PLLs driver
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tony Xie <tony.xie@rock-chips.com>, Wen He <wen.he_1@nxp.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20200306130053.BCBFC803078F@mail.baikalelectronics.ru>
 <20200506222300.30895-1-Sergey.Semin@baikalelectronics.ru>
 <20200506222300.30895-4-Sergey.Semin@baikalelectronics.ru>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9259445e-86a8-8e4a-58c9-822bd00d62f8@infradead.org>
Date:   Wed, 6 May 2020 15:27:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506222300.30895-4-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Typo(s):

On 5/6/20 3:22 PM, Serge Semin wrote:
> diff --git a/drivers/clk/baikal-t1/Kconfig b/drivers/clk/baikal-t1/Kconfig
> new file mode 100644
> index 000000000000..e1257af9f49e
> --- /dev/null
> +++ b/drivers/clk/baikal-t1/Kconfig
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config CLK_BAIKAL_T1
> +	bool "Baikal-T1 Clocks Control Unit interface"
> +	depends on (MIPS_BAIKAL_T1 && OF) || COMPILE_TEST
> +	default MIPS_BAIKAL_T1
> +	help
> +	  Clocks Control Unit is the core of Baikal-T1 SoC System Controller
> +	  responsible for the chip subsystems clocking and resetting. It
> +	  consists of multiple global clock domains, which can be reset by
> +	  means of the CCU control registers. These domains and devices placed
> +	  in them are fed with clocks generated by a hierarchy of PLLs,
> +	  configurable and fixed clock dividers. Enable this option to be able
> +	  to select Baikal-T1 CCU PLLs and Dividers drivers.
> +
> +if CLK_BAIKAL_T1
> +
> +config CLK_BT1_CCU_PLL
> +	bool "Baikal-T1 CCU PLLs support"
> +	select MFD_SYSCON
> +	default MIPS_BAIKAL_T1
> +	help
> +	  Enable this to support the PLLs embedded into the Baikal-T1 SoC
> +	  System Controller. These are five PLLs placed at the root of the
> +	  clocks hierarchy, right after an external reference osciallator

	                                                      oscillator

> +	  (normally of 25MHz). They are used to generate high frequency
> +	  signals, which are either directly wired to the consumers (like
> +	  CPUs, DDR, etc) or passed over the clock dividers to be only then

and while you are here:

                     etc.)

> +	  used as an individual reference clock of a target device.
> +
> +endif

thanks.
-- 
~Randy

