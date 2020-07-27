Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5661C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E872070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859667;
	bh=cToFvjwH/rD41ff8mryTBGVqToQbljdz/cOulN4Cwqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PDIl3+sM977o3LP8JPq9UAw8QjQ8ScUHHdUXUaQPX+ISYWNP11eMf0WKN83NbkEU4
	 lOUVZwXg9ZPTPBU2sYx+NX3pAwbY4oue+5dd/md1yLQkgY/wHW9vwM2g/d2U2Kdyfi
	 DB29DLTzm+PWDPLuFRJ3QNaG9Czo8JEgqSFKof4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbgG0OVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:21:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731638AbgG0OVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:21:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B0D22070A;
        Mon, 27 Jul 2020 14:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859661;
        bh=cToFvjwH/rD41ff8mryTBGVqToQbljdz/cOulN4Cwqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E9FKyTht/FGSgtTrsLXtm3lY2lildYuHaQvGvNjy0PyCe5KCQjT9CB9zie9OYgTgw
         gBZbAdoStJm96+yXEjlBYabLXaXj1phFFU34t75HdJDSm0w9knHU33aWpdvXBuUw35
         t2t39AJ8gABHeAZXDJiPAgIjlD+6zCIduSlMZprA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Steve Schremmer <steve.schremmer@netapp.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 016/179] scsi: dh: Add Fujitsu device to devinfo and dh lists
Date:   Mon, 27 Jul 2020 16:03:11 +0200
Message-Id: <20200727134933.464050722@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Schremmer <steve.schremmer@netapp.com>

[ Upstream commit e094fd346021b820f37188aaa6b502c7490ab5b5 ]

Add FUJITSU ETERNUS_AHB

Link: https://lore.kernel.org/r/DM6PR06MB5276CCA765336BD312C4282E8C660@DM6PR06MB5276.namprd06.prod.outlook.com
Signed-off-by: Steve Schremmer <steve.schremmer@netapp.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_devinfo.c | 1 +
 drivers/scsi/scsi_dh.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index eed31021e7885..ba84244c1b4f6 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -239,6 +239,7 @@ static struct {
 	{"LSI", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
 	{"ENGENIO", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
 	{"LENOVO", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
+	{"FUJITSU", "Universal Xport", "*", BLIST_NO_ULD_ATTACH},
 	{"SanDisk", "Cruzer Blade", NULL, BLIST_TRY_VPD_PAGES |
 		BLIST_INQUIRY_36},
 	{"SMSC", "USB 2 HS-CF", NULL, BLIST_SPARSELUN | BLIST_INQUIRY_36},
diff --git a/drivers/scsi/scsi_dh.c b/drivers/scsi/scsi_dh.c
index 42f0550d6b11f..6f41e4b5a2b85 100644
--- a/drivers/scsi/scsi_dh.c
+++ b/drivers/scsi/scsi_dh.c
@@ -63,6 +63,7 @@ static const struct scsi_dh_blist scsi_dh_blist[] = {
 	{"LSI", "INF-01-00",		"rdac", },
 	{"ENGENIO", "INF-01-00",	"rdac", },
 	{"LENOVO", "DE_Series",		"rdac", },
+	{"FUJITSU", "ETERNUS_AHB",	"rdac", },
 	{NULL, NULL,			NULL },
 };
 
-- 
2.25.1



