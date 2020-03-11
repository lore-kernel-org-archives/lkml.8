Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0006BC5ACBF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DEF2074E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZXDsY4AA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbgCKXOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 19:14:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37013 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731338AbgCKXOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:14:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id f16so1827083plj.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 16:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M5YJLKJcxwEPId9+i+O/beL+j/9lm96wUEn1DNYymac=;
        b=ZXDsY4AAGMrW8ORBp2CoIvZNFzwrJQ0+R9NPUeFJwxmDBONJr4Nian5wotzxXzjFO2
         vuXyKTotxNlzQqS8XQjkp5wlUQ15yNgJkXKuyumC7KlRrPMed3ayY/XCjLcDiRS5R1F4
         G19dsHJAEUZedOT0ZLQmA+7u6OVHR0xQuBrVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M5YJLKJcxwEPId9+i+O/beL+j/9lm96wUEn1DNYymac=;
        b=SStncxda0YI+fmpFG3C+0rpGZbteWJfbcGL4W998RxuwGUahIVG9psBSGdPgI2xOTW
         ec9WvhJxOf0zfufUJAuw40/E9VZdSzeRJzPuajbfNPRkbD/qJu009MbvKSlMdjal1Qme
         FB3VPyK3y79fe66QpEPPwc1XeWhIUEYK2WA+ve5e9+ppcV+30kZqm7BCaGA44Wo65xmO
         o9weZVmb5CwWMbe7KiJOB5h0ys4xBuE/fQl9tRe8qr1AuZu0widFju0iR9maw8UUzzS/
         PO5x8w4xdJpfd3dLBdG0GF7o24B0SrYewiSzx7bDmEjPML8MBIfvB81YYUhN7SjNPjSs
         qedA==
X-Gm-Message-State: ANhLgQ2SLoM/y49or8xpFWLsZREg4q3b8T9yXNtBlnW3A48pyZFMHHzH
        fpMZie5j2emjb+9qpIXrMulpBw==
X-Google-Smtp-Source: ADFU+vt15BF/iHu6Jo59dmAQcWMKOAgo8Zm7TY1fXqWSkm1ezuyQB2gDubvfPczCT8mAEGbBp7Zh5g==
X-Received: by 2002:a17:90a:357:: with SMTP id 23mr1091055pjf.192.1583968454151;
        Wed, 11 Mar 2020 16:14:14 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id g75sm2606334pje.37.2020.03.11.16.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 16:14:13 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        evgreen@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 02/10] drivers: qcom: rpmh-rsc: Document the register layout better
Date:   Wed, 11 Mar 2020 16:13:40 -0700
Message-Id: <20200311161104.RFT.v2.2.Iaddc29b72772e6ea381238a0ee85b82d3903e5f2@changeid>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200311231348.129254-1-dianders@chromium.org>
References: <20200311231348.129254-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps it's just me, it took a really long time to understand what
the register layout of rpmh-rsc was just from the #defines.  Let's add
a bunch of comments describing which blocks are part of other blocks.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Now prose in comments instead of struct definitions.
- Pretty ASCII art from Stephen.

 drivers/soc/qcom/rpmh-rsc.c | 78 ++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index b87b79f0347d..02c8e0ffbbe4 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -37,14 +37,24 @@
 #define DRV_NCPT_MASK			0x1F
 #define DRV_NCPT_SHIFT			27
 
-/* Register offsets */
+/*
+ * Register offsets within a TCS.
+ *
+ * TCSs are stored one after another; multiply tcs_id by RSC_DRV_TCS_OFFSET
+ * to find a given TCS and add one of the below to find a register.
+ */
 #define RSC_DRV_IRQ_ENABLE		0x00
 #define RSC_DRV_IRQ_STATUS		0x04
-#define RSC_DRV_IRQ_CLEAR		0x08
-#define RSC_DRV_CMD_WAIT_FOR_CMPL	0x10
+#define RSC_DRV_IRQ_CLEAR		0x08	/* w/o; write 1 to clear */
+#define RSC_DRV_CMD_WAIT_FOR_CMPL	0x10	/* 1 bit per command */
 #define RSC_DRV_CONTROL			0x14
-#define RSC_DRV_STATUS			0x18
-#define RSC_DRV_CMD_ENABLE		0x1C
+#define RSC_DRV_STATUS			0x18	/* zero if tcs is busy */
+#define RSC_DRV_CMD_ENABLE		0x1C	/* 1 bit per command */
+
+/*
+ * Commands (up to 16) start at 0x30 in a TCS; multiply command index
+ * by RSC_DRV_CMD_OFFSET and add one of the below to find a register.
+ */
 #define RSC_DRV_CMD_MSGID		0x30
 #define RSC_DRV_CMD_ADDR		0x34
 #define RSC_DRV_CMD_DATA		0x38
@@ -61,6 +71,64 @@
 #define CMD_STATUS_ISSUED		BIT(8)
 #define CMD_STATUS_COMPL		BIT(16)
 
+/*
+ * Here's a high level overview of how all the registers in RPMH work
+ * together:
+ *
+ * - The main rpmh-rsc address is the base of a register space that can
+ *   be used to find overall configuration of the hardware
+ *   (DRV_PRNT_CHLD_CONFIG).  Also found within the rpmh-rsc register
+ *   space are all the TCS blocks.  The offset of the TCS blocks is
+ *   specified in the device tree by "qcom,tcs-offset" and used to
+ *   compute tcs_base.
+ * - TCS blocks come one after another.  Type, count, and order are
+ *   specified by the device tree as "qcom,tcs-config".
+ * - Each TCS block has some registers, then space for up to 16 commands.
+ *   Note that though address space is reserved for 16 commands, fewer
+ *   might be present.  See ncpt (num cmds per TCS).
+ * - The first TCS block is special in that it has registers to control
+ *   interrupts (RSC_DRV_IRQ_XXX).  Space for these registers is reserved
+ *   in all TCS blocks to make the math easier, but only the first one
+ *   matters.
+ *
+ * Here's a picture:
+ *
+ *  +---------------------------------------------------+
+ *  |RSC                                                |
+ *  | ctrl                                              |
+ *  |                                                   |
+ *  | Drvs:                                             |
+ *  | +-----------------------------------------------+ |
+ *  | |DRV0                                           | |
+ *  | | ctrl                                          | |
+ *  | |                                               | |
+ *  | | TCSs:                                         | |
+ *  | | +------------------------------------------+  | |
+ *  | | |TCS0  |  |  |  |  |  |  |  |  |  |  |  |  |  | |
+ *  | | | IRQ  | 0| 1| 2| 3| 4| 5| .| .| .| .|14|15|  | |
+ *  | | | ctrl |  |  |  |  |  |  |  |  |  |  |  |  |  | |
+ *  | | +------------------------------------------+  | |
+ *  | | +------------------------------------------+  | |
+ *  | | |TCS1  |  |  |  |  |  |  |  |  |  |  |  |  |  | |
+ *  | | |      | 0| 1| 2| 3| 4| 5| .| .| .| .|14|15|  | |
+ *  | | | ctrl |  |  |  |  |  |  |  |  |  |  |  |  |  | |
+ *  | | +------------------------------------------+  | |
+ *  | | +------------------------------------------+  | |
+ *  | | |TCS2  |  |  |  |  |  |  |  |  |  |  |  |  |  | |
+ *  | | |      | 0| 1| 2| 3| 4| 5| .| .| .| .|14|15|  | |
+ *  | | | ctrl |  |  |  |  |  |  |  |  |  |  |  |  |  | |
+ *  | | +------------------------------------------+  | |
+ *  | |                    ......                     | |
+ *  | +-----------------------------------------------+ |
+ *  | +-----------------------------------------------+ |
+ *  | |DRV1                                           | |
+ *  | | (same as DRV0)                                | |
+ *  | +-----------------------------------------------+ |
+ *  |                      ......                       |
+ *  +---------------------------------------------------+
+ */
+
+
 static u32 read_tcs_cmd(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
 {
 	return readl_relaxed(drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg +
-- 
2.25.1.481.gfbce0eb801-goog

