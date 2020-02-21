Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292F3C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0084824650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271235;
	bh=a/JbiaU6A10GtmsEI/rx+V/8XXumfKNN7zGs8yipPCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P2B53InRnk49VCeZsfR++o24CDdRdczv24uEGvi3a/DDh01d60Fu0wSPo0x0IazYK
	 ch3+ec1rV+TVTGdPjehah/vRjqTWAOMp4HDAYwS//OYouOEMgFi/oX59x1ww0lllHX
	 zXhIMZsS1KIg7sgRLtUtszXt+1HZxzk31cnB6pmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgBUHrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:47:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:42972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbgBUHrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:47:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3689624650;
        Fri, 21 Feb 2020 07:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271231;
        bh=a/JbiaU6A10GtmsEI/rx+V/8XXumfKNN7zGs8yipPCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wmyv3FfzFmeK07lkLQ6rCjAavRPJKyAmEYLuDv7DRZ1V9zvJmOtwPSJN/euybR8dT
         fwcJwErM+3Df77oFEDY6p14Vsxmkw0eLGwWOywlvpSUbLzqLoUa5JtkLoUC0UG0plm
         6tS+EPdz7bh6+Lt2ZU96c8qXDpoJXpW66eXvlGj4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 089/399] brcmfmac: sdio: Fix OOB interrupt initialization on brcm43362
Date:   Fri, 21 Feb 2020 08:36:54 +0100
Message-Id: <20200221072410.976008175@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

[ Upstream commit 8c8e60fb86a90a30721bbd797f58f96b3980dcc1 ]

Commit 262f2b53f679 ("brcmfmac: call brcmf_attach() just before calling
brcmf_bus_started()") changed the initialization order of the brcmfmac
SDIO driver. Unfortunately since brcmf_sdiod_intr_register() is now
called before the sdiodev->bus_if initialization, it reads the wrong
chip ID and fails to initialize the GPIO on brcm43362. Thus the chip
cannot send interrupts and fails to probe:

[   12.517023] brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
[   12.531214] ieee80211 phy0: brcmf_bus_started: failed: -110
[   12.536976] ieee80211 phy0: brcmf_attach: dongle is not responding: err=-110
[   12.566467] brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed

Initialize the bus interface earlier to ensure that
brcmf_sdiod_intr_register() properly sets up the OOB interrupt.

BugLink: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=908438
Fixes: 262f2b53f679 ("brcmfmac: call brcmf_attach() just before calling brcmf_bus_started()")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/sdio.c  | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 1dea0178832ea..a935993a3c514 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -4226,6 +4226,12 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 	}
 
 	if (err == 0) {
+		/* Assign bus interface call back */
+		sdiod->bus_if->dev = sdiod->dev;
+		sdiod->bus_if->ops = &brcmf_sdio_bus_ops;
+		sdiod->bus_if->chip = bus->ci->chip;
+		sdiod->bus_if->chiprev = bus->ci->chiprev;
+
 		/* Allow full data communication using DPC from now on. */
 		brcmf_sdiod_change_state(bus->sdiodev, BRCMF_SDIOD_DATA);
 
@@ -4242,12 +4248,6 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 
 	sdio_release_host(sdiod->func1);
 
-	/* Assign bus interface call back */
-	sdiod->bus_if->dev = sdiod->dev;
-	sdiod->bus_if->ops = &brcmf_sdio_bus_ops;
-	sdiod->bus_if->chip = bus->ci->chip;
-	sdiod->bus_if->chiprev = bus->ci->chiprev;
-
 	err = brcmf_alloc(sdiod->dev, sdiod->settings);
 	if (err) {
 		brcmf_err("brcmf_alloc failed\n");
-- 
2.20.1



