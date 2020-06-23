Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B711EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CEA32085B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947451;
	bh=50r7EeLU58sGZGul3qGU5kJ0It9yv31mvgDrhWhfr6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dCvc9HEegU0ZZFvMrzvBom/ZyF1TRZGyQwzrG41y2R7UoxpShjJarbR/3hyuv8W7i
	 3nJ5v/dlj5APHb93x4wvN4qPSDmFJDYHBFH7eq9e29njb79GX+CnDZyO6uauB4ECBg
	 82ASsO1/qz0rGPOFDb+2RPLbAWJbNqY1EiwOcEFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389885AbgFWUUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389316AbgFWUUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:20:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C21DD21473;
        Tue, 23 Jun 2020 20:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943608;
        bh=50r7EeLU58sGZGul3qGU5kJ0It9yv31mvgDrhWhfr6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vsSvsuhKt80vWd4+jqR9nPDMlN6+WIzorTJ7rSgg6zjpfnId/gqyEdWzWee9G68Wy
         f1acgXTCJa0+UHXrwFkvoYoOHsc9FbCyEygy1dpcYP1ZWHCG/xQkbxj0zon8TBB7fq
         p8Mxan0Tm8siB7VVcGQQaI02lW1BtLI13XVeaMTc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Monakov <amonakov@ispras.ru>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Michael Chiu <Michael.Chiu@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 5.7 458/477] Revert "drm/amd/display: disable dcn20 abm feature for bring up"
Date:   Tue, 23 Jun 2020 21:57:35 +0200
Message-Id: <20200623195429.199288714@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harry Wentland <harry.wentland@amd.com>

commit 14ed1c908a7a623cc0cbf0203f8201d1b7d31d16 upstream.

This reverts commit 96cb7cf13d8530099c256c053648ad576588c387.

This change was used for DCN2 bringup and is no longer desired.
In fact it breaks backlight on DCN2 systems.

Cc: Alexander Monakov <amonakov@ispras.ru>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: Michael Chiu <Michael.Chiu@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reported-and-tested-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1334,7 +1334,7 @@ static int dm_late_init(void *handle)
 	unsigned int linear_lut[16];
 	int i;
 	struct dmcu *dmcu = adev->dm.dc->res_pool->dmcu;
-	bool ret = false;
+	bool ret;
 
 	for (i = 0; i < 16; i++)
 		linear_lut[i] = 0xFFFF * i / 15;
@@ -1350,13 +1350,10 @@ static int dm_late_init(void *handle)
 	 */
 	params.min_abm_backlight = 0x28F;
 
-	/* todo will enable for navi10 */
-	if (adev->asic_type <= CHIP_RAVEN) {
-		ret = dmcu_load_iram(dmcu, params);
-
-		if (!ret)
-			return -EINVAL;
-	}
+	ret = dmcu_load_iram(dmcu, params);
+
+	if (!ret)
+		return -EINVAL;
 
 	return detect_mst_link_for_all_connectors(adev->ddev);
 }


