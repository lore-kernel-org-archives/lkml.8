Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABD5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 01:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5431206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 01:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajK68aMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgGHBAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 21:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgGHBAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 21:00:23 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E54C061755;
        Tue,  7 Jul 2020 18:00:23 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x9so3793664plr.2;
        Tue, 07 Jul 2020 18:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KvpMciF86CSc7RkRJ7qW81+ZPWoK2hqTyP6YUhfAR/w=;
        b=ajK68aMHC92DcsW97jFZ8MVFaVFFeraZayZ2LpJzwPhFzi5ytARAWzMoOs6W/Xq2KE
         KflLR/vbh/zRonjNvQ66PrQzHc4IBqpq1PNnwl9ger7z09C/7NoEmFJj43vTIsiEfQPz
         fdbvOlxE4lcRaR1+4G9+yL16x1LB1F4D/TC0edrytlTnjmMQset7SU46iSGhE7xub/Lv
         HxZSof3bQ9XcdTgvjW/rtFOyparFwN6IoVcYHn2DIoWY4yY+exZTQhLRhuRvtYgzlIRx
         QFIkvdtkD1/ZrYp56HvKp0ax0RofLIt8UWKPcb6G5SZ+p56q9+Nq5lb5oysp9Je8y4Y+
         34KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KvpMciF86CSc7RkRJ7qW81+ZPWoK2hqTyP6YUhfAR/w=;
        b=b3ccrGpKhpnZBWTs+kuzF8tUR1p6rMqKf2g6GU030nMdyGitorAkX3xDasALCP/E5n
         f57PY8OUwlZFyE6Cag+ZJ3Nt8ftjjJslOVOR/EGj8BoxKlhnnKSxb8HOMqSj1ZzMH4xp
         Nxm4Jhw2rrVAmLKi8ju2XstTdm9lxcjOgkgP0TS0MOb94eXeZwI7ojqMRG6lk85b9Ffm
         UfPODYUC6KSL2QbSjzdZ/PLTaii7Awf2jGhgoIIOTFKTb0Enhv85otxYDFpYT+MhvpqK
         tILsZVHOrwse4aPhE23OK+N0Kw/2vytojpKULlNWmF//FsfERUecvmmD9hsTDSBfrZkY
         tzOg==
X-Gm-Message-State: AOAM530rnUjQIdWo2fLBRVyE09/CfmqnDipKDSAGLeaw11hSyoXpNwLF
        7sqw98006XEhZNOCC5Ji65jEauLYU8WyTg==
X-Google-Smtp-Source: ABdhPJxGU2pVBPzPSip/FGX3f1RpJs/tI8PizP4jHpU4GJXresP6Vr5XwJXr6LWrF5eBglOHi3sA5g==
X-Received: by 2002:a17:90a:d912:: with SMTP id c18mr6881603pjv.184.1594170023105;
        Tue, 07 Jul 2020 18:00:23 -0700 (PDT)
Received: from localhost.localdomain.com ([2605:e000:160b:911f:a2ce:c8ff:fe03:6cb0])
        by smtp.gmail.com with ESMTPSA id 191sm23361234pfw.150.2020.07.07.18.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 18:00:22 -0700 (PDT)
From:   Chris Healy <cphealy@gmail.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, andrew.smirnov@gmail.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch
Cc:     Chris Healy <cphealy@gmail.com>
Subject: [PATCH v3] arm64: dts: zii-ultra: update MDIO speed and preamble
Date:   Tue,  7 Jul 2020 18:00:05 -0700
Message-Id: <20200708010005.6366-1-cphealy@gmail.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update MDIO configuration with zii-ultra device to fully utilize
MDIO endpoint capabilities.  Device supports 12.5MHz clock and
doesn't require MDIO preamble.

Signed-off-by: Chris Healy <cphealy@gmail.com>
---
v3:
- make "status = okay" the last property
v2:
- Fix subject line to reference zii-ultra:
- Get rid of "=<1>;" from suppress-preamble lines

 arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
index 6a55165bd76a..0d1088dcaa02 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
@@ -131,6 +131,8 @@
 	mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clock-frequency = <12500000>;
+		suppress-preamble;
 		status = "okay";
 
 		switch: switch@0 {
-- 
2.21.3

