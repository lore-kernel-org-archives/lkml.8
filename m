Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C20C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F293C2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594617068;
	bh=u99mantlgDlYGSKWrmXRQ9Ww3mkTcScp3HJLB+/bxQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P/4dVqhu9PVPbplskd9stkH++gPqTLy6GtgjAUTLmLWtJ8x+dfWAV1Zk8lFVLZUVR
	 Q9OYRGg6dl7Txwp6W6ua5OGsRZ3bNSHkloXekPH8Mc5YgHvN7S5RvszKTikZjrTOLR
	 hNm2zv8Z5htNdKun3eNoh4UPfnCMaD05Kxv9wW4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgGMFLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgGMFLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:11:06 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 338E520724;
        Mon, 13 Jul 2020 05:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594617066;
        bh=u99mantlgDlYGSKWrmXRQ9Ww3mkTcScp3HJLB+/bxQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YtahfSmoj3Mu4y0qrtvqwCadHk8BsF4GKBGIC8KruJBvz1ciDXjyurjLM5y3Wc2VJ
         TmKp+MMlfFXs4U17zLLSE96H1KR7ZjM/87zXFIQCcRNjXG+lDP2OJrrY1ibce5Qjwm
         GXi0uLAB4fPg3QbAnFgWW3c5sWIFxGrwkFSLRAQ8=
Date:   Mon, 13 Jul 2020 10:41:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] phy: allwinner: Make PHY_SUN6I_MIPI_DPHY depend on
 COMMON_CLK
Message-ID: <20200713051102.GU34333@vkoul-mobl>
References: <1594113746-25393-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594113746-25393-1-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-07-20, 17:22, Tiezhu Yang wrote:
> When CONFIG_ARCH_SUNXI is not set but CONFIG_COMPILE_TEST=y,
> CONFIG_HAVE_CLK=y, CONFIG_HAVE_LEGACY_CLK=y, there exists
> the following build errors with CONFIG_PHY_SUN6I_MIPI_DPHY=y:
> 
> drivers/phy/allwinner/phy-sun6i-mipi-dphy.o: In function `sun6i_dphy_init':
> phy-sun6i-mipi-dphy.c:(.text+0x320): undefined reference to `clk_set_rate_exclusive'
> drivers/phy/allwinner/phy-sun6i-mipi-dphy.o: In function `sun6i_dphy_exit':
> phy-sun6i-mipi-dphy.c:(.text+0x2c8): undefined reference to `clk_rate_exclusive_put'
> 
> clk_set_rate_exclusive() and clk_rate_exclusive_put() are defined
> in drivers/clk/clk.c, this file is built under CONFIG_COMMON_CLK,
> so in order to build drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
> successful used with various configs, CONFIG_PHY_SUN6I_MIPI_DPHY
> should depend on CONFIG_COMMON_CLK.

Applied, thanks

-- 
~Vinod
