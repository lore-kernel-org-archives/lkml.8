Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F31FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFEF2207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590074813;
	bh=v/XfBYXoPrjYbHYgPlJHQY5tb/I1IRk35QKBoZMojHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1QFf7WLithSSb0Uavu61bOUtUcgBZyHMlcPv0bro3QqS57t0/PJReZdvtNnnqoGrC
	 9OUxiTHFPUlPuMid/HkVNsDbH6b8oT/f0n1ZsJmKHLDHu8Z/qsjq1VXXPJCssQim1k
	 d2Uk8lWsoMTRXhQxStgJfSBSG4XjLWt8IybsG9Nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbgEUP0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbgEUP0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:26:51 -0400
Received: from localhost.localdomain (unknown [157.51.235.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DE8A204EA;
        Thu, 21 May 2020 15:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590074810;
        bh=v/XfBYXoPrjYbHYgPlJHQY5tb/I1IRk35QKBoZMojHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ToEeusDgM5GQ6jN1ieKEu/mMhPDiPmj6k3SWbH7lowcxJ/R+d4PlpvKy6mREHEqaW
         4rvf6MoC0Jk8siYY7FxszSGHlhEQ2t0cDHWRG1LuZq7Wq4EA6FpacRONertoBZeMuM
         Vf3FVAkyL5ebw3DPcK8F5pIGjJaN0XoD+uGDspFk=
From:   mani@kernel.org
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 13/14] bus: mhi: core: Handle write lock properly in mhi_pm_m0_transition
Date:   Thu, 21 May 2020 20:55:39 +0530
Message-Id: <20200521152540.17335-14-mani@kernel.org>
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

Take write lock only to protect db_mode member of mhi channel.
This allows rest of the mhi channels to just take read lock which
fine grains the locking. It prevents channel readers to starve if
they try to enter critical section after a writer.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/pm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index a5d9973059c8..e6236a3ca39d 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -288,14 +288,18 @@ int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl)
 	for (i = 0; i < mhi_cntrl->max_chan; i++, mhi_chan++) {
 		struct mhi_ring *tre_ring = &mhi_chan->tre_ring;
 
-		write_lock_irq(&mhi_chan->lock);
-		if (mhi_chan->db_cfg.reset_req)
+		if (mhi_chan->db_cfg.reset_req) {
+			write_lock_irq(&mhi_chan->lock);
 			mhi_chan->db_cfg.db_mode = true;
+			write_unlock_irq(&mhi_chan->lock);
+		}
+
+		read_lock_irq(&mhi_chan->lock);
 
 		/* Only ring DB if ring is not empty */
 		if (tre_ring->base && tre_ring->wp  != tre_ring->rp)
 			mhi_ring_chan_db(mhi_cntrl, mhi_chan);
-		write_unlock_irq(&mhi_chan->lock);
+		read_unlock_irq(&mhi_chan->lock);
 	}
 
 	mhi_cntrl->wake_put(mhi_cntrl, false);
-- 
2.26.GIT

