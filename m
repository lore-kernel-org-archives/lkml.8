Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734E5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53AC921531
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgGBS1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:27:54 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:44751 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgGBS1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:27:53 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 48019C0003;
        Thu,  2 Jul 2020 18:27:48 +0000 (UTC)
Date:   Thu, 2 Jul 2020 20:27:47 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "moderated list:ARM/Microchip (AT91) SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] ASoC: atmel: fix kernel-doc
Message-ID: <20200702182747.GB6538@piout.net>
References: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com>
 <20200702165901.164100-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702165901.164100-2-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2020 11:58:54-0500, Pierre-Louis Bossart wrote:
> Fix W=1 warning
> 
> Kernel-doc is not used in one file and missing argument in the second.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  sound/soc/atmel/atmel-pcm-dma.c | 2 +-
>  sound/soc/atmel/atmel_ssc_dai.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
> index cb03c4f7324c..0a2e956232af 100644
> --- a/sound/soc/atmel/atmel-pcm-dma.c
> +++ b/sound/soc/atmel/atmel-pcm-dma.c
> @@ -44,7 +44,7 @@ static const struct snd_pcm_hardware atmel_pcm_dma_hardware = {
>  	.buffer_bytes_max	= 512 * 1024,
>  };
>  
> -/**
> +/*
>   * atmel_pcm_dma_irq: SSC interrupt handler for DMAENGINE enabled SSC
>   *
>   * We use DMAENGINE to send/receive data to/from SSC so this ISR is only to
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index 0f18dfb85bfe..6a63e8797a0b 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -887,6 +887,7 @@ static int asoc_ssc_init(struct device *dev)
>  
>  /**
>   * atmel_ssc_set_audio - Allocate the specified SSC for audio use.
> + * @ssc_id: SSD ID in [0, NUM_SSC_DEVICES[
>   */
>  int atmel_ssc_set_audio(int ssc_id)
>  {
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
