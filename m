Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6933DC433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 485262071A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNsqvlR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgGWXF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgGWXFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:05:52 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FFAC0619D3;
        Thu, 23 Jul 2020 16:05:52 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g67so4066019pgc.8;
        Thu, 23 Jul 2020 16:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lVepU+ZwtLg61EekGifFvcWIHx8/75YvPPQTkYbwJr8=;
        b=NNsqvlR3R/ebOXczP2pa2IDEyMN0WNJyDr9UhwB/4qENFd+cLas/Dgp5yds2vqV8w5
         8wZrsTnhFfLyN40fhTbzZrb/1NCwNjK67Dvh5cWniM/F8I6u9MwtScNx3mBjcJ5G1/mP
         tgWTMtKnfVcIm6opPG/3h0K/16DXVJ3KaN2fHxs9VMRbDCHoEVztRo1pinCryuZtXw+R
         kpPuvWQH71NWFAkLdvsbfVB4E9DxT0NpohOQeNq7ssE7Yu2upjLR55OR9Vxh0dEFxgwk
         6EWQayW6LYAy53OcOTl3SYnZUkjO0qj7uq3KzdLkr90Aa8A0KabDJp4ZnuUaobeHtI9m
         2Cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lVepU+ZwtLg61EekGifFvcWIHx8/75YvPPQTkYbwJr8=;
        b=CJDs/vRzFuhnafCAsxugYaQDnxR2jpWxLaLuJGUJdyp0tbnH+9TnkEj13wvlIugDQ9
         E9hKBVwTholE3VyJkNPmp9NeKCoafXPITRn1a0EBdOKMqso5CdMsdj18vGXbVUP0Cz0e
         427pKtJVNmdjHxuUe5aVshoNJPtbyMT7tmF4Sr5kBCeBIDvP7d9mgyxQcLG5+/Jd6s3E
         EgGdxq3/rFa606GccCENoKM39t3Laitw4aGax5n5iItNEQThTEG/aXxC1ggZpQpt6W/x
         ltu0FFr0teDP6rd1Ob19xBqdJWAsDbQcnFKh4XUhKFCiIEDgxph623+iZ2XgQtxMSWQQ
         1scA==
X-Gm-Message-State: AOAM532UWyPZxAU7ST9SDA7l9Yl7vh5924kH5CMGnY7w4b/kq/caFrLI
        kKI3J/RlWPO77bG8QdHbh8o=
X-Google-Smtp-Source: ABdhPJx4kMBNnslf9Qu63+wKCjksfkfXgOJnn1caCxGQDWIOybaTSq5CmdnP2Xv5ovGfX7C2Gd/ucg==
X-Received: by 2002:a62:3246:: with SMTP id y67mr5914578pfy.131.1595545552160;
        Thu, 23 Jul 2020 16:05:52 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id gn5sm3644742pjb.23.2020.07.23.16.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:05:51 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2 3/3] ARM: dts: aspeed: wedge40: enable pwm_tacho device
Date:   Thu, 23 Jul 2020 16:05:39 -0700
Message-Id: <20200723230539.17860-4-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723230539.17860-1-rentao.bupt@gmail.com>
References: <20200723230539.17860-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Enable pwm_tacho device for fan control and monitoring in Wedge40.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
   - Nothing changed. Resending the patch just in case the previous
     email was not delivered.

 .../boot/dts/aspeed-bmc-facebook-wedge40.dts  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
index 1049cfa80ac2..8ac23ff6b09e 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
@@ -135,3 +135,32 @@
 &adc {
 	status = "okay";
 };
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default
+		     &pinctrl_pwm1_default
+		     &pinctrl_pwm6_default
+		     &pinctrl_pwm7_default>;
+
+	fan@0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00 0x01>;
+	};
+
+	fan@1 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02 0x03>;
+	};
+
+	fan@6 {
+		reg = <0x06>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x04 0x05>;
+	};
+
+	fan@7 {
+		reg = <0x07>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x06 0x07>;
+	};
+};
-- 
2.17.1

