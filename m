Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B911C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69EF7206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tUr7wg3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388243AbgF3Ne3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388189AbgF3NeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:34:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8977C03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:34:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so20205708wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aqos2NxgL6TqV6vtAHFj09o8FM67bpNGP+lJI0qHUic=;
        b=tUr7wg3Wznr91hdBXq50eNTGAccm33bM6tBl1CH1AYKPp7JvNXSuZ0fLootAup+nLZ
         7xkoMJq1lUn19jzjKvVfTuaHmloQm+V871dkMcRy9T/bH3j7+hJYql6Pv+wj15mhtdHE
         z+p3HQuk511W60JvRiiE4ZaHUMC3YYw6cpfddvAPSL7oz94GQ5JxL/eIwpYYN7AI7zER
         02C7um3AfjHlBzqoZ7eQY2pLhJAu4hgYRRVaj6miRKRa0ZaL2ZCGcKELxqLOX9qJJhcc
         kU1S0ht8R33R/0IqyPDqJyOcr1Rc3GifN2tOTQKD40fTDw1T9liHtszfTp2Uvn3pJlru
         HMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aqos2NxgL6TqV6vtAHFj09o8FM67bpNGP+lJI0qHUic=;
        b=buM9uvuPaAvajiZq7HCq2psIf9PLOvHtl1CuGf5dsOboaWGcQPtd/ZPpxJv0Nhtqwh
         42TFWCk5Q6zNNfi0ek76rIgfnlIRdgCcAXD5xQI0powp8MGugYD3bXcdVUrP4yMJBIEf
         vWnSTjgPOh6cUnkalPW2Vc11miuuyeeQJypPo9W3RxEh3IYTlHMZmDHV5ooacUGGd2ga
         kTbns9c4bWhjeylD7sTbLhfBt/vLNieTQ6z/jdiBiWWzZsomfw+o5YR5iE2SQ+mAZfLy
         ec44j4+gPUMFl6Nzj27FQsYUOc+SdILqc3Lufw52i4E7pexjEMMG8bviYn0Aur+jhFPj
         k3ow==
X-Gm-Message-State: AOAM531iuJThF1vP2LK/G3rymYpYHZVTiYJsRMnSmUAMw7MSNujUp4UN
        G0TzW1BEljwAHHtwUTdtQZkIwVFCumU=
X-Google-Smtp-Source: ABdhPJx9WxsVZ5j6ppbW2LpfgLfGN/iYhXnS9SqvRlEbRO7i3cfvBgwP5qkADNjWMaQO/b1FJ/QXnQ==
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr23139275wrw.16.1593524039424;
        Tue, 30 Jun 2020 06:33:59 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id z16sm3682464wrr.35.2020.06.30.06.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:33:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Asmaa Mnebhi <Asmaa@mellanox.com>
Subject: [PATCH 10/10] gpio: gpio-mlxbf2.c: Provide __releases() annotation to stop confusing Sparse
Date:   Tue, 30 Jun 2020 14:33:45 +0100
Message-Id: <20200630133345.2232932-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630133345.2232932-1-lee.jones@linaro.org>
References: <20200630133345.2232932-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse cannot peer into other functions to see when and if locks are
acquired and released, thus it simply warns that a 'context imbalance'
is detected instead.  Let's be kind to Sparse and let it know that
this behaviour is intentional.

 drivers/gpio/gpio-mlxbf2.c:125:12: warning: context imbalance in 'mlxbf2_gpio_lock_acquire' - different lock contexts for basic block
 drivers/gpio/gpio-mlxbf2.c:151:13: warning: context imbalance in 'mlxbf2_gpio_lock_release' - unexpected unlock

Cc: Asmaa Mnebhi <Asmaa@mellanox.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpio/gpio-mlxbf2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c
index 861a8d0a84be0..befa5e1099439 100644
--- a/drivers/gpio/gpio-mlxbf2.c
+++ b/drivers/gpio/gpio-mlxbf2.c
@@ -149,6 +149,8 @@ static int mlxbf2_gpio_lock_acquire(struct mlxbf2_gpio_context *gs)
  * Release the YU arm_gpio_lock after changing the direction mode.
  */
 static void mlxbf2_gpio_lock_release(struct mlxbf2_gpio_context *gs)
+	__releases(&gs->gc.bgpio_lock)
+	__releases(yu_arm_gpio_lock_param.lock)
 {
 	writel(YU_ARM_GPIO_LOCK_RELEASE, yu_arm_gpio_lock_param.io);
 	spin_unlock(&gs->gc.bgpio_lock);
-- 
2.25.1

