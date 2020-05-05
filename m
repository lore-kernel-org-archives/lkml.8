Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F33C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53E4220721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ota0VHhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgEERCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 13:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728804AbgEERCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 13:02:38 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B85C061A0F;
        Tue,  5 May 2020 10:02:38 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x25so3111351wmc.0;
        Tue, 05 May 2020 10:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Fa9SRX5iGefguq9oBjY0ujY1kxsa+01Ny22B/LnyJg=;
        b=Ota0VHhLwimGfuqQXDT5Cm/ryqh3nix86NndMnb4/lv3yKDFdLDPzSIF3rL/1VCQ8J
         c5JfalcNar2PI5aHHHMY+BVkiHyCgS/qr2yRvC8BUxaoZs/Opr9bgDh2xFrJP+yHb42Z
         kdx2HPpLIBmypvHxR8iRBlw8v1gkOvij88nxQSDewwTherDFxQJ6j7OmpK3SH1fQw3HN
         JR95is0tt0sfsleV0tTGzH+7CKoFhWTSNDUvBySF3MBuNv/wH3VWrpoijovq8iblG4TK
         hz7RBOvoR9VUpVy+vH4y2KnH/cXOX8RqaAUT5ZRUfRHzKwXm5tjdXa2WsQZMSAloY40o
         Oudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Fa9SRX5iGefguq9oBjY0ujY1kxsa+01Ny22B/LnyJg=;
        b=YdFKyBzCQN0+/UT7zvIg6t2c1Ncz2jvPaFosUPdbRxf5eYkcV4rEtC9SxdodkTDabZ
         bICF5XX9LyR7ddaKhTiW3RFQBGmPOnXFciSmUkcTrKdnDWUmsb0Mhg3AFseJ2xbj5KVT
         Pk+379Sj5D7Lh9xBoFelYOkBE6Wtjif+gSIlnypJE6qRSrcdZGzyIKnoSgZeonawU+iG
         IOOdHhqlPs5+PWHHNmGRxptkqA3gihrhnPtVtYhlF/0SnXovAGNDPYnsJAeT9CgL/glS
         0k5LUtbNjjnILdMwLUi0ewYwE45bbmLYS4DE/rMPhehBPYEY6uy2IHiStND6tPLmAVv2
         HTtA==
X-Gm-Message-State: AGi0Pubm+Il/Fwg7lc+LMNRBm/b3JYC0t414HmzuZvyokkKOCWy7LeaC
        zfkrxpmSNZgiJmlFs0/3SgE=
X-Google-Smtp-Source: APiQypJAuuQIMcmMxXCSbON9abfTYyy02Wjgc8Q38il3f+5HzxAp3b1VaD3sXdGSeZIgUiwFGsXi7Q==
X-Received: by 2002:a7b:c456:: with SMTP id l22mr4204827wmi.148.1588698156757;
        Tue, 05 May 2020 10:02:36 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o6sm4397252wrw.63.2020.05.05.10.02.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 10:02:36 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: fix phy nodename for rk3328
Date:   Tue,  5 May 2020 19:02:27 +0200
Message-Id: <20200505170227.6503-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200321215423.12176-1-jbx6244@gmail.com>
References: <20200321215423.12176-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm64/boot/dts/rockchip/rk3328-evb.dt.yaml: phy@0:
'#phy-cells' is a required property

The phy nodename is normally used by a phy-handle.
This node is however compatible with
"ethernet-phy-id1234.d400", "ethernet-phy-ieee802.3-c22"
which is just been added to 'ethernet-phy.yaml'.
So change nodename to 'ethernet-phy' for which '#phy-cells'
is not a required property

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
phy/phy-provider.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changes v2:
  Reword commit message in the same way as in the patches for
  'rk3228-evb.dts' and 'rk3229-xms6.dts'
  that are already aproved.

  Patch 2-6 of version 1 unchanged.
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 931a9279e..fdf0e1b26 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -935,7 +935,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			phy: phy@0 {
+			phy: ethernet-phy@0 {
 				compatible = "ethernet-phy-id1234.d400", "ethernet-phy-ieee802.3-c22";
 				reg = <0>;
 				clocks = <&cru SCLK_MAC2PHY_OUT>;
-- 
2.11.0

