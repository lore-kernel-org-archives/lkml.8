Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60536C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A45C20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2rVIq8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505812AbgDONDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505787AbgDONDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:03:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFC2C061A10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 06:03:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i10so19042808wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 06:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5U+39TkWTU7CFl4lHYQgx2px7qcje/SDjhq9vzEPb9I=;
        b=N2rVIq8SiMSbzTNB44TC26fvAv9RrVWuy6i9RVjT2e9/6PysXAY3o0cw+pGWROjdBT
         QzuYNOW1ybVUXDbym1nHs7jnZmEcj9yMQl4lwcgD+2XpMj5fXKtoLOKFKRw8n/EbE2t9
         zWCC/2VMGbjJVcpWrjBUuOv9XEbVmwh37j3cge2Q68HSm6QnoKltgmB9pLuV69f/dohi
         +pU4kIIppcHgsVJrbc6nBBCVDeDW/19FPeZN1sQ28ssPgkfHKjNwZK5O7MwKgUuMUtXL
         5lHxtBevxCIy6Fk1UmvPiHRlkopVWcxnYeqjodhYb5FIocFN1RbPnlHNxjDxi2pUp1jL
         FSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5U+39TkWTU7CFl4lHYQgx2px7qcje/SDjhq9vzEPb9I=;
        b=Bx78FN5/yuOcsdAb7kOvI1Hgbf0uHQN+iKLQSwxCQyvOVE/EOmpPgj1itDk0PLGBL8
         k87trQViYHa+BUcL8m4OFL5dyKTbzCQJ9uJyBqkXd4n6j4ewFzh1SB/2lgWYXpZHgr1E
         VKtFR8sQSGvQyYXbpSaiX3ypCVslgB9G3xYM2aDIln0zNfpZEL/UNmdMjnjBNvO2Onn2
         mJI7z47XqnA8Mo8RaQbagXxO5UKDFEX1Njz9w6DjG+m01RAJowjfZzs/5Mbg/WH0EGO+
         +/y+PlIj9udsdoDYZiM74qYI8qkGi8QE1NbKk/HbVt6AXKxnLAPWM9+UqfSNn8/CZ2Mv
         Dx4A==
X-Gm-Message-State: AGi0PuZqKnd3LkB67lAMr7BWi4vhC1yKo5zmbZFtg9ttnI0uuDbv2mbP
        TP/bPRMxqaH4SsLpXxX7/tHr6A==
X-Google-Smtp-Source: APiQypIMFS7NVo88wMIAGwQbRJVKFV6LPETgWFgPYzxSWsJdg9b2qrRcvaAwIC/CnCOhhpM0o6Rztg==
X-Received: by 2002:adf:f282:: with SMTP id k2mr11397809wro.133.1586955811195;
        Wed, 15 Apr 2020 06:03:31 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id b66sm23418111wmh.12.2020.04.15.06.03.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 06:03:30 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 1/1] interconnect: qcom: Fix uninitialized tcs_cmd::wait
Date:   Wed, 15 Apr 2020 16:03:27 +0300
Message-Id: <20200415130327.23059-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415130327.23059-1-georgi.djakov@linaro.org>
References: <20200415130327.23059-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Tipton <mdtipton@codeaurora.org>

Currently, if tcs_cmd_gen is called with commit=false, then
tcs_cmd::wait is left uninitialized. Since the tcs_cmd structures passed
to this function aren't zero-initialized, then we're left with random
wait values. This results in waiting for completion for more commands
than is necessary, depending on what's on the stack at the time.

Removing the unnecessary if-condition fixes this, but add an explicit
memset of the tcs_cmd structure as well to ensure predictable behavior
if more tcs_cmd members are added in the future.

Fixes: 976daac4a1c5 ("interconnect: qcom: Consolidate interconnect RPMh support")
Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20200319231021.18108-1-mdtipton@codeaurora.org
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index 2adfde8cdf19..2a11a63e7217 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -96,6 +96,8 @@ static inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
 	if (!cmd)
 		return;
 
+	memset(cmd, 0, sizeof(*cmd));
+
 	if (vote_x == 0 && vote_y == 0)
 		valid = false;
 
@@ -112,8 +114,7 @@ static inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
 	 * Set the wait for completion flag on command that need to be completed
 	 * before the next command.
 	 */
-	if (commit)
-		cmd->wait = true;
+	cmd->wait = commit;
 }
 
 static void tcs_list_gen(struct list_head *bcm_list, int bucket,
