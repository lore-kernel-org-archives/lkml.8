Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03990C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F8F2078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B5REFPxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgGIRqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgGIRqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:46:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D81C08E763
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 10:46:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so2758889wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 10:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C5nB3Mt8dSammYcSx/DeGO6fJUxNEtSbs7LNv2ZUITw=;
        b=B5REFPxqpY4U9h1UcdynMeECke2ws22Q/RqEx5NCXEI70dB2JA2/r2vn7gTFrZIFw8
         Ca7m0trxTRP9F03C1wWbOvUxHMMC6ghF7ruBqHISwidgCyAmIWFKzUQGSgH8eoJcGIJF
         +zPACneU93P30lrxLCM1/PORQCSPKFPP+zdUdR+/GlQZnwtumCJtVmMsXRwCH7hoSmL+
         tqO+VOjY6fl7O/0oERhX/CWuH6ISC1E++R3J+ICwgTrdKEZ5YkVzwRRUbhkAmzBYl3X/
         gp8RnGX+hznsSXdFuIsnBLrxhvfMhpyJNOS2V3FBq97kxgA3kmCu+9ckid11QOELqR4v
         KnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C5nB3Mt8dSammYcSx/DeGO6fJUxNEtSbs7LNv2ZUITw=;
        b=Ji/BJlfCn/xBa84kcFPsHVwoOfpFR0QpbjD+9DjgorUPciQckDJ1DmRWf5Gdptm0i9
         vnKmzYy3kfM4uEmNfAXIVfNhNCtlUTyN104W/TdMtvxkP0yWjJrL9iM0/6ANiNjloQ1p
         s00IXP1U3UPGF78xj8OTfLdmKfQSDMIRs2oT+CRCApP3UYL7FfAfJqEgz2haoVk/y4C6
         cvdSFcXcYo8nn6CLuYRMWaykvyuzMTyMo9iHALoLh31jg56sNw/B97MT1fU0gca3goEO
         HLWk3LKToGoH/r2/kOcl8xuuKhiccGPkibzVNlPp170rFBK1uhTGxxlgqFA/9IrOQE8K
         xLbg==
X-Gm-Message-State: AOAM533dgIy9pkw+fI/EpOXDBcxDnpdtScN02yLIffNitrEFmlgBN7co
        XihZseQNV/IT6NHl5PNrki00Tg==
X-Google-Smtp-Source: ABdhPJwbQtK2NS43DOB0/aB4cOs7/WXNqASKpn4AbxsRWRvwToV6OhSFinwvEEDRqkUsBykQalaZ+w==
X-Received: by 2002:a7b:ce14:: with SMTP id m20mr1167778wmc.129.1594316773435;
        Thu, 09 Jul 2020 10:46:13 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id f15sm6063854wrx.91.2020.07.09.10.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 10:46:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Brian King <brking@us.ibm.com>
Subject: [PATCH 13/24] scsi: ipr: Remove a bunch of set but checked variables
Date:   Thu,  9 Jul 2020 18:45:45 +0100
Message-Id: <20200709174556.7651-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709174556.7651-1-lee.jones@linaro.org>
References: <20200709174556.7651-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

In file included from  drivers/scsi/ipr.c:73:
 drivers/scsi/ipr.c: In function ‘ipr_mask_and_clear_interrupts’:
 drivers/scsi/ipr.c:740:15: warning: variable ‘int_reg’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/ipr.c: In function ‘ipr_cancel_op’:
 drivers/scsi/ipr.c:5497:13: warning: variable ‘int_reg’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/ipr.c: In function ‘ipr_iopoll’:
 drivers/scsi/ipr.c:5765:22: warning: variable ‘ioa_cfg’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/ipr.c: In function ‘ipr_reset_restore_cfg_space’:
 drivers/scsi/ipr.c:8662:6: warning: variable ‘int_reg’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/ipr.c: In function ‘ipr_test_msi’:

Cc: Brian King <brking@us.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/ipr.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index f85020904099e..b0aa58d117cc9 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -738,7 +738,6 @@ struct ipr_cmnd *ipr_get_free_ipr_cmnd(struct ipr_ioa_cfg *ioa_cfg)
 static void ipr_mask_and_clear_interrupts(struct ipr_ioa_cfg *ioa_cfg,
 					  u32 clr_ints)
 {
-	volatile u32 int_reg;
 	int i;
 
 	/* Stop new interrupts */
@@ -758,7 +757,7 @@ static void ipr_mask_and_clear_interrupts(struct ipr_ioa_cfg *ioa_cfg,
 	if (ioa_cfg->sis64)
 		writel(~0, ioa_cfg->regs.clr_interrupt_reg);
 	writel(clr_ints, ioa_cfg->regs.clr_interrupt_reg32);
-	int_reg = readl(ioa_cfg->regs.sense_interrupt_reg);
+	readl(ioa_cfg->regs.sense_interrupt_reg);
 }
 
 /**
@@ -5510,7 +5509,7 @@ static int ipr_cancel_op(struct scsi_cmnd *scsi_cmd)
 	struct ipr_ioa_cfg *ioa_cfg;
 	struct ipr_resource_entry *res;
 	struct ipr_cmd_pkt *cmd_pkt;
-	u32 ioasc, int_reg;
+	u32 ioasc;
 	int i, op_found = 0;
 	struct ipr_hrr_queue *hrrq;
 
@@ -5533,7 +5532,7 @@ static int ipr_cancel_op(struct scsi_cmnd *scsi_cmd)
 	 * by a still not detected EEH error. In such cases, reading a register will
 	 * trigger the EEH recovery infrastructure.
 	 */
-	int_reg = readl(ioa_cfg->regs.sense_interrupt_reg);
+	readl(ioa_cfg->regs.sense_interrupt_reg);
 
 	if (!ipr_is_gscsi(res))
 		return FAILED;
@@ -5780,7 +5779,6 @@ static int ipr_process_hrrq(struct ipr_hrr_queue *hrr_queue, int budget,
 
 static int ipr_iopoll(struct irq_poll *iop, int budget)
 {
-	struct ipr_ioa_cfg *ioa_cfg;
 	struct ipr_hrr_queue *hrrq;
 	struct ipr_cmnd *ipr_cmd, *temp;
 	unsigned long hrrq_flags;
@@ -5788,7 +5786,6 @@ static int ipr_iopoll(struct irq_poll *iop, int budget)
 	LIST_HEAD(doneq);
 
 	hrrq = container_of(iop, struct ipr_hrr_queue, iopoll);
-	ioa_cfg = hrrq->ioa_cfg;
 
 	spin_lock_irqsave(hrrq->lock, hrrq_flags);
 	completed_ops = ipr_process_hrrq(hrrq, budget, &doneq);
@@ -8681,7 +8678,6 @@ static int ipr_dump_mailbox_wait(struct ipr_cmnd *ipr_cmd)
 static int ipr_reset_restore_cfg_space(struct ipr_cmnd *ipr_cmd)
 {
 	struct ipr_ioa_cfg *ioa_cfg = ipr_cmd->ioa_cfg;
-	u32 int_reg;
 
 	ENTER;
 	ioa_cfg->pdev->state_saved = true;
@@ -8697,7 +8693,7 @@ static int ipr_reset_restore_cfg_space(struct ipr_cmnd *ipr_cmd)
 	if (ioa_cfg->sis64) {
 		/* Set the adapter to the correct endian mode. */
 		writel(IPR_ENDIAN_SWAP_KEY, ioa_cfg->regs.endian_swap_reg);
-		int_reg = readl(ioa_cfg->regs.endian_swap_reg);
+		readl(ioa_cfg->regs.endian_swap_reg);
 	}
 
 	if (ioa_cfg->ioa_unit_checked) {
@@ -10120,7 +10116,6 @@ static irqreturn_t ipr_test_intr(int irq, void *devp)
 static int ipr_test_msi(struct ipr_ioa_cfg *ioa_cfg, struct pci_dev *pdev)
 {
 	int rc;
-	volatile u32 int_reg;
 	unsigned long lock_flags = 0;
 	int irq = pci_irq_vector(pdev, 0);
 
@@ -10131,7 +10126,7 @@ static int ipr_test_msi(struct ipr_ioa_cfg *ioa_cfg, struct pci_dev *pdev)
 	ioa_cfg->msi_received = 0;
 	ipr_mask_and_clear_interrupts(ioa_cfg, ~IPR_PCII_IOA_TRANS_TO_OPER);
 	writel(IPR_PCII_IO_DEBUG_ACKNOWLEDGE, ioa_cfg->regs.clr_interrupt_mask_reg32);
-	int_reg = readl(ioa_cfg->regs.sense_interrupt_mask_reg);
+	readl(ioa_cfg->regs.sense_interrupt_mask_reg);
 	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
 
 	rc = request_irq(irq, ipr_test_intr, 0, IPR_NAME, ioa_cfg);
@@ -10142,7 +10137,7 @@ static int ipr_test_msi(struct ipr_ioa_cfg *ioa_cfg, struct pci_dev *pdev)
 		dev_info(&pdev->dev, "IRQ assigned: %d\n", irq);
 
 	writel(IPR_PCII_IO_DEBUG_ACKNOWLEDGE, ioa_cfg->regs.sense_interrupt_reg32);
-	int_reg = readl(ioa_cfg->regs.sense_interrupt_reg);
+	readl(ioa_cfg->regs.sense_interrupt_reg);
 	wait_event_timeout(ioa_cfg->msi_wait_q, ioa_cfg->msi_received, HZ);
 	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
 	ipr_mask_and_clear_interrupts(ioa_cfg, ~IPR_PCII_IOA_TRANS_TO_OPER);
-- 
2.25.1

