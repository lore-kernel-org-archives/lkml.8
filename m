Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8B1C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 21:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82790206F9
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 21:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ieaj58da"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgCUVyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 17:54:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47011 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgCUVyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 17:54:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id j17so8475106wru.13;
        Sat, 21 Mar 2020 14:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DpqLQNw+Y8418IGRjNUnbHR+oFWS/Jp+NdksTj8XtVM=;
        b=Ieaj58daFUjzApL99s/gSTwsOHAkxY28s8mVlRF88WpDa+sxVLHOlX54uBK0eR6+w6
         mGDr5YMrqluu+3tiAUUza6bRaumRKLvtuLxfkM0in/Uon3yjy1txb42JyegYqiDv1+NT
         zPfhyJmgAk9yS5CSlW6fF3UBKBRZRjeJFZRb4+hrGyrOjnvyG/DJq9CuHY2Icf/s1/9h
         /fezGHHS5vKAp9nWyOteswcCAoIxcSPrBiQytB/s4Y/m2F1xYdynH1KhM4NV415DHTKN
         UDlbpxjNFjvQrER3+YZ8Fd6mKzINmIvmZZTlVENAu2dmW5eyMYnUaK7qOLNQ/uwk+DZl
         un1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DpqLQNw+Y8418IGRjNUnbHR+oFWS/Jp+NdksTj8XtVM=;
        b=YSy3khPTesiD/hOlY65Q2FjzVXHNSCKo4fxg4KN8P7SQQLX4xhtJwtgSt+1amQzZ/e
         g7F1E0VbE9qHlDFfXN94AWTdI0l8o0bSHeygzwAiO73EymutWvxvp+REyHUPnIISgX3r
         GIMGIaGCoWpdw/D86I5MIekhajN2RgfDrvbVVjNDfBQa+U98yEGjvw6RoK03Vszn3Cd7
         gYPib/dI0ZHd/tbsYQ2zk17mkw/7Vo96OjZeBf3grCa2fiD9i9hzebBAgngGXphCLpLa
         D5NJPm4+/7gavWAufheq+Wy7wWpQCuDF7/oYORHwKbBI3b0lbFatXgDYy6tEVKEbrgGd
         C3oA==
X-Gm-Message-State: ANhLgQ1aiyjlC+7uYaKTCU8ymH6Se1dnf185/lYjnXTO9hYuFtceDFYH
        bpOG+DdNOAs6hEvxOu8IYZs=
X-Google-Smtp-Source: ADFU+vvRKpH8zZvngVS+BjZYxUICBZ/L0+SXI1hw0oMVZtCN4+mO/NHzqSU/EVpXrEVYGJT2aPtrVA==
X-Received: by 2002:adf:fc05:: with SMTP id i5mr19783133wrr.152.1584827671212;
        Sat, 21 Mar 2020 14:54:31 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id l83sm14113796wmf.43.2020.03.21.14.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 14:54:30 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robin.murphy@arm.com, aballier@gentoo.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] arm64: dts: rockchip: fix phy nodename for rk3328
Date:   Sat, 21 Mar 2020 22:54:18 +0100
Message-Id: <20200321215423.12176-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm64/boot/dts/rockchip/rk3328-evb.dt.yaml: phy@0:
'#phy-cells' is a required property

The phy nodename is used by a phy-handle.
The parent node is compatible with "snps,dwmac-mdio",
so change nodename to 'ethernet-phy', for which '#phy-cells'
is not a required property

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
phy/phy-provider.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 54b3f4616..8976c869f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -934,7 +934,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			phy: phy@0 {
+			phy: ethernet-phy@0 {
 				compatible = "ethernet-phy-id1234.d400", "ethernet-phy-ieee802.3-c22";
 				reg = <0>;
 				clocks = <&cru SCLK_MAC2PHY_OUT>;
-- 
2.11.0

