Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E94C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E715B208B6
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vXBWyVt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgE0L0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgE0L0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:26:23 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0EFC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:26:23 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m18so28426465ljo.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7JrgKFknWam4V1fZqyMtAvJglLBt+OuycTcodKNrhfA=;
        b=vXBWyVt9KfxvraiQX+TBkoR9fkLxC6dAcjgqDC8FPB8Eg5T0vCu3hFkF7mrPDmGH3+
         B8sK9h5OmF3hTDadQ/boUYw+M60ietj/qXOgyJsslTPI/qJK8r9mWyxG2uPL3tC3EPGo
         9OKSyfA3fDQGAvb8q3XLuZGH5rY/VSeDCgpjjTGyhJ7k+KrmPnEaPf3uF6AUYWQGMauo
         dl9FMEIA/nAFX3bS2PqWq+9j+UTxtt5BWFBimT+d8KxcUc3CDwP7O7YQdUivztrgny63
         Q1FfDh9V8pUOvvddTYTtExzVL+81dSlazBBOL7SOK4pkp+mrC31giVsP5cUZBYfs1/1y
         Ea2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7JrgKFknWam4V1fZqyMtAvJglLBt+OuycTcodKNrhfA=;
        b=tfu7iR5x1wY0rbdwnF9oZizBtaDQZAGCpC9ALNjufbRjCX0gbfJUYIRMqpReJwJLlC
         f86SqrScUEx+0QGNGiZDHysRUDAF2HimDZUR7/daVpV5sVq0YdwLFoxojmwsqVPAf2mT
         4YFba4prh+w9YSp/sCw1OgsGfxKtelrqokn/ipvIdwNZmIQ2YGW9UXSZJW2tfEP7h4T3
         gL/EBFIJqvtleblmy22h4gqECnBBErYkYpu2Tfc+TwYG1LuDUDaMPBx7jYB+3QGUdJO2
         XTQIkXiKYp1hu6uwcpk1j/U82zxFSBFv29POTKpXqs65dbOSotSwmvREqCMxGymNxrGc
         xD4g==
X-Gm-Message-State: AOAM532/QQ6U2Ke+So94V+74ledpu3E/C9ILAsKZG2Y2lesriwO2Z7Ln
        fLBzANWYoZY1y2n1WdZfGpMkhw==
X-Google-Smtp-Source: ABdhPJynCQiy7HTZrLhL1W88TFn9lXdsTehxo3xi0Uzt9bQLsp1sbAhmLpjUyAhmBW+kLMsahCt4xg==
X-Received: by 2002:a2e:9b89:: with SMTP id z9mr2653117lji.51.1590578781833;
        Wed, 27 May 2020 04:26:21 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id c4sm844304lfj.9.2020.05.27.04.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 04:26:21 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linus.walleij@linaro.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/5] power: vexpress: cleanup: use builtin_platform_driver
Date:   Wed, 27 May 2020 13:26:05 +0200
Message-Id: <20200527112608.3886105-3-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527112608.3886105-1-anders.roxell@linaro.org>
References: <20200527112608.3886105-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the helper macro for builtin drivers taht don't do anything special
in driver init. This removes some boilerplate code.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/power/reset/vexpress-poweroff.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
index 0bf9ab8653ae..1fdbcbd95fc2 100644
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -146,9 +146,4 @@ static struct platform_driver vexpress_reset_driver = {
 		.suppress_bind_attrs = true,
 	},
 };
-
-static int __init vexpress_reset_init(void)
-{
-	return platform_driver_register(&vexpress_reset_driver);
-}
-device_initcall(vexpress_reset_init);
+builtin_platform_driver(vexpress_reset_driver);
-- 
2.26.2

