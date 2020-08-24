Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F369AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D032072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0eJ4Bth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgHXVUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgHXVUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:20:01 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA63C061755;
        Mon, 24 Aug 2020 14:20:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id n3so239218pjq.1;
        Mon, 24 Aug 2020 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g7VV/krJKjpl3fVXGlaNY9/0wsMNumXkPGYdDy0NLaw=;
        b=D0eJ4BthOJUjXlvokWibZqWoBGnjmf0N34bXsEzLNsxiDNvnx22WiQpvgVHLvrVg2U
         YtMPLVrC65sSNGnhPK8hhLrx2TmbixqTyYkl+hDWMJS03TR0g/F4wrt6vK77DrSFsbYS
         PaJ5e97HLwPuuhgK1fkMjLLmsJwzRm0ciHF/9yVqKVaRBUzKR39gdq1TsmsIqcg8koiG
         xqs+F9BBXUai+sDSwGOXIgRyxJneWpqfbckjXvKiWnU7z4h+6Jkw6U6pBbfFBnpFBkzN
         2UWWXngLvD7gZ/arZEHqxolP9I9/LMmrfPDpbUK9uObH7kcXWCOsh0vMK7/6RpBrWfrc
         BsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g7VV/krJKjpl3fVXGlaNY9/0wsMNumXkPGYdDy0NLaw=;
        b=tUCIFQTf32Y+6CeNDXaIpIxi7kwyGfvLQcOVz7qacGBb8EWjoImW2xkOnVBsrGmMrh
         I27XlYbA9dt5OFcWQT0OaFlwQYNBE4TC6UB6M+PjC9Gz1bu5UvJEVbcGDan+dVTlquSf
         BM6XTQi+OxVCGt3moxcGD0wI6fUM4TCTbTf2BoRQdoyTJTmpj3P5SCjXHgkq9ZtbYglY
         yDDXarHCaD5gHVzq93cxF00RpO7sgUHZ66NUiLSUVzDa7/ze7lUwmx04Co77C29jYUqk
         JBPjLjQnx2J1xLxKWAxAvT18YJMXvvT8SyC58DPdYCWOoRz4DxnhcUyBXWl35qs72PEO
         qs/g==
X-Gm-Message-State: AOAM530lrmi33zp3ZRZ2Mq6PPc3b2n/VK3oc31+I12bvwvsldO59E6u1
        Q3gHe8Zi5MwwHIYSlBSXEk8=
X-Google-Smtp-Source: ABdhPJyugdNrli9G6rRXQAqw0VEFn+pFbiLqtwFesKfsieewyGLJXfjSPVXdmt7qTmHtDJGOqkDPfg==
X-Received: by 2002:a17:90a:cb92:: with SMTP id a18mr883425pju.80.1598304000683;
        Mon, 24 Aug 2020 14:20:00 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id t10sm97788pfq.77.2020.08.24.14.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:20:00 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 4/5] ARM: dts: aspeed: minipack: Update 64MB FMC flash layout
Date:   Mon, 24 Aug 2020 14:19:47 -0700
Message-Id: <20200824211948.12852-5-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824211948.12852-1-rentao.bupt@gmail.com>
References: <20200824211948.12852-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Set 64Mb FMC flash layout in Minipack device tree explicitly because the
flash layout was removed from "ast2500-facebook-netbmc-common.dtsi".

Please note "data0" partition' size is updated to 4MB to be consistent
with other Facebook OpenBMC platforms.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../boot/dts/aspeed-bmc-facebook-minipack.dts | 47 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
index 88ce4ff9f47e..c34741dbd268 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
@@ -88,17 +88,60 @@
  */
 &fmc_flash0 {
 	partitions {
-		data0@1c00000 {
-			reg = <0x1c00000 0x2400000>;
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/*
+		 * u-boot partition: 384KB.
+		 */
+		u-boot@0 {
+			reg = <0x0 0x60000>;
+			label = "u-boot";
 		};
+
+		/*
+		 * u-boot environment variables: 128KB.
+		 */
+		u-boot-env@60000 {
+			reg = <0x60000 0x20000>;
+			label = "env";
+		};
+
+		/*
+		 * FIT image: 59.5 MB.
+		 */
+		fit@80000 {
+			reg = <0x80000 0x3b80000>;
+			label = "fit";
+		};
+
+		/*
+		 * "data0" partition (4MB) is reserved for persistent
+		 * data store.
+		 */
+		data0@3800000 {
+			reg = <0x3c00000 0x400000>;
+			label = "data0";
+		};
+
+		/*
+		 * "flash0" partition (covering the entire flash) is
+		 * explicitly created to avoid breaking legacy applications.
+		 */
 		flash0@0 {
 			reg = <0x0 0x4000000>;
+			label = "flash0";
 		};
 	};
 };
 
 &fmc_flash1 {
 	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
 		flash1@0 {
 			reg = <0x0 0x4000000>;
 		};
-- 
2.17.1

