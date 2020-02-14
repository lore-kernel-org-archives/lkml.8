Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E837EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1C5222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704097;
	bh=CRDxD14ZKtU6RO/ItcSRnZiC1A5zVYWTUHZYtVKcMlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L0OjfSqZa9UJ8T77h6h249oZcN3DzsRBfqoUyxdfAJsFr/xehFBMZyJbgk6tjAK6T
	 YoOVAtB9jAgXOk9cLv+SbMrXMxFgb4EmdzX9TwrBOhl10eWXQz4bXf8nMVaEXASQzy
	 wregCE5OQffaHBgOlMWzr8RDO3qfpJSmUYPmMGzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394151AbgBNSO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:14:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730943AbgBNPwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:52:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F63124673;
        Fri, 14 Feb 2020 15:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695531;
        bh=CRDxD14ZKtU6RO/ItcSRnZiC1A5zVYWTUHZYtVKcMlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fKFKmWxXqB5PnmNYnl1k6RIZt4Y752PyYnw9WRULV3qQIA4Uvrm+APSLwUZTN8kLk
         ASsZrSAjjNCMdPlUIIE+P7ciIm3E0v5zJWvw3YubTWBlmm5z7RTnzvQ5vZNL40FIPM
         cApKew5HkZ/0VaMcXuzcEDH8AK64cckwaIsUFRmQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 151/542] drm/gma500: remove set but not used variable 'htotal'
Date:   Fri, 14 Feb 2020 10:42:23 -0500
Message-Id: <20200214154854.6746-151-sashal@kernel.org>
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

[ Upstream commit dfa703b6f91818fa9f652c00e3589c104c518930 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/gma500/oaktrail_hdmi.c: In function htotal_calculate:
drivers/gpu/drm/gma500/oaktrail_hdmi.c:160:6: warning: variable htotal set but not used [-Wunused-but-set-variable]

It is introduced by commit 39ec748f7174 ("gma600: Enable HDMI support"),
but never used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/1573828027-122323-2-git-send-email-zhengbin13@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/gma500/oaktrail_hdmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index f4c520893ceb6..f4370232767d3 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -159,9 +159,7 @@ static void oaktrail_hdmi_audio_disable(struct drm_device *dev)
 
 static unsigned int htotal_calculate(struct drm_display_mode *mode)
 {
-	u32 htotal, new_crtc_htotal;
-
-	htotal = (mode->crtc_hdisplay - 1) | ((mode->crtc_htotal - 1) << 16);
+	u32 new_crtc_htotal;
 
 	/*
 	 * 1024 x 768  new_crtc_htotal = 0x1024;
-- 
2.20.1

