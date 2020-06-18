Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D35C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B23222240
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445559;
	bh=Cub4vj9nLqVHK+vP9cLZf3O/SAGabxVQiO5LtqWPr3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v1meLvP+NgzD0jFl34t/Hft+pmfCf5eC6FEopYBLTeJL+O+h+YTdlNpsRRXt6ISoR
	 DjjWIF4yXIAcMPa0ba+ZXjITBlntm1Rw/Xoac8CchRFrOVzRtD2F6COBeCBcfuvvWr
	 mV6OBAzk/hrX1xbBACb5xT1HOTOA5oC/Ir5wfzvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbgFRBYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:24:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728340AbgFRBVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:21:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10C8B20CC7;
        Thu, 18 Jun 2020 01:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443282;
        bh=Cub4vj9nLqVHK+vP9cLZf3O/SAGabxVQiO5LtqWPr3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0pG6APArivPVS1UhMa9kylHSmrRtNWZuVYdwW927Evr9PoDOS4LcsiQeq4QtU+FO
         2V2TGK8H4mZ5H/oQ4HwBPgS6Se2vveXFnuYkfp+4gADmRL9w8dBpXy1M5eQKMTVl9i
         1+un2skuDuMYT2V3TCOGI+/C8zKGlbiSNpCuEMUA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 226/266] drm/amd/display: Revalidate bandwidth before commiting DC updates
Date:   Wed, 17 Jun 2020 21:15:51 -0400
Message-Id: <20200618011631.604574-226-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[ Upstream commit a24eaa5c51255b344d5a321f1eeb3205f2775498 ]

[Why]
Whenever we switch between tiled formats without also switching pixel
formats or doing anything else that recreates the DC plane state we
can run into underflow or hangs since we're not updating the
DML parameters before committing to the hardware.

[How]
If the update type is FULL then call validate_bandwidth again to update
the DML parmeters before committing the state.

This is basically just a workaround and protective measure against
update types being added DC where we could run into this issue in
the future.

We can only fully validate the state in advance before applying it to
the hardware if we recreate all the plane and stream states since
we can't modify what's currently in use.

The next step is to update DM to ensure that we're creating the plane
and stream states for whatever could potentially be a full update in
DC to pre-emptively recreate the state for DC global validation.

The workaround can stay until this has been fixed in DM.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2028dc017f7a..b95a58aa82d9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2230,6 +2230,12 @@ void dc_commit_updates_for_stream(struct dc *dc,
 
 	copy_stream_update_to_stream(dc, context, stream, stream_update);
 
+	if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
+		DC_ERROR("Mode validation failed for stream update!\n");
+		dc_release_state(context);
+		return;
+	}
+
 	commit_planes_for_stream(
 				dc,
 				srf_updates,
-- 
2.25.1

