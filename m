Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E57C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A492067D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581699318;
	bh=97idC7HR8p/LOff1a/Sz0B0Sg2Vysa5wF7lpSwiKO1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tT3gSUjEpsPKppko+SXyDzsFoGAFzQfheITPnJmJQpLirUlvezpkdllCZ9TdEBfhJ
	 cN8LIyDxP8P30cQEwLETZuPz1M6PSElqE1FD1hjpiYXIud5G/uw4wFxlef1lwrsCNK
	 l188G8c7vn1nDthfXFnq0UomNFCVfHOt2Ntvg83c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394212AbgBNQzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:55:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404715AbgBNQSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:18:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E059724701;
        Fri, 14 Feb 2020 16:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697102;
        bh=97idC7HR8p/LOff1a/Sz0B0Sg2Vysa5wF7lpSwiKO1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hbk56kMipj8N/uNTfevlWVWrdH5nordtWmGt1ykZL8iiVlogGIycik6cn+bt48Ne/
         TBz8TRSH2rcbFwq/uWypTpI9dyYCPpfk06ELZenqqONImIxW6u9sQBymQ1TjxpOw7r
         wqEIkrJsXVHri5EUA+h2W9/nR3IiooaspA+H41do=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 052/186] drm/gma500: remove set but not used variable 'htotal'
Date:   Fri, 14 Feb 2020 11:15:01 -0500
Message-Id: <20200214161715.18113-52-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
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
index 8b2eb32ee988b..6b403c3586fa0 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -157,9 +157,7 @@ static void oaktrail_hdmi_audio_disable(struct drm_device *dev)
 
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

