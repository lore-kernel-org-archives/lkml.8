Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEEAC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B342072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690868;
	bh=EqM+gLh7D3odZQRkGC9GZ7RNw+ABm4SgeE8Cenu11Gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=imiFcuYQqlPz13a9lowSta//aqO3GBmrBs+hmikGykJvrP5Po93r2FgoSiZQ+u3uT
	 8XIg7RX/IM8SLCVB4q1tT3AJ7hZubm8Y6FcBo5hZoJTeEJz/ZdbPH9pZitZ15MNJjo
	 z0sWrS1dVTgZj+2yyy1KSOLRVnSgH1oMS/XyEWeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbgHQTBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730835AbgHQPsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:48:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 759982065D;
        Mon, 17 Aug 2020 15:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679287;
        bh=EqM+gLh7D3odZQRkGC9GZ7RNw+ABm4SgeE8Cenu11Gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHQAkzRcQ/gOioFMPL3d3T41HjqiM4PuE5o5ekiXzW2QJZswnqxE7+z/+3hxZHtTD
         2jPa4QDmUXDm0YXVboD3EjyBCoKpPY8vfOnUSROqeAxVEal322aU4+cCHt1/nvRAwm
         oV8TulEGq252F/zDoK1QmygVcERnDGHs1fLJy3HA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 129/393] btmrvl: Fix firmware filename for sd8977 chipset
Date:   Mon, 17 Aug 2020 17:12:59 +0200
Message-Id: <20200817143825.866153275@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

[ Upstream commit dbec3af5f13b88a96e31f252957ae1a82484a923 ]

Firmware for sd8977 chipset is distributed by Marvell package and also as
part of the linux-firmware repository in filename sdsd8977_combo_v2.bin.

This patch fixes mwifiex driver to load correct firmware file for sd8977.

Fixes: 8c57983bf7a79 ("Bluetooth: btmrvl: add support for sd8977 chipset")
Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btmrvl_sdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 0f3a020703ab2..7aa2c94720bc5 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -328,7 +328,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8897 = {
 
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8977 = {
 	.helper         = NULL,
-	.firmware       = "mrvl/sd8977_uapsta.bin",
+	.firmware       = "mrvl/sdsd8977_combo_v2.bin",
 	.reg            = &btmrvl_reg_8977,
 	.support_pscan_win_report = true,
 	.sd_blksz_fw_dl = 256,
@@ -1831,6 +1831,6 @@ MODULE_FIRMWARE("mrvl/sd8787_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8797_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8887_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8897_uapsta.bin");
-MODULE_FIRMWARE("mrvl/sd8977_uapsta.bin");
+MODULE_FIRMWARE("mrvl/sdsd8977_combo_v2.bin");
 MODULE_FIRMWARE("mrvl/sd8987_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8997_uapsta.bin");
-- 
2.25.1



