Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AD1C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB5FD2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OySoCssi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgGTU5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:57:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37032 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726016AbgGTU5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595278641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=epckH3RTrZi5cYmGZDu/11K+cHm6x4vqJk8JLUqbk84=;
        b=OySoCssiNUJN2lokcX4uw+3ffBDRlYscWutpVvIIuFfY3Ft75kvY6dyi7WJh96Gg4AmYK5
        Dvp78Kwy8UD2MvR8AhEXPydZk0RUWU/As/cpPCDv1Pr0Kx31l/bqDVx3Gpa1b4Dbc9Puhv
        gGvzd9eThM3jlwSKwlI5/FBRoS2UZgs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-09bg8cUrNASZmwx-EKBX9g-1; Mon, 20 Jul 2020 16:57:19 -0400
X-MC-Unique: 09bg8cUrNASZmwx-EKBX9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB984107ACCA;
        Mon, 20 Jul 2020 20:57:17 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-120-196.rdu2.redhat.com [10.10.120.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1109076216;
        Mon, 20 Jul 2020 20:57:16 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     kernel test robot <lkp@intel.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA
        GEFORCE/QUADRO GPUS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/nouveau/kms/nv50-: Fix CRC-related compile errors with debugfs disabled
Date:   Mon, 20 Jul 2020 16:56:56 -0400
Message-Id: <20200720205659.296879-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like I made the mistake of forgetting to check whether or not this
would build without CONFIG_DEBUG_FS, as the Kbuild bot reported some
issues building with tegra_defconfig:

In file included from drivers/gpu/drm/nouveau/nouveau_display.c:47:
./drivers/gpu/drm/nouveau/dispnv50/crc.h: In function
‘nv50_head_crc_late_register’:
./drivers/gpu/drm/nouveau/dispnv50/crc.h:106:47: error: parameter name
omitted
  106 | static inline int nv50_head_crc_late_register(struct nv50_head *) {}
      |                                               ^~~~~~~~~~~~~~~~~~
./drivers/gpu/drm/nouveau/dispnv50/crc.h:106:54: warning: no return
statement in function returning non-void [-Wreturn-type]
  106 | static inline int nv50_head_crc_late_register(struct nv50_head *) {}
      |                                                      ^~~~~~~~~
./drivers/gpu/drm/nouveau/dispnv50/crc.h: In function
‘nv50_crc_handle_vblank’:
./drivers/gpu/drm/nouveau/dispnv50/crc.h:108:57: warning: ‘return’ with
a value, in function returning void [-Wreturn-type]
  108 | nv50_crc_handle_vblank(struct nv50_head *head) { return 0; }
      |                                                         ^
./drivers/gpu/drm/nouveau/dispnv50/crc.h:108:1: note: declared here
  108 | nv50_crc_handle_vblank(struct nv50_head *head) { return 0; }
      | ^~~~~~~~~~~~~~~~~~~~~~
./drivers/gpu/drm/nouveau/dispnv50/crc.h: In function
‘nv50_crc_atomic_check’:
./drivers/gpu/drm/nouveau/dispnv50/crc.h:111:23: error: parameter name
omitted
  111 | nv50_crc_atomic_check(struct nv50_head *, struct nv50_head_atom *,
      |                       ^~~~~~~~~~~~~~~~~~
./drivers/gpu/drm/nouveau/dispnv50/crc.h:111:43: error: parameter name
omitted
  111 | nv50_crc_atomic_check(struct nv50_head *, struct nv50_head_atom *,
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~
./drivers/gpu/drm/nouveau/dispnv50/crc.h:112:9: error: parameter name
omitted
  112 |         struct nv50_head_atom *) {}
      |         ^~~~~~~~~~~~~~~~~~~~~~~
./drivers/gpu/drm/nouveau/dispnv50/crc.h:112:16: warning: no return
statement in function returning non-void [-Wreturn-type]
  112 |         struct nv50_head_atom *) {}
      |                ^~~~~~~~~~~~~~
./drivers/gpu/drm/nouveau/dispnv50/crc.h: In function
‘nv50_crc_atomic_stop_reporting’:
./drivers/gpu/drm/nouveau/dispnv50/crc.h:114:32: error: parameter name
omitted
  114 | nv50_crc_atomic_stop_reporting(struct drm_atomic_state *) {}
      |                                ^~~~~~~~~~~~~~~~~~~~~~~~~
./drivers/gpu/drm/nouveau/dispnv50/crc.h: In function
‘nv50_crc_atomic_prepare_notifier_contexts’:
./drivers/gpu/drm/nouveau/dispnv50/crc.h:116:43: error: parameter name
omitted
  116 | nv50_crc_atomic_prepare_notifier_contexts(struct drm_atomic_state *) {}
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
./drivers/gpu/drm/nouveau/dispnv50/crc.h: In function
‘nv50_crc_atomic_start_reporting’:
./drivers/gpu/drm/nouveau/dispnv50/crc.h:118:33: error: parameter name
omitted
  118 | nv50_crc_atomic_start_reporting(struct drm_atomic_state *) {}
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
./drivers/gpu/drm/nouveau/dispnv50/crc.h: In function
‘nv50_crc_atomic_set’:
./drivers/gpu/drm/nouveau/dispnv50/crc.h:120:21: error: parameter name
omitted
  120 | nv50_crc_atomic_set(struct nv50_head *, struct nv50_head_atom *) {}
      |                     ^~~~~~~~~~~~~~~~~~
./drivers/gpu/drm/nouveau/dispnv50/crc.h:120:41: error: parameter name
omitted
  120 | nv50_crc_atomic_set(struct nv50_head *, struct nv50_head_atom *) {}
      |                                         ^~~~~~~~~~~~~~~~~~~~~~~
./drivers/gpu/drm/nouveau/dispnv50/crc.h: In function
‘nv50_crc_atomic_clr’:
./drivers/gpu/drm/nouveau/dispnv50/crc.h:122:21: error: parameter name
omitted
  122 | nv50_crc_atomic_clr(struct nv50_head *) {}
      |                     ^~~~~~~~~~~~~~~~~~
drivers/gpu/drm/nouveau/nouveau_display.c: In function
‘nouveau_framebuffer_new’:
drivers/gpu/drm/nouveau/nouveau_display.c:286:15: warning: variable
‘width’ set but not used [-Wunused-but-set-variable]
  286 |  unsigned int width, height, i;
      |               ^~~~~

So, fix the inline function declarations we use in
drm/drivers/gpu/drm/nouveau/dispnv50/crc.h when CONFIG_DEBUG_FS is
enabled.

Fixes: 12885ecbfe62 ("drm/nouveau/kms/nvd9-: Add CRC support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/crc.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/crc.h b/drivers/gpu/drm/nouveau/dispnv50/crc.h
index 4bc59e7793151..92df084492a8c 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/crc.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/crc.h
@@ -106,26 +106,27 @@ struct nv50_crc_atom {};
 #define nv50_crc_set_source NULL
 
 static inline void nv50_crc_init(struct drm_device *dev) {}
-static inline int nv50_head_crc_late_register(struct nv50_head *) {}
-static inline void
-nv50_crc_handle_vblank(struct nv50_head *head) { return 0; }
+static inline int
+nv50_head_crc_late_register(struct nv50_head *head) { return 0; }
+static inline void nv50_crc_handle_vblank(struct nv50_head *head) {}
 
 static inline int
-nv50_crc_atomic_check_head(struct nv50_head *, struct nv50_head_atom *,
-			   struct nv50_head_atom *) {}
+nv50_crc_atomic_check_head(struct nv50_head *head,
+			   struct nv50_head_atom *asyh,
+			   struct nv50_head_atom *armh) { return 0; }
 static inline void nv50_crc_atomic_check_outp(struct nv50_atom *atom) {}
 static inline void
-nv50_crc_atomic_stop_reporting(struct drm_atomic_state *) {}
+nv50_crc_atomic_stop_reporting(struct drm_atomic_state *state) {}
 static inline void
-nv50_crc_atomic_init_notifier_contexts(struct drm_atomic_state *) {}
+nv50_crc_atomic_init_notifier_contexts(struct drm_atomic_state *state) {}
 static inline void
-nv50_crc_atomic_release_notifier_contexts(struct drm_atomic_state *) {}
+nv50_crc_atomic_release_notifier_contexts(struct drm_atomic_state *state) {}
 static inline void
-nv50_crc_atomic_start_reporting(struct drm_atomic_state *) {}
+nv50_crc_atomic_start_reporting(struct drm_atomic_state *state) {}
 static inline void
-nv50_crc_atomic_set(struct nv50_head *, struct nv50_head_atom *) {}
+nv50_crc_atomic_set(struct nv50_head *head, struct nv50_head_atom *state) {}
 static inline void
-nv50_crc_atomic_clr(struct nv50_head *) {}
+nv50_crc_atomic_clr(struct nv50_head *head) {}
 
 #endif /* IS_ENABLED(CONFIG_DEBUG_FS) */
 #endif /* !__NV50_CRC_H__ */
-- 
2.26.2

