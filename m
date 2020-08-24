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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D88C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CEA120656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXxLh7Vt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHXVUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgHXVT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:19:59 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA09BC061574;
        Mon, 24 Aug 2020 14:19:59 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w186so3160095pgb.8;
        Mon, 24 Aug 2020 14:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rXBG77uZ+juZ55nF2nk//sAT0YipNn7g2EO+5+pDj1E=;
        b=QXxLh7Vt6vSOsYqAnE3CpFos70Yk4e3pu5/M0Pix5/hJ909bsaOIymUxSaW11DFDvT
         tXlYnpaWTyEHjGILHAq4GOuXRuKrWA0uafYsecqWN3lkZN9llUGOOyzyZNXvFJOO6VuI
         nXG1TIkS23PQpmbJ3vgmXjvBnwq4GNY37tHuHCv899iSG4tQ00pqYjct4OZS8OA9leHc
         paD2aMk0PgA5a7CZKbqlxsZraUp33AzRU97OI2UtyMF64gplUtNoCp16latnABJqVuxQ
         ZADC9RVxrryGuOiN3TvSAxIaKstLOldkMYwbDk8pxBYNMyMGp/4dTCS3e1v7UjjPmQVr
         THQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rXBG77uZ+juZ55nF2nk//sAT0YipNn7g2EO+5+pDj1E=;
        b=TbJZ5+UnbiQDuuF6L6yWzD76kpCbO4zj04bHuvVniquPSE10rnQ3nVkCLwGVLUxBlH
         0Zhh0Zr0oCRmt+0LRgpWYaKY6PUWGzv0FNx9pneaaoiRE7C9TNBJl3YXGFwTBa/bF9ou
         ag+23uOygCGPE2cn5PnUNHxR+AKX44YlqYlNHnlXG93vqhQ75BoW8C3FZxY8Ra0x/g6g
         B7UIjepeEsEN/LOlHKBLcy82iviv+K/6z8MY7o4FfvPTRy9CX/qhNRhn4fEuBmNsG5L8
         ctCobJku27iyHCLvzGEVT9Sztr5bGFh0jsBsV/aozXYsIi7Ix7Wk+sl10yBuI+GkmAGT
         nh+w==
X-Gm-Message-State: AOAM531KAMkrdRq5RN32220EHDAZJYiWfz9nLdticcx1KSl/XcOPKZIG
        k+Z5LuTiX/gohI6K6Os3wnA=
X-Google-Smtp-Source: ABdhPJz04w77u6/hGINaTXWQWFtFKH3m7WKP9npNSL5MEyNDMXnSp3StFRYm+WPchS3GBDJQxccaTA==
X-Received: by 2002:aa7:8285:: with SMTP id s5mr5365120pfm.226.1598303999175;
        Mon, 24 Aug 2020 14:19:59 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id t10sm97788pfq.77.2020.08.24.14.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:19:58 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 3/5] ARM: dts: aspeed: yamp: Set 32MB FMC flash layout
Date:   Mon, 24 Aug 2020 14:19:46 -0700
Message-Id: <20200824211948.12852-4-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824211948.12852-1-rentao.bupt@gmail.com>
References: <20200824211948.12852-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Set 32MB FMC flash layout in Yamp device tree explicitly because flash
layout settings were removed from "ast2500-facebook-netbmc-common.dtsi".

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
index fe2e11c2da15..5e6105874217 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
@@ -108,3 +108,20 @@
 &i2c13 {
 	status = "okay";
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

