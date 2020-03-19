Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E040AC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 23:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F2820658
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 23:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="mwuBwFR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgCSXL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 19:11:28 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:29817 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727456AbgCSXL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 19:11:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584659487; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=lgPcKGxes2wWKu8ZYirzlVaF0XLf7i8dA+8OTprMqPo=; b=mwuBwFR4suPnDWS02fxmuE4C1jGRoO0j2C933CXwziS+wXB74LB8payvh6mSJuuGJ1TUkAXR
 Ucz4DMG9nPM4bFdrqGpe2KRhcWTuDsSArZVJOlPqwHzk11XonC+1jm7nmkeJ47TJbG7XDDlI
 YbM2UGHV4rv0ihe+LBbOaGP/9zs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e73fc1f.7f3350c28420-smtp-out-n04;
 Thu, 19 Mar 2020 23:11:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 140D7C43636; Thu, 19 Mar 2020 23:11:27 +0000 (UTC)
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36160C433D2;
        Thu, 19 Mar 2020 23:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36160C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH] interconnect: qcom: Fix uninitialized tcs_cmd::wait
Date:   Thu, 19 Mar 2020 16:10:21 -0700
Message-Id: <20200319231021.18108-1-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
