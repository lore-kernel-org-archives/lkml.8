Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79366C47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5963A20661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="LQwCci65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgEEODW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729378AbgEEODS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:03:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EF0C061A41
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:03:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y4so2660918wrm.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qePp19LiRiOBXtccpgQ+eI6GUOhz0auoBWQ11adkXY=;
        b=LQwCci65NzZKH7S/k3KLNL9uDqCmT0NhL3+vr0FbsT08zlA7KCjEKKJA3sZtnf2+C9
         MgO3OOfj1iU8OOWJHAIFg37vsHsbgcG/ty8jsHreNlysA9n/Au6JLGB7Xxv750eTBgT+
         Sl+iLzCZd3APUglRO82tTPfZvQVLMJ3uavNHAqLe/avFh/YZADgXqEMvzVqRopDktCy2
         JBbLkT1YWVum/i0H4xsIcA/O3SnOtyCQ72Fc/9gVx/ow94+06PK5wjuMsmA86t5vb78a
         f1BNH1aOQZ6Kmm6CjzEh853K5kHs/8DpEoorye+0Q8Vxs8MX0SzFaarHH6cmphLUotuV
         jc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qePp19LiRiOBXtccpgQ+eI6GUOhz0auoBWQ11adkXY=;
        b=fGTe/k9HxSlfc7+m4UUZC05xT9n++a8W0/lKkWBYDcPYRQwqc4O6qjYfgPmdQPJ6tI
         Tmb6vE2C4YkWxqQKkhDlpOL4mmjxw9ofat1SY/hKH3KKCXeQVpXifWEiHomUj1V9yPMO
         +R/UUw1KlpYoHZrAfaSXTVILYBicf+vaEMO0rs/jT+xx0sI+0284d2yCF5h68G1nCwLb
         vTZ7tep6ogco6OZ5VVsAXutwRsXZW5Lf9BS3ZUCTGars3yuUPLIaeu9beA61QafThbeF
         YE5oZUVS3M6xaBhLwxSH74i3AXM4UV4HGTHfrGvqnfXF4ImfcKPc89uDYkftqAJY6gXp
         iMVg==
X-Gm-Message-State: AGi0PuZKQcuSKI3ic5kIIoltZPf6+SY18eEYxltBj/9u8zyNIvVD3m05
        LBapzgNzGkFnnm1HERqSIZEm7w==
X-Google-Smtp-Source: APiQypKqTKjLTaeehBmyF8ZBLt7Ztsq7bEei0OsGAye1X2D3s2hQaZgytBvFg7WpUlAYtX37tEZNHw==
X-Received: by 2002:adf:ab5c:: with SMTP id r28mr3827494wrc.384.1588687396984;
        Tue, 05 May 2020 07:03:16 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id c190sm4075755wme.4.2020.05.05.07.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 07:03:16 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Felix Fietkau <nbd@openwrt.org>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 09/11] ARM64: dts: mediatek: add an alias for ethernet0 for pumpkin boards
Date:   Tue,  5 May 2020 16:02:29 +0200
Message-Id: <20200505140231.16600-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200505140231.16600-1-brgl@bgdev.pl>
References: <20200505140231.16600-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the ethernet0 alias for ethernet so that u-boot can find this node
and fill in the MAC address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
index a31093d7142b..97d9b000c37e 100644
--- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -9,6 +9,7 @@
 / {
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &ethernet;
 	};
 
 	chosen {
-- 
2.25.0

