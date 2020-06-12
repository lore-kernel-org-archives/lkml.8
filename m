Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132D5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE27207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="bbWvobok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgFLNHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgFLNHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:07:19 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1EAC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:07:18 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t7so3733262plr.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 06:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z1wL/nTpoCfTcg366NsnGcxAQJ1eOVS2RuakcWo4bpQ=;
        b=bbWvobokn1hMGVtYjKXn8jL0a0LeCtMPDb1/be00BoCaEAZ9W9JD9qacJJFtGsl/Gd
         wUw1uPOr1miju7K8G5AWTsSAkKvNGpPiZ1SZrNiZzCJmRWHK97DhicFtvnPiFjZshXmx
         hi5trNaMbOZLaFoD3CLLZcM131hIwxj10onW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z1wL/nTpoCfTcg366NsnGcxAQJ1eOVS2RuakcWo4bpQ=;
        b=Nl1Tjt9iwfM2G8qAhx3BXp2xNGHrJag4oXyV8gTpkn3QQFoR7CV449NSWQ1xClf9St
         AJ10KOkxzxzgYyZwqsYpPOotnOvL7pbCXzqUWmiQZr8V0hHpjkqTO2dbMMZNg+U+THrM
         JksK4aGTM+FT5OMoTBguNCZz3A1eiqoan1wKW9L9Qf48zsKrB87njgQiSTFzANcAW9YV
         xMpECIYG++/sPGtqAnd7XOTs6vAjfBCXpDWR8oUl4N0yHB4GhYj4NyiE1fl/ryWP5jfr
         3ejG7jMKVIx5fhSHjZ9z76AXNL5HvaJ83jbidmwjpiO4bdutQGaroiPXyJia3oU8dBTj
         w7EA==
X-Gm-Message-State: AOAM533k/4waDCBZwEauk1VscEwWsM8VSAGOgXT6OT0bKi+OXhDq0iq9
        lcdJuIPXTPWxWKw8NdHTMI7cpimBcB9VUQ==
X-Google-Smtp-Source: ABdhPJztVlOEvC0EqrVons+BbjARSXkv+88YEx+nBZ1tLtU1TyUeHyNXKIoIxoaYXc/0nKINXqE1Yw==
X-Received: by 2002:a17:902:82ca:: with SMTP id u10mr11312443plz.294.1591967237499;
        Fri, 12 Jun 2020 06:07:17 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id k12sm5481939pgm.11.2020.06.12.06.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 06:07:16 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-kernel@vger.kernel.org
Cc:     daniel@0x0f.com, afaerber@suse.de, devicetree@vger.kernel.org,
        Daniel Palmer <daniel@thingy.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Will Deacon <will@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Christian Lamparter <chunkeey@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 10/12] ARM: mstar: Add mercury5 series dtsis
Date:   Fri, 12 Jun 2020 22:00:10 +0900
Message-Id: <20200612130032.3905240-11-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200612130032.3905240-1-daniel@0x0f.com>
References: <20200610090421.3428945-1-daniel@0x0f.com>
 <20200612130032.3905240-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a family level dtsi for the mercury5 and then a
chip level dtsi for the ssc8336n chip.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 MAINTAINERS                              |  1 +
 arch/arm/boot/dts/mercury5-ssc8336n.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/mercury5.dtsi          |  7 +++++++
 3 files changed, 22 insertions(+)
 create mode 100644 arch/arm/boot/dts/mercury5-ssc8336n.dtsi
 create mode 100644 arch/arm/boot/dts/mercury5.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index 7673acf55172..246951ab0888 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2117,6 +2117,7 @@ S:	Maintained
 W:	http://linux-chenxing.org/
 F:	Documentation/devicetree/bindings/arm/mstar.yaml
 F:	arch/arm/boot/dts/infinity*.dtsi
+F:	arch/arm/boot/dts/mercury*.dtsi
 F:	arch/arm/boot/dts/mstar-v7.dtsi
 F:	arch/arm/mach-mstar/
 
diff --git a/arch/arm/boot/dts/mercury5-ssc8336n.dtsi b/arch/arm/boot/dts/mercury5-ssc8336n.dtsi
new file mode 100644
index 000000000000..7d4a4630c25c
--- /dev/null
+++ b/arch/arm/boot/dts/mercury5-ssc8336n.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include "mercury5.dtsi"
+
+/ {
+	memory@20000000 {
+		device_type = "memory";
+		reg = <0x20000000 0x4000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/mercury5.dtsi b/arch/arm/boot/dts/mercury5.dtsi
new file mode 100644
index 000000000000..f68e6d59c328
--- /dev/null
+++ b/arch/arm/boot/dts/mercury5.dtsi
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include "mstar-v7.dtsi"
-- 
2.27.0.rc0

