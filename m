Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED640C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0B120760
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593468242;
	bh=TQ9E0qJq16phMpfxrIhzPQ+5aXnNyTIFxB/mtYLhK8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C52rCKjSCs1Zw3iEYoNQdLiIju9csXvRuKAJtN9t5d7bYvXYghPtU3svq5XwGwmre
	 QxWNOo2khTHa4ZLGGnmkXIGYusRLqR1pQ78nApr/mi/Z13wDH9uPWo1cjknHfB+f8w
	 OUgrxvG/VEXWpTK4crx6Ar2pp5fIqpAbIIa45qOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389477AbgF2WEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgF2SfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCCD024059;
        Mon, 29 Jun 2020 15:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593443928;
        bh=TQ9E0qJq16phMpfxrIhzPQ+5aXnNyTIFxB/mtYLhK8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FwQf2d19/V7gsOnNIEdzkvbFY7f/v/MYI+lpVa0Jbhxl8vKGtYxTVzj8LByYZ+S+b
         DdRnHT0m92Q6nMSHq4uRlWoo+qxmkvUdSMKX+bEqtvPA1xeiC9f8Z5pJ+fE25Q36nR
         gtT/7heGnDqfRQqeHogKwyENa43ZPvHXLtypAaBg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Chan <michael.chan@broadcom.com>,
        Edwin Peer <edwin.peer@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.7 029/265] bnxt_en: Do not enable legacy TX push on older firmware.
Date:   Mon, 29 Jun 2020 11:14:22 -0400
Message-Id: <20200629151818.2493727-30-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit fed7edd18143c68c63ea049999a7e861123de6de ]

Older firmware may not support legacy TX push properly and may not
be disabling it.  So we check certain firmware versions that may
have this problem and disable legacy TX push unconditionally.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Reviewed-by: Edwin Peer <edwin.peer@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 83ed6f31a1fae..6bf97b3acdadc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6953,7 +6953,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_ERR_RECOVER_RELOAD;
 
 	bp->tx_push_thresh = 0;
-	if (flags & FUNC_QCAPS_RESP_FLAGS_PUSH_MODE_SUPPORTED)
+	if ((flags & FUNC_QCAPS_RESP_FLAGS_PUSH_MODE_SUPPORTED) &&
+	    BNXT_FW_MAJ(bp) > 217)
 		bp->tx_push_thresh = BNXT_TX_PUSH_THRESH;
 
 	hw_resc->max_rsscos_ctxs = le16_to_cpu(resp->max_rsscos_ctx);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index a880aea0c20b5..23ee433db8644 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1732,6 +1732,7 @@ struct bnxt {
 	u64			fw_ver_code;
 #define BNXT_FW_VER_CODE(maj, min, bld, rsv)			\
 	((u64)(maj) << 48 | (u64)(min) << 32 | (u64)(bld) << 16 | (rsv))
+#define BNXT_FW_MAJ(bp)		((bp)->fw_ver_code >> 48)
 
 	__be16			vxlan_port;
 	u8			vxlan_port_cnt;
-- 
2.25.1

