Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA946C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 836EA2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WjClSL1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbgGMOux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730144AbgGMOtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D7C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:45 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w3so13438569wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4tW5IFgDDqy7qyYDWJ2VHhOu5cDN/GOhkX5hDm+X0KA=;
        b=WjClSL1n2aF+iDQnyRNBBuqCOZEhWicWvABW9Y8n0ov9NCQi2T/5ZDyNbEbMC7NP4L
         gLKJ/VyZFokhHMKwL1I5ZkRbNsutDxl40DWjr7FLj53d0G3Uc4v/jZvzcCgJa7RAaa78
         X/gvNjcxjE3WvbULnI1iDQKcK7NBquO/2uRMuBzxL+zDjXbwCOs6xEHHiURiyeiZFbLh
         dIIEYNY38n3ovFlJHQCXVnRuIbfvoCaUwGoEVhgzxpuhPwMs+jOKfKNn5T02n9JrJRs3
         6VVnu31yidyKhClTtm7F1yqAh6E+hTVa2ZoJLWSP1fgL3/Xk0L6mPHWs2TP09tsqcWSS
         24kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4tW5IFgDDqy7qyYDWJ2VHhOu5cDN/GOhkX5hDm+X0KA=;
        b=BW3ywgRwsv1f0ueih5pcIn7lZIxf7EhK32AFQjogqlKsDmr9Xah+tVEp1NIBdn2E/D
         n6UShbzEiO8yQ9b3wNpYRyO6++dAbjrOGvnhF6cwqhsQm4RQ/qqGEI/u4tRq0WNoWmHK
         X8IdWpffSmMH+wKoriEKblkYLZM8VzoxkLTpIj22f7naaJFccY2k9FHZg0DAI56ld3ty
         4A6dyDsU4RYyzj+GXleP+/Tz6n+SFNECjKX4aXDDQxtwGWAYi9fUSheH3XEwIq89Tdp3
         d7ohHgotcDLesWTUSb9elxvuu3XjYDD/xUUU4GpuQ7pkqoIpJedRWSfCAFvYtT2CNeSS
         ALew==
X-Gm-Message-State: AOAM530HcPnin950cLQaBuEM7vXcICAkzaKfp9oRlL2RtyprTHvNFadb
        xyIQ2BCMzdCkA+fAbfZLMIWGLUYMirE=
X-Google-Smtp-Source: ABdhPJy3KLnpKINijttBB8YhzPj7oorwUByKOTrROJQQy1EK6e62RsYUX/R0V2tT2CZQ54QxZ8iOCQ==
X-Received: by 2002:a1c:3546:: with SMTP id c67mr329914wma.102.1594651783867;
        Mon, 13 Jul 2020 07:49:43 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 10/25] pinctrl: mediatek: pinctrl-mtk-common-v2: Mark 'mtk_default_register_base_names' as __maybe_unused
Date:   Mon, 13 Jul 2020 15:49:15 +0100
Message-Id: <20200713144930.1034632-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all sourcefiles which end up including pinctrl-mtk-common-v2.h make use
of 'mtk_default_register_base_names' and there is nowhere we can place the
definition to void the need for __maybe_unused except its own headerfile,
which seems like overkill.  So instead we tell the compiler that it's okay
for it to be unused by some of the consumers.

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c:19:
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h:83:27: warning: ‘mtk_default_register_base_names’ defined but not used [-Wunused-const-variable=]
 83 | static const char const mtk_default_register_base_names[] = {
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/pinctrl/mediatek/pinctrl-moore.h:25,
 from drivers/pinctrl/mediatek/pinctrl-moore.c:12:
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h:83:27: warning: ‘mtk_default_register_base_names’ defined but not used [-Wunused-const-variable=]
 83 | static const char const mtk_default_register_base_names[] = {
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/pinctrl/mediatek/pinctrl-paris.h:27,
 from drivers/pinctrl/mediatek/pinctrl-paris.c:15:
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h:83:27: warning: ‘mtk_default_register_base_names’ defined but not used [-Wunused-const-variable=]
 83 | static const char const mtk_default_register_base_names[] = {
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/pinctrl/mediatek/pinctrl-paris.h:27,
 from drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h:15,
 from drivers/pinctrl/mediatek/pinctrl-mt6797.c:13:
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h:83:27: warning: ‘mtk_default_register_base_names’ defined but not used [-Wunused-const-variable=]
 83 | static const char const mtk_default_register_base_names[] = {
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/pinctrl/mediatek/pinctrl-paris.h:27,
 from drivers/pinctrl/mediatek/pinctrl-mtk-mt8183.h:12,
 from drivers/pinctrl/mediatek/pinctrl-mt8183.c:9:
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h:83:27: warning: ‘mtk_default_register_base_names’ defined but not used [-Wunused-const-variable=]
 83 | static const char const mtk_default_register_base_names[] = {
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/pinctrl/mediatek/pinctrl-paris.h:27,
 from drivers/pinctrl/mediatek/pinctrl-mtk-mt6765.h:12,
 from drivers/pinctrl/mediatek/pinctrl-mt6765.c:10:
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h:83:27: warning: ‘mtk_default_register_base_names’ defined but not used [-Wunused-const-variable=]
 83 | static const char const mtk_default_register_base_names[] = {
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Sean Wang <sean.wang@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index 27df087363960..45aa0fdbe3306 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -80,7 +80,7 @@ enum {
 	DRV_GRP_MAX,
 };
 
-static const char * const mtk_default_register_base_names[] = {
+static const char * const mtk_default_register_base_names[] __maybe_unused = {
 	"base",
 };
 
-- 
2.25.1

