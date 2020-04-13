Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1D1C2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5574720692
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kOanPAx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbgDMREw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732350AbgDMREn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:04:43 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79E9C008748
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:04:43 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b72so4746475pfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yQa4rSEyz3ccSDXjPft7iXP/XNiFKyUc3JhnVc0uHhI=;
        b=kOanPAx2WT+vQFl1nrjQWFWMi/weFrWJhnCi7VqXMiJtMtZP16mCRouNhNTRs39mC4
         4KXi7TvuR4B8XqiZ2yKf0Xh1ZyUZLgMIwg7OemA5td/CBdmsmoTimDaHFLvEwp3RibjD
         FheMpsjQ+vA6ho7LybJrD8cl9Ufb3GGjOVRX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQa4rSEyz3ccSDXjPft7iXP/XNiFKyUc3JhnVc0uHhI=;
        b=fnWR43kS1mwnF5Z8yalSRsXqn4APLPJv13FisPCUetGL5xsUFLJ8YJShn04w0tA0RM
         4xYQLNYjjEB4rDELPYZH6Yx3CjKG+fx5Eo2DjGr/RGSBwVtekPD2BiCDlsKfu/KI32ZV
         olPfo044QKTRWJf+IA4BFLuyijeHfNVsF8tmflk17YcluDDvO8vsTu36oNrJyIE+MGuz
         zrpJFTi30uw+x2I3fNucjOlUqwTg1j0oq2m8Qa6LJpBoL7yCOpNsgS6sKP6A7hNC0X5q
         mcffua0wCyG79bt7hzYAVu1j9hfZ27Ogo8ZhG0e10dfnX+drsul9CYEtZuaTSwYYXZdV
         SU7w==
X-Gm-Message-State: AGi0Pua76vSGfKtQ+SQDs/9+NKpEjjsL59RmU4Hyk26Qkx40JDxLefyH
        bcms76qveEWf//tq0zxc/UkAmg==
X-Google-Smtp-Source: APiQypLffysxRK7c+S6N+88TezN7NVI5m12WD316lZEsBbSXW1jfZbneZUmeFqxj7+D1Gl9LArGKvA==
X-Received: by 2002:a62:764b:: with SMTP id r72mr350076pfc.207.1586797483162;
        Mon, 13 Apr 2020 10:04:43 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p62sm1634414pfb.93.2020.04.13.10.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:04:42 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     swboyd@chromium.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>, evgreen@chromium.org,
        Lina Iyer <ilina@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/10] drivers: qcom: rpmh-rsc: Document the register layout better
Date:   Mon, 13 Apr 2020 10:04:07 -0700
Message-Id: <20200413100321.v4.2.Iaddc29b72772e6ea381238a0ee85b82d3903e5f2@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200413170415.32463-1-dianders@chromium.org>
References: <20200413170415.32463-1-dianders@chromium.org>
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
Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
---

Changes in v4: None
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
index 91fb5a6d68a2..439a0eadabf1 100644
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
2.26.0.110.g2183baf09c-goog

