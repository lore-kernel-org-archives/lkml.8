Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9A7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D3620873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GhxPzSwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgE0L0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgE0L0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:26:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E548BC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:26:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c11so26295039ljn.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uD4NJKCCrAKNdXZhG6Aj4i9yfAmRa77MGUIOkJhlYc=;
        b=GhxPzSwZxz/FuMNuYGDzM0k2vcNESJSv1wSCeApiFe9C5uuAhpURWaks7Na0i1OoZl
         fb4TZBpJSzNuud6nOW5MZxTyfDD4j/YafFwKfPIothSviDUQmqjZtVbN/9OsckDhTr+V
         mA4nZK+7Ev17F4Bai5Dz7iASsxNNmXrEs04XGyrUHqeN6xW4Q5C+KoFhevkkttayPL87
         7zp5uZYZ8wXlhnnIafFDbuDwPhbL0kqa5Lrqndy3Dt+APlMRJetnr3S5clk48W130t4Z
         t5topENI91V8YnZG5eGP5YxuPpcGYEnYGLKwCgmWQwI9dwTh07aeg8S3Z0DzqvPwF7/6
         kZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uD4NJKCCrAKNdXZhG6Aj4i9yfAmRa77MGUIOkJhlYc=;
        b=JUgRAgWmkNJQMSZknM36Y9YB3MkqnKpakOF/eM5MErAnj2iPmQsbsuhgokDieH2hZ6
         GptQMtLLmCAW2h4y7V5B/kNVCXVwi4u3skl3duG5+jWvtAuoxQLOvRCxbvmS6r0sM1JO
         SSmUEr9OFJVe7kifTPp7qqlkGfnvSNKTpuvqnhAJ9UfioNaueo0rG0FkxqTUmdIlysaY
         Gic5vTqqCwU974yWbjKDY3LS2+ghyWNtwx2VSIJEH2vySPhqe+mmqkYOREqVjVX9NEgC
         PA874k6x0psVCch2b0SzPuvVH3q08zOjk4SkUToJXKakrhjA5bq6Nm2rAywb3B2XZenu
         9arg==
X-Gm-Message-State: AOAM533utuVQ+dKApvJr/GOPYI/cCF24inGo15WTu+NKd/KXnuS+TGwZ
        pdR/Ks0l3dw2BP+VB6vJr3JQ5Q==
X-Google-Smtp-Source: ABdhPJwDVIZKKWsa2g9rM6j4jD0gbLPuXLdz/ptNe0zUdXTeoHpsBq5Wum0HsUHujy9Uyd5zBz27Pw==
X-Received: by 2002:a2e:9a02:: with SMTP id o2mr2659598lji.89.1590578778399;
        Wed, 27 May 2020 04:26:18 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id b18sm637226ljp.35.2020.05.27.04.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 04:26:17 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linus.walleij@linaro.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 1/5] power: vexpress: add suppress_bind_attrs to true
Date:   Wed, 27 May 2020 13:26:04 +0200
Message-Id: <20200527112608.3886105-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527112608.3886105-1-anders.roxell@linaro.org>
References: <20200527112608.3886105-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the POWER_RESET_VEXPRESS driver won't have bind/unbind
attributes available via the sysfs, so lets be explicit here and use
".suppress_bind_attrs = true" to prevent userspace from doing something
silly.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/power/reset/vexpress-poweroff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
index 90cbaa8341e3..0bf9ab8653ae 100644
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -143,6 +143,7 @@ static struct platform_driver vexpress_reset_driver = {
 	.driver = {
 		.name = "vexpress-reset",
 		.of_match_table = vexpress_reset_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
-- 
2.26.2

