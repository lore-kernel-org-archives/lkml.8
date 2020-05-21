Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FD0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 676FA207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XoeXj/bW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgEUREI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbgEUREG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:04:06 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DECBC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:04:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a5so3380756pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GT1QJQok2ZeWgDDmOKZP3KFdZvLbU1iojOHos6Kus1g=;
        b=XoeXj/bWn5fPEBxKO2XN5CzZqMLSQshY7INmoMZdM8p1jF4+92iZmL62JDkX1sHS1Z
         7VMUfjeh/RQvbvaZ/N73t1h4qh5/TMlBqqCo2CeEJU6JHU3EcuYZCcapkZIPFM/VopUR
         W11PEJlAHJdAZ5COVAjIUxZWtq4nXzLbVkMvfgg76OvtIWvtsaZMqbcFaZ+doiLepxuJ
         jWMRA/4Jc0LPKQcJH/8ytikkjoRdpQPIvkVJ1Btp8+XbC95vo+4VdYQkIkpj0shFUh1R
         OerfF+4PdM8XOAqen1ijatw6E+Aif1wzkt0tpALDeSjdesVbpwFSPl2W79Kv2Rw1xuo6
         1kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GT1QJQok2ZeWgDDmOKZP3KFdZvLbU1iojOHos6Kus1g=;
        b=Pu4qcyeQp70/c703cPKiaN4LgG7mmux6hrUxlzl2m8f7JGVS4UOcIM47wCYDKsey8g
         1f+AC1mzsm8hqzPX5ANDOdKWuPFIthrp2pTOZHaP/BuTvQIsVw2e82UIon2yWTu9EWDI
         eA2zw1FgHM1e78HyBR8tMeCvbwdPUsRTgV1W5zRPsx20tM7Szvqkj0yVLcxeiLbunCAt
         L7lYBYY29C2GEM4OF4lebOscF0UQfJbHcNKU3reoZToDHcO9vyxkOmwp4ZVzSLvWZBNs
         bVzpWZR7z68ba7KHDbGs13H3ZbLf4P1uc4HENy629bxqEOswOukDNvw78LNFwKG+FyQO
         5ysw==
X-Gm-Message-State: AOAM533/cvhDqngkp+OnPWjuoixGA87qORi3MXhNuOxZBleBrGHOJ7UN
        3f6NQCUF1+dB6fy4DWVyhCCe
X-Google-Smtp-Source: ABdhPJy775tEb44MI4qz4lpz8v1vm1S79IFoYTkGMUHkJZU93PA35NHmYPJ+3qZf5imUpcQTRLXdow==
X-Received: by 2002:a17:902:bd47:: with SMTP id b7mr10908666plx.79.1590080644717;
        Thu, 21 May 2020 10:04:04 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:69f:45f2:3d8d:3719:f568:7ee9])
        by smtp.gmail.com with ESMTPSA id e26sm4874693pff.137.2020.05.21.10.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 10:04:03 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 14/14] bus: mhi: core: Handle syserr during power_up
Date:   Thu, 21 May 2020 22:32:49 +0530
Message-Id: <20200521170249.21795-15-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
References: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jhugo@codeaurora.org>

The MHI device may be in the syserr state when we attempt to init it in
power_up().  Since we have no local state, the handling is simple -
reset the device and wait for it to transition out of the reset state.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/pm.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
index e6236a3ca39d..1bd61a64d7bb 100644
--- a/drivers/bus/mhi/core/pm.c
+++ b/drivers/bus/mhi/core/pm.c
@@ -763,6 +763,7 @@ static void mhi_deassert_dev_wake(struct mhi_controller *mhi_cntrl,
 
 int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 {
+	enum mhi_state state;
 	enum mhi_ee_type current_ee;
 	enum dev_st_transition next_state;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
@@ -832,6 +833,32 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 		goto error_bhi_offset;
 	}
 
+	state = mhi_get_mhi_state(mhi_cntrl);
+	if (state == MHI_STATE_SYS_ERR) {
+		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
+		ret = wait_event_timeout(mhi_cntrl->state_event,
+				MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state) ||
+					mhi_read_reg_field(mhi_cntrl,
+							   mhi_cntrl->regs,
+							   MHICTRL,
+							   MHICTRL_RESET_MASK,
+							   MHICTRL_RESET_SHIFT,
+							   &val) ||
+					!val,
+				msecs_to_jiffies(mhi_cntrl->timeout_ms));
+		if (ret) {
+			ret = -EIO;
+			dev_info(dev, "Failed to reset MHI due to syserr state\n");
+			goto error_bhi_offset;
+		}
+
+		/*
+		 * device cleares INTVEC as part of RESET processing,
+		 * re-program it
+		 */
+		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
+	}
+
 	/* Transition to next state */
 	next_state = MHI_IN_PBL(current_ee) ?
 		DEV_ST_TRANSITION_PBL : DEV_ST_TRANSITION_READY;
-- 
2.17.1

