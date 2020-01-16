Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8E4C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B412051A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5zSAd9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392095AbgAPSXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:23:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45528 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436563AbgAPSXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:23:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so20146710wrj.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EH2Mlebs2h/AJbindEkCjYYUOjO3EITRwzjTXRLMFFA=;
        b=J5zSAd9eVXpfMh3JNdcZH2r72kKVb0yZkdxGbNtKTci8omN9fk0NiDXfbE+0IG6QK0
         aIkbrdwMAuNeyJSXHsOOU+/G5oH8wPfPlv2W9J9PM7E8tT3PtKhqG+XfsNl+FSuyfi79
         tyPnpxN58+F3EkyoXNcDdQU4IW0D+vNw/7im8CZ8CroXuEPOTZXaFDFKv9C2NyF1IGD6
         bFozHcr3GUcpq0ACe05jT3KBGcT7ds4GX3nTwv6U0WOLg0jk4nU0QJAcHmZk6e4Vnq6Y
         CvN8qk9spP9dVF8eelhYDKPcl22zNVPEk8WZvn0JL168qqs+r9gFLkYCmQT2EXXq7A/t
         iDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EH2Mlebs2h/AJbindEkCjYYUOjO3EITRwzjTXRLMFFA=;
        b=aq65918pVNGtnfrwCsqSyXokQHfTAhtf45F7NPiN62vkLit4ZGvS45VIxkUhSWqEBO
         u+8WClcwomPmzCiu4t6TFwZ4n4ILVpd7VriY6IuL5GhATzVNO3FCAfstVL7udJjFIfq7
         qFFe9Q7GhLb7kRWlXDVMoVBu0bgqta2A/6SX68oghF8/MkweWzEBZid24wCPCGwUzw3t
         7Sz2gzU5dH0vwxQ/VSjBSdllzGKY8ewVdRBlxVKYbvYiWPfA9L4LTl+rCbSYwGKLg0hM
         /b7HIeH+aPwoSRGmVwm0I5dDjy/dzt9WXVb/JXwwM8nqDWWV4a5jmRxIu+lz4tNlx1vi
         NVTg==
X-Gm-Message-State: APjAAAVa87LQNIbPB7J2NEPhPOIOVjcu+3C4sMMaoCkjSCwOoH6SDIpM
        uSGh2xop6frVz1uaypega+6byrzzKnSdMw==
X-Google-Smtp-Source: APXvYqw1HruZQ+bfPnoJIZTkfncXPklOofg9wHJg2ToMu2p9yNTQ1Sf4zwGU5X8hDfZjrGDAEi66kg==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr4824552wrv.79.1579199014934;
        Thu, 16 Jan 2020 10:23:34 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f])
        by smtp.gmail.com with ESMTPSA id b137sm1087920wme.26.2020.01.16.10.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:23:34 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 09/17] clocksource/drivers/em_sti: Convert to devm_platform_ioremap_resource
Date:   Thu, 16 Jan 2020 19:22:56 +0100
Message-Id: <20200116182304.4926-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116182304.4926-1-daniel.lezcano@linaro.org>
References: <74bf7170-401f-2962-ea5a-1e21431a9349@linaro.org>
 <20200116182304.4926-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Use devm_platform_ioremap_resource() to simplify code, which
wraps 'platform_get_resource' and 'devm_ioremap_resource' in a
single helper.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191221173027.30716-2-tiny.windzz@gmail.com
---
 drivers/clocksource/em_sti.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index 9039df4f90e2..086fd5d80b99 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -279,7 +279,6 @@ static void em_sti_register_clockevent(struct em_sti_priv *p)
 static int em_sti_probe(struct platform_device *pdev)
 {
 	struct em_sti_priv *p;
-	struct resource *res;
 	int irq;
 	int ret;
 
@@ -295,8 +294,7 @@ static int em_sti_probe(struct platform_device *pdev)
 		return irq;
 
 	/* map memory, let base point to the STI instance */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	p->base = devm_ioremap_resource(&pdev->dev, res);
+	p->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(p->base))
 		return PTR_ERR(p->base);
 
-- 
2.17.1

