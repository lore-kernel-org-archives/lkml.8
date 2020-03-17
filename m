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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D6DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CBC206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFZQuTgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCQKUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:20:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37474 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgCQKUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:20:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id r24so22171847ljd.4;
        Tue, 17 Mar 2020 03:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TGItJuz5W+h2gk6C+B6NIbPkvJZ2cZOlOG/P+lQP9D0=;
        b=JFZQuTgf0ix5GURciyxJzWH0sf14opuwqmkI7yvs/F5Adnfkifh53/Erfv3MQTmy9/
         9GQY7KikuoGDq/yCVcBDkdMFy3/kh7ZhPUiHw2lGonWtoSOaIFA2KhsqhfzSlN2rPWfG
         IlXWiOriBmkqXsDsZNrFxijHgX2FRmzOEdxtc1ijrDL2F2M2s4ulfcWlt2AN0AC3diI1
         s5rjK2JxOg8XUC9PJybzYaqxvBKFukvPzQH/pjfB1j83zku/E8mskdc33c8vCKAr4aW3
         inpShlE9qeQPQIWCfAZmUMCh8N/1dztWnZmGKEvsohgeY2GjsUB/kdzujVEVzcqlx22+
         fqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TGItJuz5W+h2gk6C+B6NIbPkvJZ2cZOlOG/P+lQP9D0=;
        b=pRlI8iDs6zOLA37RwfCzEUFVOvcgD1In9nz7Rf3fQtQZjO4/Q5Kr8PYk8TzE6ww234
         ZJaQA+8hSShRH4Ejb3qaGLDpaJX58OcnCeQQgMRkrL9wilG/LBMcEHkfzVt+Ck62HkcS
         GQbnMAel5TS+9lVZ8Be/d99i7n2j+7oaUgk5P8dyVN5kkfyxLSNxyiHa3e1keka8KN28
         xfjpC7yKhDcmnPvAPM6vcYfDkGaAivzJknt++Q8ShPjZ6l4t8QP9bAZeaUfm6nAc3t48
         aze5etRThvTCa3MDfxkhf5aEaIIrKC6grNazHakYg8tnHekL9PvNfbAVqWwRkeYZx5Su
         fTvg==
X-Gm-Message-State: ANhLgQ25ArdZoLW8dgd1snQ7Gdt7PE8fOIiMoDC6ixSEdqmaDQ4HtWTF
        G9iDw8uDT26sPSRGJhNuMYk=
X-Google-Smtp-Source: ADFU+vslGfTWII4zYbs4+SWZVmzcm1asQXYP0xCVtUNvJ3fqgQvjprHgGlIsriWG0xbiU7Nx1gBO4A==
X-Received: by 2002:a05:651c:1058:: with SMTP id x24mr2423894ljm.248.1584440410561;
        Tue, 17 Mar 2020 03:20:10 -0700 (PDT)
Received: from localhost (host-176-37-176-139.la.net.ua. [176.37.176.139])
        by smtp.gmail.com with ESMTPSA id m18sm1956945ljj.52.2020.03.17.03.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 03:20:10 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 3/5] dt-bindings: gpio: Dual license file adding MIT
Date:   Tue, 17 Mar 2020 12:19:45 +0200
Message-Id: <20200317101947.27250-3-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200317101947.27250-1-igor.opaniuk@gmail.com>
References: <20200317101947.27250-1-igor.opaniuk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Igor Opaniuk <igor.opaniuk@toradex.com>

Dual license files adding MIT license, which will permit to re-use
bindings and dependent device tree sources in other non-GPL OSS projects.

Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---

 include/dt-bindings/gpio/gpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/gpio/gpio.h b/include/dt-bindings/gpio/gpio.h
index c029467e828b..01c528708208 100644
--- a/include/dt-bindings/gpio/gpio.h
+++ b/include/dt-bindings/gpio/gpio.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
  * This header provides constants for most GPIO bindings.
  *
-- 
2.17.1

