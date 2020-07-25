Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08C3C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 04:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E38620786
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 04:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgGYECE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 00:02:04 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:54728 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgGYECE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 00:02:04 -0400
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 11EEEEC493;
        Sat, 25 Jul 2020 12:01:58 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [111.204.108.116])
        by smtp.263.net (postfix) whith ESMTP id P5979T140275804518144S1595649718262681_;
        Sat, 25 Jul 2020 12:01:58 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8979ef735d1a662965749e452507493a>
X-RL-SENDER: penghao@uniontech.com
X-SENDER: penghao@uniontech.com
X-LOGIN-NAME: penghao@uniontech.com
X-FST-TO: perex@perex.cz
X-SENDER-IP: 111.204.108.116
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   penghao <penghao@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com, gregkh@linuxfoundation.org,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, phz0008@163.com,
        penghao@uniontech.com, "penghao@deepin.com" <penghao@deepin.com>
Subject: [PATCH 14216/14216] ALSA: usb-audio: This patch for prevent auto wakeup from s3 trig by usb disconnect signal from Lenovo Thinkcentre TI024Gen3  USB-audio.
Date:   Sat, 25 Jul 2020 12:01:55 +0800
Message-Id: <20200725040155.27648-1-penghao@uniontech.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "penghao@deepin.com" <penghao@deepin.com>

 TI024Gen3 USB-audio is controlled by TI024Gen3,when TI024Gens
 enter sleep mode, USB-audio will disconnect from USB bus port,
 so disabled the /sys/bus/usb/*/power/wakeup Fixesimmediately
 wakup form s3 state

Signed-off-by: penghao@uniontech.com <penghao@uniontech.com>
Signed-off-by: penghao@deepin.com <penghao@deepin.com>
---
 sound/usb/card.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 2644a5ae2b75..969c3809e051 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -640,6 +640,12 @@ static int usb_audio_probe(struct usb_interface *intf,
 		}
 	}
 	dev_set_drvdata(&dev->dev, chip);
+	/*
+	 * ALSA: usb-audio: Add prevent wakeup from s3 state trig by lenovo
+	 * ThinkCentre TI024Gen3 USB-audio
+	 */
+	if ((usb_id->idVendor == 0x17ef) && (usb_id->idProduct == 0xa012))
+		device_set_wakeup_enable(&dev->dev, 0);
 
 	/*
 	 * For devices with more than one control interface, we assume the
@@ -914,3 +920,4 @@ static struct usb_driver usb_audio_driver = {
 };
 
 module_usb_driver(usb_audio_driver);
+
-- 
2.11.0



