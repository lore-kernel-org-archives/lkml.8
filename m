Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED24EC3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D8C2467E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695559;
	bh=XkJIbnairGNv5feCGTBQ9Yux6PNapzdcJ3bfivHLc5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CeO7zqDmuf7T8ARU5uz2lnpNLIbYL3yQJJKBIy8qNMzMuoT6tcc8rQ9ZBTW3CixsO
	 bf4aeQc3G7zW/8oRwbOG4u889ghCO6Wpy/88cYq4wNoEDC1yr/3jkvfdBkC9YlDwic
	 6GsnhvRaMbI7/apdxzRPlSq3nNjJ+RsTl5YvBAuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgBNPwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:52:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730951AbgBNPwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:52:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E21F24676;
        Fri, 14 Feb 2020 15:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695533;
        bh=XkJIbnairGNv5feCGTBQ9Yux6PNapzdcJ3bfivHLc5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVX+oDS7Hs98bW4amcV8SSKOVgDul9kjFK33ZussvA+/RZbla8mHv3HMTRtjEjOFA
         N1LZRAZPcN2z/rOuJRDTidWt4Z1uo7f1UJs9BIriouoFzgieCtp1SLJKW9qckFnKkG
         O+4/+ihdwWzD1IFstx7PGAdHbXT5gbsUy4X0HSuk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 153/542] drm/gma500: remove set but not used variable 'is_hdmi','is_crt'
Date:   Fri, 14 Feb 2020 10:42:25 -0500
Message-Id: <20200214154854.6746-153-sashal@kernel.org>
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

[ Upstream commit 834c43a97f341d319aa7b74099bbce2c4e75bc72 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/gma500/cdv_intel_display.c: In function cdv_intel_crtc_mode_set:
drivers/gpu/drm/gma500/cdv_intel_display.c:594:7: warning: variable is_hdmi set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/gma500/cdv_intel_display.c: In function cdv_intel_crtc_mode_set:
drivers/gpu/drm/gma500/cdv_intel_display.c:593:7: warning: variable is_crt set but not used [-Wunused-but-set-variable]

They are not used since commit acd7ef927e06 ("gma500:
Update the Cedarview clock handling")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/1573828027-122323-4-git-send-email-zhengbin13@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/gma500/cdv_intel_display.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_display.c b/drivers/gpu/drm/gma500/cdv_intel_display.c
index 8b784947ed3b9..334a203d62555 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_display.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_display.c
@@ -582,8 +582,8 @@ static int cdv_intel_crtc_mode_set(struct drm_crtc *crtc,
 	struct gma_clock_t clock;
 	u32 dpll = 0, dspcntr, pipeconf;
 	bool ok;
-	bool is_crt = false, is_lvds = false, is_tv = false;
-	bool is_hdmi = false, is_dp = false;
+	bool is_lvds = false, is_tv = false;
+	bool is_dp = false;
 	struct drm_mode_config *mode_config = &dev->mode_config;
 	struct drm_connector *connector;
 	const struct gma_limit_t *limit;
@@ -607,10 +607,7 @@ static int cdv_intel_crtc_mode_set(struct drm_crtc *crtc,
 			is_tv = true;
 			break;
 		case INTEL_OUTPUT_ANALOG:
-			is_crt = true;
-			break;
 		case INTEL_OUTPUT_HDMI:
-			is_hdmi = true;
 			break;
 		case INTEL_OUTPUT_DISPLAYPORT:
 			is_dp = true;
-- 
2.20.1

