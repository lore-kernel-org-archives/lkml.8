Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E64C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB6321739
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581550326;
	bh=12CbUhkaEKf20xhNvllwkznIYLq9X5u3BJxoAwCvatc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=BaqmHTnM/vhBD99c/dFjNM1FfOUbgjmMwM+gFoejfC1xUdc1WaHHMswC/+NW3Zy7u
	 7mp+RtSg718lTSc1C9mYBJIRjy+pXHMgGCBx8CHA5c+HZ7EMChMUwnpmrasUPr0qJU
	 P7gSQpnn2uhnqKz3EtCIe/pnp5Eq+ztmfdN4lmX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgBLXcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:32:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgBLXcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:32:05 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EDA42168B;
        Wed, 12 Feb 2020 23:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581550324;
        bh=12CbUhkaEKf20xhNvllwkznIYLq9X5u3BJxoAwCvatc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fdInQSg5pCcP/kvjRo/WxTMjnt3ElG1vTHS77+o2SDmGJAiE9XfBEOeejUzbVNFLK
         qzls/7FafGFykcbRQF0cDagKJuzufUKmf9Iy0GCXAdn3Mzx4UpPAtetpmqTjZG+YNW
         3CyAXBtTR5mf1ODxyyS+V2yGKB4kYXeh/ZpHtlQM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1579261009-4573-2-git-send-email-claudiu.beznea@microchip.com>
References: <1579261009-4573-1-git-send-email-claudiu.beznea@microchip.com> <1579261009-4573-2-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 1/4] clk: at91: usb: continue if clk_hw_round_rate() return zero
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Wed, 12 Feb 2020 15:32:03 -0800
Message-ID: <158155032378.184098.13418432475305981955@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-01-17 03:36:46)
> clk_hw_round_rate() may call round rate function of its parents. In case
> of SAM9X60 two of USB parrents are PLLA and UPLL. These clocks are
> controlled by clk-sam9x60-pll.c driver. The round rate function for this
> driver is sam9x60_pll_round_rate() which call in turn
> sam9x60_pll_get_best_div_mul(). In case the requested rate is not in the
> proper range (rate < characteristics->output[0].min &&
> rate > characteristics->output[0].max) the sam9x60_pll_round_rate() will
> return a negative number to its caller (called by
> clk_core_round_rate_nolock()). clk_hw_round_rate() will return zero in
> case a negative number is returned by clk_core_round_rate_nolock(). With
> this, the USB clock will continue its rate computation even caller of
> clk_hw_round_rate() returned an error. With this, the USB clock on SAM9X60
> may not chose the best parent. I detected this after a suspend/resume
> cycle on SAM9X60.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
