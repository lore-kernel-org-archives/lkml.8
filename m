Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8EDC3B194
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517FE2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581648617;
	bh=cQz7WMswfnptwR1SES46bBvWnXS2aGplada74E0ndYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hVF0f/cXBZFhFjDVN6zQcpmtdvYP5yMvlbnhkIUi4ddg4SV8w4HpXQZiBJWi5DaTR
	 soBchWd6oKOQ5v2As02xmL362B6WpDW8FTwOx2frdExLhWLdLRFXAmyK6HYfBNMl4S
	 mJmigALMRW7PxvlQ0kEstyWpNwvuQZOwND6Z0n9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgBNCuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbgBNCuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:50:15 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D98FB20873;
        Fri, 14 Feb 2020 02:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581648615;
        bh=cQz7WMswfnptwR1SES46bBvWnXS2aGplada74E0ndYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zh/nJnbIegiJ91mRCijJH3FWiDC8+voZl7dA7qAwsXopCpgBcbbJk27akiEvitc+W
         DdfSBFinysn6NBKrwbPpPiR4AUi6AfxN74Kqdw0uFwYc/dLr1FaqMG5QWdY8scZaPC
         298JTfXdHPScaPeivsRJU8xQ5Y+MAiQRqXDaOYR4=
Date:   Fri, 14 Feb 2020 10:50:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: Re: [PATCH V4 0/4] clk: imx: imx8m: introduce
 imx8m_clk_hw_composite_core
Message-ID: <20200214025006.GI22842@dragon>
References: <1580189015-5744-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580189015-5744-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 05:28:32AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V4:
>  Per Leonard's comments, added new definitions and  _SRC/CG/DIV are
>  alias to the new definition.
>  Did boot test on i.MX8MQ/M/N-EVK
> 
> V3:
>  Add CLK_SET_RATE_NO_REPARENT and CLK_OPS_PARENT_ENABLE for core
>  Avoid break DT for i.MX8MQ
> 
> V2:
>  Rename imx8m_clk_hw_core_composite to imx8m_clk_hw_composite_core
>  Add Abel's tag
> 
> To i.MX8M family, there are different types of clock slices,
> bus/core/ip and etc. Currently, the imx8m_clk_hw_composite
> api could only handle bus and ip clock slice, it could
> not handle core slice. The difference is core slice not have
> pre divider and the width of post divider is 3 bits.
> 
> To simplify code and reuse imx8m_clk_hw_composite, introduce a
> flag IMX_COMPOSITE_CORE to differentiate the slices.
> 
> With this new helper, we could simplify i.MX8M SoC clk drivers.
> 
> 
> Peng Fan (4):
>   clk: imx: composite-8m: add imx8m_clk_hw_composite_core
>   clk: imx: imx8mq: use imx8m_clk_hw_composite_core
>   clk: imx: imx8mm: use imx8m_clk_hw_composite_core
>   clk: imx: imx8mn: use imx8m_clk_hw_composite_core

Applied all, thanks.
