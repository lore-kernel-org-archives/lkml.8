Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0E3C4345F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C2E820A8B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595892277;
	bh=9LUzR/YtZJBcc1OX6VZNe69SBsMIeQiq5r8Yi7VeYsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0e1CEoHRJffjTOu4bzUuHeOq2c+J6SgVl3CPq1hSnuFOpQ14gJGIsBvaRc1ZJIt66
	 3ra6mL2AzwEEXKZXr8svfdDnoseOjLQoVJvHaupzkRZsPIcz//mJiAbm9bos8+Dj80
	 2CAQidMwzBgpJKzfalRsttdJ8if8Sz5XoeYhYi18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgG0XYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbgG0XY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:24:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF98D208E4;
        Mon, 27 Jul 2020 23:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595892267;
        bh=9LUzR/YtZJBcc1OX6VZNe69SBsMIeQiq5r8Yi7VeYsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t7odGp92TR4jAWKffT9EWnqsQlDNkOLub95u3xo6OLvVjIIMs677q+3kyrap5N4Im
         Wfl2nueQRno1dcjZzJ7nZt3ajgZHrLIvh8IzCq6ge86F6YP+0HFxv/CMy1WNxgQbKp
         WwoOFmI4YorisEOiu1RSiX6s4NB/21dZx7gQrGzk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Tomer Tayar <ttayar@habana.ai>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 05/17] habanalabs: prevent possible out-of-bounds array access
Date:   Mon, 27 Jul 2020 19:24:08 -0400
Message-Id: <20200727232420.717684-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727232420.717684-1-sashal@kernel.org>
References: <20200727232420.717684-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oded Gabbay <oded.gabbay@gmail.com>

[ Upstream commit cea7a0449ea3fa4883bf5dc8397f000d6b67d6cd ]

Queue index is received from the user. Therefore, we must validate it
before using it to access the queue props array.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Reviewed-by: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/habanalabs/command_submission.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 447f307ef4d6f..ef95ee33cea40 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -400,15 +400,23 @@ static struct hl_cb *validate_queue_index(struct hl_device *hdev,
 	/* Assume external queue */
 	*ext_queue = true;
 
-	hw_queue_prop = &asic->hw_queues_props[chunk->queue_index];
-
-	if ((chunk->queue_index >= HL_MAX_QUEUES) ||
-			(hw_queue_prop->type == QUEUE_TYPE_NA)) {
+	/* This must be checked here to prevent out-of-bounds access to
+	 * hw_queues_props array
+	 */
+	if (chunk->queue_index >= HL_MAX_QUEUES) {
 		dev_err(hdev->dev, "Queue index %d is invalid\n",
 			chunk->queue_index);
 		return NULL;
 	}
 
+	hw_queue_prop = &asic->hw_queues_props[chunk->queue_index];
+
+	if (hw_queue_prop->type == QUEUE_TYPE_NA) {
+		dev_err(hdev->dev, "Queue index %d is not applicable\n",
+			chunk->queue_index);
+		return -EINVAL;
+	}
+
 	if (hw_queue_prop->driver_only) {
 		dev_err(hdev->dev,
 			"Queue index %d is restricted for the kernel driver\n",
-- 
2.25.1

