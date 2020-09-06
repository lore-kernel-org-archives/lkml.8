Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7936FC433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 15:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 428EE2075A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599407074;
	bh=q4PfSN/iGfvSKBF5OqA0xnoo0M75rGDiILB3JNyi3Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jlYFCcKq4/kd/71djb1GdINrHoxh7TYmRG3+DoCzlHnXrwRSnDJZ/dOhmowUPyOpN
	 1XjXA/l3FWood+48Y1/Yo5EuK3nXLIVk7GTNdCTTKyLsE8ACjMX1Bq4iJKsrScAVde
	 jGCafHFJkBDCWZhOrRKIjim6U2SS5v/VpXqFEBVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgIFPo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 11:44:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbgIFPi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 11:38:59 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 180932087C;
        Sun,  6 Sep 2020 15:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599406668;
        bh=q4PfSN/iGfvSKBF5OqA0xnoo0M75rGDiILB3JNyi3Sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mefOvFPvkOhJ1KcRy7p46kGHjsedLZGjp2Kt5upg97ASLzTfnGSC8WlkySSNo6pPQ
         5lebo9u6KrD611LAzv67xR9keoBcwnHUikfjbPOTp0OLAHtocpuxFEVs5MgiNjc2tO
         X2sH7WwyFAdR9hI3lzU91hR0RQkL2kf7W6eSb6UA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-nfc@lists.01.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 5/9] nfc: s3fwrn5: Add missing CRYPTO_HASH dependency
Date:   Sun,  6 Sep 2020 17:36:50 +0200
Message-Id: <20200906153654.2925-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200906153654.2925-1-krzk@kernel.org>
References: <20200906153654.2925-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses crypto hash functions so it needs to select CRYPTO_HASH.
This fixes build errors:

  arc-linux-ld: drivers/nfc/s3fwrn5/firmware.o: in function `s3fwrn5_fw_download':
  firmware.c:(.text+0x152): undefined reference to `crypto_alloc_shash'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/nfc/s3fwrn5/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nfc/s3fwrn5/Kconfig b/drivers/nfc/s3fwrn5/Kconfig
index af9d18690afe..3f8b6da58280 100644
--- a/drivers/nfc/s3fwrn5/Kconfig
+++ b/drivers/nfc/s3fwrn5/Kconfig
@@ -2,6 +2,7 @@
 config NFC_S3FWRN5
 	tristate
 	select CRYPTO
+	select CRYPTO_HASH
 	help
 	  Core driver for Samsung S3FWRN5 NFC chip. Contains core utilities
 	  of chip. It's intended to be used by PHYs to avoid duplicating lots
-- 
2.17.1

