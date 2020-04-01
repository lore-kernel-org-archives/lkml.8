Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B91C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621E921655
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758416;
	bh=VG0NiHdi3TlnW4vQx2Fos3Trvv1k3/p0YMmSv0f118o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KkO5LETXEeMBE/WTXnCLF6j3X54elbUWEMj1Ry9K8KQMIQETJZx7pRuP9HmOEgWYH
	 RoLqUWIZhjIOOD0lkWxYd1oItCg6LnPy1pQGZ74BmVdAnejQecrl33m5YXpDSdvz+Y
	 VmLSi6hFTZkEprdDlTiWoUgUMQCixPhFzG9YaAu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387950AbgDAQ0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:26:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387893AbgDAQ0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:26:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED23F20857;
        Wed,  1 Apr 2020 16:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758395;
        bh=VG0NiHdi3TlnW4vQx2Fos3Trvv1k3/p0YMmSv0f118o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mBY4ImPNiVrNRSKuGwt0WAf3jKpfplI6fuDrdMlLReJf8RGXD0G80j0QtUehQv6yh
         f2ZnJY/RnGhlQ3p7zcHbAUiVN4yvvN/3o7zPcn6V+S/lK5sWHkur8BpFWeR/g7vQdR
         WXDEJfFWg4wR82J3koRhW6BVZdqWgvazRlygmp/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 076/116] Revert "r8169: check that Realtek PHY driver module is loaded"
Date:   Wed,  1 Apr 2020 18:17:32 +0200
Message-Id: <20200401161552.481298942@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 85a19b0e31e256e77fd4124804b9cec10619de5e which is
commit f325937735498afb054a0195291bbf68d0b60be5 upstream.

Heiner writes:
	commit 85a19b0e31e2 ("r8169: check that Realtek PHY driver
	module is loaded") made it accidentally to 4.19 and causes an
	issue with Android/x86.  Could you please revert it?

Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    9 ---------
 1 file changed, 9 deletions(-)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -7433,15 +7433,6 @@ static int rtl_init_one(struct pci_dev *
 	int chipset, region, i;
 	int jumbo_max, rc;
 
-	/* Some tools for creating an initramfs don't consider softdeps, then
-	 * r8169.ko may be in initramfs, but realtek.ko not. Then the generic
-	 * PHY driver is used that doesn't work with most chip versions.
-	 */
-	if (!driver_find("RTL8201CP Ethernet", &mdio_bus_type)) {
-		dev_err(&pdev->dev, "realtek.ko not loaded, maybe it needs to be added to initramfs?\n");
-		return -ENOENT;
-	}
-
 	dev = devm_alloc_etherdev(&pdev->dev, sizeof (*tp));
 	if (!dev)
 		return -ENOMEM;


