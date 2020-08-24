Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBF9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D05B2177B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258270;
	bh=+g15zvWxMTTR9tUD6wqrpflJZ0HmGnEdloiRcOmDlDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rz1aH/V8bmq1KSFWXnSnLLFBPcHivsQeyGzOzqdTjpyoscIansTJFtfNZCpIlqOe9
	 tEkuDN1Erl2EQYivYyDLeq/XrTl3KMbjusK1Iriln8P64PIIB6mzplpuQQKns1k3Zt
	 QNWMtQ0Q6SSxrK3ZVn4TDcZpBhon9SpYqh0kUJ5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgHXIhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbgHXIhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:37:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A6BB207DF;
        Mon, 24 Aug 2020 08:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258262;
        bh=+g15zvWxMTTR9tUD6wqrpflJZ0HmGnEdloiRcOmDlDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bcMi3o1Aj35zSqidte7CuUGxuKUGTQKTeB80ujB6I1ryhbCso11Aimb9ObnYvHsqm
         077Id+dAA9Bm2kbMJMDF9e3pt0+iGdzP3Wp9SJmQqUB2CzrVs5ZgMm6ymZUrlM81RY
         N6X9XEHpb0Bxa9nrW7WpyDzuzdrUPIVO0ssQQWIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 117/148] Revert "scsi: qla2xxx: Disable T10-DIF feature with FC-NVMe during probe"
Date:   Mon, 24 Aug 2020 10:30:15 +0200
Message-Id: <20200824082419.616434286@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
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
index e92fad99338cd..5c7c22d0fab4b 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -2829,10 +2829,6 @@ qla2x00_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
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



