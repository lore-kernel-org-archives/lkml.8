Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1ACC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928FC2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690889;
	bh=Md//2SsM3pTbIACxtDC5zWBoU63z75KHf/1QgDR+418=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B4YPVrSmTqhdcEdb1SImoC8ggbjg60mayJuFEVjhbnL3vBynk0Lk/un4gt9bixqns
	 MIU795LH1lye7bDIaWL+JkHVPOm8yp3wcy4aOXSitWJUKLZUANS8sXripNp/a+io8V
	 J7z3iK5dsjYnucFzZ5pLkHFQ0u8TE1TE8Selv1K8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404011AbgHQTBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:01:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730831AbgHQPsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:48:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC1452245C;
        Mon, 17 Aug 2020 15:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679281;
        bh=Md//2SsM3pTbIACxtDC5zWBoU63z75KHf/1QgDR+418=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jeTlgDiu53QU484E/Vlvf7rilLo+U75uNXIHWVmMiV1bHV+/XkYRj6Ej1rlMoDJdi
         kekjsDaSwplDOdlTYjRL00KmVVfmfC4AnCqdFk30bToodBjWJKWVlRDpqIsa4oweL6
         WDJQZRcRt9edooNYMw1NNpLE0UQtv2q52kl64jLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 127/393] mwifiex: Fix firmware filename for sd8977 chipset
Date:   Mon, 17 Aug 2020 17:12:57 +0200
Message-Id: <20200817143825.767477349@linuxfoundation.org>
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

[ Upstream commit 47fd3ee25e13cc5add48ba2ed71f7ee964b9c3a4 ]

Firmware for sd8977 chipset is distributed by Marvell package and also as
part of the linux-firmware repository in filename sdsd8977_combo_v2.bin.

This patch fixes mwifiex driver to load correct firmware file for sd8977.

Fixes: 1a0f547831dce ("mwifiex: add support for sd8977 chipset")
Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/sdio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
index 71cd8629b28ef..0cac2296ed53c 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.h
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
@@ -36,7 +36,7 @@
 #define SD8897_DEFAULT_FW_NAME "mrvl/sd8897_uapsta.bin"
 #define SD8887_DEFAULT_FW_NAME "mrvl/sd8887_uapsta.bin"
 #define SD8801_DEFAULT_FW_NAME "mrvl/sd8801_uapsta.bin"
-#define SD8977_DEFAULT_FW_NAME "mrvl/sd8977_uapsta.bin"
+#define SD8977_DEFAULT_FW_NAME "mrvl/sdsd8977_combo_v2.bin"
 #define SD8987_DEFAULT_FW_NAME "mrvl/sd8987_uapsta.bin"
 #define SD8997_DEFAULT_FW_NAME "mrvl/sd8997_uapsta.bin"
 
-- 
2.25.1



