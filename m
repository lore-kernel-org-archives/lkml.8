Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38231C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C2524679
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583820283;
	bh=r2MPC5UtaW4E+Gx3vUdEl/eb7ySDkUz4DXRirRU3m1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pFEDrSrpu6natQXKvBERa/GLeUcNPYcpJQstCRiLy9rwFgYqjfVNQtZjDzHmmMqfn
	 joXBicaA2s5rmvG2YZGGBCk5riymz58R+RWJEyHhWj/F9OgQnVsduQsfTecZxtbTQy
	 ZcT7qesxB4i/zLItKMp7xXpgzG2m/WYVdhLMJbxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgCJGEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgCJGEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 02:04:41 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EF36222D9;
        Tue, 10 Mar 2020 06:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583820281;
        bh=r2MPC5UtaW4E+Gx3vUdEl/eb7ySDkUz4DXRirRU3m1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KN6ETD5wysJVebQR9jSbcf0KVdTLhMNlw0l7uwvCqnSSOmqmHlDvEn8rGnRTiAksi
         0d/oDwkmigihBqVp+7r0aG6DTpvKk2ulzoZV6A3EGs00RcaVL6p16PeD/cDD8yLvZL
         hD8qQkhkKrvBVCkr8ObTi3u33FI5mDFLZsCla3Bk=
Date:   Tue, 10 Mar 2020 14:04:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     s.hauer@pengutronix.de, sboyd@kernel.org, robh+dt@kernel.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        abel.vesa@nxp.com
Subject: Re: [PATCH v2 05/14] clk: imx: pfdv2: determine best parent rate
Message-ID: <20200310060434.GH15729@dragon>
References: <1582099197-20327-1-git-send-email-peng.fan@nxp.com>
 <1582099197-20327-6-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582099197-20327-6-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 03:59:48PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> pfdv2 is only used in i.MX7ULP. To get best pfd output, the i.MX7ULP
> Datasheet defines two best PLL rate and pfd frac.
> 
> Per Datasheel
> All PLLs on i.MX 7ULP either have VCO base frequency of
> 480 MHz or 528 MHz. So when determine best rate, we also
> determine best parent rate which could match the requirement.
> 
> For some reason the current parent might not be 480MHz or 528MHz,
> so we still take current parent rate as a choice.
> 
> And we also enable flag CLK_SET_RATE_PARENT to let parent rate
> to be configured.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
