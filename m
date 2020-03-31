Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A7DC2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DBB208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcBI+VTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbgCaMOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:14:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41362 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730543AbgCaMOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 08:14:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9so25589576wrc.8;
        Tue, 31 Mar 2020 05:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o49PLtczjrvnDvwyYGD9D+ZfmKnK23dv8VxdMQjHLQo=;
        b=GcBI+VTxX4A3aVLmPkgITDWYoC2Han02vraisjcoDy6dieWJWqK7aSepeeBupCGFgQ
         ha+cEwrNujyV0gQQIpmvWoHL8bZxiS/HVBgNLhX4JuyVLXMBlp+8Om4/GZUPb1f1rgbZ
         d+5LVd54abHb4j9SRHvr/5Zhja9h0dbPkgmCgfHWA0lL/PB4XKfJFk0StUfIO886iYxG
         wfKrwaINP5VIYI2c3gC1GhqraRZJNiaRAz4hyRIn0foos/63M0K/2ZP1+2izbIoBNh6x
         8ZIWMZsFqGurcUbLTezggmynH/BiIPxgJDIlD/YT+KsKlPoMgh8dIX3B2gFvpntRZ2Ku
         9nCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o49PLtczjrvnDvwyYGD9D+ZfmKnK23dv8VxdMQjHLQo=;
        b=A+IqPBcJF9vDhF8psHp7vjPJ0XUAmWpbpGmoaP7lHXeAFu1WOARiJ0Vyfw0nfDvWAh
         IGGVjORxAyGZRUuiuoomG6lpCD55kEYaOOPFkl/o34RPI3+34TUOx8uClbIRTWUh3xaw
         HzsiZIuVDDREJHJUt4wrSFWsMU51fjOP4FHi9tCrZv7ku4jMGxo4e9r9znOE33jOMQN0
         flO2xPyK44/A1BF82lvC4y1dBFU/IlAzbe/f7NYVbm2n/PYEwtZGJqLyTnonqTGom9+Q
         wpypl8hjzHWrYsNztndAvhtEbf5O0GiUQIiiMzKUSo9XfqYlGKszQ4eeB7zOKAHxQJU6
         LVBw==
X-Gm-Message-State: ANhLgQ0Hd+5GpznHQ0LZW3LO/BBuEbUrGzwKu8+d+9q/Rkb5quwFDYgv
        gn4KqgYh02YyBBouTIeNzU4=
X-Google-Smtp-Source: ADFU+vuz27mAc1lNVPQfLWPm/LTORsy6muqNkMdbp2qKAPkgBcrIlks83Udd1Fa6w5TPOn0as3gJjg==
X-Received: by 2002:a5d:4cc4:: with SMTP id c4mr19884904wrt.346.1585656840655;
        Tue, 31 Mar 2020 05:14:00 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 127sm3754936wmd.38.2020.03.31.05.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2020 05:14:00 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 2/2] ARM: dts: rockchip: fix yaml warnings for rk3288-pmu-sram compatible nodes
Date:   Tue, 31 Mar 2020 14:13:52 +0200
Message-Id: <20200331121352.3825-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200331121352.3825-1-jbx6244@gmail.com>
References: <20200331121352.3825-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example these warnings:

arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: sram@ff720000:
'#address-cells' is a required property
arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: sram@ff720000:
'#size-cells' is a required property
arch/arm/boot/dts/rk3288-evb-act8846.dt.yaml: sram@ff720000:
'ranges' is a required property

Fix this error by adding '#address-cells', '#size-cells' and
'ranges' to the 'rockchip,rk3288-pmu-sram' compatible node
in rk3288.dtsi.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sram/sram.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Not tested with hardware.

Changed v2:
  Fix dtsi.
---
 arch/arm/boot/dts/rk3288.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 9c8741bb1..f102fec69 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -730,6 +730,9 @@
 	pmu_sram: sram@ff720000 {
 		compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";
 		reg = <0x0 0xff720000 0x0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x0 0xff720000 0x1000>;
 	};
 
 	pmu: power-management@ff730000 {
-- 
2.11.0

