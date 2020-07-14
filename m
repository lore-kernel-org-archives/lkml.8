Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12476C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D63A522B4E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752886;
	bh=d57Z06bRJknnqjS3Wp/YqNK1f++WDqjwuAwuq9k2yN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yuANxF0lSWXriABCQZriFmLURZFVZ7EvzRrXhgul2s6yMwWkYTbCV7YLQZrsJ/fdC
	 C0YvatVN3qAb6kuMyoAFXqLw9gvHOemOU32b2NN3nCFA843Yxinp1q+QbGZWbGrxlG
	 zsCBjXrPNn3cQuT6CRamRWKOyKaYfyDsN4np0c1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbgGNSyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:54:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729677AbgGNSyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:54:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C9D322BEB;
        Tue, 14 Jul 2020 18:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752880;
        bh=d57Z06bRJknnqjS3Wp/YqNK1f++WDqjwuAwuq9k2yN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FFOWfZQn3taVf5InDwR4+Z/XIR3VzJZCFPygPX0+bDC9tVHECGe2oVWt3Z2yrgseP
         wyz/5xWLcYs46St2o2N5PvUJUrfvM2jM+lx1fj7tUXLfcFHA4fAJUqrj/MuyLlcxtg
         7Ur7k8Jv3hYIAy4CC4k+8uPK4So3URvLYvfE59RU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanislav Saner <ssaner@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 036/166] scsi: mptscsih: Fix read sense data size
Date:   Tue, 14 Jul 2020 20:43:21 +0200
Message-Id: <20200714184117.609250151@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
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
index f0737c57ed5fc..1491561d2e5c9 100644
--- a/drivers/message/fusion/mptscsih.c
+++ b/drivers/message/fusion/mptscsih.c
@@ -118,8 +118,6 @@ int 		mptscsih_suspend(struct pci_dev *pdev, pm_message_t state);
 int 		mptscsih_resume(struct pci_dev *pdev);
 #endif
 
-#define SNS_LEN(scp)	SCSI_SENSE_BUFFERSIZE
-
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
 /*
@@ -2422,7 +2420,7 @@ mptscsih_copy_sense_data(struct scsi_cmnd *sc, MPT_SCSI_HOST *hd, MPT_FRAME_HDR
 		/* Copy the sense received into the scsi command block. */
 		req_index = le16_to_cpu(mf->u.frame.hwhdr.msgctxu.fld.req_idx);
 		sense_data = ((u8 *)ioc->sense_buf_pool + (req_index * MPT_SENSE_BUFFER_ALLOC));
-		memcpy(sc->sense_buffer, sense_data, SNS_LEN(sc));
+		memcpy(sc->sense_buffer, sense_data, MPT_SENSE_BUFFER_ALLOC);
 
 		/* Log SMART data (asc = 0x5D, non-IM case only) if required.
 		 */
-- 
2.25.1



