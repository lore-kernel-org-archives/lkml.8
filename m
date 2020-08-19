Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADAAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0657A2072D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgHSL6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:58:36 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:60294 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbgHSL6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:58:31 -0400
Received: from localhost (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id 6F6EF153C;
        Wed, 19 Aug 2020 19:58:04 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from localhost.localdomain (250.19.126.124.broad.bjtelecom.net [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P9873T140063715358464S1597838284065216_;
        Wed, 19 Aug 2020 19:58:04 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e53548ead706dc6b484bfeb14e7bcb0e>
X-RL-SENDER: penghao@uniontech.com
X-SENDER: penghao@uniontech.com
X-LOGIN-NAME: penghao@uniontech.com
X-FST-TO: perex@perex.cz
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 5
X-System-Flag: 0
From:   penghao <penghao@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alexander@tsoy.me, dan.carpenter@oracle.com, crwulff@gmail.com,
        penghao@uniontech.com, gustavoars@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Add prevent wakeup from s3 state trig by Lenovo ThinkCentre TI024Gen3 USB-audio
Date:   Wed, 19 Aug 2020 19:57:57 +0800
Message-Id: <20200819115757.23168-1-penghao@uniontech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI024Gen3 USB-audio is controlled by TI024Gen3,when TI024Gens
enter sleep mode, USB-audio will disconnect from USB bus port,
wakup form s3 state

Signed-off-by: penghao <penghao@uniontech.com>
---
 sound/usb/card.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 696e788c5d31..6bdbb34009b3 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -658,6 +658,12 @@ static int usb_audio_probe(struct usb_interface *intf,
 	}
 
 	dev_set_drvdata(&dev->dev, chip);
+	/*
+	 *ALSA: usb-audio: Add prevent wakeup from s3 state trig by Lenovo
+	 *ThinkCentre TI024Gen3 usb-audio
+	 */
+	if ((usb_id->idVendor == 0x17ef) && (usb_id->idProduct == 0xa012))
+		device_set_wakeup_enable(＆dev->dev, 0);
 
 	/*
 	 * For devices with more than one control interface, we assume the
-- 
2.11.0



