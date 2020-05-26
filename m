Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC144C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 03:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79CD920706
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 03:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="GTWzOqvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388728AbgEZDXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 23:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388706AbgEZDXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 23:23:03 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB335C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 20:23:02 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id fb16so8860708qvb.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 20:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AWAnzxFlBG6fffzFUdxDOCWUGLZUTqYmdG/nfLxRIYw=;
        b=GTWzOqvEA7APlKZrtWytxI3UiIPa9Y6MaUsjnygPQbcUyaVx4c8XiCqiNr7Cff/a9G
         KgjjDLdUPGOfF7m9HbgzYwegRZ28LwBDg8+/wHxjDDe2zYW/RU5qqo50EXMqB5rfxOB7
         Fhmi6xUUmFAA6ClbRVu/6DWDq/MJWeN/LcpMRH89Vt1qVWcMNTtNRo+rYJE80hL6au+5
         BvNQuPooPe8liULVPK/iZkNHC++tBaF4M0at4yOAAPYbVW86K4Dqh+ITCYl+ipj7ufOF
         Q/ayVJCWCKD9JqufTNPlTcwRadXX/x/k4NoHaJPkyPyCto0vOwXgTGv+1Eqd1ACMJZsx
         idtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AWAnzxFlBG6fffzFUdxDOCWUGLZUTqYmdG/nfLxRIYw=;
        b=pB+1D8nCYMLwv7BhA4fpqAM1rcVY16RAtqT/FqcBUV9cVeoGHd6nH4rU9vsT2LhBOr
         2QO/M+uZl8BofIz+vIE9t09NazSzOQCQqi+x3BuYCsRZw1w1346ZiX+uc7db2kS/Ido/
         tTYF5AwKtRikO0haYDJeq0j1w9LCDXmlApG4Z2HijsZaxHMCONix6CEpJPyzcD2n5ulH
         0SAT+kFyuBNR2T5Qupera5IVl1nMPLS4lOz1Ri2ukwSsp6UlxphA8hXkDbcm3qPiaFfW
         YAq/MyYxwaJflxvffk6r5eVjtlDjUZ3QECvHTXWdbHkWcupRB3oIlxXA3daqGPVzRRSU
         9thw==
X-Gm-Message-State: AOAM532lIvPY+jbfXt/9WifF0e1r9iMwsc6+P3l1GF8n08ciC7mN25rc
        0GwWc82N/fry9huGP6F2tsASOQ==
X-Google-Smtp-Source: ABdhPJwQ99YZM55+rNFn66oLsnyuqhfzXbeGT/sUdIanmJgqga8K7kurbsvipAlWTxcAKJBZ3WarOA==
X-Received: by 2002:ad4:5684:: with SMTP id bc4mr18783129qvb.85.1590463382263;
        Mon, 25 May 2020 20:23:02 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id k20sm2530796qtu.16.2020.05.25.20.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 20:23:01 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Allison Randal <allison@lohutok.net>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/8] drm/msm/dpu: set missing flush bits for INTF_2 and INTF_3
Date:   Mon, 25 May 2020 23:22:12 -0400
Message-Id: <20200526032235.21930-6-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200526032235.21930-1-jonathan@marek.ca>
References: <20200526032235.21930-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes flushing of INTF_2 and INTF_3 on SM8150 and SM8250 hardware.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 831e5f7a9b7f..996666afdd66 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -245,30 +245,14 @@ static int dpu_hw_ctl_get_bitmask_intf(struct dpu_hw_ctl *ctx,
 static int dpu_hw_ctl_get_bitmask_intf_v1(struct dpu_hw_ctl *ctx,
 		u32 *flushbits, enum dpu_intf intf)
 {
-	switch (intf) {
-	case INTF_0:
-	case INTF_1:
-		*flushbits |= BIT(31);
-		break;
-	default:
-		return 0;
-	}
+	*flushbits |= BIT(31);
 	return 0;
 }
 
 static int dpu_hw_ctl_active_get_bitmask_intf(struct dpu_hw_ctl *ctx,
 		u32 *flushbits, enum dpu_intf intf)
 {
-	switch (intf) {
-	case INTF_0:
-		*flushbits |= BIT(0);
-		break;
-	case INTF_1:
-		*flushbits |= BIT(1);
-		break;
-	default:
-		return 0;
-	}
+	*flushbits |= BIT(intf - INTF_0);
 	return 0;
 }
 
-- 
2.26.1

