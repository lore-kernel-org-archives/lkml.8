Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70B6C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F932077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865115;
	bh=347xYjqGo2/cdyy/6HnlMu+UtDDr7Ln9gkQu+a6DbQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sfL+OV5waQddRf9fpavT/P+iMoPckSZJ2zbgyor0MtvDUBkHdTYUtQz0DNlaW2tga
	 Rf1senyWxMm3UmmuHabGRW2kpVvA+SwG62GuqjcdfDUE5oUGwOcLKnHs9Y2jcYFvVS
	 AQ85bocT/aU3aj8KJEet0V3c39eSijRrddH/MB4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391461AbgAXLZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:25:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403849AbgAXLZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:25:09 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2F45206D4;
        Fri, 24 Jan 2020 11:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865109;
        bh=347xYjqGo2/cdyy/6HnlMu+UtDDr7Ln9gkQu+a6DbQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NrDrbwNL06bWa8nPYjBQdKGeY9xMw0JKehTv1Wb5FeaqeTxNjuSGojmpTm+bM+FM9
         qm5yG6GUooutIjKhhJPNHl8OnJqn0sTCwnY9YU3JffDdIFk++H3r2R2i8hG7k2xlGi
         Dws1WcFX3h6WAirdq5O5dLlPoMWzAAqj57pCAYiA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 456/639] bnxt_en: Suppress error messages when querying DSCP DCB capabilities.
Date:   Fri, 24 Jan 2020 10:30:26 +0100
Message-Id: <20200124093144.302099247@linuxfoundation.org>
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

[ Upstream commit 4ca5fa39e1aea2f85eb9c4257075c4077c6531da ]

Some firmware versions do not support this so use the silent variant
to send the message to firmware to suppress the harmless error.  This
error message is unnecessarily alarming the user.

Fixes: afdc8a84844a ("bnxt_en: Add DCBNL DSCP application protocol support.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
index a85d2be986af4..0e4e0b47f5d85 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
@@ -396,7 +396,7 @@ static int bnxt_hwrm_queue_dscp_qcaps(struct bnxt *bp)
 
 	bnxt_hwrm_cmd_hdr_init(bp, &req, HWRM_QUEUE_DSCP_QCAPS, -1, -1);
 	mutex_lock(&bp->hwrm_cmd_lock);
-	rc = _hwrm_send_message(bp, &req, sizeof(req), HWRM_CMD_TIMEOUT);
+	rc = _hwrm_send_message_silent(bp, &req, sizeof(req), HWRM_CMD_TIMEOUT);
 	if (!rc) {
 		bp->max_dscp_value = (1 << resp->num_dscp_bits) - 1;
 		if (bp->max_dscp_value < 0x3f)
-- 
2.20.1



