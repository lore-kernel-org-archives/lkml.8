Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220EDC433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC6222CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgGSROk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 13:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgGSROj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:14:39 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668F9C0619D2;
        Sun, 19 Jul 2020 10:14:39 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 4198DBC085;
        Sun, 19 Jul 2020 17:14:35 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        corbet@lwn.net, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH for v5.9] drm: Replace HTTP links with HTTPS ones
Date:   Sun, 19 Jul 2020 19:14:28 +0200
Message-Id: <20200719171428.60470-1-grandmaster@al2klimov.de>
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

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
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


 Documentation/gpu/vgaarbiter.rst | 8 ++++----
 drivers/gpu/drm/drm_modes.c      | 2 +-
 include/uapi/drm/drm_mode.h      | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/gpu/vgaarbiter.rst b/Documentation/gpu/vgaarbiter.rst
index 0b41b051d021..339ed5fecd2e 100644
--- a/Documentation/gpu/vgaarbiter.rst
+++ b/Documentation/gpu/vgaarbiter.rst
@@ -185,7 +185,7 @@ enhancing the kernel code to adapt as a kernel module and also did the
 implementation of the user space side [3]. Now (2009) Tiago Vignatti and Dave
 Airlie finally put this work in shape and queued to Jesse Barnes' PCI tree.
 
-0) http://cgit.freedesktop.org/xorg/xserver/commit/?id=4b42448a2388d40f257774fbffdccaea87bd0347
-1) http://lists.freedesktop.org/archives/xorg/2005-March/006663.html
-2) http://lists.freedesktop.org/archives/xorg/2005-March/006745.html
-3) http://lists.freedesktop.org/archives/xorg/2007-October/029507.html
+0) https://cgit.freedesktop.org/xorg/xserver/commit/?id=4b42448a2388d40f257774fbffdccaea87bd0347
+1) https://lists.freedesktop.org/archives/xorg/2005-March/006663.html
+2) https://lists.freedesktop.org/archives/xorg/2005-March/006745.html
+3) https://lists.freedesktop.org/archives/xorg/2007-October/029507.html
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index fec1c33b3045..f6f21a5507f4 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -548,7 +548,7 @@ EXPORT_SYMBOL(drm_gtf_mode_complex);
  * Generalized Timing Formula is derived from:
  *
  *	GTF Spreadsheet by Andy Morrish (1/5/97)
- *	available at http://www.vesa.org
+ *	available at https://www.vesa.org
  *
  * And it is copied from the file of xserver/hw/xfree86/modes/xf86gtf.c.
  * What I have done is to translate it by using integer calculation.
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 735c8cfdaaa1..deea447e5f22 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -497,7 +497,7 @@ struct drm_mode_fb_cmd2 {
 	 * In case of planar formats, this ioctl allows up to 4
 	 * buffer objects with offsets and pitches per plane.
 	 * The pitch and offset order is dictated by the fourcc,
-	 * e.g. NV12 (http://fourcc.org/yuv.php#NV12) is described as:
+	 * e.g. NV12 (https://fourcc.org/yuv.php#NV12) is described as:
 	 *
 	 *   YUV 4:2:0 image with a plane of 8 bit Y samples
 	 *   followed by an interleaved U/V plane containing
-- 
2.27.0

