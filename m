Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCA2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FBA2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eKX0lpjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbgE0QSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgE0QSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:18:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED34C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=RHgzXdboAvRH0Qxpb6780yAGJZR7CslW148oBOys/44=; b=eKX0lpjYtTpsYBwWEVSFQwb7Hk
        qDLr6pSgvf6PDdSUfNPyaAVk1gEuQkHfSAwhZ/aC8TONTyXLb8cfpQDaVRetTXaGC8aL4qekEFdiI
        YMVpgNVf+nOSXmLqzPtn91abUUuBGmKO4oZzHMuTRimazoFCmOAf2AQq4zYj7aVLbU34AdRpL/lwX
        AksRiCH12Y/Zm4mZxoSWfs2RhoxL8n3sdHSS7v5eMaaa6SxFZx+7GSLa12RX2qZDSD6jaRSqnX4aG
        epccXnoTShDXynRgebbPbJ1uB8TC2CSOwCIYN1doftGg6FkzD86LJtELWcqcWllyoXwqT1a8jFQ3/
        C/ElAMjQ==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.252])
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdylR-0008PW-JP; Wed, 27 May 2020 16:18:45 +0000
Subject: Re: [PATCH v2 1/1] phy: intel: Fix compilation error on FIELD_PREP
 usage
To:     Dilip Kota <eswara.kota@linux.intel.com>,
        linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org
Cc:     andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <8a309dd3c238efbaa59d1649704255d6f8b6c9c5.1590575358.git.eswara.kota@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7ad3253d-b581-4833-7e78-2b565b88a75c@infradead.org>
Date:   Wed, 27 May 2020 09:18:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <8a309dd3c238efbaa59d1649704255d6f8b6c9c5.1590575358.git.eswara.kota@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/20 3:56 AM, Dilip Kota wrote:
> FIELD_PREP expects constant arguments. Istead of doing FIELD_PREP
> operation on the arguments of combo_phy_w32_off_mask(), pass the
> final FIELD_PREP value as an argument.
> 
> Error reported as:
> In file included from include/linux/build_bug.h:5,
> from include/linux/bitfield.h:10,
> from drivers/phy/intel/phy-intel-combo.c:8:
> drivers/phy/intel/phy-intel-combo.c: In function 'combo_phy_w32_off_mask':
> include/linux/bitfield.h:52:28: warning: comparison is always false due to limited range of data type [-Wtype-limits]
> 
> include/linux/compiler.h:350:38: error: call to '__compiletime_assert_37' declared with attribute error: FIELD_PREP: mask is not constant
> 94 |   __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");          |   ^~~~~~~~~~~~~~~~
> drivers/phy/intel/phy-intel-combo.c:137:13: note: in expansion of macro 'FIELD_PREP'
> 137 |  reg_val |= FIELD_PREP(mask, val);
> |             ^~~~~~~~~~
> 
> ../include/linux/compiler.h:392:38: error: call to__compiletime_assert_137
>  declared with attribute error:
> BUILD_BUG_ON failed: (((mask) + (1ULL << (__builtin_ffsll(mask) - 1))) & (((mask) + (1ULL << (__builtin_ffsll(mask) - 1))) - 1)) != 0
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> 
> ../include/linux/bitfield.h:94:3: note: in expansion of macro __BF_FIELD_CHECK
>    __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
>    ^~~~~~~~~~~~~~~~
> ../drivers/phy/intel/phy-intel-combo.c:137:13: note: in expansion of macro FIELD_PREP
>   reg_val |= FIELD_PREP(mask, val);
>              ^~~~~~~~~~
> 
> Fixes: ac0a95a3ea78 ("phy: intel: Add driver support for ComboPhy")
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/phy/intel/phy-intel-combo.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/phy/intel/phy-intel-combo.c b/drivers/phy/intel/phy-intel-combo.c
> index c2a35be4cdfb..254ea7cba7ca 100644
> --- a/drivers/phy/intel/phy-intel-combo.c
> +++ b/drivers/phy/intel/phy-intel-combo.c
> @@ -134,7 +134,7 @@ static inline void combo_phy_w32_off_mask(void __iomem *base, unsigned int reg,
>  
>  	reg_val = readl(base + reg);
>  	reg_val &= ~mask;
> -	reg_val |= FIELD_PREP(mask, val);
> +	reg_val |= val;
>  	writel(reg_val, base + reg);
>  }
>  
> @@ -169,7 +169,7 @@ static int intel_cbphy_pcie_en_pad_refclk(struct intel_cbphy_iphy *iphy)
>  		return 0;
>  
>  	combo_phy_w32_off_mask(cbphy->app_base, PCIE_PHY_GEN_CTRL,
> -			       PCIE_PHY_CLK_PAD, 0);
> +			       PCIE_PHY_CLK_PAD, FIELD_PREP(PCIE_PHY_CLK_PAD, 0));
>  
>  	/* Delay for stable clock PLL */
>  	usleep_range(50, 100);
> @@ -192,7 +192,7 @@ static int intel_cbphy_pcie_dis_pad_refclk(struct intel_cbphy_iphy *iphy)
>  		return 0;
>  
>  	combo_phy_w32_off_mask(cbphy->app_base, PCIE_PHY_GEN_CTRL,
> -			       PCIE_PHY_CLK_PAD, 1);
> +			       PCIE_PHY_CLK_PAD, FIELD_PREP(PCIE_PHY_CLK_PAD, 1));
>  
>  	return 0;
>  }
> @@ -385,7 +385,7 @@ static int intel_cbphy_calibrate(struct phy *phy)
>  
>  	/* trigger auto RX adaptation */
>  	combo_phy_w32_off_mask(cr_base, CR_ADDR(PCS_XF_ATE_OVRD_IN_2, id),
> -			       ADAPT_REQ_MSK, 3);
> +			       ADAPT_REQ_MSK, FIELD_PREP(ADAPT_REQ_MSK, 3));
>  	/* Wait RX adaptation to finish */
>  	ret = readl_poll_timeout(cr_base + CR_ADDR(PCS_XF_RX_ADAPT_ACK, id),
>  				 val, val & RX_ADAPT_ACK_BIT, 10, 5000);
> @@ -396,7 +396,7 @@ static int intel_cbphy_calibrate(struct phy *phy)
>  
>  	/* Stop RX adaptation */
>  	combo_phy_w32_off_mask(cr_base, CR_ADDR(PCS_XF_ATE_OVRD_IN_2, id),
> -			       ADAPT_REQ_MSK, 0);
> +			       ADAPT_REQ_MSK, FIELD_PREP(ADAPT_REQ_MSK, 0));
>  
>  	return ret;
>  }
> 


-- 
~Randy
