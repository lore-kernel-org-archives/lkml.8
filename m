Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCDEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C8F24655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TyTcoaZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgAVIYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 03:24:01 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:44227 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726077AbgAVIYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:24:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579681439; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=BaK9wRIScTnYdLhZWXlD4XXkYiXa7pMzORrY3Jdz4lE=; b=TyTcoaZrvfLa3wWJszDUNo2g8Fw1jTbOfPf6bYqT5K4M7T+M6jbonVnZXwX/S+g21kPw2IFs
 DhsiDf9D0A1J+WzAGXxkQ3VH2bcXBNpxVjlGD17S1owF7aUyUnqSeCflf0347QCDb+pTIPpj
 fylB9AWzKCO8Vj4KPBXWm2GRw4U=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e280699.7f6ed848c500-smtp-out-n03;
 Wed, 22 Jan 2020 08:23:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3EFE8C4479C; Wed, 22 Jan 2020 08:23:52 +0000 (UTC)
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B5FFC43383;
        Wed, 22 Jan 2020 08:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B5FFC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     bjorn.andersson@linaro.org, clew@codeaurora.org
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] soc: qcom: aoss: Use wake_up_all() instead of wake_up_interruptible_all()
Date:   Wed, 22 Jan 2020 13:53:37 +0530
Message-Id: <1579681417-1155-1-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the probe the task is waiting in TASK_UNINTERRUPTIBLE state which
cannot be woken-up by wake_up_interruptible_all() function.

Use wake_up_all() to wake-up both TASK_UNINTERRUPTIBLE and
TASK_INTERRUPTIBLE state tasks.

Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/soc/qcom/qcom_aoss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index 006ac40..fe79661 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -200,7 +200,7 @@ static irqreturn_t qmp_intr(int irq, void *data)
 {
 	struct qmp *qmp = data;
 
-	wake_up_interruptible_all(&qmp->event);
+	wake_up_all(&qmp->event);
 
 	return IRQ_HANDLED;
 }
-- 
1.9.1
