Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE13C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91649214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgFQQAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:00:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45563 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFQQAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:00:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jlaTo-0003xt-5r; Wed, 17 Jun 2020 16:00:00 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/mm/selftests: fix unsigned comparison with less than zero
Date:   Wed, 17 Jun 2020 16:59:59 +0100
Message-Id: <20200617155959.231740-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Function get_insert_time can return error values that are cast
to a u64. The checks of insert_time1 and insert_time2 check for
the errors but because they are u64 variables the check for less
than zero can never be true. Fix this by casting the value to s64
to allow of the negative error check to succeed.

Addresses-Coverity: ("Unsigned compared against 0, no effect")
Fixes: 6e60d5ded06b ("drm/mm: add ig_frag selftest")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/selftests/test-drm_mm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_mm.c b/drivers/gpu/drm/selftests/test-drm_mm.c
index 3846b0f5bae3..671a152a6df2 100644
--- a/drivers/gpu/drm/selftests/test-drm_mm.c
+++ b/drivers/gpu/drm/selftests/test-drm_mm.c
@@ -1124,12 +1124,12 @@ static int igt_frag(void *ignored)
 
 		insert_time1 = get_insert_time(&mm, insert_size,
 					       nodes + insert_size, mode);
-		if (insert_time1 < 0)
+		if ((s64)insert_time1 < 0)
 			goto err;
 
 		insert_time2 = get_insert_time(&mm, (insert_size * 2),
 					       nodes + insert_size * 2, mode);
-		if (insert_time2 < 0)
+		if ((s64)insert_time2 < 0)
 			goto err;
 
 		pr_info("%s fragmented insert of %u and %u insertions took %llu and %llu nsecs\n",
-- 
2.27.0.rc0

