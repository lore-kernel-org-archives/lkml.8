Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFFFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A6620823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgEUSwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 14:52:34 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:39316 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729329AbgEUSwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:52:33 -0400
Received: from belgarion.home ([86.210.245.36])
        by mwinf5d28 with ME
        id hWsG220030nqnCN03WsXKi; Thu, 21 May 2020 20:52:32 +0200
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 21 May 2020 20:52:32 +0200
X-ME-IP: 86.210.245.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: <soc.lore.kernel.org>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, soc@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org, Mike Rapoport <rppt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 3/3] ASoC: pxa: remove Compulab pxa2xx boards
Date:   Thu, 21 May 2020 20:51:39 +0200
Message-Id: <20200521185140.27276-3-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521185140.27276-1-robert.jarzmik@free.fr>
References: <20200521185140.27276-1-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As these boards have been removed from the pxa tree, amend accordingly
the sound subsystem.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Acked-by: Mike Rapoport <rppt@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/pxa/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index d4c0f580a565..fb2d5ab02b0d 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -128,9 +128,8 @@ config SND_PXA2XX_SOC_E800
 	  Toshiba e800 PDA
 
 config SND_PXA2XX_SOC_EM_X270
-	tristate "SoC Audio support for CompuLab EM-x270, eXeda and CM-X300"
-	depends on SND_PXA2XX_SOC && (MACH_EM_X270 || MACH_EXEDA || \
-			MACH_CM_X300)
+	tristate "SoC Audio support for CompuLab CM-X300"
+	depends on SND_PXA2XX_SOC && MACH_CM_X300
 	depends on AC97_BUS=n
 	select REGMAP
 	select AC97_BUS_NEW
-- 
2.26.2

