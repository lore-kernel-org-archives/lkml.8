Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768C9C47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 23:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A6B20731
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 23:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c2jrSafQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgEHXdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 19:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgEHXdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 19:33:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6CDC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 16:33:52 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d184so1777810pfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 16:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aH8P4+Ei6pqqMKSRAGY6lrlBj9MTJLPAq1y54tH7x5M=;
        b=c2jrSafQfRhEZd9jTfLKbDy93UfmN/2t2IeoD8u5JqRk43Wn2SFjno2k+3fw8Ww7ha
         m/86nRlyZIcjbgT65I6GDky8MnlZk9UJacJo9vtbWrY6C2A8oO28CkrUfd8wSgbGF8ot
         w3YXATiZu/A7UtV8gDeP4jKT01vaiwWb7Walg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aH8P4+Ei6pqqMKSRAGY6lrlBj9MTJLPAq1y54tH7x5M=;
        b=ZqSY0HcG1CoG+g+XVoyE/gHCGtr+uDiUcMqlJAuMXPole1pKBi4jARCbCPDtwqUV9Y
         L6evK4aIkqD6aPuKkT3PgqvjGqpEmExFM0XvARo9/fwciMMHXxxhsDYdgtFqmsqQtgE7
         fIJs1sw1wgDBZr7KK2piCVJJrs6P+NeYNVHH2B+BHzse7O+A1C1BFGIbe1LEoqZSIo5f
         JSyKyp0d1e8z/wT7paf+EBwE99OmKsRWlpRkuBYHvsGavMy8myKzrMPuM2rD+gK45iFw
         IJeY7Qq9qaqbm1K3kP+LVv5NaJTel9/vq2rIoA/+zHHKsFD6Nrm+Hk3cmLUWIGJ3B8si
         EA4w==
X-Gm-Message-State: AGi0PuYiPaoIdJYMYJrvO0f8bfS1DUtBqKqOrKtjHo2bQ1bw8CkZQEg1
        0SSUDJDX9XQSugoK8p34KX6czg==
X-Google-Smtp-Source: APiQypJvhMuGbXg+gBKnMJeVTmbSCsAWmHD2jkpOVJl3TZQ859+Dq6ODnzjWWTM/O3Ntaprp3YQ5hw==
X-Received: by 2002:a63:575f:: with SMTP id h31mr3707439pgm.200.1588980831399;
        Fri, 08 May 2020 16:33:51 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p66sm2713991pfb.65.2020.05.08.16.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 16:33:50 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     linux-arm-msm@vger.kernel.org, seanpaul@chromium.org,
        robdclark@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sandeep Panda <spanda@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: ti-sn65dsi86: Clear old error bits before AUX transfers
Date:   Fri,  8 May 2020 16:33:29 -0700
Message-Id: <20200508163314.1.Idfa69d5d3fc9623083c0ff78572fea87dccb199c@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AUX channel transfer error bits in the status register are latched
and need to be cleared.  Clear them before doing our transfer so we
don't see old bits and get confused.

Without this patch having a single failure would mean that all future
transfers would look like they failed.

Fixes: b814ec6d4535 ("drm/bridge: ti-sn65dsi86: Implement AUX channel")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 6ad688b320ae..d865cc2565bc 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -827,6 +827,12 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 				     buf[i]);
 	}
 
+	/* Clear old status bits before start so we don't get confused */
+	regmap_write(pdata->regmap, SN_AUX_CMD_STATUS_REG,
+		     AUX_IRQ_STATUS_NAT_I2C_FAIL |
+		     AUX_IRQ_STATUS_AUX_RPLY_TOUT |
+		     AUX_IRQ_STATUS_AUX_SHORT);
+
 	regmap_write(pdata->regmap, SN_AUX_CMD_REG, request_val | AUX_CMD_SEND);
 
 	ret = regmap_read_poll_timeout(pdata->regmap, SN_AUX_CMD_REG, val,
-- 
2.26.2.645.ge9eca65c58-goog

