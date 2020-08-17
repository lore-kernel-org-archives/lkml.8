Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CD8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60387206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597683308;
	bh=3AOwrpxBfMLHIXcFZv2BiZQU27j5feiAgZ6njoFCWg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wWSoL2lKfBcjkyuZ9vXidUBvdGIcLsoUK+aRmHEF05TbPRR3A/6SnyQWtwF1K5T/J
	 u3t0gtf1eyOz8ZYbsUFt7vYDOoecqCSDxz9h7mrG1q22RO67VH6iwuS4jZ6RGK35pg
	 dbpESNMxTdBnotA2B1yUaQX1KSIhjEpeHSdNSGyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389166AbgHQQzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388256AbgHQQDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:03:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0FA120729;
        Mon, 17 Aug 2020 16:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680223;
        bh=3AOwrpxBfMLHIXcFZv2BiZQU27j5feiAgZ6njoFCWg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UIrbwGYIjVhuWK73F5A6y+7SR1MWsH39x3Dvv38P2wAgnilaaUV2bXee+dkX+MP7K
         Lu4aRJU8X3hiy984lkhNmlwJu4upcmk6F5HicRjcpihELZAuznFlqMOvFGyMBlnJhW
         ZVp0aeIV/dGj0GodAdvXhKiwhRNfR+26TOt03K5U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 093/270] mwifiex: Fix firmware filename for sd8977 chipset
Date:   Mon, 17 Aug 2020 17:14:54 +0200
Message-Id: <20200817143800.402634765@linuxfoundation.org>
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
index f672bdf52cc17..9364e2c267f72 100644
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



