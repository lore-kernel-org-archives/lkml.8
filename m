Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF44C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4638B2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590605697;
	bh=buDzRBIkAkYDEh9lsYjrjDhRTyGGo4mtZJEWBxbG99A=;
	h=From:To:Subject:Date:List-ID:From;
	b=AQ28NkXYMxjSfKyFXX+f2lBsveTIZyiDirMNSuscaa9rvqiE1BFvYt9Oh7N4axk+k
	 vtY4lsOUVPPVQxDmIjgOWtHvxJUaA1R+AVMiJ6ncQ14lJyB3wa55RbfCeidCFxWPbS
	 boA59GQNRXbUGIx+wZQ5jfPqIPfDa1hcIjGt11+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgE0Sy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgE0Syz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:54:55 -0400
Received: from localhost.localdomain (unknown [194.230.155.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A343E2073B;
        Wed, 27 May 2020 18:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590605695;
        bh=buDzRBIkAkYDEh9lsYjrjDhRTyGGo4mtZJEWBxbG99A=;
        h=From:To:Subject:Date:From;
        b=k4IB+QoZdhL1u7RYjM2DU/sQMyZcCeRoS2exnWppx9TQNN0jB9T097rKPIZZ5fXtu
         rRlrJ4ktLRhJuLVEZuulhQNakAO31ViQ6L2Ue7bWkD5enTCCguKvQfs6xDODwdiTiJ
         tTnIbi+gq5uqi+/DvqrQbnjlW/PDYhU/HU/2KDLo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Guan Xuetao <gxt@pku.edu.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] unicore32: defconfig: Cleanup from old Kconfig options
Date:   Wed, 27 May 2020 20:54:51 +0200
Message-Id: <20200527185451.13512-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove old, dead Kconfig options (in order appearing in this commit):
 - EXPERIMENTAL is gone since v3.9;
 - MTD_PARTITIONS: commit 6a8a98b22b10 ("mtd: kill
   CONFIG_MTD_PARTITIONS");
 - MTD_CHAR: commit 660685d9d1b4 ("mtd: merge mtdchar module with
   mtdcore");
 - NETDEV_1000: commit f860b0522f65 ("drivers/net: Kconfig and Makefile
   cleanup"); NET_ETHERNET should be replaced with just ETHERNET but
   that is separate change;

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/unicore32/configs/defconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/unicore32/configs/defconfig b/arch/unicore32/configs/defconfig
index 360cc9abcdb0..511e216a2f13 100644
--- a/arch/unicore32/configs/defconfig
+++ b/arch/unicore32/configs/defconfig
@@ -1,5 +1,4 @@
 ### General setup
-CONFIG_EXPERIMENTAL=y
 CONFIG_LOCALVERSION="-unicore32"
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
@@ -75,8 +74,6 @@ CONFIG_PUV3_UART=n
 #	Memory Technology Device (MTD) support
 CONFIG_MTD=m
 CONFIG_MTD_UBI=m
-CONFIG_MTD_PARTITIONS=y
-CONFIG_MTD_CHAR=m
 CONFIG_MTD_BLKDEVS=m
 #	RAM/ROM/Flash chip drivers
 CONFIG_MTD_CFI=m
@@ -101,7 +98,6 @@ CONFIG_SATA_VIA=y
 #	Network device support
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
-CONFIG_NETDEV_1000=y
 #	Wireless LAN
 CONFIG_WLAN_80211=n
 CONFIG_RT2X00=n
-- 
2.17.1

