Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6884BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28FF820C56
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo/+HJeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgIDUvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbgIDUvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:51:01 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B38C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 13:51:01 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e33so4937806pgm.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 13:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DngiifY+VD/aBUQNzK5lN4dyApug0qmV/8iUp0GFosI=;
        b=Eo/+HJegguYckBDEgMQ88Chqogj50AZ96F29ESZ6L5BhiGQyPOS8jUg85tClyTt+0w
         A1R6WgMKQsF+DR1DQVS8aEboMVayrhKLVFeh6mnF6eS1sk6laQ1tZIG/+uKpHz3dmZ/B
         vKM06B6EZjq2nHVTb5NVX30XTLU2asXOZgOr9vxDma9ogkCyJ58nSCJlhyyk/4X9wHNz
         +p4L9xYs6ApFHwwsBYwtJI2K1eElb2KeKzj9payRl3XJcbn+wDRb5zLnLZ9q8TeAZ0V8
         YarJtZW2mL3juqNjm88LZ3JMIkqgPJgIuyNUxW2SQ1f++G+DfFJVnIQ6xKzOiBRfm84L
         ahoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DngiifY+VD/aBUQNzK5lN4dyApug0qmV/8iUp0GFosI=;
        b=r5nSLCv9pCCKXiHoipFOvhbZpC3tZ7Imd65Wx+mFx1BKzfSd2sqXYr4BiDg+PhV0Pg
         /HHIFdFXHVp2I+qhaIG2zoQABM6HI0CWfMBRdOP8u7u70Y9GIcFiruVl7YTFmihxlrnW
         W5bzRGU5d9c0iZJKuo45NzcToEF//gmbz5+JemyP/KBK2FxrXzcSa+3bMuW2F/o0HYf4
         E2WXtpRsRWCJmSxg6WB4o2QdjyFfH3FvZJAdoPmfZolMQkhjXlbXl6R9iR+O//HYUPXK
         OCFhBMavQRD1h+toJxnnySqTdKWHEJJg4N+6OQig1peX8czfV9anL9JvigiMnIIKtTvR
         3dmw==
X-Gm-Message-State: AOAM533ly9zFcXgIwUogeFuoCd2WhBTWRbj+Ek5B4aTDIXfPky6beJla
        licccTb88S5oYpRleDAjF1g=
X-Google-Smtp-Source: ABdhPJznmz3IN9+McBSe5OwC6YWtASYz6SNPdbpxnwyHoAp2N2UcEgnINXoIN6OLbguJPlR1M12bkw==
X-Received: by 2002:a63:5a5d:: with SMTP id k29mr8551214pgm.51.1599252660754;
        Fri, 04 Sep 2020 13:51:00 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id gb17sm6193305pjb.15.2020.09.04.13.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 13:51:00 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] soc: bcm: brcmstb: biuctrl: Tune MCP settings for 72164
Date:   Fri,  4 Sep 2020 13:50:51 -0700
Message-Id: <20200904205055.3309379-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904205055.3309379-1-f.fainelli@gmail.com>
References: <20200904205055.3309379-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

72164 uses a Brahma-B53 CPU and its Bus Interface Unit, tune it
according to the existing values we have.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index 95602ece51d4..a4b01894a9ad 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -130,6 +130,7 @@ static int __init mcp_write_pairing_set(void)
 static const u32 a72_b53_mach_compat[] = {
 	0x7211,
 	0x7216,
+	0x72164,
 	0x7255,
 	0x7260,
 	0x7268,
-- 
2.25.1

