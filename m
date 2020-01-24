Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153CFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E4C20718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865463;
	bh=KJGNqo10mAJdeZR1iC0ThmXuqdofLYgqTNzk8qDPVd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ehIsO78qdcc3vbfuZtq6H/TRWM8C7fYxaMNYuz1/48IDD2Dg5VolU78OXRggDG8+j
	 F1W/3f4DwyW0D5ohdwjjr0jsx8VOF4UhOra3CUQjg5madqWZhwR7HfMU4gF1J7n/J7
	 GTvCD8LtspihZXITcIKX1RGBqb6OgiwrS1xtyV54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404349AbgAXLbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:31:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388654AbgAXLbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:31:01 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AD0C206D4;
        Fri, 24 Jan 2020 11:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865461;
        bh=KJGNqo10mAJdeZR1iC0ThmXuqdofLYgqTNzk8qDPVd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZXR0qoHWneShe2yKc5OyGUY9xNYyGWFQLIBLVYYkyurnst4YU956nDsSVCsXAozvx
         Ct1s14IvwZoJf15wrfb2sx1Eu3x+crzLqAzdL4Z3sLP5prM0vfGFOOz0EUMhsJKIS6
         A33siby544OOYuBbgd5irlMaPfPAYBy6MZ1zL08Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Govindarajulu Varadarajan <gvaradar@cisco.com>,
        Satish Kharat <satishkh@cisco.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 552/639] scsi: fnic: fix msix interrupt allocation
Date:   Fri, 24 Jan 2020 10:32:02 +0100
Message-Id: <20200124093158.340295429@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Govindarajulu Varadarajan <gvaradar@cisco.com>

[ Upstream commit 3ec24fb4c035e9cbb2f02a48640a09aa913442a2 ]

pci_alloc_irq_vectors() returns number of vectors allocated.  Fix the check
for error condition.

Fixes: cca678dfbad49 ("scsi: fnic: switch to pci_alloc_irq_vectors")
Link: https://lore.kernel.org/r/20190827211340.1095-1-gvaradar@cisco.com
Signed-off-by: Govindarajulu Varadarajan <gvaradar@cisco.com>
Acked-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/fnic/fnic_isr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_isr.c b/drivers/scsi/fnic/fnic_isr.c
index 4e3a50202e8c5..d28088218c364 100644
--- a/drivers/scsi/fnic/fnic_isr.c
+++ b/drivers/scsi/fnic/fnic_isr.c
@@ -254,7 +254,7 @@ int fnic_set_intr_mode(struct fnic *fnic)
 		int vecs = n + m + o + 1;
 
 		if (pci_alloc_irq_vectors(fnic->pdev, vecs, vecs,
-				PCI_IRQ_MSIX) < 0) {
+				PCI_IRQ_MSIX) == vecs) {
 			fnic->rq_count = n;
 			fnic->raw_wq_count = m;
 			fnic->wq_copy_count = o;
@@ -280,7 +280,7 @@ int fnic_set_intr_mode(struct fnic *fnic)
 	    fnic->wq_copy_count >= 1 &&
 	    fnic->cq_count >= 3 &&
 	    fnic->intr_count >= 1 &&
-	    pci_alloc_irq_vectors(fnic->pdev, 1, 1, PCI_IRQ_MSI) < 0) {
+	    pci_alloc_irq_vectors(fnic->pdev, 1, 1, PCI_IRQ_MSI) == 1) {
 		fnic->rq_count = 1;
 		fnic->raw_wq_count = 1;
 		fnic->wq_copy_count = 1;
-- 
2.20.1



