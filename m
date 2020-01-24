Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0DCC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6096324125
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579828659;
	bh=CAoon06qVeetPHI+5B++oaz5xHfenwfMOdCiD1FwRPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qsh6zorTmcEb+puBQvu+VLQu0cqWTxqocQ9smw7uXjWLr+sMHPTe9TuGuE+juuoIl
	 fMLmJOQrZ+A8AQa6v+DM+PqHrUPXb1OLeIVkwkR4c+XlwYjYO4r+WsEi98iFZQ8Pg/
	 j4avPiJn0s6eHDiIEnmgIuGIwai6xGtqKAF0aQr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgAXBRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:17:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730608AbgAXBRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 20:17:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8432522464;
        Fri, 24 Jan 2020 01:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579828654;
        bh=CAoon06qVeetPHI+5B++oaz5xHfenwfMOdCiD1FwRPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxffk0OWsY9EZ7d0V8JZZVXi8/RGzyQgFXaTEyMqKJQLL3K/yV2vMKza5uNn+w4MI
         lWMexYf5ki6PWMaSERT+kMrzc5HSRyF1g+rdPlyIYXSLtFedu2UHERu8x2xJXbwKvS
         8ahli/fa8hmOdK1yj2PK6Nh9i8ZODcb6mbnoMblw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 22/33] bus: ti-sysc: Add module enable quirk for audio AESS
Date:   Thu, 23 Jan 2020 20:16:57 -0500
Message-Id: <20200124011708.18232-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124011708.18232-1-sashal@kernel.org>
References: <20200124011708.18232-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 020003f763e24e4ed0bb3d8909f3940891536d5d ]

We must set the autogating bit on enable for AESS (Audio Engine SubSystem)
when probed with ti-sysc interconnect target module driver. Otherwise it
won't idle properly.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c                 | 14 +++++++++++++-
 include/linux/platform_data/ti-sysc.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index c072a7fe709c3..6dc9d460e3065 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1242,6 +1242,8 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 		   SYSC_QUIRK_SWSUP_SIDLE),
 
 	/* Quirks that need to be set based on detected module */
+	SYSC_QUIRK("aess", 0, 0, 0x10, -1, 0x40000000, 0xffffffff,
+		   SYSC_MODULE_QUIRK_AESS),
 	SYSC_QUIRK("hdq1w", 0, 0, 0x14, 0x18, 0x00000006, 0xffffffff,
 		   SYSC_MODULE_QUIRK_HDQ1W),
 	SYSC_QUIRK("hdq1w", 0, 0, 0x14, 0x18, 0x0000000a, 0xffffffff,
@@ -1270,7 +1272,6 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 #ifdef DEBUG
 	SYSC_QUIRK("adc", 0, 0, 0x10, -1, 0x47300001, 0xffffffff, 0),
 	SYSC_QUIRK("atl", 0, 0, -1, -1, 0x0a070100, 0xffffffff, 0),
-	SYSC_QUIRK("aess", 0, 0, 0x10, -1, 0x40000000, 0xffffffff, 0),
 	SYSC_QUIRK("cm", 0, 0, -1, -1, 0x40000301, 0xffffffff, 0),
 	SYSC_QUIRK("control", 0, 0, 0x10, -1, 0x40000900, 0xffffffff, 0),
 	SYSC_QUIRK("cpgmac", 0, 0x1200, 0x1208, 0x1204, 0x4edb1902,
@@ -1402,6 +1403,14 @@ static void sysc_clk_enable_quirk_hdq1w(struct sysc *ddata)
 	sysc_write(ddata, offset, val);
 }
 
+/* AESS (Audio Engine SubSystem) needs autogating set after enable */
+static void sysc_module_enable_quirk_aess(struct sysc *ddata)
+{
+	int offset = 0x7c;	/* AESS_AUTO_GATING_ENABLE */
+
+	sysc_write(ddata, offset, 1);
+}
+
 /* I2C needs extra enable bit toggling for reset */
 static void sysc_clk_quirk_i2c(struct sysc *ddata, bool enable)
 {
@@ -1484,6 +1493,9 @@ static void sysc_init_module_quirks(struct sysc *ddata)
 		return;
 	}
 
+	if (ddata->cfg.quirks & SYSC_MODULE_QUIRK_AESS)
+		ddata->module_enable_quirk = sysc_module_enable_quirk_aess;
+
 	if (ddata->cfg.quirks & SYSC_MODULE_QUIRK_SGX)
 		ddata->module_enable_quirk = sysc_module_enable_quirk_sgx;
 
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
index b5b7a3423ca81..0b93804751444 100644
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -49,6 +49,7 @@ struct sysc_regbits {
 	s8 emufree_shift;
 };
 
+#define SYSC_MODULE_QUIRK_AESS		BIT(19)
 #define SYSC_MODULE_QUIRK_SGX		BIT(18)
 #define SYSC_MODULE_QUIRK_HDQ1W		BIT(17)
 #define SYSC_MODULE_QUIRK_I2C		BIT(16)
-- 
2.20.1

