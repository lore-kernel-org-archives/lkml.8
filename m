Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBF4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87CE9206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K9FL9hLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgFDPGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbgFDPGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:06:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B649EC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 08:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Zd0FBuiA8Z0n7i/7o4S0t2ulc9tdz69SotbM6eLluXU=; b=K9FL9hLQkO+tLh5B7JIuM2MBmw
        nIbdRzK83zfcZjGVof4X0x0qt3CUFIY+g6OsF8VZo3aHgWY2UmiJ4V+75xn39U4CEcXF9tKC/lXa8
        Fe4qIULKST+802LoHwj8iM+YfBct+elx+Ay6L8s26TvZxz3jSExamb0aCRsLHCCNoTzN/AY/UBYnY
        qau/vmULtWSKYEzDF5uydu61MG9Kt36mw4e8dEeUf0V9puNsGxlJlg1fRaM9OJXdg9PP34uNc1Bwm
        gmdZzQdBGsCe9Zxt5HEVR7g7wBcaXOHoXeOznhmJMmja3OnJDyv/Dx1ToKFxOmpBCNzD8CkcTe2ro
        NHpWzWyQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgrRh-0007rf-MW; Thu, 04 Jun 2020 15:06:17 +0000
Subject: Re: [PATCH] regulator: mt6360: Add support for MT6360 regulator
To:     Gene Chen <gene.chen.richtek@gmail.com>, matthias.bgg@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
References: <1591254387-10304-1-git-send-email-gene.chen.richtek@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4135d264-6758-301a-0f19-ba2f229301c3@infradead.org>
Date:   Thu, 4 Jun 2020 08:06:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591254387-10304-1-git-send-email-gene.chen.richtek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/20 12:06 AM, Gene Chen wrote:
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index f4b72cb..05a3b14 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -680,6 +680,16 @@ config REGULATOR_MT6358
>  	  This driver supports the control of different power rails of device
>  	  through regulator interface.
>  
> +config REGULATOR_MT6360
> +	tristate "MT6360 SubPMIC Regulator"
> +	depends on MFD_MT6360
> +	select CRC8
> +	help
> +	  Say Y here to enable MT6360 regulator support.
> +	  This is support MT6360 PMIC/LDO part include

	  This supports the MT6300 PMIC/LDO part, which includes

> +	  2-channel buck with Thermal Shutdown and Overlord Protection

	                              is that      Overload  ?
Yes, it could be Overlord.

> +	  6-channel High PSRR and Low Dropout LDO.
> +
>  config REGULATOR_MT6380
>  	tristate "MediaTek MT6380 PMIC"
>  	depends on MTK_PMIC_WRAP


-- 
~Randy

