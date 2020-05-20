Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE55CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C39C20835
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589938087;
	bh=yaMpbg/CqIf6nS95IhGjsX1jBrk4yx1tjQoacauEKM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xinwi64nI5mPqVzV92Hldq2UE2vkk1PGRxrfn8uXCRT1b10Wmyog51wPhODI9XtZj
	 fDTsnGw4q/h7wkEKDJxKSq/ABCda36bNns4QG7Y+3TcfbiXop3YRCXeMfOCuKPpgC9
	 5HB1132OSHC+L5s0x4kCMkTVFKtlboaRDyZ/IBPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgETB2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgETB2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:28:06 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8517207C4;
        Wed, 20 May 2020 01:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589938086;
        bh=yaMpbg/CqIf6nS95IhGjsX1jBrk4yx1tjQoacauEKM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QoUNqcK649U1kMFA8EAx6Mqn6NBCNVbih/trnWoHHfzaGMojBkRiHOmQj3XJ6o8HJ
         LvOvm0VxpaKwySo3YFYwUUIPTDLMOnaFBVfOyJ+dvQTEze8wbKBZ+DFb3GFNGdDWuT
         njJJG3akXFzjrqa7jkwBaBIMhSDg7+NXA1cbpURA=
Date:   Wed, 20 May 2020 09:27:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, leonard.crestez@nxp.com, abel.vesa@nxp.com,
        aisheng.dong@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V3 00/10] clk: imx: fixes and improve for i.MX8M
Message-ID: <20200520012758.GJ11739@dragon>
References: <1588830979-11586-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588830979-11586-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 01:56:09PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Patches rebased on for-next
> 
> V3:
>  Add R-b tag for patch 1-6,10
>  Use clk_mux_ops in patch 7, explain more details in commit log
>  Boot test on i.MX8MM/N/MQ/P
> 
> V2:
>  Patch 7, drop wait after write, add one line comment for write twice
> 
> V1:
> Patch 1,2 is to fix the lockdep warning reported by Leonard
> Patch 3 is to fix pll mux bit
> Patch 4 is align with other i.MX8M using gate
> Patch 5 is to simplify i.MX8MP clk root using composite
> 
> Patch 3~5 is actually https://patchwork.kernel.org/patch/11402761/
> with a minimal change to patch 5 here.
> 
> Patch 6 is to use composite core clk for A53 clk root
> Patch 7,8,9 is actually to fix CORE/BUS clk slice issue.
>  This issue is triggerred after we update U-Boot to include
>  the A53 clk fixes to sources from PLL, not from A53 root clk,
>  because of the signoff timing is 1GHz. U-Boot set the A53 root
>  mux to 2, sys pll2 500MHz. Kernel will set the A53 root mux to
>  4, sys pll1 800MHz, then gate off sys pll2 500MHz. Then kernel
>  will gate off A53 root because clk_ignore_unsed, A53 directly sources
>  PLL, so it is ok to gate off A53 root. However when gate off A53
>  root clk, system hang, because the original mux sys pll2 500MHz
>  gated off with CLK_OPS_PARENT_ENABLE flag.
> 
>  It is lucky that we not met issue for other core/bus clk slice
>  except A53 ROOT core slice. But it is always triggerred after
>  U-Boot and Linux both switch to use ARM PLL for A53 core, but
>  have different mux settings for A53 root clk slice.
> 
>  So the three patches is to address this issue.
> 
> Patch 10 is make memrepair as critical.
> 
> Peng Fan (10):
>   arm64: dts: imx8m: assign clocks for A53
>   clk: imx8m: drop clk_hw_set_parent for A53
>   clk: imx: imx8mp: fix pll mux bit
>   clk: imx8mp: Define gates for pll1/2 fixed dividers
>   clk: imx8mp: use imx8m_clk_hw_composite_core to simplify code
>   clk: imx8m: migrate A53 clk root to use composite core
>   clk: imx: add mux ops for i.MX8M composite clk
>   clk: imx: add imx8m_clk_hw_composite_bus
>   clk: imx: use imx8m_clk_hw_composite_bus for i.MX8M bus clk slice

Applied 1 ~ 9, thanks.

>   clk: imx8mp: mark memrepair clock as critical
