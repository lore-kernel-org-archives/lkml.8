Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26933C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8341206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598288563;
	bh=z7WM8kvm7Ky2+fBfqb0kIuuS0/swvnvpl4HnDc7EUXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yeVMzoDHNVAxlR4QUE7dzBZLxNJNXZ5OukQ+LmFstibTajo2q86LEpmd5Aydw7Lvp
	 2ZsuA1BslTvI3LQ8R0K8dlOA9Bd7JIKN0cSdxvX//y7RVoDnZgH9vGVgqc+tmiLq7U
	 E73dwGZ4vz+8LQorFMHa/8a3FcPKexvBhFb0W9Gg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHXRCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728487AbgHXQik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:38:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7387922D37;
        Mon, 24 Aug 2020 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287108;
        bh=z7WM8kvm7Ky2+fBfqb0kIuuS0/swvnvpl4HnDc7EUXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OPfWwTDDpaCCRMaUF0H+EbdjTaqqN8W/RN3DoqmrU9VoXY/k/ecHL4MjN7iOUEWB1
         LLzfGzxPtaFefITS0a1pv1skIQP1fiOe7LZL01oz+RzvK1UDcJgXIlDxR8luuiIQqC
         C30XR8v/LsB1BkZKiATUyTmqG79JnWB/ZKcHBRjw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 27/38] scsi: ufs: Clean up completed request without interrupt notification
Date:   Mon, 24 Aug 2020 12:37:39 -0400
Message-Id: <20200824163751.606577-27-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163751.606577-1-sashal@kernel.org>
References: <20200824163751.606577-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanley Chu <stanley.chu@mediatek.com>

[ Upstream commit b10178ee7fa88b68a9e8adc06534d2605cb0ec23 ]

If somehow no interrupt notification is raised for a completed request and
its doorbell bit is cleared by host, UFS driver needs to cleanup its
outstanding bit in ufshcd_abort(). Otherwise, system may behave abnormally
in the following scenario:

After ufshcd_abort() returns, this request will be requeued by SCSI layer
with its outstanding bit set. Any future completed request will trigger
ufshcd_transfer_req_compl() to handle all "completed outstanding bits". At
this time the "abnormal outstanding bit" will be detected and the "requeued
request" will be chosen to execute request post-processing flow. This is
wrong because this request is still "alive".

Link: https://lore.kernel.org/r/20200811141859.27399-2-huobean@gmail.com
Reviewed-by: Can Guo <cang@codeaurora.org>
Acked-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 99c1b0138c573..df38e069c9a8b 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6138,7 +6138,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 			/* command completed already */
 			dev_err(hba->dev, "%s: cmd at tag %d successfully cleared from DB.\n",
 				__func__, tag);
-			goto out;
+			goto cleanup;
 		} else {
 			dev_err(hba->dev,
 				"%s: no response from device. tag = %d, err %d\n",
@@ -6172,6 +6172,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 		goto out;
 	}
 
+cleanup:
 	scsi_dma_unmap(cmd);
 
 	spin_lock_irqsave(host->host_lock, flags);
-- 
2.25.1

