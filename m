Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D3EC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05D6E206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598976259;
	bh=JYRY77aIiFv/2pas7yiKC2FaObN7TX7oCY2P07drzSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HafOstStz5cpBnbOEzW+5vi4kF2a6L3xD1FcIGJT5h6nP9Fm7AP1451Sbyv1Tp1zg
	 XjPKiX8mg0plKiKqs9nykd4IzSbpnNKJ4S2qhZ2QQ/6NCMlKDCdMuZDwowfGErE90W
	 CW91egVlY9tU4AOlzX6ET+4vLLsuLWchlffFQmHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgIAQES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:04:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728417AbgIAPmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:42:19 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCF32207D3;
        Tue,  1 Sep 2020 15:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974938;
        bh=JYRY77aIiFv/2pas7yiKC2FaObN7TX7oCY2P07drzSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0XpcAMt3Qlf2xAIpc/JtCplA0/TH7qyq1m3kXghiS7007ZhqCm7bTGrfQiHqXJrnk
         9w6iRFvVhhOLjDrCZBWnFijPdaJ7l/Ib5vzT6HXc/z1Rg8+O6m3CsYktUAtP+B4Svs
         qWwsjAmD8Yhz7fc4CrL6ygSBAtfCZDpyl15dhEP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Can Guo <cang@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 146/255] scsi: ufs: Clean up completed request without interrupt notification
Date:   Tue,  1 Sep 2020 17:10:02 +0200
Message-Id: <20200901151007.697223090@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 6af79ff5185f6..8bc8e4e62c045 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6541,7 +6541,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 			/* command completed already */
 			dev_err(hba->dev, "%s: cmd at tag %d successfully cleared from DB.\n",
 				__func__, tag);
-			goto out;
+			goto cleanup;
 		} else {
 			dev_err(hba->dev,
 				"%s: no response from device. tag = %d, err %d\n",
@@ -6575,6 +6575,7 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
 		goto out;
 	}
 
+cleanup:
 	scsi_dma_unmap(cmd);
 
 	spin_lock_irqsave(host->host_lock, flags);
-- 
2.25.1



