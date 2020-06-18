Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45465C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15EC8221F8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445695;
	bh=XjLwWG3ywh1AX4F0gMD1EW1r5Nwmn6q/j0s9sHz7G34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m3Ue+uKGpf93EROwY3R9y9O935Tg9CddyCkeOLlRVf0r2vOVbOHO9LAnMQkZZi3RG
	 9path6OWcd6cWTPXcf0XD4t2PW0I/2iYnErciJXtCMvQlr7H/WKnzH3pRdHP4BrK/b
	 BSG4BJIXyZG8mx4P9T0YHoMDK/efsKJyyasM3KQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbgFRCBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731129AbgFRBYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:24:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AA5E20B1F;
        Thu, 18 Jun 2020 01:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443447;
        bh=XjLwWG3ywh1AX4F0gMD1EW1r5Nwmn6q/j0s9sHz7G34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbNboTuf65VIRcQo2HO/MV2rEzfR2zkDojhCBwViJNeTS4ICvpaKNh1Irdca3qPrS
         Oh52O15pQNY7Ayzq6jmq9vF02fMwlEObo9oXfsGS6Kw4xjTn3w5UYivbhZa6LDM2Xe
         n3biIOSszQhMx8cjbyoh49KrksDThekTNvxlEtQA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 083/172] scsi: mpt3sas: Fix double free warnings
Date:   Wed, 17 Jun 2020 21:20:49 -0400
Message-Id: <20200618012218.607130-83-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
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
index 2c556c7fcf0d..9fbe20e38ad0 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4284,7 +4284,9 @@ _base_release_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 	}
 
 	kfree(ioc->hpr_lookup);
+	ioc->hpr_lookup = NULL;
 	kfree(ioc->internal_lookup);
+	ioc->internal_lookup = NULL;
 	if (ioc->chain_lookup) {
 		for (i = 0; i < ioc->scsiio_depth; i++) {
 			for (j = ioc->chains_per_prp_buffer;
-- 
2.25.1

