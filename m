Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7C9C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A9724677
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 07:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="BhLncz8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgCJHni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 03:43:38 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:17834 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgCJHnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 03:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1583826213;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=Dn5GFcmLByBrDK1f5aOSRQMAAq+2DgMtrNwOlwS3U+8=;
        b=BhLncz8XHsOe7d4GMDYTVyOkQNuflkhiQuA2+zMdp9fUZrpd7iDJPvjSQhccNv66hv
        2hOJU/6vJby1Bv8pi/0RkYSWRDBqfHkPckIylDAGq92kg50gJYXmO2+qRlmo0tjGZ5/E
        Jkc9MuAa+1JcFDoYo/09H4QnogcmaMWQR85jcREViRqWZpcnW8U7wuec3+c2YXFfK5TH
        jSWQqaklSCHGL4xUlyOm752PT/KhVEV9ldqOBZHMcE4iaduEuy9oRf0ZQVQpsYsuUtf5
        6hphIE8gT8UOrKbKPj5U3l/RlBwzdlGGtfVclPfOBLXWgILmFZUbjM17JvtrkBeOauba
        jeLQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH4GJ9t5w=="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.2.0 DYNA|AUTH)
        with ESMTPSA id y0a02cw2A7hJmUL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 10 Mar 2020 08:43:19 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Ville Syrjala <ville.syrjala@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] drm/panel-simple: Fix dotclock for Ortustech COM37H3M
Date:   Tue, 10 Mar 2020 08:43:19 +0100
Message-Id: <e63a0533ad5b5142373437ef758aedbdb716152d.1583826198.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The currently listed dotclock disagrees with the currently
listed vrefresh rate. Change the dotclock to match the vrefresh.

There are two variants of the COM37H3M panel.
The older one's COM37H3M05DTC data sheet specifies:

                         MIN      TYP     MAX
CLK frequency    fCLK     --       22.4    26.3 MHz (in VGA mode)
VSYNC Frequency  fVSYNC   54       60      66   Hz
VSYNC cycle time tv       --      650      --   H
HSYNC frequency  fHSYNC   --       39.3    --   kHz
HSYNC cycle time th       --      570      --   CLK

The newer one's COM37H3M99DTC data sheet says:

                         MIN      TYP     MAX
CLK frequency    fCLK     18       19.8    27   MHz
VSYNC Frequency  fVSYNC   54       60      66   Hz
VSYNC cycle time tv      646      650     700   H
HSYNC frequency  fHSYNC  --        39.0    50.0 kHz
HSYNC cycle time th      504      508     630   CLK

So we choose a parameter set that lies within the specs
of both variants. We start at .vrefresh = 60,
choose .htotal = 570 and .vtotal = 650 and end up
in a clock of 22.230 MHz.

Reported-by: Ville Syrjala <ville.syrjala@linux.intel.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index e14c14ac62b5..b4cb23d4898d 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2390,15 +2390,15 @@ static const struct panel_desc ontat_yx700wv03 = {
 };
 
 static const struct drm_display_mode ortustech_com37h3m_mode  = {
-	.clock = 22153,
+	.clock = 22230,
 	.hdisplay = 480,
-	.hsync_start = 480 + 8,
-	.hsync_end = 480 + 8 + 10,
-	.htotal = 480 + 8 + 10 + 10,
+	.hsync_start = 480 + 40,
+	.hsync_end = 480 + 40 + 10,
+	.htotal = 480 + 40 + 10 + 40,
 	.vdisplay = 640,
 	.vsync_start = 640 + 4,
-	.vsync_end = 640 + 4 + 3,
-	.vtotal = 640 + 4 + 3 + 4,
+	.vsync_end = 640 + 4 + 2,
+	.vtotal = 640 + 4 + 2 + 4,
 	.vrefresh = 60,
 	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
 };
-- 
2.23.0

