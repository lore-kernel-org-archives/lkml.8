Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C7BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21000204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598976750;
	bh=G92AkfBE4688u2QAr02mcYBloUEsmi/UG84Jv7duEF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PrU7sZ0qqf43e2bJDN89z3HRcZ8pjm6KmUoWdmlst2T+j3qj6d70cZSH+neIGvzGJ
	 GlG9vjWKUFANgFjl9RE+/qA5pD4H5Z5jrd/juOqSAolrjZfYtWCO5Fw+23EeTB3XuQ
	 Ph51zocQKN4aPf0Lr0hCa8Lmg4RLyqn5Dsde/duo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbgIAQMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731311AbgIAPhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:37:02 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3565F20E65;
        Tue,  1 Sep 2020 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974621;
        bh=G92AkfBE4688u2QAr02mcYBloUEsmi/UG84Jv7duEF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eg6gTLmpMeBnkn+EVHSDeqNaLdP/8vBV/uxzsu0xaOF3znt4WSBHPboCbKJ1f8EjC
         lOrbFmAdJ4rI0IuOjg9hioE4hH3IraICh9N+r8QEjQZJWSJLChSbaXXKqhEmFWjP2Z
         iCGAw53u7ie3UAZ5o67Qyg+zzWHQDkZU0hJ/m8gs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 032/255] scsi: lpfc: Fix shost refcount mismatch when deleting vport
Date:   Tue,  1 Sep 2020 17:08:08 +0200
Message-Id: <20200901151002.307948076@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dick Kennedy <dick.kennedy@broadcom.com>

[ Upstream commit 03dbfe0668e6692917ac278883e0586cd7f7d753 ]

When vports are deleted, it is observed that there is memory/kthread
leakage as the vport isn't fully being released.

There is a shost reference taken in scsi_add_host_dma that is not released
during scsi_remove_host. It was noticed that other drivers resolve this by
doing a scsi_host_put after calling scsi_remove_host.

The vport_delete routine is taking two references one that corresponds to
an access to the scsi_host in the vport_delete routine and another that is
released after the adapter mailbox command completes that destroys the VPI
that corresponds to the vport.

Remove one of the references taken such that the second reference that is
put will complete the missing scsi_add_host_dma reference and the shost
will be terminated.

Link: https://lore.kernel.org/r/20200630215001.70793-8-jsmart2021@gmail.com
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_vport.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_vport.c b/drivers/scsi/lpfc/lpfc_vport.c
index b766463579800..d0296f7cf45fc 100644
--- a/drivers/scsi/lpfc/lpfc_vport.c
+++ b/drivers/scsi/lpfc/lpfc_vport.c
@@ -642,27 +642,16 @@ lpfc_vport_delete(struct fc_vport *fc_vport)
 		    vport->port_state < LPFC_VPORT_READY)
 			return -EAGAIN;
 	}
+
 	/*
-	 * This is a bit of a mess.  We want to ensure the shost doesn't get
-	 * torn down until we're done with the embedded lpfc_vport structure.
-	 *
-	 * Beyond holding a reference for this function, we also need a
-	 * reference for outstanding I/O requests we schedule during delete
-	 * processing.  But once we scsi_remove_host() we can no longer obtain
-	 * a reference through scsi_host_get().
-	 *
-	 * So we take two references here.  We release one reference at the
-	 * bottom of the function -- after delinking the vport.  And we
-	 * release the other at the completion of the unreg_vpi that get's
-	 * initiated after we've disposed of all other resources associated
-	 * with the port.
+	 * Take early refcount for outstanding I/O requests we schedule during
+	 * delete processing for unreg_vpi.  Always keep this before
+	 * scsi_remove_host() as we can no longer obtain a reference through
+	 * scsi_host_get() after scsi_host_remove as shost is set to SHOST_DEL.
 	 */
 	if (!scsi_host_get(shost))
 		return VPORT_INVAL;
-	if (!scsi_host_get(shost)) {
-		scsi_host_put(shost);
-		return VPORT_INVAL;
-	}
+
 	lpfc_free_sysfs_attr(vport);
 
 	lpfc_debugfs_terminate(vport);
@@ -809,8 +798,9 @@ skip_logo:
 		if (!(vport->vpi_state & LPFC_VPI_REGISTERED) ||
 				lpfc_mbx_unreg_vpi(vport))
 			scsi_host_put(shost);
-	} else
+	} else {
 		scsi_host_put(shost);
+	}
 
 	lpfc_free_vpi(phba, vport->vpi);
 	vport->work_port_events = 0;
-- 
2.25.1



