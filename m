Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85BFC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 01:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFBD2074D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 01:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="mGPxDd56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgFNBzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 21:55:48 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:34728 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgFNBzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 21:55:47 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49kyGp2Qg7z9vFPn
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 01:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yOih3PpJSzRh for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 20:55:46 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49kyGp0lc9z9vC7g
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 20:55:46 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49kyGp0lc9z9vC7g
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49kyGp0lc9z9vC7g
Received: by mail-io1-f70.google.com with SMTP id z20so8954993iog.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 18:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TdqIFxgHaPyml2SmCdHxvLQZge/mICMslBYJgjMsN0k=;
        b=mGPxDd568gvpjZYW7B0VV+xmdjn8NF+TD7I3LwqVL2COMehOHnoTIw5DZKtZ2bCFGj
         BMwI50DUWvzIA/tkfqI65XIID6XJlTCB+kdK1dh8rade6ulX7Fi6FgldOo2ERHBlLP2E
         siDnavJnLqqVBTE/lCpswnHpXQ3RILH0X1OcuU63Jb7jg4KONnbJRfSzX+IfyN0IPSRn
         IgppSXNBpwFC8F/DX691Ay6J3ZtLHjW5t8tArT5DtA1b/L9EpEdLoE+k6XLlxU86O5ra
         8lAH96X22H/YvEqm7TkoXs7Lf95zofSOUpbSCv6nAIFhoj7emn26PExmWKYugvvVBMIw
         6VMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TdqIFxgHaPyml2SmCdHxvLQZge/mICMslBYJgjMsN0k=;
        b=t0cdRBp9bRfxNKuazt06d9GPmWJ8CwgoCq/5s+0u1O2ULcHNtHVcHyKMVXsmeQrBYV
         Ysh4iJB5ylPJTmZXm1Xsu2YrYQEGq5v7i6mm2607y70BJUE1ceqHxT8VIvr1EjBEOFiA
         AnrVjMtb+NRGhUmM4k4DPbtikGy+3kkawVd7Hz3Zv7OWe9zsnsJtK9Z2FqCHE7Gv1MOE
         WVkfD8Oa6WbIKHxcd4kyIzybQy0IznhBOlhMOII1heQECGhmwnNXCc3phuQPdChMYkjl
         r5CC+26Npk1Dl301Pn8uYcpIoSJovZvNsF1jKx15xVAObiQEFhqxrFJLUnRgCv2c6Iga
         8BnQ==
X-Gm-Message-State: AOAM53382o0xUgN1kVV2U3BHSbug5TYJYAfQykmsjeJa+JgpBHqi0JKL
        auVbe0gahL93KeXkj+S27nxXnu2dL9GUtzfHE/1NanMcunqvWXxJujAh0k7eDg7D22aF293sQqS
        HGNvvN+kwP6vp0Edek/GJAJKRE0Q4
X-Received: by 2002:a05:6e02:be8:: with SMTP id d8mr19558115ilu.32.1592099745719;
        Sat, 13 Jun 2020 18:55:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcVDjXlANd/0Xr752unf8N10VGa47mAE3GfelbMmqQ32kEGlnlBYsVkfVLgyXnIgnf2V8zuQ==
X-Received: by 2002:a05:6e02:be8:: with SMTP id d8mr19558104ilu.32.1592099745566;
        Sat, 13 Jun 2020 18:55:45 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:49fa:9c47:e40b:9c40])
        by smtp.gmail.com with ESMTPSA id w15sm5544402ilq.4.2020.06.13.18.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 18:55:45 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, wu000273@umn.edu,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: fix multiple reference count leak
Date:   Sat, 13 Jun 2020 20:55:39 -0500
Message-Id: <20200614015539.123654-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On calling pm_runtime_get_sync() the reference count of the device
is incremented. In case of failure, decrement the
reference count before returning the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/gpu/drm/radeon/radeon_connectors.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index fe12d9d91d7a..e30834434442 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -879,8 +879,10 @@ radeon_lvds_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	if (encoder) {
@@ -1025,8 +1027,10 @@ radeon_vga_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	encoder = radeon_best_single_encoder(connector);
@@ -1163,8 +1167,10 @@ radeon_tv_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	encoder = radeon_best_single_encoder(connector);
@@ -1247,8 +1253,10 @@ radeon_dvi_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	if (radeon_connector->detected_hpd_without_ddc) {
@@ -1657,8 +1665,10 @@ radeon_dp_detect(struct drm_connector *connector, bool force)
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
-		if (r < 0)
+		if (r < 0) {
+			pm_runtime_put_autosuspend(connector->dev->dev);
 			return connector_status_disconnected;
+		}
 	}
 
 	if (!force && radeon_check_hpd_status_unchanged(connector)) {
-- 
2.25.1

