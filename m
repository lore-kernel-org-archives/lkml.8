Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DD6C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8951D206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J308Rnrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbgDNRmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728863AbgDNRly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 13:41:54 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D533C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 10:41:54 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t4so199957plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 10:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b73GV4Vy2UdnTiTlwt7UyB1U6O78KTyM8pwwpV6UwBE=;
        b=J308RnrtSxmBZyD2q+SfqV2Auks0oi6JBzBiS+P2tcpUJ+WDmIasD3yN6rMcvngydH
         +zVvfYwrvLUlpW06jcUs6O/G/lJbGxYE8Oy8ZpBIw2A19HWpfwR/B/8LtNobi4UZNvrf
         +D/SdIiKchH0MKEvqcImwOxFAfLCj7tQL9r/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b73GV4Vy2UdnTiTlwt7UyB1U6O78KTyM8pwwpV6UwBE=;
        b=LV4OObTXSwGdlhGxdOX7N2pLeRDUceKvnm+lIxBFXhtf7Hyj2S44M1YApHFB7P5De6
         e6cfkut+R8tDV36Cl3lSqo0r9dcjqPCbBKi1DeCIl8xb43F2rcUz38VXLLrhsB75ltZw
         MJRSMMM30ENEw8pEX85qpZHZujwlBw6ur1mPEEwGs9F36YlpaLE/S7Goq0zONK4RejJB
         0UthPwcO9DAvpd+yCl6vLV4lFnsGVxfksG0zTj/NsEF/D0OwhBSVDwC32KixwabbgAna
         /GsDinXTOJluvjw+lY7pNj4Fa4eUxNGLrY7S8wsalaae4o2SKrIf8VZdGr4JcQgrXGU8
         aPbg==
X-Gm-Message-State: AGi0PubCjEbV+C6gKPg3udnTIN8icS8r4TDFMrdiHh1c2ipT3+CZV9uo
        JLoqoT6EIrWWKc4aMe1xLOcNng==
X-Google-Smtp-Source: APiQypK4uvD/+aVArtBTd3SKMVNcV+YPbATjoo20kaBFE0JmY5BbeYCqWNEwnhAF+rN19ABDiuoDFQ==
X-Received: by 2002:a17:90b:3615:: with SMTP id ml21mr1413294pjb.145.1586886113870;
        Tue, 14 Apr 2020 10:41:53 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id e26sm11652207pfj.61.2020.04.14.10.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:41:53 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mkshah@codeaurora.org, mka@chromium.org, swboyd@chromium.org,
        joe@perches.com, evgreen@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: rpmh-rsc: Factor "tcs_reg_addr" and "tcs_cmd_addr" calculation
Date:   Tue, 14 Apr 2020 10:41:34 -0700
Message-Id: <20200414104120.1.Ic70288f256ff0be65cac6a600367212dfe39f6c9@changeid>
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

 drivers/soc/qcom/rpmh-rsc.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 732316bb67dc..de1f9c7732e1 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -136,36 +136,45 @@
  *  +---------------------------------------------------+
  */
 
+static inline void __iomem *
+tcs_reg_addr(struct rsc_drv *drv, int reg, int tcs_id)
+{
+	return drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg;
+}
+
+static inline void __iomem *
+tcs_cmd_addr(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
+{
+	return tcs_reg_addr(drv, reg, tcs_id) + RSC_DRV_CMD_OFFSET * cmd_id;
+}
+
 static u32 read_tcs_cmd(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
 {
-	return readl_relaxed(drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg +
-			     RSC_DRV_CMD_OFFSET * cmd_id);
+	return readl_relaxed(tcs_cmd_addr(drv, reg, tcs_id, cmd_id));
 }
 
 static u32 read_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id)
 {
-	return readl_relaxed(drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg);
+	return readl_relaxed(tcs_reg_addr(drv, reg, tcs_id));
 }
 
 static void write_tcs_cmd(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id,
 			  u32 data)
 {
-	writel_relaxed(data, drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg +
-		       RSC_DRV_CMD_OFFSET * cmd_id);
+	writel_relaxed(data, tcs_cmd_addr(drv, reg, tcs_id, cmd_id));
 }
 
 static void write_tcs_reg(struct rsc_drv *drv, int reg, int tcs_id, u32 data)
 {
-	writel_relaxed(data, drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg);
+	writel_relaxed(data, tcs_reg_addr(drv, reg, tcs_id));
 }
 
 static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
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

