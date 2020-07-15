Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DCEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 801932065F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkvF95NL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgGOVcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgGOVcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:32:04 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC43AC061755;
        Wed, 15 Jul 2020 14:32:04 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t6so2934210plo.3;
        Wed, 15 Jul 2020 14:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZ0KZN00M7Eg2nobcUsMSLge6CDRhkBU7KyuTrMkvdM=;
        b=hkvF95NL8rjWtQcQbRXTa45+1CgC/E9jFnldkr6mUbbzH5gJ2v01dqkfscKRYxdt96
         c2n1c7nA4NkjBU3TIuDXiO1+B4n7G2wxlFTA01Q1lamosrnNYdyKvtXFNxOsjjzb+rso
         55ytSxuOH6nYXLVSu2CwrO8/93vkNH6li/YsR8z8mZsqobSNTAixUA1gm1o8oUZwuWWV
         HXl2ymgbWFXygf2QS/wSSCwKYuLc/UdJiPgzZvJnw3umjeIuw8HHjrOQ3o29HTEbeXCt
         LdFVrPQKhYQyOBaYbbgGQEUm8wjGYmlbxCE/OFifGmUY3ejmzNp2N3RenTz+cGu6xBLC
         LJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UZ0KZN00M7Eg2nobcUsMSLge6CDRhkBU7KyuTrMkvdM=;
        b=VH13u0vDaKoYdWn0ga5pRIO20FQNYmWQUpZW6KzBPHnNjsF55zzl+gcJaS0fry0eYd
         IHRpC738GbUJtV3qAmLN2lGECF9Kh0nEVVO8Mi6Jz2v7OlTxN1WJlsYm2a81VkGjOHIq
         V2nYZsNdsCeTLWk0znYq1IJfRx+SOTu8GIoxWWpSSaqTDA12APuLJu/eh/l13WG8PBWw
         ZK5TQA/WGeyd+1gV1Judn3IwPqN3va+yM9ahuAucstYXdPZHzXzICZcCckNbopEf22Ns
         iJG39mqwQJeUGVktRtmevmMxOqLyozkoE5KsX42lqGQKd0jgMRoCsMnAhy25t/OY2Uoh
         jChg==
X-Gm-Message-State: AOAM532Nc5xbcBCUCWLRWhAkscDBXozKKnHkX6rDp10v5BDHdHWlSwYe
        3UkrVmCT0+rVENIpM5LMU7OnBilWqy4WrQ==
X-Google-Smtp-Source: ABdhPJyrVYHWvterauvVzXr9uw030lc/7NE6tvL7B7K4foBORUOedgUo4Xir/9OGqj6O5g5bTFxfsQ==
X-Received: by 2002:a17:90a:148:: with SMTP id z8mr1750893pje.197.1594848724500;
        Wed, 15 Jul 2020 14:32:04 -0700 (PDT)
Received: from localhost.localdomain.com ([2605:e000:160b:911f:a2ce:c8ff:fe03:6cb0])
        by smtp.gmail.com with ESMTPSA id nl11sm447038pjb.0.2020.07.15.14.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 14:32:04 -0700 (PDT)
From:   Chris Healy <cphealy@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, stefan@agner.ch,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.smirnov@gmail.com
Cc:     Chris Healy <cphealy@gmail.com>, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] ARM: dts: vf610-zii-ssmb-dtu: Add no-sdio/no-sd properties
Date:   Wed, 15 Jul 2020 14:31:48 -0700
Message-Id: <20200715213148.26905-1-cphealy@gmail.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

esdhc0 is connected to an eMMC, so it is safe to pass the "no-sdio"/"no-sd"
properties.

esdhc1 is wired to a standard SD socket, so pass the "no-sdio" property.

Signed-off-by: Chris Healy <cphealy@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>

---
v2:
- Fix formatting so patch applies cleanly
- Add Fabio's reviewed-by
- Update subject line per Shawn's recommendation

 arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
index e37b9643269b..3ecc1ad5abea 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
@@ -81,6 +81,8 @@
 	non-removable;
 	no-1-8-v;
 	keep-power-in-suspend;
+	no-sdio;
+	no-sd;
 	status = "okay";
 };
 
@@ -88,6 +90,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
 	bus-width = <4>;
+	no-sdio;
 	status = "okay";
 };
 
-- 
2.21.3

