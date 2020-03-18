Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE46C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E078D20757
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3InRhON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgCRRnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:43:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35736 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgCRRnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:43:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so10922217wru.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UECOqhVXTO4WTSf9+88d/gPF4iTL0TltzwoS0jurVoE=;
        b=X3InRhONf0y9chdNCyUrwGPBhyZzqitwLnWsrU8JjKupUxbqtkc7V6VC6HcfCXXOft
         I0PXA8x/CCtdrIUiVr5p1NsD6Y8+0f8opR11H8+ILfj/m7q8NKrc/y/+JiKrwchtw2xz
         qVbDcHVYC6ugoTW3Bu0l4I84g0EkoJyKniBXIdiQwNHLQuNyTRdzNgaFkxpnhvZPwhYR
         hPygVET2zKSerO0oSB5EvdxVR5o6FQcBqz08D6y4ON0f/125tAA6qD6MuUzTEM2F5ZgS
         oDxlfpl6Bkqt0+hfPY/dTx/p3bVSf1e63/dDsh4l5VhLXt476/lLeCfUGTUsXjOn3NvH
         D9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UECOqhVXTO4WTSf9+88d/gPF4iTL0TltzwoS0jurVoE=;
        b=iVd4MfeIIhzVGR2xX+o4gdIxnIIh44wahhHd8ezHOTWGwy16tySChlCp563zX4Gp6E
         HvmG689cb89D0d7hszcdjEG/jPUSP9Pwl8PJVdgvYXcMtTh5Hqdbbpu9gpm+9jHBPExw
         0YAw8n8DTrXuWK8jJwY2TepH4SUwy5F9XuALEkoAN8T/BZDqvOgYG+cOpX8MZ+NYBBZk
         Sz1hUvmp3WnkkeWW6I0CWVKg5d+T8O5WWRhnkGO4J7DNPJz8/SntFKLK7VChfX64tADK
         L2VA/ptq1VfLG+HjTWyUbGLTMMyavLA69yDNKlyxo+df8KO8nRZ5B0j/rT+TH0l5Egtu
         E7Ew==
X-Gm-Message-State: ANhLgQ3TfSfAWwEPMGbXoLqxGdiStJ2wCXKT/Yl0TGTUUN0dZJJa3Wqk
        t/lcQvMFsKNDLjjWXpnod8WOa0hCRZY=
X-Google-Smtp-Source: ADFU+vud5NUiK1Xg7GRmepVK9v8BtqMIWNpQAcqBlzhe/pCplTvWGIegZBPVKCyD/aLw2elX5DXkaA==
X-Received: by 2002:a5d:490e:: with SMTP id x14mr7253568wrq.58.1584553387588;
        Wed, 18 Mar 2020 10:43:07 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:43:07 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH 21/21] clocksource/drivers/timer-probe: Avoid creating dead devices
Date:   Wed, 18 Mar 2020 18:41:31 +0100
Message-Id: <20200318174131.20582-21-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318174131.20582-1-daniel.lezcano@linaro.org>
References: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
 <20200318174131.20582-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

Timer initialization is done during early boot way before the driver
core starts processing devices and drivers. Timers initialized during
this early boot period don't really need or use a struct device.

However, for timers represented as device tree nodes, the struct devices
are still created and sit around unused and wasting memory. This change
avoid this by marking the device tree nodes as "populated" if the
corresponding timer is successfully initialized.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200111052125.238212-1-saravanak@google.com
---
 drivers/clocksource/timer-probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
index ee9574da53c0..a10f28d750a9 100644
--- a/drivers/clocksource/timer-probe.c
+++ b/drivers/clocksource/timer-probe.c
@@ -27,8 +27,10 @@ void __init timer_probe(void)
 
 		init_func_ret = match->data;
 
+		of_node_set_flag(np, OF_POPULATED);
 		ret = init_func_ret(np);
 		if (ret) {
+			of_node_clear_flag(np, OF_POPULATED);
 			if (ret != -EPROBE_DEFER)
 				pr_err("Failed to initialize '%pOF': %d\n", np,
 				       ret);
-- 
2.17.1

