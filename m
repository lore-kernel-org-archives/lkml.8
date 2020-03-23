Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB8EC54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C6E2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPDxZW5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbgCWQGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:06:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37030 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbgCWQGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:06:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id x1so2072614plm.4;
        Mon, 23 Mar 2020 09:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6myrbcP2wFpIJAA9gt9TKv02zj8RjNJVtTVH5Hy4EQ=;
        b=iPDxZW5gynXS7qL2nxO/6PsxG5rcS8dWADROTCw7IalP/icc7wGyAX6KBI+Rbzjl/S
         fmpzB+AKXILNq2M0fJ65oYArUzOqLNm7jEl+V9pZHBaxfVsTuB2ggrp45nI1xBm5xfnn
         IRLc+BT8+90od+y38SHq1W2e3194m5bvqree8cABWy98nqTBvP2P477/ER5Fa1Dequq0
         EoRvN1DGIsV45lQ5BUeE16MSYuTJMo5Buf6iP1vyupAjBQMtg4MVswqD4S0CKCplO67p
         KhGGrSTqhtpvOBO6DhXeG8Mk0lXcbV+UnWNqIzW2QTWMZLUN+rQObz+nfXkaV0BC7B71
         SHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6myrbcP2wFpIJAA9gt9TKv02zj8RjNJVtTVH5Hy4EQ=;
        b=HfyGquEknS0+eT3OTheA5beeUyfYfmJyB9gCrqKOMZMubB0DRYV2KLzkPhVHpge6En
         k3l0tSt7Hkd79esRnZJqQ0AbrTAI8lsDnhYtLZy6/+kB/ZWtEjTtN4JZ+uLZ/OYhO9bo
         pF+8BG9E0+yQoolXzhbhivkEBuYfigenKWy7J1h1mO3dLhh82sBTMVvMbEv+ALumtXMX
         v80zdElyImM+2yBC+10L/33Du9P9kND7P34Pfhg/1p7rAysrSMBkGptH6uQsLAxsdFJb
         m3+j+UvWDVDSUH1KsK5fuPpO5cRjnq/QSXIbLOWXoqRI+HekhzIcYg0ZKJhAjKQ66j2G
         sfKg==
X-Gm-Message-State: ANhLgQ1rVv9jgkPQw8ko3ASFzUzHLJ/9HsR9W3nSHdDXwDXcINLa9yhc
        5NUpQBlQeFjb9rSf4EcHEBU=
X-Google-Smtp-Source: ADFU+vsWrn+Tdam6ubw6nKp82rtGimANdOulS0rXh4M8tmN7SAY7E3UPzXLDMzhhzNsXYcCSEyAIpA==
X-Received: by 2002:a17:90a:240f:: with SMTP id h15mr29115pje.176.1584979595869;
        Mon, 23 Mar 2020 09:06:35 -0700 (PDT)
Received: from localhost (176.122.158.203.16clouds.com. [176.122.158.203])
        by smtp.gmail.com with ESMTPSA id nk12sm531pjb.41.2020.03.23.09.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 09:06:35 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, hminas@synopsys.com,
        mathias.nyman@intel.com, bgolaszewski@baylibre.com, arnd@arndb.de,
        geert+renesas@glider.be, tomas.winkler@intel.com,
        tglx@linutronix.de, hdegoede@redhat.com, treding@nvidia.com,
        suzuki.poulose@arm.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH v4 2/5] usb: host: xhci-plat: convert to devm_platform_get_and_ioremap_resource
Date:   Tue, 24 Mar 2020 00:06:09 +0800
Message-Id: <20200323160612.17277-3-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200323160612.17277-1-zhengdejin5@gmail.com>
References: <20200323160612.17277-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_get_and_ioremap_resource() to simplify code, which
contains platform_get_resource() and devm_ioremap_resource(), it also
get the resource for use by the following code.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v3 -> v4:
	- no changed.
v2 -> v3:
	- call the rename function devm_platform_get_and_ioremap_resource()
v1 -> v2:
	- add this patch for add some real users of this function. 
 
 drivers/usb/host/xhci-plat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index d90cd5ec09cf..dcc0bfe04c43 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -219,8 +219,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 		goto disable_runtime;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
+	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(hcd->regs)) {
 		ret = PTR_ERR(hcd->regs);
 		goto put_hcd;
-- 
2.25.0

