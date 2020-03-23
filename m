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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF55DC54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF1720714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enFns1JT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgCWQG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:06:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35887 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbgCWQG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:06:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id j29so534698pgl.3;
        Mon, 23 Mar 2020 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uK1iorBXF9BB4oGseEqjv4lqsBJQT04CW0YTLmh51Gc=;
        b=enFns1JTPAAQxePIF5XR/UkwY8Cc6ppWp3dRroiZAdFgisuXjzD/OwK6FCuu988wz1
         a31lIJSe2W9hVqDk0SjUSyV778lcJE6Dl1tZ/wW7NLRcj15if/hViAQ80LrIj3C3WCTX
         zc+irBWnrZLZn/G5ZefV8FDCllViW7lE7QZghgAuUtj/KXzwV/CvSyTGZOPByI/NW2iC
         DkIFLKfoxRLyRZo+EboDkwgL43rYSaNFQcLUOqF+t6JF5QrQdIL3CHopXbCHcZxb/p8N
         EC1Ab3O2M8z54vDF2Ff4np/penjbARCtAlrPcK/BeWObWzyLcMAnmRBoUdnq8oXw0MEi
         7Y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uK1iorBXF9BB4oGseEqjv4lqsBJQT04CW0YTLmh51Gc=;
        b=rl+Uh2earBgboWUIGfEgpuVYD2ouR0w5IDcFbzrgvfm6zllU/d5BDZY3ConWGN79fA
         1mCBP7iK6ik3MMOokh1u5YY+4HMW+WDqiFszpiSZb/Lnrxt/n1j8nFy61R98wXzS6gFN
         W6kv8nMAwHlkEj3AF4z6yQKUU30LDQODv0PgWrHn9J7WyT78C5TXRkJp+DwlrYF/bfpN
         nQay9waqDig8dfFRo6DCZlSSRVxi5qXwUzJdPhG/FqSmpycKgsOp5Uq86z+XPYAQigdv
         OovZ67+usgr+S5RZWbfuWDZD5JI4gav0P7rKjDRV2SB/U+XIzjinjLHVPSzXniRxLDQ9
         fkZQ==
X-Gm-Message-State: ANhLgQ0MrZor4fvR9y+8IkvkaR3O+M7TAFT+Yk4vAfSE4Yr+bbVn95qy
        528d7hPdTWMyoyMBoOKOfvo=
X-Google-Smtp-Source: ADFU+vsrPRMOiAMsZ+zyYSVQ4JhY92AmjIK635SFGp303xhUELRjugX5pvVkZ6+tAXme3RRKVFLz6g==
X-Received: by 2002:a63:5d04:: with SMTP id r4mr22463802pgb.241.1584979613571;
        Mon, 23 Mar 2020 09:06:53 -0700 (PDT)
Received: from localhost (176.122.158.203.16clouds.com. [176.122.158.203])
        by smtp.gmail.com with ESMTPSA id x190sm13510335pfb.96.2020.03.23.09.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 09:06:53 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, hminas@synopsys.com,
        mathias.nyman@intel.com, bgolaszewski@baylibre.com, arnd@arndb.de,
        geert+renesas@glider.be, tomas.winkler@intel.com,
        tglx@linutronix.de, hdegoede@redhat.com, treding@nvidia.com,
        suzuki.poulose@arm.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v4 5/5] driver core: platform: Reimplement devm_platform_ioremap_resource
Date:   Tue, 24 Mar 2020 00:06:12 +0800
Message-Id: <20200323160612.17277-6-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200323160612.17277-1-zhengdejin5@gmail.com>
References: <20200323160612.17277-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reimplement devm_platform_ioremap_resource() by calling
devm_platform_ioremap_and_get_resource() with res = NULL to
simplify the code.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v3 -> v4:
	- modified this patch's commit comment.
v2 -> v3:
	- add this patch to simplify the code by Geert's suggestion.

 drivers/base/platform.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 3e8a9fb91dcd..16b54ebc6958 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -95,10 +95,7 @@ EXPORT_SYMBOL_GPL(devm_platform_get_and_ioremap_resource);
 void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
 					     unsigned int index)
 {
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
-	return devm_ioremap_resource(&pdev->dev, res);
+	return devm_platform_get_and_ioremap_resource(pdev, index, NULL);
 }
 EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
 
-- 
2.25.0

