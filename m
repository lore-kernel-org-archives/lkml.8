Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7444C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 08:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBA82074D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 08:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmNnphxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgFNI7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 04:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgFNI7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 04:59:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D478C03E969;
        Sun, 14 Jun 2020 01:59:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j10so14039985wrw.8;
        Sun, 14 Jun 2020 01:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bfBfjc13i9oNkQ8+Zqf2QVGnWSdbHs2CT9bleKRk3vM=;
        b=VmNnphxe/tlqN9qdh0se5AF78dwcs2rEq07gVb2RhQNqK5JMsCM6MAiQW+kxHjYHlF
         vOZwdz+fItaEVUvu4d1s8W6fPczxu192jJ3I2I3tuLtq6SZc4unUS0RDbreUE3AyDhU9
         5YzSlLKYYy01fEmhLnQGVfG+wNl+seEaHVxcfuiXjbhxdEHUasPAdXaLUr4gF7zO3PrI
         6LjEI0ujoYMEWvCtXQu3aZ2TsUzbfQ+x2uIZR21Bm3UqTSQ99ZgNCOtZsY5La9ybr2Jo
         UDSDV3OQ1tZfC4w/1gS6wS0xfXWTWucPLkx6c6CGQ/AxoDGP7AwcfKwQieDzIZsVsgjJ
         /h2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bfBfjc13i9oNkQ8+Zqf2QVGnWSdbHs2CT9bleKRk3vM=;
        b=Kr4LWzB+TRO7UL1ShBKGbScKYnt4zOck1j5pNkib5EpxT+vbY3tKEqG9wGaC4C+HXE
         0qWAKXclzwGaOViieuGzCF26PhKYPBpKXyerBFXTiakYVi5b3o5jb1LVbE87uWpKQdRk
         wGS0nV4imuDxK5F0YcsHR86yVkNrhEgNRf+MF+dHtY5KtJ/Be5HZUzHqjdBryRQB+Lsm
         H38tkwHCOcYxLyw6eRgBdMmnbhUAXDyBF7+tKZ4XE8fEtbe2WrubIMPzfSnQgC3JxHOK
         gPk+e6Gr3emjd5+t16oxbvIjf4fewY+waKMdwSyN5Aj///Ef4ZFdcA/imZZmqCQnZTAb
         Km9g==
X-Gm-Message-State: AOAM530uVgKnktUI34stW4cuyjBM20bMURCNl7782TzzZy7CnFLk8xnN
        JkIKTWiyRyp6ONr08MSoVkejeJQFCdM=
X-Google-Smtp-Source: ABdhPJyrWu3tPQCvkEYvTz6K4aMJz2Ts6V/3m25HhZqYVJ+DpP33UqxhQWvnpiWcPJ5qBP9f8czSyg==
X-Received: by 2002:adf:f812:: with SMTP id s18mr22370339wrp.28.1592125143824;
        Sun, 14 Jun 2020 01:59:03 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id u4sm17174043wmb.48.2020.06.14.01.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 01:59:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        jonas.gorski@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Florian Fainelli <F.fainelli@gmail.com>
Subject: [PATCH v5 9/9] mips: bmips: add BCM6318 reset controller definitions
Date:   Sun, 14 Jun 2020 10:58:52 +0200
Message-Id: <20200614085852.2130147-10-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200614085852.2130147-1-noltari@gmail.com>
References: <20200613083813.2027186-1-noltari@gmail.com>
 <20200614085852.2130147-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM6318 SoCs have a reset controller for certain components.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Acked-by: Florian Fainelli <F.fainelli@gmail.com>
---
 v5: no changes.
 v4: no changes.
 v3: add new path with BCM6318 reset controller definitions.

 include/dt-bindings/reset/bcm6318-reset.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 include/dt-bindings/reset/bcm6318-reset.h

diff --git a/include/dt-bindings/reset/bcm6318-reset.h b/include/dt-bindings/reset/bcm6318-reset.h
new file mode 100644
index 000000000000..f4fef7bfb06d
--- /dev/null
+++ b/include/dt-bindings/reset/bcm6318-reset.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __DT_BINDINGS_RESET_BCM6318_H
+#define __DT_BINDINGS_RESET_BCM6318_H
+
+#define BCM6318_RST_SPI		0
+#define BCM6318_RST_EPHY	1
+#define BCM6318_RST_SAR		2
+#define BCM6318_RST_ENETSW	3
+#define BCM6318_RST_USBD	4
+#define BCM6318_RST_USBH	5
+#define BCM6318_RST_PCIE_CORE	6
+#define BCM6318_RST_PCIE	7
+#define BCM6318_RST_PCIE_EXT	8
+#define BCM6318_RST_PCIE_HARD	9
+#define BCM6318_RST_ADSL	10
+#define BCM6318_RST_PHYMIPS	11
+#define BCM6318_RST_HOSTMIPS	11
+
+#endif /* __DT_BINDINGS_RESET_BCM6318_H */
-- 
2.27.0

