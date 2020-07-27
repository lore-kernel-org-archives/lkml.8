Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5993C4345B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B7B2173E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595892272;
	bh=Iz5tUY4gfrdU2cdZyw0Xqf8QtUvX+KWg12EojTs4aaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OAaWN6am4XUDOLrHoU9xJs2t/ja6pOC66w5GFKRYyzVn1F/9VXKm8jRbsC9J6yVDP
	 xyHDirkB4gN4FXlM8L+WxMW9i/0zCgLZZoecnNNc2/ruwzGObv8M3sZc6WEbEWPTOz
	 lI38UEaY6g/eg4AAwth+v+4MGBd6qTK9CSae3kkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgG0XYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:24:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbgG0XYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:24:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 385E221883;
        Mon, 27 Jul 2020 23:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595892264;
        bh=Iz5tUY4gfrdU2cdZyw0Xqf8QtUvX+KWg12EojTs4aaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVNhS5TMpmPUt+yMzSFMnYa94p4PuNjE52ve7qsRb+YuU1yVyiEGntnDbfKoclnqm
         Xe+xhlbibwIL1X3HIjtdxX0P4wooQXcLRR8AMiXjeHlmVxg2ND30JJ9vvtPKM2smPs
         4Br4iRjvlaZa4dJcKr3nvmJff7XgErjqv5Jb6D0o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Laurence Oberman <loberman@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 03/17] qed: Disable "MFW indication via attention" SPAM every 5 minutes
Date:   Mon, 27 Jul 2020 19:24:06 -0400
Message-Id: <20200727232420.717684-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727232420.717684-1-sashal@kernel.org>
References: <20200727232420.717684-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurence Oberman <loberman@redhat.com>

[ Upstream commit 1d61e21852d3161f234b9656797669fe185c251b ]

This is likely firmware causing this but its starting to annoy customers.
Change the message level to verbose to prevent the spam.
Note that this seems to only show up with ISCSI enabled on the HBA via the
qedi driver.

Signed-off-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_int.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_int.c b/drivers/net/ethernet/qlogic/qed/qed_int.c
index 9f5113639eaf0..4bccaafca8b28 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_int.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_int.c
@@ -1172,7 +1172,8 @@ static int qed_int_attentions(struct qed_hwfn *p_hwfn)
 			index, attn_bits, attn_acks, asserted_bits,
 			deasserted_bits, p_sb_attn_sw->known_attn);
 	} else if (asserted_bits == 0x100) {
-		DP_INFO(p_hwfn, "MFW indication via attention\n");
+		DP_VERBOSE(p_hwfn, NETIF_MSG_INTR,
+			   "MFW indication via attention\n");
 	} else {
 		DP_VERBOSE(p_hwfn, NETIF_MSG_INTR,
 			   "MFW indication [deassertion]\n");
-- 
2.25.1

