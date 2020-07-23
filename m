Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61479C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373DD206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HB08PN5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgGWM06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgGWMZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:25:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37A9C0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x5so4224445wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 05:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/UGwSSOfVJ61ieGuJp/ke+Vy79kXqOUhlL6mzdoMYJw=;
        b=HB08PN5OpZSPQg8TKcCyb9s+OvOQTkDdUf13RCod8CSlkh4gkBoNHy7qbGNR5E5TO4
         bxhN/ORl9XKEt9TAYCm8ePdCpHQfuRfreiRN0lraY+8t8nOYVI8xD+et9nuvfv6fPMRa
         O4NBBI0KQyJJ7iK5d1G2X/sjUq0ROZ2Wdd8XBzMmINzzs/dXTs3Azq/6GsXSZB9cuyfm
         DoxW05DgTVX04SVdwwCM+kvxJqJxb+UU6UZtWcg5Ivn5I1SZvYW9nSP+ksHgw3bNyj6+
         RpdeMM0Ahh+aYDYmkwCPq5sbCf76U8OoqVaPtGXy60YTfg07xmJyHJHnGn/8KnO94LQf
         gQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/UGwSSOfVJ61ieGuJp/ke+Vy79kXqOUhlL6mzdoMYJw=;
        b=WWNpiq4FEd8u8LG4IPlpjbgsbpSH07/w61XWtYDQNU02ciKsod5smvg+O7CR6W0PLh
         9l351Zjp/27jej+JL1xuuqrvC4BvyrCdihxIP9jfXmIaZ73eE3jdJUOn8WlqL0x35rzO
         hPsHAlR4oTT2nhy8/9YJTvfmPUH+LjYRkJfWcBYWtpVK2Fp+j+yqAaaLF1h+REGCjK0S
         wyfvR54d0KRrBuB8xYjmSThvt9SaIooSSEVkEK4AaCHje8Ghh0rMZyoihhXGDOLRkbNf
         +Z7IU59qnmDgJH5L4aKAwAXNomCD1tBlIUp2xaQbKk8HbzpRe7IKUm7GveepgyTOb2C4
         rAMg==
X-Gm-Message-State: AOAM531GoPeGKy0L71FJHQ3mVtwx68ov6beGVfoDY76RVB1P4e4LaxXh
        OdghCxoJbNzDAl1h0RmXgn/WnQ==
X-Google-Smtp-Source: ABdhPJwkcZxfhjTTuWg1EVk/SSAtzNi4LdaonYB/co3209eDkArEedg76asRWzhwyDp3QgBLXYUkLg==
X-Received: by 2002:a1c:2183:: with SMTP id h125mr4212886wmh.83.1595507106549;
        Thu, 23 Jul 2020 05:25:06 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id j5sm3510651wma.45.2020.07.23.05.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 05:25:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        QLogic-Storage-Upstream@qlogic.com
Subject: [PATCH 14/40] scsi: qla4xxx: ql4_83xx: Remove set but unused variable 'status'
Date:   Thu, 23 Jul 2020 13:24:20 +0100
Message-Id: <20200723122446.1329773-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723122446.1329773-1-lee.jones@linaro.org>
References: <20200723122446.1329773-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/qla4xxx/ql4_83xx.c: In function ‘qla4_83xx_dump_pause_control_regs’:
 drivers/scsi/qla4xxx/ql4_83xx.c:1409:9: warning: variable ‘status’ set but not used [-Wunused-but-set-variable]
 1409 | int i, status = QLA_SUCCESS;
 | ^~~~~~

Cc: QLogic-Storage-Upstream@qlogic.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/qla4xxx/ql4_83xx.c | 34 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_83xx.c b/drivers/scsi/qla4xxx/ql4_83xx.c
index 638f72c5ab052..de10e67de8c01 100644
--- a/drivers/scsi/qla4xxx/ql4_83xx.c
+++ b/drivers/scsi/qla4xxx/ql4_83xx.c
@@ -1406,16 +1406,16 @@ int qla4_83xx_isp_reset(struct scsi_qla_host *ha)
 static void qla4_83xx_dump_pause_control_regs(struct scsi_qla_host *ha)
 {
 	u32 val = 0, val1 = 0;
-	int i, status = QLA_SUCCESS;
+	int i;
 
-	status = qla4_83xx_rd_reg_indirect(ha, QLA83XX_SRE_SHIM_CONTROL, &val);
+	qla4_83xx_rd_reg_indirect(ha, QLA83XX_SRE_SHIM_CONTROL, &val);
 	DEBUG2(ql4_printk(KERN_INFO, ha, "SRE-Shim Ctrl:0x%x\n", val));
 
 	/* Port 0 Rx Buffer Pause Threshold Registers. */
 	DEBUG2(ql4_printk(KERN_INFO, ha,
 		"Port 0 Rx Buffer Pause Threshold Registers[TC7..TC0]:"));
 	for (i = 0; i < 8; i++) {
-		status = qla4_83xx_rd_reg_indirect(ha,
+		qla4_83xx_rd_reg_indirect(ha,
 				QLA83XX_PORT0_RXB_PAUSE_THRS + (i * 0x4), &val);
 		DEBUG2(pr_info("0x%x ", val));
 	}
@@ -1426,7 +1426,7 @@ static void qla4_83xx_dump_pause_control_regs(struct scsi_qla_host *ha)
 	DEBUG2(ql4_printk(KERN_INFO, ha,
 		"Port 1 Rx Buffer Pause Threshold Registers[TC7..TC0]:"));
 	for (i = 0; i < 8; i++) {
-		status = qla4_83xx_rd_reg_indirect(ha,
+		qla4_83xx_rd_reg_indirect(ha,
 				QLA83XX_PORT1_RXB_PAUSE_THRS + (i * 0x4), &val);
 		DEBUG2(pr_info("0x%x  ", val));
 	}
@@ -1437,7 +1437,7 @@ static void qla4_83xx_dump_pause_control_regs(struct scsi_qla_host *ha)
 	DEBUG2(ql4_printk(KERN_INFO, ha,
 		"Port 0 RxB Traffic Class Max Cell Registers[3..0]:"));
 	for (i = 0; i < 4; i++) {
-		status = qla4_83xx_rd_reg_indirect(ha,
+		qla4_83xx_rd_reg_indirect(ha,
 			       QLA83XX_PORT0_RXB_TC_MAX_CELL + (i * 0x4), &val);
 		DEBUG2(pr_info("0x%x  ", val));
 	}
@@ -1448,7 +1448,7 @@ static void qla4_83xx_dump_pause_control_regs(struct scsi_qla_host *ha)
 	DEBUG2(ql4_printk(KERN_INFO, ha,
 		"Port 1 RxB Traffic Class Max Cell Registers[3..0]:"));
 	for (i = 0; i < 4; i++) {
-		status = qla4_83xx_rd_reg_indirect(ha,
+		qla4_83xx_rd_reg_indirect(ha,
 			       QLA83XX_PORT1_RXB_TC_MAX_CELL + (i * 0x4), &val);
 		DEBUG2(pr_info("0x%x  ", val));
 	}
@@ -1459,15 +1459,11 @@ static void qla4_83xx_dump_pause_control_regs(struct scsi_qla_host *ha)
 	DEBUG2(ql4_printk(KERN_INFO, ha,
 			  "Port 0 RxB Rx Traffic Class Stats [TC7..TC0]"));
 	for (i = 7; i >= 0; i--) {
-		status = qla4_83xx_rd_reg_indirect(ha,
-						   QLA83XX_PORT0_RXB_TC_STATS,
-						   &val);
+		qla4_83xx_rd_reg_indirect(ha, QLA83XX_PORT0_RXB_TC_STATS, &val);
 		val &= ~(0x7 << 29);    /* Reset bits 29 to 31 */
 		qla4_83xx_wr_reg_indirect(ha, QLA83XX_PORT0_RXB_TC_STATS,
 					  (val | (i << 29)));
-		status = qla4_83xx_rd_reg_indirect(ha,
-						   QLA83XX_PORT0_RXB_TC_STATS,
-						   &val);
+		qla4_83xx_rd_reg_indirect(ha, QLA83XX_PORT0_RXB_TC_STATS, &val);
 		DEBUG2(pr_info("0x%x  ", val));
 	}
 
@@ -1477,24 +1473,18 @@ static void qla4_83xx_dump_pause_control_regs(struct scsi_qla_host *ha)
 	DEBUG2(ql4_printk(KERN_INFO, ha,
 			  "Port 1 RxB Rx Traffic Class Stats [TC7..TC0]"));
 	for (i = 7; i >= 0; i--) {
-		status = qla4_83xx_rd_reg_indirect(ha,
-						   QLA83XX_PORT1_RXB_TC_STATS,
-						   &val);
+		qla4_83xx_rd_reg_indirect(ha, QLA83XX_PORT1_RXB_TC_STATS, &val);
 		val &= ~(0x7 << 29);    /* Reset bits 29 to 31 */
 		qla4_83xx_wr_reg_indirect(ha, QLA83XX_PORT1_RXB_TC_STATS,
 					  (val | (i << 29)));
-		status = qla4_83xx_rd_reg_indirect(ha,
-						   QLA83XX_PORT1_RXB_TC_STATS,
-						   &val);
+		qla4_83xx_rd_reg_indirect(ha, QLA83XX_PORT1_RXB_TC_STATS, &val);
 		DEBUG2(pr_info("0x%x  ", val));
 	}
 
 	DEBUG2(pr_info("\n"));
 
-	status = qla4_83xx_rd_reg_indirect(ha, QLA83XX_PORT2_IFB_PAUSE_THRS,
-					   &val);
-	status = qla4_83xx_rd_reg_indirect(ha, QLA83XX_PORT3_IFB_PAUSE_THRS,
-					   &val1);
+	qla4_83xx_rd_reg_indirect(ha, QLA83XX_PORT2_IFB_PAUSE_THRS, &val);
+	qla4_83xx_rd_reg_indirect(ha, QLA83XX_PORT3_IFB_PAUSE_THRS, &val1);
 
 	DEBUG2(ql4_printk(KERN_INFO, ha,
 			  "IFB-Pause Thresholds: Port 2:0x%x, Port 3:0x%x\n",
-- 
2.25.1

