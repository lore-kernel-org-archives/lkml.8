Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9F9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AF02072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgGMMtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:49:35 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:39906 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgGMMte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 08:49:34 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id BD155BC069;
        Mon, 13 Jul 2020 12:49:31 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     hdegoede@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] drm/vboxvideo: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 14:49:23 +0200
Message-Id: <20200713124923.34282-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely or at least not just HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 drivers/gpu/drm/vboxvideo/hgsmi_defs.h | 2 +-
 drivers/gpu/drm/vboxvideo/vbox_hgsmi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vboxvideo/hgsmi_defs.h b/drivers/gpu/drm/vboxvideo/hgsmi_defs.h
index 6c8df1cdb087..3cb52f2b2274 100644
--- a/drivers/gpu/drm/vboxvideo/hgsmi_defs.h
+++ b/drivers/gpu/drm/vboxvideo/hgsmi_defs.h
@@ -58,7 +58,7 @@ struct hgsmi_buffer_tail {
 	/* Reserved, must be initialized to 0. */
 	u32 reserved;
 	/*
-	 * One-at-a-Time Hash: http://www.burtleburtle.net/bob/hash/doobs.html
+	 * One-at-a-Time Hash: https://www.burtleburtle.net/bob/hash/doobs.html
 	 * Over the header, offset and for first 4 bytes of the tail.
 	 */
 	u32 checksum;
diff --git a/drivers/gpu/drm/vboxvideo/vbox_hgsmi.c b/drivers/gpu/drm/vboxvideo/vbox_hgsmi.c
index 94b60654a012..a9ca4d0c3eca 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_hgsmi.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_hgsmi.c
@@ -8,7 +8,7 @@
 #include "vboxvideo_vbe.h"
 #include "hgsmi_defs.h"
 
-/* One-at-a-Time Hash from http://www.burtleburtle.net/bob/hash/doobs.html */
+/* One-at-a-Time Hash from https://www.burtleburtle.net/bob/hash/doobs.html */
 static u32 hgsmi_hash_process(u32 hash, const u8 *data, int size)
 {
 	while (size--) {
-- 
2.27.0

