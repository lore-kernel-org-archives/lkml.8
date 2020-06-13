Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A367C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 08:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B6F206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 08:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmrFdlgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgFMIil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 04:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgFMIi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 04:38:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A7CC08C5C6;
        Sat, 13 Jun 2020 01:38:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e1so12183901wrt.5;
        Sat, 13 Jun 2020 01:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=apYVJSQOoJKr8S1F9QvI20+pzas9FiQWtNSclf0VUoQ=;
        b=fmrFdlgyfSMnhLqDRle25xuMZlGWzMOlLlpmgdL2Tesm0amr/j/QqXDvakzHGN3/zg
         NxQbm3+ZzPS5IByW5CfYG2NmHXH98ol0bRwBuVuOTFJmGUTgFIye+Bdfb3Ingc5ELngC
         VnTFIPk5rIDofQyGzLzO+skndlmVLb6OGIH9wosd5fumwDxMCeFZm1l6qshPQ3MydTCE
         azeHtjXyTo77vPdA1r4OuFKreaw0P26ww4fzKXjDfDIndJhB6SRfec/YxvhviBIG8bQ5
         HQXFw88yz7wkKc1d3Fy+c08pO8Te0uDj3BoYrO5o6XuZv76+CLtPYK/QkwRkXor7yd0h
         3DcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=apYVJSQOoJKr8S1F9QvI20+pzas9FiQWtNSclf0VUoQ=;
        b=smnw4vgQchwSf9Gtx/vESqPRSMJ0DjaYu2j6Dd263IEIhVk7ALWeTyVglB6fEz6bNy
         Xp2OVB7pXXUai4yc0kloib8z5UafeI3f2yzcCz3+IUDO5XSYIGoPVjDFjMx3VV5GH7dF
         /Z8RUWLaYZAY2Q97Dr3cMbDTEr2OcLf/PtgRbBP6spUtT5yLS+h/MmtlzNITtZAhok2U
         UsLgLqoh8CRPp/grCKBt0tfK5yfRb7z7dG9DhPTMAnUOLXWWKY3Kut34Y0B0R5RuIESf
         VESQLRJq8yjaF/HgGGWZXrHtmm2CajRxiyLT/C/pIUTq9lLlNnFTPIMZzFhSDoxmn+zq
         lbcw==
X-Gm-Message-State: AOAM53084Ed1njUP0wg06sX4IcWN68Mhj6EXUU3+EaKxiYlqwOIvbf9+
        j7/ay2ri9CsRoQqJGopM5q4=
X-Google-Smtp-Source: ABdhPJzKFMTe9TbdDDotFUYRLGdmb4BqnL+vzwjnUVAEX0u5odeK+eW2Dm5Qc/m3kXhxlJFKsVUEXA==
X-Received: by 2002:adf:fd81:: with SMTP id d1mr19395675wrr.96.1592037504995;
        Sat, 13 Jun 2020 01:38:24 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id l17sm11622704wmi.3.2020.06.13.01.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 01:38:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        jonas.gorski@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v4 9/9] mips: bmips: add BCM6318 reset controller definitions
Date:   Sat, 13 Jun 2020 10:38:13 +0200
Message-Id: <20200613083813.2027186-10-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200613083813.2027186-1-noltari@gmail.com>
References: <20200610172859.466334-1-noltari@gmail.com>
 <20200613083813.2027186-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM6318 SoCs have a reset controller for certain components.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
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

