Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE0AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14BE620781
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgsP9okA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgF3AJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgF3AJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:09:05 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01B8C061755;
        Mon, 29 Jun 2020 17:09:04 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q90so7918276pjh.3;
        Mon, 29 Jun 2020 17:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AYRl8pOAy8o2qO178aXaRH0fdWgs7Bra1sCO7acnTT8=;
        b=BgsP9okAqsbNdfU8Qix1naJZC6HZ/DB/tRSbhLZXsMdFJ3//c8ILFfjvIsdEtdbGe8
         WRNNeOa/ZbF+eJSGaDMTCfI/wS+aBk3qMC8p47zIvI8LMbSGVXMCJCT2J+XbFto6Phht
         u9IfBs6id4Woyr2Hz7pxGPdt5+63cbCRCUyetzRdWOuEDWVpVd/hpSdfjjLnKPOgKR+b
         Q1mXnrLYH4bXjUX3snuFbNYlE36BiCXwsXxAVUgD/SA/FYvVvyF1YITEafIic7jal7pj
         aWr1mhNFpjIaXjSzLdMpam2u7Jop5dpijsoH0GKhooN29zh9KQsueW/aWgIbBj6l/OVW
         s8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AYRl8pOAy8o2qO178aXaRH0fdWgs7Bra1sCO7acnTT8=;
        b=JfIUMc7Ilb3hYPDcPB8dcf0jkSjsUK7Pzq1R9yFXGsJFA4zE95PnDDkCUcMggThsww
         UrmXh3ldddIw4JWK15MyQHOI8EzvpogT9zLj/L7tCsM6lQuy+IYNIK8njbBJHbqajBD6
         gOLU7zNA9xQ9XCp/D1foGluPOiJyPG7a0eLU2FjQaOALmFVAA+7Ca/BQCDIvRrJOqmsL
         UpNyrKFDPFdd7jnEyay0AM7dCO55oCo/gMloyYSIdoWujzPh3lEGF2CLC8jLqt8G1zf+
         ZBO7M+D1wK74b1jZMwOqXyr1BiD4i7O+kNWkqu8SAHT7tXaNRmm8BNPFxmmbRIPSz0cw
         8h3Q==
X-Gm-Message-State: AOAM530g46q4a1c5zFH3l1UEIjJm+IXq9Ki1YD6LwQJKQZpnDzQSopas
        Mr6m8FtLPFXrOI3hb/f1MY8=
X-Google-Smtp-Source: ABdhPJw2TID2zawq32v23OdWSYQPmDRRXwFxa4iOa/bk/gIfLeZrz1CVQRgGVdgnQJcDErCNb42UDg==
X-Received: by 2002:a17:90b:4910:: with SMTP id kr16mr10855811pjb.126.1593475744335;
        Mon, 29 Jun 2020 17:09:04 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id m9sm754600pgq.61.2020.06.29.17.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 17:09:03 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 2/3] ARM: dts: aspeed: wedge40: enable adc device
Date:   Mon, 29 Jun 2020 17:08:50 -0700
Message-Id: <20200630000851.26879-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200630000851.26879-1-rentao.bupt@gmail.com>
References: <20200630000851.26879-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Enable adc controller and corresponding voltage sensoring channels for
Wedge40.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
index aea23c313088..1049cfa80ac2 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
@@ -27,6 +27,11 @@
 	memory@40000000 {
 		reg = <0x40000000 0x20000000>;
 	};
+
+	ast-adc-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>;
+	};
 };
 
 &wdt1 {
@@ -126,3 +131,7 @@
 &vhub {
 	status = "okay";
 };
+
+&adc {
+	status = "okay";
+};
-- 
2.17.1

