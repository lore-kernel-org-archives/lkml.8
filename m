Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4599C761A1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783BE24656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fRDY4Kkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgBTGWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:22:46 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52264 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgBTGWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:22:46 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep11so431415pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4HmaMrg/A0ePGN0EoT7LOXLlO0HcR/QAQGKc66IQiBw=;
        b=fRDY4KkruK7J3WvWuRYCMBR/HFq68axyRau9YhW75xxf3hmvY0zQZh0pHSJdxCvJX7
         OQMw9MatyxS8oE7/oWzN1VFUJ+cdS3Iy4OW3bcuoCgn4/ByJ9PNnV6JA7ZyFauySNe/A
         SAhzTtQ7YoXLrfvYJSrfL6HXeiIm/S7OEWuQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4HmaMrg/A0ePGN0EoT7LOXLlO0HcR/QAQGKc66IQiBw=;
        b=cnK78+1LOaI2lhUjWmANTEsLrL13VhawnZPzINyrmRpxMNk/JWBN7OFByGaxNf4OBz
         EPPx9oRg9ZkSsqX00BpmOtGeJzynGF376ougmAlw6WghK3HP0Go+t1e52vkOa6dsylN+
         J9Rrs/lptksDCHVmd3mM/+qZya5l9x2aeGHv0UbKEKwN//Yq+kjiQz7ec3X/rL01IuW0
         0jtiUwhIqilw+Q7SdNlnTLEAUwSeIOSHCtczum003ovP3WE+wO02jTT5gz90pNSoMMba
         DY6gahTjUp0KsdnoZE8z5rbHpsvA8GjyjCgKtc2olDNz/AqcByaiAU1m0rDmLVX35Jge
         HEBg==
X-Gm-Message-State: APjAAAUEp94npWaKjJvblmdEJ+D3D3TGMmDj4qrPgG10Ge2aLGU5toTG
        wyaaAnoWHoYYcrtDP2umF/Jlzw==
X-Google-Smtp-Source: APXvYqzUBh4ei9Kl84PAl7GiBD2O/P0w5AgGuNUUZTL7tvsylTFtzNcyGxmNyNSGpG+A0WeGLDo+4A==
X-Received: by 2002:a17:90a:348a:: with SMTP id p10mr1787055pjb.120.1582179765345;
        Wed, 19 Feb 2020 22:22:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k2sm1836863pgk.84.2020.02.19.22.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 22:22:44 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/edid: Distribute switch variables for initialization
Date:   Wed, 19 Feb 2020 22:22:29 -0800
Message-Id: <20200220062229.68762-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables declared in a switch statement before any case statements
cannot be automatically initialized with compiler instrumentation (as
they are not part of any execution flow). With GCC's proposed automatic
stack variable initialization feature, this triggers a warning (and they
don't get initialized). Clang's automatic stack variable initialization
(via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
doesn't initialize such variables[1]. Note that these warnings (or silent
skipping) happen before the dead-store elimination optimization phase,
so even when the automatic initializations are later elided in favor of
direct initializations, the warnings remain.

To avoid these problems, move such variables into the "case" where
they're used or lift them up into the main function body.

drivers/gpu/drm/drm_edid.c: In function ‘drm_edid_to_eld’:
drivers/gpu/drm/drm_edid.c:4395:9: warning: statement will never be executed [-Wswitch-unreachable]
 4395 |     int sad_count;
      |         ^~~~~~~~~

[1] https://bugs.llvm.org/show_bug.cgi?id=44916

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/drm_edid.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 805fb004c8eb..2941b65b427f 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -4392,9 +4392,9 @@ static void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
 			dbl = cea_db_payload_len(db);
 
 			switch (cea_db_tag(db)) {
-				int sad_count;
+			case AUDIO_BLOCK: {
 
-			case AUDIO_BLOCK:
+				int sad_count;
 				/* Audio Data Block, contains SADs */
 				sad_count = min(dbl / 3, 15 - total_sad_count);
 				if (sad_count >= 1)
@@ -4402,6 +4402,7 @@ static void drm_edid_to_eld(struct drm_connector *connector, struct edid *edid)
 					       &db[1], sad_count * 3);
 				total_sad_count += sad_count;
 				break;
+			}
 			case SPEAKER_BLOCK:
 				/* Speaker Allocation Data Block */
 				if (dbl >= 1)

