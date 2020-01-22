Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4EAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF8620678
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699656;
	bh=DMzQfcS5xAtCDGC66DRYfaphZBjQGtafikwUVfigmRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UAPSd9c1iIdaSsJTar3wpcZYEb50/1K3eFaio1arEzMIz6LXoKhmaztZKU1xU/geD
	 l3ZJn2DjPbgFAr5wUBEb43zPl6NH/Q4logyQwDtKrkkNiTMbZGxhYf0Pm2c7Q9QA6Y
	 G8u1w7YGtHsBx9d9yFrhW4PPM+ZG0HrVML5WJkl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgAVN1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:27:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731505AbgAVN1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:27:32 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD24120678;
        Wed, 22 Jan 2020 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699652;
        bh=DMzQfcS5xAtCDGC66DRYfaphZBjQGtafikwUVfigmRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Njo4gzoneIQnjNWwUU1UBPjzir5xamqG6TwZd+Z7N8e9T4zSy2QZTw7E8vvnZeqhm
         ZVoJ3RddLmqi8usOl9mEaQKjCuYJlrPecWELDqRsJSzGfQEMMNWHPivQMGBY8N8Pk7
         cZkNDBVeY8ShzwTMuNShjRZ3lbG3e7fXAB4p/nPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michael Hernandez <michael.hernandez@cavium.com>,
        Huacai Chen <chenhc@lemote.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4 208/222] scsi: qla2xxx: Fix qla2x00_request_irqs() for MSI
Date:   Wed, 22 Jan 2020 10:29:54 +0100
Message-Id: <20200122092848.590628821@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhc@lemote.com>

commit 45dc8f2d9c94ed74a5e31e63e9136a19a7e16081 upstream.

Commit 4fa183455988 ("scsi: qla2xxx: Utilize pci_alloc_irq_vectors/
pci_free_irq_vectors calls.") use pci_alloc_irq_vectors() to replace
pci_enable_msi() but it didn't handle the return value correctly. This bug
make qla2x00 always fail to setup MSI if MSI-X fail, so fix it.

BTW, improve the log message of return value in qla2x00_request_irqs() to
avoid confusion.

Fixes: 4fa183455988 ("scsi: qla2xxx: Utilize pci_alloc_irq_vectors/pci_free_irq_vectors calls.")
Cc: Michael Hernandez <michael.hernandez@cavium.com>
Link: https://lore.kernel.org/r/1574314847-14280-1-git-send-email-chenhc@lemote.com
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Acked-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_isr.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -3625,7 +3625,7 @@ qla2x00_request_irqs(struct qla_hw_data
 skip_msix:
 
 	ql_log(ql_log_info, vha, 0x0037,
-	    "Falling back-to MSI mode -%d.\n", ret);
+	    "Falling back-to MSI mode -- ret=%d.\n", ret);
 
 	if (!IS_QLA24XX(ha) && !IS_QLA2532(ha) && !IS_QLA8432(ha) &&
 	    !IS_QLA8001(ha) && !IS_P3P_TYPE(ha) && !IS_QLAFX00(ha) &&
@@ -3633,13 +3633,13 @@ skip_msix:
 		goto skip_msi;
 
 	ret = pci_alloc_irq_vectors(ha->pdev, 1, 1, PCI_IRQ_MSI);
-	if (!ret) {
+	if (ret > 0) {
 		ql_dbg(ql_dbg_init, vha, 0x0038,
 		    "MSI: Enabled.\n");
 		ha->flags.msi_enabled = 1;
 	} else
 		ql_log(ql_log_warn, vha, 0x0039,
-		    "Falling back-to INTa mode -- %d.\n", ret);
+		    "Falling back-to INTa mode -- ret=%d.\n", ret);
 skip_msi:
 
 	/* Skip INTx on ISP82xx. */


