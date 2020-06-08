Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608DCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF58206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="crI+dMdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgFHRtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730160AbgFHRtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:49:00 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B3EC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 10:48:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b7so173095pju.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8YyCBCbGrw0DIZ0MXUQK0lVQu61p/lQcR9/ys0P7l8=;
        b=crI+dMdfSYQau9vc9/yyK65ynELRvAs6mgoiidknTuRcDF9lKldNHf6Un61KThO6LE
         aBqIOsMppcw3sgF5IxZmYi6Vi+hGCW50d4PqH5aPGGzmglwhzfJxe0d+KFX5WCCsMNDx
         ofzFeFKmOIFr+i5FdRP+j44Jqmp71NbWE+Hv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8YyCBCbGrw0DIZ0MXUQK0lVQu61p/lQcR9/ys0P7l8=;
        b=nJNLP/d8r65kh+l+wSerAzeHmQtnvtvYp7nwkIZROd5QI0cj+yUSJVGElqxy0Bx7+h
         sn+T5oL76ZwNymAvYKfoVlXIDnz9weX3dwUAezUDg8ZoHQTD8md+ah958qafPyzowpw5
         6hHrNdrYP+GnhXJlWKpLSsz2HcHKRuirbz6FOskwkpaU6NItw1fGmj74nsWbLoWVhV6t
         J+6fv0AdsAh3fHyP2osiZrKAhowdp1HB6IwIBYDnSwU/PoMvCPvuvodCPEqC/3CvsxcC
         Kf6fWKJWQFSkAIKIIupPr6pW/m31rl3mZ/5D7R2B61vOovCJ4AVAtBhsZXHlzjvFG4br
         Bdmw==
X-Gm-Message-State: AOAM532DqLOzq9NydPM3jtJ76v9IjglSGesBTjq7mJD3YKiXfWBPRTch
        6gX13uR/VHYBXR1Zu5IdO5KeI4HSPvvInw==
X-Google-Smtp-Source: ABdhPJxDBcpzVSyypXwZzUR9uGeArOBaGnIrUgjorP9jdXDSPFLOIaEjQmAkCG5ko8oaACbKDzq5+Q==
X-Received: by 2002:a17:90b:915:: with SMTP id bo21mr469617pjb.52.1591638538722;
        Mon, 08 Jun 2020 10:48:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id n7sm162682pjq.22.2020.06.08.10.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 10:48:58 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     a.hajda@samsung.com, narmstrong@baylibre.com, sam@ravnborg.org
Cc:     robdclark@chromium.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, spanda@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/bridge: ti-sn65dsi86: Fix kernel-doc typo ln_polr => ln_polrs
Date:   Mon,  8 Jun 2020 10:48:34 -0700
Message-Id: <20200608104832.3.Ib616e311c48cc64b2cef11bd54d4a9cedc874bb1@changeid>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
In-Reply-To: <20200608104832.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
References: <20200608104832.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a kernel doc warning due to a typo:
  warning: Function parameter or member 'ln_polrs' not described in 'ti_sn_bridge'

Fixes: 5bebaeadb30e ("drm/bridge: ti-sn65dsi86: Implement lane reordering + polarity")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index fca7c2a0bcf9..1080e4f9df96 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -122,7 +122,7 @@
  * @supplies:     Data for bulk enabling/disabling our regulators.
  * @dp_lanes:     Count of dp_lanes we're using.
  * @ln_assign:    Value to program to the LN_ASSIGN register.
- * @ln_polr:      Value for the 4-bit LN_POLRS field of SN_ENH_FRAME_REG.
+ * @ln_polrs:     Value for the 4-bit LN_POLRS field of SN_ENH_FRAME_REG.
  *
  * @gchip:        If we expose our GPIOs, this is used.
  * @gchip_output: A cache of whether we've set GPIOs to output.  This
-- 
2.27.0.278.ge193c7cf3a9-goog

