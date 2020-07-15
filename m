Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044A3C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D16206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BhAQ/z1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbgGOMsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 08:48:46 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60148 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbgGOMsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:48:45 -0400
Received: from Q.local (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 651DF595;
        Wed, 15 Jul 2020 14:48:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594817323;
        bh=a7uVQzE49137RdV07bw9OGdl1LVEpyOGkBAVLWh288A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BhAQ/z1NGB0cIEOvyVsZG7CB936KpG6rTgJSLDtFCgObG0y+k+Vhnh8ThyDG8TeWN
         5147wg0RI6c3cin6GYmxbQA9KBYaNHAfmMV1Ijx1Onemy1xIEYUp1tkhlawf3nYFXQ
         Be65b2WYNfIefqdiruXdTQrTlTrjNEAtYMWUP/t4=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     trivial@kernel.org
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM
        SUB-ARCHITECTURES), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/8] arch: arm: mach-davinci: Fix trivial spelling
Date:   Wed, 15 Jul 2020 13:48:32 +0100
Message-Id: <20200715124839.252822-2-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715124839.252822-1-kieran.bingham+renesas@ideasonboard.com>
References: <20200715124839.252822-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word 'descriptor' is misspelled throughout the tree.

Fix it up accordingly:
    decriptors -> descriptors

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 arch/arm/mach-davinci/board-da830-evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index a273ab25c668..1076886938b6 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -266,7 +266,7 @@ static struct mtd_partition da830_evm_nand_partitions[] = {
 	}
 };
 
-/* flash bbt decriptors */
+/* flash bbt descriptors */
 static uint8_t da830_evm_nand_bbt_pattern[] = { 'B', 'b', 't', '0' };
 static uint8_t da830_evm_nand_mirror_pattern[] = { '1', 't', 'b', 'B' };
 
-- 
2.25.1

