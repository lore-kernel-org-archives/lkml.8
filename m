Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3025BC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0238722CF6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261235;
	bh=MbpAOcmxmJ3/76UpuuG0kEC1olXjWqtvwjSncmz/L8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GVZxPeobW0J3r53rzstOyrKmHc3bhuChfjXIpIta/TthmziWWB6ddAWymn9qisR0P
	 mfR5YCGpnJ8oWPoP3QG/zsOwO+Xv244GGFV9cFfpSxZ1Q3vxlooDcAXEJq8+yZyBjv
	 RHUQYeEUFA5rtIFCptsCndQeblmMAO4GHbzqlIFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732867AbgGTQHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733066AbgGTQGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:06:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 659362064B;
        Mon, 20 Jul 2020 16:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261211;
        bh=MbpAOcmxmJ3/76UpuuG0kEC1olXjWqtvwjSncmz/L8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MiKBWkYVtK7XS6EUJRoV1ZUESaq/ZVIg29VHXUGfSAJXGwGcGd1NipYtbFnGhmVVp
         sTTzktbZHzlyWNl5AkZqBNn4jnjqqose7hEaHUzrhSDEUdy6CVGUdyX9aRkVlXL+D1
         rINttFLywk+4cj1Yx7xKTpkyoKepEeEVM/X9N5+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 033/244] drm/msm/dpu: allow initialization of encoder locks during encoder init
Date:   Mon, 20 Jul 2020 17:35:04 +0200
Message-Id: <20200720152827.440349646@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krishna Manikandan <mkrishn@codeaurora.org>

[ Upstream commit 2e7ec6b5297157efabb50e5f82adc628cf90296c ]

In the current implementation, mutex initialization
for encoder mutex locks are done during encoder
setup. This can lead to scenarios where the lock
is used before it is initialized. Move mutex_init
to dpu_encoder_init to avoid this.

Signed-off-by: Krishna Manikandan <mkrishn@codeaurora.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index a2f6b688a9768..932dd8c3c4118 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2126,7 +2126,6 @@ int dpu_encoder_setup(struct drm_device *dev, struct drm_encoder *enc,
 
 	dpu_enc = to_dpu_encoder_virt(enc);
 
-	mutex_init(&dpu_enc->enc_lock);
 	ret = dpu_encoder_setup_display(dpu_enc, dpu_kms, disp_info);
 	if (ret)
 		goto fail;
@@ -2141,7 +2140,6 @@ int dpu_encoder_setup(struct drm_device *dev, struct drm_encoder *enc,
 				0);
 
 
-	mutex_init(&dpu_enc->rc_lock);
 	INIT_DELAYED_WORK(&dpu_enc->delayed_off_work,
 			dpu_encoder_off_work);
 	dpu_enc->idle_timeout = IDLE_TIMEOUT;
@@ -2186,6 +2184,8 @@ struct drm_encoder *dpu_encoder_init(struct drm_device *dev,
 
 	spin_lock_init(&dpu_enc->enc_spinlock);
 	dpu_enc->enabled = false;
+	mutex_init(&dpu_enc->enc_lock);
+	mutex_init(&dpu_enc->rc_lock);
 
 	return &dpu_enc->base;
 }
-- 
2.25.1



