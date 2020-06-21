Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BD2C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 18:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9757225227
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 18:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Y77qRJBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgFUShm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 14:37:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:42278 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbgFUShl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 14:37:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592764661; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=1m9LqaPA7q87uBqQLzmBOLr4aMCHc+FIo6y028MdmMU=; b=Y77qRJBZZSvL8zsaXUx8HlRk6xbW7grkJup5l6d3GABlFxlU1z801hthI2THjKju+vNEYpOq
 Y32nj+ZOhar7cYQZ9LNghD5dcUPbiO8Td9hKAp3KsN6MNYjfBza5Gwd9veQ6Fyq6g3myCZQK
 yrmox+BMFNipJYECFi+FbIXZjNU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5eefa8ed0206ad41d1d3b702 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 21 Jun 2020 18:37:33
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A659FC4339C; Sun, 21 Jun 2020 18:37:32 +0000 (UTC)
Received: from localhost (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E9DDC433CA;
        Sun, 21 Jun 2020 18:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5E9DDC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=neeraju@codeaurora.org
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: [PATCH] rcu/tree: Force quiescent state on callback overload
Date:   Mon, 22 Jun 2020 00:07:27 +0530
Message-Id: <1592764647-2452-1-git-send-email-neeraju@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On callback overload, we want to force quiescent state immediately,
for the first and second fqs. Enforce the same, by including
RCU_GP_FLAG_OVLD flag, in fqsstart check.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d0988a1..6226bfb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1865,7 +1865,7 @@ static void rcu_gp_fqs_loop(void)
 			break;
 		/* If time for quiescent-state forcing, do it. */
 		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
-		    (gf & RCU_GP_FLAG_FQS)) {
+		    (gf & (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD))) {
 			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("fqsstart"));
 			rcu_gp_fqs(first_gp_fqs);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

