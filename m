Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83784C2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5759D2063A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7iGAme+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgDERgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:36:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53610 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgDERgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:36:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id d77so12363417wmd.3;
        Sun, 05 Apr 2020 10:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5M1R3a7is4s7bwwepv3EX0pn0j+KLFdAxm++0b65K4A=;
        b=S7iGAme+T3NPEMI9AvbI2gNLYo7JoAAMnoYrBRZuD3OUceRM5JM7eoqCbSXL++jVqL
         KTqd4ymrixpLdkKy6zKlHF6gcZUTYrtane3bMrBiks3A44xKQMUyDbrcTERarUBXuM3W
         pjWYZPRkzZds+o1veMy+owZJGMdKXzkjsHYBvK5Q+klp9XL8pDRX/50EzWfAnchR1+CF
         bjYE8K/c872nsf2RzKZYdpt1pW38l1d+WtoNWfZfWzqeetqRFiN/g6Z7oXrmwjCXPX/o
         HIq/mc0xYJ3QPfk0esFckfg2G1DJxXT1c/Nd35dfVrexd142sqPnK7FXFfdeC2i45Vnx
         j1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5M1R3a7is4s7bwwepv3EX0pn0j+KLFdAxm++0b65K4A=;
        b=EtdzblDnldHKW2EAnptOKtGNxKMX7/tPPjUpqtmbxZskfvkfP/4+gPb56tmNjoI+PF
         xau7ys3pKzRcMjYhRjyr5ELwiXdUlfag4TfBbRu0Pr/See+CS5fpKN03CiG0Qd++dlmO
         vZDvtzk3nXbSdSSsw8CumldSEPgctFXus41jeOmETenYgmM83pjBdESECyz8iRo+0i3q
         B0dEEzbgEfPO+sElu2kpJg42JOl7I8vqwJuX9LyiDuVl5KDLRUCUIjhzMN87cDJOUpmY
         3+3SroPk/w7MOgLoj03Pg4Tjv+Te7S70bR8oSzi5VB0mqEXAC/johqb3TplYOxJEml7R
         k91w==
X-Gm-Message-State: AGi0Pub8zdONam9OjAWUuwP9A1L0ICYtT8pFICE+qLYfgGS8rl1K6irF
        2Tmn1V2kAzJ8xp12U2ptw1k=
X-Google-Smtp-Source: APiQypICLzZwmhla0XhGF8QMFIN6xjgNZ5W4a7wriO/UdPeeYjgTuyOeDIDFhxt5UHnt2aMPJ3/FWA==
X-Received: by 2002:a05:600c:3d1:: with SMTP id z17mr18985049wmd.56.1586108169523;
        Sun, 05 Apr 2020 10:36:09 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id s13sm6031669wrw.20.2020.04.05.10.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 10:36:08 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 4/7] arm64: dts: allwinner: h6: Add GPU Operating Performance Points table
Date:   Sun,  5 Apr 2020 19:35:58 +0200
Message-Id: <20200405173601.24331-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200405173601.24331-1-peron.clem@gmail.com>
References: <20200405173601.24331-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an Operating Performance Points table for the GPU to
enable Dynamic Voltage & Frequency Scaling on the H6.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
new file mode 100644
index 000000000000..4a1814844fe0
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2020 Clément Péron <peron.clem@gmail.com>
+
+/ {
+	gpu_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+
+		opp@756000000 {
+			opp-hz = /bits/ 64 <756000000>;
+			opp-microvolt = <1040000>;
+		};
+		opp@624000000 {
+			opp-hz = /bits/ 64 <624000000>;
+			opp-microvolt = <950000>;
+		};
+		opp@576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-microvolt = <930000>;
+		};
+		opp@540000000 {
+			opp-hz = /bits/ 64 <540000000>;
+			opp-microvolt = <910000>;
+		};
+		opp@504000000 {
+			opp-hz = /bits/ 64 <504000000>;
+			opp-microvolt = <890000>;
+		};
+		opp@456000000 {
+			opp-hz = /bits/ 64 <456000000>;
+			opp-microvolt = <870000>;
+		};
+		opp@432000000 {
+			opp-hz = /bits/ 64 <432000000>;
+			opp-microvolt = <860000>;
+		};
+		opp@420000000 {
+			opp-hz = /bits/ 64 <420000000>;
+			opp-microvolt = <850000>;
+		};
+		opp@408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <840000>;
+		};
+		opp@384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-microvolt = <830000>;
+		};
+		opp@360000000 {
+			opp-hz = /bits/ 64 <360000000>;
+			opp-microvolt = <820000>;
+		};
+		opp@336000000 {
+			opp-hz = /bits/ 64 <336000000>;
+			opp-microvolt = <810000>;
+		};
+		opp@312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-microvolt = <810000>;
+		};
+		opp@264000000 {
+			opp-hz = /bits/ 64 <264000000>;
+			opp-microvolt = <810000>;
+		};
+		opp@216000000 {
+			opp-hz = /bits/ 64 <216000000>;
+			opp-microvolt = <810000>;
+		};
+	};
+};
+
+&gpu {
+	operating-points-v2 = <&gpu_opp_table>;
+	#cooling-cells = <2>;
+};
-- 
2.20.1

