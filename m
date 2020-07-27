Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFACC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD54120786
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595892246;
	bh=ZDt/Zl6117SPnQ8nKwlwPrgsijr9OdQmhrm1hTPLeCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mFqY7aay6wOyJ4ufgLK4arG+Y2pk5p4toWFb6Leg6JX8GNWXLX6zKtDbcpMZeODWe
	 n7LrnEruvXnE2BMTWjwM+BEzmDjfGOToKjmEUbAEJKsIZYciSUI1LNssKL5cuipYMY
	 JMJ9Nlj06oAepI5ge+CSAjRpqb/eaYuzczVKUSi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgG0XYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0XX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:23:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C514720A8B;
        Mon, 27 Jul 2020 23:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595892237;
        bh=ZDt/Zl6117SPnQ8nKwlwPrgsijr9OdQmhrm1hTPLeCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZcxjJViFXsnSAba3p980fhLk4uQaDfAvOYpe/YaVCZfqAna7vd++h8xz+tAnM2eEc
         JBOJ1iT7zLHfOyqYiqS47I6XK4tRmtJLj6oew8s2Xqd0T0PcOuQ6lKn5GCb1k4/9DW
         FHDUZU9YcqQvt5bW9so5Ku5ls4y5xg7UYWjzWbEg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Tomer Tayar <ttayar@habana.ai>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 08/25] habanalabs: prevent possible out-of-bounds array access
Date:   Mon, 27 Jul 2020 19:23:28 -0400
Message-Id: <20200727232345.717432-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727232345.717432-1-sashal@kernel.org>
References: <20200727232345.717432-1-sashal@kernel.org>
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
 drivers/misc/habanalabs/command_submission.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 409276b6374d7..e7c8e7473226f 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -425,11 +425,19 @@ static int validate_queue_index(struct hl_device *hdev,
 	struct asic_fixed_properties *asic = &hdev->asic_prop;
 	struct hw_queue_properties *hw_queue_prop;
 
+	/* This must be checked here to prevent out-of-bounds access to
+	 * hw_queues_props array
+	 */
+	if (chunk->queue_index >= HL_MAX_QUEUES) {
+		dev_err(hdev->dev, "Queue index %d is invalid\n",
+			chunk->queue_index);
+		return -EINVAL;
+	}
+
 	hw_queue_prop = &asic->hw_queues_props[chunk->queue_index];
 
-	if ((chunk->queue_index >= HL_MAX_QUEUES) ||
-			(hw_queue_prop->type == QUEUE_TYPE_NA)) {
-		dev_err(hdev->dev, "Queue index %d is invalid\n",
+	if (hw_queue_prop->type == QUEUE_TYPE_NA) {
+		dev_err(hdev->dev, "Queue index %d is not applicable\n",
 			chunk->queue_index);
 		return -EINVAL;
 	}
-- 
2.25.1

