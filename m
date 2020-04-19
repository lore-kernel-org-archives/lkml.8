Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3969C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91032206F9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI95/ZjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDSNum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgDSNuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:50:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9D4C061A0C;
        Sun, 19 Apr 2020 06:50:17 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r26so8193940wmh.0;
        Sun, 19 Apr 2020 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nc3cDv/S8K5EI2hOuNsI3mldCjUl3ocR/NEfaOULj3M=;
        b=nI95/ZjH71ySY6uXGjLedJbNIT5kpYGkrINPlyIcPFYvg8Uu9Pyjbw7wLbgdg35tcP
         uJkJ5tlDF01igqu2vhWLTahY2WkeiOGUhWH8MLTJv/XyZsKnEbrjS8BDVcqRpMbTZcH+
         /PgR+2tS1pyFOgsnaSQtNa+U65mqYLHp1Yud7AoCSNsc0Z3IhPkvHI+iHlfoMd3SWf8G
         /UYHSYIkLlpVXg3fAPHyHuFoO1mllH8XhcrXrO3sskPAeWXuMK3IaVyNUfzg+Wx3/jIf
         sdF+kl+jZFp5ZzCo2YnF10kJ+Fze7jhagwMjTiHR8Ul49tCL176AySvkPo5L83hNF7cZ
         EFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nc3cDv/S8K5EI2hOuNsI3mldCjUl3ocR/NEfaOULj3M=;
        b=XvSTeTvc2ziS445dbvJWqmgmzEKgGgeGuc9DLPOCX/moBC+n/g/hZMW59sBDemXCuL
         jYnpQiiJdFeq7gDmdlCH5QvAyFaWqRZNY+R8pK8oXzUrwns1rDcEnKjOUhziSf5rM8V6
         XyJ6+Ib2JXRSF4zaksvSfd/TjzyjEj2f1U3OgaTzg4Rto1gPikRtrxXRlhNuZ3ZvwRKl
         0xWa/T7AOvx0XmEU+a5x+U0jonjnW02OwJ/4IsCV8d4VfunG1R4iVyfNvbwbD/TV2URE
         UGXP6AaBN4qYXSsO0YUhYx2dyysLMrbIjm4cpfJAkTb82RjoyqUYdEDEqqPdIE5NSeD2
         PNnA==
X-Gm-Message-State: AGi0PuZUAiRQ/m/oGKlWF7i53/DHzm1mxHSh8qyAAxjSbtHOJG5EHwOw
        M5mcV8Ef/wTSwKcmAH+l7OM=
X-Google-Smtp-Source: APiQypJxdgjLYRxBFD6/tAelj5Ds+PrbDiWbR2b/Zct7aMTE9/866RPUxPoM0n27L+lKuJh0zunv7g==
X-Received: by 2002:a1c:a7c2:: with SMTP id q185mr12958486wme.42.1587304216075;
        Sun, 19 Apr 2020 06:50:16 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id z8sm20183940wrr.40.2020.04.19.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 06:50:14 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 2/7] arm64: configs: Enable sun50i cpufreq nvmem
Date:   Sun, 19 Apr 2020 15:50:06 +0200
Message-Id: <20200419135011.18010-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419135011.18010-1-peron.clem@gmail.com>
References: <20200419135011.18010-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 needs this driver to be able to get
the correct speed_bin required for DVFS.

Enable this option in arm64 defconfig.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f9eefb5940ca..37e512c135ba 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -84,6 +84,7 @@ CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
 CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_ACPI_CPPC_CPUFREQ=m
+CONFIG_ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM=m
 CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
 CONFIG_ARM_SCPI_CPUFREQ=y
 CONFIG_ARM_IMX_CPUFREQ_DT=m
-- 
2.20.1

