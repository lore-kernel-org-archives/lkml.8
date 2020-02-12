Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0B8C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2482073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581493176;
	bh=n7Ndijc0qWiVVABjn3qhnZ9fuPMPdghskECH0s/oIeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VA+/4enCbZxey8MV4tzXeQvIzsCmvY+lHh5I5bzcsMJH9tFV9G8YaXXN/Qs4sRwNR
	 tvhLpUoOcNPHie5Xn8K/ZMl0caQHVd25CbLj8YwqVVqJE3uBU3rrOZ1TtsZNucOTLS
	 dfjgt92tIq27Cv0q92Vq53atl9na++Res2wXADXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgBLHjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:39:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbgBLHje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:39:34 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7341C20658;
        Wed, 12 Feb 2020 07:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581493174;
        bh=n7Ndijc0qWiVVABjn3qhnZ9fuPMPdghskECH0s/oIeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vHKWwKT8mQ4uWKXTwpVuQZk68Mt4wQ4jD42Sfn7+faAdSTB7CLV7yDdooFla1OKhm
         a6iVba6kzG1XGhaJoThjmLnxck+BL6wz2dnheOcMl5xKPoPDehnSsAk8Cj2fcy6nRp
         XPCuiJZEhuwyiBiA2ZQzdJhAJd0+K/swkKh/nOyE=
Date:   Wed, 12 Feb 2020 15:39:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mn: Init rates and parents configs for
 clocks
Message-ID: <20200212073924.GB11096@dragon>
References: <1578640589-17210-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578640589-17210-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 07:20:31AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add the initial configuration for clocks that need default parent and rate
> setting.
> 
> NoC sources from SYS PLL3, running at 600MHz. Audio AHB/IPG clks needs
> to run at 400MHz for better performance.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
