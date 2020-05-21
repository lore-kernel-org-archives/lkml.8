Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4670BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17683204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590074806;
	bh=i91QfTti5DB8FqfwzsBEbItnOlrRtbcA4RiEHX/m6uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vb2ZvZrbWigd9CWHKiscHYH+LInzihSdPWc5xuWXP8mcrQXlwF/AflBzaw1lwzsjF
	 tmFVYS0FE39D2MzSlMjOypKRvhCX8/D+zULdsbsbM69AwAAgxTiySw/tZtX2SZaNSw
	 iUAFS75wScZl7jgZfR3BDYoQhZ8oyobRfaSso0w8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgEUP0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbgEUP0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:26:43 -0400
Received: from localhost.localdomain (unknown [157.51.235.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB218204EA;
        Thu, 21 May 2020 15:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590074802;
        bh=i91QfTti5DB8FqfwzsBEbItnOlrRtbcA4RiEHX/m6uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=baOcq0ZUVLdo2sQu2xef367DZ+lv3M4dxWfDNBfp4euh9094xT6kRy5L4m96SaAw/
         cOXwKEivrtOkKqVzsXX1XVrBjeGA2FiQuGRKGWOQ1FTRr7p07eJXbtg9dymZycfLMz
         oeHplKc3fqBKVVrK/XMXTJD7rvnE37GKHauIIij4=
From:   mani@kernel.org
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 11/14] bus: mhi: core: Skip handling BHI irq if MHI reg access is not allowed
Date:   Thu, 21 May 2020 20:55:37 +0530
Message-Id: <20200521152540.17335-12-mani@kernel.org>
X-Mailer: git-send-email 2.26.GIT
In-Reply-To: <20200521152540.17335-1-mani@kernel.org>
References: <20200521152540.17335-1-mani@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemant Kumar <hemantk@codeaurora.org>

Driver continues handling of BHI interrupt even if MHI register access
is not allowed. By doing so it calls the status call back and performs
early notification for the MHI client. This is not needed when MHI
register access is not allowed. Hence skip the handling in this case and
return. Also add debug log to print device state, local EE and device EE
when reg access is valid.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/main.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index e5f6500e89fd..7429189840b0 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -368,22 +368,29 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
 	return IRQ_HANDLED;
 }
 
-irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *dev)
+irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
 {
-	struct mhi_controller *mhi_cntrl = dev;
+	struct mhi_controller *mhi_cntrl = priv;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	enum mhi_state state = MHI_STATE_MAX;
 	enum mhi_pm_state pm_state = 0;
 	enum mhi_ee_type ee = 0;
 
 	write_lock_irq(&mhi_cntrl->pm_lock);
-	if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
-		state = mhi_get_mhi_state(mhi_cntrl);
-		ee = mhi_cntrl->ee;
-		mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		write_unlock_irq(&mhi_cntrl->pm_lock);
+		goto exit_intvec;
 	}
 
+	state = mhi_get_mhi_state(mhi_cntrl);
+	ee = mhi_cntrl->ee;
+	mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
+	dev_dbg(dev, "local ee:%s device ee:%s dev_state:%s\n",
+		TO_MHI_EXEC_STR(mhi_cntrl->ee), TO_MHI_EXEC_STR(ee),
+		TO_MHI_STATE_STR(state));
+
 	if (state == MHI_STATE_SYS_ERR) {
-		dev_dbg(&mhi_cntrl->mhi_dev->dev, "System error detected\n");
+		dev_dbg(dev, "System error detected\n");
 		pm_state = mhi_tryset_pm_state(mhi_cntrl,
 					       MHI_PM_SYS_ERR_DETECT);
 	}
-- 
2.26.GIT

