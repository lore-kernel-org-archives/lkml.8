Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F871C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D3B20747
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M5pTY7ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgDGXvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:51:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39534 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgDGXu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:50:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id g32so2487839pgb.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 16:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oKuFZtIVAaoTUp6zjeWWya0JiaoLnKXJuM17HCZ8dJk=;
        b=M5pTY7aojgtX6+VWwhtgGGTYPvYVdRS7o88skoxAdy5owgcafnAb5V+W5RCg8PUC/1
         6tE8wI6uOAzEqm0lU/QoXLdIhb45H8GltOdhvATslZEbyanrtcPZGpME/tpvbaBd8CcS
         kJ2SKLguRYLsxWtyVq1GF8DIhowvqKy82uvkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oKuFZtIVAaoTUp6zjeWWya0JiaoLnKXJuM17HCZ8dJk=;
        b=LtDEknwS/aU7258NGDnTbb7cMwygxcrUweSlfjqv8Zy2VwxCQbT1577aNYd7eDK9w4
         xIvrOZFhd2nBUJlG5JP9qx616pBt6Wg/78LmUxxqqyklaI8YpYx2oksNOT4x7UYSylL3
         q3gbmKX2N30+BHz8TjS/5E85kBYOsM/A0+SmssQJxzwAKZGD9ILZ4thqrmZjtd37JQv2
         fOOgz83kFHUzzoALMwZ4rozOiVXgx/3M91JGdNhfVx7tDCiUxMQh2b5qmkNI8ictSjS6
         flfs3qus+uokuppidn8FDIy33vYoY+XIsRi4dwB8eXys6/AxYn560hV8GHHUEfuhEsMT
         a44A==
X-Gm-Message-State: AGi0PuYfPZrPcf02t+vnQZ1ViGdDA0WEdj2E+gPNWK5rI/8WtEshlWbN
        97Wm58YWkOWvchYGDDi5wC5akw==
X-Google-Smtp-Source: APiQypJU+hJHpLvbm4lN8v4HiUF4yrapGknIxLf3afhVeWR7FhNmLP2sB97twUIiVcLdp85DHllyJQ==
X-Received: by 2002:aa7:93cd:: with SMTP id y13mr4738524pff.213.1586303458124;
        Tue, 07 Apr 2020 16:50:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id s27sm14467165pgn.90.2020.04.07.16.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 16:50:57 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     mka@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        evgreen@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/10] drivers: qcom: rpmh-rsc: Document the register layout better
Date:   Tue,  7 Apr 2020 16:50:16 -0700
Message-Id: <20200407164915.v3.2.Iaddc29b72772e6ea381238a0ee85b82d3903e5f2@changeid>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200407235024.260460-1-dianders@chromium.org>
References: <20200407235024.260460-1-dianders@chromium.org>
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

Changes in v3:
- Extra blank line removed (Maulik).
- IRQ registers aren't in TCS0 (Maulik).
- One space after a period now (Maulik).
- Plural of TCS fixed to TCSes following Maulik's example.
- Rebased atop v16 ('Invoke rpmh_flush...') series.

Changes in v2:
- Now prose in comments instead of struct definitions.
- Pretty ASCII art from Stephen.

 drivers/soc/qcom/rpmh-rsc.c | 79 ++++++++++++++++++++++++++++++++++---
 1 file changed, 74 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 7d9e2c2f0e27..46455b1d93f1 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -43,14 +43,29 @@
 #define DRV_NCPT_MASK			0x1F
 #define DRV_NCPT_SHIFT			27
 
-/* Register offsets */
+/* Offsets for common TCS Registers, one bit per TCS */
 #define RSC_DRV_IRQ_ENABLE		0x00
 #define RSC_DRV_IRQ_STATUS		0x04
-#define RSC_DRV_IRQ_CLEAR		0x08
-#define RSC_DRV_CMD_WAIT_FOR_CMPL	0x10
+#define RSC_DRV_IRQ_CLEAR		0x08	/* w/o; write 1 to clear */
+
+/*
+ * Offsets for per TCS Registers.
+ *
+ * TCSes start at 0x10 from tcs_base and are stored one after another.
+ * Multiply tcs_id by RSC_DRV_TCS_OFFSET to find a given TCS and add one
+ * of the below to find a register.
+ */
+#define RSC_DRV_CMD_WAIT_FOR_CMPL	0x10	/* 1 bit per command */
 #define RSC_DRV_CONTROL			0x14
-#define RSC_DRV_STATUS			0x18
-#define RSC_DRV_CMD_ENABLE		0x1C
+#define RSC_DRV_STATUS			0x18	/* zero if tcs is busy */
+#define RSC_DRV_CMD_ENABLE		0x1C	/* 1 bit per command */
+
+/*
+ * Offsets for per command in a TCS.
+ *
+ * Commands (up to 16) start at 0x30 in a TCS; multiply command index
+ * by RSC_DRV_CMD_OFFSET and add one of the below to find a register.
+ */
 #define RSC_DRV_CMD_MSGID		0x30
 #define RSC_DRV_CMD_ADDR		0x34
 #define RSC_DRV_CMD_DATA		0x38
@@ -67,6 +82,60 @@
 #define CMD_STATUS_ISSUED		BIT(8)
 #define CMD_STATUS_COMPL		BIT(16)
 
+/*
+ * Here's a high level overview of how all the registers in RPMH work
+ * together:
+ *
+ * - The main rpmh-rsc address is the base of a register space that can
+ *   be used to find overall configuration of the hardware
+ *   (DRV_PRNT_CHLD_CONFIG). Also found within the rpmh-rsc register
+ *   space are all the TCS blocks. The offset of the TCS blocks is
+ *   specified in the device tree by "qcom,tcs-offset" and used to
+ *   compute tcs_base.
+ * - TCS blocks come one after another. Type, count, and order are
+ *   specified by the device tree as "qcom,tcs-config".
+ * - Each TCS block has some registers, then space for up to 16 commands.
+ *   Note that though address space is reserved for 16 commands, fewer
+ *   might be present. See ncpt (num cmds per TCS).
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
+ *  | | ctrl/config                                   | |
+ *  | | IRQ                                           | |
+ *  | |                                               | |
+ *  | | TCSes:                                        | |
+ *  | | +------------------------------------------+  | |
+ *  | | |TCS0  |  |  |  |  |  |  |  |  |  |  |  |  |  | |
+ *  | | | ctrl | 0| 1| 2| 3| 4| 5| .| .| .| .|14|15|  | |
+ *  | | |      |  |  |  |  |  |  |  |  |  |  |  |  |  | |
+ *  | | +------------------------------------------+  | |
+ *  | | +------------------------------------------+  | |
+ *  | | |TCS1  |  |  |  |  |  |  |  |  |  |  |  |  |  | |
+ *  | | | ctrl | 0| 1| 2| 3| 4| 5| .| .| .| .|14|15|  | |
+ *  | | |      |  |  |  |  |  |  |  |  |  |  |  |  |  | |
+ *  | | +------------------------------------------+  | |
+ *  | | +------------------------------------------+  | |
+ *  | | |TCS2  |  |  |  |  |  |  |  |  |  |  |  |  |  | |
+ *  | | | ctrl | 0| 1| 2| 3| 4| 5| .| .| .| .|14|15|  | |
+ *  | | |      |  |  |  |  |  |  |  |  |  |  |  |  |  | |
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
 static u32 read_tcs_cmd(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
 {
 	return readl_relaxed(drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg +
-- 
2.26.0.292.g33ef6b2f38-goog

