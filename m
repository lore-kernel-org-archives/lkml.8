Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676CBC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E8520B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595210174;
	bh=W8YzRx78vB3k/uKqwUom8cLKtr60pKZvb50g41M28uI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v4yc6OO2aXLjfylyOJR1wpYUuQJ/4ZtVNElql1bHGleWUTdABSa2aBwxK5xeWCf3a
	 W084Wvu9xP2hJ+9ULwo/6S1FI3Z9LSfr5oGjRGnUJlrHlDauFkZRPCvvBui0G4cqFf
	 rTaHWjm4Mw4Dq2wNfRrCHZ7SYUxwCkBAcObGLGl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgGTB4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:56:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgGTB4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:56:12 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EB0820809;
        Mon, 20 Jul 2020 01:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595210171;
        bh=W8YzRx78vB3k/uKqwUom8cLKtr60pKZvb50g41M28uI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sMTz2hhUZp9w8dXrJkd1hWjfwAxDM8zB73GZ8411ME0c7BLSdbyZLmqPCQF8suXmL
         5azAd7pqFNBmVzLxN36ONOJ14dGUssXSKfgBcyAwACZ+wh9Sj/fNFG01R/uvk6eZEI
         PZ4LGToxAiEHuvqwIymw1f4BtJ5KIqiF98x3ShHM=
Date:   Mon, 20 Jul 2020 09:55:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Georg.Waibel@wiedemann-group.com, abel.vesa@nxp.com,
        aisheng.dong@nxp.com, andrew.smirnov@gmail.com, chen.fang@nxp.com,
        daniel.baluta@nxp.com, festevam@gmail.com, fugang.duan@nxp.com,
        georg.waibel@wiedemann-group.de, horia.geanta@nxp.com,
        j.remmet@phytec.de, kernel@pengutronix.de,
        laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        peng.fan@nxp.com, s.hauer@pengutronix.de, sfr@canb.auug.org.au,
        yuehaibing@huawei.com, Linux-imx@nxp.com
Subject: Re: [PATCH V6 6/6] clk: imx6sl: Fix build warning reported by kernel
 test robot
Message-ID: <20200720015553.GB11560@dragon>
References: <1594098579-25050-1-git-send-email-Anson.Huang@nxp.com>
 <1594098579-25050-7-git-send-email-Anson.Huang@nxp.com>
 <159486121748.1987609.16422613903444902156@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159486121748.1987609.16422613903444902156@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 06:00:17PM -0700, Stephen Boyd wrote:
> Quoting Anson Huang (2020-07-06 22:09:39)
> > Use readl_relaxed() instead of __raw_readl(), and use BIT(x)
> > instead of (1 << X) to fix below build warning reported by kernel
> > test robot:
> > 
> > drivers/clk/imx/clk-imx6sl.c:149:49: warning: Shifting signed 32-bit
> > value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
> >      while (!(__raw_readl(anatop_base + PLL_ARM) & BM_PLL_ARM_LOCK))
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> 
> The subject is poor. Please improve it so that it summarizes the change
> instead of the reaction to a warning from a robot.
> 
> > New patch.
> > ---
> >  drivers/clk/imx/clk-imx6sl.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> 
> This should come earlier in the series too so that the build warning
> doesn't come out before this patch is applied.

Anson,

Please update the series per request from Stephen.  I have dropped the
series from my branch.

Shawn
