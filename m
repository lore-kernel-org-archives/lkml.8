Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6ACC54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 00:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704F42072E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 00:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgCXAp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 20:45:29 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:59610 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgCXAp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 20:45:28 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 48mXbR5r3Jz1qs45;
        Tue, 24 Mar 2020 01:45:23 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 48mXbR568tz1qyF8;
        Tue, 24 Mar 2020 01:45:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id FO-gghsvXtfJ; Tue, 24 Mar 2020 01:45:22 +0100 (CET)
X-Auth-Info: ZGG/J4gwG3dOZ4fK596fd89O+wp6LvVr1WgV+S4kI0M=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 24 Mar 2020 01:45:22 +0100 (CET)
Subject: Re: [10/12] mtd: rawnand: stm32_fmc2: use regmap APIs
To:     Christophe Kerello <christophe.kerello@st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        tony@atomide.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <1584975532-8038-1-git-send-email-christophe.kerello@st.com>
 <1584975532-8038-11-git-send-email-christophe.kerello@st.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <784fafd2-f1f3-f9c4-d6eb-1d2f6f8d38e4@denx.de>
Date:   Tue, 24 Mar 2020 01:44:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584975532-8038-11-git-send-email-christophe.kerello@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/20 3:58 PM, Christophe Kerello wrote:
[...]
> @@ -531,11 +515,11 @@ static int stm32_fmc2_nfc_bch_correct(struct nand_chip *chip, u8 *dat,
>  		return -ETIMEDOUT;
>  	}
>  
> -	ecc_sta[0] = readl_relaxed(nfc->io_base + FMC2_BCHDSR0);
> -	ecc_sta[1] = readl_relaxed(nfc->io_base + FMC2_BCHDSR1);
> -	ecc_sta[2] = readl_relaxed(nfc->io_base + FMC2_BCHDSR2);
> -	ecc_sta[3] = readl_relaxed(nfc->io_base + FMC2_BCHDSR3);
> -	ecc_sta[4] = readl_relaxed(nfc->io_base + FMC2_BCHDSR4);
> +	regmap_read(nfc->regmap, FMC2_BCHDSR0, &ecc_sta[0]);
> +	regmap_read(nfc->regmap, FMC2_BCHDSR1, &ecc_sta[1]);
> +	regmap_read(nfc->regmap, FMC2_BCHDSR2, &ecc_sta[2]);
> +	regmap_read(nfc->regmap, FMC2_BCHDSR3, &ecc_sta[3]);
> +	regmap_read(nfc->regmap, FMC2_BCHDSR4, &ecc_sta[4]);

Would regmap_bulk_read() work here ?
