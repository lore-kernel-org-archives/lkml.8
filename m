Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2F5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47194207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VU+iXWhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgEUREB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbgEUREA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:04:00 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FE5C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:04:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nu7so3380039pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EeYtHIYOhrBA6OPifmOIKFP4kcfASZVORto+oyQu4tM=;
        b=VU+iXWhu8jPKHtKUJEIRnGgT/2Hm+/4/RF/Dbewzzcq180H59sc/L9XTpCLu0FkBQv
         DmGjRsT8C+QYWVHh3f4U6rn2sIqQfTqyxTjXgbe3XiFUXuR1VLUI1QANqf4O52EdVm+z
         0e5vNFGhZBuf/DufmJ0c5ax+akqd23Trbvu0I+05FQsmDLwIPD7SJjErm6J3pHmGL35J
         azIzm4Z8g18AKgvHnkwffDpvQraKMiUo8UJgCx5Hlaq/pd0IdX/NuqbdNhDxRzyADWZ8
         iAGRKel6qagYv3mBsnvs9jOrK3XwhMiC7TsM0ap7QvfK3tH7k7xbWs/XFSH/dA0ue/vo
         pRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EeYtHIYOhrBA6OPifmOIKFP4kcfASZVORto+oyQu4tM=;
        b=SzjxQ17uXVcXlisscDfGt9v4kkaIlpp8WXKyqbfTWE4jqZp2LjYZ4ejhuIPR02kM2I
         rF2hlwi1KpgdNB0oNOfElMWdmZ5abhS9X7y5DVOicEQJSQs8XV4VJh9v1DAM3Di426rd
         7E3skXUAhGqI+iNFOF1v0cViVuhx0vw8wBNr3QBOX3kbcG/mLUgDmbQ4ul1IrgMMEOGt
         iAvTPcd/DDTGq0tnVtozytCmRq6tG3hGT1PLHAlJUWrwwP2yaP8pV4/r6r1TkfIfiZGV
         v4GHB35KfMGme1d4cKkkKYcu1+5IyhY6wbNMwd85ZrOTPdp1deKqA+7nOL1SNsDrTt5D
         oYZQ==
X-Gm-Message-State: AOAM532ard4s8KqAXbg5jqkDLbi2mZtueP7e5QrLFxYyBpO1atC7bS2h
        mltQE5iZHZFpPjDF/Jk6RBFx
X-Google-Smtp-Source: ABdhPJytAabPuW4Vy17vaIbjJOJVfAsJ5CMiw1EV2ncVPoTOY6irlTOJUCuJB/k/HAva2kBRRy/coQ==
X-Received: by 2002:a17:90a:5288:: with SMTP id w8mr9815699pjh.66.1590080639483;
        Thu, 21 May 2020 10:03:59 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:69f:45f2:3d8d:3719:f568:7ee9])
        by smtp.gmail.com with ESMTPSA id e26sm4874693pff.137.2020.05.21.10.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 10:03:58 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 13/14] bus: mhi: core: Handle write lock properly in mhi_pm_m0_transition
Date:   Thu, 21 May 2020 22:32:48 +0530
Message-Id: <20200521170249.21795-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
References: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
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
2.17.1

