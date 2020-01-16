Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81A0C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E56246B0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194750;
	bh=kJDSH6qspOXmPpENhFtEh6iF87PxDG6eFgEJbsH73fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OrFWSOvnul12w7Rc9T1NkCRAmP88YuYzYlBqB7FWRW28savbKj4m1bb6AobEOSeJh
	 aX1y9TA7mZMwOeVrf4JFK6+618RSZi4OZEpFJ8yQEY2fYXiKiY25IVxzpBU9+GgykJ
	 9hzvliXdFRlRB0hIu4AVBhqH7Cc7hQdAMbH1fRjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390494AbgAPRM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:12:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390473AbgAPRM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:12:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C8C324690;
        Thu, 16 Jan 2020 17:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194746;
        bh=kJDSH6qspOXmPpENhFtEh6iF87PxDG6eFgEJbsH73fE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZH9jzOt8LMnQ6fqsL53+BeTQ0ZXzKE50ONE75ExOmry7df/a82sFuQzBHilVj5mq
         We26ybxVcGlAbnUEJBpe1s4LIPl5F0o4S+ClbYUTNQ5uWKrtplNZrmjyzZXfW6n7Nh
         YuYEYrSodT3aWIGabFjkJcRirLp8Mode66yaWrzw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 575/671] net: stmmac: gmac4+: Not all Unicast addresses may be available
Date:   Thu, 16 Jan 2020 12:03:33 -0500
Message-Id: <20200116170509.12787-312-sashal@kernel.org>
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

From: Jose Abreu <Jose.Abreu@synopsys.com>

[ Upstream commit 25683bab09a70542b9f8e3e28f79b3369e56701f ]

Some setups may not have all Unicast addresses filters available. Check
the number of available filters before trying to setup it.

Fixes: 477286b53f55 ("stmmac: add GMAC4 core support")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 48cf5e2b2441..bc8871e7351f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -443,7 +443,7 @@ static void dwmac4_set_filter(struct mac_device_info *hw,
 	}
 
 	/* Handle multiple unicast addresses */
-	if (netdev_uc_count(dev) > GMAC_MAX_PERFECT_ADDRESSES) {
+	if (netdev_uc_count(dev) > hw->unicast_filter_entries) {
 		/* Switch to promiscuous mode if more than 128 addrs
 		 * are required
 		 */
-- 
2.20.1

