Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732B8C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440F820CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646813;
	bh=XF+uZhWMSbOURxQFBO8GMourxyfjCr7V8E8GKH8MksE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0hLnhPgob0CXwj9i3NcknHiMKgF86HTsxZORGV40nO/onbEkaYczkw+4ug7QoNQWc
	 fRQgTnZmHMG9uFgDGJzEUtwi3Qyl09O3MBNLH1pGOqjNb8ou9XVSCB3p1DY2JoZNj/
	 NRumMV8b3gV37Lx4nk6lcwd3SxVb6hJ5bw6ESZys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbgDKXNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730359AbgDKXNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:13:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE92420787;
        Sat, 11 Apr 2020 23:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646793;
        bh=XF+uZhWMSbOURxQFBO8GMourxyfjCr7V8E8GKH8MksE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VL5bYnBQRGnSQlkZUG0QrUSCnqFOWuzTriezGajxGDAiQ4+YZAWgIWVcrH0wYv8pa
         jlqLET9kSKnyukZgPY0xeC183c82eJYGgxugd4R6ZhwBJzp541EqMXrvaahlGN9F9G
         L31QIjReWp4Nb0VvrOJ+VySHPfP/h0pYqG6EwpjA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 57/66] scsi: qla2xxx: Add fixes for mailbox command
Date:   Sat, 11 Apr 2020 19:11:54 -0400
Message-Id: <20200411231203.25933-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411231203.25933-1-sashal@kernel.org>
References: <20200411231203.25933-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Himanshu Madhani <hmadhani@marvell.com>

[ Upstream commit 345f574dac85276d1471492c6e90c57e3f90a4f3 ]

This patch fixes:

- qla2x00_issue_iocb_timeout will now return if chip is down

- only check for sp->qpair in abort handling

Link: https://lore.kernel.org/r/20200212214436.25532-24-hmadhani@marvell.com
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_mbx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index bef9faea5eeeb..0def2f7a8af28 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -1366,6 +1366,9 @@ qla2x00_issue_iocb_timeout(scsi_qla_host_t *vha, void *buffer,
 	mbx_cmd_t	mc;
 	mbx_cmd_t	*mcp = &mc;
 
+	if (qla2x00_chip_is_down(vha))
+		return QLA_INVALID_COMMAND;
+
 	ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x1038,
 	    "Entered %s.\n", __func__);
 
@@ -1436,7 +1439,7 @@ qla2x00_abort_command(srb_t *sp)
 	ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x103b,
 	    "Entered %s.\n", __func__);
 
-	if (vha->flags.qpairs_available && sp->qpair)
+	if (sp->qpair)
 		req = sp->qpair->req;
 	else
 		req = vha->req;
-- 
2.20.1

