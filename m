Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7A2C52D2F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F3B24690
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812352;
	bh=nTUFDxJTSKMw7nm4WtGMqwa/1PFu2+DVEmLu+nBfXK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f2ijAcN2xF8k3D0463K/wjHOwvsThOMYDzb02VDMEzz38SVYukqsT84wpOEBGtorT
	 LR9KdNtjyULdgmsWeTbdVaAPCshZk/nEsp7zLCMWbyXIi8Y9v5IRgk3dfMfoOe4JjB
	 /heClaqGIltT00SvCkQSojVnAeJ44+vndRoYdvhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbgB0OFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:05:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733039AbgB0OFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:05:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B28D21D7E;
        Thu, 27 Feb 2020 14:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812347;
        bh=nTUFDxJTSKMw7nm4WtGMqwa/1PFu2+DVEmLu+nBfXK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PW2vXnxCyA4FGS4ivZT3/nlV2NYsSWNMr/C+M5AaYpeV9PIURtmF5F+hPJKeGZHDs
         bYaFQMorVJLUr1DiL4JAMnVYnYunkFJ0KtXpdGL5wQEZxn08aoUtNFiLWqkaqRKFll
         MDUkD/3wKM2Sp+07x0/i5UAFg8KKW4bRJGzUMpyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rahul Kundu <rahul.kundu@chelsio.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Dakshaja Uppalapati <dakshaja@chelsio.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 80/97] scsi: Revert "RDMA/isert: Fix a recently introduced regression related to logout"
Date:   Thu, 27 Feb 2020 14:37:28 +0100
Message-Id: <20200227132227.510397955@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132214.553656188@linuxfoundation.org>
References: <20200227132214.553656188@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

commit 76261ada16dcc3be610396a46d35acc3efbda682 upstream.

Since commit 04060db41178 introduces soft lockups when toggling network
interfaces, revert it.

Link: https://marc.info/?l=target-devel&m=158157054906196
Cc: Rahul Kundu <rahul.kundu@chelsio.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reported-by: Dakshaja Uppalapati <dakshaja@chelsio.com>
Fixes: 04060db41178 ("scsi: RDMA/isert: Fix a recently introduced regression related to logout")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/isert/ib_isert.c |   12 ++++++++++++
 drivers/target/iscsi/iscsi_target.c     |    6 +++---
 2 files changed, 15 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2584,6 +2584,17 @@ isert_wait4logout(struct isert_conn *ise
 	}
 }
 
+static void
+isert_wait4cmds(struct iscsi_conn *conn)
+{
+	isert_info("iscsi_conn %p\n", conn);
+
+	if (conn->sess) {
+		target_sess_cmd_list_set_waiting(conn->sess->se_sess);
+		target_wait_for_sess_cmds(conn->sess->se_sess);
+	}
+}
+
 /**
  * isert_put_unsol_pending_cmds() - Drop commands waiting for
  *     unsolicitate dataout
@@ -2631,6 +2642,7 @@ static void isert_wait_conn(struct iscsi
 
 	ib_drain_qp(isert_conn->qp);
 	isert_put_unsol_pending_cmds(conn);
+	isert_wait4cmds(conn);
 	isert_wait4logout(isert_conn);
 
 	queue_work(isert_release_wq, &isert_conn->release_work);
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4123,6 +4123,9 @@ int iscsit_close_connection(
 	iscsit_stop_nopin_response_timer(conn);
 	iscsit_stop_nopin_timer(conn);
 
+	if (conn->conn_transport->iscsit_wait_conn)
+		conn->conn_transport->iscsit_wait_conn(conn);
+
 	/*
 	 * During Connection recovery drop unacknowledged out of order
 	 * commands for this connection, and prepare the other commands
@@ -4208,9 +4211,6 @@ int iscsit_close_connection(
 	target_sess_cmd_list_set_waiting(sess->se_sess);
 	target_wait_for_sess_cmds(sess->se_sess);
 
-	if (conn->conn_transport->iscsit_wait_conn)
-		conn->conn_transport->iscsit_wait_conn(conn);
-
 	ahash_request_free(conn->conn_tx_hash);
 	if (conn->conn_rx_hash) {
 		struct crypto_ahash *tfm;


