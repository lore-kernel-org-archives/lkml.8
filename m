Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9A3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5850E22CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597925090;
	bh=q+/BfhKioI3638M7k9ipVudVd623gBSf1KwRlG9SoYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eke26hpDDRo5DNxtH34ZzdPHVl3RKXIi9i2KiY40a8ZNsY4lv+ojPgHoTVnqpI1mY
	 cwCtERPeOtMkygLAlngPRgo0ERTFE/2e4/d9maIBt9EXETuFxrS0Dya69i3mXe0e3T
	 bbdaV4s65+oeMESiEVQh+fY8iVBM4pzTnV45M5Kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbgHTMEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730346AbgHTJ7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:59:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B42A722CAE;
        Thu, 20 Aug 2020 09:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917553;
        bh=q+/BfhKioI3638M7k9ipVudVd623gBSf1KwRlG9SoYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wW0u6OS/Gwhl+CpiVi/tVLuQwWW866pIw4O+WrK4VNn0MKiLsyQzPEuOVxYO3r237
         IHewlBd1PJjQYAVXl/lbamvLYnF0ASnk0IpdOk1yC19/gAsoCnRZXvbR90b3XqYnx9
         2A9UhslJanWGm503RFsZUs6WUUuhbybfmTX1zzrs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 032/212] ibmvnic: Fix IRQ mapping disposal in error path
Date:   Thu, 20 Aug 2020 11:20:05 +0200
Message-Id: <20200820091603.982157277@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
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
index 20f7ab4aa2f15..d25b76440c114 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1515,7 +1515,7 @@ req_rx_irq_failed:
 req_tx_irq_failed:
 	for (j = 0; j < i; j++) {
 		free_irq(adapter->tx_scrq[j]->irq, adapter->tx_scrq[j]);
-		irq_dispose_mapping(adapter->rx_scrq[j]->irq);
+		irq_dispose_mapping(adapter->tx_scrq[j]->irq);
 	}
 	release_sub_crqs_no_irqs(adapter);
 	return rc;
-- 
2.25.1



