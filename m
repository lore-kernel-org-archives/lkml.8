Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC09C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39B972073E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UP8lLwyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbgFWHqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731041AbgFWHqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:46:47 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0928C061573;
        Tue, 23 Jun 2020 00:46:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i4so1190584pjd.0;
        Tue, 23 Jun 2020 00:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K7pLJ19JFWW+fjDOXAk3uKhCU5E/5p3QUJebzKwwRXw=;
        b=UP8lLwyP9OMkz/XR2W62pC5h2fQzhmIQvvW8UAK2dFCacKya/qkNNT1A6KlVxaj+Dw
         AU4Fjtc1SKhFsLz39puyCi0npCB9WsbEKYyZKSolVkSWqYdmxBi5lLd8C37rOG1eqA7j
         AIKsWmqGu5ormxrTgRPkd72CUCVYdEajCeB80cDKieAxrOMRsmHUN6J4l3vBqaXZydUd
         nuTtiGi4Sa3ikr8zFzrGsvQVbIRcqeoKJSsw/Ftu0s53ir/Uuc8BCOdH8/tyfYLlTpx5
         toOEwEF23LAgTaWRoy0M3Qp8VHQaf1wriigmlVF27fk7EjFFVCOGdiWAw99lgqLDvIPq
         udtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K7pLJ19JFWW+fjDOXAk3uKhCU5E/5p3QUJebzKwwRXw=;
        b=uNaNuzinCa5K/oHeuYkvAhnN9ckQLPdDjINJgpZEmKlpz0ivSUbjeQPfPZlM1UQCO5
         2h+1zBPzvhkbk7Q5JZf692a8N85NlKNmopyGiYJGvWd7X1bqOWMzWdH4qTTr6kSs5qse
         xEyIEGitIPEu3vqudFzpE0u3VjdM0QFFUTpUvJ0OlOqAyofpKprAbiJkWSrfWDwtNVoq
         TVeo11BsR2lP9BiHXzB5cEAjZgOFv0P4M0/PlByJ+1v5m041yWAUbz13QBOZNgTz7i3n
         EkJn12+EVOiEliwBbo1ad39jwyecVxafuVOmYnFmmEnjaSPZQmOERGXzednDFfGIwFHK
         57bA==
X-Gm-Message-State: AOAM530K9zUR+l1uG3BNjmU5qdZj6URStyM7yjHk737eAG55aL86+w53
        6IqQf3K24JBfMRKWEMPEkO6Ob9xW
X-Google-Smtp-Source: ABdhPJzqmg/USzmPszikwZIXmW+UZTIbGJSRpDpl9O5oDhBWqNjvORnAbzV9mh12ybPV0vEuUlMdvQ==
X-Received: by 2002:a17:90a:d485:: with SMTP id s5mr20970108pju.61.1592898406106;
        Tue, 23 Jun 2020 00:46:46 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.220])
        by smtp.gmail.com with ESMTPSA id i5sm15803522pfd.5.2020.06.23.00.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 00:46:45 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "usb: dwc3: exynos: Add support for Exynos5422 suspend clk"
Date:   Tue, 23 Jun 2020 07:46:37 +0000
Message-Id: <20200623074637.756-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 07f6842341abe978e6375078f84506ec3280ece5.

Since SCLK_SCLK_USBD300 suspend clock need to be configured
for phy module, I wrongly mapped this clock to DWC3 code.

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/usb/dwc3/dwc3-exynos.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index 48b68b6f0dc8..90bb022737da 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -162,12 +162,6 @@ static const struct dwc3_exynos_driverdata exynos5250_drvdata = {
 	.suspend_clk_idx = -1,
 };
 
-static const struct dwc3_exynos_driverdata exynos5420_drvdata = {
-	.clk_names = { "usbdrd30", "usbdrd30_susp_clk"},
-	.num_clks = 2,
-	.suspend_clk_idx = 1,
-};
-
 static const struct dwc3_exynos_driverdata exynos5433_drvdata = {
 	.clk_names = { "aclk", "susp_clk", "pipe_pclk", "phyclk" },
 	.num_clks = 4,
@@ -184,9 +178,6 @@ static const struct of_device_id exynos_dwc3_match[] = {
 	{
 		.compatible = "samsung,exynos5250-dwusb3",
 		.data = &exynos5250_drvdata,
-	}, {
-		.compatible = "samsung,exynos5420-dwusb3",
-		.data = &exynos5420_drvdata,
 	}, {
 		.compatible = "samsung,exynos5433-dwusb3",
 		.data = &exynos5433_drvdata,
-- 
2.27.0

