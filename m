Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999C7C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 03:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 780B0206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 03:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgEEDEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 23:04:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59166 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgEEDEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 23:04:32 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jVnsJ-0003LT-4I; Tue, 05 May 2020 03:04:03 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Evan Green <evgreen@chromium.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] ALSA: hda: Use dev_to_hdac_dev macro
Date:   Tue,  5 May 2020 11:03:52 +0800
Message-Id: <20200505030357.28004-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_to_hdac_dev() instead of container_of().

No functional change intended.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/hda/ext/hdac_ext_bus.c | 2 +-
 sound/hda/hdac_device.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 73bfa71845f6..d0a604c939df 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -62,7 +62,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_exit);
 
 static void default_release(struct device *dev)
 {
-	snd_hdac_ext_bus_device_exit(container_of(dev, struct hdac_device, dev));
+	snd_hdac_ext_bus_device_exit(dev_to_hdac_dev(dev));
 }
 
 /**
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index e3119f5cb0d5..333220f0f8af 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -20,7 +20,7 @@ static int get_codec_vendor_name(struct hdac_device *codec);
 
 static void default_release(struct device *dev)
 {
-	snd_hdac_device_exit(container_of(dev, struct hdac_device, dev));
+	snd_hdac_device_exit(dev_to_hdac_dev(dev));
 }
 
 /**
-- 
2.17.1

