Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B0DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C986D20671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="MlVPl7tH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgEOCSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 22:18:03 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:31839 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728018AbgEOCSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 22:18:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589509081; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=LIkYfJRN7PLEeEi/ulUhazbev/1bwcEkEalsKq0bNh4=; b=MlVPl7tHjjlwUtMCbQe4aK8+UC8a6Ms8/iUKFa9EpvzyK8Gcks1EidASVD9FCraVAFdpZOnd
 Xwk8YgK/ZdTyRr/9linaPf6YIW7eziA0/XO2We/6zV1qncCiBnkV/kNjfWiLLNeopTLO9wYN
 rbLhQi3SgzL3u3vmuKKJxyQYhnw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ebdfbccaefa5a01cc8977ca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 15 May 2020 02:17:48
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 80536C432C2; Fri, 15 May 2020 02:17:47 +0000 (UTC)
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 20700C433D2;
        Fri, 15 May 2020 02:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20700C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org, hemantk@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH] bus: mhi: core: Use current ee in intvec handler
Date:   Thu, 14 May 2020 20:17:29 -0600
Message-Id: <1589509049-14532-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intvec handler stores the caches ee in a local variable for use in
processing the intvec.  It should instead use the current ee which is
read at the beginning of the intvec incase that the intvec is related to
an ee change.  Otherwise, the handler might make the wrong decision
based on an incorrect ee.

Fixes: 3000f85b8f47 (bus: mhi: core: Add support for basic PM operations)
Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/bus/mhi/core/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 7272a5a..0a41fe5 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -386,8 +386,8 @@ irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *dev)
 	write_lock_irq(&mhi_cntrl->pm_lock);
 	if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
 		state = mhi_get_mhi_state(mhi_cntrl);
-		ee = mhi_cntrl->ee;
 		mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
+		ee = mhi_cntrl->ee;
 	}
 
 	if (state == MHI_STATE_SYS_ERR) {
-- 
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

