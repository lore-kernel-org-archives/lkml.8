Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5FBC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 03:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0966F2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 03:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583811748;
	bh=9t6PQTF4yZhBSTuBT59aCA5e/8OFUhyc/DijBpBFCMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BCBVtBqYmyzr3ge99SBeiLsu+HJz5buYdLjihBVRDvqyNJ2h4SjZHztLvpj61ZXTz
	 D9e2nFp+KVrU78GgL0hHnH24DRuZs4gmNZoZOWo8rg8zaVd34PAexVua0IvCdityk5
	 mHpFPTWzMJYeHynjE7uzE7QmIG9YJ3rnhMr/kOdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgCJDm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 23:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgCJDm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 23:42:26 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8022224649;
        Tue, 10 Mar 2020 03:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583811746;
        bh=9t6PQTF4yZhBSTuBT59aCA5e/8OFUhyc/DijBpBFCMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELC4laBnmWyQWgtZJRyxXX+wvcGYrYptReol9dy2C3ggnAg2cY9PZ1OrFLqsto5O9
         tn20frD/Hqh27tEbDmU+/a+bYw3QDHLxoSQlmL0qZcLO+5zejMPu1kyug5rZmeiFYV
         yiALkYFxuWN8B0V8zbnTLxDUbpJw0kg9IFB65Lfk=
Date:   Tue, 10 Mar 2020 11:42:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, aisheng.dong@nxp.com, peng.fan@nxp.com,
        fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] clk: imx8: Add SCU and LPCG clocks for I2C in CM40 SS
Message-ID: <20200310034214.GB15729@dragon>
References: <1581909561-12058-1-git-send-email-qiangqing.zhang@nxp.com>
 <1581909561-12058-3-git-send-email-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581909561-12058-3-git-send-email-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 11:19:16AM +0800, Joakim Zhang wrote:
> Add SCU and LPCG clocks for I2C in CM40 SS.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  include/dt-bindings/clock/imx8-clock.h | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

I think it can be merged into patch #4.

Shawn

> 
> diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/clock/imx8-clock.h
> index 673a8c662340..84a442be700f 100644
> --- a/include/dt-bindings/clock/imx8-clock.h
> +++ b/include/dt-bindings/clock/imx8-clock.h
> @@ -131,7 +131,12 @@
>  #define IMX_ADMA_PWM_CLK				188
>  #define IMX_ADMA_LCD_CLK				189
>  
> -#define IMX_SCU_CLK_END					190
> +/* CM40 SS */
> +#define IMX_CM40_IPG_CLK				200
> +#define IMX_CM40_I2C_CLK				205
> +
> +#define IMX_SCU_CLK_END					220
> +
>  
>  /* LPCG clocks */
>  
> @@ -290,4 +295,10 @@
>  
>  #define IMX_ADMA_LPCG_CLK_END				45
>  
> +/* CM40 SS LPCG */
> +#define IMX_CM40_LPCG_I2C_IPG_CLK			0
> +#define IMX_CM40_LPCG_I2C_CLK				1
> +
> +#define IMX_CM40_LPCG_CLK_END				2
> +
>  #endif /* __DT_BINDINGS_CLOCK_IMX_H */
> -- 
> 2.17.1
> 
