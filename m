Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4CAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 03:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2E8206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 03:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgG0D6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 23:58:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8829 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726676AbgG0D6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 23:58:53 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A40D314EB9C7481BCB8C;
        Mon, 27 Jul 2020 11:58:51 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Jul 2020
 11:58:50 +0800
From:   Peng Wu <wupeng58@huawei.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <airlied@gmail.com>, <lyude@redhat.com>
CC:     <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] crc:Fix build errors
Date:   Mon, 27 Jul 2020 12:00:18 +0800
Message-ID: <1595822418-34124-1-git-send-email-wupeng58@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DRM_NOUVEAU=y,the following errors
are seen while building crc.h.

In file included from /scratch/linux/drivers/gpu/drm/nouveau/nouveau_display.c:47:
/scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h: In function ‘nv50_head_crc_late_register’:
/scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:109:47: error: parameter name omitted
 static inline int nv50_head_crc_late_register(struct nv50_head *) {}
                                               ^~~~~~~~~~~~~~~~~~
/scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:109:54: warning: no return statement in function returning non-void [-Wreturn-type]
 static inline int nv50_head_crc_late_register(struct nv50_head *) {}
                                                      ^~~~~~~~~
/scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h: In function ‘nv50_crc_handle_vblank’:
/scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:111:57: warning: ‘return’ with a value, in function returning void
 nv50_crc_handle_vblank(struct nv50_head *head) { return 0; }
                                                         ^
/scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:111:1: note: declared here
 nv50_crc_handle_vblank(struct nv50_head *head) { return 0; }
 ^~~~~~~~~~~~~~~~~~~~~~
/scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h: In function ‘nv50_crc_atomic_check_head’:
/scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:114:28: error: parameter name omitted
 nv50_crc_atomic_check_head(struct nv50_head *, struct nv50_head_atom *,
                            ^~~~~~~~~~~~~~~~~~
/scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:114:48: error: parameter name omitted
 nv50_crc_atomic_check_head(struct nv50_head *, struct nv50_head_atom *,
                                                ^~~~~~~~~~~~~~~~~~~~~~~
/scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:115:7: error: parameter name omitted
       struct nv50_head_atom *) {}
       ^~~~~~~~~~~~~~~~~~~~~~~
/scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:115:14: warning: no return statement in function returning non-void [-Wreturn-type]
       struct nv50_head_atom *) {}
              ^~~~~~~~~~~~~~
/scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h: In function ‘nv50_crc_atomic_stop_reporting’:
/scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:118:32: error: parameter name omitted
 nv50_crc_atomic_stop_reporting(struct drm_atomic_state *) {}
                                ^~~~~~~~~~~~~~~~~~~~~~~~~
/scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h: In function ‘nv50_crc_atomic_init_notifier_contexts’:
/scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:120:40: error: parameter name omitted
 nv50_crc_atomic_init_notifier_contexts(struct drm_atomic_state *) {}
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~
/scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h: In function ‘nv50_crc_atomic_release_notifier_contexts’:
/scratch/linux/drivers/gpu/drm/nouveau/dispnv50/crc.h:122:43: error: parameter name omitted

Signed-off-by: Peng Wu <wupeng58@huawei.com>
---
 drivers/gpu/drm/nouveau/dispnv50/crc.h | 44 +++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/crc.h b/drivers/gpu/drm/nouveau/dispnv50/crc.h
index 4bc59e7..3da16cd 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/crc.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/crc.h
@@ -76,22 +76,22 @@ struct nv50_crc {
 };
 
 void nv50_crc_init(struct drm_device *dev);
-int nv50_head_crc_late_register(struct nv50_head *);
+int nv50_head_crc_late_register(struct nv50_head *head);
 void nv50_crc_handle_vblank(struct nv50_head *head);
 
-int nv50_crc_verify_source(struct drm_crtc *, const char *, size_t *);
-const char *const *nv50_crc_get_sources(struct drm_crtc *, size_t *);
-int nv50_crc_set_source(struct drm_crtc *, const char *);
+int nv50_crc_verify_source(struct drm_crtc *crtc, const char *source_name, size_t *values_cnt);
+const char *const *nv50_crc_get_sources(struct drm_crtc *crtc, size_t *count);
+int nv50_crc_set_source(struct drm_crtc *crtc, const char *source_str);
 
-int nv50_crc_atomic_check_head(struct nv50_head *, struct nv50_head_atom *,
-			       struct nv50_head_atom *);
+int nv50_crc_atomic_check_head(struct nv50_head *head, struct nv50_head_atom *asyh,
+			       struct nv50_head_atom *armh);
 void nv50_crc_atomic_check_outp(struct nv50_atom *atom);
-void nv50_crc_atomic_stop_reporting(struct drm_atomic_state *);
-void nv50_crc_atomic_init_notifier_contexts(struct drm_atomic_state *);
-void nv50_crc_atomic_release_notifier_contexts(struct drm_atomic_state *);
-void nv50_crc_atomic_start_reporting(struct drm_atomic_state *);
-void nv50_crc_atomic_set(struct nv50_head *, struct nv50_head_atom *);
-void nv50_crc_atomic_clr(struct nv50_head *);
+void nv50_crc_atomic_stop_reporting(struct drm_atomic_state *state);
+void nv50_crc_atomic_init_notifier_contexts(struct drm_atomic_state *state);
+void nv50_crc_atomic_release_notifier_contexts(struct drm_atomic_state *state);
+void nv50_crc_atomic_start_reporting(struct drm_atomic_state *state);
+void nv50_crc_atomic_set(struct nv50_head *head, struct nv50_head_atom *asyh);
+void nv50_crc_atomic_clr(struct nv50_head *head);
 
 extern const struct nv50_crc_func crc907d;
 extern const struct nv50_crc_func crcc37d;
@@ -106,26 +106,26 @@ struct nv50_crc_atom {};
 #define nv50_crc_set_source NULL
 
 static inline void nv50_crc_init(struct drm_device *dev) {}
-static inline int nv50_head_crc_late_register(struct nv50_head *) {}
+static inline int nv50_head_crc_late_register(struct nv50_head *head) { return 0; }
 static inline void
-nv50_crc_handle_vblank(struct nv50_head *head) { return 0; }
+nv50_crc_handle_vblank(struct nv50_head *head) {}
 
 static inline int
-nv50_crc_atomic_check_head(struct nv50_head *, struct nv50_head_atom *,
-			   struct nv50_head_atom *) {}
+nv50_crc_atomic_check_head(struct nv50_head *head, struct nv50_head_atom *asyh,
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
+nv50_crc_atomic_set(struct nv50_head *head, struct nv50_head_atom *asyh) {}
 static inline void
-nv50_crc_atomic_clr(struct nv50_head *) {}
+nv50_crc_atomic_clr(struct nv50_head *head) {}
 
 #endif /* IS_ENABLED(CONFIG_DEBUG_FS) */
 #endif /* !__NV50_CRC_H__ */
-- 
2.7.4

