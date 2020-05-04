Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A90C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA7220721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ON7kbrtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgEDTvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbgEDTvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:51:20 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11036C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 12:51:19 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i10so522487wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 12:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vh444uXRAgRXgT6rgkMAr0JYfUHIeqhqHIUGvOQ7pc0=;
        b=ON7kbrtBoT7MWLLUIuP7TZ3htQOPLVWFBTBZ+UKghdA0FRitoBixlUWJqfqpSKwwVs
         oJQ/qMcfVZgbrULsnztljOBZU6liqQdGRj+NbCMtQJmABc/uXwnPQwcI8boc14vQpTR9
         ZCm3CuLdREKuXR5WgCj/NrYEphF2fDtpZOGnlm42G09T84ytf3uWhUqmoiTlTLfuMqpA
         IdQ7F3mHSbjUy+yzX77uVe/4BkuAvgzlquliu+uKz1Nvy6dlabkeRgZSjZ0NQxiKJjqv
         3bj94Bm3zfFwgI5T6NnKJH86UaYxlAT5w4IVwUs5qZBxnvYm99gWVWjiA/vT+paWf9jl
         30lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vh444uXRAgRXgT6rgkMAr0JYfUHIeqhqHIUGvOQ7pc0=;
        b=awG4JT2826qfgUsGjJMY3/0wzMV2jFEMT0+RmG5cBp9BgqOJnE74QIRYrKRTV6cVod
         NmUzOo5nOQKBBZJqX4aCDQn6OOL4j91NaSvupUykbcPbM/fPMh6/ZzDMIBInQ7GjPQA6
         Qid3MHEIiOpCsNLXpz7omk9axsbh7JWROc/e27jQAE2OupsBOH8pZZRFGpK7rEWXOqss
         YlWXDmyygm17hvLuBASnfuJ3uHwtQzKDp53qsODQ2kDCxL86XER/lWT/HW87qL84KvOC
         9lg9taikRwuNxBYd3KlY9hQyd9MFdByYQR9OouU7wday6YO80vQAB4Z3loSE+yuQqOWZ
         T1ZQ==
X-Gm-Message-State: AGi0PuZn/Qzt9aQFiNxL/GbjopyNPN4q4fEs02IdFkTe1wAQ20JYcaQF
        mL5hEUbE1DOm6Qm9pHYaabk=
X-Google-Smtp-Source: APiQypJILD6MKPAye5JlbWy5uG3IwH9ogJIS9ceuBRa79erV4+lC5JGQL1Cqz9Df/SLLdF7ilxIMKw==
X-Received: by 2002:adf:cc89:: with SMTP id p9mr743414wrj.269.1588621877710;
        Mon, 04 May 2020 12:51:17 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f83sm696042wmf.42.2020.05.04.12.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:51:17 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] ARM: dts: meson: add the gadget mode properties to the USB0 controller
Date:   Mon,  4 May 2020 21:51:05 +0200
Message-Id: <20200504195105.2909711-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing with a USB RNDIS connection and iperf3 gives the following
results:
- From the host computer to the device at ~250Mbit/s
- From the device to the host computer at ~76Mbit/s

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 5d198309058a..ae89deaa8c9c 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -229,6 +229,9 @@ usb0: usb@c9040000 {
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&usb0_phy>;
 			phy-names = "usb2-phy";
+			g-rx-fifo-size = <512>;
+			g-np-tx-fifo-size = <500>;
+			g-tx-fifo-size = <256 192 128 128 128>;
 			dr_mode = "host";
 			status = "disabled";
 		};
-- 
2.26.2

