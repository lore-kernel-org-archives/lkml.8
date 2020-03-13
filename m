Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88568C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F80C20746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+VQkJt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgCMKhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:37:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42782 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgCMKhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:37:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id v11so11413596wrm.9;
        Fri, 13 Mar 2020 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k4BHlmlIIly19yAcT+U9SlSGDpikfNDuftvz1GG3NyI=;
        b=n+VQkJt4keLrX9Z1cmab2rKVIEKUzaRGvqgCHicwB+TzWWb5sc/zEKZvz0m2BFBtYY
         2VfKrgvos4hhjRRo0Lig266Xz4lUDFlz0+LWVKUa42psEC3f5hWh6veiR84uBFMKuSWL
         MKTsF0XdvTidRIbMHj1jEl5I+pK2xg7chztbVijEKZMNFzrJvT1KlcPd17Bq8QUtIYQ/
         3/ktCL+6KVRPqV18k3mAf5q+3wzF2sw8GuTnE9SMeZdrJpXsH5W/RtNXsGNBll9I0a6u
         ScfrJyaHFuO36hRHZeXmlB7kheCnmgP0rirvPSvk2hiuMkLJ3e3Wxxu4WQqno5EXcjsC
         pN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k4BHlmlIIly19yAcT+U9SlSGDpikfNDuftvz1GG3NyI=;
        b=Ol8rrHGK901ge8ULntvO3NoPkeaBVCsFImTELjZu5INcVxMrO+RwJ8uPVvKt9gYzSR
         cbPxZF+w8hSV7BLimDAm9vjpk7/fbEphVz4SKBSyTdhQtO8AENzmd8CmFmgz+Lt3zSjC
         Fx7hPG3Tm9zYqaUOEoLfVjoLhyVstmRoBXXudmt2s78Ys1SCSEvI9tYXsTjT7zTRM9VE
         +9t/nqjs275YT8BFJtScmSbWtPXy6KwnWS6EE5CqlkDgxnx3Zr3RjjE6mByXLK1E9uAC
         k/2y2mUtG+DDuN9WeZs5405G35fd1wA2cqe7Pkic7EhIah4SZ1zawLXW4eNcCaPhFKT7
         o4Bw==
X-Gm-Message-State: ANhLgQ1xcBVREOuF6D29Lf/klXbqhcryB9HE79a2JEtASxXDCrBp+mtx
        gkPvvbF4Bz2pywhLaDByWjVftaoD
X-Google-Smtp-Source: ADFU+vsCE/NjGMEqAImu3YZBGZWMwPRv2f7D0Xn0qVCk5kqumgbi15H0AYaphrhjWzVuCayVI52zQA==
X-Received: by 2002:adf:fc0d:: with SMTP id i13mr16858848wrr.364.1584095854238;
        Fri, 13 Mar 2020 03:37:34 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o3sm17688551wme.36.2020.03.13.03.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 03:37:33 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: rockchip: add missing @0 to memory nodenames
Date:   Fri, 13 Mar 2020 11:37:26 +0100
Message-Id: <20200313103726.1678-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200313103726.1678-1-jbx6244@gmail.com>
References: <20200313103726.1678-1-jbx6244@gmail.com>
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

