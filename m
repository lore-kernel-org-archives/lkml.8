Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873F2C47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F4724954
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VPEPKfr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgEHW7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 18:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgEHW7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 18:59:23 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215CDC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 15:59:23 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so1384967plt.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 15:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o4yPuc1IBO0Fpnm5cH3RYbHF1/VvJ8rseVz+WFhHEck=;
        b=VPEPKfr0LpFXRwKZseBAaugcPZIisNSbI8QDDiJ5iM7IDfqVfeloezY7Mx5OmrxuXJ
         n0fWKGZ6VaznJFxuCz+eQRHIKwjre+sRj8KVs5Rwrq+C/UWwJDgi5xda9Gf7lFEVTATy
         pryaY5dZVtK7IlkgvcMQje0Wi0ArhUEKlGh3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o4yPuc1IBO0Fpnm5cH3RYbHF1/VvJ8rseVz+WFhHEck=;
        b=Bw8fnvu97Ryma9FecoRS7qMVGsAhEw7aBYyEbKvCMn5lera6bAygezq8nb8LMGbBNC
         oCPuUoWFMWa38FtWbLnGKC66uCQtaPdv70inIFOXiXrIXkmQuMCZyed4k7OllAwIcx8k
         a1m6/34pUVRAcYILO7vxzvUP5Xbw0wGlng4h28BL919Kn3kmPZQOIPbcA+wywVDhGf/s
         SvF5FsoBiYeYyCDyoCRfYjdVeinApJpYk5Ohmr0PGEZWwfUDJphneuUeGJs2Cie+PImh
         uMQbKnEfpZBt0leFtohfx7NcTTbkYAbUCS5AvaSrg0xBOMBJ93hvdNuNpBDsv40nCjU7
         g/ow==
X-Gm-Message-State: AGi0PuYk33qJEAFcH4po8FOgnzvn+DNnjcxOgwRn2yPZrCOSEFH2UZv7
        QZ4UWCBP/MiXEVuUfIqnvRAxMw==
X-Google-Smtp-Source: APiQypLq9GOG18q+UNqlsvudYEAfECHIF4Ub5kQ4kC7q+ReXKvIaZAAJMf/RFYQ9gNVjy8LNt8MdNw==
X-Received: by 2002:a17:902:23:: with SMTP id 32mr4625148pla.40.1588978762408;
        Fri, 08 May 2020 15:59:22 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id i72sm3062874pfe.104.2020.05.08.15.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 15:59:21 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] panel: simple: Fix size and bpp of BOE NV133FHM-N61
Date:   Fri,  8 May 2020 15:59:00 -0700
Message-Id: <20200508155859.1.I4d29651c0837b4095fb4951253f44036a371732f@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BOE NV133FHM-N61 is documented in the original commit to be a
13.3" panel, but the size listed in our struct doesn't match.
Specifically:

  math.sqrt(30.0 * 30.0 + 18.7 * 18.7) / 2.54 ==> 13.92

Searching around on the Internet shows that the size that was in the
structure was the "Outline Size", not the "Display Area".  Let's fix
it.

Also the Internet says that this panel supports 262K colors.  That's
6bpp, not 8bpp.

Fixes: b0c664cc80e8 ("panel: simple: Add BOE NV133FHM-N61")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-simple.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index d6c29543e510..7219436499f1 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1189,10 +1189,10 @@ static const struct drm_display_mode boe_nv133fhm_n61_modes = {
 static const struct panel_desc boe_nv133fhm_n61 = {
 	.modes = &boe_nv133fhm_n61_modes,
 	.num_modes = 1,
-	.bpc = 8,
+	.bpc = 6,
 	.size = {
-		.width = 300,
-		.height = 187,
+		.width = 294,
+		.height = 165,
 	},
 	.delay = {
 		.hpd_absent_delay = 200,
-- 
2.26.2.645.ge9eca65c58-goog

