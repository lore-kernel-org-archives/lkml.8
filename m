Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054EEC433EA
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60B020657
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="dk7x85B9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgGKAuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 20:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgGKAuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 20:50:21 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC65C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:50:20 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id k18so7090701qke.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SH81ocgF+oAHcpIFHcVCEtbEA/eMMo0Rk5aeuJez85E=;
        b=dk7x85B9jBSqI7kMWwQmPep7Pkq3sdXPexpRQmUWMhTwZ52iwjKKuxKtcbipHk7IYI
         8YG31wZnH0cwTX1hmClJ1RDV9ymQi2jZ9H5gb0U16msjGovfyDw9K/xkgi32Nvez02PC
         PDPvBFV8pR7VIk9walAh8IXIDpl7OxYqPUAuCW/ZQW/r4n7TWtgmRnfZxNBAoHrqFPwS
         GT/bgOtQo2ipBNLbsmXkQPf2QdUui4c3EX1H61CGOrmoOy51bNfysCVYlTTBhuKRfaF5
         soiQv8PL9EZRvHsUgqNFnlTrNEG755A52YMwu9R8M5K5ME5KlAhbLvIblN1Sk7yxN0dT
         Y38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SH81ocgF+oAHcpIFHcVCEtbEA/eMMo0Rk5aeuJez85E=;
        b=mnNyjFBLvxDrk6JN8RAgrGVuaKqBateUmBqyBSKX+0IsbrqNFbHKLOC9X4wOo5f2it
         YYGBllt6FniI2ktIhdgAMY6vOS1EOnB+d4nDgki0YcUfPdp3diUpq0UAZAdZnKrHm5qO
         sekP2AoY9OxnHMeuV4kbQ8Bae7O6Uc8Z1XYctRJszU6CK1aGUOSWWnxhLhLdOnvnxbgF
         uoMZ7hPWyuV7Zhk463SnQcJlngSRjpdpBnzTkrN6+6aAQECMr6cVzivv1yyokv3Oo8vD
         +n4lIDsvZjhG+JeqfrajQWnz2nbhNyfa9F2AzLcNlqtgpAVTcfNw70sSyFU3vRZK97tA
         07vQ==
X-Gm-Message-State: AOAM532kMDQEIg1f54WFVer5ZnSVNQVK0knVEKJPwG5/aa0f4cd7OZvh
        xt8eyww1E0/N7XCPtruU43VBJg==
X-Google-Smtp-Source: ABdhPJwKzjLiuX94fBfKmcTzf4I0K3ACIWPkWPoQt+kid5Kr+J3Euh9ydp8oQ5K7CTfbe49c39DuXQ==
X-Received: by 2002:a37:6758:: with SMTP id b85mr59916869qkc.238.1594428620058;
        Fri, 10 Jul 2020 17:50:20 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id g20sm10427510qtc.46.2020.07.10.17.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 17:50:19 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Shubhashree Dhar <dhar@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 5/8] drm/msm/dpu: set missing flush bits for INTF_2 and INTF_3
Date:   Fri, 10 Jul 2020 20:47:28 -0400
Message-Id: <20200711004752.30760-6-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200711004752.30760-1-jonathan@marek.ca>
References: <20200711004752.30760-1-jonathan@marek.ca>
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
index 613ae8f0cfcd..758c355b4fd8 100644
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

