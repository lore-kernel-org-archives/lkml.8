Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC45C4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89367208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584565107;
	bh=XzLnamPGAVWNo71FOyVtfuxzgn2GqCeijCwLwzNzh+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M5sM6uvwQXDwXaep6cQzGqU2M2jCCcSv/MEn+lbdNGe5fISvw/Wi5R/yNvBv26DTU
	 mknAUTmBVLZGB93FkR57zbuAlWjlEPdgaGefBShPOndlXAJlpqnDD5NDzeuZxgFl5g
	 2eBIfeNAmfF8lXcZBUuVewGPM7IFjFlwjwl7ClSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgCRU5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbgCRU4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:56:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D958C20BED;
        Wed, 18 Mar 2020 20:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564992;
        bh=XzLnamPGAVWNo71FOyVtfuxzgn2GqCeijCwLwzNzh+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c3fu4bWVP6NsREdu+m1zjQrmWxoiqzBmAG14JJvr23h50urScQpKWxJXvHsUzSnvk
         iJG5TrBK44bTxwkC8+a2Oq+5nWgXvop9JkckLOW91tVFB+IFjNg43qVQp8flq5Rja6
         zLdBdW4+1hkuUceAPAxZDuMNMZkknR+qm8yyGayM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 02/15] bnxt_en: reinitialize IRQs when MTU is modified
Date:   Wed, 18 Mar 2020 16:56:16 -0400
Message-Id: <20200318205629.17750-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205629.17750-1-sashal@kernel.org>
References: <20200318205629.17750-1-sashal@kernel.org>
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
index fbe3c2c114f93..736e550163e10 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6439,13 +6439,13 @@ static int bnxt_change_mtu(struct net_device *dev, int new_mtu)
 		return -EINVAL;
 
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

