Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39CFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9390204EA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598288192;
	bh=ERlbd4mm2RJBMGROf6XW4FY+adAnJSPEYzkBuVOvmWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2YaaM4n+3J9pJTI+BXklxOUQoWnQJ47cVisLLfpCIQUCPPXVzHfVfyS4BIPEd9QSA
	 DfASULZFaTAaI0Kc5hJTc4dtN0mvwBcuGjRxfi2Af4w2ySl+583y2SGIgLQ7fEpiRk
	 p1aOhkhfRV96Ris47nyc6kQTC2r6WFDYLjm12Bew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHXQ41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728549AbgHXQjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:39:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF8EF22C9F;
        Mon, 24 Aug 2020 16:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287147;
        bh=ERlbd4mm2RJBMGROf6XW4FY+adAnJSPEYzkBuVOvmWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PaI/lWWx+EYlLT61QNvDJKUWaf7c/MtCzTqw5i8Frbmt0+bWqC8Lm5COAEuEwQKJi
         YLOxxODWCJwPi++Rs7Lt564DpGoqhvNClYqp1PwGh5PNdJfJKl6zs7Cgczk8jh+R76
         1QuUA2Q/HcPfyyMC5EWEN5hysPPVcRJtMtT5qGNM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Saurav Kashyap <skashyap@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 16/21] scsi: qla2xxx: Check if FW supports MQ before enabling
Date:   Mon, 24 Aug 2020 12:38:40 -0400
Message-Id: <20200824163845.606933-16-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163845.606933-1-sashal@kernel.org>
References: <20200824163845.606933-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saurav Kashyap <skashyap@marvell.com>

[ Upstream commit dffa11453313a115157b19021cc2e27ea98e624c ]

OS boot during Boot from SAN was stuck at dracut emergency shell after
enabling NVMe driver parameter. For non-MQ support the driver was enabling
MQ. Add a check to confirm if FW supports MQ.

Link: https://lore.kernel.org/r/20200806111014.28434-9-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index b56cf790587e5..e17ca7df8d0e4 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1997,6 +1997,11 @@ qla2x00_iospace_config(struct qla_hw_data *ha)
 	/* Determine queue resources */
 	ha->max_req_queues = ha->max_rsp_queues = 1;
 	ha->msix_count = QLA_BASE_VECTORS;
+
+	/* Check if FW supports MQ or not */
+	if (!(ha->fw_attributes & BIT_6))
+		goto mqiobase_exit;
+
 	if (!ql2xmqsupport || !ql2xnvmeenable ||
 	    (!IS_QLA25XX(ha) && !IS_QLA81XX(ha)))
 		goto mqiobase_exit;
-- 
2.25.1

