Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5AFC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384BF206E9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648102;
	bh=lQRj8VNsJOOF8DfDzvqCyTjDoXlEsrTKzjTgMDofYVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qeMvq8+yxhCx1lIW+MIjB4VfGM325r7VXTRa3ADcOi4zoayrxfKuij0vqTwoplkzO
	 oPDKL53/M1YPIQdsABI9O93G5z1IXrxc5yA1L24Me3w2GE72DLTW4b+Mo8TLAL9T9x
	 fJSuSMUyacYL0X0OjWHxjIUTnf7qJ/aDP9NgBCxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgDKXfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:35:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbgDKXJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:09:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6479218AC;
        Sat, 11 Apr 2020 23:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646549;
        bh=lQRj8VNsJOOF8DfDzvqCyTjDoXlEsrTKzjTgMDofYVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UuL2ZBlyiMMxtLPrbvDSfpgUcjF79k4iFWKIV1BxEp4yLfbBfcoOQjqbBRiBKgI6c
         t8Pbu4uuRpARHFlTJAjeYlfRQw3+a/P8Nf4VirfBGhZlFnD2OKpJwRcOnjLcOy7gj+
         wHQOwWpLjKzKb2fLVIQFPKmckwsHze6x34O0vgpQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 100/121] scsi: qla2xxx: fix FW resource count values
Date:   Sat, 11 Apr 2020 19:06:45 -0400
Message-Id: <20200411230706.23855-100-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

[ Upstream commit ce1ee122e0f048fc67c1259489f0802a28049bfd ]

This patch fixes issue where current and original exchanges count
were swapped for intiator and targets.

Also fix IOCB count for current and original which were swapped.

Link: https://lore.kernel.org/r/20200226224022.24518-9-hmadhani@marvell.com
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_dfs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index 0a6fb359f4d5e..e62b2115235e1 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -134,11 +134,11 @@ qla_dfs_fw_resource_cnt_show(struct seq_file *s, void *unused)
 	} else {
 		seq_puts(s, "FW Resource count\n\n");
 		seq_printf(s, "Original TGT exchg count[%d]\n", mb[1]);
-		seq_printf(s, "current TGT exchg count[%d]\n", mb[2]);
-		seq_printf(s, "original Initiator Exchange count[%d]\n", mb[3]);
-		seq_printf(s, "Current Initiator Exchange count[%d]\n", mb[6]);
-		seq_printf(s, "Original IOCB count[%d]\n", mb[7]);
-		seq_printf(s, "Current IOCB count[%d]\n", mb[10]);
+		seq_printf(s, "Current TGT exchg count[%d]\n", mb[2]);
+		seq_printf(s, "Current Initiator Exchange count[%d]\n", mb[3]);
+		seq_printf(s, "Original Initiator Exchange count[%d]\n", mb[6]);
+		seq_printf(s, "Current IOCB count[%d]\n", mb[7]);
+		seq_printf(s, "Original IOCB count[%d]\n", mb[10]);
 		seq_printf(s, "MAX VP count[%d]\n", mb[11]);
 		seq_printf(s, "MAX FCF count[%d]\n", mb[12]);
 		seq_printf(s, "Current free pageable XCB buffer cnt[%d]\n",
@@ -149,7 +149,6 @@ qla_dfs_fw_resource_cnt_show(struct seq_file *s, void *unused)
 		    mb[22]);
 		seq_printf(s, "Original Target fast XCB buffer cnt[%d]\n",
 		    mb[23]);
-
 	}
 
 	return 0;
-- 
2.20.1

