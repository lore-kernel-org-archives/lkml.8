Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E987C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7102020724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945815;
	bh=6m3wXgaVYOYeOzH2NXttvoEuW9DYuUgob8tBzPyiZ/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XRvSLAj936Q5oJvG1xirE/BRoLYyzJzP+C93zd5w+2FFahVzFn30bBJ5PMOcWlLyy
	 NRK81VbZ0/ipd/gxVRF/xAhXKh8I864haCtOZUF3qQe39eU2fR3OlZqStldIwXQw5I
	 JJckr98LiCmhOo4PZbFPHb7PDb8wLRMbFE0wfgqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393002AbgFWUyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392694AbgFWUpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:45:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF0F120781;
        Tue, 23 Jun 2020 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945134;
        bh=6m3wXgaVYOYeOzH2NXttvoEuW9DYuUgob8tBzPyiZ/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUaeN5X4xYBFYe5KB0MFIv0/aQXq2dBhMPjMOov12KCGVMUgpwfLKBRBeEjYLoiuA
         UcojCSwVtLiOuOIl3s0uoe9YM1nTqmWiabbyGLF9spfX8etJ8VbmtqJaffqhawuaSc
         oAjGGa55EszeGDJU1eIYELZ7mExMb+6iFWZzhkgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 052/136] scsi: mpt3sas: Fix double free warnings
Date:   Tue, 23 Jun 2020 21:58:28 +0200
Message-Id: <20200623195306.296095733@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 817a7963a038b..556971c5f0b0e 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3263,7 +3263,9 @@ _base_release_memory_pools(struct MPT3SAS_ADAPTER *ioc)
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



