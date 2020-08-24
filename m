Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3FBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C302071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262188;
	bh=xhoqt3a3IIwjHjCqzbMOMlxPAxRbKdagGZxvB0lpQWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DgcB6dDb7msmlyduOx1zTNo47Y519ra+SvxwRNNMDVvOY2qvVYfDKIPdfmF9gE3J+
	 h8b2ELBOvFDTODkonYQ+YbOHEThjovbBixRSehENn5kjJrb9k518haVdw5RouS+fi/
	 UYLQrQI7LKdEKfyGZ7WxRbCNjZ+WzuS2TtHWAbIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgHXJnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbgHXIoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:44:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FF272074D;
        Mon, 24 Aug 2020 08:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258664;
        bh=xhoqt3a3IIwjHjCqzbMOMlxPAxRbKdagGZxvB0lpQWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2QtJYetFwaJTKFEDuuPGdYscxs2qedRdT9AhneBsfIJuyBhTtkn5qIztQVbHilM9
         +oupTxbqHTujv+371TmpWs0KLqUneeKO1rmYW3cgg3jN7Tpp38B/OM7fHfI7JgD98Y
         fJtOn33xeoRTey/q9Z6Sak5wr35JHqiSUQ0ESamo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 100/124] Revert "scsi: qla2xxx: Disable T10-DIF feature with FC-NVMe during probe"
Date:   Mon, 24 Aug 2020 10:30:34 +0200
Message-Id: <20200824082414.339401077@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082409.368269240@linuxfoundation.org>
References: <20200824082409.368269240@linuxfoundation.org>
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
index 1120d133204c2..20e3048276a01 100644
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



