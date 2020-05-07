Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE20EC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2DB62078C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgEGGno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:43:44 -0400
Received: from smtprelay0193.hostedemail.com ([216.40.44.193]:51830 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbgEGGnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:43:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id AA3E7801A056;
        Thu,  7 May 2020 06:43:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: humor62_7784db8d54d20
X-Filterd-Recvd-Size: 3778
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 May 2020 06:43:41 +0000 (UTC)
Message-ID: <158979eb8e6e80c9b535acfdb4821bc9547c7c50.camel@perches.com>
Subject: Re: [PATCH -next] ASoC: amd: acp3x-pcm-dma: Use bitwise instead of
 arithmetic operator for flags
From:   Joe Perches <joe@perches.com>
To:     Samuel Zou <zou_wei@huawei.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Wed, 06 May 2020 23:43:40 -0700
In-Reply-To: <1588833562-14417-1-git-send-email-zou_wei@huawei.com>
References: <1588833562-14417-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-07 at 14:39 +0800, Samuel Zou wrote:
> Fix the following coccinelle warnings:

> sound/soc/amd/raven/acp3x-pcm-dma.c:161:39-40: WARNING: sum of probable bitmasks, consider |
> sound/soc/amd/raven/acp3x-pcm-dma.c:172:39-40: WARNING: sum of probable bitmasks, consider |
> sound/soc/amd/raven/acp3x-pcm-dma.c:183:39-40: WARNING: sum of probable bitmasks, consider |
> sound/soc/amd/raven/acp3x-pcm-dma.c:194:39-40: WARNING: sum of probable bitmasks, consider |

These are not bitmasks.

Samuel, please look deeper at the code before submitting
bad patches.

And hey Julia.

This is the second false positive submitted for this
warning today.

Can you please remove the script or fix it so it
uses better logic?k

Thanks.


> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Samuel Zou <zou_wei@huawei.com>
> ---
>  sound/soc/amd/raven/acp3x-pcm-dma.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
> index e362f0b..b0cc0fe 100644
> --- a/sound/soc/amd/raven/acp3x-pcm-dma.c
> +++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
> @@ -158,7 +158,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
>  		switch (rtd->i2s_instance) {
>  		case I2S_BT_INSTANCE:
>  			reg_dma_size = mmACP_BT_TX_DMA_SIZE;
> -			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
> +			acp_fifo_addr = ACP_SRAM_PTE_OFFSET |
>  						BT_PB_FIFO_ADDR_OFFSET;
>  			reg_fifo_addr = mmACP_BT_TX_FIFOADDR;
>  			reg_fifo_size = mmACP_BT_TX_FIFOSIZE;
> @@ -169,7 +169,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
>  		case I2S_SP_INSTANCE:
>  		default:
>  			reg_dma_size = mmACP_I2S_TX_DMA_SIZE;
> -			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
> +			acp_fifo_addr = ACP_SRAM_PTE_OFFSET |
>  						SP_PB_FIFO_ADDR_OFFSET;
>  			reg_fifo_addr =	mmACP_I2S_TX_FIFOADDR;
>  			reg_fifo_size = mmACP_I2S_TX_FIFOSIZE;
> @@ -180,7 +180,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
>  		switch (rtd->i2s_instance) {
>  		case I2S_BT_INSTANCE:
>  			reg_dma_size = mmACP_BT_RX_DMA_SIZE;
> -			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
> +			acp_fifo_addr = ACP_SRAM_PTE_OFFSET |
>  						BT_CAPT_FIFO_ADDR_OFFSET;
>  			reg_fifo_addr = mmACP_BT_RX_FIFOADDR;
>  			reg_fifo_size = mmACP_BT_RX_FIFOSIZE;
> @@ -191,7 +191,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
>  		case I2S_SP_INSTANCE:
>  		default:
>  			reg_dma_size = mmACP_I2S_RX_DMA_SIZE;
> -			acp_fifo_addr = ACP_SRAM_PTE_OFFSET +
> +			acp_fifo_addr = ACP_SRAM_PTE_OFFSET |
>  						SP_CAPT_FIFO_ADDR_OFFSET;
>  			reg_fifo_addr = mmACP_I2S_RX_FIFOADDR;
>  			reg_fifo_size = mmACP_I2S_RX_FIFOSIZE;

