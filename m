Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8024C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 04:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD24020773
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 04:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="f1GWr7Zc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgGZEkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 00:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgGZEkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 00:40:02 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04699C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 21:40:02 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 72so6463837ple.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 21:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S1PScPr62Fyv3G3V3sqS9lJD1oItrdYt39x4/kLlLZg=;
        b=f1GWr7Zc/SXlmn6mpmIZZbbZO2lfbv2DdsH8zIq4IUJlSzD2EuurHvhso0l3HGPDpy
         OV+KB4ORv8psgddkQju9P4NtBIJNoS1Ads0DUfP2hWG3NI7lC2eAIi9iBjzoVE2yY/xo
         uqAIBMEGixZv4admjTtM3jdG0rN3V4KkEQ4Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1PScPr62Fyv3G3V3sqS9lJD1oItrdYt39x4/kLlLZg=;
        b=Yo03neGWKcXzqd0ERqJsCaPPm/ulYQ5sM13R/iak+8Gnpvx74knxUpfMNVqiwi00Qd
         83KzWrwjpgIo8dwDnXbBYnkj3eDeJVj5W4+PFPGL3y7E03U/UIf8G/7yoktad6jgDhH+
         Al1Nsxck7xdFJe4nZR8+g+vNnxuI2h3nXSWvxuBHgX8Q1SSyKcIz6ctAnpidM+APe3OX
         /hHjoPYD6p8KnnSLNnFtcLZzy7UZLppz5ue4/Ns63gPAqdKKocfmDZgFoYL9U2JDqQWq
         5Kt0u1t6UmOlmkjrpND0AQ4myx9GRW2cRJ5l/l3ZQDQNId1VNGbG20GiXhAfVuT5s7mk
         o7dA==
X-Gm-Message-State: AOAM530ogM6ZNSU+LXejaO+ppkxGkYlg+8df51Iv4BysRdplnWTvQLuW
        dmfWBS879JkmO5C4FRTnr48EdA==
X-Google-Smtp-Source: ABdhPJyWKGqMGQhv/ydwBeupMiGitoRNYos25yqTDgSQYVBfbpr1lNBgCgwv7ZHoETJw+BUYNcBLag==
X-Received: by 2002:a17:902:59c1:: with SMTP id d1mr14715427plj.78.1595738400719;
        Sat, 25 Jul 2020 21:40:00 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id t1sm10507372pje.55.2020.07.25.21.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 21:40:00 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 2/7] ARM:mstar: Adjust IMI size of infinity
Date:   Sun, 26 Jul 2020 13:39:43 +0900
Message-Id: <20200726043948.1357573-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726043948.1357573-1-daniel@0x0f.com>
References: <20200726043948.1357573-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

infinity has 88KB of SRAM at the IMI region.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/infinity.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/infinity.dtsi b/arch/arm/boot/dts/infinity.dtsi
index f68e6d59c328..cd911adef014 100644
--- a/arch/arm/boot/dts/infinity.dtsi
+++ b/arch/arm/boot/dts/infinity.dtsi
@@ -5,3 +5,7 @@
  */
 
 #include "mstar-v7.dtsi"
+
+&imi {
+	reg = <0xa0000000 0x16000>;
+};
-- 
2.27.0

