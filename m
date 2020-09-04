Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E731CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A47206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eEwr7rjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgIDTTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgIDTTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 15:19:02 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12D7C061246
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 12:19:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id j11so1593596plk.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 12:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qRMPP9LxKZUNiuhnbNUkYFs55rCgA//jb+vd/Rx6Ht0=;
        b=eEwr7rjOHjYc90SI75Z6Ut+MR+UIR8SjsReg4Nh+bkkNtf3q6mhsZe/DOfXcHbnOjz
         drKjfYKMQUPR1vGqcPN3Bl+y6ed/X+LsPKZVQsSpKrtVddmpMBN0zhjmooYpjO8cxUyh
         k3zKOVzfP8YdEHI1VaORIAtYLL2AQ6r2WUqAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qRMPP9LxKZUNiuhnbNUkYFs55rCgA//jb+vd/Rx6Ht0=;
        b=Gd5lYlwzPcPcqmpJOXBZ57A6kUuOJWtvdrn3I7iIGTS3I/xArCTKxS/ga3qOQUujn6
         VoQXHeqasl0wRY6D62nZMQUjE3CE17Yj6I8BgKrvx5SiN6Czo/58wtdn73ZacuouaQ82
         nLeAhkLkC7nMWeyO6KmGNogrrcufj7/67rYG4rgR2rc1D8gqNLcRD1kmGYI0KsushNbT
         e7Ke6afBPCfOVZXo70fsDm3iUpqGy6atZym73ubfodQl1bXaPpRgo5tA2nChf6rOLjuR
         F1g1KlBfaeTB2AuRP0Rlzwt/0rakcuxhGrQPtA6xsUy87nWhNrHg1RUlhbs4IEaRCFDI
         8Y9A==
X-Gm-Message-State: AOAM532mGQWfcL3CvwvJ/0EfTQzlBc/HxOwTqYjGQhC6zxDt/Rq1tVYe
        5TEggswb/AQGLHPJsfpmRbbMwA==
X-Google-Smtp-Source: ABdhPJzUuILtE+Lwd5POY+0Lfp6RXonJmBryQBkbG0RS+y2jdm+w1JLUsyQMiNXyvqjHmoi1pWFsZg==
X-Received: by 2002:a17:902:be08:b029:d0:5c75:38da with SMTP id r8-20020a170902be08b02900d05c7538damr9927728pls.1.1599247140913;
        Fri, 04 Sep 2020 12:19:00 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c809:c7d5:b9ea:24bf:6b2b:1eee])
        by smtp.gmail.com with ESMTPSA id t4sm5986001pje.56.2020.09.04.12.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 12:19:00 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Tom Cubie <tom@radxa.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 3/3] arm64: dts: rk3399-rock-pi-4c: Enable Display Port
Date:   Sat,  5 Sep 2020 00:48:30 +0530
Message-Id: <20200904191830.387296-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904191830.387296-1-jagan@amarulasolutions.com>
References: <20200904191830.387296-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Display Port on ROCK Pi 4C board.

Unlike, other RK3399 platforms with accessing DP Altmode
via Type-C connector, the display Port on ROCK Pi 4C is
accessible via physical display port connector by means
of Type-C Virtual PD extcon configuration.

Enable support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../boot/dts/rockchip/rk3399-rock-pi-4c.dts      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
index 4c7ebb1c5d2d..19a648add355 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4c.dts
@@ -11,6 +11,22 @@
 / {
 	model = "Radxa ROCK Pi 4C";
 	compatible = "radxa,rockpi4c", "radxa,rockpi4", "rockchip,rk3399";
+
+	virtual_pd: virtual-pd {
+		compatible = "linux,extcon-usbc-virtual-pd";
+		det-gpios = <&gpio4 RK_PD1 GPIO_ACTIVE_LOW>;	/* DP_HPD */
+		vpd-data-role = "display-port";
+		vpd-super-speed;
+	};
+};
+
+&cdn_dp {
+	extcon = <&virtual_pd>;
+	status = "okay";
+};
+
+&tcphy0 {
+	extcon = <&virtual_pd>;
 };
 
 &sdio0 {
-- 
2.25.1

