Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67943C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE3B2146E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgCCJDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:03:51 -0500
Received: from inva021.nxp.com ([92.121.34.21]:39864 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728018AbgCCJDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:03:44 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 049C5201334;
        Tue,  3 Mar 2020 10:03:43 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EAFC4201332;
        Tue,  3 Mar 2020 10:03:42 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id EFAE520414;
        Tue,  3 Mar 2020 10:03:41 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 06/11] clk: imx: Add helpers for passing the device as argument
Date:   Tue,  3 Mar 2020 11:03:21 +0200
Message-Id: <1583226206-19758-7-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com>
References: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the imx clocks that need to be registered by the audiomix need to pass
on the device so that the runtime PM support could work properly.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index cb28f06..42960a9 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -321,6 +321,13 @@ static inline struct clk_hw *imx_clk_hw_gate(const char *name, const char *paren
 				    shift, 0, &imx_ccm_lock);
 }
 
+static inline struct clk_hw *imx_dev_clk_hw_gate(struct device *dev, const char *name,
+						const char *parent, void __iomem *reg, u8 shift)
+{
+	return clk_hw_register_gate(dev, name, parent, CLK_SET_RATE_PARENT, reg,
+				    shift, 0, &imx_ccm_lock);
+}
+
 static inline struct clk_hw *imx_clk_hw_gate_dis(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
@@ -422,6 +429,15 @@ static inline struct clk_hw *imx_clk_hw_mux(const char *name, void __iomem *reg,
 			width, 0, &imx_ccm_lock);
 }
 
+static inline struct clk_hw *imx_dev_clk_hw_mux(struct device *dev, const char *name,
+                        void __iomem *reg, u8 shift, u8 width,
+                        const char * const *parents, int num_parents)
+{
+        return clk_hw_register_mux(dev, name, parents, num_parents,
+                        CLK_SET_RATE_NO_REPARENT | CLK_SET_PARENT_GATE,
+                        reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_mux2(const char *name, void __iomem *reg,
 			u8 shift, u8 width, const char * const *parents,
 			int num_parents)
@@ -484,6 +500,19 @@ static inline struct clk_hw *imx_clk_hw_mux_flags(const char *name,
 				   reg, shift, width, 0, &imx_ccm_lock);
 }
 
+static inline struct clk_hw *imx_dev_clk_hw_mux_flags(struct device *dev,
+						  const char *name,
+						  void __iomem *reg, u8 shift,
+						  u8 width,
+						  const char * const *parents,
+						  int num_parents,
+						  unsigned long flags)
+{
+	return clk_hw_register_mux(dev, name, parents, num_parents,
+				   flags | CLK_SET_RATE_NO_REPARENT,
+				   reg, shift, width, 0, &imx_ccm_lock);
+}
+
 struct clk_hw *imx_clk_hw_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
-- 
2.7.4

