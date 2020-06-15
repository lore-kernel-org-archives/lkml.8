Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C009C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 084B520663
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVuMZFhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgFOJDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbgFOJCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:02:37 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395CBC05BD43;
        Mon, 15 Jun 2020 02:02:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j10so16226077wrw.8;
        Mon, 15 Jun 2020 02:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lxtS6lu0f1MMLwKbznbg5Hfidh6dQZlR1AKoD5Erw7s=;
        b=kVuMZFhPf1eo0U8vCNXGm7zlLb8iILNdRoWQUK0PpgciaCkk9S4hRY2XGvR4TZrSS2
         cWdLycBE9fSWJCUlw3aTVh5DBCHjApSCmSKbfaQKPlOAtqTX0dhYjKZQ3g7+4uFcd7cd
         eKgnobWDv8jMxvqHxNFHRa5EkEcjewWAUg6astihL8ZN/2Rhv0fmSaxqeENuAW6a8K0K
         7MvjcLDgH3NH5K5xuG9+WGlV2hWOtaKpn2vBOz4r2Vu4LnGaOO0ga3WS+7koWc0EBsA2
         b10V6FBj9Ur2SjDaxjt5RKxVL3sqDmxWpMen65JYeZT4tOAkxKlOk8/SMjdaiqxKwzPJ
         FAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lxtS6lu0f1MMLwKbznbg5Hfidh6dQZlR1AKoD5Erw7s=;
        b=S/CSr1AX8MD6pS35x9gnwSLb4FqnxjrZj4AAEXP16GYsQb43+V5H0rEqJBmk84rjqi
         prR/9/VX9DcTX1yQ3Q8t+ICet6fQSM7e7HYzT1jRn2zsCEiN5qo8BnlgckV6CWK7M6be
         c1dIlwKiyvYPrgSf5lbT9qf0z2+4aVcRSr8gIGVkLuwqzyh9+txGLBObHy4tIMNYOUIL
         93/4VHOPqtSUNPnWBL6tPskHG6vx4o6zzdPtE09uUUogYurTLYf5LrBXMe3qOwA+M9Vi
         pqZJ5r5DVg1j7E8PjOUGd0GbIlmH78/bquWHbH1FjFjugFhajTpyCtHVQnDemLMf0TcB
         y05g==
X-Gm-Message-State: AOAM530RjtZpSHG73ozCi+rkB7yw/BCuMoAYgwX0YHBevGqweN+tqK+x
        ZOhEXwcN7GqEQI1ybepYzFo=
X-Google-Smtp-Source: ABdhPJwX/v0DIrobFoOX5TTFCQKPVL3VkIg/tzqckNaoCicn6Be0G8N7kP9EqH4u/fda7T9ws627Cg==
X-Received: by 2002:adf:82c9:: with SMTP id 67mr30210524wrc.149.1592211755931;
        Mon, 15 Jun 2020 02:02:35 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id o15sm24089516wrv.48.2020.06.15.02.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:02:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        julia.lawall@lip6.fr, jonas.gorski@gmail.com, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 1/8] mips: bmips: add BCM3368 clock definitions
Date:   Mon, 15 Jun 2020 11:02:24 +0200
Message-Id: <20200615090231.2932696-2-noltari@gmail.com>
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

Add header with BCM3368 definitions in order to be able to include it from
device tree files.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 include/dt-bindings/clock/bcm3368-clock.h | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 include/dt-bindings/clock/bcm3368-clock.h

diff --git a/include/dt-bindings/clock/bcm3368-clock.h b/include/dt-bindings/clock/bcm3368-clock.h
new file mode 100644
index 000000000000..74a7382f77b8
--- /dev/null
+++ b/include/dt-bindings/clock/bcm3368-clock.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __DT_BINDINGS_CLOCK_BCM3368_H
+#define __DT_BINDINGS_CLOCK_BCM3368_H
+
+#define BCM3368_CLK_MAC 	3
+#define BCM3368_CLK_TC         	5
+#define BCM3368_CLK_US_TOP	6
+#define BCM3368_CLK_DS_TOP	7
+#define BCM3368_CLK_ACM 	8
+#define BCM3368_CLK_SPI	        9
+#define BCM3368_CLK_USBS	10
+#define BCM3368_CLK_BMU         11
+#define BCM3368_CLK_PCM         12
+#define BCM3368_CLK_NTP         13
+#define BCM3368_CLK_ACP_B       14
+#define BCM3368_CLK_ACP_A       15
+#define BCM3368_CLK_EMUSB       17
+#define BCM3368_CLK_ENET0       18
+#define BCM3368_CLK_ENET1       19
+#define BCM3368_CLK_USBSU       20
+#define BCM3368_CLK_EPHY        21
+
+#endif /* __DT_BINDINGS_CLOCK_BCM3368_H */
-- 
2.27.0

