Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46740C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2328E206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1PNM85k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgD1O0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726900AbgD1O0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:26:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD13BC03C1AB;
        Tue, 28 Apr 2020 07:26:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b11so24872285wrs.6;
        Tue, 28 Apr 2020 07:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hG1iewHRLomP7TVu4ek95y5UWXfro8sk9H3gDbdYkFU=;
        b=e1PNM85kPudrtghx5esFXKTU72xQjtksJL6Cxf/4nXufhl1oWdxTsWEX/sQzVqwAfz
         zn/8/hXeVC9v2d6fGq/uuidWo5LQvWQGdxAcgErMR8deJaEflxX9NvSrXbiEExJZjUkU
         h52KUrhA4ZJe7aTj+nbDJtiTG3dq/A61TtI0Gram/0KFNcSQfSB5PksuUH1khvhpTdhw
         BDxZVMWdpipYzYcZOsaEmD7tR4qUi8LtkckQeORuB0taY1u5xHJtB1UAVN4xaRb4/2O6
         VjVkb0PgO+Ban1Q1ZGLh2xy424SxSGFn6UB9f1TrlsaOqfPFOh+PnnkSH3za2B8Xz/Uv
         dmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hG1iewHRLomP7TVu4ek95y5UWXfro8sk9H3gDbdYkFU=;
        b=G3bjHrJ/cH8B7op3G0NmHcDA09L94ZqS86DE1/t1wqv0p2H2IXMumB8Rw6OeRz56+F
         0ZAtvwx2fkZMSu53eLuOissDgPjc9URUXpUm0sf1tBSqMwMPziN1CHqorgJYOH8x+CSL
         nr+Rw6YmEvHT5jd6wn5P8whDBQr8O+FjVpdZ+uWOuS4rSET+rP141IzmJP2JULDrUzCs
         tIy0XpztoDFPQnv1AhtFvLdUcfPEnuRzQF/oJmmUlJlSNwW4k/3Xf0H+Ttvw2NQ2oph6
         y/P4Zo7lrDlSGZJUx2AUrakxuCy29groYo+eVvZYLbrWDXxXUd0D1GWO1nAO9NgD1yIc
         3kAA==
X-Gm-Message-State: AGi0PuZBmvi4kZ+Aeg6fAux8LhUZ9RNd6XmocoRmTGR0jIgiJXoW9ykf
        Kc8yLenM+r5WASMi6fOejy4=
X-Google-Smtp-Source: APiQypJ7gR281FtErynXrsmeODO1gY7gzdn3z5Z1gvMXwBRkdEPTT8anxYrfO/GsOajLTJDAcgNnfQ==
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr11519520wrq.342.1588083992303;
        Tue, 28 Apr 2020 07:26:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:9542:27c5:80f1:9810])
        by smtp.gmail.com with ESMTPSA id h6sm3367106wmf.31.2020.04.28.07.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 07:26:31 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Piotr Oniszczuk <warpme@o2.pl>
Subject: [PATCH v2] arm64: dts: allwinner: h6: Use dummy regulator for Tanix TX6
Date:   Tue, 28 Apr 2020 16:26:29 +0200
Message-Id: <20200428142629.8950-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tanix TX6 has a fixed regulator. As DVFS is instructed to change
voltage to meet OPP table, the DVFS is not working as expected.

Avoid to introduce a new dedicated OPP Table where voltage are
equals to the fixed regulator as it will only duplicate all the OPPs.
Instead remove the fixed regulator so the DVFS framework will create
dummy regulator and will have the same behavior.

Add some comments to explain this in the device-tree.

Reported-by: Piotr Oniszczuk <warpme@o2.pl>
Fixes: add1e27fb703 ("arm64: dts: allwinner: h6: Enable CPU opp tables for Tanix TX6")
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h6-tanix-tx6.dts | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index be81330db14f..3e96fcb317ea 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -48,7 +48,15 @@
 };
 
 &cpu0 {
-	cpu-supply = <&reg_vdd_cpu_gpu>;
+	/*
+	 * Don't specify the CPU regulator, as it's a fixed
+	 * regulator DVFS will not work as it is intructed
+	 * to reach a voltage which can't be reached.
+	 * Not specifying a regulator will create a dummy
+	 * regulator allowing all OPPs.
+	 *
+	 * cpu-supply = <&reg_vdd_cpu_gpu>;
+	 */
 };
 
 &de {
@@ -68,7 +76,13 @@
 };
 
 &gpu {
-	mali-supply = <&reg_vdd_cpu_gpu>;
+	/*
+	 * Don't specify the GPU regulator, see comment
+	 * above for the CPU supply.
+	 *
+	 * mali-supply = <&reg_vdd_cpu_gpu>;
+	 */
+
 	status = "okay";
 };
 
-- 
2.20.1

