Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E85C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5580246CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696829;
	bh=7lG+dWiKK0SAsQ/9MpxIx6tL6YFcunMBoZY+JdjCtaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U6BdyAzvAYWY+2/26bweYmy/V+IcSJkMln1ZKClJKJRg/eTeFAE1EV0h8PcHwTi/G
	 94QkBR8dfk85WRIeFYBhJnqXFwI3m6rjHOe1Rw55dJMaQq0IHdFaQKIAk2z03gX6ao
	 0O5Og7CpgzoBearlHU3Nmh2KS5M6OVpaWp2s5EaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390830AbgBNQNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:13:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392136AbgBNQNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:13:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58C9B24696;
        Fri, 14 Feb 2020 16:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696793;
        bh=7lG+dWiKK0SAsQ/9MpxIx6tL6YFcunMBoZY+JdjCtaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLj5lC2bBEhx+yRPj+kyw2IblsZM/7reWF1u8OlMogSgZqiuUfHKHUqn24+NWbzae
         PwBmPIjdzylv1/e/JeJUBTmzO8S38QnNDIcrgXrLAFJuvBzRdkwFrHjZTMgA310gfx
         CYPTe439sl/6qKdczjokXYAM724GvtrpD/QIhroM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Hulk Robot <hulkci@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 067/252] drm/amd/display: remove set but not used variable 'bp' in bios_parser2.c
Date:   Fri, 14 Feb 2020 11:08:42 -0500
Message-Id: <20200214161147.15842-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit 589d8d282ebe1eab2dd8b1fba3e60322787a50e6 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c: In function bios_get_board_layout_info:
drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c:1826:22: warning: variable bp set but not used [-Wunused-but-set-variable]

It is introduced by commit 1eeedbcc20d6 ("drm/amd/display:
get board layout for edid emulation"), but never used,
so remove it.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index eab007e1793c2..9ee6814e80c7c 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2029,7 +2029,6 @@ static enum bp_result bios_get_board_layout_info(
 	struct board_layout_info *board_layout_info)
 {
 	unsigned int i;
-	struct bios_parser *bp;
 	enum bp_result record_result;
 
 	const unsigned int slot_index_to_vbios_id[MAX_BOARD_SLOTS] = {
@@ -2038,7 +2037,6 @@ static enum bp_result bios_get_board_layout_info(
 		0, 0
 	};
 
-	bp = BP_FROM_DCB(dcb);
 	if (board_layout_info == NULL) {
 		DC_LOG_DETECTION_EDID_PARSER("Invalid board_layout_info\n");
 		return BP_RESULT_BADINPUT;
-- 
2.20.1

