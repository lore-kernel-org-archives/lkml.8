Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0970FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D849C2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJQOHjqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgGIK2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgGIK2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:28:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0067AC061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:28:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 207so845348pfu.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 03:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GE6EabJkdfi5MecFWD1y4WWbwgp6Pb6ICJCDMYOyPdI=;
        b=YJQOHjqhzWy3Bqw4FCoUTeBdFRj8dGdT26NMtcdhZmOO78e1SzIEz3f8bbehdXgCiL
         QSop/wWeM375llO+5HT3WaOrvvWlopkqdylB1FJwS0ZoX1M47/uv6VlSyjKg2QNxZwCm
         9SxhgprMFzXtZMyxDJc6FgUuO3uWnLIzaMLy3x5EO/J2yFbX5kqO3PvQ5XcUMYXm9Yt7
         X3PCGeyTo4oF1Skr5v+KHfSn0CnjJoCG5LI+WKCI7G+afe0kEEzgnkVembpVTUBZAcZ1
         lHlY6Ufi8corpwQqQkhzjrubIe8BWenDcvVgVvyckTRCS2Xsk1CCEabfVRnfsknm3bKq
         SpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GE6EabJkdfi5MecFWD1y4WWbwgp6Pb6ICJCDMYOyPdI=;
        b=Wz65tvUx8cYcU/nfmT8vDPugtOtprQXyaLbu+x8yUWPGy7lVstqAJvNoDGIDVsWQyX
         TNWjwHChDBfflw+cNuDLXWndIJXZyztuTocI32Kdnts0gU1ksHu3sW9A57caet7cxWKq
         wvN+5Mpt0oo7a2oInDxHXPmkqKyO2yJd4MT1Vp5h6qUBqmkivGIPMBg5yw915Yvc/JmL
         zwhesYVgGfVMs9MPYKu0+GjAqyb1lmwxahA+LmkfMS0MXpv+5/shvFR4QR5y+698C09q
         CVtVy9LumDlcPUaFC4alAShPr9hwzJU/6yitXRnjBMTfpFDuHKdSfdCcqIKQmiLbmQDu
         8eKw==
X-Gm-Message-State: AOAM532crQ/YZ/+ywCXEZO5edBSm1C2AKCCAvfQkzrJDpiap7PXLmYzE
        2nWsN/oPkRq0lv1aj58vqzw=
X-Google-Smtp-Source: ABdhPJy1feaXOjJ2LM06j2vDOnooBTXz9EhzkWFBL16lFF5z45AgGc9Ujpss3f/XXJats39EVIZyUA==
X-Received: by 2002:a63:8c5d:: with SMTP id q29mr52019061pgn.249.1594290514467;
        Thu, 09 Jul 2020 03:28:34 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.54.40])
        by smtp.googlemail.com with ESMTPSA id y8sm2125163pju.49.2020.07.09.03.28.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 03:28:34 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4 7/7] drivers: staging: audio: Fix the missing header file for helper file
Date:   Thu,  9 Jul 2020 15:57:23 +0530
Message-Id: <6341df9b0b5985047af0bbbc8e136481ac515b25.1594290158.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594290158.git.vaibhav.sr@gmail.com>
References: <cover.1594290158.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the warning reported for missing prototypes due to
missing header file. Also, it includes changes to remove
unused_but_set_variables.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
---
 drivers/staging/greybus/audio_helper.c   | 1 +
 drivers/staging/greybus/audio_topology.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
index faaa39708118..8b100a71f02e 100644
--- a/drivers/staging/greybus/audio_helper.c
+++ b/drivers/staging/greybus/audio_helper.c
@@ -7,6 +7,7 @@
 #include <sound/core.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include "audio_helper.h"
 
 #define gbaudio_dapm_for_each_direction(dir) \
 	for ((dir) = SND_SOC_DAPM_DIR_IN; (dir) <= SND_SOC_DAPM_DIR_OUT; \
diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index ad88d3127a60..2f9fdbdcd547 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -28,14 +28,16 @@ static struct gbaudio_module_info *find_gb_module(
 					struct gbaudio_codec_info *codec,
 					char const *name)
 {
-	int dev_id, ret;
+	int dev_id;
 	char begin[NAME_SIZE];
 	struct gbaudio_module_info *module;
 
 	if (!name)
 		return NULL;
 
-	ret = sscanf(name, "%s %d", begin, &dev_id);
+	if (sscanf(name, "%s %d", begin, &dev_id) != 2)
+		return NULL;
+
 	dev_dbg(codec->dev, "%s:Find module#%d\n", __func__, dev_id);
 
 	mutex_lock(&codec->lock);
@@ -377,7 +379,6 @@ static int gbcodec_mixer_dapm_ctl_get(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
 {
 	int ret;
-	struct gb_audio_ctl_elem_info *info;
 	struct gbaudio_ctl_pvt *data;
 	struct gb_audio_ctl_elem_value gbvalue;
 	struct gbaudio_module_info *module;
@@ -393,7 +394,6 @@ static int gbcodec_mixer_dapm_ctl_get(struct snd_kcontrol *kcontrol,
 		return -EINVAL;
 
 	data = (struct gbaudio_ctl_pvt *)kcontrol->private_value;
-	info = (struct gb_audio_ctl_elem_info *)data->info;
 	bundle = to_gb_bundle(module->dev);
 
 	if (data->vcount == 2)
-- 
2.27.0

