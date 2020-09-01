Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F049C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 01:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E34C2073A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 01:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="lsPSl98J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgIABUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 21:20:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30413 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgIABUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 21:20:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598923240; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=YVrekhRja53pvOBvjZUkfskwtrhryfC5K7ba/YDLhuo=; b=lsPSl98JrefubjznTdUHuuPXeHneYoJbyYuPyWa85XSGz5HKM3qZI0cIXg2yMyREG8DA6mxQ
 fzVqL9FfCsY96whQg4o3xfsco6NU9gwXYUjbngTs1rJM80ErkbZHWEzqo2USW1+0z5N/L2zY
 t98+KtEHiK47i/XDwLbwPXRdxUU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f4da1de238e1efa379c7321 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Sep 2020 01:20:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1DE17C43391; Tue,  1 Sep 2020 01:20:30 +0000 (UTC)
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: nguyenb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DAD77C433C6;
        Tue,  1 Sep 2020 01:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DAD77C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=nguyenb@codeaurora.org
From:   "Bao D. Nguyen" <nguyenb@codeaurora.org>
To:     cang@codeaurora.org, asutoshd@codeaurora.org,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     "Bao D. Nguyen" <nguyenb@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 1/1] scsi: ufshcd: Properly set the device Icc Level
Date:   Mon, 31 Aug 2020 18:19:57 -0700
Message-Id: <5c9d6f76303bbe5188bf839b2ea5e5bf530e7281.1598923023.git.nguyenb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFS version 3.0 and later devices require Vcc and Vccq power supplies
with Vccq2 being optional. While earlier UFS version 2.0 and 2.1
devices, the Vcc and Vccq2 are required with Vccq being optional.
Check the required power supplies used by the device
and set the device's supported Icc level properly.

Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 06e2439..fdd1d3e 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6845,8 +6845,9 @@ static u32 ufshcd_find_max_sup_active_icc_level(struct ufs_hba *hba,
 {
 	u32 icc_level = 0;
 
-	if (!hba->vreg_info.vcc || !hba->vreg_info.vccq ||
-						!hba->vreg_info.vccq2) {
+	if (!hba->vreg_info.vcc ||
+		(!hba->vreg_info.vccq && hba->dev_info.wspecversion >= 0x300) ||
+		(!hba->vreg_info.vccq2 && hba->dev_info.wspecversion < 0x300)) {
 		dev_err(hba->dev,
 			"%s: Regulator capability was not set, actvIccLevel=%d",
 							__func__, icc_level);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

