Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4896DC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E282469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZutASD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbgB1CIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 21:08:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41728 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbgB1CIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 21:08:16 -0500
Received: by mail-pg1-f194.google.com with SMTP id b1so657538pgm.8;
        Thu, 27 Feb 2020 18:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S4kJGuEJfAjfPYh/Ew20Fs75jjdr/lDPxEC7XvHdiQ4=;
        b=UZutASD0HqaUsmZQ28/j4nBb0ea4qnMjWg42ddLNpUQYkPvicXpWWaj+s0HbQjY6UE
         rcOytnas6HACXzfJ5qU6ObxXqRQdL4vZJPEIQDJlMXPh+LU6m2g3a1iL2d26ImThm4dn
         V9pDMYHqNXEWA7T7Lm+c3vITxW0NmH0bUckrlby8M4g2CZY3uwbLeyJfqQFZhMWHwXa+
         ZiMNMP/6oZd7iVbJd8WKby+deNCmiz/TqUzsw79RXaWJ5k4dVQhcp4skiqJXB2AOyANz
         cM7IopAYZcZxoAY9bFG9vt/ENAhgu70gjFRm7ILiD8A5xlaPqo3BGudTld5x6mE9Lg4f
         INLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S4kJGuEJfAjfPYh/Ew20Fs75jjdr/lDPxEC7XvHdiQ4=;
        b=cHqDuClVePguBx831lqcTN16r4YwGAjV/Cefmps+iRnpwE641cR3AvgH5NoOO9KsVF
         5jKevTFq1GuJh9EWVVrAN0LE2kcZx43esyKekI9CxCXMUFNacCygz5xEfqq0UMqu7GdQ
         hxjzbu8xg9mIGJxxD0LSp7QuMNWxy96ydlUJSRt8GyXXMopwlq8PUu/HBO/pd7Q+QM+J
         BcT9sk2qmG+NCUuMoeRDPcRXgj7Z0g60URbqn6YlPNRXP90jwKYTKrsMTnYAGCxdsLk9
         HSbmuM6RfVtW0Fa4zdUuhFgM7SOeHzPZNHEX6+DGWdbFcGoi5GHUblA1SZquxF2FtsGH
         XYNg==
X-Gm-Message-State: APjAAAWlpcqgBvNq4DL3B055AWwHGZz6ugAnjcoVnsLV5Fz8ccxzAZgA
        5bqrRBEVmMgJi4tUy+ngk8A=
X-Google-Smtp-Source: APXvYqyyuwzFsaoesPovGGYPfNjv0U27sfwo1cNSj3VSdjUokF67ekm0yo1YUh2GET9uSjk0VZpl5w==
X-Received: by 2002:a62:f251:: with SMTP id y17mr2111805pfl.204.1582855695286;
        Thu, 27 Feb 2020 18:08:15 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com ([2620:10d:c090:500::4:d8f5])
        by smtp.gmail.com with ESMTPSA id k24sm4931972pgm.61.2020.02.27.18.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 18:08:14 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v6 5/7] ARM: dts: aspeed-g5: add vhub port and endpoint properties
Date:   Thu, 27 Feb 2020 18:07:55 -0800
Message-Id: <20200228020757.10513-6-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228020757.10513-1-rentao.bupt@gmail.com>
References: <20200228020757.10513-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add "aspeed,vhub-downstream-ports" and "aspeed,vhub-generic-endpoints"
properties to describe supported number of vhub ports and endpoints.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 No change in v2/v3/v4/v5/v6.
   - It's given v6 to align with the version of the patch series.

 arch/arm/boot/dts/aspeed-g5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index ebec0fa8baa7..f12ec04d3cbc 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -195,6 +195,8 @@
 			reg = <0x1e6a0000 0x300>;
 			interrupts = <5>;
 			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
+			aspeed,vhub-downstream-ports = <5>;
+			aspeed,vhub-generic-endpoints = <15>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usb2ad_default>;
 			status = "disabled";
-- 
2.17.1

