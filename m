Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EED1C2BBD0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A2AD20C09
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgIHKRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:17:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:56218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbgIHKRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:17:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F011BB6B7;
        Tue,  8 Sep 2020 10:17:11 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
List-Id: <linux-firmware.lore.kernel.org>
To:     linux-firmware@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH linux-firmware] brcm: Fix a stale symlink for RPi3 model b+
Date:   Tue,  8 Sep 2020 12:16:56 +0200
Message-Id: <20200908101656.27835-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symlink for brcmfmac43455-sdio.raspberrypi,3-model-b-plus.txt
was wrongly listed with the same subdirectory brcm, and this resulted
in a stale symlink.  Fix it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 WHENCE | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/WHENCE b/WHENCE
index 4adac39e28eb..f4af5d01e2c8 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2639,7 +2639,7 @@ File: "brcm/brcmfmac43430-sdio.Hampoo-D2D3_Vi8A1.txt"
 File: "brcm/brcmfmac43430-sdio.MUR1DX.txt"
 File: "brcm/brcmfmac43430-sdio.raspberrypi,3-model-b.txt"
 File: "brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.txt"
-Link: brcm/brcmfmac43455-sdio.raspberrypi,3-model-a-plus.txt -> brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.txt
+Link: brcm/brcmfmac43455-sdio.raspberrypi,3-model-a-plus.txt -> brcmfmac43455-sdio.raspberrypi,3-model-b-plus.txt
 File: "brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt"
 File: "brcm/brcmfmac43455-sdio.MINIX-NEO Z83-4.txt"
 File: "brcm/brcmfmac4356-pcie.gpd-win-pocket.txt"
-- 
2.16.4

