Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AF1C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F9D20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgDTOIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:08:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43464 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgDTOIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:08:51 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jQX6N-0006NI-2h; Mon, 20 Apr 2020 14:08:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amdgpu: fix a dereference on pointer hive before it is null checked
Date:   Mon, 20 Apr 2020 15:08:46 +0100
Message-Id: <20200420140846.78062-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently pointer hive is being dereferenced before it is being null
checked and hence can lead to null pointer dereference issues. Fix this
by only dereferencing pointer hive after it has been null checked.

Addresses-Coverity: ("Dereference before null check")
Fixes: 25d4275e1931 ("drm/amdgpu: fix race between pstate and remote buffer map")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 54d8a3e7e75c..2c0a59ba2826 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -389,15 +389,17 @@ int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate)
 {
 	int ret = 0;
 	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, 0);
-	struct amdgpu_device *request_adev = hive->hi_req_gpu ?
-						hive->hi_req_gpu : adev;
+	struct amdgpu_device *request_adev;
 	bool is_hi_req = pstate == AMDGPU_XGMI_PSTATE_MAX_VEGA20;
-	bool init_low = hive->pstate == AMDGPU_XGMI_PSTATE_UNKNOWN;
+	bool init_low;
 
 	/* fw bug so temporarily disable pstate switching */
 	if (!hive || adev->asic_type == CHIP_VEGA20)
 		return 0;
 
+	request_adev = hive->hi_req_gpu ? hive->hi_req_gpu : adev;
+	init_low = hive->pstate == AMDGPU_XGMI_PSTATE_UNKNOWN;
+
 	mutex_lock(&hive->hive_lock);
 
 	if (is_hi_req)
-- 
2.25.1

