Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EACCC28E83
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D99A02098B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JgWRyGDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgIAGXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgIAGXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 02:23:23 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9149C0612AC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 23:23:23 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id c142so217591pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 23:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VISh9+UX16Kxomq7MvNQPeqw53Cit+NbcKfa5TeuC+c=;
        b=JgWRyGDuju2lJa6EhPUya9PhsI+iDwgHD/YJaTrxa3MrijyvOsLmc/VCRAUvS07uXe
         4GSw5Sa8QZkHCAOxQA83aw1RaizicMSf5jyqq6HstcEXFIg9d6xePUCtbH+KrjJUC7YL
         uzM+2QKnKNxuHZWn8OTQx0PHDN/s3QOsiqQww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VISh9+UX16Kxomq7MvNQPeqw53Cit+NbcKfa5TeuC+c=;
        b=f6KENhags+67Y7MlXBCcxQDbm4Dy4h6bTJDkrcIUalli+SsmbyxeF5/RVd5Eu0Mrjk
         EpjJA0O1+GUFIF7lznIB4aJfd0F8tyj+6bf4DuZUk6XD1qnVfHZVjnDWztSU4PaGQLkq
         2zxeE7BywEZXcjc6Nk7p7chFYBVddlTnjug9EaKQbAXccnTemzm5UfZXGajV8AIcbHhY
         UkFS3ZT+nT5KnDeuSnDuD4VBF4lxzjxFbGYYnqQJG7lt3JM+G8iGq9HKjQc7ehZw4lQK
         hqE29VHG2t80+DoD7IKQdbZDf6IwFFpckepr+Zuh8RH28pQkJybsSotf0kO5X2ZksBVu
         Ph+Q==
X-Gm-Message-State: AOAM5339HTJHMX6sfrD1amo1vGnxyC4YWyvqNou0S0XlfRemmYVkYtTw
        Ac+QWKOzJjwDihtyEjVbY4bbmbLupniwco8s
X-Google-Smtp-Source: ABdhPJzBsGh6rqlyfq2U0mHIrlmG0brZn6FHdYjOIhyHsLFqK/eR46xR+BGy5SV1mrg0bbCJwCAfwQ==
X-Received: by 2002:a63:cd0b:: with SMTP id i11mr227551pgg.306.1598941402803;
        Mon, 31 Aug 2020 23:23:22 -0700 (PDT)
Received: from localhost ([2401:fa00:9:15:7220:84ff:fe09:cabc])
        by smtp.gmail.com with ESMTPSA id lh6sm249339pjb.15.2020.08.31.23.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 23:23:22 -0700 (PDT)
From:   Sam McNally <sammc@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Sam McNally <sammc@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Francis <David.Francis@amd.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Leo Li <sunpeng.li@amd.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 4/5] drm_dp_cec: add plumbing in preparation for MST support
Date:   Tue,  1 Sep 2020 16:22:18 +1000
Message-Id: <20200901162133.4.I900b1b80709b7632a47d0ddb4cd375b4a3616c9e@changeid>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200901162133.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
References: <20200901162133.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hans.verkuil@cisco.com>

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
[sammc@chromium.org:
 - rebased
 - removed polling-related changes
 - moved the calls to drm_dp_cec_(un)set_edid() into the next patch
]
Signed-off-by: Sam McNally <sammc@chromium.org>
---

 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  2 +-
 drivers/gpu/drm/drm_dp_cec.c                  | 22 ++++++++++---------
 drivers/gpu/drm/i915/display/intel_dp.c       |  2 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c   |  2 +-
 include/drm/drm_dp_helper.h                   |  6 +++--
 5 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 461fa4da0a34..6e7075893ec9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -419,7 +419,7 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 
 	drm_dp_aux_init(&aconnector->dm_dp_aux.aux);
 	drm_dp_cec_register_connector(&aconnector->dm_dp_aux.aux,
-				      &aconnector->base);
+				      &aconnector->base, false);
 
 	if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_eDP)
 		return;
diff --git a/drivers/gpu/drm/drm_dp_cec.c b/drivers/gpu/drm/drm_dp_cec.c
index 3ab2609f9ec7..04ab7b88055c 100644
--- a/drivers/gpu/drm/drm_dp_cec.c
+++ b/drivers/gpu/drm/drm_dp_cec.c
@@ -14,6 +14,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_device.h>
 #include <drm/drm_dp_helper.h>
+#include <drm/drm_dp_mst_helper.h>
 
 /*
  * Unfortunately it turns out that we have a chicken-and-egg situation
@@ -338,8 +339,6 @@ void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid)
 	if (aux->cec.adap) {
 		if (aux->cec.adap->capabilities == cec_caps &&
 		    aux->cec.adap->available_log_addrs == num_las) {
-			/* Unchanged, so just set the phys addr */
-			cec_s_phys_addr_from_edid(aux->cec.adap, edid);
 			goto unlock;
 		}
 		/*
@@ -364,15 +363,16 @@ void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid)
 	if (cec_register_adapter(aux->cec.adap, connector->dev->dev)) {
 		cec_delete_adapter(aux->cec.adap);
 		aux->cec.adap = NULL;
-	} else {
-		/*
-		 * Update the phys addr for the new CEC adapter. When called
-		 * from drm_dp_cec_register_connector() edid == NULL, so in
-		 * that case the phys addr is just invalidated.
-		 */
-		cec_s_phys_addr_from_edid(aux->cec.adap, edid);
 	}
 unlock:
+	/*
+	 * Update the phys addr for the new CEC adapter. When called
+	 * from drm_dp_cec_register_connector() edid == NULL, so in
+	 * that case the phys addr is just invalidated.
+	 */
+	if (aux->cec.adap && edid) {
+		cec_s_phys_addr_from_edid(aux->cec.adap, edid);
+	}
 	mutex_unlock(&aux->cec.lock);
 }
 EXPORT_SYMBOL(drm_dp_cec_set_edid);
@@ -418,6 +418,7 @@ EXPORT_SYMBOL(drm_dp_cec_unset_edid);
  * drm_dp_cec_register_connector() - register a new connector
  * @aux: DisplayPort AUX channel
  * @connector: drm connector
+ * @is_mst: set to true if this is an MST branch
  *
  * A new connector was registered with associated CEC adapter name and
  * CEC adapter parent device. After registering the name and parent
@@ -425,12 +426,13 @@ EXPORT_SYMBOL(drm_dp_cec_unset_edid);
  * CEC and to register a CEC adapter if that is the case.
  */
 void drm_dp_cec_register_connector(struct drm_dp_aux *aux,
-				   struct drm_connector *connector)
+				   struct drm_connector *connector, bool is_mst)
 {
 	WARN_ON(aux->cec.adap);
 	if (WARN_ON(!aux->transfer))
 		return;
 	aux->cec.connector = connector;
+	aux->cec.is_mst = is_mst;
 	INIT_DELAYED_WORK(&aux->cec.unregister_work,
 			  drm_dp_cec_unregister_work);
 }
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 82b9de274f65..744cb55572f9 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6261,7 +6261,7 @@ intel_dp_connector_register(struct drm_connector *connector)
 	intel_dp->aux.dev = connector->kdev;
 	ret = drm_dp_aux_register(&intel_dp->aux);
 	if (!ret)
-		drm_dp_cec_register_connector(&intel_dp->aux, connector);
+		drm_dp_cec_register_connector(&intel_dp->aux, connector, false);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 49dd0cbc332f..671a70e95cd1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1414,7 +1414,7 @@ nouveau_connector_create(struct drm_device *dev,
 	switch (type) {
 	case DRM_MODE_CONNECTOR_DisplayPort:
 	case DRM_MODE_CONNECTOR_eDP:
-		drm_dp_cec_register_connector(&nv_connector->aux, connector);
+		drm_dp_cec_register_connector(&nv_connector->aux, connector, false);
 		break;
 	}
 
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 85513eeb2196..12bca1b9512b 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1495,12 +1495,14 @@ struct drm_connector;
  * @lock: mutex protecting this struct
  * @adap: the CEC adapter for CEC-Tunneling-over-AUX support.
  * @connector: the connector this CEC adapter is associated with
+ * @is_mst: this is an MST branch
  * @unregister_work: unregister the CEC adapter
  */
 struct drm_dp_aux_cec {
 	struct mutex lock;
 	struct cec_adapter *adap;
 	struct drm_connector *connector;
+	bool is_mst;
 	struct delayed_work unregister_work;
 };
 
@@ -1746,7 +1748,7 @@ drm_dp_has_quirk(const struct drm_dp_desc *desc, u32 edid_quirks,
 #ifdef CONFIG_DRM_DP_CEC
 void drm_dp_cec_irq(struct drm_dp_aux *aux);
 void drm_dp_cec_register_connector(struct drm_dp_aux *aux,
-				   struct drm_connector *connector);
+				   struct drm_connector *connector, bool is_mst);
 void drm_dp_cec_unregister_connector(struct drm_dp_aux *aux);
 void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid);
 void drm_dp_cec_unset_edid(struct drm_dp_aux *aux);
@@ -1757,7 +1759,7 @@ static inline void drm_dp_cec_irq(struct drm_dp_aux *aux)
 
 static inline void
 drm_dp_cec_register_connector(struct drm_dp_aux *aux,
-			      struct drm_connector *connector)
+			      struct drm_connector *connector, bool is_mst)
 {
 }
 
-- 
2.28.0.402.g5ffc5be6b7-goog

