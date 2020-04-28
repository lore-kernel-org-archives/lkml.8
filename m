Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B61C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB3D20575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588100316;
	bh=ywCuuZVchHuljK5/XJ7hU6cICroLR7jkduQE/GKG5GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oqQHyp0PNkI0SB0MWYe0QSEPCzltA0Rd93do/hTpZh7N6Bh6F67QcLgaInVHQnhs+
	 xFXLGj7QTc4iVUg4w6VEpWo/OVwCZKv8tbHyku66yMv6xl+qnStuceO4hDahFI1NAh
	 23SnJrbKMgNWA5znkSvhp2vraixqVa+VI2Go4vnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgD1S6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbgD1S3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:29:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 053AC20BED;
        Tue, 28 Apr 2020 18:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098553;
        bh=ywCuuZVchHuljK5/XJ7hU6cICroLR7jkduQE/GKG5GM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKklbHEJvSgWe21/XWzThaveYZQozxk5f/D+5IHlzF+ryR2yCnJ7wx8w41+o/pvCy
         OVOX/+FNqZrIPsVb90ofwN9IEF3QXywhYTta6Hqfbu+qZC24t1DqFRMLXR6oeWQlvh
         qYxbC6qhZfiMBO1v08HCxKaONV8w0HmbWkAIOtsI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 013/131] scsi: lpfc: Fix crash in target side cable pulls hitting WAIT_FOR_UNREG
Date:   Tue, 28 Apr 2020 20:23:45 +0200
Message-Id: <20200428182226.838996617@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 807e7353d8a7105ce884d22b0dbc034993c6679c ]

Kernel is crashing with the following stacktrace:

  BUG: unable to handle kernel NULL pointer dereference at
    00000000000005bc
  IP: lpfc_nvme_register_port+0x1a8/0x3a0 [lpfc]
  ...
  Call Trace:
  lpfc_nlp_state_cleanup+0x2b2/0x500 [lpfc]
  lpfc_nlp_set_state+0xd7/0x1a0 [lpfc]
  lpfc_cmpl_prli_prli_issue+0x1f7/0x450 [lpfc]
  lpfc_disc_state_machine+0x7a/0x1e0 [lpfc]
  lpfc_cmpl_els_prli+0x16f/0x1e0 [lpfc]
  lpfc_sli_sp_handle_rspiocb+0x5b2/0x690 [lpfc]
  lpfc_sli_handle_slow_ring_event_s4+0x182/0x230 [lpfc]
  lpfc_do_work+0x87f/0x1570 [lpfc]
  kthread+0x10d/0x130
  ret_from_fork+0x35/0x40

During target side fault injections, it is possible to hit the
NLP_WAIT_FOR_UNREG case in lpfc_nvme_remoteport_delete. A prior commit
fixed a rebind and delete race condition, but called lpfc_nlp_put
unconditionally. This triggered a deletion and the crash.

Fix by movng nlp_put to inside the NLP_WAIT_FOR_UNREG case, where the nlp
will be being unregistered/removed. Leave the reference if the flag isn't
set.

Link: https://lore.kernel.org/r/20200322181304.37655-8-jsmart2021@gmail.com
Fixes: b15bd3e6212e ("scsi: lpfc: Fix nvme remoteport registration race conditions")
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index f73726e55e44d..e3013858937b7 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -342,13 +342,15 @@ lpfc_nvme_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 	if (ndlp->upcall_flags & NLP_WAIT_FOR_UNREG) {
 		ndlp->nrport = NULL;
 		ndlp->upcall_flags &= ~NLP_WAIT_FOR_UNREG;
-	}
-	spin_unlock_irq(&vport->phba->hbalock);
+		spin_unlock_irq(&vport->phba->hbalock);
 
-	/* Remove original register reference. The host transport
-	 * won't reference this rport/remoteport any further.
-	 */
-	lpfc_nlp_put(ndlp);
+		/* Remove original register reference. The host transport
+		 * won't reference this rport/remoteport any further.
+		 */
+		lpfc_nlp_put(ndlp);
+	} else {
+		spin_unlock_irq(&vport->phba->hbalock);
+	}
 
  rport_err:
 	return;
-- 
2.20.1



