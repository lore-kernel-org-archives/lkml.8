Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFE9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A84A207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPJ7d03k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgEURDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbgEURDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:03:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9A7C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:50 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f21so453427pgg.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q5yfNXBi/pyCrVYA4OXZ5wvRsd/WOmZNAVlR+n14UYs=;
        b=HPJ7d03ksJyMoak2agFqvtDlyxwuFcsHKInDj8MWW1RCe/YBh3WQyqdr6gEXXFB+f6
         LIJ6SuX2CviGIgZMtYq6l0/0LqrEdcBrjYRB+9g8X5mLoL+uQlrn8OrAdBvEZQtuV+WS
         2bdYo3zTt/8PbRVTOVufU9ICUsBGjhxUDnc0OPGsVJzFI1puYg14e6a1MV87x7ZFecs4
         I9h5PNgmcvHIDneZukvU8n+4mg08QZqudroKoksG5+ERDd8cUjiD2Iz8yVIWcnBzPt2B
         wUvIeX53dw0beZHHUFUhDpqHtwJUy/JzVXCMsbKZuvDng0v4dfFi8eQM6r2qFP+KRinJ
         y5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q5yfNXBi/pyCrVYA4OXZ5wvRsd/WOmZNAVlR+n14UYs=;
        b=T7qJRXXltv/EJh5Ae7/DJLSq0a7eAVumQEykCBhTS1QNjN1e8oPwhA2lyJvZcTpn3q
         EyU1qIp1kCr/VDGKeDN2DkadY8V1ULFyzp5EVPIpovorXWmXNlT9ySLY9TIY+c9MrwHG
         yryPb703DRiS4gKkU22+IL2gr2GNV0vdZV+H4sl6ddOOo4/H18/7zDydKg3U+rFJZ2bF
         4dNV3L6rQKRXx21UaHz4M91Ib77hMhAdYOFx/CKI/IHMgqWRVmSD3rs4EYVYW8WjLXFu
         ZS5Z+gqSGD3dUlU1cWxcEZQUmOUXLhP2KMZllR560ohEKvwJFMhEoRuhAitJhloIYYZZ
         gtAw==
X-Gm-Message-State: AOAM530oBGc8/zWkWPLD53xtqqzNmGKtoeqFtp2+RPedft7pS8/e+NTr
        3YVB432WRDCz4y+oEBTFqu2j
X-Google-Smtp-Source: ABdhPJw5cH/DhbNgfMg7/ist3nqcUZatJz2bnZAYSn8d7gmp0FtDz1Vce8nr7DWxMzjvuEnWm9Bchg==
X-Received: by 2002:aa7:93b1:: with SMTP id x17mr10516769pff.275.1590080629639;
        Thu, 21 May 2020 10:03:49 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:69f:45f2:3d8d:3719:f568:7ee9])
        by smtp.gmail.com with ESMTPSA id e26sm4874693pff.137.2020.05.21.10.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 10:03:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 11/14] bus: mhi: core: Skip handling BHI irq if MHI reg access is not allowed
Date:   Thu, 21 May 2020 22:32:46 +0530
Message-Id: <20200521170249.21795-12-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
References: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
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
2.17.1

