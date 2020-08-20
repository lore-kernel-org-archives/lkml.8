Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AA6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2B52206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgHTIwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:52:02 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:58886 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgHTIvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:51:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id C7F74FB07;
        Thu, 20 Aug 2020 10:51:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LCI2PGXCr712; Thu, 20 Aug 2020 10:51:00 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 83CC7457CB; Thu, 20 Aug 2020 10:50:59 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
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
Subject: [PATCH v2 0/4] arm64: dts: imx8mq: Add NWL DSI host controller to Librem 5 Devkit
Date:   Thu, 20 Aug 2020 10:50:55 +0200
Message-Id: <cover.1597913263.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


These patches add the NWL host controller to the imx8mq and make use of it on
the Librem 5 Devkit enabling the built in MIPI DSI LCD panel.

I opted to add imx8mq internal ports and endpoints between nwl and lcdif to the
generic dtsi since those are SOC rather than board specific properties.

Changes from v1
- Add Reviewed-by from Fabio Estevam, thanks!
  https://lore.kernel.org/linux-arm-kernel/CAOMZO5DUA5eS8apZPbte0EcSQ4Vwpg6YLK7D0YdjSUy+kdBu8Q@mail.gmail.com/
  https://lore.kernel.org/linux-arm-kernel/CAOMZO5ANrd2JCmHyxZ0Sv0WNcU9T-q3MbaeADxbOwf+31MQ4LQ@mail.gmail.com/#t
  https://lore.kernel.org/linux-arm-kernel/CAOMZO5Dg5NGpJ0SQkYny04Kv3ky0619J7YwT-0eE1dsK19o1-w@mail.gmail.com/
- As per review comment by Fabio Estevam
  Re-sync DRM related defconfig bits. I didn't resyc the whole defconfig since
  this is pretty much kernel version dependent.

Guido Günther (4):
  arm64: dts: imx8mq: Add NWL MIPI DSI controller
  arm64: dts: imx8mq-librem5-devkit: Enable the LCD panel
  arm64: defconfig: re-sync DRM related defconfig bits
  arm64: defconfig: Enable imx8mq-librem5-devkit display stack

 .../dts/freescale/imx8mq-librem5-devkit.dts   | 33 +++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 49 +++++++++++++++++++
 arch/arm64/configs/defconfig                  |  6 ++-
 3 files changed, 87 insertions(+), 1 deletion(-)

-- 
2.26.2

