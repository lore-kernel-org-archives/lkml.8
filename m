Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAE0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6690E20823
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591366991;
	bh=H8TSug70zdms/pTRXhiGGPW0NgzFCnlO3fUnymnDzyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vBwTTsXkKjdbS1xqi65dsM2OhYiZU7iCNJJB0aJ4vKmbdfGnnFL/JC78stR/knTlX
	 uNWFfz5hNyYkSYDc/8x9dWddZGno21fzqekKrnGtGNizGKeeR1CluEabqfgg4nZBpv
	 h+ee45Try2dIl52uXP18IJm7eN3fiRg1qjnuDfXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgFEOSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbgFEOSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:18:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C476B208C3;
        Fri,  5 Jun 2020 14:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591366694;
        bh=H8TSug70zdms/pTRXhiGGPW0NgzFCnlO3fUnymnDzyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TAcVjE0frETREHXvs29JGdDgNYReuofQWTeUvUEMdXT7jdO0TJFwxpzQabGfcRJII
         4S0S5wfd2/9Qw8GXx42BaHaIMqiZNGWfSWuKdunN9MXFmIdiKelf3LZZkiPP8IYdil
         pRPTcfA7cdlNTkaTD9ad1vg1ID25b77P3rcfpZpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 16/38] scsi: hisi_sas: Check sas_port before using it
Date:   Fri,  5 Jun 2020 16:14:59 +0200
Message-Id: <20200605140253.543975590@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605140252.542768750@linuxfoundation.org>
References: <20200605140252.542768750@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

[ Upstream commit 8c39673d5474b95374df2104dc1f65205c5278b8 ]

Need to check the structure sas_port before using it.

Link: https://lore.kernel.org/r/1573551059-107873-2-git-send-email-john.garry@huawei.com
Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 849335d76cf6..6f4692f0d714 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -974,12 +974,13 @@ static void hisi_sas_port_notify_formed(struct asd_sas_phy *sas_phy)
 	struct hisi_hba *hisi_hba = sas_ha->lldd_ha;
 	struct hisi_sas_phy *phy = sas_phy->lldd_phy;
 	struct asd_sas_port *sas_port = sas_phy->port;
-	struct hisi_sas_port *port = to_hisi_sas_port(sas_port);
+	struct hisi_sas_port *port;
 	unsigned long flags;
 
 	if (!sas_port)
 		return;
 
+	port = to_hisi_sas_port(sas_port);
 	spin_lock_irqsave(&hisi_hba->lock, flags);
 	port->port_attached = 1;
 	port->id = phy->port_id;
-- 
2.25.1



