Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4176C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0AC62065F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwEo+CvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgFOJCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgFOJCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:02:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA0EC05BD43;
        Mon, 15 Jun 2020 02:02:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l26so13803585wme.3;
        Mon, 15 Jun 2020 02:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sul9vJFiyBV6DzJkPSxg+U7YDJ0hSsaO8TNndWGgTaU=;
        b=fwEo+CvAjK6dvRzrJaQwX3nBJrIXw6jfji3vKpMwpjImSNh/1xQbkGUQ998M537hqe
         oZHiRBCq14RF7yT+q5jDRvZSnNWzMa+jLR83t+KoCybLAWB54oCpMruph3oh1cTfDe9Z
         o4oAVhwJpHUrrJ0SUgoF8PfsOsSn1QCMpT13EyEr1EeLF/FtfelhHrDjfMZE/8xUOUD+
         5cJ2FffMDPu8vMr5NItLffknE7Rvr6UBh+dTX/mtOXzs6E5RwgGyXhii414XVpyZTndM
         vf/3mz+rssH16wNCj13S2HFecN2w7E2kpeNiKLzllmDifJSOZScRLaNqXH7Hc0acr1lt
         ynTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sul9vJFiyBV6DzJkPSxg+U7YDJ0hSsaO8TNndWGgTaU=;
        b=ivqZfq6JszwIrOhI7osshBtW+GVw747mBEfTF3vqCzUOsNhyMbwpcPKU3daG1cI3z+
         T7AOqXnQQSSmoVXMZL88iBuedOAmGQEXceYTXImArQHiecJEKEn3LOlOFYtPksCHiWF+
         DvTWcTybupCY7DP9JS7CjoF8Z5J7BnJfCjXn5uUNymS90LguLfg3hlwGlC2WG17vdGo4
         O2hbGJYIoAkB+x/f1dnZjcJW/Uzl8R3IvSbZJYja1w1pJhtXFKklucmMJz4MFFAwO63n
         QVuAkim3CAf0+AP5ySjpaLYFR6FbR5JSG7v0LNQj6Jj27wE4GBlqtkzmH/ETASYuYlyP
         RXYQ==
X-Gm-Message-State: AOAM533er0NCONTnW7Bkq5meTdqeZdoNRTvx+Qf2Z/NdAVB14JtktapI
        9eUeGMtxMdhSzhL36KVyt+8=
X-Google-Smtp-Source: ABdhPJyw/S8iFkx2eI1viZD4C2iESlJld5Z8fOnV0NaoxTum7ZFKlP+Ll4U7JVOLpjAwpR0GPjAv7A==
X-Received: by 2002:a05:600c:2945:: with SMTP id n5mr12937217wmd.189.1592211763201;
        Mon, 15 Jun 2020 02:02:43 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id o15sm24089516wrv.48.2020.06.15.02.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:02:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        julia.lawall@lip6.fr, jonas.gorski@gmail.com, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 7/8] mips: bmips: add BCM63268 clock definitions
Date:   Mon, 15 Jun 2020 11:02:30 +0200
Message-Id: <20200615090231.2932696-8-noltari@gmail.com>
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

Add header with BCM63268 definitions in order to be able to include it from
device tree files.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 include/dt-bindings/clock/bcm63268-clock.h | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 include/dt-bindings/clock/bcm63268-clock.h

diff --git a/include/dt-bindings/clock/bcm63268-clock.h b/include/dt-bindings/clock/bcm63268-clock.h
new file mode 100644
index 000000000000..da23e691d359
--- /dev/null
+++ b/include/dt-bindings/clock/bcm63268-clock.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __DT_BINDINGS_CLOCK_BCM63268_H
+#define __DT_BINDINGS_CLOCK_BCM63268_H
+
+#define BCM63268_CLK_DIS_GLESS	0
+#define BCM63268_CLK_VDSL_QPROC	1
+#define BCM63268_CLK_VDSL_AFE	2
+#define BCM63268_CLK_VDSL	3
+#define BCM63268_CLK_MIPS	4
+#define BCM63268_CLK_WLAN_OCP	5
+#define BCM63268_CLK_DECT	6
+#define BCM63268_CLK_FAP0	7
+#define BCM63268_CLK_FAP1	8
+#define BCM63268_CLK_SAR	9
+#define BCM63268_CLK_ROBOSW	10
+#define BCM63268_CLK_PCM	11
+#define BCM63268_CLK_USBD	12
+#define BCM63268_CLK_USBH	13
+#define BCM63268_CLK_IPSEC	14
+#define BCM63268_CLK_SPI	15
+#define BCM63268_CLK_HSSPI	16
+#define BCM63268_CLK_PCIE	17
+#define BCM63268_CLK_PHYMIPS	18
+#define BCM63268_CLK_GMAC	19
+#define BCM63268_CLK_NAND	20
+#define BCM63268_CLK_TBUS	27
+#define BCM63268_CLK_ROBOSW250	31
+
+#endif /* __DT_BINDINGS_CLOCK_BCM63268_H */
-- 
2.27.0

