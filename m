Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE27C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3351E21739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0xQuwHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387650AbgCDHlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:41:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43005 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387608AbgCDHlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:41:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id z11so1053425wro.9;
        Tue, 03 Mar 2020 23:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k4BHlmlIIly19yAcT+U9SlSGDpikfNDuftvz1GG3NyI=;
        b=c0xQuwHhk9JwKgTYK6r9zATBdT8/BEfX5u82mAw7YYFnnoo0VBAj9bhPdH7MlkajWW
         QzplPQBg07XeOGjHE7OrdajnzhLRw/x7Sx6VI7jH6KwYfaUuvCef+JAEZst3u2yJkZgG
         GkuC2q2u40I7iCUs7VUqd377iljejFdIH9S/cG7j4doP+wuLme/rLqP1Cc+k0T7uMJLW
         Hda2TU2esakWqOSoozZqKsU/k910Z5ih19rB21r9YWePl+XtiPOeHY5e1iAo9W13m0g+
         yWN3355quPmPbSfixbpoy0fAVQ5+AwE5HolSEUeyKPnPXzKWvuXUskBofwyqL6gLimuM
         VaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k4BHlmlIIly19yAcT+U9SlSGDpikfNDuftvz1GG3NyI=;
        b=csDi5u1AvklGYQyaG/BvDc8X0Ty7BwTtdR58IY43T46iW8FluTxTKyHQezVaiey3L1
         b6bJNqY1lFMsyTcKiQYpCo0HenD4H6r4ZplkrwO1hluRxD2aAXPWvaqQ6A2IsMjto/k+
         ti/buvLUWHna662yFRo0he8qS6XNW/f6z4+NAr4qJCQA+weyxC55IgAcgYUmNZrsvrPM
         DlCrUSD7QMM1NZIpgpqablnDilIKGihGY3QjCAnrlLPBZT6H7kzZoanCabSdLlZFiM3z
         ujfJyFliyxwNfaciobBl0BFznMazPJAfWFgdCXEnjJn+1Cq7WaeRBZ/igyyCYRLvk6oU
         lYCA==
X-Gm-Message-State: ANhLgQ0I2jfcPjZt2yHQ5AZXrN8TqcPveIgmhhQtRuXG12xj5t2Fj22p
        NdFmixl9+Cd3ZtxaGNbvMs3cBhm4
X-Google-Smtp-Source: ADFU+vv8LNXPX7dYoNHaEhkEjhyz2UCIJBozg6Jxq3WaU7ecnwHbK3BvyAVbfXxhgix9tDYSyj/LMw==
X-Received: by 2002:a5d:4f85:: with SMTP id d5mr1735598wru.130.1583307662453;
        Tue, 03 Mar 2020 23:41:02 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id m16sm6410530wrs.67.2020.03.03.23.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 23:41:02 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: rockchip: add missing @0 to memory nodenames
Date:   Wed,  4 Mar 2020 08:40:51 +0100
Message-Id: <20200304074051.8742-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200304074051.8742-1-jbx6244@gmail.com>
References: <20200304074051.8742-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives these errors:

arch/arm64/boot/dts/rockchip/rk3368-evb-act8846.dt.yaml: /: memory:
False schema does not allow
{'reg': [[0, 0, 0, 1073741824]], 'device_type': ['memory']}
arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dt.yaml: /: memory:
False schema does not allow
{'reg': [[0, 0, 0, 2147483648]], 'device_type': ['memory']}
arch/arm64/boot/dts/rockchip/rk3368-r88.dt.yaml: /: memory:
False schema does not allow
{'reg': [[0, 0, 0, 1073741824]], 'device_type': ['memory']}

The memory nodes all have a reg property that requires '@' in
the nodename. Fix this error by adding the missing '@0' to
the involved memory nodenames.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/
schemas/root-node.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi           | 2 +-
 arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
index 1c52f47c4..b9e2e4bc0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
@@ -12,7 +12,7 @@
 		stdout-path = "serial2:115200n8";
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
index 6cc310255..9435008d5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
@@ -15,7 +15,7 @@
 		stdout-path = "serial2:115200n8";
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
index 006a1fb6a..cf11175ec 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
@@ -15,7 +15,7 @@
 		stdout-path = "serial2:115200n8";
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
-- 
2.11.0

