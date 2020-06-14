Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46C3C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 07:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B869120714
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 07:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpaxFuy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgFNHFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 03:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgFNHFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 03:05:39 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183DFC03E96F
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 00:05:38 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a13so12513241ilh.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 00:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0XuYLXE5LXbZw3w+xu/hegikrINLkb1ZDvcbBdL0ayM=;
        b=LpaxFuy0s9GL1das7axADmDQ6Y1YqWAaWu1hxP1r1ZBSYNJpSrMug1KhN4q+TZvseA
         7EOd510jkNdZmnilgAEOcAOag30TLmRIMFyNaC28MKtS92uKCMwH5YPwr2KLKrxjA+KV
         7AMPBAiqfyWrCSV6Bkz4HekY6xGvVh0HSkrQBo9EZWnJERzqcG+jZSstD067A3CneKFG
         D5MDWKZ3HozR1wjSWVLubkRq0yUXkPqV5kTSttF4AGXhX/J7bG7muzBSe+ybPdh9gXwk
         jd/B50nQz8rjRmndlA4BPTIDx7DC3v43BruUxo3d3LpAL3mlY+eCMx9nz5ID7yUGQlkw
         a1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0XuYLXE5LXbZw3w+xu/hegikrINLkb1ZDvcbBdL0ayM=;
        b=TrbO0CT4aQXIUubq86U1Um+Cpmw+cVN0dtlBdFtyVTR4eRwvQGTxJY0U4HcPIWB/MS
         BThsTu0YCipX3BhkcGU8vACNjMDfyM20bzfxUERT1h7sTn+9qd3I2rocMfTol2ZQ9uLh
         EfUJMVDlXT2HOlFyuwJCp5XheNJbGYAIptSRc4TC282uOJYww+8BpqInfWFPaI2kqmQp
         yMNOGmeyJszIwdYNwbzg+lIxop+2j62myXljNk9dgsVMXzw28enb27r6ZefbUuaWtYEI
         G9YM4ddovfdT24BlsZAS3JlZ44/ioH/g/W/Ar3A25zVbny7tNZtS2j++6VoFqgUMt7nz
         NVwQ==
X-Gm-Message-State: AOAM532VrJ3lW8lwSWyu04UrRGnnv4f22Ra+qE0SCRaz9r7Totofctf7
        4dO9KclQVmDW1931D76lvxQ=
X-Google-Smtp-Source: ABdhPJy24po3ZTlu9/GPx5XVlvsADFJvpxCf44M5BuTfT1nO7/H8lWeq4lUmzcuJYTAkE5nprNwvcg==
X-Received: by 2002:a92:2454:: with SMTP id k81mr20064215ilk.24.1592118338299;
        Sun, 14 Jun 2020 00:05:38 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id c62sm6132702ill.62.2020.06.14.00.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 00:05:37 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu
Subject: [PATCH] drm/amdgpu/display: fix ref count leak when pm_runtime_get_sync fails
Date:   Sun, 14 Jun 2020 02:05:28 -0500
Message-Id: <20200614070530.56366-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to pm_runtime_get_sync increments the counter even in case of
failure, leading to incorrect ref count.
In case of failure, decrement the ref count before returning.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index f355d9a752d2..a1aec205435d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -716,8 +716,10 @@ amdgpu_connector_lvds_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	if (encoder) {
@@ -854,8 +856,10 @@ amdgpu_connector_vga_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	encoder = amdgpu_connector_best_single_encoder(connector);
@@ -977,8 +981,10 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	if (!force && amdgpu_connector_check_hpd_status_unchanged(connector)) {
@@ -1328,8 +1334,10 @@ amdgpu_connector_dp_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	if (!force && amdgpu_connector_check_hpd_status_unchanged(connector)) {
-- 
2.17.1

