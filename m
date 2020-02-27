Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9273C3F363
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8499C2469B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811723;
	bh=d2Y3vdBjdlgymI0gTztZkgEs4JJBDw6qwf8ODVNVIYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G89wUWsUg46Zt1qsO0ODH517ZqDJkJT168bs4vhdnpOUTf3znz0s/kURlWkt9KFas
	 nPRwGzJL3QfrTbCJjsyK52G4AWVIeow/R2uq5IOqgBK5fZzthO39gw9edIFfbAlXBB
	 +i2/UzuKUPLxOiRBvsnlbG2L1p5aZ11/ScxHHqbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbgB0NzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:55:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731961AbgB0NzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:55:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97EA12469D;
        Thu, 27 Feb 2020 13:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811717;
        bh=d2Y3vdBjdlgymI0gTztZkgEs4JJBDw6qwf8ODVNVIYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hdlrAuJ37Go4dbciQcX0ru2S0y80vJ4Exnvrd18+Wpnr6jZ9hS7SSzgIb6aiB4FTx
         vKtlMSTqIgHbvH6918d/Yd9QD09Mv9AseVYMbLNHLM1D/alfqqb5kKIgIJA8w0uDN3
         yZJUkhhMN6RNjsrvBu1MiVZVuSpLYd+uM39l6O2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Allen Pais <allen.pais@oracle.com>,
        Martin Wilck <mwilck@suse.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH 4.14 035/237] scsi: qla2xxx: fix a potential NULL pointer dereference
Date:   Thu, 27 Feb 2020 14:34:09 +0100
Message-Id: <20200227132259.293580864@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen Pais <allen.pais@oracle.com>

commit 35a79a63517981a8aea395497c548776347deda8 upstream.

alloc_workqueue is not checked for errors and as a result a potential
NULL dereference could occur.

Link: https://lore.kernel.org/r/1568824618-4366-1-git-send-email-allen.pais@oracle.com
Signed-off-by: Allen Pais <allen.pais@oracle.com>
Reviewed-by: Martin Wilck <mwilck@suse.com>
Acked-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[Ajay: Modified to apply on v4.14.y]
Signed-off-by: Ajay Kaher <akaher@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_os.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3178,6 +3178,10 @@ qla2x00_probe_one(struct pci_dev *pdev,
 	    base_vha->mgmt_svr_loop_id, host->sg_tablesize);
 
 	ha->wq = alloc_workqueue("qla2xxx_wq", WQ_MEM_RECLAIM, 0);
+	if (unlikely(!ha->wq)) {
+		ret = -ENOMEM;
+		goto probe_failed;
+	}
 
 	if (ha->mqenable) {
 		bool mq = false;


