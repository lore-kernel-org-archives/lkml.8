Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDDFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9970207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pGhwHR37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390244AbgFYGqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 02:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390110AbgFYGqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:46:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2230EC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:46:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h15so4597855wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+TE9kOk1Eo+Xge5t3lOhgSjVuYsSynXXEjCl45jZ/BE=;
        b=pGhwHR37tt09Kl/bFu1zOX6lNU6Dnj8LyCDuRPVubE+Z3M1gSrffbY1VbW9qfSaXiE
         CNdyWz9lJ0fYj2v5+22h8s0YXCpzND9580Dayad1kycUDReg+D/IhrDU/NO5omUJyCSS
         xU0riBAU+Vh4SJ/wHhIK/ZIpZTtQ5Onz2zI56sZxmVNSSRIV4b4DZ8c9HqWT7dlLN5sz
         Y7Aq86j9bH3VV4sB9SdCoQ8+MSmCO8TU6TZDLq8+hT02COCOq7IXFrO0ZftW8FWes2gN
         zulTt3y1vQ7kc9cNSnHlyPIHjPzBedtVnrUfpSSW0Y0qv6ls8pctACHJYSlHtWv6s8iz
         bjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+TE9kOk1Eo+Xge5t3lOhgSjVuYsSynXXEjCl45jZ/BE=;
        b=n/M8etLNYsPUZfJu0Pt69SC7YVbp3ZAkBKUnGABxL96EE6No9eDIMhs96BL1Oe/2mi
         hP/X7qQeALtedxubTwaW/70iIESlff17J86pGJZEQRk31vfG6j1IRlxqpabVve6L6fWY
         3r6S5lf4GGE6ni6GC2AFpX9ExGZBRdvHmsXOsXwUxGX9kQVbvMYEmi8v8TTU50qerqKR
         QVgBrE5NTuWslYRPUDz72/uhusY3znrnFPV1GoiqZ9dTRutu++AjOJPDqW21+iayZnhz
         yBnAWiwzf0q/uKQIpRezEObpqTqoLkgjjtfMKnAuCVVDIU899kS7HRVstNapt3q0Z9jl
         TroQ==
X-Gm-Message-State: AOAM531eqXzEsfpTzSmrQmUzSgX2hOkma1wEEMYee0krHfBlIYsjn2xM
        owQjQ1n/iMchECj8ZgX6LXehQA==
X-Google-Smtp-Source: ABdhPJytxUMgGBVPUzM3IOR72zdB3gVcybqT84W3fTE4JkO2L+7Fo++7itDizMNwfNXl2gA3TPz5/A==
X-Received: by 2002:adf:e749:: with SMTP id c9mr37817613wrn.25.1593067592886;
        Wed, 24 Jun 2020 23:46:32 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id c20sm27235363wrb.65.2020.06.24.23.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 23:46:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Keshava Munegowda <keshava_mgowda@ti.com>,
        Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org
Subject: [PATCH 06/10] mfd: omap-usb-host: Provide description for 'pdev' argument to .probe()
Date:   Thu, 25 Jun 2020 07:46:15 +0100
Message-Id: <20200625064619.2775707-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625064619.2775707-1-lee.jones@linaro.org>
References: <20200625064619.2775707-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc syntax is used, but not complete.  Arg descriptions required.

Prevents warnings like:

 drivers/mfd/omap-usb-host.c:531: warning: Function parameter or member 'pdev' not described in 'usbhs_omap_probe'

Cc: <stable@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/omap-usb-host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index f56cdf3149dc0..aca5a160c1b24 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -526,6 +526,8 @@ static const struct of_device_id usbhs_child_match_table[] = {
  * usbhs_omap_probe - initialize TI-based HCDs
  *
  * Allocates basic resources for this USB host controller.
+ *
+ * @pdev: Pointer to this device's platform device structure
  */
 static int usbhs_omap_probe(struct platform_device *pdev)
 {
-- 
2.25.1

