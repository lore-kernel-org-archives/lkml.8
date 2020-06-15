Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0E4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCCD92065F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9GLQDL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgFOJCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbgFOJCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:02:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17F7C061A0E;
        Mon, 15 Jun 2020 02:02:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f185so13982118wmf.3;
        Mon, 15 Jun 2020 02:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BfSpJilVz5MBdXnFVVixX+VqMK8O5L3P9Oe2sInGfUM=;
        b=V9GLQDL3wjU9TOCgzcvu6TCUM+VKlkblaqX4gJ7pP7t2m+Sm0nPsply5hEji1jR934
         NUhC7XMASudvtIebY8xfTrpCa2xpBRX5+t8rcc3RxWhQDIE2/rNLs4FgKmpcy3fWJNVn
         XVavyZVGbTQH90sZCreABuwre50CSDStxcvC+keG4gG6Nitc1X1MTxgVNaXU7FHBGly+
         Qh0PNOC9//LzzLdQKnZyRsyhdlOoUUwIwBRfCpEZcj/lWfJtL8mtYQ7HPQ8F8XOVuGI8
         W3NXoFKEYk0ei9O2l4cR9st7Cz6V6GCeLm3ALcwI7mfJc37BpYvNgSdbr6Yx82yo5BJI
         pxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BfSpJilVz5MBdXnFVVixX+VqMK8O5L3P9Oe2sInGfUM=;
        b=G3WtulWR/Ucko85boURHhDakZA8ZHP0IK1rwk+m5LE6+B2EB5baYvZTTKUjFb0w23g
         XTOeiOcNWcwODdQIW+ivoGuObbTwmPy4IabDYchfqaPtLyo8Noea5f0QeTMlrJkCXSDu
         0RPu+MZjcuwvkYNS6ZlAdGfNiMH1klAGzFGLLQKGnjERI0huSMlc+/a3pch1/MOANJdi
         mA1XcNw14dFQlPOAcbaaN/nHYECs9aJck2p+KLzeDgPBgSPHhqeTNMPb1itxAPmvHQ9E
         9zLyjYJ+03nGqXeCosI30Num0LkCpf6kjL5svrqVMhJ3qPaylw6P3C//uQYJ+P5lrygq
         JOsA==
X-Gm-Message-State: AOAM531SE5oMs0hro+Wse4+8BO2PS6NXMI5r1IsSf/E5dSZBRkfH5P3a
        /yLLGylZYtE6h1PYw4bi6i4=
X-Google-Smtp-Source: ABdhPJw+jc3rlKaMwpSlxfMFAU48Fr+Ju6bjKOG9sAgPzoyaLt5Rasi5J4H9aIUviEWunmnThUtH9Q==
X-Received: by 2002:a7b:cf06:: with SMTP id l6mr11958504wmg.63.1592211756856;
        Mon, 15 Jun 2020 02:02:36 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id o15sm24089516wrv.48.2020.06.15.02.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:02:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        julia.lawall@lip6.fr, jonas.gorski@gmail.com, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 2/8] mips: bmips: add BCM6318 clock definitions
Date:   Mon, 15 Jun 2020 11:02:25 +0200
Message-Id: <20200615090231.2932696-3-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615090231.2932696-1-noltari@gmail.com>
References: <20200615090231.2932696-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add header with BCM6318 definitions in order to be able to include it from
device tree files.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 include/dt-bindings/clock/bcm6318-clock.h | 42 +++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 include/dt-bindings/clock/bcm6318-clock.h

diff --git a/include/dt-bindings/clock/bcm6318-clock.h b/include/dt-bindings/clock/bcm6318-clock.h
new file mode 100644
index 000000000000..c4417f8983ab
--- /dev/null
+++ b/include/dt-bindings/clock/bcm6318-clock.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __DT_BINDINGS_CLOCK_BCM6318_H
+#define __DT_BINDINGS_CLOCK_BCM6318_H
+
+#define BCM6318_CLK_ADSL_ASB	0
+#define BCM6318_CLK_USB_ASB	1
+#define BCM6318_CLK_MIPS_ASB	2
+#define BCM6318_CLK_PCIE_ASB	3
+#define BCM6318_CLK_PHYMIPS_ASB	4
+#define BCM6318_CLK_ROBOSW_ASB	5
+#define BCM6318_CLK_SAR_ASB	6
+#define BCM6318_CLK_SDR_ASB	7
+#define BCM6318_CLK_SWREG_ASB	8
+#define BCM6318_CLK_PERIPH_ASB	9
+#define BCM6318_CLK_CPUBUS160	10
+#define BCM6318_CLK_ADSL	11
+#define BCM6318_CLK_SAR125	12
+#define BCM6318_CLK_MIPS	13
+#define BCM6318_CLK_PCIE	14
+#define BCM6318_CLK_ROBOSW250	16
+#define BCM6318_CLK_ROBOSW025	17
+#define BCM6318_CLK_SDR		19
+#define BCM6318_CLK_USBD	20
+#define BCM6318_CLK_HSSPI	25
+#define BCM6318_CLK_PCIE25	27
+#define BCM6318_CLK_PHYMIPS	28
+#define BCM6318_CLK_AFE		29
+#define BCM6318_CLK_QPROC	30
+
+#define BCM6318_UCLK_ADSL	0
+#define BCM6318_UCLK_ARB	1
+#define BCM6318_UCLK_MIPS	2
+#define BCM6318_UCLK_PCIE	3
+#define BCM6318_UCLK_PERIPH	4
+#define BCM6318_UCLK_PHYMIPS	5
+#define BCM6318_UCLK_ROBOSW	6
+#define BCM6318_UCLK_SAR	7
+#define BCM6318_UCLK_SDR	8
+#define BCM6318_UCLK_USB	9
+
+#endif /* __DT_BINDINGS_CLOCK_BCM6318_H */
-- 
2.27.0

