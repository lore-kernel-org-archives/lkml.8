Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF29C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4806D20836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8mE+37c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgBXRcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:32:54 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46681 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgBXRcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:32:45 -0500
Received: by mail-lj1-f194.google.com with SMTP id x14so11001775ljd.13;
        Mon, 24 Feb 2020 09:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+9syUnzBYLf5yHfdlePRF5uRaJfhkTqyzyBJCLAmQAg=;
        b=k8mE+37cYEUjGZjgYEHiiqPPAYY9L5zoI4R4BGjWM/a8exAQ5Nb48lR2ec8GEO9e1N
         vngQh+bHp9hMS7S2m5MvAdxWnMuaq9nXE8kgJh1Cmkq2ry3m9GvxkDwkGwIB9MSd0ymV
         lcYt2rbgZxu9vl7m5u6Yn3IUwlrajZ5jdSLMlkebHh0BnWiOOlBa3zviOlksWvLNMrR3
         Pjt3OFvBM0nv9GZk8DnNrVwaq74GY3pKd3Iaij0lyatHXy4WZsJTKDVTZBaeVxoPEyXq
         fBWV+opgChkKQlLzWZyWlYwQF7zHSqkiEA2GAE4w/UUJKWKXSo/reF5fEimS1jAA3cwN
         ggww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+9syUnzBYLf5yHfdlePRF5uRaJfhkTqyzyBJCLAmQAg=;
        b=EYS+0UZp2GpCnKwjUmspembOCsNA6NzPGy6r8NGahwdnQ5ruUikvlk74cj1+m0Lp0o
         re2ftPeLgG7w/pzpPWR1c9Uua0BMYDE8UnGBBkSWZjufgL53rg1y9n7OBZxLkwXKC7DW
         95NdOFvrBJQl/ouMnq0opuK8DLVcjjgnWzpaVmjj1SX6F58ZuSTFu3khaDNZ+Y73xN1H
         zefB2NuT+SJ2vfdZyUloccpRWCJVICqT/8BG9gU1HOXA0Mlmc2UU7VG7wE3Vt/079UZ0
         ysq8UQnMNCO21TaZ7bTgZv+LkBnNg9phDFtMQI0e2RfBRXC246gaA9h9l/JZSP+PKkc0
         UBfA==
X-Gm-Message-State: APjAAAWsUH19AuGgWAnt6l3A+hxaydwRxc6555GOMkFxrfZHZymMhV+z
        2s/SalSrFUOLIVyTJ/ZvwvU=
X-Google-Smtp-Source: APXvYqxrW1aIBeGVgKZDhxcgU3BiWTUxtgTHgbIyhU3q2w/N+J94P2PC652dyrc66y0d7mJYZY5rIQ==
X-Received: by 2002:a2e:8745:: with SMTP id q5mr31505913ljj.208.1582565563351;
        Mon, 24 Feb 2020 09:32:43 -0800 (PST)
Received: from localhost ([194.44.101.147])
        by smtp.gmail.com with ESMTPSA id o20sm4311993lfg.45.2020.02.24.09.32.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 09:32:42 -0800 (PST)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     philippe.schenker@toradex.com, marcel.ziswiler@toradex.com,
        stefan.agner@toradex.com, max.krummenacher@toradex.com,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] arm: dts: vf: toradex: re-license GPL-2.0+ to GPL-2.0
Date:   Mon, 24 Feb 2020 19:32:27 +0200
Message-Id: <1582565548-20627-4-git-send-email-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582565548-20627-1-git-send-email-igor.opaniuk@gmail.com>
References: <1582565548-20627-1-git-send-email-igor.opaniuk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Opaniuk <igor.opaniuk@toradex.com>

Specify explicitly that GPL-2.0 license can be used and not
GPL-2.0+ (which also includes next less permissive versions of GPL)
in Toradex i.MX7-based SoM device trees.

Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 2 +-
 arch/arm/boot/dts/imx7-colibri.dtsi         | 2 +-
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts | 2 +-
 arch/arm/boot/dts/imx7d-colibri.dtsi        | 2 +-
 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts | 2 +-
 arch/arm/boot/dts/imx7s-colibri.dtsi        | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 0ec2b81..22ce5c2 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Copyright 2016-2020 Toradex AG
  */
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 70fc3a6..85ccf1b 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Copyright 2016-2020  Toradex AG
  */
diff --git a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
index 8ae4c58..b830383 100644
--- a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Copyright 2016-2020 Toradex AG
  */
diff --git a/arch/arm/boot/dts/imx7d-colibri.dtsi b/arch/arm/boot/dts/imx7d-colibri.dtsi
index 13331df..b56baa8 100644
--- a/arch/arm/boot/dts/imx7d-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Copyright 2016-2020 Toradex AG
  */
diff --git a/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts b/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
index 1d1b438..7cfb3ed 100644
--- a/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Copyright 2016-2020 Toradex AG
  */
diff --git a/arch/arm/boot/dts/imx7s-colibri.dtsi b/arch/arm/boot/dts/imx7s-colibri.dtsi
index 3b85b0b..df3646d 100644
--- a/arch/arm/boot/dts/imx7s-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7s-colibri.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Copyright 2016-2020 Toradex AG
  */
-- 
2.7.4

