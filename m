Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315C2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 012E620756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6ieZxkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgEUUrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:47:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52517 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726858AbgEUUrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590094024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZCbHVU++ADvqtlwI3liORSZGCKRYFsaHclPVH+arJhU=;
        b=a6ieZxkDXHsjGi0QQxdCHtjtestv2d/lYYQvqDwTPiZQxEgaG6rd6LB6+neVAczHZ4DCc+
        3c03EWPgNanoOHgFEkFSNAkc4rfMrNSK9rHDv03fjvgElLFeFVo3h/cNzXgHvza5fq3r8q
        OzDSvr1KF64IVYbMWvY+A4KwP/DfI8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-gzgkwDQFMVKsC_RoQwr3Ew-1; Thu, 21 May 2020 16:47:00 -0400
X-MC-Unique: gzgkwDQFMVKsC_RoQwr3Ew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7559918FE860;
        Thu, 21 May 2020 20:46:58 +0000 (UTC)
Received: from Whitewolf.redhat.com (ovpn-116-188.rdu2.redhat.com [10.10.116.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C97B56ED80;
        Thu, 21 May 2020 20:46:56 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vblank: Fix -Wformat compile warnings on some arches
Date:   Thu, 21 May 2020 16:46:47 -0400
Message-Id: <20200521204647.2578479-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some architectures like ppc64le and aarch64, compiling with
-Wformat=1 will throw the following warnings:

  In file included from drivers/gpu/drm/drm_vblank.c:33:
  drivers/gpu/drm/drm_vblank.c: In function 'drm_update_vblank_count':
  drivers/gpu/drm/drm_vblank.c:273:16: warning: format '%llu' expects
  argument of type 'long long unsigned int', but argument 4 has type
  'long int' [-Wformat=]
    DRM_DEBUG_VBL("updating vblank count on crtc %u:"
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/drm/drm_print.h:407:22: note: in definition of macro
  'DRM_DEBUG_VBL'
    drm_dbg(DRM_UT_VBL, fmt, ##__VA_ARGS__)
                        ^~~
  drivers/gpu/drm/drm_vblank.c:274:22: note: format string is defined here
           " current=%llu, diff=%u, hw=%u hw_last=%u\n",
                     ~~~^
                     %lu

So, fix that with a typecast.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Co-developed-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/drm_vblank.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index acb3c3f65b579..1a96db2dd16fa 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -342,7 +342,7 @@ static void drm_update_vblank_count(struct drm_device *dev, unsigned int pipe,
 
 	DRM_DEBUG_VBL("updating vblank count on crtc %u:"
 		      " current=%llu, diff=%u, hw=%u hw_last=%u\n",
-		      pipe, atomic64_read(&vblank->count), diff,
+		      pipe, (unsigned long long)atomic64_read(&vblank->count), diff,
 		      cur_vblank, vblank->last);
 
 	if (diff == 0) {
-- 
2.26.2

