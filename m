Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB7DC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 681A620725
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgEJUGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 16:06:39 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:46221 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgEJUGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 16:06:39 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id DAB47C0007;
        Sun, 10 May 2020 20:06:36 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marex@denx.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: denali: add more delays before latching incoming data
Date:   Sun, 10 May 2020 22:06:35 +0200
Message-Id: <20200510200635.3080-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317071821.9916-1-yamada.masahiro@socionext.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 5756f2e8dad46eba6e2d3e530243b8eff4dd5a42
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-17 at 07:18:21 UTC, Masahiro Yamada wrote:
> The Denali IP have several registers to specify how many clock cycles
> should be waited between falling/rising signals. You can improve the
> NAND access performance by programming these registers with optimized
> values.
> 
> Because struct nand_sdr_timings represents the device requirement
> in pico seconds, denali_setup_data_interface() computes the register
> values by dividing the device timings with the clock period.
> 
> Marek Vasut reported this driver in the latest kernel does not work
> on his SOCFPGA board. (The on-board NAND chip is mode 5)
> 
> The suspicious parameter is acc_clks, so this commit relaxes it.
> 
> The Denali NAND Flash Memory Controller User's Guide describes this
> register as follows:
> 
>   acc_clks
>     signifies the number of bus interface clk_x clock cycles,
>     controller should wait from read enable going low to sending
>     out a strobe of clk_x for capturing of incoming data.
> 
> Currently, acc_clks is calculated only based on tREA, the delay on the
> chip side. This does not include additional delays that come from the
> data path on the PCB and in the SoC, load capacity of the pins, etc.
> 
> This relatively becomes a big factor on faster timing modes like mode 5.
> 
> Before supporting the ->setup_data_interface() hook (e.g. Linux 4.12),
> the Denali driver hacks acc_clks in a couple of ways [1] [2] to support
> the timing mode 5.
> 
> We would not go back to the hard-coded acc_clks, but we need to include
> this factor into the delay somehow. Let's say the amount of the additional
> delay is 10000 pico sec.
> 
> In the new calculation, acc_clks is determined by timings->tREA_max +
> data_setup_on_host.
> 
> Also, prolong the RE# low period to make sure the data hold is met.
> 
> Finally, re-center the data latch timing for extra safety.
> 
> [1] https://github.com/torvalds/linux/blob/v4.12/drivers/mtd/nand/denali.c#L276
> [2] https://github.com/torvalds/linux/blob/v4.12/drivers/mtd/nand/denali.c#L282
> 
> Reported-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Tested-by: Marek Vasut <marex@denx.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
