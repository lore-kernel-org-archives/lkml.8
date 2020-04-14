Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67E4C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B25EE2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hWzfu5AS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632732AbgDNUK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731019AbgDNUKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:10:48 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA35C03C1A8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:10:48 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m21so424869pff.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+HbRhlvMIy8BtU4nbArvVaIdClKnKmx3fk08M3A1Tw=;
        b=hWzfu5ASeq+x9poLZFbihzZcfvSnpNkS+Mz8exkiNPYNVn4CB0LRIMoQ8XVMmx/MDX
         f0Gdn/FI8JmEvsP5vjMIWV/y1KjMxPL5cmGSwUrr+F+HlheXIU/a3C4Y5gqOM414QDia
         fzXT/xQQueQmZJOZ4N4QWVV9GQtc/iJcngSXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+HbRhlvMIy8BtU4nbArvVaIdClKnKmx3fk08M3A1Tw=;
        b=eQ6Kko3LevyQJLzfHZL3CnwB5dujuaIqnIVEdM2iPKCuy5qlriX0HRU7sj0Y0sRmLj
         vM3Fwc7zjHGTQuDzdzPBO6lyEMAE/z4tWdE9ExJ5G79+QsKtcYq4NYgaKv/QrUsp+NuJ
         sKQb7IsRtsk8QtBGjUfH0sjLmbu7LD+bDELt1+eY+fU8GPPB7Ytlgf/xxX1UrqOQV1RC
         KygLrEzcXqD4dtOCdxs5Zr7wnKb6wDG6k6mcL4KV0Oa6lsbuwULFlVv36Bd5PNMsdyZJ
         5rdKvdFS3JXy6Ax9ZjxDZlmOHbbPqn7nUqSo1xIDuTNVJ5BaPr6eJDRPDXFF6AFLOfr1
         b1mA==
X-Gm-Message-State: AGi0PuazbJXmjJc1sVYCUVnVSPAUdaFBbbM8jomc+DsH3zjWZjC2krdM
        ZvhUyNBi3n7odC0BSX25tfOtRA==
X-Google-Smtp-Source: APiQypL57AogodJ/QRvyi59rvr6fP+Vcz3T49k0rmzFDNnw/tjrJwbmpCI3GG7bsGOIeV3OfL3GYcg==
X-Received: by 2002:a62:160b:: with SMTP id 11mr25627935pfw.189.1586895047051;
        Tue, 14 Apr 2020 13:10:47 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 135sm12189805pfu.207.2020.04.14.13.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:10:46 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mkshah@codeaurora.org, joe@perches.com, swboyd@chromium.org,
        mka@chromium.org, evgreen@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] soc: qcom: rpmh-rsc: Factor "tcs_reg_addr" and "tcs_cmd_addr" calculation
Date:   Tue, 14 Apr 2020 13:10:15 -0700
Message-Id: <20200414131010.v2.1.Ic70288f256ff0be65cac6a600367212dfe39f6c9@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can make some of the register access functions more readable by
factoring out the calculations a little bit.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Make drv parameter const.

 drivers/soc/qcom/rpmh-rsc.c | 41 +++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 732316bb67dc..f988e9cc2c30 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -136,36 +136,47 @@
  *  +---------------------------------------------------+
  */
 
-static u32 read_tcs_cmd(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
+static inline void __iomem *
+tcs_reg_addr(const struct rsc_drv *drv, int reg, int tcs_id)
 {
-	return readl_relaxed(drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg +
-			     RSC_DRV_CMD_OFFSET * cmd_id);
+	return drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg;
 }
 
-static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id)
+static inline void __iomem *
+tcs_cmd_addr(const struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
 {
-	return readl_relaxed(drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg);
+	return tcs_reg_addr(drv, reg, tcs_id) + RSC_DRV_CMD_OFFSET * cmd_id;
 }
 
-static void write_tcs_cmd(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id,
-			  u32 data)
+static u32 read_tcs_cmd(const struct rsc_drv *drv, int reg, int tcs_id,
+			int cmd_id)
+{
+	return readl_relaxed(tcs_cmd_addr(drv, reg, tcs_id, cmd_id));
+}
+
+static u32 read_tcs_reg(const struct rsc_drv *drv, int reg, int tcs_id)
 {
-	writel_relaxed(data, drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg +
-		       RSC_DRV_CMD_OFFSET * cmd_id);
+	return readl_relaxed(tcs_reg_addr(drv, reg, tcs_id));
 }
 
-static void write_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id, u32 data)
+static void write_tcs_cmd(const struct rsc_drv *drv, int reg, int tcs_id,
+			  int cmd_id, u32 data)
+{
+	writel_relaxed(data, tcs_cmd_addr(drv, reg, tcs_id, cmd_id));
+}
+
+static void write_tcs_reg(const struct rsc_drv *drv, int reg, int tcs_id,
+			  u32 data)
 {
-	writel_relaxed(data, drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg);
+	writel_relaxed(data, tcs_reg_addr(drv, reg, tcs_id));
 }
 
-static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
+static void write_tcs_reg_sync(const struct rsc_drv *drv, int reg, int tcs_id,
 			       u32 data)
 {
-	writel(data, drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg);
+	writel(data, tcs_reg_addr(drv, reg, tcs_id));
 	for (;;) {
-		if (data == readl(drv->tcs_base + reg +
-				  RSC_DRV_TCS_OFFSET * tcs_id))
+		if (data == readl(tcs_reg_addr(drv, reg, tcs_id)))
 			break;
 		udelay(1);
 	}
-- 
2.26.0.110.g2183baf09c-goog

