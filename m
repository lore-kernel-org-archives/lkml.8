Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757ACC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CEE1206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 13:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgHJNbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 09:31:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60556 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgHJNba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 09:31:30 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k57tQ-000489-AE; Mon, 10 Aug 2020 13:31:12 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Andrew Oakley <andrew@adoakley.name>,
        Chris Boyle <chris@boyle.name>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: usb-audio: Disable Lenovo P620 Rear line-in volume control
Date:   Mon, 10 Aug 2020 21:31:06 +0800
Message-Id: <20200810133108.31580-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB device (0x17aa:0x1046) that support Lenovo P620 rear panel
line-in claim to support volume control, but it doens't seem to have an
AMP, so when line-in volume lowers below 80, nothing gets recorded
anymore.

Disable the volume control to workaround the issue.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/usb/mixer_maps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index c369c81e74c4..5b43e9e40e49 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -371,6 +371,7 @@ static const struct usbmix_name_map asus_rog_map[] = {
 };
 
 static const struct usbmix_name_map lenovo_p620_rear_map[] = {
+	{ 19, NULL, 2 }, /* FU, Volume */
 	{ 19, NULL, 12 }, /* FU, Input Gain Pad */
 	{}
 };
-- 
2.17.1

