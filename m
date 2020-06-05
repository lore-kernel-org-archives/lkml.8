Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B79C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1829820663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591366930;
	bh=LdEIPkjvJ8xqDM/hFsUn+psk8VzAVH/5vIvKuDXWIC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H/BwyR8FRHCmwQkBeWgHjoB3Mso0KNJGTw7PW4P15Bk6gT2UIzYCQh3PH16UHKsgn
	 OpRyrQaYyGZ5+QQbzoJ0jgIpYj/Re5RqSX87gk2m8BUHKaWixodpCnt9iPkiKtXfQX
	 /XueLTz95wIQDa0lstcpv+0ECK2zl2XWtWqgnmqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgFEOWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbgFEOTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:19:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E889D2086A;
        Fri,  5 Jun 2020 14:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591366776;
        bh=LdEIPkjvJ8xqDM/hFsUn+psk8VzAVH/5vIvKuDXWIC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nT0eW/54FSl9XKoNMlskrSqJAaqZ10+2XOq2Hrj7+hcvbbgXiQmKBNIFry8KK+Gej
         PpUGyTSojYbTlD5fIcjpLrKzcmjs+2QQKzadou7lFYIOD/ICT5lrY2kWkWPLcJ4ewH
         nuqEOkrOjLUtIlkHsk89Ste95L7hkwvpwUWubMY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiang Chen <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 13/28] scsi: hisi_sas: Check sas_port before using it
Date:   Fri,  5 Jun 2020 16:15:15 +0200
Message-Id: <20200605140253.156033023@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605140252.338635395@linuxfoundation.org>
References: <20200605140252.338635395@linuxfoundation.org>
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
index 33191673249c..de4f41bce8e9 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -789,12 +789,13 @@ static void hisi_sas_port_notify_formed(struct asd_sas_phy *sas_phy)
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



