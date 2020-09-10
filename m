Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD73BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B124206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599733679;
	bh=KRfDEjXRBI/tBCJXx+FLikIBMH8HE8aMniHSQ98gJAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A+IM9VIAMkLPFvzahPdjf8bSypNc0Ko4Qfx1iZ2hljPwQ9uwyYkVsAFwQEkVFeQzE
	 v6Hr6ExZ7gHyr7dnZYa59hy0y34KDt2OJp5d+DahTLB+7SgNY+69q5/t0qUuvXlxcX
	 8L5Hk4NGAIrB+BJeO1a7SDmlM8qheYTO4GhwLidY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbgIJK1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgIJKYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:24:11 -0400
Received: from mail.kernel.org (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80CEF21D6C;
        Thu, 10 Sep 2020 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599733450;
        bh=KRfDEjXRBI/tBCJXx+FLikIBMH8HE8aMniHSQ98gJAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M5WSz4T3AJEu99nVJN0eNkotvDnemWcnEWUT9DF82SK220h8hFY8b2FUebSMo1oA9
         ycQUQOCxasY6aAWMec/8rYZhRMqds0OqDI6So6X3iJapcblcOPYf2jcL3oZ7YTbfhb
         BEWYMSilaRhAEgQZLz75Ic4oCVp+iIdgvg4vbQIk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGJkO-00EIO2-KS; Thu, 10 Sep 2020 12:24:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/14] drm: amdgpu: kernel-doc: update some adev parameters
Date:   Thu, 10 Sep 2020 12:24:03 +0200
Message-Id: <9238f1d558b4757117a7347861bf6f66cc049fe1.1599732764.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599732764.git.mchehab+huawei@kernel.org>
References: <cover.1599732764.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running "make htmldocs: produce lots of warnings on those files:
	./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:177: warning: Excess function parameter 'man' description in 'amdgpu_vram_mgr_init'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:177: warning: Excess function parameter 'p_size' description in 'amdgpu_vram_mgr_init'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:211: warning: Excess function parameter 'man' description in 'amdgpu_vram_mgr_fini'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:177: warning: Excess function parameter 'man' description in 'amdgpu_vram_mgr_init'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:177: warning: Excess function parameter 'p_size' description in 'amdgpu_vram_mgr_init'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:211: warning: Excess function parameter 'man' description in 'amdgpu_vram_mgr_fini'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:177: warning: Excess function parameter 'man' description in 'amdgpu_vram_mgr_init'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:177: warning: Excess function parameter 'p_size' description in 'amdgpu_vram_mgr_init'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:211: warning: Excess function parameter 'man' description in 'amdgpu_vram_mgr_fini'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:177: warning: Excess function parameter 'man' description in 'amdgpu_vram_mgr_init'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:177: warning: Excess function parameter 'p_size' description in 'amdgpu_vram_mgr_init'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:211: warning: Excess function parameter 'man' description in 'amdgpu_vram_mgr_fini'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c:90: warning: Excess function parameter 'man' description in 'amdgpu_gtt_mgr_init'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c:90: warning: Excess function parameter 'p_size' description in 'amdgpu_gtt_mgr_init'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c:134: warning: Excess function parameter 'man' description in 'amdgpu_gtt_mgr_fini'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c:90: warning: Excess function parameter 'man' description in 'amdgpu_gtt_mgr_init'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c:90: warning: Excess function parameter 'p_size' description in 'amdgpu_gtt_mgr_init'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c:134: warning: Excess function parameter 'man' description in 'amdgpu_gtt_mgr_fini'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:675: warning: Excess function parameter 'dev' description in 'amdgpu_device_asic_init'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:675: warning: Excess function parameter 'dev' description in 'amdgpu_device_asic_init'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:675: warning: Excess function parameter 'dev' description in 'amdgpu_device_asic_init'
	./drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:675: warning: Excess function parameter 'dev' description in 'amdgpu_device_asic_init'

They're related to the repacement of some parameters by adev,
and due to a few renamed parameters.

Update the kernel-doc documentation accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c  | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 5 ++---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f7307af76452..ba32b3ea9098 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -667,7 +667,7 @@ static void amdgpu_block_invalid_wreg(struct amdgpu_device *adev,
 /**
  * amdgpu_device_asic_init - Wrapper for atom asic_init
  *
- * @dev: drm_device pointer
+ * @adev: drm_device pointer
  *
  * Does any asic specific work and then calls atom asic init.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 2b1b7c136343..62c66c8a7a69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -81,8 +81,8 @@ static const struct ttm_resource_manager_func amdgpu_gtt_mgr_func;
 /**
  * amdgpu_gtt_mgr_init - init GTT manager and DRM MM
  *
- * @man: TTM memory type manager
- * @p_size: maximum size of GTT
+ * @adev: amdgpu device structure
+ * @gtt_size: maximum size of GTT
  *
  * Allocate and initialize the GTT manager.
  */
@@ -125,7 +125,7 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size)
 /**
  * amdgpu_gtt_mgr_fini - free and destroy GTT manager
  *
- * @man: TTM memory type manager
+ * @adev: amdgpu device structure
  *
  * Destroy and free the GTT manager, returns -EBUSY if ranges are still
  * allocated inside it.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index b2adc2abc581..a26cf1c80d62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -168,8 +168,7 @@ static const struct ttm_resource_manager_func amdgpu_vram_mgr_func;
 /**
  * amdgpu_vram_mgr_init - init VRAM manager and DRM MM
  *
- * @man: TTM memory type manager
- * @p_size: maximum size of VRAM
+ * @adev: amdgpu device structure
  *
  * Allocate and initialize the VRAM manager.
  */
@@ -202,7 +201,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 /**
  * amdgpu_vram_mgr_fini - free and destroy VRAM manager
  *
- * @man: TTM memory type manager
+ * @adev: amdgpu device structure
  *
  * Destroy and free the VRAM manager, returns -EBUSY if ranges are still
  * allocated inside it.
-- 
2.26.2

