Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13B7C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C2420679
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgDUOoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:44:19 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:40162 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbgDUOoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:44:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 10FFFFB05;
        Tue, 21 Apr 2020 16:44:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6sxK6Q_KX8VC; Tue, 21 Apr 2020 16:44:14 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 55E64400FB; Tue, 21 Apr 2020 16:44:14 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     "Rob Herring" <robh+dt@kernel.org>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        "Martin Kepplinger" <martink@posteo.de>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        "Abel Vesa" <abel.vesa@nxp.com>,
        "Anson Huang" <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] arm64: dts: imx8mq-librem5-devkit: Use 0.9V for VDD_GPU
Date:   Tue, 21 Apr 2020 16:44:12 +0200
Message-Id: <cover.1587480093.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the imx8mq data sheet running VDD_GPU at 0.9V is enough
when not overclocking to 1GHz (which we currently don't do).

changes from v2:
 - rebase aginst Shawn's tree
 - fix a warning for the typec connector

Guido Günther (2):
  arm64: dts: imx8mq-librem5-devkit: Use 0.9V for VDD_GPU
  arm64: dts: Don't use underscore in node name

 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.26.1

