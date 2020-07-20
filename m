Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C73AC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F2DB2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259849;
	bh=b9mQDorhFC7sS98onQzu+8sJwNkkUMXw0ygqhBTzCHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eH1glqOVXivpqDxMvEBPNY+TT2Qnetm7WMMxUTe1z5gmjMXjhFie+VXOE2EMksgme
	 diS6cU91Eg7SeQjvE39tDfF5/FjIcR5q6MiAIFhqj4hgyAN8MnfcNeeFflmtDsc2Iu
	 Bm3nrJn4m52IPppFWW5GF/CVXEyIEaE4oEOi3ixg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgGTPoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729393AbgGTPoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:44:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35D3322CAF;
        Mon, 20 Jul 2020 15:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259844;
        bh=b9mQDorhFC7sS98onQzu+8sJwNkkUMXw0ygqhBTzCHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nCm9cfyQNCPDlr/qjGCuN6ChMri8trQyBb0iEpebU9d7kz3DEke06afjrBl6wlWSD
         aOrzxfSWlRaZCuWJ4dcbTL1qIFLo7NvJSB0NrpSIvoQ5H1ooHL6eSCEdA6REhJ9+qz
         eO8eBvJAWLEGc9Sn9/id7jizN96LGJqimwPwk1xA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanislav Saner <ssaner@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 014/125] scsi: mptscsih: Fix read sense data size
Date:   Mon, 20 Jul 2020 17:35:53 +0200
Message-Id: <20200720152803.665771520@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Henzl <thenzl@redhat.com>

[ Upstream commit afe89f115e84edbc76d316759e206580a06c6973 ]

The sense data buffer in sense_buf_pool is allocated with size of
MPT_SENSE_BUFFER_ALLOC(64) (multiplied by req_depth) while SNS_LEN(sc)(96)
is used when reading the data.  That may lead to a read from unallocated
area, sometimes from another (unallocated) page.  To fix this, limit the
read size to MPT_SENSE_BUFFER_ALLOC.

Link: https://lore.kernel.org/r/20200616150446.4840-1-thenzl@redhat.com
Co-developed-by: Stanislav Saner <ssaner@redhat.com>
Signed-off-by: Stanislav Saner <ssaner@redhat.com>
Signed-off-by: Tomas Henzl <thenzl@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/message/fusion/mptscsih.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/message/fusion/mptscsih.c b/drivers/message/fusion/mptscsih.c
index 6ba07c7feb92b..2af7ae13449d3 100644
--- a/drivers/message/fusion/mptscsih.c
+++ b/drivers/message/fusion/mptscsih.c
@@ -118,8 +118,6 @@ int 		mptscsih_suspend(struct pci_dev *pdev, pm_message_t state);
 int 		mptscsih_resume(struct pci_dev *pdev);
 #endif
 
-#define SNS_LEN(scp)	SCSI_SENSE_BUFFERSIZE
-
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /*
@@ -2420,7 +2418,7 @@ mptscsih_copy_sense_data(struct scsi_cmnd *sc, MPT_SCSI_HOST *hd, MPT_FRAME_HDR
 		/* Copy the sense received into the scsi command block. */
 		req_index = le16_to_cpu(mf->u.frame.hwhdr.msgctxu.fld.req_idx);
 		sense_data = ((u8 *)ioc->sense_buf_pool + (req_index * MPT_SENSE_BUFFER_ALLOC));
-		memcpy(sc->sense_buffer, sense_data, SNS_LEN(sc));
+		memcpy(sc->sense_buffer, sense_data, MPT_SENSE_BUFFER_ALLOC);
 
 		/* Log SMART data (asc = 0x5D, non-IM case only) if required.
 		 */
-- 
2.25.1



