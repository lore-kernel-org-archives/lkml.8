Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FDAC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8653920661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200592;
	bh=yMXuyAR6PqJcgBeraLWWJOmAPLzea7zZyDI8rS7zrO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nbk0V0Xex/RvP3eaLUvlbhZ38xk+EWVul2ixxrS6Ntr6RBKwxL62NpjUtEbiAU5wT
	 KfyzYpxg5dq5QhFaHHw2t4aMbqIa+GKcN11OOq5cHUYKy6NQyQB1/GFSQIB8uxVEHl
	 XIWu+GxXWSY4N+AG2psXws6/dtgHNnaizkG50g80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436497AbgAPStu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:49:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389658AbgAPRJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:09:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A94F24680;
        Thu, 16 Jan 2020 17:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194559;
        bh=yMXuyAR6PqJcgBeraLWWJOmAPLzea7zZyDI8rS7zrO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LD1fP+9u1hWLSQlKqy6FljGXmaV4nmQNUoKPtJWhKTzMcWxWgGzTlqQzLIY1YGLJY
         qlU/F/yt4tFQ/UVKPj0IFZZUNZObm4jyuXcrnsBBq6KoUG/5X1dZgFOJYmufb3LlAK
         ec1ZlFFgq6L07Hzu7Q6H80ApXFDpkvsDDscRPfUM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Chan <michael.chan@broadcom.com>,
        Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 440/671] bnxt_en: Fix ethtool selftest crash under error conditions.
Date:   Thu, 16 Jan 2020 12:01:18 -0500
Message-Id: <20200116170509.12787-177-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit d27e2ca1166aefd54d9c48fb6647dee8115a5dfc ]

After ethtool loopback packet tests, we re-open the nic for the next
IRQ test.  If the open fails, we must not proceed with the IRQ test
or we will crash with NULL pointer dereference.  Fix it by checking
the bnxt_open_nic() return code before proceeding.

Reported-by: Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>
Fixes: 67fea463fd87 ("bnxt_en: Add interrupt test to ethtool -t selftest.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 0a409ba4012a..dc63d269f01d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2600,7 +2600,7 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 	bool offline = false;
 	u8 test_results = 0;
 	u8 test_mask = 0;
-	int rc, i;
+	int rc = 0, i;
 
 	if (!bp->num_tests || !BNXT_SINGLE_PF(bp))
 		return;
@@ -2671,9 +2671,9 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 		}
 		bnxt_hwrm_phy_loopback(bp, false, false);
 		bnxt_half_close_nic(bp);
-		bnxt_open_nic(bp, false, true);
+		rc = bnxt_open_nic(bp, false, true);
 	}
-	if (bnxt_test_irq(bp)) {
+	if (rc || bnxt_test_irq(bp)) {
 		buf[BNXT_IRQ_TEST_IDX] = 1;
 		etest->flags |= ETH_TEST_FL_FAILED;
 	}
-- 
2.20.1

