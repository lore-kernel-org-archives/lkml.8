Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68103C3F349
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EAC20726
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811084;
	bh=QfhNG+2Bqggo8/TPGsYpzPuD4HNyMRGUQS3IdG4mdnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BCK/yH18/BkwrYEkaC38+A/6sFr3lwWNqFgyoSffJjt4T09bnN1du1q42zlPVUb0V
	 8AH7KVtzVApnhQYlq6zzQhy8i3vr0TS/DvdEQ7vWDZDhtqzg00ACSGzPvuvM7jo3NL
	 9wa63TQ6Jk+33GlZ84jVYPWRgU+g/tO+AFv8PB30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbgB0Nol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:44:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729436AbgB0Nog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:44:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89161246A9;
        Thu, 27 Feb 2020 13:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811076;
        bh=QfhNG+2Bqggo8/TPGsYpzPuD4HNyMRGUQS3IdG4mdnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cgPTQ8Ry7GbJucrcUUzWD5HMB7ggNwRyunvX7oqvv/yvYwPV6doPTvStCCQgaIlum
         7Srpdv1GXZDYSsbnRyjtXuT9X3gT2snUrUL/jvLL6fVVcs67ToBuiFkkzD4j4bxXa4
         eWE/G3FnG6Py/Z4bNKZU73Fz9kLUUSnmcQCs/QrI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rahul Kundu <rahul.kundu@chelsio.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Dakshaja Uppalapati <dakshaja@chelsio.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 108/113] scsi: Revert "target: iscsi: Wait for all commands to finish before freeing a session"
Date:   Thu, 27 Feb 2020 14:37:04 +0100
Message-Id: <20200227132229.067564398@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132211.791484803@linuxfoundation.org>
References: <20200227132211.791484803@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

commit 807b9515b7d044cf77df31f1af9d842a76ecd5cb upstream.

Since commit e9d3009cb936 introduced a regression and since the fix for
that regression was not perfect, revert this commit.

Link: https://marc.info/?l=target-devel&m=158157054906195
Cc: Rahul Kundu <rahul.kundu@chelsio.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reported-by: Dakshaja Uppalapati <dakshaja@chelsio.com>
Fixes: e9d3009cb936 ("scsi: target: iscsi: Wait for all commands to finish before freeing a session")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/target/iscsi/iscsi_target.c |   10 ++--------
 include/scsi/iscsi_proto.h          |    1 -
 2 files changed, 2 insertions(+), 9 deletions(-)

--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -993,9 +993,7 @@ int iscsit_setup_scsi_cmd(struct iscsi_c
 		hdr->cmdsn, be32_to_cpu(hdr->data_length), payload_length,
 		conn->cid);
 
-	if (target_get_sess_cmd(&cmd->se_cmd, true) < 0)
-		return iscsit_add_reject_cmd(cmd,
-				ISCSI_REASON_WAITING_FOR_LOGOUT, buf);
+	target_get_sess_cmd(&cmd->se_cmd, true);
 
 	cmd->sense_reason = transport_lookup_cmd_lun(&cmd->se_cmd,
 						     scsilun_to_int(&hdr->lun));
@@ -1806,9 +1804,7 @@ iscsit_handle_task_mgt_cmd(struct iscsi_
 			      conn->sess->se_sess, 0, DMA_NONE,
 			      TCM_SIMPLE_TAG, cmd->sense_buffer + 2);
 
-	if (target_get_sess_cmd(&cmd->se_cmd, true) < 0)
-		return iscsit_add_reject_cmd(cmd,
-				ISCSI_REASON_WAITING_FOR_LOGOUT, buf);
+	target_get_sess_cmd(&cmd->se_cmd, true);
 
 	/*
 	 * TASK_REASSIGN for ERL=2 / connection stays inside of
@@ -4394,8 +4390,6 @@ int iscsit_close_connection(
 	 * must wait until they have completed.
 	 */
 	iscsit_check_conn_usage_count(conn);
-	target_sess_cmd_list_set_waiting(sess->se_sess);
-	target_wait_for_sess_cmds(sess->se_sess);
 
 	if (conn->conn_rx_hash.tfm)
 		crypto_free_hash(conn->conn_rx_hash.tfm);
--- a/include/scsi/iscsi_proto.h
+++ b/include/scsi/iscsi_proto.h
@@ -638,7 +638,6 @@ struct iscsi_reject {
 #define ISCSI_REASON_BOOKMARK_INVALID	9
 #define ISCSI_REASON_BOOKMARK_NO_RESOURCES	10
 #define ISCSI_REASON_NEGOTIATION_RESET	11
-#define ISCSI_REASON_WAITING_FOR_LOGOUT	12
 
 /* Max. number of Key=Value pairs in a text message */
 #define MAX_KEY_VALUE_PAIRS	8192


