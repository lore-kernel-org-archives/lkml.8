Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E16FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 646082072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690865;
	bh=YlRh3B+yB1gO6DwsQEz0MDfmSprSyUwxCReZ80FBhQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ju3UTfUAf5DWtpGPmEYQH8Rv+JWds+azxXJuNOd9GpSpLAfaD5WHwZUkch9jASxlc
	 /ZbAIPQfv9XEB2Z0x3eYWMoOFRxaKk5K7EcM5BgTw0o2Ha8RNYaZdldVZn8ZZ1stMT
	 FV863qtXPK+Q04FYIYRpOFqPgcXZYJguosEG5QHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbgHQTBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730833AbgHQPsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:48:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AAFA22CA1;
        Mon, 17 Aug 2020 15:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679283;
        bh=YlRh3B+yB1gO6DwsQEz0MDfmSprSyUwxCReZ80FBhQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qjywQYN2c+15V2/Pa5aCWLogDYjBxjVuzc9Wk/B7H1TQspdkDoRPsuqFnYLX8AFYS
         mAl7pXMlb8vWIMArhZQnKVvS0Q6CKk56QyFz1oF4OxU6hpBiv7cn9vpzpooSIt5my8
         R5v1gOS+YhfiBoTqnfVL96N/G6Ky83841ofvz6Uw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 128/393] mwifiex: Fix firmware filename for sd8997 chipset
Date:   Mon, 17 Aug 2020 17:12:58 +0200
Message-Id: <20200817143825.816146615@linuxfoundation.org>
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

[ Upstream commit 2e1fcac52a9ea53e5a13a585d48a29a0fb4a9daf ]

Firmware for sd8997 chipset is distributed by Marvell package and also as
part of the linux-firmware repository in filename sdsd8997_combo_v4.bin.

This patch fixes mwifiex driver to load correct firmware file for sd8997.

Fixes: 6d85ef00d9dfe ("mwifiex: add support for 8997 chipset")
Signed-off-by: Pali Rohár <pali@kernel.org>
Acked-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/sdio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.h b/drivers/net/wireless/marvell/mwifiex/sdio.h
index 0cac2296ed53c..8b476b007c5e2 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.h
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.h
@@ -38,7 +38,7 @@
 #define SD8801_DEFAULT_FW_NAME "mrvl/sd8801_uapsta.bin"
 #define SD8977_DEFAULT_FW_NAME "mrvl/sdsd8977_combo_v2.bin"
 #define SD8987_DEFAULT_FW_NAME "mrvl/sd8987_uapsta.bin"
-#define SD8997_DEFAULT_FW_NAME "mrvl/sd8997_uapsta.bin"
+#define SD8997_DEFAULT_FW_NAME "mrvl/sdsd8997_combo_v4.bin"
 
 #define BLOCK_MODE	1
 #define BYTE_MODE	0
-- 
2.25.1



