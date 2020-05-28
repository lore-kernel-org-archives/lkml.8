Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66352C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 488C2215A4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590667361;
	bh=MULI+Njyfm2wJqBQaQ0lcAG8tNbzME1uIFaWCPpfjBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E2aIv7lrv4jZWohyNa+VnpodnOO3fcHUI1MNPraYLNqPJ9H9QDUlpNJunDT7y7n0h
	 EgowYym4CYkN5N4/xO5A8Lmg6+08Za6c1bbYxu1qz9FckpZFigp07x18bEORE61isC
	 My3SaXC482me4KGIeLfAbhUITZZODKKkoKXMSrpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389518AbgE1MCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389046AbgE1L5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:57:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2D23216C4;
        Thu, 28 May 2020 11:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590667055;
        bh=MULI+Njyfm2wJqBQaQ0lcAG8tNbzME1uIFaWCPpfjBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PIZsaxQTrd7zjexMAFSPKivImWVEJv1nzGIArAoojxO9IsSmOrMRzZXS2pqKSWpNH
         l1RvfdcgzlqtSgdL53HWkdsItAtPHFtY/ZBfgfOAjqMr+0HEBYJeya1TFyJwgUxGxY
         xBy5YKA33XPF/7MquljOdMkUjKehnRQcrFTQJgd8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Schmidt <jan@centricular.com>,
        Dave Airlie <airlied@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 09/17] drm/edid: Add Oculus Rift S to non-desktop list
Date:   Thu, 28 May 2020 07:57:16 -0400
Message-Id: <20200528115724.1406376-9-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528115724.1406376-1-sashal@kernel.org>
References: <20200528115724.1406376-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Schmidt <jan@centricular.com>

[ Upstream commit 5a3f610877e9d08968ea7237551049581f02b163 ]

Add a quirk for the Oculus Rift S OVR0012 display so
it shows up as a non-desktop display.

Signed-off-by: Jan Schmidt <jan@centricular.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200507180628.740936-1-jan@centricular.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_edid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index d5dcee7f1fc8..108f542176b8 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -198,10 +198,11 @@ static const struct edid_quirk {
 	{ "HVR", 0xaa01, EDID_QUIRK_NON_DESKTOP },
 	{ "HVR", 0xaa02, EDID_QUIRK_NON_DESKTOP },
 
-	/* Oculus Rift DK1, DK2, and CV1 VR Headsets */
+	/* Oculus Rift DK1, DK2, CV1 and Rift S VR Headsets */
 	{ "OVR", 0x0001, EDID_QUIRK_NON_DESKTOP },
 	{ "OVR", 0x0003, EDID_QUIRK_NON_DESKTOP },
 	{ "OVR", 0x0004, EDID_QUIRK_NON_DESKTOP },
+	{ "OVR", 0x0012, EDID_QUIRK_NON_DESKTOP },
 
 	/* Windows Mixed Reality Headsets */
 	{ "ACR", 0x7fce, EDID_QUIRK_NON_DESKTOP },
-- 
2.25.1

