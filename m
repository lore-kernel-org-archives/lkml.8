Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7CBC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FEF20729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SFtaoChS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgG0XKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgG0XKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:10:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C9BC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 16:10:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f1so15894985wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 16:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=X+XgM3FnODj9118Te+p3joAjz7Jojf3SmbRCLLwhj1Q=;
        b=SFtaoChSIVBjn4GTxMr4LGqSJOcKGWnGwvCGbiqriyC4uOo8+dg9nmzgnPtRC7FTRh
         uOGbq3CCnd65nlR6sebeY0KzR9HYLloLLafgHKrURUl5gNbcmWUZ31YCxLBnxm5WGvk/
         I38E1IgL8ajV5rbM+SaB3Lr5yeWAwUctBsMx9TyiU8VAcKCis3jkYV1zps4UsuvBYTlK
         Q92nrF0djoq5tfDcCkk9WxR4m6r4+O36HUTR9KpuyFQoKyPHggmVP7Vqz+rk46tcdIqR
         hPW06x8x4/IQ/rQ3F1Jni60zOpob1/c/qtAVNTG2ItvtEOlov78ckaEwr6i3zu0wl9M6
         BCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X+XgM3FnODj9118Te+p3joAjz7Jojf3SmbRCLLwhj1Q=;
        b=W9M4eUBoisAXX1JSJ0cTMCrnwrU/ffarWoFtVPNt0mbvVOOwpJCKb6cXsOaUcwtEKZ
         L4NB8XMbaAmIE29XtshBYCfMWz9GoOwZM/FfYxP+5vnJlHFs+lxdQzk4GpplH4VW7iPH
         O3u0rGJKthO+nbrG48edVUY6VoX8zbvlefEct1opZotEQnrBGpx2YIMgZ5/1mCsOQrRn
         eJDjKOnYcptKqtGNUZIVWqB9BOF92mjqIS6hqJ6VJvsWXOZKg5JXpWClscO67z5FbNK4
         Sp0JLXgK7Xvx7+fnet3XWi/XFYWY59+DQGtxU8Nw16T2i1DiBBaIGZ2UsfQ/0MvU7y6J
         QlbQ==
X-Gm-Message-State: AOAM531rptk4AQHVdkJYStoCssYy8dLIb2rlRa6e9EVwAV9O4RuHmnzA
        ka56rO4kZbQwAEN+GTtATTZ4f7jt97cj/w==
X-Google-Smtp-Source: ABdhPJzZtV9IgcG34Ze8qQEdH3JL/CHLSiUvr9gZK/tVTWdYSUBgWbvgaxwCLT+zt2eZxNxYi/SrlQ==
X-Received: by 2002:a5d:678a:: with SMTP id v10mr16540345wru.423.1595891440468;
        Mon, 27 Jul 2020 16:10:40 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-131-168.adsl.proxad.net. [82.252.131.168])
        by smtp.gmail.com with ESMTPSA id w14sm14238251wrt.55.2020.07.27.16.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 16:10:39 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@linaro.org, andrzej.p@collabora.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com
Subject: [PATCH] thermal: core: Add thermal zone enable/disable notification
Date:   Tue, 28 Jul 2020 01:10:33 +0200
Message-Id: <20200727231033.26512-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the calls to enable/disable a thermal zone are centralized in a
call to a function, we can add in these the corresponding netlink
notifications.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9748fbb9a3a1..72bf159bcecc 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -509,6 +509,11 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 
 	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
+	if (mode == THERMAL_DEVICE_ENABLED)
+		thermal_notify_tz_enable(tz->id);
+	else
+		thermal_notify_tz_disable(tz->id);
+
 	return ret;
 }
 
-- 
2.17.1

