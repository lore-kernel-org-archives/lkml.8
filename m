Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB0FC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 00:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62454206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 00:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584319676;
	bh=s6CPDhXjtVNGRU8In3e3kagDf6tr13gZhiw5JX4K0CE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WqgGv675PuQjJfQgTHdnH4PKlPyoAALh88OMWtRlFoVs+t9y0L77VBVt8ORXxp1O8
	 IqmfX1OPsukVneVA0mhWvxBJVYZ6IXuhsX6QhkYkdgL0ZtJkjbJ/iHVVlxeYtJtDDo
	 DrnL7hyR9OqCzL1qO4B7EixAjF/MCU8jTBMNs368=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgCPArz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 20:47:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbgCPAry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 20:47:54 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 482C5205C9;
        Mon, 16 Mar 2020 00:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584319674;
        bh=s6CPDhXjtVNGRU8In3e3kagDf6tr13gZhiw5JX4K0CE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PrS1n0O2hE5xdVizU0WiA0Sw+DkXi1c4YNJff2vFXIO2Xj7F7wQRLvdFP35Vwh243
         qLoTQivc06Fq14FXUG+O+Dmrwv6xNzEQ7CWo39tJ74VCwtH0x4E8Wr6NyzbY5fGz9W
         RCy6SNICzkZb75Fp1K0ug7Kd5x5Rymmfl2PweuHo=
Date:   Mon, 16 Mar 2020 08:47:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: gate2: Fix a few typos
Message-ID: <20200316004745.GB17221@dragon>
References: <20200308214927.16688-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200308214927.16688-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 10:49:26PM +0100, Jonathan Neuschäfer wrote:
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Sorry.  We do not take patch with empty commit log.

Shawn

> ---
>  drivers/clk/imx/clk-gate2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
> index 7d44ce814806..a1230cc215c4 100644
> --- a/drivers/clk/imx/clk-gate2.c
> +++ b/drivers/clk/imx/clk-gate2.c
> @@ -15,7 +15,7 @@
>  #include "clk.h"
> 
>  /**
> - * DOC: basic gatable clock which can gate and ungate it's ouput
> + * DOC: basic gateable clock which can gate and ungate its output
>   *
>   * Traits of this clock:
>   * prepare - clk_(un)prepare only ensures parent is (un)prepared
> --
> 2.20.1
> 
