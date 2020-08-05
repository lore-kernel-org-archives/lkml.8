Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA006C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0AF922D00
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="YRCgWsJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgHEQ4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgHEQxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:53:52 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2C1C0611E0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 04:01:32 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u10so15552557plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 04:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Az+AszYcHQWzYCnqT/5thfyfYHza99FgAVuo6NVwe5o=;
        b=YRCgWsJ8pGTf9hSUA+n2UAu2tevH60z+ftxm0yHShwRstP9B0a1upVpRfJz9WDL68j
         l8yEHTiQCLSdNiS/bRbYfVZ+rUErAa9vmbTXK3h+gByDGPVvEMF7jquoke5sRJfn1vME
         CoeVdQYK0iRon/IxKtqOxQkQ8hb7nxsG5ig+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Az+AszYcHQWzYCnqT/5thfyfYHza99FgAVuo6NVwe5o=;
        b=B1+J1rrW1gB64YN8+mK+Wxp4696y+Q/mL1EkvSNWVPJ8qJ7iyYaeShrGHoutEykSgR
         3BFixAq3wLSLMKhr05FH0WEBVdLrNOb/RX8u3HQSbAK25bqu24yVpwvs5ST/gYPeKQw0
         4XpMPr878NqbLzPtSlKQEpEnmuhpR7BL28saHqv8sFbxOb64ihycFujBzaz7KdG/PfD5
         47ag4RpmK96DNCIuJy55BebFr2jkkFXxsiJisUgvmuzejHYLvOMZ+IDE+th/FdFKsTdk
         iHlbcF0dkpi6LjERpH0CQSBJHVep81xyhodWyfwd6GvXnLRKpECS0884l8SSi04IiHSy
         WP7g==
X-Gm-Message-State: AOAM531CI8KBlH7momWg4EtmYg8zAiDaKvye7jc1b4prxhwqOBfJauEI
        w22zDUnbb/aqepKYNL8CaNStBA==
X-Google-Smtp-Source: ABdhPJxtCw0v0qrAXzPqLGiqTkiXcYFmKfdnKsHWfbhgvd5nuFoxNKvUzwQxkBrwLUbkzgfT+9qCGA==
X-Received: by 2002:a17:90a:e643:: with SMTP id ep3mr2780313pjb.18.1596625292189;
        Wed, 05 Aug 2020 04:01:32 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id fv21sm2583142pjb.16.2020.08.05.04.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 04:01:31 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        robh+dt@kernel.org, arnd@arndb.de, Daniel Palmer <daniel@0x0f.com>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3/3] ARM: mstar: Add interrupt controller to base dtsi
Date:   Wed,  5 Aug 2020 20:00:52 +0900
Message-Id: <20200805110052.2655487-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200805110052.2655487-1-daniel@0x0f.com>
References: <20200805110052.2655487-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the IRQ and FIQ intc instances to the base MStar/SigmaStar v7
dtsi. All of the known SoCs have both and at the same place with
their common IPs using the same interrupt lines.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Tested-by: Willy Tarreau <w@1wt.eu>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 3b7b9b793736..2b3bb0886d1a 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -85,6 +85,26 @@ reboot {
 				mask = <0x79>;
 			};
 
+			intc_fiq: intc@201310 {
+				compatible = "mstar,msc313-intc-fiq";
+				interrupt-controller;
+				reg = <0x201310 0x40>;
+				#interrupt-cells = <2>;
+				interrupt-parent = <&gic>;
+				mstar,gic-offset = <96>;
+				mstar,nr-interrupts = <32>;
+			};
+
+			intc_irq: intc@201350 {
+				compatible = "mstar,msc313-intc-irq";
+				interrupt-controller;
+				reg = <0x201350 0x40>;
+				#interrupt-cells = <2>;
+				interrupt-parent = <&gic>;
+				mstar,gic-offset = <32>;
+				mstar,nr-interrupts = <64>;
+			};
+
 			l3bridge: l3bridge@204400 {
 				compatible = "mstar,l3bridge";
 				reg = <0x204400 0x200>;
-- 
2.27.0

