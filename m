Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1CAC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6707206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRsG0bSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgCQKUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:20:10 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:47075 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgCQKUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:20:09 -0400
Received: by mail-lj1-f180.google.com with SMTP id d23so22084934ljg.13;
        Tue, 17 Mar 2020 03:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QfN9+apjqgrpyXVBAuhOdOy73M+EI8t13wRirUC/hq4=;
        b=CRsG0bSZgXP3imIAs+8w/8G8duiwcTZ6AFaxlOZU6lgbWcGnRCqO0xXJjgPQUdFhsi
         JqQFK5GYwSRle9CiC66EXEIeDcNbAj63aohv1a1vALQkm7PTW+6dxUvuGMnm8xPvwgJu
         5Va3eOWLSiNL4rO0ahN2PvGTJOEXlmYIQcIMhaS1ItThH14NcfrFgpvkainFSYKVy2Fl
         /z+U8kk4G/hhsi4qEvHCAfMne9DGjskZm2TGkW6YJjAt2sajqXSVS3cud/xOEgVoGI1a
         eJkhk3xy/uykwM1/NAxMzfVSZXGuxKFgRTDQJ5byoKdQEIsaF50qoAzD34XfxV6JPl+G
         +KEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QfN9+apjqgrpyXVBAuhOdOy73M+EI8t13wRirUC/hq4=;
        b=nX7v6oM7fbTInyW7TuKK9tF571rEF0MiWcEb/Fj0hMJs2KKZdTX3+VKaHHM+uXevBG
         Tfomd1NubSF/DHH8QPomopH7llSREriuJaM+Jb8EWz5X+8Rc9Nho7SB1cgsxjRPeDBYv
         g9P/9vn73Uyy4c9z2wigu1ZspVTO14ZDEmlT1+11JnkA3juZARh7/mPHNrJmOPigO6T0
         wIXuw5XrwXyn0wi5ou2O70HAPDJSKvNMQ5qXU9AT8WoaXBRHj1cfqaataagbRbtTh5nn
         pcfz1ELnEs7cGcY0iMiPZ75ZOh842if535WZ+UFmfHJO/mlNKHo1/elew8GiSqo9n2kH
         5l0Q==
X-Gm-Message-State: ANhLgQ3Kp+8sfzyN/Ja+x9wKAAgGyyR0CSKRNWttUlfusr5WfUH+BTYi
        12L+EZgxp4vbZXUV3tuWy4g=
X-Google-Smtp-Source: ADFU+vvANbRH8hQuVM/g7obFDWw4eF8AgZ4x7wC3XCx7JToxciEnTVjLbWKiSQxm6JEPVDxIDNQZ0g==
X-Received: by 2002:a2e:b892:: with SMTP id r18mr2404764ljp.252.1584440407694;
        Tue, 17 Mar 2020 03:20:07 -0700 (PDT)
Received: from localhost (host-176-37-176-139.la.net.ua. [176.37.176.139])
        by smtp.gmail.com with ESMTPSA id u10sm1974653ljj.88.2020.03.17.03.20.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 03:20:07 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/5] ARM: dts: imx6: Dual license adding MIT
Date:   Tue, 17 Mar 2020 12:19:43 +0200
Message-Id: <20200317101947.27250-1-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Opaniuk <igor.opaniuk@toradex.com>

Dual license files adding MIT license, which will permit to re-use
device trees in other non-GPL OSS projects.

Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---

 arch/arm/boot/dts/imx6dl-pinfunc.h | 2 +-
 arch/arm/boot/dts/imx6dl.dtsi      | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-pinfunc.h b/arch/arm/boot/dts/imx6dl-pinfunc.h
index 9d88d09f9bf6..960d300ea9ba 100644
--- a/arch/arm/boot/dts/imx6dl-pinfunc.h
+++ b/arch/arm/boot/dts/imx6dl-pinfunc.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
 /*
  * Copyright 2013 Freescale Semiconductor, Inc.
  */
diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 008312ee0c31..77e946b3d012 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 //
 // Copyright 2013 Freescale Semiconductor, Inc.
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index e6b4b8525f98..75d746952932 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
 //
 // Copyright 2011 Freescale Semiconductor, Inc.
 // Copyright 2011 Linaro Ltd.
-- 
2.17.1

