Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF48C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534EC207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TF2Wb0P9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgEURDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbgEURDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:03:12 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90136C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:12 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n18so3607028pfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FEuwJaG5URTzBfiAVO5fSIfxwEDeBWH52Z0wn/F3cVs=;
        b=TF2Wb0P9dB5k+fhF6P65+UQvmORyfP9rOufC9P/2WEG7sPx6WCXu9bsDaRjQ4qFnmO
         EdamoyzbDbSzXI54S67q9pi/ucP9/+5AT55FOeA42S5aSUxm86Tp3Pzqq8UVN2GXtkcl
         6UR4VSjLkE03uDnzUz+Gi+xlOf8qycwp7OyP4dZiODklUyxssipb1Ucwbfd09AGZlq4a
         tjFsFnF2W+4ar6qc7kldH5u0mmQ1RiuvXEptaAKSzXhTbQcUHyCi3Np7oGKidCk2v8lr
         YbcQKeKzxLfil4cCiG8AzS78L1D4AaC1Vgf2dmgAaR/QaNH0ISS1OwVsaZn5FdtHBae3
         pB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FEuwJaG5URTzBfiAVO5fSIfxwEDeBWH52Z0wn/F3cVs=;
        b=s2utPpAcJDknIwUNe+Vbbv+8LDAPFxlsVhE/rXWnTzH7vqGDSm7Bc4Jw9pt7aQLN+g
         FQdYONA8E+t1uW6KjwBQ69Fbo/xMZUhPEQU6KUOaAdzwNZRDJNw3tIVhDPOpr8XmPcib
         jW2wMCNXiWurjh9aqoiaWboyk/Eh8dmXH8sPFidpTfq8EoyutXFFZ8Ou9erlMqyz9zTH
         8PHRG1hdwjujDRrnOSl15ht5YmqEUirlW7EDUahxS8iIacDWi/tiUmwrIOkxp5AurIEa
         9xUpp4dO9xklaaXEcyfGkbI9qnF02S9q6LeTqB5efbgTwl5g0wvOhqOvyRgVmReUzTAi
         ewGQ==
X-Gm-Message-State: AOAM530hEQpAwAwoOASlgIrpJD49xyVKAYT+Ncbx/S1B8JEmQn1L4OtX
        LFbOHIv0YTiElm8GxryAtrlO
X-Google-Smtp-Source: ABdhPJw976XEqcaoNcNO2Qd4Ey91jgV7mf72EdF1jB2q52ZSWDtELN6mzl6VCYezmPm4r1xqD5qdyw==
X-Received: by 2002:a63:cf03:: with SMTP id j3mr9623786pgg.24.1590080591971;
        Thu, 21 May 2020 10:03:11 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:69f:45f2:3d8d:3719:f568:7ee9])
        by smtp.gmail.com with ESMTPSA id e26sm4874693pff.137.2020.05.21.10.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 10:03:11 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH 03/14] bus: mhi: core: Add range check for channel id received in event ring
Date:   Thu, 21 May 2020 22:32:38 +0530
Message-Id: <20200521170249.21795-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
References: <20200521170249.21795-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemant Kumar <hemantk@codeaurora.org>

MHI data completion handler function reads channel id from event
ring element. Value is under the control of MHI devices and can be
any value between 0 and 255. In order to prevent out of bound access
add a bound check against the max channel supported by controller
and skip processing of that event ring element.

Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/main.c | 40 +++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index beac8d33d1cb..64022865cb75 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -774,9 +774,18 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 		}
 		case MHI_PKT_TYPE_TX_EVENT:
 			chan = MHI_TRE_GET_EV_CHID(local_rp);
-			mhi_chan = &mhi_cntrl->mhi_chan[chan];
-			parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
-			event_quota--;
+
+			WARN_ON(chan >= mhi_cntrl->max_chan);
+
+			/*
+			 * Only process the event ring elements whose channel
+			 * ID is within the maximum supported range.
+			 */
+			if (chan < mhi_cntrl->max_chan) {
+				mhi_chan = &mhi_cntrl->mhi_chan[chan];
+				parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
+				event_quota--;
+			}
 			break;
 		default:
 			dev_err(dev, "Unhandled event type: %d\n", type);
@@ -819,14 +828,23 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
 
 		chan = MHI_TRE_GET_EV_CHID(local_rp);
-		mhi_chan = &mhi_cntrl->mhi_chan[chan];
-
-		if (likely(type == MHI_PKT_TYPE_TX_EVENT)) {
-			parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
-			event_quota--;
-		} else if (type == MHI_PKT_TYPE_RSC_TX_EVENT) {
-			parse_rsc_event(mhi_cntrl, local_rp, mhi_chan);
-			event_quota--;
+
+		WARN_ON(chan >= mhi_cntrl->max_chan);
+
+		/*
+		 * Only process the event ring elements whose channel
+		 * ID is within the maximum supported range.
+		 */
+		if (chan < mhi_cntrl->max_chan) {
+			mhi_chan = &mhi_cntrl->mhi_chan[chan];
+
+			if (likely(type == MHI_PKT_TYPE_TX_EVENT)) {
+				parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
+				event_quota--;
+			} else if (type == MHI_PKT_TYPE_RSC_TX_EVENT) {
+				parse_rsc_event(mhi_cntrl, local_rp, mhi_chan);
+				event_quota--;
+			}
 		}
 
 		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
-- 
2.17.1

