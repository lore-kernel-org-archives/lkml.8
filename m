Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7C1C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 02:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F4EA2072D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 02:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598151294;
	bh=0YvnrHpvZ7oTHNYO4FXQwUMbhiGeyuQlE7jD2jsQC5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AAcEp8WY/ZU706wtUfSissk3zesYV4gr18bgBFb7ktFolygsxhrqLB/LS0v0KbXVw
	 +sXuer0OywWUihMV6ErArzW3ofOjgS84IzP0IKYq9hCiuOGhhKBxBDcQY2bomtyXJv
	 mgSdAXT//RDkzAbyBgj1ZALxchYom99cYIK3jnTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgHWCyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 22:54:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgHWCyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 22:54:51 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1BD92072D;
        Sun, 23 Aug 2020 02:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598151291;
        bh=0YvnrHpvZ7oTHNYO4FXQwUMbhiGeyuQlE7jD2jsQC5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujYbuoPY7487JVXcIcpWsN2uwLX96W2XR+mPHJjBV/EwWO8iSufkSa/pbYnRy+UWd
         7wPp/W9frkJtTB4WJa57oKSBoBXEpkzQx2N5FY+ZyXSYTJvI6LXeR0AqOXx0cHRGeR
         u+1bqTts7giXtsjLWeHnSApWMWHLD7QMH4xk+IkQ=
Date:   Sun, 23 Aug 2020 10:54:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Anson Huang <Anson.Huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Li Jun <jun.li@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: imx8mq-librem5-devkit: Enable the LCD
 panel
Message-ID: <20200823025442.GQ30094@dragon>
References: <cover.1597913263.git.agx@sigxcpu.org>
 <f03b599160804142f738eb53d0fe8686234c4896.1597913263.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f03b599160804142f738eb53d0fe8686234c4896.1597913263.git.agx@sigxcpu.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 10:50:57AM +0200, Guido Günther wrote:
> Enable LCD panel output by adding nodes for the NWL DSI host controller,
> the Rocktech panel and the eLCDIF display controller.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
