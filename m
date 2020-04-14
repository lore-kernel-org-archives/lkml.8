Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650DAC3815B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3901C2063A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586871516;
	bh=hwrKfBxeK+4AD1ibFnoch7kah+4fJkFJk3wYroT7S0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dXE1M0ALVfHMbRadeVj3VJSa1so+pae0rjeQD/rj365af+1aBORYyEuavQlYXjlAK
	 LqiwYbHnGR9Ahf/utL1WOv+Dn6zS9UkxVlCy1YA7F1M4ySSSVEe6LzEoaA5VzPaalw
	 Xpqkb8rALAjOWk1RSLT5XNK4g/FS0fH/6LX9jPso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbgDNNid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:38:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732466AbgDNNgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:36:48 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F63F2063A;
        Tue, 14 Apr 2020 13:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586871408;
        bh=hwrKfBxeK+4AD1ibFnoch7kah+4fJkFJk3wYroT7S0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=skTTgN+rq63uKIs1RVHnvAHkfXTHlRb4q/HJUL3prWhQpva1ix5Y8wQQxe5imin/P
         /Up9D9UF5vipk/nT7gY9M9Oo9qYOo3G03z1zesgxe2LKbGyHtkqUwKRtlhpqAHodM2
         8gOmu4jHZrYIdc8F40rej6Hw+QPT3+tdg7I3bNRw=
Date:   Tue, 14 Apr 2020 21:36:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     sboyd@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        abel.vesa@nxp.com, Anson.Huang@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] clk: imx7ulp: make it easy to change ARM core clk
Message-ID: <20200414133639.GC30676@dragon>
References: <1584347553-2654-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584347553-2654-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 04:32:33PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> ARM clk could only source from divcore or hsrun_divcore.
> 
> Follow what we already used on i.MX7D and i.MX8M SoCs, use
> imx_clk_hw_cpu API. When ARM core is running normaly,
> whether divcore or hwrun_divcore will finally source
> from SPLL_PFD0. However SPLL_PFD0 is marked with CLK_SET_GATE,
> so we need to disable SPLL_PFD0, when configure the rate.
> So add CORE and HSRUN_CORE virtual clk to make it easy to
> configure the clk using imx_clk_hw_cpu API.
> 
> Since CORE and HSRUN_CORE already marked with CLK_IS_CRITICAL, no
> need to set ARM as CLK_IS_CRITICAL. And when set the rate of ARM clk,
> prograting it the parent with CLK_SET_RATE_PARENT will finally set
> the SPLL_PFD0 clk.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
