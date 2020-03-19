Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C4AC4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 04:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6782071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 04:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tg2aN6xt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgCSEjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 00:39:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45348 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgCSEjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 00:39:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id m15so534227pgv.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 21:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ruMvWKaCTsbInQhs/V5bAwFT4fo/B2LhqokROVX1RJo=;
        b=tg2aN6xtBRVVIsylVN35uS278/h81kU5E3rrZb4l9rasLTWQ0gO2RA0UvpzzCntSPD
         ZPIiYQ8t6hnvWpKofzzGzll+jfkqbYURB0VtpYDjsIKqvD4B3bKHij1aLEY1qdFdWFUR
         6II5O54rz9PrCLotYrETJh1NIQT3fKEtfL/DUGC2rs/BPsqoqb+egLQnKbiBy7uwf55n
         U+kLTmtbRTdj3d3FG0Jk7dNBxxYhnOvKmqe0Oau6zQGq5nEoJVoE1nooNnvWQxELdLl8
         0bNe9Qqfe61hyW/e5KaoNY32tTxagRuyKyaKC1epbe1ve6VNNVmKXpriu+88+RagG67M
         Ixvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ruMvWKaCTsbInQhs/V5bAwFT4fo/B2LhqokROVX1RJo=;
        b=rN1D5dF2LaZWZa1EXPhQwc4ZaGgKuqFsTU6ofd+PQb6uvZY90xAi8++Zm4YL6M0N2L
         nb6ns0czJchFQYvnnItRlKlnlV8Po717jqqk5JQmKohjAH8mseMbIjmWR678+IFM2WlK
         lV57I3X5aUhR2HlKWltb5FGspDmUjQU+oVGYSo/dcXMV07pOCuPVnVJUvnbscLJnP2lK
         jBFkiK5JFFaUHctndprKmDuD8lUuQrVwr/Ypk0qnDNdSw7ekNtHSleq+XcyWQpJpXLFA
         gH24wXt9BDTz+CJdCw6LAxpe+0gMJ5TNkow3touRFOwBWwx29aoLtkQ91DAjHHin+iwG
         UYhg==
X-Gm-Message-State: ANhLgQ3zx6FiWsIlRzFlmTFEHLgWOUIt3XzYIsF7xoI5RUqi0SvtlQDz
        PyXDPnYvH5wF/PDZBuk+soXCgrXTv/Y=
X-Google-Smtp-Source: ADFU+vvT12s0aAoLNNrPFmHAx5hQiycl6q/fBkWc1OwJE6FPv7umjTrZuM7h/FPuLb8vCrLAF5uWdw==
X-Received: by 2002:a63:2a4b:: with SMTP id q72mr1309267pgq.441.1584592760401;
        Wed, 18 Mar 2020 21:39:20 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 25sm571370pfn.190.2020.03.18.21.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 21:39:19 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: Don't attempt to attach HDMI bridge twice
Date:   Wed, 18 Mar 2020 21:37:41 -0700
Message-Id: <20200319043741.3338842-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of '3ef2f119bd3e ("drm/msm: Use
drm_attach_bridge() to attach a bridge to an encoder")' the HDMI bridge
is attached both in msm_hdmi_bridge_init() and later in
msm_hdmi_modeset_init().

The second attempt fails as the bridge is already attached to the
encoder and the whole process is aborted.

So instead make msm_hdmi_bridge_init() just initialize the hdmi_bridge
object and let msm_hdmi_modeset_init() attach it later.

Fixes: 3ef2f119bd3e ("drm/msm: Use drm_attach_bridge() to attach a bridge to an encoder")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 6e380db9287b..0e103ee1b730 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -271,31 +271,18 @@ static const struct drm_bridge_funcs msm_hdmi_bridge_funcs = {
 /* initialize bridge */
 struct drm_bridge *msm_hdmi_bridge_init(struct hdmi *hdmi)
 {
-	struct drm_bridge *bridge = NULL;
 	struct hdmi_bridge *hdmi_bridge;
-	int ret;
+	struct drm_bridge *bridge;
 
 	hdmi_bridge = devm_kzalloc(hdmi->dev->dev,
 			sizeof(*hdmi_bridge), GFP_KERNEL);
-	if (!hdmi_bridge) {
-		ret = -ENOMEM;
-		goto fail;
-	}
+	if (!hdmi_bridge)
+		return ERR_PTR(-ENOMEM);
 
 	hdmi_bridge->hdmi = hdmi;
 
 	bridge = &hdmi_bridge->base;
 	bridge->funcs = &msm_hdmi_bridge_funcs;
 
-	ret = drm_bridge_attach(hdmi->encoder, bridge, NULL, 0);
-	if (ret)
-		goto fail;
-
 	return bridge;
-
-fail:
-	if (bridge)
-		msm_hdmi_bridge_destroy(bridge);
-
-	return ERR_PTR(ret);
 }
-- 
2.24.0

