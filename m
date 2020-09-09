Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7594AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28CCE207DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gvxxZAB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgIIHVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgIIHVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:21:30 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF5BC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 00:21:29 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k15so1353190pfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 00:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Cckn9EcRCOy7+IrqhRAkRB9fhj6npQVnQRV+Ywzibc=;
        b=gvxxZAB0tPUxEA0Thi4h7/smwnXShApL7/fFLgGCHldHmOEE2BTAehvz980zF0bC5V
         1jyjKn1EcadTXdtjYvSp6exlDKHQgRGcsYiGmfs1pvalHPOjt9P3+KqwM1/PjcdN6uw5
         ofBzbQ6swdXhEMJZ9w0hU/qrJcw4o4uQvTUWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Cckn9EcRCOy7+IrqhRAkRB9fhj6npQVnQRV+Ywzibc=;
        b=fl/AZWTaNuBLR+/k7voog4/XKWeyMLUF6MyAJwp+APxnzstHjnL+vajv3LQGzoE9Lt
         1BKYl/LkWfFBxrH1bVE4PUCajHXDoN08oVTi4f4tWkosN7LAfVkzyg+p4rfTEx3x2Q+c
         51jcpRUA1lO0y2CcoRJJJS+hjiWfqp8THBTvyiEMhPAAIXm6H7A6BplbMFq7hzarObg6
         n0FzRjoQS+WVA2S1zhTmfL5YYJ7ppZh8NI+rL250Vb6pUxb1UJofzW1tGXl8DQuitsZx
         gvmRJKtq7FldUoPeNpQpEhb9IsEI263ljd4QVtDgjvLuV4uSiGkdE0S1bVKcywByPks6
         NIwA==
X-Gm-Message-State: AOAM531Qc6tY6z8Bigp/XkmM8fo9SXZbdCmLg4fqcaG5ElimdjcQRbAY
        5t9d2TXb7ob5uXIJK9WlXLIAJ89EGn2m8g==
X-Google-Smtp-Source: ABdhPJyVJbjJSTx1Z989hLkxbOZzvUOJE6v28wOoJgdZ3iUdbEym7T5IeDt/Vu4kikQytkZs652qvg==
X-Received: by 2002:a17:902:ea82:b029:d1:7ed9:5470 with SMTP id x2-20020a170902ea82b02900d17ed95470mr1734756plb.26.1599636088605;
        Wed, 09 Sep 2020 00:21:28 -0700 (PDT)
Received: from localhost ([2401:fa00:9:15:7220:84ff:fe09:cabc])
        by smtp.gmail.com with ESMTPSA id x9sm1240120pgi.87.2020.09.09.00.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 00:21:28 -0700 (PDT)
From:   Sam McNally <sammc@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Sam McNally <sammc@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 3/4] drm_dp_mst_topology: export two functions
Date:   Wed,  9 Sep 2020 17:20:51 +1000
Message-Id: <20200909172023.v2.3.I6c917ff82a1d2ae2253a3bd4d750d58879387cac@changeid>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200909172023.v2.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
References: <20200909172023.v2.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hans.verkuil@cisco.com>

These are required for the CEC MST support.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Sam McNally <sammc@chromium.org>
---

(no changes since v1)

 drivers/gpu/drm/drm_dp_mst_topology.c | 6 ++----
 include/drm/drm_dp_mst_helper.h       | 4 ++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 0d753201adbd..c783a2a1c114 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -62,8 +62,6 @@ struct drm_dp_pending_up_req {
 static bool dump_dp_payload_table(struct drm_dp_mst_topology_mgr *mgr,
 				  char *buf);
 
-static void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port);
-
 static int drm_dp_dpcd_write_payload(struct drm_dp_mst_topology_mgr *mgr,
 				     int id,
 				     struct drm_dp_payload *payload);
@@ -1864,7 +1862,7 @@ static void drm_dp_mst_topology_get_port(struct drm_dp_mst_port *port)
  * drm_dp_mst_topology_try_get_port()
  * drm_dp_mst_topology_get_port()
  */
-static void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port)
+void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port)
 {
 	topology_ref_history_lock(port->mgr);
 
@@ -1935,7 +1933,7 @@ drm_dp_mst_topology_get_port_validated_locked(struct drm_dp_mst_branch *mstb,
 	return NULL;
 }
 
-static struct drm_dp_mst_port *
+struct drm_dp_mst_port *
 drm_dp_mst_topology_get_port_validated(struct drm_dp_mst_topology_mgr *mgr,
 				       struct drm_dp_mst_port *port)
 {
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index c7c79e0ced18..d036222e0d64 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -754,6 +754,10 @@ drm_dp_mst_detect_port(struct drm_connector *connector,
 		       struct drm_dp_mst_topology_mgr *mgr,
 		       struct drm_dp_mst_port *port);
 
+struct drm_dp_mst_port *drm_dp_mst_topology_get_port_validated
+(struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port);
+void drm_dp_mst_topology_put_port(struct drm_dp_mst_port *port);
+
 struct edid *drm_dp_mst_get_edid(struct drm_connector *connector, struct drm_dp_mst_topology_mgr *mgr, struct drm_dp_mst_port *port);
 
 
-- 
2.28.0.526.ge36021eeef-goog

