Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355CFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF1D207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVsRYMJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgHQC2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 22:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgHQC2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 22:28:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF57C061786;
        Sun, 16 Aug 2020 19:28:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t6so6977905pjr.0;
        Sun, 16 Aug 2020 19:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbcJUyoj0MOJokhYZmJrPSYDEwXtGHbcuB04jT0aeKc=;
        b=KVsRYMJVPNoEtGvtrltMYHLL6jROX0rNW4WKSOzfztMhKPnz8jE11IKEc4/CccH/uo
         nBUSmP57qfYQ2AjZY67PciCUqIvOHE4oCZo75y5Q+xI5U2DkkL8DinMbD4YfQ5TXL88L
         71At5RlXp72Ie8Cp/PInI+g9K6DuP9mDmpTmL5oGAl3GeaN0dgnuSyaXu+YXnKX55HC5
         qXczRqJ24XPeHJJ9lmc+OZWhtT82a6tutoZ/S1pfE73XL9Zx2POkGf1F3BQjqs9pjMvx
         wCZD4qjF/xFAeZweuLhfKM51il334K1WmppcQeJ5dqtN3vTrirehWYTcBLGTuxnWb13B
         A/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbcJUyoj0MOJokhYZmJrPSYDEwXtGHbcuB04jT0aeKc=;
        b=Nx28DqME026k0iIurKSB0R5Zwdcw9li+dUUK/sTWW8lvlIQ+8LKqvI+Ky3XCkyEUyk
         N7jjxvC8zba07XrIYEuMELjiLt0ZkDPcq8O/uKeG7Gdw6Pby1JWdjN+H2ZZbVvdiPbbm
         Ye0z9d3yAFKbKOOBvWH/H66VQBcBREUX96FYxWMzLDlH7N5FqcqaYBXlQlnvBlINAe7Y
         wpMWaFAfRsmgCui41CI31e7WpE7YFXTG5Gxf78Xql1lhP19LC78StIPV8bLJQE1WCbc/
         IILzqaVwXxiSRA/nW4P8jV7E/iDo/NVLSI8vYSyL5l+zKSjNpswr4e1nTFMdfGlezPRm
         ARGg==
X-Gm-Message-State: AOAM530LLbrLuMGyPeF367+pPhpMsfo6CjG1k4e6lQ/+oB2+s0mpFErj
        oikGDXn5LsDageaHuXDQpVdTXsqxXQfMKg==
X-Google-Smtp-Source: ABdhPJzi8UPPr6Sn5AGuLmo44rS1J7ZYzCY7Hm/QJvnKqkRqvO/5N8rpyA5dH69P8M4RpaVo7phyQQ==
X-Received: by 2002:a17:90a:1749:: with SMTP id 9mr10864111pjm.127.1597631289661;
        Sun, 16 Aug 2020 19:28:09 -0700 (PDT)
Received: from localhost.localdomain.com ([2605:e000:160b:911f:722f:a74:437d:fd3c])
        by smtp.gmail.com with ESMTPSA id x28sm17445687pfq.141.2020.08.16.19.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 19:28:08 -0700 (PDT)
From:   Chris Healy <cphealy@gmail.com>
X-Google-Original-From: Chris Healy <cphealy@gmail.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        stefan@agner.ch, festevam@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>
Subject: [PATCH] ARM: dts: vfxxx: Add syscon compatible with ocotp
Date:   Sun, 16 Aug 2020 19:27:46 -0700
Message-Id: <20200817022746.3115005-1-cphealy@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Healy <cphealy@gmail.com>

Add syscon compatibility with Vybrid ocotp node. This is required to
access the UID.

Signed-off-by: Chris Healy <cphealy@gmail.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 0fe03aa0367f..2259d11af721 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -495,7 +495,7 @@ edma1: dma-controller@40098000 {
 			};
 
 			ocotp: ocotp@400a5000 {
-				compatible = "fsl,vf610-ocotp";
+				compatible = "fsl,vf610-ocotp", "syscon";
 				reg = <0x400a5000 0x1000>;
 				clocks = <&clks VF610_CLK_OCOTP>;
 			};
-- 
2.26.2

