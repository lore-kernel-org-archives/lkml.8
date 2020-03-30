Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62F1C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 03:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A849C20732
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 03:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IpJk2Wnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgC3DOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 23:14:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgC3DOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 23:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=tOIXPksrFt6cwhiEXwu768AFaEMWovTs91zSUDw/0/Q=; b=IpJk2WnwziGB1J1HhyptrobQGF
        ioSiScBxKkLRYrT3QAkOLW78j1lPuijybtjhj3xl1lh/s7H+fEd+vU8I0N+AcL/hgqyHjSEHeVAp8
        58w6rWurwoN9GhecLoAxyVqc021aY58wbh5o6UfTTGthI8wIAvYek3v/4w7siTv7CceCDA0WcRvS+
        rLzs67nYzlKLkRTKD1oxPKqO/X8KNtzFKRNVjd84wNC0CES0chRent/hTLNhLC+MzY54OMxR+gFoP
        wEpWs7TZ3haEmo2GzgDr4/8n6v4OEqmUNpjDpABlGnlrSyulCAR8kZ83J5SwH7hoqghsA28ONSpcS
        pZJrAjww==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIksK-000346-Sa; Mon, 30 Mar 2020 03:14:08 +0000
Subject: Re: [PATCH 4/6] soc: bt1: Add Baikal-T1 AXI-bus EHB driver
To:     Sergey.Semin@baikalelectronics.ru
List-Id: <soc.lore.kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-kernel@vger.kernel.org
References: <20200306130721.10347-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130735.0EE9D8030700@mail.baikalelectronics.ru>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8401560d-9f2e-baff-ac34-1ac6bd1d3e57@infradead.org>
Date:   Sun, 29 Mar 2020 20:14:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200306130735.0EE9D8030700@mail.baikalelectronics.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 3/6/20 5:07 AM, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> AXI3-bus is the main communication bus connecting all high-speed peripheral
> IP-cores with RAM controller and MIPS P5600 cores. Baikal-T1 SoC provides a
> way to detect the bus protocol errors and report a short info about it by
> means of the AXI-bus Errors Handler Block (AXI EHB). The block rises an

                                                                 raises an

> interrupt indicating an AXI protocol error at an attempt either to reach
> a non-existent slave device or to perform an invalid operation with a
> slave IP-block. This driver provides the interrupt handler, which prints
> an error message with a faulty address and updates an errors counter,
> and exposes a sysfs-node to inject the described types of errors.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: soc@kernel.org
> ---

> diff --git a/drivers/soc/baikal-t1/Kconfig b/drivers/soc/baikal-t1/Kconfig
> new file mode 100644
> index 000000000000..aca155350612
> --- /dev/null
> +++ b/drivers/soc/baikal-t1/Kconfig
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0
> +menu "Baikal-T1 SoC drivers"
> +
> +config SOC_BAIKAL_T1
> +	def_bool y
> +	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
> +
> +config BT1_AXI_EHB
> +	bool "Baikal-T1 AXI-bus Errors Handler Block"
> +	depends on SOC_BAIKAL_T1 && OF
> +	help
> +	  Baikal-T1 CCU registers space as being MFD provides an access to the

	                                             and provides access to the

> +	  AXI-bus Errors Handler Block (AXI EHB). It rises an interrupt

	                                             raises

> +	  indicating an AXI protocol error at an attempt either to reach a
> +	  non-existent slave device or to perform an invalid operation with a
> +	  slave IP-block. This driver provides the interrupt handler, which
> +	  prints an error message with a faulty address and updates an errors
> +	  counter.
> +
> +	  If unsure, say N.
> +
> +endmenu

-- 
~Randy

