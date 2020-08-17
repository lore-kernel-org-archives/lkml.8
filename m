Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CF9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F04A20729
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597683430;
	bh=JrnZwM8UAIuMLHP7tBDKi0C6XfjGffVEugHReXa9cHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wNB0WjwjlyWM2dMDBDHf2p5+YdoOsdautC4unZGa6PUUsbd1SJAjJofWGrJe57u3l
	 ji89ROrjTB301p8GpRsy/b24ZUHGtzoDehAdOfrhmhdMOS37BuY3iHOxlrC+LzFmA/
	 8zDdJQWn5+bqZaLluf2Sm4iSyJ0ggpbSe/HyENMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389243AbgHQQ5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:57:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388344AbgHQQEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:04:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3330D2053B;
        Mon, 17 Aug 2020 16:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680286;
        bh=JrnZwM8UAIuMLHP7tBDKi0C6XfjGffVEugHReXa9cHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GX1UF2+cFvGCXJvFMPDQWzNONSnsADiErQDOcB4/tm4px7pQPQflFRQBit8MqlOSi
         9NPZuPjxqWknhkW3sr6hSBFKe8hza1vR5UT6NEekPT8wR0qKki30q/s4MkqPuQIcg8
         wJd8RXbLbcOWpf+y/SBdZk7SwJxwlVnKMgfNItfw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 096/270] btmrvl: Fix firmware filename for sd8997 chipset
Date:   Mon, 17 Aug 2020 17:14:57 +0200
Message-Id: <20200817143800.559669207@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

[ Upstream commit 00eb0cb36fad53315047af12e83c643d3a2c2e49 ]

Firmware for sd8997 chipset is distributed by Marvell package and also as
part of the linux-firmware repository in filename sdsd8997_combo_v4.bin.

This patch fixes mwifiex driver to load correct firmware file for sd8997.

Fixes: f0ef67485f591 ("Bluetooth: btmrvl: add sd8997 chipset support")
Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btmrvl_sdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 7aa2c94720bc5..4c7978cb1786f 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -346,7 +346,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8987 = {
 
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8997 = {
 	.helper         = NULL,
-	.firmware       = "mrvl/sd8997_uapsta.bin",
+	.firmware       = "mrvl/sdsd8997_combo_v4.bin",
 	.reg            = &btmrvl_reg_8997,
 	.support_pscan_win_report = true,
 	.sd_blksz_fw_dl = 256,
@@ -1833,4 +1833,4 @@ MODULE_FIRMWARE("mrvl/sd8887_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8897_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sdsd8977_combo_v2.bin");
 MODULE_FIRMWARE("mrvl/sd8987_uapsta.bin");
-MODULE_FIRMWARE("mrvl/sd8997_uapsta.bin");
+MODULE_FIRMWARE("mrvl/sdsd8997_combo_v4.bin");
-- 
2.25.1



