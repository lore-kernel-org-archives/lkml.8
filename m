Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAF1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 878E1206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593464856;
	bh=HNyBE1hTrNXbSBGAqMnk8Ynsekr44GsKu7muWPFXWPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vGN5d+FxOIWbbXLrmgptRPmfCg+y4mwW9wVbOvZlsqkxVzIBt5atbImzuEiJpoAkA
	 nFXotm8QpxIk5m0Hc4xNMyJFo5Nr7bE03lUvxCPTdya7IdGRT2DQ4iWODz+8SNU+7j
	 GV+35qZx2WoDIRmMfQAqtw89yUYLupG1njH6rQJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbgF2VHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:07:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730828AbgF2TKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:10:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12156254C8;
        Mon, 29 Jun 2020 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593446021;
        bh=HNyBE1hTrNXbSBGAqMnk8Ynsekr44GsKu7muWPFXWPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eXbPthKr1UZRXuLsB8TOp8DJPpkKewLzAC7TPZUqXaqQz1WUYPOn8V5ZVIZsTDLnq
         RiG+MYD2c5Hfx9EsZi/lz8vyhLOr4vj1o7LSYoi4PGTdOJIrprvXWdg9QkoFTQiYwF
         0xAiqZlN1o1wG8bIiL3jHuL+emca+/ZvR3htLcxQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 028/135] scsi: mpt3sas: Fix double free warnings
Date:   Mon, 29 Jun 2020 11:51:22 -0400
Message-Id: <20200629155309.2495516-29-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629155309.2495516-1-sashal@kernel.org>
References: <20200629155309.2495516-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:53+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>

[ Upstream commit cbbfdb2a2416c9f0cde913cf09670097ac281282 ]

Fix following warning from Smatch static analyser:

drivers/scsi/mpt3sas/mpt3sas_base.c:5256 _base_allocate_memory_pools()
warn: 'ioc->hpr_lookup' double freed

drivers/scsi/mpt3sas/mpt3sas_base.c:5256 _base_allocate_memory_pools()
warn: 'ioc->internal_lookup' double freed

Link: https://lore.kernel.org/r/20200508110738.30732-1-suganath-prabu.subramani@broadcom.com
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 7af7a08594785..8d52afd1f71db 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3136,7 +3136,9 @@ _base_release_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 		ioc->scsi_lookup = NULL;
 	}
 	kfree(ioc->hpr_lookup);
+	ioc->hpr_lookup = NULL;
 	kfree(ioc->internal_lookup);
+	ioc->internal_lookup = NULL;
 	if (ioc->chain_lookup) {
 		for (i = 0; i < ioc->chain_depth; i++) {
 			if (ioc->chain_lookup[i].chain_buffer)
-- 
2.25.1

