Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C931C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633FB20776
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 20:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R5D8rBaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgFPUhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 16:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgFPUhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 16:37:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F6EC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:37:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b7so1501923pju.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 13:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjDHEijxA5jX/NCAw6/eQbUNUcsi5uFiyeIKic4MZ28=;
        b=R5D8rBaJGQqskgZLnAm4lfOrO2TTpKw1JUeusk2w0ksw2Mqg9gf4SEXqUB8NhgxF4M
         +COlgnE114HAwhXWlfOwUJXhLfcRH/JthVfWq/QNvj6AfcoiQvh5AOIGAxfU2GxjFELh
         c01s4x1Xth7X5Rly3rrCHqRQjtRPqXNQCnnvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjDHEijxA5jX/NCAw6/eQbUNUcsi5uFiyeIKic4MZ28=;
        b=REHFuFGZc4gGyldDwRCqxZSo4zRLffIbKRchxtZlNQmzTzhGXd+pnyAJOZEa7nBi6a
         +akAw5rvaTMa+6h1zFdaKHngY7djX9Gtdq7CzYSh+3PwrdAZDIo9ZetVaWzSqhTkSMxR
         S/2vS32FggTAna43l6/jnusMxLanaV/WCL06uY5BlRiSCJ22SgE1T3eBz12uHkXIL1Wr
         FsSAUUt1AmKsiefpJhj8GIq1WEavVWhZ4GXs7YRjTi0XvBXGK00NIPVEZ/mWJ1rQPQJl
         IDGhkZzljEGUDJgmLdy5LJuxQgBOzICSETS0HdDET2IK7k7QdTMc4Sm0vAIS2hAIioSD
         ekqg==
X-Gm-Message-State: AOAM530gAdsj7jkrntUvPEaCSY+wBHW2h6NiBBQmvcbHGr7Vvq4xTGlp
        OseTqbfl43UHqEyGFmdIOEt32AfsyjE=
X-Google-Smtp-Source: ABdhPJxpFyy6tkXgIAY+58Fe1gDOxV5E6IqGluSe/o8T0/HOtLkWJiJJ1dP0HZ7PHtnA832kJeEd0Q==
X-Received: by 2002:a17:902:bd0b:: with SMTP id p11mr3552194pls.91.1592339860776;
        Tue, 16 Jun 2020 13:37:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id z9sm3232116pjr.39.2020.06.16.13.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 13:37:40 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] usb: dwc3: qcom: Make sure core device is fully initialized before it is used
Date:   Tue, 16 Jun 2020 13:37:37 -0700
Message-Id: <20200616133734.1.I1902d0d48e4f3d4c5b5f1a2008108a4cd3c5ddb5@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dwc3_qcom_of_register_core() uses of_platform_populate() to add
the dwc3 core device. The driver core will try to probe the device,
however this might fail (e.g. due to deferred probing) and
of_platform_populate() would still return 0 if the device was
successully added to the platform bus. Verify that the core device
is actually bound to its driver before using it, defer probing of the
dwc3_qcom device if the core device isn't ready (yet).

Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver").
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
depends on:
  https://lore.kernel.org/patchwork/patch/1251661/ ("driver core:Export
    the symbol device_is_bound")

 drivers/usb/dwc3/dwc3-qcom.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 1dfd024cd06b..5a9036b050c6 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -537,6 +537,16 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/*
+	 * A successful return from of_platform_populate() only guarantees that
+	 * the core device was added to the platform bus, however it might not
+	 * be bound to its driver (e.g. due to deferred probing). This driver
+	 * requires the core device to be fully initialized, so defer probing
+	 * if it isn't ready (yet).
+	 */
+	if (!device_is_bound(&qcom->dwc3->dev))
+		return -EPROBE_DEFER;
+
 	return 0;
 }
 
-- 
2.27.0.290.gba653c62da-goog

