Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFB8C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD58D20639
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewJ3JKHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgHOWEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbgHOVuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:55 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C712C0F26E6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:59:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l2so11052967wrc.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=D1qp9Sg5Vz7dxa7BsyonZd3Kc8l+lC9M/3l1Va+2nWM=;
        b=ewJ3JKHkqTMghk5rkiCzHfQPeZiL5378GCf2e4QX+fdrHf5zqLZay9/iat/Gb0QcPW
         0IGBiq3pCuwD8TA/vs1MZMKwhaIvtLJffg153Jy2e60LEl8esFycaOsJWqX6BXexbGYC
         WyfP2vWdWzLPYvz+sDayOp3edkJkzG3Lx7MRa0oDJ3OReBJ9MUf4iZz5AVsHI5dW8q8e
         s4iunHft6TcjESOL3RnB6wwYyEI76ZQzh0B3CIjL2m18fzBMhObRVu6+W+XMfQ1lSBf7
         SkIsfOp+g6Xk++GC1d19mvaretDliRqj0K6TDc5X1Dy5h07f2TgmrN5xSGwew3vPTZS1
         CF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=D1qp9Sg5Vz7dxa7BsyonZd3Kc8l+lC9M/3l1Va+2nWM=;
        b=Lc4UctOHqPLHkV/2YiNJT/brvk0W87vkGUqyxDSZbU2pDGkz+CyqDiwtsFFacC/3ud
         veaZDU1dCHWEH7B9vCA7aXFwh+gTGOR2kDMQPovl8CFxGGr7A9ZB+7JJJMg/0nhyiUPI
         /0FUsvTnVt+bRuA8rJS9oD93sOASBWWce0TijWVsM1/lEFvhynP/nlqVzSFzzcCtqKER
         +o5fT6UG4gpvoTMzvj2P2lPJdgJ6n91IarSVzNZ/oB204SB+eoIZ/b1kwUXBwHmq/TId
         0MRC0C7zgL3l/cWawcSqnYmKj4qVqwNRoNq2WynrLDzvzHCX3e763eLDbm9JUkIKmUpA
         JV6w==
X-Gm-Message-State: AOAM53047ap0DBlB9R8arwsoR2p4c5iBgU3HFxmj6t5AcdKbr0uZSIEA
        Mcn3wqZOoeUTW5HLRqC+5zZuhK4I5Hg=
X-Google-Smtp-Source: ABdhPJxAsJDNrK39Otc1xbssnuz3FFHo2LdOIqBaRvmTsBRkRX2si2FaB1F6EwWuqyWIgM6PmCzQbw==
X-Received: by 2002:a5d:5446:: with SMTP id w6mr7600511wrv.127.1597514390069;
        Sat, 15 Aug 2020 10:59:50 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id e5sm24460775wrc.37.2020.08.15.10.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 10:59:48 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 7/9] habanalabs: check TPC vector pipe is empty
Date:   Sat, 15 Aug 2020 20:59:36 +0300
Message-Id: <20200815175938.16619-7-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200815175938.16619-1-oded.gabbay@gmail.com>
References: <20200815175938.16619-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver waits for the TPC vector pipe to be empty before checking if the
TPC kernel has finished executing, but the code doesn't validate that the
pipe was indeed empty, it just wait for it without checking the return
value.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index ffd0849e8f2d..3360c3c207a9 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6262,6 +6262,15 @@ static int gaudi_run_tpc_kernel(struct hl_device *hdev, u64 tpc_kernel,
 		1000,
 		kernel_timeout);
 
+	if (rc) {
+		dev_err(hdev->dev,
+			"Timeout while waiting for TPC%d vector pipe\n",
+			tpc_id);
+		hdev->asic_funcs->set_clock_gating(hdev);
+		mutex_unlock(&gaudi->clk_gate_mutex);
+		return -EIO;
+	}
+
 	rc = hl_poll_timeout(
 		hdev,
 		mmTPC0_CFG_WQ_INFLIGHT_CNTR + offset,
-- 
2.17.1

