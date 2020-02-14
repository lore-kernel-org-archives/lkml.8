Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126C4C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D174F2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704082;
	bh=eJKMDsNfkCSE8iaeKvTgTaLuJjG9/+64ASQSb5MgAos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fXJ/1OB5EURK1Isb/PmCUJ7aoGnpfzRt5FnYBO1ez8um2D2UfS7BdMF5PEpKiHKnn
	 dx8gYcqjmZhyB3wti9fRzwMhMFIJuNhP0FH+6z1iyNJTx5AzacxLdBE/3CnIWe939m
	 b9Mnk/LUoCk2XxUrfFhRFpJUD9/SwyDhON96HoHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393177AbgBNSOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:14:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729444AbgBNPwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:52:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 891232467E;
        Fri, 14 Feb 2020 15:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695540;
        bh=eJKMDsNfkCSE8iaeKvTgTaLuJjG9/+64ASQSb5MgAos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n7SkdmpAft7tWlvcKdVVN+4DjMskZNthCKmTG8IznKTJlaYB7Tv4YX3kWzDKP0Esn
         0ZYGjRsRSM1UVHITmM9+aol7kT2sXzGsyjL5FyF2TP/YzKMK77ftk/6hp4h+uVMXb+
         RXYXYxXxjE3p4sfqmGJq80tb3clLNaURzdqZQLuE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Hulk Robot <hulkci@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 158/542] drm/amd/display: remove set but not used variable 'bp' in bios_parser.c
Date:   Fri, 14 Feb 2020 10:42:30 -0500
Message-Id: <20200214154854.6746-158-sashal@kernel.org>
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

[ Upstream commit 7e30402bed151fc6222baafe5aa1abe3e65c3065 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/display/dc/bios/bios_parser.c: In function bios_get_board_layout_info:
drivers/gpu/drm/amd/display/dc/bios/bios_parser.c:2743:22: warning: variable bp set but not used [-Wunused-but-set-variable]

It is introduced by commit 1eeedbcc20d6 ("drm/amd/display:
get board layout for edid emulation"), but never used,
so remove it.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 823843cd26133..c34797cb4d2d3 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -2739,7 +2739,6 @@ static enum bp_result bios_get_board_layout_info(
 	struct board_layout_info *board_layout_info)
 {
 	unsigned int i;
-	struct bios_parser *bp;
 	enum bp_result record_result;
 
 	const unsigned int slot_index_to_vbios_id[MAX_BOARD_SLOTS] = {
@@ -2748,7 +2747,6 @@ static enum bp_result bios_get_board_layout_info(
 		0, 0
 	};
 
-	bp = BP_FROM_DCB(dcb);
 	if (board_layout_info == NULL) {
 		DC_LOG_DETECTION_EDID_PARSER("Invalid board_layout_info\n");
 		return BP_RESULT_BADINPUT;
-- 
2.20.1

