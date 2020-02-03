Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1D7C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF66421775
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747469;
	bh=MLE07Jg3m5Pyf3nApr/XEI7uSjm0+1XWJvjx+qBNE3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m4CiUMbGCCk/HcHxC8Hf0dTBUEsVTDlSTZzAeCh/NqCstWpu272Egm7E2NWILaTgs
	 Ow4wZjGgq2KEhFt8yrY/YB6rORBRGV99VzMhWrWglzKaiu2JNAtx5ZL2SCxOuZuTJk
	 DzZZZGSeALUp4JtvRNQfE2l/gbqTwBfkJ61LcY1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgBCQbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:31:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729694AbgBCQbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:31:03 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 093EE2080D;
        Mon,  3 Feb 2020 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747461;
        bh=MLE07Jg3m5Pyf3nApr/XEI7uSjm0+1XWJvjx+qBNE3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cpR5TjPYnXdjz/vFLQFhanvxDS/iHRDUTfdWikqk15j1OV/M1WqXYVjOf8B7EGjpm
         EP7qwVoVZC+bV0beQQxHLvPZJ+grFHpyJfC3uF0N2CchkUvDPQa/tkhU6E5sHpys8g
         yWpzq9rUqsB8TWnrrSoXEGvYEsN77NF8SeShCatQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 73/89] scsi: fnic: do not queue commands during fwreset
Date:   Mon,  3 Feb 2020 16:19:58 +0000
Message-Id: <20200203161925.918135836@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161916.847439465@linuxfoundation.org>
References: <20200203161916.847439465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 0e2209629fec427ba75a6351486153a9feddd36b ]

When a link is going down the driver will be calling fnic_cleanup_io(),
which will traverse all commands and calling 'done' for each found command.
While the traversal is handled under the host_lock, calling 'done' happens
after the host_lock is being dropped.

As fnic_queuecommand_lck() is being called with the host_lock held, it
might well be that it will pick the command being selected for abortion
from the above routine and enqueue it for sending, but then 'done' is being
called on that very command from the above routine.

Which of course confuses the hell out of the scsi midlayer.

So fix this by not queueing commands when fnic_cleanup_io is active.

Link: https://lore.kernel.org/r/20200116102053.62755-1-hare@suse.de
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/fnic/fnic_scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 242e2ee494a1c..d79ac0b24f5af 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -446,6 +446,9 @@ static int fnic_queuecommand_lck(struct scsi_cmnd *sc, void (*done)(struct scsi_
 	if (unlikely(fnic_chk_state_flags_locked(fnic, FNIC_FLAGS_IO_BLOCKED)))
 		return SCSI_MLQUEUE_HOST_BUSY;
 
+	if (unlikely(fnic_chk_state_flags_locked(fnic, FNIC_FLAGS_FWRESET)))
+		return SCSI_MLQUEUE_HOST_BUSY;
+
 	rport = starget_to_rport(scsi_target(sc->device));
 	if (!rport) {
 		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host,
-- 
2.20.1



