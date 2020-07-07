Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA3FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A173A206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135819;
	bh=S7eiGmRuaKWDe8sT0Q/XHhWd/GxK3Pp5c+OTWM4esxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S7gR/NAlz7bf7hGECoMI04dcv9YW9LlVYsqwNNoV5TSYB2puy7VeHSGV8lmqssQxY
	 P11So6zzxSRUJx5cuWpK+8TDe7QO/Mus/5n4olw/tj3jZEwuVc3oK6qOQQACVe638N
	 c+rtYVn3AP4mvyMI5Mlcwj61urKhhWhhD5VbXdFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgGGPaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728765AbgGGPYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:24:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61D582065D;
        Tue,  7 Jul 2020 15:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135454;
        bh=S7eiGmRuaKWDe8sT0Q/XHhWd/GxK3Pp5c+OTWM4esxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yt0oRvAYVHymXdL7FY4RWa9GgYef9ArHaTgzkh5fFNzkcCitreoqUjIprn81PjMGo
         hzap825mtB+hXaMpTy4Djxj3L78VkvDNzipx/ABLE0ZPGCFaR0L3G2/cn1qnGUs2r4
         UK+ep/t2U8p/mXvti8rM0O3hbg6SupCbdwSeJebw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen Tao <chentao107@huawei.com>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 047/112] drm/msm/dpu: fix error return code in dpu_encoder_init
Date:   Tue,  7 Jul 2020 17:16:52 +0200
Message-Id: <20200707145803.244395838@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145800.925304888@linuxfoundation.org>
References: <20200707145800.925304888@linuxfoundation.org>
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
index a1b79ee2bd9d5..a2f6b688a9768 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2173,7 +2173,7 @@ struct drm_encoder *dpu_encoder_init(struct drm_device *dev,
 
 	dpu_enc = devm_kzalloc(dev->dev, sizeof(*dpu_enc), GFP_KERNEL);
 	if (!dpu_enc)
-		return ERR_PTR(ENOMEM);
+		return ERR_PTR(-ENOMEM);
 
 	rc = drm_encoder_init(dev, &dpu_enc->base, &dpu_encoder_funcs,
 			drm_enc_mode, NULL);
-- 
2.25.1



