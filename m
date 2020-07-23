Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE6FC433F8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F01422B43
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+0A1dF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbgGWP1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729650AbgGWP1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:27:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AFCC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f2so5561803wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kHJ+XeVbi6Fqf64rZGsvMfPCwEnJl/mkyREvWYHyzSs=;
        b=P+0A1dF9XopiITzqpUXhrqYmXagxXC05lz3m9je4nXa09TlHs3Wgl5NkZ0dwKPljj2
         bNncZ1E7bxQNsrC/daqJTPVx6+DR9vV0FUpip0Mlr9OBTSfLqwdtXzIm58MPKJKFzObE
         cIjpP033bIrzzrX3Y5KuGgYSb440xS3POfuAAbN4D9qJw40M15PMKTTvT0RlBOA/xah7
         jrNBC+cdGHmi2ZD68Vrkz0Wgn+QR+TJfdasmgUd1YS7DHC9ysFNoMs5dSOGQoi10EXha
         9tJWIgJ5ofi5CyoYnQwfoDlc3GN27Gk9rFaq8B6bJGI1x8Qj3Jr3Q8FgFoBPYjO6rAWf
         deDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kHJ+XeVbi6Fqf64rZGsvMfPCwEnJl/mkyREvWYHyzSs=;
        b=AobLoDVG2Mj83nxiwYbPYwlrxaj6TMOL/NZxNzVoWgOOQ5Hl0U2pYGkc2HKLAMjd8J
         tamqrZUz3DPWb6Z4wuczgZShM+xcTZkT6Y9huDprX0GHFNbiS2eyDQkskmDTWr4p8rjc
         e8WfTlVQc9eHdZRTlpKf810Vcbo27tXmv3xrz3vEcbSheLayb4vkzgFMkpkab+xK5vhC
         QC6BeVxFiyf+SyWtKKseaW37hawbb33WtDr4W4EBDi+zo+uVIOHYJXqb4ghThs9Z7qIL
         chSAijExPaE9XwMbLut5lkf6PD5tzeEfnBYO46O6MVhV14LoL36/ckKIn+P1oe4DOyEC
         6LrQ==
X-Gm-Message-State: AOAM530Zl6DDZzv6x4N8JdAV1nRgquXqq57qkKIOC2dmlmaUUdi9Rkgf
        OvKrycDL8ZraFhiBx6gB/yhl8g==
X-Google-Smtp-Source: ABdhPJxto3SkmLheNic/ExNkEwYZALuchouPqArggo5mcpv1XGq50mFFFcZ22obJHZIjt6mM3FIe5A==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr4471366wrq.401.1595518030564;
        Thu, 23 Jul 2020 08:27:10 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:dca7:8d30:33fa:daac])
        by smtp.gmail.com with ESMTPSA id g145sm5963491wmg.23.2020.07.23.08.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:27:10 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 14/16] clocksource/drivers: Replace HTTP links with HTTPS ones
Date:   Thu, 23 Jul 2020 17:26:34 +0200
Message-Id: <20200723152639.639771-14-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723152639.639771-1-daniel.lezcano@linaro.org>
References: <1b1122f4-bce9-f349-e602-ed8e14cbb501@linaro.org>
 <20200723152639.639771-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Alexander A. Klimov" <grandmaster@al2klimov.de>

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200708165856.15322-1-grandmaster@al2klimov.de
---
 Documentation/devicetree/bindings/timer/ti,keystone-timer.txt | 2 +-
 drivers/clocksource/timer-ti-32k.c                            | 2 +-
 drivers/clocksource/timer-ti-dm.c                             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/ti,keystone-timer.txt b/Documentation/devicetree/bindings/timer/ti,keystone-timer.txt
index 5fbe361252b4..d3905a5412b8 100644
--- a/Documentation/devicetree/bindings/timer/ti,keystone-timer.txt
+++ b/Documentation/devicetree/bindings/timer/ti,keystone-timer.txt
@@ -10,7 +10,7 @@ It is global timer is a free running up-counter and can generate interrupt
 when the counter reaches preset counter values.
 
 Documentation:
-http://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf
+https://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf
 
 Required properties:
 
diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index ae12bbf3d68c..59b0be482f32 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -21,7 +21,7 @@
  * Roughly modelled after the OMAP1 MPU timer code.
  * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
  *
- * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #include <linux/clk.h>
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 60aff087947a..33eeabf9c3d1 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -4,7 +4,7 @@
  *
  * OMAP Dual-Mode Timers
  *
- * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
  * Tarun Kanti DebBarma <tarun.kanti@ti.com>
  * Thara Gopinath <thara@ti.com>
  *
-- 
2.25.1

