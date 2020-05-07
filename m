Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968DFC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768F420735
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AgKHhzvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgEGAWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 20:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgEGAWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 20:22:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4233CC061A0F;
        Wed,  6 May 2020 17:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=cj2TDq9YJ3M3PzXgjlWcgHNOf0t0JTr+blQ7myIxzsY=; b=AgKHhzvmV59z00CfGSgUszkYjH
        fU0FtJTeieEUPnI6InfRKUoiXAKjYlRIJnZx+EuCUm2I4lMDIf6x37XuOe6Ee5xOIUGZak+opjt0u
        cO+cAftUoDl5Ikqss4VsJcwDfZDjO1R30ach3tiwMKn5X9gQOIt9HfZ1pcrIoIiDHNhtsLwFz8nKB
        RVDCJqX3127IyiG0dTdATsOaEz1eVcpOCW+5jmupHiveHs/STLNQxWAAtHAgB7VNGQQL2z8LTIXZM
        jAJke27tINbz4sKDhziBPLFCbWhNZsNrJPpUF1sBzNzSaF/Ne84StQDYIyqgGoItyOVZgJCp1wiUo
        qcj4sh7w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWUIf-0003hv-9A; Thu, 07 May 2020 00:22:05 +0000
Subject: Re: [PATCH v5 2/2] mtd: rawnand: Add NAND controller support on Intel
 LGM SoC
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        arnd@arndb.de, brendanhiggins@google.com, tglx@linutronix.de,
        boris.brezillon@collabora.com, anders.roxell@linaro.org,
        masonccyang@mxic.com.tw, robh+dt@kernel.org,
        linux-mips@vger.kernel.org, hauke.mehrtens@intel.com,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com
References: <20200507001537.4034-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200507001537.4034-3-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <35cf7227-0045-9916-7994-a5763367aab3@infradead.org>
Date:   Wed, 6 May 2020 17:22:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507001537.4034-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/20 5:15 PM, Ramuthevar,Vadivel MuruganX wrote:
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index a80a46bb5b8b..a026bec28f39 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -457,6 +457,14 @@ config MTD_NAND_CADENCE
>  	  Enable the driver for NAND flash on platforms using a Cadence NAND
>  	  controller.
>  
> +config MTD_NAND_INTEL_LGM
> +	tristate "Support for NAND controller on Intel LGM SoC"
> +	depends on OF || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  Enables support for NAND Flash chips on Intel's LGM SoC.
> +          NAND flash interfaced through the External Bus Unit.

Please use one tab + 2 spaces for indentation in the line above.

> +
>  comment "Misc"
>  
>  config MTD_SM_COMMON


-- 
~Randy

