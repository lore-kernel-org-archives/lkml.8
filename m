Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767EDC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB7821655
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979301;
	bh=FeEjMst33F7XYwCjWK2Fc1/wB2pauHmPP9mbwrcIq84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rR5kNbl/JpkxafggOTUOGyTeO6yK9Wqk1JBd0kj+Xc7kN7W6ErZOlSixqwGktUIg9
	 E+0pctJgbv+C/aAy7sRwyhPRDKBlLq8zYToHzyds8XMW6H0gsd7te4kxCkhNejmfln
	 wY/FKwWDr2nt98jFmM25kBZ/KRDtUbOETxbw/Lm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbgIAQy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:54:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729954AbgIAPYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:24:19 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE0DB20BED;
        Tue,  1 Sep 2020 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973859;
        bh=FeEjMst33F7XYwCjWK2Fc1/wB2pauHmPP9mbwrcIq84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFa6mu99ZguvENe/TzT8OqyU8WoJv5Jh35BbgZH5lOtM/FJo5RU9kbNYDHLIb4G7Y
         FZNaeRfDnGp+dq8kpBFd3XCXGsLF1aZKWO/PBGR2nPl2Qz+CDQFA/m0aIaJAdKvd0M
         x+gaXwb2vxBbKcPaa1mXS0yqlMalJocp28XMVW8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 076/125] Revert "scsi: qla2xxx: Fix crash on qla2x00_mailbox_command"
Date:   Tue,  1 Sep 2020 17:10:31 +0200
Message-Id: <20200901150938.307141874@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index ac5d2d34aeeae..07c5d7397d425 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -329,14 +329,6 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
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



