Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3A6C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AF420749
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGBliQoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgCMKhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:37:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52362 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgCMKhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:37:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id 11so9336366wmo.2;
        Fri, 13 Mar 2020 03:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rQjq8uKoRrlLiAy2jC9SVIhkfPttmNZUWXbQLhDZM9k=;
        b=UGBliQojrFTzcrINN1hj7VaIxQhifS1a+pj8O7CpftaSMpdX/jXa/e2ShvDTKrPtDg
         /fRJICfUaCPHZHAL/PoJGQZLQbqzlIcyPGAvhNetLxmKmIuVbhuVT/3YC2+sLn6/l/lz
         YcEuUOumTYQtWC8aSHnVQVQmxI50A+8b/Z1vom5CTboDz/Mr5ZUAmZNTd8D4XkhhACEO
         2qdHlYmOrqcec5DzyzF0TDDIPkPkJowmXOs3vydQavbqCyfGBQgcpKRnRAiVbOG50JRJ
         4VXELyeSJOTeO7IQmWQtFWAg96CAYdDzO7cj57V0b5pfjxV5jJWQRlXM66ff9YFUmnVx
         dDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rQjq8uKoRrlLiAy2jC9SVIhkfPttmNZUWXbQLhDZM9k=;
        b=n27B3IQO7RURQVW+annWOAR+hjkzkq4sHop+7Hac/sy/hZT+wzosTBvnPB2DZyZHaM
         9RSLSHWQ0g+zZEiClrVH639hI5xmaFbE8gcsMXGVa50MNI9SB3kkdf3A+zKIOg4S7HhH
         6s9fm4486gLcoBjTh1MiDPnuNBhFJgLNmxx695efZt2Aj/hWV7MkFZkpD+YvJ09t7Uxj
         hg2OwKAL5b7Ld/UJxT6K8PxmtcHo10Abo2wRcy3+m808b+PafH5hrIRyLxWdIlnGa4ut
         XOKmLlEzR1xQs78Ekk6njsmigwe0x/t5Z1scImYtgy2Sprr4TmMrEf1dHQeenquu0rfj
         Vuug==
X-Gm-Message-State: ANhLgQ3MNUVX19FxLbxKjaFyXSHEEmTYA9Tm73NfqyceM1X6rhfq3PV2
        UQCrPI3/zuG+JxSWYgYRDlvDOiL6
X-Google-Smtp-Source: ADFU+vsvWMWzKMxNqeNsKtP8NvCy424vINQYoxocmtCUEXMyobJjwyOn9tG53zX72IKMsG6O9hK2aw==
X-Received: by 2002:a1c:2048:: with SMTP id g69mr10462496wmg.187.1584095853079;
        Fri, 13 Mar 2020 03:37:33 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o3sm17688551wme.36.2020.03.13.03.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 03:37:32 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: dts: rockchip: add missing @0 to memory nodenames
Date:   Fri, 13 Mar 2020 11:37:25 +0100
Message-Id: <20200313103726.1678-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm/boot/dts/rk3288-tinker.dt.yaml: /: memory:
False schema does not allow
{'device_type': ['memory'], 'reg': [[0, 0, 0, 2147483648]]}

The memory nodes all have a reg property that requires '@' in
the nodename. Fix this error by adding the missing '@0' to
the involved memory nodenames.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/
schemas/root-node.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changes v2:
  Skip rk3288-veyron
---
 arch/arm/boot/dts/rk3288-phycore-som.dtsi | 2 +-
 arch/arm/boot/dts/rk3288-tinker.dtsi      | 2 +-
 arch/arm/boot/dts/rk3288-vyasa.dts        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-phycore-som.dtsi b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
index 77a47b9b7..9e76166c3 100644
--- a/arch/arm/boot/dts/rk3288-phycore-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
@@ -16,7 +16,7 @@
 	 * Set the minimum memory size here and
 	 * let the bootloader set the real size.
 	 */
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x8000000>;
 	};
diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
index 312582c1b..77ae303b0 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -12,7 +12,7 @@
 		stdout-path = "serial2:115200n8";
 	};
 
-	memory {
+	memory@0 {
 		reg = <0x0 0x0 0x0 0x80000000>;
 		device_type = "memory";
 	};
diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index ba06e9f97..889b95e95 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -14,7 +14,7 @@
 		stdout-path = &uart2;
 	};
 
-	memory {
+	memory@0 {
 		reg = <0x0 0x0 0x0 0x80000000>;
 		device_type = "memory";
 	};
-- 
2.11.0

