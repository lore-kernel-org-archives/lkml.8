Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E516C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053C92077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587553257;
	bh=fMIbKF4UunvlXc7lLG5zLO3UJbltX/cxE/vfANOnhK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ppQwx5OAKBZr/ZT7Zt4Q7/Cla6SOcAK8D9nS47acUbdxe2S0ruhHHkbmBqtqj/uOD
	 JgL4r4MxHTPkEyG328hxIFFFqskrmU1ArsK+kyveYp1EHRdngEI4ErHnnzR9JNh1nM
	 KPLdT4KR3hSX1ln/UxMo1j6j5KSlPfOSUO0UusxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgDVLAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbgDVKB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:01:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5230220780;
        Wed, 22 Apr 2020 10:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549715;
        bh=fMIbKF4UunvlXc7lLG5zLO3UJbltX/cxE/vfANOnhK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzB4R6gx2YX+QvzqsnBhmhNK32pv7qYJFMk6Wav1ECiyDY4KGxh/+K/aEQTtVy3kx
         XGjvVrxEZfJ8R1KLRLQeKFwH24C4WUSS7GUEPUWKirGsz99mGYVE7SguQyr+UzjOlq
         NhmiC8Pk3ichBJPRm5cszZK6aZisdkjFCxOl4HhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.4 078/100] scsi: ufs: ufs-qcom: remove broken hci version quirk
Date:   Wed, 22 Apr 2020 11:56:48 +0200
Message-Id: <20200422095037.111146008@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095022.476101261@linuxfoundation.org>
References: <20200422095022.476101261@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Subhash Jadavani <subhashj@codeaurora.org>

[ Upstream commit 69a6fff068567469c0ef1156ae5ac8d3d71701f0 ]

UFSHCD_QUIRK_BROKEN_UFS_HCI_VERSION is only applicable for QCOM UFS host
controller version 2.x.y and this has been fixed from version 3.x.y
onwards, hence this change removes this quirk for version 3.x.y onwards.

[mkp: applied by hand]

Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ufs/ufs-qcom.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -1032,7 +1032,7 @@ static void ufs_qcom_advertise_quirks(st
 		hba->quirks |= UFSHCD_QUIRK_BROKEN_LCC;
 	}
 
-	if (host->hw_ver.major >= 0x2) {
+	if (host->hw_ver.major == 0x2) {
 		hba->quirks |= UFSHCD_QUIRK_BROKEN_UFS_HCI_VERSION;
 
 		if (!ufs_qcom_cap_qunipro(host))


