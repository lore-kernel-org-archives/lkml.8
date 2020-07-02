Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14711C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F6720723
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qEnbP/fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgGBLdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:33:36 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:57523 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgGBLdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593689615; x=1625225615;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=CU9InOfV7XPTgQvPxOnN3QO0TR0N2L3ry6P7Dr4ONQg=;
  b=qEnbP/fzAi0MFDEdV7AATDEzFV0v6vNCLWfbQHncuhtni8mDbrR52/1n
   YoiBCrKXJqIPFn3WlKWzr7/lVrOvCdd0+aCkh2Fm0HlW2wmngsU4lKl5E
   QGc5imDy4rZTSfj1WpJrmH8NBbt4OqkCBUOAYJ4lNIWk/0rhTAkaJnEfd
   doZsZMVf1AV3MNSE7KvTXqUuxRLsNhSQKVr//egWdH8SzRorOq24cve14
   c53zFQ+V4gOeg4aE1vxIFHugtkWHBM2ZP8YaMy+CnrENgjoXH7BrrsjTO
   XhAXnXJDziZzlGYpkZcsnlLJDt4ke4/LmRtq7ZqfnZI4toDfpd8LMMHY4
   g==;
IronPort-SDR: cJt13ZTvTeh6wvA8K7SGbfi7yk+3R079CbnH2VcDEBZAszJo21j9Bdr5X4mUWzefu2oxDznpMh
 H3lWqyHKVf2IL2uVZ0t8lT1/ij3YLxfDlipF0ABktbmh7EHitqVLR1iMv8sEl/LxAakqytwDGS
 JbmRncikU24ac/xYljkd7E/pN77oM2pO2wttrcpATAEB2KQxIV3ReXoDdHK31ycYVNpfbkwCOg
 n49HWsiNMs9ytj0lOGpeeEmbkaIe/o07a8TwdFY2kC7UfNI9C/5Zbn0uP6k75Bun76k3OcB4vd
 GaE=
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="78552903"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2020 04:33:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 04:33:15 -0700
Received: from soft-dev15.microsemi.net.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 2 Jul 2020 04:33:12 -0700
References: <20200702101331.26375-1-lars.povlsen@microchip.com> <20200702101331.26375-5-lars.povlsen@microchip.com>
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Lars Povlsen <lars.povlsen@microchip.com>
CC:     Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>,
        "Microchip Linux Driver Support" <UNGLinuxDriver@microchip.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Serge Semin" <fancer.lancer@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v3 4/8] mux: sparx5: Add Sparx5 SPI mux driver
In-Reply-To: <20200702101331.26375-5-lars.povlsen@microchip.com>
Date:   Thu, 2 Jul 2020 13:33:29 +0200
Message-ID: <87366akv7a.fsf@soft-dev15.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lars Povlsen writes:

> The Sparx5 mux driver may be used to control selecting between two
> alternate SPI bus segments connected to the SPI controller
> (spi-dw-mmio).
>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  drivers/mux/Makefile     |   2 +
>  drivers/mux/sparx5-spi.c | 138 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 140 insertions(+)
>  create mode 100644 drivers/mux/sparx5-spi.c
>
...
> +
> +#define SPARX5_MAX_CS	16
> +
> +struct mux_sparx5 {
> +	struct regmap *syscon;
> +	u8 bus[SPARX5_MAX_CS];
> +	int cur_bus;
> +};

Yeah, "cur_bus" is a leftover. I'll remove it.

-- 
Lars Povlsen,
Microchip
