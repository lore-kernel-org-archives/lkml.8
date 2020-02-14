Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F0DC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A4E2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704068;
	bh=Zyh3gxQCNHNRIhs5e1XYrjc0NPYFdY4P2QPnyJn75c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xw0INqzB/yc9EvjEzn8PWUKlivYCmS0TZ/wz2H/Sw5Cupu1cn2LkcXt4AnuqUWk1h
	 urqp7hD6SfsODAfeA/FK3Mo/IuJmmaKe8sOkwMKBkBbPBJUnJ/QCVkCKAWqnlGVdq7
	 FYfk6sQtq4boGxgTA51Jz59r7QHnSOjRSspYoGWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393869AbgBNSO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:14:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730980AbgBNPwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:52:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF47624676;
        Fri, 14 Feb 2020 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695544;
        bh=Zyh3gxQCNHNRIhs5e1XYrjc0NPYFdY4P2QPnyJn75c0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x07HsUGBggJefPForajyuyOuI56xL1899vS6E2KLvJjNdFotKIVgBkFxB6YkaBp8P
         bPIBD5STnuJ8SEKc6Ppsd21JIGSi069/o8jN+AIqEZNHPsNM9MBKV+TyU+iWitMWp8
         Cth9gRTk/Iy4xtslFdD2e03KTxqHFRcz7l7HFnCk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 161/542] drm/radeon: remove set but not used variable 'size', 'relocs_chunk'
Date:   Fri, 14 Feb 2020 10:42:33 -0500
Message-Id: <20200214154854.6746-161-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit e9f782dd22c0e17874b8b8e12aafcd3a06810dd0 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/radeon/r600_cs.c: In function r600_cs_track_validate_cb:
drivers/gpu/drm/radeon/r600_cs.c:353:22: warning: variable size set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/radeon/r600_cs.c: In function r600_cs_track_validate_db:
drivers/gpu/drm/radeon/r600_cs.c:520:27: warning: variable size set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/radeon/r600_cs.c: In function r600_dma_cs_next_reloc:
drivers/gpu/drm/radeon/r600_cs.c:2345:26: warning: variable relocs_chunk set but not used [-Wunused-but-set-variable]

The first 'size' is not used since commit f30df2fad0c9 ("drm/radeon/r600:
fix tiling issues in CS checker.")

The second 'size' is introduced by commit 88f50c80748b ("drm/radeon/kms:
add htile support to the cs checker v3"), but never used, so remove it.

'relocs_chunk' is not used since commit 9305ede6afe2 ("radeon/kms:
fix dma relocation checking")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/r600_cs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r600_cs.c
index d6c28a5d77abb..49e8266461f85 100644
--- a/drivers/gpu/drm/radeon/r600_cs.c
+++ b/drivers/gpu/drm/radeon/r600_cs.c
@@ -350,7 +350,7 @@ static void r600_cs_track_init(struct r600_cs_track *track)
 static int r600_cs_track_validate_cb(struct radeon_cs_parser *p, int i)
 {
 	struct r600_cs_track *track = p->track;
-	u32 slice_tile_max, size, tmp;
+	u32 slice_tile_max, tmp;
 	u32 height, height_align, pitch, pitch_align, depth_align;
 	u64 base_offset, base_align;
 	struct array_mode_checker array_check;
@@ -360,7 +360,6 @@ static int r600_cs_track_validate_cb(struct radeon_cs_parser *p, int i)
 	/* When resolve is used, the second colorbuffer has always 1 sample. */
 	unsigned nsamples = track->is_resolve && i == 1 ? 1 : track->nsamples;
 
-	size = radeon_bo_size(track->cb_color_bo[i]) - track->cb_color_bo_offset[i];
 	format = G_0280A0_FORMAT(track->cb_color_info[i]);
 	if (!r600_fmt_is_valid_color(format)) {
 		dev_warn(p->dev, "%s:%d cb invalid format %d for %d (0x%08X)\n",
@@ -517,7 +516,7 @@ static int r600_cs_track_validate_cb(struct radeon_cs_parser *p, int i)
 static int r600_cs_track_validate_db(struct radeon_cs_parser *p)
 {
 	struct r600_cs_track *track = p->track;
-	u32 nviews, bpe, ntiles, size, slice_tile_max, tmp;
+	u32 nviews, bpe, ntiles, slice_tile_max, tmp;
 	u32 height_align, pitch_align, depth_align;
 	u32 pitch = 8192;
 	u32 height = 8192;
@@ -564,7 +563,6 @@ static int r600_cs_track_validate_db(struct radeon_cs_parser *p)
 		}
 		ib[track->db_depth_size_idx] = S_028000_SLICE_TILE_MAX(tmp - 1) | (track->db_depth_size & 0x3FF);
 	} else {
-		size = radeon_bo_size(track->db_bo);
 		/* pitch in pixels */
 		pitch = (G_028000_PITCH_TILE_MAX(track->db_depth_size) + 1) * 8;
 		slice_tile_max = G_028000_SLICE_TILE_MAX(track->db_depth_size) + 1;
@@ -2342,7 +2340,6 @@ int r600_cs_parse(struct radeon_cs_parser *p)
 int r600_dma_cs_next_reloc(struct radeon_cs_parser *p,
 			   struct radeon_bo_list **cs_reloc)
 {
-	struct radeon_cs_chunk *relocs_chunk;
 	unsigned idx;
 
 	*cs_reloc = NULL;
@@ -2350,7 +2347,6 @@ int r600_dma_cs_next_reloc(struct radeon_cs_parser *p,
 		DRM_ERROR("No relocation chunk !\n");
 		return -EINVAL;
 	}
-	relocs_chunk = p->chunk_relocs;
 	idx = p->dma_reloc_idx;
 	if (idx >= p->nrelocs) {
 		DRM_ERROR("Relocs at %d after relocations chunk end %d !\n",
-- 
2.20.1

