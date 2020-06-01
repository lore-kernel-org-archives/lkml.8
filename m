Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB2BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A6D206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591036825;
	bh=kl7MXkBZJGC6s8thZUM2YDAIP7k2Z9xNDyBuU/WLlk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h3MT17yRiPbe1+jCXt3rcM1u4SQunxNetWRdnsyq3EO15oYIgzaX5c1YKUdVlpKU1
	 22WNjqKmvEIWz29pp8NcMX62+RflaZcyYsPdFtWtNg211IXeaIYV2HobaHrwMGw1dR
	 f23a4TKhER4LETke1RfjvzbZWliy0RKdpDg+//xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgFASNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:13:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729979AbgFASNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:13:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F10D72065C;
        Mon,  1 Jun 2020 18:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035195;
        bh=kl7MXkBZJGC6s8thZUM2YDAIP7k2Z9xNDyBuU/WLlk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JQEt1lqodFoPmWtDo1SD94vXDwSh3gJxdLHsEn+gEvVlkZAd0GSc5xbcmiKh9GZb7
         8mt8Ib+9Ml4LlqPSCs6+EAXwldG5PzWnoCYCxw47xdUvMQHM/TGrKii3D5mQhuNc+5
         EYf7whVQP2iHI8qEmaWq0QY7iSpkeI1xrgKkt+78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Oakley <andrew@adoakley.name>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 052/177] ALSA: usb-audio: add mapping for ASRock TRX40 Creator
Date:   Mon,  1 Jun 2020 19:53:10 +0200
Message-Id: <20200601174053.387395537@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Oakley <andrew@adoakley.name>

[ Upstream commit da7a8f1a8fc3e14c6dcc52b4098bddb8f20390be ]

This is another TRX40 based motherboard with ALC1220-VB USB-audio
that requires a static mapping table.

This motherboard also has a PCI device which advertises no codecs.  The
PCI ID is 1022:1487 and PCI SSID is 1022:d102.  As this is using the AMD
vendor ID, don't blacklist for now in case other boards have a working
audio device with the same ssid.

alsa-info.sh report for this board:
http://alsa-project.org/db/?f=0a742f89066527497b77ce16bca486daccf8a70c

Signed-off-by: Andrew Oakley <andrew@adoakley.name>
Link: https://lore.kernel.org/r/20200503141639.35519-1-andrew@adoakley.name
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer_maps.c   | 5 +++++
 sound/usb/quirks-table.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 0260c750e156..bfdc6ad52785 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -549,6 +549,11 @@ static const struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.map = trx40_mobo_map,
 		.connector_map = trx40_mobo_connector_map,
 	},
+	{	/* Asrock TRX40 Creator */
+		.id = USB_ID(0x26ce, 0x0a01),
+		.map = trx40_mobo_map,
+		.connector_map = trx40_mobo_connector_map,
+	},
 	{ 0 } /* terminator */
 };
 
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 8c2f5c23e1b4..aa4c16ce0e57 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3647,6 +3647,7 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q"),
 ALC1220_VB_DESKTOP(0x0414, 0xa002), /* Gigabyte TRX40 Aorus Pro WiFi */
 ALC1220_VB_DESKTOP(0x0db0, 0x0d64), /* MSI TRX40 Creator */
 ALC1220_VB_DESKTOP(0x0db0, 0x543d), /* MSI TRX40 */
+ALC1220_VB_DESKTOP(0x26ce, 0x0a01), /* Asrock TRX40 Creator */
 #undef ALC1220_VB_DESKTOP
 
 #undef USB_DEVICE_VENDOR_SPEC
-- 
2.25.1



