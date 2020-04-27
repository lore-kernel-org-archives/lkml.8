Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65989C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6EF216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgD0SWS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:22:18 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42851 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgD0SWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:22:18 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 6483A20005;
        Mon, 27 Apr 2020 18:22:13 +0000 (UTC)
Date:   Mon, 27 Apr 2020 20:22:12 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <tony@atomide.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>
Subject: Re: [PATCH v2 06/12] mtd: rawnand: stm32_fmc2: use FMC2_TIMEOUT_MS
 for timeouts
Message-ID: <20200427202212.0235d987@xps13>
In-Reply-To: <1586966256-29548-7-git-send-email-christophe.kerello@st.com>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
        <1586966256-29548-7-git-send-email-christophe.kerello@st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 15 Apr
2020 17:57:30 +0200:

> This patch removes the constant FMC2_TIMEOUT_US.
> FMC2_TIMEOUT_MS is set to 5 seconds and this constant is used
> each time that we need to wait (except when the timeout value
> is set by the framework)
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> ---
>  drivers/mtd/nand/raw/stm32_fmc2_nand.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> index ab53314..f159c39 100644
> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> @@ -37,8 +37,7 @@
>  /* Max ECC buffer length */
>  #define FMC2_MAX_ECC_BUF_LEN		(FMC2_BCHDSRS_LEN * FMC2_MAX_SG)
>  
> -#define FMC2_TIMEOUT_US			1000
> -#define FMC2_TIMEOUT_MS			1000
> +#define FMC2_TIMEOUT_MS			5000
>  
>  /* Timings */
>  #define FMC2_THIZ			1
> @@ -525,9 +524,9 @@ static int stm32_fmc2_ham_calculate(struct nand_chip *chip, const u8 *data,
>  	u32 sr, heccr;
>  	int ret;
>  
> -	ret = readl_relaxed_poll_timeout(fmc2->io_base + FMC2_SR,
> -					 sr, sr & FMC2_SR_NWRF, 10,
> -					 FMC2_TIMEOUT_MS);
> +	ret = readl_relaxed_poll_timeout_atomic(fmc2->io_base + FMC2_SR,
> +						sr, sr & FMC2_SR_NWRF, 1,
> +						1000 * FMC2_TIMEOUT_MS);

Is the _atomic suffix needed here? If yes it would deserve a separate
patch with Fixes/Stable tags.

>  	if (ret) {
>  		dev_err(fmc2->dev, "ham timeout\n");
>  		return ret;
> @@ -1315,7 +1314,7 @@ static int stm32_fmc2_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
>  	/* Check if there is no pending requests to the NAND flash */
>  	if (readl_relaxed_poll_timeout_atomic(fmc2->io_base + FMC2_SR, sr,
>  					      sr & FMC2_SR_NWRF, 1,
> -					      FMC2_TIMEOUT_US))
> +					      1000 * FMC2_TIMEOUT_MS))
>  		dev_warn(fmc2->dev, "Waitrdy timeout\n");
>  
>  	/* Wait tWB before R/B# signal is low */

You change the timeouts from 1ms to 5s.

Maybe 5s is a little bit too much IMHO but we don't really care as this
is a timeout. However 1ms is tight. If you are changing this value
because it triggers error (eg. when the machine is loaded), then it is
a fix and should appear like it.

Thanks,
Miquèl
