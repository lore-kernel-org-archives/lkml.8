Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A9DC3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD6524691
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoLjISZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgB1Gdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:33:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51751 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgB1Gds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:33:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so1991726wmi.1;
        Thu, 27 Feb 2020 22:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SeId1K9kCYlRnsLVKxSoPARgCfEt06rQxOjVRJ3Mr5E=;
        b=NoLjISZEbZJcbs87Rx7G7WWPaw+MT4fi1WtnBCwYP2DmP08z5Xcn/nchoK1nq0cV1H
         vVjqWeg4vfUNfciN9WsasYR2NERcF6PtR1pZNZ07eG8mzQapQxqgOPSosNEfDtVxbN+D
         jxAV3rZ++0mSFo9NeBoPOXzhS6huJ8XKt3Q3l7BgkRmz1i7rpnGeNOupS5UD9FZXkz8+
         HeOa+3iRrIPZHH0ecuDHbBK+isWR4o8s36JHgZr++ZC8YBztSJDybfsluVuFmwKJjEJa
         qF2vx91z5ecGveKSHgKuicFA7/nucp5yfVzBrQVc3E0O4aFUrsV8xFbPCeGA/FU/pF+h
         L0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SeId1K9kCYlRnsLVKxSoPARgCfEt06rQxOjVRJ3Mr5E=;
        b=lmFAPmBxDXPkSlz5SAsJZ5z/HnYtDLXqVxq1SxYplBkzQxsREuZS+UwNiUFZbqnpJZ
         Dk9c7fX3t2GSjptqNAnTZ5bYQan9+rDk64DARBGSvErgGSicStLZ6huBSEcH3ysDCdHY
         iAxVkQJerl/6b+viPQYwF7ep6wSlAf/RQkZxLlPUA9fHmhAV9AeXywe47DFYpmLaiE+n
         Hpi1MhXCVPXAikRwV7iD2pNQhSCr6fhsvav09VlHpJk+h1iOOh3qP8W2tFj2z9j/i5Au
         llSYtHy/NLQ/4NC5rcIyfTd9sssRj09u81xSy2l9yN3pwoLI9c/bQMARbLuedsqo0hl/
         ClEw==
X-Gm-Message-State: APjAAAWtozguCZW1AZH7fCleh9PIoY0BBKKoTP1spv4FB1h6AUVfcioV
        RS4Ozgj33tcdHu30ab6SC+4=
X-Google-Smtp-Source: APXvYqy4EfkRJE8J7hWmqNsyE1ryRXoSs7t/mE56wW5Nj7E15Il90UYsdETWqvqSudu/dQMXMilkXA==
X-Received: by 2002:a1c:7d93:: with SMTP id y141mr3050186wmc.111.1582871626798;
        Thu, 27 Feb 2020 22:33:46 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2de2:1300:d9cc:d15b:e13:b06d])
        by smtp.gmail.com with ESMTPSA id z21sm790118wml.5.2020.02.27.22.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 22:33:46 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Sebastian Duda <sebastian.duda@fau.de>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust to renaming physmap_of_versatile.c
Date:   Fri, 28 Feb 2020 07:33:38 +0100
Message-Id: <20200228063338.4099-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6ca15cfa0788 ("mtd: maps: Rename physmap_of_{versatile, gemini}
into physmap-{versatile, gemini}") renamed physmap_of_versatile.c to
physmap-versatile.c, but did not adjust the MAINTAINERS entry.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: drivers/mtd/maps/physmap_of_versatile.c

Rectify the ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT entry and now
also cover drivers/mtd/maps/physmap-versatile.h while at it.

Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Boris, please pick or ack this patch.
applies cleanly on current master and next-20200228

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fcd79fc38928..bbf2108fb9fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1294,7 +1294,7 @@ F:	arch/arm/boot/dts/versatile*
 F:	drivers/clk/versatile/
 F:	drivers/i2c/busses/i2c-versatile.c
 F:	drivers/irqchip/irq-versatile-fpga.c
-F:	drivers/mtd/maps/physmap_of_versatile.c
+F:	drivers/mtd/maps/physmap-versatile.*
 F:	drivers/power/reset/arm-versatile-reboot.c
 F:	drivers/soc/versatile/
 
-- 
2.17.1

