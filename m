Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BB8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CD924683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220347;
	bh=u8FEAMoac37zAG9ZH+8up4ADy+KrvFAr7q8E0WT9JOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K7M7GKNUPDKfpqrxsjI8tJ02dqhar6GkQF+KHsR99Y7FBAiWhJFzjfl1NxuP6qqVB
	 TEdi2m5SM2ZYkJKkw3w1gAxLy9UBPlb/tL3ZuIxwJwAnBOLfbYhndq58qUKyHuHmI4
	 /jQwKsRuk5LOU96I7FpW7TvROTXXI8OY0mbKwliE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgA1OFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:05:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbgA1OFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:05:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B294124688;
        Tue, 28 Jan 2020 14:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220340;
        bh=u8FEAMoac37zAG9ZH+8up4ADy+KrvFAr7q8E0WT9JOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VyiHY6du+n6LfUCr+Inx5LGaU5ZlyN9qzhng4nexT/1f3uGz1dzOXOpScLQFmyWjy
         QzPJUGvYkuq7FKB12NHL9JUNcB9K/jAeCtBdOuWvBjQaF4pVxP/6aDNx2j8uyJKk4C
         bbVVKCY4f026kz31vBw+xkfG9XG7BWMyzeYJJKoA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rahul Kundu <rahul.kundu@chelsio.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4 078/104] scsi: RDMA/isert: Fix a recently introduced regression related to logout
Date:   Tue, 28 Jan 2020 15:00:39 +0100
Message-Id: <20200128135827.989226960@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135817.238524998@linuxfoundation.org>
References: <20200128135817.238524998@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

commit 04060db41178c7c244f2c7dcd913e7fd331de915 upstream.

iscsit_close_connection() calls isert_wait_conn(). Due to commit
e9d3009cb936 both functions call target_wait_for_sess_cmds() although that
last function should be called only once. Fix this by removing the
target_wait_for_sess_cmds() call from isert_wait_conn() and by only calling
isert_wait_conn() after target_wait_for_sess_cmds().

Fixes: e9d3009cb936 ("scsi: target: iscsi: Wait for all commands to finish before freeing a session").
Link: https://lore.kernel.org/r/20200116044737.19507-1-bvanassche@acm.org
Reported-by: Rahul Kundu <rahul.kundu@chelsio.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Acked-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/isert/ib_isert.c |   12 ------------
 drivers/target/iscsi/iscsi_target.c     |    6 +++---
 2 files changed, 3 insertions(+), 15 deletions(-)

--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2575,17 +2575,6 @@ isert_wait4logout(struct isert_conn *ise
 	}
 }
 
-static void
-isert_wait4cmds(struct iscsi_conn *conn)
-{
-	isert_info("iscsi_conn %p\n", conn);
-
-	if (conn->sess) {
-		target_sess_cmd_list_set_waiting(conn->sess->se_sess);
-		target_wait_for_sess_cmds(conn->sess->se_sess);
-	}
-}
-
 /**
  * isert_put_unsol_pending_cmds() - Drop commands waiting for
  *     unsolicitate dataout
@@ -2633,7 +2622,6 @@ static void isert_wait_conn(struct iscsi
 
 	ib_drain_qp(isert_conn->qp);
 	isert_put_unsol_pending_cmds(conn);
-	isert_wait4cmds(conn);
 	isert_wait4logout(isert_conn);
 
 	queue_work(isert_release_wq, &isert_conn->release_work);
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4151,9 +4151,6 @@ int iscsit_close_connection(
 	iscsit_stop_nopin_response_timer(conn);
 	iscsit_stop_nopin_timer(conn);
 
-	if (conn->conn_transport->iscsit_wait_conn)
-		conn->conn_transport->iscsit_wait_conn(conn);
-
 	/*
 	 * During Connection recovery drop unacknowledged out of order
 	 * commands for this connection, and prepare the other commands
@@ -4239,6 +4236,9 @@ int iscsit_close_connection(
 	target_sess_cmd_list_set_waiting(sess->se_sess);
 	target_wait_for_sess_cmds(sess->se_sess);
 
+	if (conn->conn_transport->iscsit_wait_conn)
+		conn->conn_transport->iscsit_wait_conn(conn);
+
 	ahash_request_free(conn->conn_tx_hash);
 	if (conn->conn_rx_hash) {
 		struct crypto_ahash *tfm;


