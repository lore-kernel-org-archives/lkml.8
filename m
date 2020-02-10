Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D25C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 06:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2CA21775
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 06:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nIERl2yu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBJGg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 01:36:29 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40955 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgBJGg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 01:36:28 -0500
Received: by mail-pj1-f67.google.com with SMTP id 12so3769649pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 22:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8M/+JKdLoe27r1QkgI6hunqV9+SJ7vAk/tNBmFTl07w=;
        b=nIERl2yuhbzfok1YLM6oHhmpJYGu5YzjLocGeIhR2aXGpa0Rzpm2/6PhHvWz5i39zN
         Nf3rkaul93gk4B4Pg34rzr0xC0GvJuPsC0o3imF5nlMLYDU3Rp6+dRa1Ot/kj6pEvNd3
         6vCTh//IQi/I4sv72O3ZB5bWxCFwuw161MP8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8M/+JKdLoe27r1QkgI6hunqV9+SJ7vAk/tNBmFTl07w=;
        b=p6O4vfztfsMbpYmnPy/RGAwhytDZtAA4E+v627Zi/eoRAyuSyUoRKq3Jsx4GLENoHA
         5T7M0eeNPsi3IoZXVbicGKCqUEb/CXTig5tSLmiRV6J+cUIiz8Q0O/oJlmDJ/MZOWbbI
         LXilu/K+JMg9m/7sun26sCfbePqrvSn3LLT4hlf58boWnUv6sMWnKmFarrXdH1ziwMm2
         hGGJMmk4Ljv1gTAhoXidEXpIbyZNKcpHWcQzlZ643vWxHFroOeQ64eQwPjTbYatxviif
         p22hP5/1RBq5ohpt4NnZ11pkY7uGJo+h+v7RlNn0eI215xQhuhp9hOXk1K/5iD8PlDSJ
         ppMQ==
X-Gm-Message-State: APjAAAXxi7HT30OMHji4+5GXYBtC1t0VJkGI5MAFsJ3Q4mOKu79yqz3a
        fSqpEHrSp76xLduztuc/B0RN5A==
X-Google-Smtp-Source: APXvYqzeU6ktZruV6307EOPnFu0S/auGICxWezFUqXXV4L/USf6GdEp0kwPmRlzuszsyR45ZVgnnrQ==
X-Received: by 2002:a17:902:7797:: with SMTP id o23mr10818758pll.298.1581316586487;
        Sun, 09 Feb 2020 22:36:26 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id f15sm11070041pgj.30.2020.02.09.22.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 22:36:26 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH v7 2/5] arm64: dts: mt8173: add uart aliases
Date:   Mon, 10 Feb 2020 14:35:21 +0800
Message-Id: <20200210063523.133333-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
In-Reply-To: <20200210063523.133333-1-hsinyi@chromium.org>
References: <20200210063523.133333-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add serial as uart aliases in mt8173.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 8b4e806d5119..790cd64aa447 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -50,6 +50,10 @@ aliases {
 		mdp_wdma0 = &mdp_wdma0;
 		mdp_wrot0 = &mdp_wrot0;
 		mdp_wrot1 = &mdp_wrot1;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
 	};
 
 	cluster0_opp: opp_table0 {
-- 
2.25.0.225.g125e21ebc7-goog

