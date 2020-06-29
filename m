Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF79C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D30A820656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="vOPAUcPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgF2Szj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:55:39 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:51846 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730003AbgF2Szc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:55:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593456931; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=W2uT7RbUayI8+09oL7ZgMik7VzMZpJICcU7OK1H+EHw=; b=vOPAUcPzsYDlsnVyQ/6hXJe9jHPNwPYV7JWSuDUCtmW6n8pY6u6+R08GK6iWPuNHcfgPFigx
 fidNb6ZU+R6C0O1YNdtzo53wXVXpzf9GlD17ficNPwAeYLsyJAYhohy5A2Qdx4POP1lXEKTd
 smRpXG3fAUO9g4ynjwLubiudDYY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n18.prod.us-west-2.postgun.com with SMTP id
 5efa195a4c9690533a7b29b0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Jun 2020 16:39:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 44553C433C6; Mon, 29 Jun 2020 16:39:54 +0000 (UTC)
Received: from malabar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E169C433CA;
        Mon, 29 Jun 2020 16:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E169C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v4 1/9] bus: mhi: core: Remove double occurrence for mhi_ctrl_ev_task() declaration
Date:   Mon, 29 Jun 2020 09:39:34 -0700
Message-Id: <1593448782-8385-2-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593448782-8385-1-git-send-email-bbhatt@codeaurora.org>
References: <1593448782-8385-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mhi_ctrl_ev_task() in the internal header file occurred twice.
Remove one of the occurrences for clean-up.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/core/internal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index b1f640b..bcfa7b6 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -592,7 +592,6 @@ int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
 void mhi_pm_sys_err_handler(struct mhi_controller *mhi_cntrl);
 void mhi_fw_load_worker(struct work_struct *work);
 int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl);
-void mhi_ctrl_ev_task(unsigned long data);
 int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl);
 void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl);
 int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

