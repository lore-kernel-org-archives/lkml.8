Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3C8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EBA22071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598261820;
	bh=5NLj5sKI134qWWyTgQ08KsIfccN+WZfBmPvo8KiYckE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=azAeDXJ0655iuqYYELdPttaMyAco2qlcIvNwmXpSB+tS0QxarErvEdQk3DXSAtB/e
	 SNOAt3j+vwl+nOUuRm86vYJnM2CH5gIHMi4V/U74jZWIbFNI+wIVZCyBjSjp0pCur6
	 lDs3Ke1VBqRd54M+U3+/BkPJrSzK2rqdmnhwqPmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgHXJg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:36:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729344AbgHXIsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:48:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 493A2206F0;
        Mon, 24 Aug 2020 08:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258909;
        bh=5NLj5sKI134qWWyTgQ08KsIfccN+WZfBmPvo8KiYckE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXf23BGsSzEmUbj6mQ/I2zSAmtaai1q33VCHgeedPhylHMimf1drzdgF8M8Sh7naS
         QDMzslA34pZNsMjtP8Lk8w7MRK2b6MfdkYnKVJxdL8vOWoCtG/BfjZqQFpB/bX8ir7
         jdjKOAFcu5b8+bGADf9KY4mIYAZMr/Dnb+SdZidk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 089/107] Revert "scsi: qla2xxx: Disable T10-DIF feature with FC-NVMe during probe"
Date:   Mon, 24 Aug 2020 10:30:55 +0200
Message-Id: <20200824082409.516205901@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082405.020301642@linuxfoundation.org>
References: <20200824082405.020301642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

[ Upstream commit dca93232b361d260413933903cd4bdbd92ebcc7f ]

FCP T10-PI and NVMe features are independent of each other. This patch
allows both features to co-exist.

This reverts commit 5da05a26b8305a625bc9d537671b981795b46dab.

Link: https://lore.kernel.org/r/20200806111014.28434-12-njavali@marvell.com
Fixes: 5da05a26b830 ("scsi: qla2xxx: Disable T10-DIF feature with FC-NVMe during probe")
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index d7ec4083a0911..d91c95d9981ac 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -2804,10 +2804,6 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	/* This may fail but that's ok */
 	pci_enable_pcie_error_reporting(pdev);
 
-	/* Turn off T10-DIF when FC-NVMe is enabled */
-	if (ql2xnvmeenable)
-		ql2xenabledif = 0;
-
 	ha = kzalloc(sizeof(struct qla_hw_data), GFP_KERNEL);
 	if (!ha) {
 		ql_log_pci(ql_log_fatal, pdev, 0x0009,
-- 
2.25.1



