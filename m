Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E7AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99DA7207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ONaJkYkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgE0L0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgE0L0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:26:30 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE09C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:26:30 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so5973083ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k7QD1+/Irx+1VllFQd8G5Bjp2O9W9kjYTs0FEoDMEik=;
        b=ONaJkYkRMcHeErRk8IHzp2w+8EQvfPsaAgChUgUktMUmtcYgYs5dsNUPwrdd7EYSKN
         D4DIXVxSh8u3zLOflHUEraISMLMQ/q3vCM3iubUxV5PigMwApQbkhw4RNuPg9ncvIcKA
         igWa+s5fR6fWEKXZModGjrdWz+h4RkpZiLE58jTQeLTji28ZQua4/RcpBz0uQLJfoHv6
         h2lEUZVOuA5FimUcUp9tk1qi4akUeGGx8ycuEGxWDgDoz5yLxUFniYV6PgTB5BGEi0wa
         0lRZEgAnQqKON74RapS8RXexD/+QgFsv2GP/RJQSWnCB1YyFFPRe8na8cjCvrVBtJwSV
         /e5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k7QD1+/Irx+1VllFQd8G5Bjp2O9W9kjYTs0FEoDMEik=;
        b=lzri+KqXIAPJH+JYQ9kh4/nIzkdrTfpSgpCH/dVfNOEJCl8TFrJxDaLyE2EDEzjeSx
         C8QzSgDbKutor6EtIjmAaXGNpYfWsNKSCXwrvGAPcYzFasNkIF9LWN/3bWuXpQp9O5hY
         h5elFVtSwl2Po4htGVwHgbtnLYe1FOKOecZFY6deKLJVqMG+TnRfyfQ3ixdfboA97HD4
         Yc3liEv3s2AmmVeMnpHP88PpGmLjo/M0nyWqmxnKtVwFXUGKmyKuAxrWLkEXyqWUuNcB
         dsHSdAuXDPxrrcTCjHNyxr1NI/SA2V2WOpxhZSqn0El6bhMi4Ydxgm/htPQjSMouPM6X
         a4+Q==
X-Gm-Message-State: AOAM533xhVyzROwvsmEUMz7unr866OmJ561quajLQXgRxXIZPu/iiULN
        Vd5FUMEKzRv0HiPYw1u4glIHPg==
X-Google-Smtp-Source: ABdhPJyJDrv1Hmbnw21diOmccCoGxDIOh35hLywSrDGN/chN+OoZ8ibsZbuSZCNyN3t40tOyXlz1BA==
X-Received: by 2002:a2e:8115:: with SMTP id d21mr2937651ljg.167.1590578788647;
        Wed, 27 May 2020 04:26:28 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id y17sm628702ljm.133.2020.05.27.04.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 04:26:28 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linus.walleij@linaro.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 4/5] power: reset: vexpress: fix build issue
Date:   Wed, 27 May 2020 13:26:07 +0200
Message-Id: <20200527112608.3886105-5-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527112608.3886105-1-anders.roxell@linaro.org>
References: <20200527112608.3886105-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An allmodconfig kernel makes CONFIG_VEXPRESS_CONFIG a module and
CONFIG_POWER_RESET_VEXPRESS builtin. That makes us see this build
error:

aarch64-linux-gnu-ld: drivers/power/reset/vexpress-poweroff.o: in function `vexpress_reset_probe':
../drivers/power/reset/vexpress-poweroff.c:119: undefined reference to `devm_regmap_init_vexpress_config'
../drivers/power/reset/vexpress-poweroff.c:119:(.text+0x48c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol
`devm_regmap_init_vexpress_config'
make[1]: *** [/srv/src/kernel/next/Makefile:1126: vmlinux] Error 1

Rework so that POWER_RESET_VEXPRESS depends on 'VEXPRESS_CONFIG=y'.

Fixes: d06cfe3f123c ("bus: vexpress-config: Merge vexpress-syscfg into vexpress-config")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/power/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 4dfac618b942..f07b982c8dff 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -191,7 +191,7 @@ config POWER_RESET_VERSATILE
 config POWER_RESET_VEXPRESS
 	bool "ARM Versatile Express power-off and reset driver"
 	depends on ARM || ARM64
-	depends on VEXPRESS_CONFIG
+	depends on VEXPRESS_CONFIG=y
 	help
 	  Power off and reset support for the ARM Ltd. Versatile
 	  Express boards.
-- 
2.26.2

