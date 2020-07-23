Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78035C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C9DA2064B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgGWOgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:36:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51067 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgGWOgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:36:41 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jycKr-00025R-Vt; Thu, 23 Jul 2020 14:36:38 +0000
From:   Colin King <colin.king@canonical.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: remove redundant initialization of variable result
Date:   Thu, 23 Jul 2020 15:36:37 +0100
Message-Id: <20200723143637.991988-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable result is being initialized with a value that is never read
and it is being updated later with a new value.  The initialization is
redundant and can be removed.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index 5d83e8174005..0853bc9917c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -1017,7 +1017,7 @@ enum dc_status dce112_add_stream_to_ctx(
 		struct dc_state *new_ctx,
 		struct dc_stream_state *dc_stream)
 {
-	enum dc_status result = DC_ERROR_UNEXPECTED;
+	enum dc_status result;
 
 	result = resource_map_pool_resources(dc, new_ctx, dc_stream);
 
-- 
2.27.0

