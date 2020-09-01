Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5A5C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC9E0206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598977315;
	bh=qkdyS7d8IfKRt0vPSqX3ghon+iMsNJgrh+HCthJqC/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u0FLhOBuY8aDa3ExjnA5kbnYCo2WqjtD+YUIhxnykdiiTugt/hn5jG4Va0+aH98af
	 PFf5MeatN76khZ/avzXk5ChaEKqQag0xM+/rfhML4uFx/LxLlcLfadrY6SeO/YKft0
	 R+9VMafK5J+gEElS2XWwwSaU4gPp16D+LvY3C8F0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731068AbgIAQVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:21:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731036AbgIAPcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:32:25 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 761E820866;
        Tue,  1 Sep 2020 15:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974344;
        bh=qkdyS7d8IfKRt0vPSqX3ghon+iMsNJgrh+HCthJqC/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C846/EAS1cEljPJiRHJZL16GLIlUZ3aDKCdrb13uth3tF51trHihonhn20Uy3+jfy
         /3t78pvTi5aMIpV4vPtDOAlOOTuJimgGh4DL4cVJS2rSF5VEJ84OKtAIZaITYm8fMM
         E0Q9JSHGTE7Q+PxVLhT3WyYrxZu+rTRE9Y1EAhCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 140/214] scsi: qla2xxx: Fix login timeout
Date:   Tue,  1 Sep 2020 17:10:20 +0200
Message-Id: <20200901150959.688792078@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

[ Upstream commit abb31aeaa9b20680b0620b23fea5475ea4591e31 ]

Multipath errors were seen during failback due to login timeout.  The
remote device sent LOGO, the local host tore down the session and did
relogin. The RSCN arrived indicates remote device is going through failover
after which the relogin is in a 20s timeout phase.  At this point the
driver is stuck in the relogin process.  Add a fix to delete the session as
part of abort/flush the login.

Link: https://lore.kernel.org/r/20200806111014.28434-5-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_gs.c     | 18 +++++++++++++++---
 drivers/scsi/qla2xxx/qla_target.c |  2 +-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index a44de4c5dcf6c..fc6e12fb7d77b 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3673,10 +3673,22 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 		}
 
 		if (fcport->scan_state != QLA_FCPORT_FOUND) {
+			bool do_delete = false;
+
+			if (fcport->scan_needed &&
+			    fcport->disc_state == DSC_LOGIN_PEND) {
+				/* Cable got disconnected after we sent
+				 * a login. Do delete to prevent timeout.
+				 */
+				fcport->logout_on_delete = 1;
+				do_delete = true;
+			}
+
 			fcport->scan_needed = 0;
-			if ((qla_dual_mode_enabled(vha) ||
-				qla_ini_mode_enabled(vha)) &&
-			    atomic_read(&fcport->state) == FCS_ONLINE) {
+			if (((qla_dual_mode_enabled(vha) ||
+			      qla_ini_mode_enabled(vha)) &&
+			    atomic_read(&fcport->state) == FCS_ONLINE) ||
+				do_delete) {
 				if (fcport->loop_id != FC_NO_LOOP_ID) {
 					if (fcport->flags & FCF_FCP2_DEVICE)
 						fcport->logout_on_delete = 0;
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index cb8a892e2d393..b75e6e4d58c06 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -1262,7 +1262,7 @@ void qlt_schedule_sess_for_deletion(struct fc_port *sess)
 
 	qla24xx_chk_fcp_state(sess);
 
-	ql_dbg(ql_dbg_tgt, sess->vha, 0xe001,
+	ql_dbg(ql_dbg_disc, sess->vha, 0xe001,
 	    "Scheduling sess %p for deletion %8phC\n",
 	    sess, sess->port_name);
 
-- 
2.25.1



