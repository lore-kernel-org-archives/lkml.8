Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBE8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDCCC207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590074810;
	bh=PEoIxyKFD6sWPpb7V0lEgmTiS8JInx32UL12xkf/v14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DzjYAod0+ezYCXdTDPenkcvTmdv00ks4GXRxMgqXvW3Rt+ZkdaI6spcQVFxpVqB4H
	 VlTDNzOnQUTgV+bgY6ESiUs7ezmM7fpd2bGY7J9EXELYdJt8Uyjgaear0T/5Lrt7jr
	 KwdqAidYa/UmyiXfG+lAeSC89nvMwNV0BUyaWDO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgEUP0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729934AbgEUP0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:26:47 -0400
Received: from localhost.localdomain (unknown [157.51.235.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAC6F207D8;
        Thu, 21 May 2020 15:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590074806;
        bh=PEoIxyKFD6sWPpb7V0lEgmTiS8JInx32UL12xkf/v14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ObSOr6Pwc3YEGeHJjNIUSD+WACN/v87mZ8a9eF9hPVK2N9bbRRgueg6IWaespdx3K
         QUYpbytYbfOrfPNUKn2p9L0ofKjygJJzEY3595HdfWHdY3UU2892qCt63ov2lpox6Y
         4N+ADrjVfgf6juxlGa4WyI8WkZCPm3GNuW5EBK/w=
From:   mani@kernel.org
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 12/14] bus: mhi: core: Do not process SYS_ERROR if RDDM is supported
Date:   Thu, 21 May 2020 20:55:38 +0530
Message-Id: <20200521152540.17335-13-mani@kernel.org>
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

Devices that support RDDM do not require processing SYS_ERROR as it is
deemed redundant. Avoid SYS_ERROR processing if RDDM is supported by
the device.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 7429189840b0..eef145180a55 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -396,9 +396,9 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
 	}
 	write_unlock_irq(&mhi_cntrl->pm_lock);
 
-	/* If device in RDDM don't bother processing SYS error */
-	if (mhi_cntrl->ee == MHI_EE_RDDM) {
-		if (mhi_cntrl->ee != ee) {
+	 /* If device supports RDDM don't bother processing SYS error */
+	if (mhi_cntrl->rddm_image) {
+		if (mhi_cntrl->ee == MHI_EE_RDDM && mhi_cntrl->ee != ee) {
 			mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_EE_RDDM);
 			wake_up_all(&mhi_cntrl->state_event);
 		}
@@ -734,6 +734,11 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 			{
 				enum mhi_pm_state new_state;
 
+				/* skip SYS_ERROR handling if RDDM supported */
+				if (mhi_cntrl->ee == MHI_EE_RDDM ||
+				    mhi_cntrl->rddm_image)
+					break;
+
 				dev_dbg(dev, "System error detected\n");
 				write_lock_irq(&mhi_cntrl->pm_lock);
 				new_state = mhi_tryset_pm_state(mhi_cntrl,
-- 
2.26.GIT

