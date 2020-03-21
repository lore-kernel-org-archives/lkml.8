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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DADCC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 21:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F94206F9
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 21:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+Ny8yQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgCUVym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 17:54:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34820 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgCUVyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 17:54:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so11939881wru.2;
        Sat, 21 Mar 2020 14:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yDruFVRHrSK5ODyzVMCRmTY0CPw77IJrtm55iVL4ls4=;
        b=G+Ny8yQIOG79RvLyCWGo3N2mrPHkrZ9M5A1g2Au0NO6RFN4ptQofj4Mkgf1YnTMN8z
         vvGFHT5+X7Jw7LTXVTr0O9jUE22wtXMADFetR2VO9M+Wn33ED7i3F6h7NX1qpzl+EEGL
         jII4jAFp0ngp6w+7X9/wcv+2jbi2/T3FxOdfIMhXkcQtbBG6FoxfB9t9rdX28Fi1WPq+
         Qsa/MaPBd5uWfMGcMVA/4+e5H0GZveBJ6Mq84RcjVOh0soZtDwuAcw2mwss8TKMNadJN
         3WaWwa6qJi3KDebK1190XVuNe7u8/G5pV8XoYtWqBkTVbegKvih/AaE7Jw4vtBqpeq7l
         Yq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yDruFVRHrSK5ODyzVMCRmTY0CPw77IJrtm55iVL4ls4=;
        b=ST0N+b9L7P0roOIfk0D2RCjqxBmq68nW5ikjbWtX89m4/K6vE/+En1ejQxIFxqPL/u
         xcyFdrRwEx5vxyB5cBiKmbDp+YzCbiqgmmQBTGpVi+/mBYns2LEfrENsclP55pfcnLK/
         ZNyPx8lzC6yRH0CZ2ioMAvekx7QwQklmTFROFD6wh/DNirtBlLBloFZquKhC69ffy8O2
         AjsJXMC2sDfHjd2Gdb1YPSVOPacmsHibqfD/OlvNbjLzwrWk1hDzwbxxcqhG+AosAMCW
         7tJfZ/qewvW/xdnVmMdtqgwSJNiudtbXd7lbAWJrnwqwNSDgIOJSO9iYYLlDu9YjkKGt
         3u7g==
X-Gm-Message-State: ANhLgQ0f6G6P68b1tzkcbshg/HTq5O6WfBvSjEwsThZ8JY5jLOATYpcN
        FpPcMSklH3p70cTt+FcqweA=
X-Google-Smtp-Source: ADFU+vvfecVP4/2cTL1Qur4iAjfBJDvtPVohFp7zMiubwjXigr+XQIYueXlTgQ5kqnzW7sC5BvDI8A==
X-Received: by 2002:adf:8182:: with SMTP id 2mr18848820wra.37.1584827675862;
        Sat, 21 Mar 2020 14:54:35 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id l83sm14113796wmf.43.2020.03.21.14.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 14:54:35 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robin.murphy@arm.com, aballier@gentoo.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] arm64: dts: rockchip: fix &pinctrl phy sub nodename for rk3399-orangepi
Date:   Sat, 21 Mar 2020 22:54:23 +0100
Message-Id: <20200321215423.12176-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200321215423.12176-1-jbx6244@gmail.com>
References: <20200321215423.12176-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below this error:

arch/arm64/boot/dts/rockchip/rk3399-orangepi.dt.yaml: phy:
'#phy-cells' is a required property

'phy' is a reserved nodename and should not be used for pinctrl,
so change it to 'gmac'.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
phy/phy-provider.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
index afbcd213c..6163ae806 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
@@ -554,7 +554,7 @@
 		};
 	};
 
-	phy {
+	gmac {
 		phy_intb: phy-intb {
 			rockchip,pins = <3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
-- 
2.11.0

