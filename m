Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8FAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CEEA20825
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457945;
	bh=V7Inx25FIvEikDAopzfi5kQvEeEprUMdU4v0oZ/86O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s4hWmHW46jMj9v2im297yqCLioOUj3miiJmwcAV7BOpRaOvT4AVu5g5POKc2YkywQ
	 VBFKuc/p237H+iBW4Url/U5TN1m7vcotwknwywB9mBObeSfqQN3sf0CjRHKbQ5vu4g
	 Xnxk/NMJAlvPkIlT06nmHYV6wGOWl04W3sRz300Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgHCMcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbgHCMcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:32:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C37012054F;
        Mon,  3 Aug 2020 12:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457939;
        bh=V7Inx25FIvEikDAopzfi5kQvEeEprUMdU4v0oZ/86O0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RFu34zHQ98/vKCJlze06+22CBtnXjsoYHmZzsBrDc5XQE+RVyD2PQkz3fCR78gXi1
         VeAXNEQUy2R69t84SIP3Te5CMPfQSpv2cLOZeaIAx45zQoGtZdW8YIdVJLNA9NOw0l
         BchttlkJOJxVagG5aAtrGHc5QuthluY5KRlo5vCs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 37/56] ibmvnic: Fix IRQ mapping disposal in error path
Date:   Mon,  3 Aug 2020 14:19:52 +0200
Message-Id: <20200803121852.140146290@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121850.306734207@linuxfoundation.org>
References: <20200803121850.306734207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Falcon <tlfalcon@linux.ibm.com>

[ Upstream commit 27a2145d6f826d1fad9de06ac541b1016ced3427 ]

RX queue IRQ mappings are disposed in both the TX IRQ and RX IRQ
error paths. Fix this and dispose of TX IRQ mappings correctly in
case of an error.

Fixes: ea22d51a7831 ("ibmvnic: simplify and improve driver probe function")
Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5e9e45befc875..d8115a9333e05 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2926,7 +2926,7 @@ req_rx_irq_failed:
 req_tx_irq_failed:
 	for (j = 0; j < i; j++) {
 		free_irq(adapter->tx_scrq[j]->irq, adapter->tx_scrq[j]);
-		irq_dispose_mapping(adapter->rx_scrq[j]->irq);
+		irq_dispose_mapping(adapter->tx_scrq[j]->irq);
 	}
 	release_sub_crqs(adapter, 1);
 	return rc;
-- 
2.25.1



