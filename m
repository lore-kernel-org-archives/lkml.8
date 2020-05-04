Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97188C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 713D62075E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615180;
	bh=yaSrsYE0N5KSzZ1Mxd8AqBPhY+jnZZhzXAsJHLQEezc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dYJmpI7VWL9B2K/4EGRSJo60Z0e/lX37uOrvliT9SULyFr/sihhLsfqpnCQ/b4d5D
	 qwD6R7kuk1qkqUYDO5chEhYXiGqY6tcZSMjzLRb7mIUPAZ2doILsCKnhwmOMO1zVjf
	 Vl4Ok341FW6Kyo7VKtzgz14EYv3dZRJVDlXcVEKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbgEDR7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:59:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730826AbgEDR7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:59:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 917432075E;
        Mon,  4 May 2020 17:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615175;
        bh=yaSrsYE0N5KSzZ1Mxd8AqBPhY+jnZZhzXAsJHLQEezc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9N+UTSkZR4nXeweAmlkdYLBcN1YVfno1bL1VoAbmL4rL9mAEg0jxOH1bhGLnz/J+
         dSIGvqaedrafzEDSI8b3HkMp/o0xQZQOH0Mvj3dWddUjlK9GS29aP6T6o1KgkqdxNw
         SbY16cKkQv9l/djyNESnYkv4QQGfkF/LIiCe85s8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>
Subject: [PATCH 4.9 02/18] drm/edid: Fix off-by-one in DispID DTD pixel clock
Date:   Mon,  4 May 2020 19:57:12 +0200
Message-Id: <20200504165442.510359901@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165442.028485341@linuxfoundation.org>
References: <20200504165442.028485341@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 6292b8efe32e6be408af364132f09572aed14382 upstream.

The DispID DTD pixel clock is documented as:
"00 00 00 h → FF FF FF h | Pixel clock ÷ 10,000 0.01 → 167,772.16 Mega Pixels per Sec"
Which seems to imply that we to add one to the raw value.

Reality seems to agree as there are tiled displays in the wild
which currently show a 10kHz difference in the pixel clock
between the tiles (one tile gets its mode from the base EDID,
the other from the DispID block).

Cc: stable@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200423151743.18767-1-ville.syrjala@linux.intel.com
Reviewed-by: Manasi Navare <manasi.d.navare@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_edid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3970,7 +3970,7 @@ static struct drm_display_mode *drm_mode
 	struct drm_display_mode *mode;
 	unsigned pixel_clock = (timings->pixel_clock[0] |
 				(timings->pixel_clock[1] << 8) |
-				(timings->pixel_clock[2] << 16));
+				(timings->pixel_clock[2] << 16)) + 1;
 	unsigned hactive = (timings->hactive[0] | timings->hactive[1] << 8) + 1;
 	unsigned hblank = (timings->hblank[0] | timings->hblank[1] << 8) + 1;
 	unsigned hsync = (timings->hsync[0] | (timings->hsync[1] & 0x7f) << 8) + 1;


