Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F60C4332E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1588620A8B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584564991;
	bh=l6XDXJrfeQwv1WCOxswPCxkQXUA1zqUxLnPLuVDTJZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=epUppWmxgA9YaWcL78zmQaE4bZip5Mylwact8LxArABf6tMdWRtBVBmWhbrI3Jf+7
	 YWs1m24gJOgqp3OjUPG252qeySbUZFSbqygSDVDh+5pIZXwEIaJ6JT4gZKWCWJQ1Sf
	 Yxvc64p61T428Kbtz4MOVwhRerR8J1Of+UZo0o5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgCRU43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:56:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgCRU4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:56:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 335BE21473;
        Wed, 18 Mar 2020 20:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564963;
        bh=l6XDXJrfeQwv1WCOxswPCxkQXUA1zqUxLnPLuVDTJZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l9G+uGSK+AzQMd9AK/sJhowMz2Z/D1q2b0eP7a7a8tQsUcidX0oJrrVLBJiCUKjOt
         byYHsdW0RD4ZCQYPSduTTPQtjXTapYNptxicSFPHPTJmf+NYYYfBNhY3JyG2jBpGbO
         4/dSfZhh8sSt6JqlZ5C01kMGaAaLIBh2VvjkwNLE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 06/28] bnxt_en: reinitialize IRQs when MTU is modified
Date:   Wed, 18 Mar 2020 16:55:33 -0400
Message-Id: <20200318205555.17447-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205555.17447-1-sashal@kernel.org>
References: <20200318205555.17447-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

[ Upstream commit a9b952d267e59a3b405e644930f46d252cea7122 ]

MTU changes may affect the number of IRQs so we must call
bnxt_close_nic()/bnxt_open_nic() with the irq_re_init parameter
set to true.  The reason is that a larger MTU may require
aggregation rings not needed with smaller MTU.  We may not be
able to allocate the required number of aggregation rings and
so we reduce the number of channels which will change the number
of IRQs.  Without this patch, it may crash eventually in
pci_disable_msix() when the IRQs are not properly unwound.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 41bc7820d2dde..5163da01e54f8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7310,13 +7310,13 @@ static int bnxt_change_mtu(struct net_device *dev, int new_mtu)
 	struct bnxt *bp = netdev_priv(dev);
 
 	if (netif_running(dev))
-		bnxt_close_nic(bp, false, false);
+		bnxt_close_nic(bp, true, false);
 
 	dev->mtu = new_mtu;
 	bnxt_set_ring_params(bp);
 
 	if (netif_running(dev))
-		return bnxt_open_nic(bp, false, false);
+		return bnxt_open_nic(bp, true, false);
 
 	return 0;
 }
-- 
2.20.1

