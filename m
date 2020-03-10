Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C884C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB92720675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583847279;
	bh=ABU12IfNmFeJk/drjZr/gSCCysZwfcqqTJ7L/m1fD/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=etpGDE0EWw+VU8ImbuNO2MI8T+VpP1PhrnKbQ1oX4iCm27tDVioiC4s4Zj0xYay4R
	 haBrrDbiYNbWdzybOAs/WVMK8x56J1RmoV8PElqmPnCWJ0OSkLjz7KrxFPQWjTRHA1
	 qA3g07sKJ+JTcE4CFYsODLJo/R+DXv5miCU05QEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgCJMqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727955AbgCJMqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:46:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97D272467D;
        Tue, 10 Mar 2020 12:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844376;
        bh=ABU12IfNmFeJk/drjZr/gSCCysZwfcqqTJ7L/m1fD/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J075e1ouZUv/KtbI5rWaOKa/qkEDgnc446Jh+5NeguJJfe7UPNWHkCZtaK2joQhcy
         NTKvnj1ywvlLrE8P45fxVv9ItlE0sr1UeNXc/iJoeEt97VHpR+MO5rR9iWcdY3x29c
         TB5Pj2ljiXubFoUleSGHjXkEsV8KZrlhEEZeF4Bs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Vasut <marex@denx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Lukas Wunner <lukas@wunner.de>, Petr Stetiar <ynezz@true.cz>,
        YueHaibing <yuehaibing@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 58/88] net: ks8851-ml: Fix 16-bit data access
Date:   Tue, 10 Mar 2020 13:39:06 +0100
Message-Id: <20200310123620.969868245@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123606.543939933@linuxfoundation.org>
References: <20200310123606.543939933@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Vasut <marex@denx.de>

[ Upstream commit edacb098ea9c31589276152f09b4439052c0f2b1 ]

The packet data written to and read from Micrel KSZ8851-16MLLI must be
byte-swapped in 16-bit mode, add this byte-swapping.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Petr Stetiar <ynezz@true.cz>
Cc: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/micrel/ks8851_mll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8851_mll.c b/drivers/net/ethernet/micrel/ks8851_mll.c
index 721f851674531..20356976b9772 100644
--- a/drivers/net/ethernet/micrel/ks8851_mll.c
+++ b/drivers/net/ethernet/micrel/ks8851_mll.c
@@ -515,7 +515,7 @@ static inline void ks_inblk(struct ks_net *ks, u16 *wptr, u32 len)
 {
 	len >>= 1;
 	while (len--)
-		*wptr++ = (u16)ioread16(ks->hw_addr);
+		*wptr++ = be16_to_cpu(ioread16(ks->hw_addr));
 }
 
 /**
@@ -529,7 +529,7 @@ static inline void ks_outblk(struct ks_net *ks, u16 *wptr, u32 len)
 {
 	len >>= 1;
 	while (len--)
-		iowrite16(*wptr++, ks->hw_addr);
+		iowrite16(cpu_to_be16(*wptr++), ks->hw_addr);
 }
 
 static void ks_disable_int(struct ks_net *ks)
-- 
2.20.1



