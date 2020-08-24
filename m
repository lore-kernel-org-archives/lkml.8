Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BEDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8728D206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598288972;
	bh=XMdVZ2dkxRLkuBAlv9jLdIRDBO/TOplRzASFQpmfhTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JzMFAqGdwq36Bagl0QmDbfqwOr2uNS0R9NHE4Y4fxCa/+Z2GhrgfKoQBQSzfD8mmB
	 28PydbQjydDEmXH3LFV8MeUEgr90qlwP6g3ibgRJWKMJ/P6mL+qpOQ0hIax4QgPMrH
	 h1V+8tLTJNC3lC0sg5pqW3P2p12W8C8QNR6Msy5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgHXRJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbgHXQiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:38:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C6A23101;
        Mon, 24 Aug 2020 16:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287054;
        bh=XMdVZ2dkxRLkuBAlv9jLdIRDBO/TOplRzASFQpmfhTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8ObbwTB3yOiaA7ycB6MDfWOUUg7FA6G6hevWVr57kBvAuRdzp8lps8OOsRrmLSLp
         dVukZoEhOShvR48XBpjaSHd4aUh9EEFJQT2aLCCIQ2n+9sO6jSbddL1l3iQ7QGrkmJ
         NAMLyIC140xI4MYJqmJmg27aEGRRu+9wjumXYIgU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Saurav Kashyap <skashyap@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 43/54] Revert "scsi: qla2xxx: Fix crash on qla2x00_mailbox_command"
Date:   Mon, 24 Aug 2020 12:36:22 -0400
Message-Id: <20200824163634.606093-43-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163634.606093-1-sashal@kernel.org>
References: <20200824163634.606093-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saurav Kashyap <skashyap@marvell.com>

[ Upstream commit de7e6194301ad31c4ce95395eb678e51a1b907e5 ]

FCoE adapter initialization failed for ISP8021 with the following patch
applied. In addition, reproduction of the issue the patch originally tried
to address has been unsuccessful.

This reverts commit 3cb182b3fa8b7a61f05c671525494697cba39c6a.

Link: https://lore.kernel.org/r/20200806111014.28434-11-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_mbx.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index d6c991bd1bde9..35720cdfb9c32 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -334,14 +334,6 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 			if (time_after(jiffies, wait_time))
 				break;
 
-			/*
-			 * Check if it's UNLOADING, cause we cannot poll in
-			 * this case, or else a NULL pointer dereference
-			 * is triggered.
-			 */
-			if (unlikely(test_bit(UNLOADING, &base_vha->dpc_flags)))
-				return QLA_FUNCTION_TIMEOUT;
-
 			/* Check for pending interrupts. */
 			qla2x00_poll(ha->rsp_q_map[0]);
 
-- 
2.25.1

