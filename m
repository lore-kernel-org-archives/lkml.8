Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68053C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3522A206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865111;
	bh=IemQ7rz1e8vyxmLwQVB7T2/D7RFWmrBCVgX2UnWu0OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z3/UgT5fJUhgtxMAA0T7csLYma+lVYaD+bZzPUgfFdN/kw2HXTgD3zFUMmy2rBSZb
	 DluMCKb+5gzWzKRgCopqwTX9e2MHeG0o0KePHVukzEyqjnW5c87WQOH4YakBx/akkY
	 +flYj5BJtnGHC60ALQX31ho50kl24/mz/aEaJoXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403850AbgAXLZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:25:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391454AbgAXLZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:25:06 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 886FF20704;
        Fri, 24 Jan 2020 11:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865106;
        bh=IemQ7rz1e8vyxmLwQVB7T2/D7RFWmrBCVgX2UnWu0OY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ZrEqkZyXo+ny6fkdnCyTNKcrEuCj9ENqhtbUc9P7xYJQz6k0z97OYq5SGMNMZ6p1
         jPlZRd/viSZATHBTq26GNJmDzNSlEgP0cpuP7khYxOc5fZyBBV+CR1htjaDySY0FlG
         KI9lHwF0LoOPOeqvPHM6asGCL5DYFo7F9Y9hhLM0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 455/639] bnxt_en: Fix ethtool selftest crash under error conditions.
Date:   Fri, 24 Jan 2020 10:30:25 +0100
Message-Id: <20200124093144.155714706@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 0a409ba4012a3..dc63d269f01dc 100644
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



