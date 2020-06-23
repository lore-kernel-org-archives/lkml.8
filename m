Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266E1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9A8206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592942496;
	bh=NPhdMSexgXVr2CMyXgOIkLzPcvA1wkS4We3dSQZTImo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=luqkrEgiwxC+CtP6EwIAejku7F1H3eQ32CiSeIKVo+xv1x1Z+lmrxAkKPf3xhZvSG
	 sWgqrd7I0JhW5vTqwM346bGApWehDpAzlFCHO2nXDKDak+LazhRev+8qZc2DaW2eQj
	 GIIgkkUjCUrVXFqjDOQIeqSqkzvU9q/0uPSp1qt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbgFWUBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:01:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387659AbgFWUBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:01:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86CBB20E65;
        Tue, 23 Jun 2020 20:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942489;
        bh=NPhdMSexgXVr2CMyXgOIkLzPcvA1wkS4We3dSQZTImo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tOZSEcX4KXrUSc4B1QdbIl+EOT0kDbAejqdZfsJNLDZFDf65KH7nRLzjiHf83r+tU
         fEfeq2/E7QFjEnACEJFCpAJJzW3mX0yn2rBTZXyJRRHHHwlXdEzVnygLjZLC6Q/nge
         U/Zuiiyt2U8cbyMwRnPX0o90qY/kKjVzmQmrvcKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 019/477] ASoC: codecs: wm97xx: fix ac97 dependency
Date:   Tue, 23 Jun 2020 21:50:16 +0200
Message-Id: <20200623195408.514096798@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit ee2cbe06935bfa58f1fe07dc2a2283945f4b97dc ]

A recent build fix got the dependency slightly wrong, breaking
builds with CONFIG_AC97_BUS_NEW:

WARNING: unmet direct dependencies detected for SND_SOC_WM9713
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AC97_BUS [=n]
  Selected by [m]:
  - SND_SOC_ZYLONITE [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_PXA2XX_SOC [=m] && MACH_ZYLONITE [=y] && AC97_BUS [=n]=n

WARNING: unmet direct dependencies detected for SND_SOC_WM9712
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AC97_BUS [=n]
  Selected by [m]:
  - SND_PXA2XX_SOC_EM_X270 [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_PXA2XX_SOC [=m] && (MACH_EM_X270 [=n] || MACH_EXEDA [=n] || MACH_CM_X300 [=y]) && AC97_BUS [=n]=n

Change the dependency to allow either version of the AC97 library
code.

Fixes: 5a309875787d ("ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20200428212721.2877627-1-arnd@arndb.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index e60e0b6a689cd..8cdc68c141dc2 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1620,19 +1620,19 @@ config SND_SOC_WM9090
 
 config SND_SOC_WM9705
 	tristate
-	depends on SND_SOC_AC97_BUS
+	depends on SND_SOC_AC97_BUS || AC97_BUS_NEW
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_WM9712
 	tristate
-	depends on SND_SOC_AC97_BUS
+	depends on SND_SOC_AC97_BUS || AC97_BUS_NEW
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
 config SND_SOC_WM9713
 	tristate
-	depends on SND_SOC_AC97_BUS
+	depends on SND_SOC_AC97_BUS || AC97_BUS_NEW
 	select REGMAP_AC97
 	select AC97_BUS_COMPAT if AC97_BUS_NEW
 
-- 
2.25.1



