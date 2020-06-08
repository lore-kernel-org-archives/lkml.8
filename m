Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4F4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 793D32078C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591660400;
	bh=77u72D9VlTY2jBi0AkU5YU4MRynhJxSGo/d8y+n6pyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G8F9CT685dE6My634b8inQwQc03TLvOz+JkjwpFr4Lmc6CRridoOPJMsfnAAAcGYb
	 LyKp9sIc3uZ7TKfZQXJFfxzVk9EaBL7YDPyPGtukex0OEOGxRfJ078pGaSplDPnb6n
	 X+UuUxaLKZ4VmS49tjdGd4F+OzFSyj2k8PJWvLDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbgFHXYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730748AbgFHXTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:19:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E19520870;
        Mon,  8 Jun 2020 23:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658353;
        bh=77u72D9VlTY2jBi0AkU5YU4MRynhJxSGo/d8y+n6pyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JS7MWay6iSoB4AdZcJ8uwXcPCx5CiB4+fagV6KJBf9fIu8svV/0g1qQq3DLfNKQg2
         c06axhbgwfAjPUR0NkBWVQQ8PKVLFAC6aoOkJ5DtDCcv6k3kLlPi50Qp5/FkfOWYZ/
         2CU+fpAzTyPgR0BExJ39GIA3MSmitOx4dhcgjXSU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Starovoytov <mstarovoitov@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 020/175] net: atlantic: make hw_get_regs optional
Date:   Mon,  8 Jun 2020 19:16:13 -0400
Message-Id: <20200608231848.3366970-20-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Starovoytov <mstarovoitov@marvell.com>

[ Upstream commit d0f23741c202c685447050713907f3be39a985ee ]

This patch fixes potential crash in case if hw_get_regs is NULL.

Signed-off-by: Mark Starovoytov <mstarovoitov@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 12949f1ec1ea..145334fb18f4 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -690,6 +690,9 @@ int aq_nic_get_regs(struct aq_nic_s *self, struct ethtool_regs *regs, void *p)
 	u32 *regs_buff = p;
 	int err = 0;
 
+	if (unlikely(!self->aq_hw_ops->hw_get_regs))
+		return -EOPNOTSUPP;
+
 	regs->version = 1;
 
 	err = self->aq_hw_ops->hw_get_regs(self->aq_hw,
@@ -704,6 +707,9 @@ int aq_nic_get_regs(struct aq_nic_s *self, struct ethtool_regs *regs, void *p)
 
 int aq_nic_get_regs_count(struct aq_nic_s *self)
 {
+	if (unlikely(!self->aq_hw_ops->hw_get_regs))
+		return 0;
+
 	return self->aq_nic_cfg.aq_hw_caps->mac_regs_count;
 }
 
-- 
2.25.1

