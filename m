Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A93BC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7737921744
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098663;
	bh=vU+2AAZL6lc+EETr5u0F7lT9UJ/xX/iksxwZJPHuOmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ylqM6yxleWmNAF/M8Fg74shtbyx99/LuF8ellvHIeG1lBACDyC/f4U4yWCBWC/xDx
	 vjYngGuI+g2FpgTisCyeZVqXJEmKyj9ISXLksYPdFTetCaikkRfoe9+F9r2wrHdu3V
	 g1nILJlcTJtAVsULM4y2swslllsxBZDIsElrxbTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgD1SbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:31:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729576AbgD1Say (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:30:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6057220B80;
        Tue, 28 Apr 2020 18:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098653;
        bh=vU+2AAZL6lc+EETr5u0F7lT9UJ/xX/iksxwZJPHuOmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UciISi3S8JOaICcBhQ/Ne/MmkIy/grvkUl+9kKpOAwf/2V1WGS40pX8vyr640Nt5W
         wn9RtdN7tRCpQfVBL6robv/bnfeM1rfrQKpNjHg+ZL3Bn2R0SscIQb4Wn0vsLm3URZ
         oOAmFp4E1L2IOJd5KDBhOFx3jayXZJhQOXgispUw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Benesh <scott.benesh@microsemi.com>,
        Scott Teel <scott.teel@microsemi.com>,
        Kevin Barnett <kevin.barnett@microsemi.com>,
        Murthy Bhat <Murthy.Bhat@microsemi.com>,
        Don Brace <don.brace@microsemi.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 035/131] scsi: smartpqi: fix call trace in device discovery
Date:   Tue, 28 Apr 2020 20:24:07 +0200
Message-Id: <20200428182229.510235336@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Murthy Bhat <Murthy.Bhat@microsemi.com>

[ Upstream commit b969261134c1b990b96ea98fe5e0fcf8ec937c04 ]

Use sas_phy_delete rather than sas_phy_free which, according to
comments, should not be called for PHYs that have been set up
successfully.

Link: https://lore.kernel.org/r/157048748876.11757.17773443136670011786.stgit@brunhilda
Reviewed-by: Scott Benesh <scott.benesh@microsemi.com>
Reviewed-by: Scott Teel <scott.teel@microsemi.com>
Reviewed-by: Kevin Barnett <kevin.barnett@microsemi.com>
Signed-off-by: Murthy Bhat <Murthy.Bhat@microsemi.com>
Signed-off-by: Don Brace <don.brace@microsemi.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/smartpqi/smartpqi_sas_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_sas_transport.c b/drivers/scsi/smartpqi/smartpqi_sas_transport.c
index b209a35e482ef..01dfb97b07786 100644
--- a/drivers/scsi/smartpqi/smartpqi_sas_transport.c
+++ b/drivers/scsi/smartpqi/smartpqi_sas_transport.c
@@ -50,9 +50,9 @@ static void pqi_free_sas_phy(struct pqi_sas_phy *pqi_sas_phy)
 	struct sas_phy *phy = pqi_sas_phy->phy;
 
 	sas_port_delete_phy(pqi_sas_phy->parent_port->port, phy);
-	sas_phy_free(phy);
 	if (pqi_sas_phy->added_to_port)
 		list_del(&pqi_sas_phy->phy_list_entry);
+	sas_phy_delete(phy);
 	kfree(pqi_sas_phy);
 }
 
-- 
2.20.1



