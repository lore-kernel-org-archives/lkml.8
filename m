Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9BBC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8232082E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="h3/mYRp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgELJAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729426AbgELJAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:00:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1159C05BD09
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:00:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i15so14310776wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jrOYK5IswDhDcmGB8LsPi+9Nw1bfVsPgV33DAHzX+ls=;
        b=h3/mYRp1OcqYZQlQX+Gw+Nr2f74xD8wrG/8uWoDrU5GGp6Ub/5RiOXKsHrW2i30PcM
         rJObZIMZcRT/PeeXQkroNNnNFRFiAD5IX8OIVMx7wsr+QVbeILzn/npECakJZp/sCWwy
         NqAHegH3rJ0pwC/jz0jj1m+H5qlwdREu7tJoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrOYK5IswDhDcmGB8LsPi+9Nw1bfVsPgV33DAHzX+ls=;
        b=IiUQvHZuuyD6utyCSJMplpbAk5MjWFUDjHJT5b2NzF80EFKTDELtsAVSg9J/SGV9gS
         p6E5k1/wDOX/EuWna8S9XAxvbadZfjAXha2xglriemSznWFHiJI8HPaAabHlzd2wnAuK
         YyVg2XXsGxNvibr3K3I15nEX6dkwPQpRqXk9aBelkyH7Zh+gJueCofz5B/iFcgp3VzLD
         IfAREPZU3BFuIda4uXeURATmE6zTmdmLr+KMnX3OPUcgbpRLN1K/2idC/cC7G9ycS0/S
         aa1eihIz09cNfYL21aM0pBjFGKtgNOlyFWloQ7teQbt7N70tkw67lCqomI9RT8LppxeB
         hayg==
X-Gm-Message-State: AGi0PuYqyKWiDMWYxz2GGvLC2skUTFTlBAWLUNu70jQexpq+Js5QeZTs
        +i6/CLUib4Gu3mAF/aHIWwLzyw==
X-Google-Smtp-Source: APiQypLaPNHMZXOD+W5pUCFXhyzl8NdTydYhe1gyIbn3OV0HN9J6C0ZeHve71lUzcmTo+4IIHmsQng==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr23346958wru.62.1589274008569;
        Tue, 12 May 2020 02:00:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y10sm18845457wrd.95.2020.05.12.02.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 02:00:08 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [RFC 11/17] drm/amdgpu: DC also loves to allocate stuff where it shouldn't
Date:   Tue, 12 May 2020 10:59:38 +0200
Message-Id: <20200512085944.222637-12-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not going to bother with a complete&pretty commit message, just
offending backtrace:

        kvmalloc_node+0x47/0x80
        dc_create_state+0x1f/0x60 [amdgpu]
        dc_commit_state+0xcb/0x9b0 [amdgpu]
        amdgpu_dm_atomic_commit_tail+0xd31/0x2010 [amdgpu]
        commit_tail+0xa4/0x140 [drm_kms_helper]
        drm_atomic_helper_commit+0x152/0x180 [drm_kms_helper]
        drm_client_modeset_commit_atomic+0x1ea/0x250 [drm]
        drm_client_modeset_commit_locked+0x55/0x190 [drm]
        drm_client_modeset_commit+0x24/0x40 [drm]

v2: Found more in DC code, I'm just going to pile them all up.

Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-rdma@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c                 | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 4cfc786699c7..1b0c674fab25 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1226,7 +1226,7 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 	ectx.abort = false;
 	ectx.last_jump = 0;
 	if (ws)
-		ectx.ws = kcalloc(4, ws, GFP_KERNEL);
+		ectx.ws = kcalloc(4, ws, GFP_ATOMIC);
 	else
 		ectx.ws = NULL;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4469a8c96b08..9bfaa4cad483 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6622,7 +6622,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		struct dc_stream_update stream_update;
 	} *bundle;
 
-	bundle = kzalloc(sizeof(*bundle), GFP_KERNEL);
+	bundle = kzalloc(sizeof(*bundle), GFP_ATOMIC);
 
 	if (!bundle) {
 		dm_error("Failed to allocate update bundle\n");
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 401d1c66a411..a37a32442a5a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1416,8 +1416,10 @@ bool dc_post_update_surfaces_to_stream(struct dc *dc)
 
 struct dc_state *dc_create_state(struct dc *dc)
 {
+	/* No you really cant allocate random crap here this late in
+	 * atomic_commit_tail. */
 	struct dc_state *context = kvzalloc(sizeof(struct dc_state),
-					    GFP_KERNEL);
+					    GFP_ATOMIC);
 
 	if (!context)
 		return NULL;
-- 
2.26.2

