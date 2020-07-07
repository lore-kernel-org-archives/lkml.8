Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6249FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31CAE2065D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135236;
	bh=aeTibctQUtwyRVzBygrSOoljHRa45dwzMs7gCQgfONA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O/jlMmiGlnMtiF+ucUjnEHIJNSkDBhe2pg6CzZJC7eptEanKWuqeN6WouSK5DyikC
	 cniFY38kKTjWX4AyBIoEJNYzGVG7ePN2lxrQK68+Orw4iLoQmjatWX4DzckKzACvpQ
	 meJk1SYrl7vx/J3UiKfNYmfHy3DkkislFY1Mczuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgGGPUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728724AbgGGPUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:20:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCB6A20663;
        Tue,  7 Jul 2020 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135225;
        bh=aeTibctQUtwyRVzBygrSOoljHRa45dwzMs7gCQgfONA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5OhS8pcczrXa+NCEPKDS54ka7Ak/jue9QjAkF96Tnv1B9ncz0Bsm3VySTBJ67HgT
         mGTquXeM+8V8vGPbXb3hndxMfNN0ZpEQfBk5ypw7nYxIZ1dkCj7KT9ddYZa0ks0UwR
         c+MrF20Rv00oAExnGFmG/SXuX56U4UKS0NBhDJKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen Tao <chentao107@huawei.com>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 22/65] drm/msm/dpu: fix error return code in dpu_encoder_init
Date:   Tue,  7 Jul 2020 17:17:01 +0200
Message-Id: <20200707145753.557090037@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145752.417212219@linuxfoundation.org>
References: <20200707145752.417212219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Tao <chentao107@huawei.com>

[ Upstream commit aa472721c8dbe1713cf510f56ffbc56ae9e14247 ]

Fix to return negative error code -ENOMEM with the use of
ERR_PTR from dpu_encoder_init.

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Signed-off-by: Chen Tao <chentao107@huawei.com>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index d82ea994063fa..edf7989d7a8ee 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2232,7 +2232,7 @@ struct drm_encoder *dpu_encoder_init(struct drm_device *dev,
 
 	dpu_enc = devm_kzalloc(dev->dev, sizeof(*dpu_enc), GFP_KERNEL);
 	if (!dpu_enc)
-		return ERR_PTR(ENOMEM);
+		return ERR_PTR(-ENOMEM);
 
 	rc = drm_encoder_init(dev, &dpu_enc->base, &dpu_encoder_funcs,
 			drm_enc_mode, NULL);
-- 
2.25.1



