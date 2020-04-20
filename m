Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B35C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA1F20747
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEsZrwa+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbgDTNBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729806AbgDTNAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:00:30 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A467C061A0F;
        Mon, 20 Apr 2020 06:00:30 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v8so10741697wma.0;
        Mon, 20 Apr 2020 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nc3cDv/S8K5EI2hOuNsI3mldCjUl3ocR/NEfaOULj3M=;
        b=dEsZrwa+RR+0rXsoAGncG62h4KbXSQv1Sgb4ZeaEEjFzMROx4U1ZsmJ+pLXwLsEwbO
         dit3H1OAWx+4QQ5U39GadtM70ZtjCiaMiyMZZVu12oFCZn9X1TfqnwLfb3RRAsZSS+sm
         v9munaG1U0+BrtDRsF13U558DJl0gi+DK0yh9wH/X8j9sBRSzWCcsyS5aMSBGzUkxdX3
         m0JF7X3lABCBHsQEF+BsX6Y8438MVnj4NZXFfBjpFlW3nE4sDuAR7tPUMDbpIQWSmJBO
         d4J8qYh8Wuro09lTKyYLgxutS8GkMWU57UjOBZrdssN5BsVhKDglyKGJBBGJRNVh/se1
         oaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nc3cDv/S8K5EI2hOuNsI3mldCjUl3ocR/NEfaOULj3M=;
        b=qftCTxLoRB1p1BaHcD8V75limgXqoNQ2VaFRj9mk55DbcyDpRgJnJQ9JPh3ecoYLBw
         W64F3OGSKhPQ+2qg27DAdUFqiyUt7w2Qxr4GYNvUj5VVSYa5Bl3skl1yz00f8Wd+Ph4b
         tlFwoulIvngCGFj3nZOB/Vn/UXeKeUsn/1PPsV4ODfSwxkzfwzgqXIa+nX2BgC2O4y1x
         t67gCm3TJpVdr3wRnDZ0kgJfXzoavc2jtFl2e0Uf1rdACYilTrSUex2tP75AVi5g9EPB
         0PzadLuc03ReAdMQ08XJayG1MR1rhndM+3Fjkkrsxahna3/QPYdmP+j8LYID5q735hXh
         eNWw==
X-Gm-Message-State: AGi0PuZDlZb3GdB2Q7JQbqspfnf00zEXvTp4ruFf7dypSOeTKhun/D9H
        HGN5jJGr8vwEsjUmKl/BYLRnaCxNBLM=
X-Google-Smtp-Source: APiQypJP9iaMkM/tJP4hscr1M2RlYqjecZSBlhqM1r96gmEU6ZDy6uMs/es6XV4J4OzQBtcxpMvvYA==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr18890360wmc.83.1587387628929;
        Mon, 20 Apr 2020 06:00:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id e11sm1081680wrn.87.2020.04.20.06.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:00:28 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 4/9] arm64: configs: Enable sun50i cpufreq nvmem
Date:   Mon, 20 Apr 2020 15:00:16 +0200
Message-Id: <20200420130021.3841-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200420130021.3841-1-peron.clem@gmail.com>
References: <20200420130021.3841-1-peron.clem@gmail.com>
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

