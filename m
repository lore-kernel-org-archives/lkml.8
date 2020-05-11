Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350AEC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15536208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qWTJbnr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbgEKPNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729771AbgEKPNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:13:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C46C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:13:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i15so11412035wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vlw61OlVumX/d2M0wG2qsd09pZiyEa8J7pDk9+78L6c=;
        b=qWTJbnr7j2LaIlNqBLtUovGnLOeXzpUEj79L1tfzrl61lJZuqhe81ZAFhdLvDLIaGH
         SGWnGu3tcuveKaMB+kqnT+RQR7rf6pAYH7cpJcm9ZMoC8BhLXvyap38D0dC0yCtyFgcH
         YxQAeFemjLS+mg26zSAeuAbM5Uq0rpnU3WovoSwF5i7Pd39UaHIB+rX6DLlRso7dA6C6
         PaJ9XZx0v4vxw18NxWoMQe2FNYShWWA4t+i/zovr+TyUQgC9ZxV9ZiSmKLg30oRz2A8M
         EGK+Q/8VWbsVfFjy40+eo00rsBn6+l8Sf0q99XPm5mdGU8SC+RT87VV6ggMpvK6CYFPu
         +1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vlw61OlVumX/d2M0wG2qsd09pZiyEa8J7pDk9+78L6c=;
        b=TQocM31sntGsYadQcASo5JTlynV35bxfUFTRxa+fuQYS4V+F3Jg6WthylFjqntT/7o
         W4KYhV8mC17RA21s2oS9RQwhqz95fCkVH26Kv3/nKujFb3elQI/5uZP7yhF7wqJy0cvy
         OG64mCj50OamRgkKscQJh0oVhoq+6NdMFq1Lnn8HMW1MV9jUMhq1+8JiDPFTAKBIUIUn
         MaxB/0VNvp+3N1gvHt193Fa+AQMRPukOv3yw8FDRnyiScTu3EWQ2E1X8+Mg/WFbpxQEZ
         hwLrsvyUg12bH66v8vHvf73W27V9QXAi1kL2tJs02WcrCosJ9xgn6RG3lxGGWjw42DU9
         4olQ==
X-Gm-Message-State: AGi0PuaPpU7k6ESSwwUVAs8wawHEUpUYTsEWdrHtgv7vkXMroVAUneG3
        JJVXnHAGfF2z8kWIL2+Pl9cQEg==
X-Google-Smtp-Source: APiQypJck6SzVC6RgCrzdM94BSUk7cS7ewYGOs+Xur6bCQt2uSYsbCqawmtPMULqNk7CgMN+uGfccA==
X-Received: by 2002:a5d:6ad0:: with SMTP id u16mr16531576wrw.94.1589210021404;
        Mon, 11 May 2020 08:13:41 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t7sm15462181wrq.39.2020.05.11.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 08:13:40 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] slimbus: core: Set fwnode for a device when setting of_node
Date:   Mon, 11 May 2020 16:13:33 +0100
Message-Id: <20200511151334.362-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200511151334.362-1-srinivas.kandagatla@linaro.org>
References: <20200511151334.362-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

When setting the of_node for a newly created device, also set the
fwnode. This allows fw_devlink feature to work for slimbus devices.

Also, remove some unnecessary NULL checks. The functions in question
already do NULL checks.

Signed-off-by: Saravana Kannan <saravanak@google.com>
[Srini: removed unnecessary NULL check from other patch]
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 526e3215d8fe..1f3beee74fdf 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -162,9 +162,8 @@ static int slim_add_device(struct slim_controller *ctrl,
 	sbdev->ctrl = ctrl;
 	INIT_LIST_HEAD(&sbdev->stream_list);
 	spin_lock_init(&sbdev->stream_list_lock);
-
-	if (node)
-		sbdev->dev.of_node = of_node_get(node);
+	sbdev->dev.of_node = of_node_get(node);
+	sbdev->dev.fwnode = of_fwnode_handle(node);
 
 	dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
 				  sbdev->e_addr.manf_id,
-- 
2.21.0

