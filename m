Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D83C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B544B2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgBYPxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:53:40 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:55244 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730309AbgBYPxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:53:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id D2C98FB04;
        Tue, 25 Feb 2020 16:53:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hDnBPv5pFWUt; Tue, 25 Feb 2020 16:53:35 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 9C517405CD; Tue, 25 Feb 2020 16:53:34 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/1] phy: fsl-imx8-mipi-dphy: Hook into runtime pm
Date:   Tue, 25 Feb 2020 16:53:33 +0100
Message-Id: <cover.1582645780.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to shut down the mipi power domain on the SOC.  The
alternative would be to drop the dphy from the mipi power domain in the
SOCs device tree and only have the DSI host controller visible there
(and rely on the phy layer's built in runtime pm handling) but this
makes the power domain dependency less explicit.

Currently the pm domain can't be shut off when blanking the panel:

pm_genpd_summary
domain                          status          slaves
    /device                                             runtime status
----------------------------------------------------------------------
mipi                            on
    /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  unsupported
    /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended

while with this we can shut down the power domain on panel blank:

mipi                            off-0
    /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  suspended
    /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended

This is similar to what drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
does.

Patch is against next-20200217

Guido Günther (1):
  phy: fsl-imx8-mipi-dphy: Hook into runtime pm

 .../phy/freescale/phy-fsl-imx8-mipi-dphy.c    | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

-- 
2.23.0

