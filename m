Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2639BC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66B6206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hTLGia7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgDTIA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgDTIAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:00:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BFDC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:00:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j1so5465678wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A+QeMSWD3PS086s3vwF3t/garbLCRMGAy7YurSuE4Kc=;
        b=hTLGia7bam5LZwHsqquFh8AymM6Ls/yjxGtl/hrZDunqN4uGsKNHdZ6O51cqaTHlUN
         BYNz1z1cbWKua9hrTYRPm3A7mut1msCAXNB703F1megHRsIopjDs2cIhcRhz6G++6Nr/
         J/IsnRBoNr7IOPpveEfTAOfIv9Qjqc12xELoq+aRps4wHEWo7AztMRlvwLdpiJOUhyA8
         XIEZS7Col4hxpVlQLXtIGF1+wOIAZRycl/EOYMVy4vzBIhb9F0mclmozxA1kwBtGGSA7
         CDj5v1n9e0Hqf/zaUlZWJsjhws2pdwplXtM5OoDvB9PD3kLZBRaPgPQB6sViOtf9toXC
         WYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A+QeMSWD3PS086s3vwF3t/garbLCRMGAy7YurSuE4Kc=;
        b=P6bZJ+K0db9KzMMnu2IsWp072crj+mjytKMwXTU6EyKMg8KSBwtgMbjFzk95SfAgUq
         KXSir4tcQPlzMQn/ANVFp+Mk9twbr5Dbq31BDV+xaGViTzKPJ3o+7dYzBKdEWP2Sjh6N
         p3LeAw25zQMPImRYzHYvATTZn9+Nzcr4yWwurcLKRkgzZLZKclHXbXRSWu4iU17KxdHG
         PzV8BNaNHDbKFKnkgGHbEQjScJSox03jImpqItQNC0fMq6ligdb51WxAp6qk/98jmBzg
         yn+TbDoftUNk35n5m8cJLxpJjLz++sv5pHAh+O7y4PBsbgHoN5f4m01cNB/mEeoJMule
         PSbg==
X-Gm-Message-State: AGi0PuZGZZ3X2LNxLQU43/WMEkwP5d85rhVqgOvdEmXaoYszdmkcIEDc
        mVDiTdlxh1mvruEwSS3kr1OFtw==
X-Google-Smtp-Source: APiQypLDTl9EnBI31IMEjpSapxs/QYgBIADfuyt1egW7mLSxjpapQG5/JpIeV52Oh+uG14VKnbAC1g==
X-Received: by 2002:a5d:4092:: with SMTP id o18mr9493720wrp.227.1587369624021;
        Mon, 20 Apr 2020 01:00:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id v10sm113256wrq.45.2020.04.20.01.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:00:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] arm64: dts: meson-g12: remove spurious blank line
Date:   Mon, 20 Apr 2020 10:00:18 +0200
Message-Id: <20200420080018.11607-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove spurious blank line introduced in f12a463d2f43 but was not part
of the original patch at [1].

[1] http://lore.kernel.org/r/20200313090713.15147-3-narmstrong@baylibre.com

Fixes: f12a463d2f43 ("arm64: dts: meson-g12: add the SPIFC nodes")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
index 783e5a397f86..55d39020ec72 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
@@ -1,4 +1,3 @@
-
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (c) 2019 BayLibre, SAS
-- 
2.22.0

