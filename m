Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC5BC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053BF20757
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgH3TRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 15:17:06 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47812 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbgH3TQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:16:49 -0400
Received: from p508fca7b.dip0.t-ipconnect.de ([80.143.202.123] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kCSop-00028U-Vw; Sun, 30 Aug 2020 21:16:48 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: Re: [PATCH v2] arm64: dts: rockchip: enable HDMI sound nodes for rk3328-rock64
Date:   Sun, 30 Aug 2020 21:16:47 +0200
Message-ID: <7880329.2VsnZ9RgxX@phil>
In-Reply-To: <20200802154231.2639186-1-katsuhiro@katsuster.net>
References: <20200802154231.2639186-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Sonntag, 2. August 2020, 17:42:31 CEST schrieb Katsuhiro Suzuki:
> This patch enables HDMI sound (I2S0) and Analog sound (I2S1) which
> are defined in rk3328.dtsi, and replace SPDIF nodes.
> 
> We can use SPDIF pass-through with suitable ALSA settings and on
> mpv or other media players.
>   - Settings: https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Rockchip/filesystem/usr/share/alsa/cards/SPDIF.conf
>   - Ex.: mpv foo.ac3 --audio-spdif=ac3 --audio-device='alsa/SPDIF.pcm.iec958.0:SPDIF'
> 
> [Why use simple-audio-card for SPDIF?]
> 
> For newly adding nodes, ASoC guys recommend to use audio-graph-card.
> But all other sound nodes for rk3328 have already been defined by
> simple-audio-card. In this time, I chose for consistent sound nodes.
> 
> [DMA allocation problem]
> 
> After this patch is applied, UART2 will fail to allocate DMA resources
> but UART driver can work fine without DMA.
> 
> This error is related to the DMAC of rk3328 (pl330 or compatible).
> DMAC connected to 16 DMA sources. Each sources have ID number that is
> called 'Req number' in rk3328 TRM. After this patch is applied total 7
> of DMA sources will be activated as follows:
> 
> | Req number | Source | Required  |
> |            |        | channels  |
> |------------+--------+-----------|
> |  8,  9     | SPI0   | 2ch       |
> | 11, 12     | I2S0   | 2ch       |
> | 14, 15     | I2S1   | 2ch       |
> |     10     | SPDIF  | 1ch       |
> |------------+--------+-----------|
> |            | Total  | 7ch       |
> |------------+--------+-----------|
> |  6,  7     | UART2  | 2ch       | -> cannot get DMA channels
> 
> Due to rk3328 DMAC specification we can use max 8 channels at same
> time. If SPI0/I2S0/I2S1/SPDIF will be activated by this patch,
> required DMAC channels reach to 7. So the last two channels (for
> UART2) cannot get DMA resources.

Wouldn't the dma allocation depend on the probe ordering?
Or is this predetermined, so that always uart2 looses its dmas?

Heiko



