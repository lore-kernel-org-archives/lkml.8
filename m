Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638BAC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 05:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364B724673
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 05:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583819615;
	bh=JJxGvJHWNSGB7lyLfFPO7G8uwwA6FJNOdDTip0Btc5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Do4xwOxN0b3CaKWZBpdw65eJofq2/Ba/RL6kCtgt84tlGqlwoNxK8IGMYZHjsk3FY
	 SuDiFSdoKS309ID/mMQ8kJDp1nNgNLdTUK1a9GE6Rl5V4p/ztjuQHMc95EtpWLG7+v
	 SrR9IMC5r1M9jrK0N55cdTa5dfgfiUqAMJu6wy2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgCJFxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 01:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgCJFxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 01:53:33 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BDA42071B;
        Tue, 10 Mar 2020 05:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583819613;
        bh=JJxGvJHWNSGB7lyLfFPO7G8uwwA6FJNOdDTip0Btc5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0jKuK38ZlOi8uX0RBbOuec5pcMzbYImr8Vs+ILU5HuY5gxfPcCR0DD0yGFnMfD05r
         aRCTooV+leJHTbPZo3r0VlhB6tNnX8BajoS/Fbr6mendvdP/AMr9MbB0TZFkXY5+g0
         e4cbDtThRMdLx2d4+aYyekaBmYJKTsjsBo7xexa8=
Date:   Tue, 10 Mar 2020 13:53:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, sboyd@kernel.org, robh+dt@kernel.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        abel.vesa@nxp.com
Subject: Re: [PATCH v2 03/14] clk: imx: Fix division by zero warning on pfdv2
Message-ID: <20200310055324.GF15729@dragon>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
 <1582099197-20327-4-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582099197-20327-4-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 03:59:46PM +0800, peng.fan@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Fix below division by zero warning:
> 
> [    3.176443] Division by zero in kernel.
> [    3.181809] CPU: 0 PID: 88 Comm: kworker/0:2 Not tainted 5.3.0-rc2-next-20190730-63758-ge08da51-dirty #124
> [    3.191817] Hardware name: Freescale i.MX7ULP (Device Tree)
> [    3.197821] Workqueue: events dbs_work_handler
> [    3.202849] [<c01127d8>] (unwind_backtrace) from [<c010cd80>] (show_stack+0x10/0x14)
> [    3.211058] [<c010cd80>] (show_stack) from [<c0c77e68>] (dump_stack+0xd8/0x110)
> [    3.218820] [<c0c77e68>] (dump_stack) from [<c0c753c0>] (Ldiv0_64+0x8/0x18)
> [    3.226263] [<c0c753c0>] (Ldiv0_64) from [<c05984b4>] (clk_pfdv2_set_rate+0x54/0xac)
> [    3.234487] [<c05984b4>] (clk_pfdv2_set_rate) from [<c059192c>] (clk_change_rate+0x1a4/0x698)
> [    3.243468] [<c059192c>] (clk_change_rate) from [<c0591a08>] (clk_change_rate+0x280/0x698)
> [    3.252180] [<c0591a08>] (clk_change_rate) from [<c0591fc0>] (clk_core_set_rate_nolock+0x1a0/0x278)
> [    3.261679] [<c0591fc0>] (clk_core_set_rate_nolock) from [<c05920c8>] (clk_set_rate+0x30/0x64)
> [    3.270743] [<c05920c8>] (clk_set_rate) from [<c089cb88>] (imx7ulp_set_target+0x184/0x2a4)
> [    3.279501] [<c089cb88>] (imx7ulp_set_target) from [<c0896358>] (__cpufreq_driver_target+0x188/0x514)
> [    3.289196] [<c0896358>] (__cpufreq_driver_target) from [<c0899b0c>] (od_dbs_update+0x130/0x15c)
> [    3.298438] [<c0899b0c>] (od_dbs_update) from [<c089a5d0>] (dbs_work_handler+0x2c/0x5c)
> [    3.306914] [<c089a5d0>] (dbs_work_handler) from [<c0156858>] (process_one_work+0x2ac/0x704)
> [    3.315826] [<c0156858>] (process_one_work) from [<c0156cdc>] (worker_thread+0x2c/0x574)
> [    3.324404] [<c0156cdc>] (worker_thread) from [<c015cfe8>] (kthread+0x134/0x148)
> [    3.332278] [<c015cfe8>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
> [    3.339858] Exception stack(0xe82d5fb0 to 0xe82d5ff8)
> [    3.345314] 5fa0:                                     00000000 00000000 00000000 00000000
> [    3.353926] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    3.362519] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
