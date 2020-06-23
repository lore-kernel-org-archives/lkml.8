Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C79DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0726B21473
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944448;
	bh=Ciqu/rlqehBtA7qIB5psFoxsNKKg8C99s+mKMZmV3fc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r8bGRM1KOIMQw2D35/cpN5puWcBwDPrNJCzeZYx4SdiklHi6QBf6y9uOByrV6/Zbi
	 p2GCreBb5L/S5AP+Q4sJOrsjkGH9dfX4HJoQp5cotWPUOsErI2OnnT303d8lM4YHNG
	 +g0Kzs29BoIJR8kmwMyOEQ64/UIsb1aY6hCPoEHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391491AbgFWUeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391463AbgFWUdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:33:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE9D22085B;
        Tue, 23 Jun 2020 20:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944434;
        bh=Ciqu/rlqehBtA7qIB5psFoxsNKKg8C99s+mKMZmV3fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=irb9ZntR6f3p7emFFCExg4JFCfiQeQEnfoMd9LpHORXBoMeJ3y9wMonLN4+mP2Zkl
         CiLjLiCdxI2+bd6mxOBLtW9Kz/t+DiTk+cg2h3JSSt0nRoDEXHq1at411kcdz/8/c5
         Ws300Iv5QvgYUFT7vRt7mE+M2YHRO5LrGVcoxFPA=
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
Subject: [PATCH 5.4 304/314] Revert "drm/amd/display: disable dcn20 abm feature for bring up"
Date:   Tue, 23 Jun 2020 21:58:19 +0200
Message-Id: <20200623195353.497652206@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
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
@@ -929,7 +929,7 @@ static int dm_late_init(void *handle)
 	unsigned int linear_lut[16];
 	int i;
 	struct dmcu *dmcu = adev->dm.dc->res_pool->dmcu;
-	bool ret = false;
+	bool ret;
 
 	for (i = 0; i < 16; i++)
 		linear_lut[i] = 0xFFFF * i / 15;
@@ -945,13 +945,10 @@ static int dm_late_init(void *handle)
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


