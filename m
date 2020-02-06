Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD31EC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F46820658
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LXI/VJlT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgBFKLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 05:11:03 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7743 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgBFKLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:11:02 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3be5fb0000>; Thu, 06 Feb 2020 02:10:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Feb 2020 02:11:01 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Feb 2020 02:11:01 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Feb
 2020 10:11:01 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 6 Feb 2020 10:11:01 +0000
Received: from viswanathl-pc.nvidia.com (Not Verified[10.24.34.161]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e3be6300014>; Thu, 06 Feb 2020 02:11:00 -0800
From:   Viswanath L <viswanathl@nvidia.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <mkumard@nvidia.com>,
        <jonathanh@nvidia.com>
CC:     <arnd@arndb.de>, <yung-chuan.liao@linux.intel.com>,
        <baolin.wang@linaro.org>, <kstewart@linuxfoundation.org>,
        <Julia.Lawall@inria.fr>, <tglx@linutronix.de>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <spujar@nvidia.com>, <sharadg@nvidia.com>, <rlokhande@nvidia.com>,
        <DRAMESH@nvidia.com>, <atalambedu@nvidia.com>,
        Viswanath L <viswanathl@nvidia.com>
Subject: [PATCH] ALSA: hda: Clear RIRB status before reading WP
Date:   Thu, 6 Feb 2020 15:40:53 +0530
Message-ID: <1580983853-351-1-git-send-email-viswanathl@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580983803; bh=e4WVFXFb11pvmP/iVTw7vCwJBQPl0YB7s5fvN/Yezig=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=LXI/VJlTfRMnqKotrPgGFLP7jUgGKNtuPKaFhO8xs+IcYprI8zYs1sTn5GpySaymv
         ddgrweVLLJmAslI1JIDx8VTGguKZxEobTjrRnIz588CL5L5B7q2XjqM45RCvL1Oabi
         6+j1C68e9+suKLkjwal5b8jJNQH7+RpGjiVBSfzpYy5Q+SQTCieCCB5S/YhnLzLWbn
         5f1MX8W8fuK6t3rgUtXjhPR1wrmEGO0DkHrSGB/Rb0pfLzo0+All6i91mnnP29Ol5z
         7438x1vXkfD1NsAMtz+Egy+60lF9/GeLTywRYaY5NVmUfra7md6MLScvJ1MCUwGMpR
         XkzCEsofI0YLQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mohan Kumar <mkumard@nvidia.com>

RIRB interrupt status getting cleared after the write pointer is read
causes a race condition, where last response(s) into RIRB may remain
unserviced by IRQ, eventually causing azx_rirb_get_response to fall
back to polling mode. Clearing the RIRB interrupt status ahead of
write pointer access ensures that this condition is avoided.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
Signed-off-by: Viswanath L <viswanathl@nvidia.com>
---
 sound/pci/hda/hda_controller.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 9757667..2609e39 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1110,16 +1110,23 @@ irqreturn_t azx_interrupt(int irq, void *dev_id)
 		if (snd_hdac_bus_handle_stream_irq(bus, status, stream_update))
 			active = true;
 
-		/* clear rirb int */
 		status = azx_readb(chip, RIRBSTS);
 		if (status & RIRB_INT_MASK) {
+			/*
+			 * Clearing the interrupt status here ensures that no
+			 * interrupt gets masked after the RIRB wp is read in
+			 * snd_hdac_bus_update_rirb. This avoids a possible
+			 * race condition where codec response in RIRB may
+			 * remain unserviced by IRQ, eventually falling back
+			 * to polling mode in azx_rirb_get_response.
+			 */
+			azx_writeb(chip, RIRBSTS, RIRB_INT_MASK);
 			active = true;
 			if (status & RIRB_INT_RESPONSE) {
 				if (chip->driver_caps & AZX_DCAPS_CTX_WORKAROUND)
 					udelay(80);
 				snd_hdac_bus_update_rirb(bus);
 			}
-			azx_writeb(chip, RIRBSTS, RIRB_INT_MASK);
 		}
 	} while (active && ++repeat < 10);
 
-- 
2.7.4

