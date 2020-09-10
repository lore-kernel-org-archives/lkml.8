Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68263C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20AD1221EB
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgIJRex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:34:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54700 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgIJR2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:28:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A991729BB0A
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 09/12] soc: mediatek: pm-domains: Allow bus protection to ignore clear ack
Date:   Thu, 10 Sep 2020 19:28:23 +0200
Message-Id: <20200910172826.3074357-10-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910172826.3074357-1-enric.balletbo@collabora.com>
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

In some cases the hardware does not create an acknowledgment of the
bus protection clearing. Add a flag to the bus protection indicating
that a clear event will be ignored.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/soc/mediatek/mtk-pm-domains.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 52a93a87e313..29e88adc8ea6 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -60,19 +60,23 @@
 
 #define SPM_MAX_BUS_PROT_DATA		3
 
-#define _BUS_PROT(_mask, _set, _clr, _sta, _update) {	\
-		.bus_prot_mask = (_mask),		\
-		.bus_prot_set = _set,			\
-		.bus_prot_clr = _clr,			\
-		.bus_prot_sta = _sta,			\
-		.bus_prot_reg_update = _update,		\
+#define _BUS_PROT(_mask, _set, _clr, _sta, _update, _ignore) {	\
+		.bus_prot_mask = (_mask),			\
+		.bus_prot_set = _set,				\
+		.bus_prot_clr = _clr,				\
+		.bus_prot_sta = _sta,				\
+		.bus_prot_reg_update = _update,			\
+		.ignore_clr_ack = _ignore,			\
 	}
 
-#define BUS_PROT_WR(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _sta, false)
+#define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
+		_BUS_PROT(_mask, _set, _clr, _sta, false, false)
+
+#define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
+		_BUS_PROT(_mask, _set, _clr, _sta, false, true)
 
 #define BUS_PROT_UPDATE(_mask, _set, _clr, _sta)		\
-		_BUS_PROT(_mask, _set, _clr, _sta, true)
+		_BUS_PROT(_mask, _set, _clr, _sta, true, false)
 
 struct scpsys_bus_prot_data {
 	u32 bus_prot_mask;
@@ -80,6 +84,7 @@ struct scpsys_bus_prot_data {
 	u32 bus_prot_clr;
 	u32 bus_prot_sta;
 	bool bus_prot_reg_update;
+	bool ignore_clr_ack;
 };
 
 #define MAX_SUBSYS_CLKS 10
@@ -257,6 +262,9 @@ static int _scpsys_bus_protect_disable(const struct scpsys_bus_prot_data *bpd,
 		else
 			regmap_write(regmap, bpd[i].bus_prot_clr, mask);
 
+		if (bpd[i].ignore_clr_ack)
+			continue;
+
 		ret = regmap_read_poll_timeout(regmap, bpd[i].bus_prot_sta,
 					       val, !(val & mask),
 					       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
-- 
2.28.0

