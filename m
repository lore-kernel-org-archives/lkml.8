Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC33C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4902477D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697411;
	bh=qekGi7wU7YSQhUWkPVpoPPNnb+45FMbtrtnohbHSl10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LgFHaw3VdO2DtEhzPBEXl4j1c5UVfoySngyxr95fk3Yp02C/dFVjubgNJ9doH7t3E
	 ElvLS7kGYU8HZzd+JrbVMNfHzQfOR18D5rzyTme7eY+NvCol0Sc1DlYUQ8zytN9GXK
	 hHhpTJmH7vH23X4XJSmpjnzUWZech0HtMG/j08yU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405654AbgBNQX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:23:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393123AbgBNQVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:21:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5141A246B8;
        Fri, 14 Feb 2020 16:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697313;
        bh=qekGi7wU7YSQhUWkPVpoPPNnb+45FMbtrtnohbHSl10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9sTUIwW4hprUN7Qsg7a4Cm+oQ5Q+vT7TWiUatm0ZijXfYA5XZS3G6GVOnXNip8yh
         CfPTEUugBaIUeShiSR1cqHpsdZAUd2O+0PRL5bP1Z11rEDTF/vOXWXWunBzeTgg9KS
         dQ95768XB6BoPWtqjDyPJ0bBUW9JWX5RMhbevOuA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bean Huo <beanhuo@micron.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 024/141] scsi: ufs: Fix ufshcd_probe_hba() reture value in case ufshcd_scsi_add_wlus() fails
Date:   Fri, 14 Feb 2020 11:19:24 -0500
Message-Id: <20200214162122.19794-24-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

[ Upstream commit b9fc5320212efdfb4e08b825aaa007815fd11d16 ]

A non-zero error value likely being returned by ufshcd_scsi_add_wlus() in
case of failure of adding the WLs, but ufshcd_probe_hba() doesn't use this
value, and doesn't report this failure to upper caller.  This patch is to
fix this issue.

Fixes: 2a8fa600445c ("ufs: manually add well known logical units")
Link: https://lore.kernel.org/r/20200120130820.1737-2-huobean@gmail.com
Reviewed-by: Asutosh Das <asutoshd@codeaurora.org>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 094e879af1213..394df57894e6b 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5347,7 +5347,8 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
 			ufshcd_init_icc_levels(hba);
 
 		/* Add required well known logical units to scsi mid layer */
-		if (ufshcd_scsi_add_wlus(hba))
+		ret = ufshcd_scsi_add_wlus(hba);
+		if (ret)
 			goto out;
 
 		scsi_scan_host(hba->host);
-- 
2.20.1

