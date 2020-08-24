Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4641C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF4DC2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufAGhVXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgHXVUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgHXVT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:19:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E853C0613ED;
        Mon, 24 Aug 2020 14:19:58 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q93so241203pjq.0;
        Mon, 24 Aug 2020 14:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SHgVSjx2yqDsWyd1CehQGWoYGWtbaX9g6kRsRLnmAA0=;
        b=ufAGhVXRwbazRrjv7wmQP6zZfKBhVZ/beiIhEkc13v34Pt0yqZ/2CnBkHguihWs/I4
         YVrA86gIIEtYVI3RLiE7IMNmrM15lnPVEUP8o/YJVNw7IBZrpaxWgzfYom6WOu93MCYY
         nf8TSgt+JtkARl0PWkihCHzlivtDlEkBSpv76T/gVetbWpf8iPkMg2tWNL0Dg3b9PryQ
         pIyzQIVCjJVbblAmPOjevmlaielNQR6dsPZxZ3s2dYJ29chBvYbtlzqJj4C4UECvOrVs
         hZm6+LC5HmSfIHySDueERLRPOLGmt+7qy612erQL69iRL989e8R56E7KfA319IuVGj3x
         jMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SHgVSjx2yqDsWyd1CehQGWoYGWtbaX9g6kRsRLnmAA0=;
        b=nEfcQCoq/XKaZK09Lkv8EezS/RAEotnRPc+1G6U9Ud3PS7wqAfj2cqKlQWthMzNjd3
         1VROZziYWxIdbjvmr3xMDvUOyXJDrKl6ULm9fruvJb1rGXuZttVHl+5pUJkN3jdFhKQG
         dEhfTyoWC9E/Lfx1P6T8O1sd5FS9qohNXleynsWlhpKBaC5g9Yf+SUR0o6aU9rxmqA8e
         U1ZYVN605zPc8zWOiTvjGr+DMk2wbearEWJj7kssHzUBTmth8echViEWbrBymodKh1j2
         JQOAwDUKCi53QwaoCXf6SB0TIGdWVuRAKPI/o819oLHck0ph33/xJlUXmzgfEO82nKtX
         6iaw==
X-Gm-Message-State: AOAM5302DdXukz/Ft/4RkC39yOBUJWjR6um+cPWF7pTWoLHSSpg/LU2b
        EsIXTpnEZTbY+jV6qZpCJYE=
X-Google-Smtp-Source: ABdhPJxGThJ/l6QPVeLfdVw08wwd8JKo0aw6C6gkL9SSwjYxVH1u8R9NldM27eXVXWTW1M08FyOhfQ==
X-Received: by 2002:a17:90b:1004:: with SMTP id gm4mr912858pjb.26.1598303998089;
        Mon, 24 Aug 2020 14:19:58 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id t10sm97788pfq.77.2020.08.24.14.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:19:57 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 2/5] ARM: dts: aspeed: cmm: Set 32MB FMC flash layout
Date:   Mon, 24 Aug 2020 14:19:45 -0700
Message-Id: <20200824211948.12852-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824211948.12852-1-rentao.bupt@gmail.com>
References: <20200824211948.12852-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Set 32MB FMC flash layout in CMM device tree explicitly because the flash
layout settings were removed from "ast2500-facebook-netbmc-common.dtsi".

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
index 7bc7df7ed428..2fb8b147f489 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
@@ -1571,3 +1571,20 @@
 &sdhci1 {
 	status = "disabled";
 };
+
+&fmc_flash0 {
+#include "facebook-bmc-flash-layout.dtsi"
+};
+
+&fmc_flash1 {
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		flash1@0 {
+			reg = <0x0 0x2000000>;
+			label = "flash1";
+		};
+	};
+};
-- 
2.17.1

