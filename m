Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8B5C3B192
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84ECD217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581642721;
	bh=cFqo9NTU427jsL80IPrv2/QZ7B3Sqw+lXM9313ESW4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gx+NPuhcYrByCB7sBJ9covfKHmQyK39t4RW8K4G6HueAn5Y3+llpxB/fQZS4rOPFN
	 oNeaQFsdZrYWmz4hgQpfNNGeCe8BlQ5Fjzmv07L4wMl4+3N7dpbejL43LQG7qN9m/h
	 ugx4Fsji6YBtmdrUfIon4vGLTvP330fgKzwngz+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgBNBMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:12:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727609AbgBNBMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 20:12:00 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C60020848;
        Fri, 14 Feb 2020 01:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581642720;
        bh=cFqo9NTU427jsL80IPrv2/QZ7B3Sqw+lXM9313ESW4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wtj4SWW7YUMx5uDPUGg9tD8XKVDr8kgTD8gQFZv6SUbykmSx2NjQP2J5w8lRhA0NN
         iJPhQs99MANvvJBNVb0o38lGHjjZew7y50sLRCqh0vrlWlp0VVglPtqqGJhyVFagRH
         nTAAOdsbYk+7PI3u6HWUfGesfUj0ZOSLXDS2CZSw=
Date:   Fri, 14 Feb 2020 09:11:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mm: drop redundant interrupt-parent
Message-ID: <20200214011014.GS11096@dragon>
References: <1579428407-9981-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579428407-9981-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 10:11:32AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> There is interrupt-parent = <&gic> in root node, there is no
> need set it again in node ddr-pmu@3d800000.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
