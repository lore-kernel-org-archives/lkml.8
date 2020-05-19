Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5386C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB07D207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPoL8108"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgESSYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgESSYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:24:07 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2010C08C5C0;
        Tue, 19 May 2020 11:24:07 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q8so292816pfu.5;
        Tue, 19 May 2020 11:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=95BuKgEJw4ZA0+/Faq3WqSrMTnT56+f41Pjs3Qp8lck=;
        b=UPoL8108fuk9BSQWsMoXUVD5XnOSO3GO3tQN9g/q5iVR4YIAw46Xq4MLAJZbiPR5iy
         TEZJ6Td1sWyonYxOy3IUrzWEoF6QS4vJZTx0hVpYJiFYfU16sz4SFe9WFyyUYrKktoyN
         eNqd6jH1fDgq4pXUS/XyUUoqQPg0CgCMNmkkzpfCMRShXz7SXIfRKlDVj8Meff1W1TTI
         MqaU6QYYHVvP/3KmS6QB08drOrK1WSi2EE/gEhoNh9NqB64DhJrNb1BSLuTvvcOx1ZCE
         bsgPtzLTstcxS1U7AEGaWs5i3AupBoqUFT9742NoQC0X+7ms/XoX1Maev4DlqcU4rH0i
         Dfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=95BuKgEJw4ZA0+/Faq3WqSrMTnT56+f41Pjs3Qp8lck=;
        b=P3VJ0yr0P2e925NohhgQwK4aXFpUf38sgqgmGmmlDPl//dLJTNYm3UfwwN5UhsTzou
         Dyr4PbHoZHQo3DD6hVIAqd5bRq6ceRUVRSmaNXgnxqJjHvI/MOr5UhAlHVYhuCCcqdO3
         PMU5S2ui7B7wDqTY3apu8FDvbbtqX2FXk0vuV1yuj7EVikaXr5TFArm+UsZniC7qFwZ4
         HUFOxHDm54WhAGKBtRHWAO271V6mbPBH9rYVlQ1d291nWvVkgqbnfhbqb0rEVOF04P7x
         UuNW2aqVZwH8FAr6Jh9u+cS1XU2T97OOhBRhRMtl7LJ/74uKiuNhc9N2kl7DCnPpTG6Y
         XwtA==
X-Gm-Message-State: AOAM533C0++CQYZUHaDvFf6a83G1o7qpBD5XByU9iBOpi90i8A7Ycwv8
        9xj7NKfKTWC2eZ9jDAsBtuM=
X-Google-Smtp-Source: ABdhPJzM2fqTcOSYJljXABT0LK1g1ksDEu0E6DJRryZf2ubaKWpNFpLv62aLy6j9uI4zAWaf7aW40g==
X-Received: by 2002:a05:6a00:d1:: with SMTP id e17mr359820pfj.85.1589912647293;
        Tue, 19 May 2020 11:24:07 -0700 (PDT)
Received: from localhost.localdomain ([223.235.145.232])
        by smtp.gmail.com with ESMTPSA id p2sm148399pgh.25.2020.05.19.11.23.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 11:24:06 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 09/10] arm64: dts: actions: Add MMC controller support for S700
Date:   Tue, 19 May 2020 23:49:27 +0530
Message-Id: <1589912368-480-10-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
References: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commits adds support for MMC controllers present on Actions S700 SoC,
there are 3 MMC controllers in this SoC which can be used for accessing
SD/EMMC/SDIO cards.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v1:
	* Added SoC specific compatibe string.
Changes since RFC:
        * No change.
---
 arch/arm64/boot/dts/actions/s700.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 56f2f84812cb..0d3ff315b00e 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -258,5 +258,38 @@
 			dma-requests = <44>;
 			clocks = <&cmu CLK_DMAC>;
 		};
+
+		mmc0: mmc@e0210000 {
+			compatible = "actions,s700-mmc", "actions,owl-mmc";
+			reg = <0x0 0xe0210000 0x0 0x4000>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD0>;
+			resets = <&cmu RESET_SD0>;
+			dmas = <&dma 2>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
+
+		mmc1: mmc@e0214000 {
+			compatible = "actions,s700-mmc", "actions,owl-mmc";
+			reg = <0x0 0xe0214000 0x0 0x4000>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD1>;
+			resets = <&cmu RESET_SD1>;
+			dmas = <&dma 3>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
+
+		mmc2: mmc@e0218000 {
+			compatible = "actions,s700-mmc", "actions,owl-mmc";
+			reg = <0x0 0xe0218000 0x0 0x4000>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD2>;
+			resets = <&cmu RESET_SD2>;
+			dmas = <&dma 4>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
 	};
 };
-- 
2.7.4

