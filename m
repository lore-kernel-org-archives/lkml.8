Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE07C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13C6206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HPTz22GX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391062AbgDCOGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:06:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44993 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCOGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:06:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id b72so3508624pfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 07:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5beh3tYBqXYsZM9WkHB84nsN0JayVNaqbU3KDCMIMkE=;
        b=HPTz22GX3PhyK0svSjiEAa/EYEoKl/3lYZ9PR0vxCRKC/FaCBtpqA6WeerrESZJ7JX
         tv88xM4eXiEciGzJFjYcoTO1WGy9MLzExMNNdTNTnZgv93V6bWIZBfitczga7J/i1i+L
         YzrahOiLRIPg7Knf2fAHPdx0qCj29Vs0t7f2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5beh3tYBqXYsZM9WkHB84nsN0JayVNaqbU3KDCMIMkE=;
        b=qh9G7xgv/4J2l2+ARa1dW+MvQV9ZPOnC2JaJZPCGU13uvmnDdZSxPoeFEvT6r/QDHQ
         QCLA60ebJuPE8ZfXBkFdYyrFma+k87EBdrjFp8lS81+ojEf+TnbdxD3moFcU/yJ1uBJn
         uR2zhfIaXVX+SqMY0P8fGPTSxkmx4ASQ+nigMsNNVC6ID978/q7r+5BP8EG/I+6/veI3
         1yFdw658eTPEQQ6vP8kE3ZAlROzdIq/b1UOpKXDDx6QLRFuEsz3aURjZhBG9P+YZEZ1V
         XwCAYgtS17Sb6J81OYAAv/7S7TjD24XcABlIvTIHlQc9Yi18gTx6qqdHvuYPH9QuCRCZ
         uAcA==
X-Gm-Message-State: AGi0PuZPjUv72pf6sI+NVbJrQ8d37K7RmWPR8CxMzYtG51WZuP68TV9z
        vKa17Ec8+yM++321hHCg5T/Qpg==
X-Google-Smtp-Source: APiQypLnyuaCfrMJVbi/1HEIwuHyrJ1Hs76x+x1jPDIZ54zuDRt5bMB+wdkOemO/y1W+MQTIm1IjZw==
X-Received: by 2002:a62:92:: with SMTP id 140mr8187984pfa.186.1585922788771;
        Fri, 03 Apr 2020 07:06:28 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:9cd7:b821:2c84:e325])
        by smtp.gmail.com with ESMTPSA id q200sm5368935pgq.68.2020.04.03.07.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:06:28 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     heiko@sntech.de, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Levin Du <djw@t-chip.com.cn>
Subject: [PATCH] arm64: defconfig: Enable GPIO_SYSCON
Date:   Fri,  3 Apr 2020 19:36:16 +0530
Message-Id: <20200403140616.19505-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

roc-rk3328-cc board has vcc_sdio regulator controlled
by a special output only gpio pin. This special pin can
now be reference as <&grf_gpio 0> via gpio-syscon driver,
as mentioned in below commit.

commit <99165b93dafe4f2a821b5dae106f2ef6b4ceff7e> "arm64: dts: rockchip:
add sdmmc UHS support for roc-rk3328-cc"

So, enable bydefault on the defconfig.

Cc: Levin Du <djw@t-chip.com.cn>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0f212889c931..0a38f0833cf7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -433,6 +433,7 @@ CONFIG_GPIO_MAX732X=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_MAX77620=y
+CONFIG_GPIO_SYSCON=y
 CONFIG_POWER_AVS=y
 CONFIG_QCOM_CPR=y
 CONFIG_ROCKCHIP_IODOMAIN=y
-- 
2.17.1

