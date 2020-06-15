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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0D8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA6C2078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqXU/lM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgFOJDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgFOJCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:02:41 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3D0C061A0E;
        Mon, 15 Jun 2020 02:02:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j10so16226284wrw.8;
        Mon, 15 Jun 2020 02:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ues0PsnnVMTN2sbMwsEgElj1LE6JXXdWEnRPN/tZ0o8=;
        b=EqXU/lM0q9MIXJDBQ0s380kcW+nwN7WLe4/vY5JTK+vuhc0adCvlPshXYcSUe6mouY
         Tx1ke6mDRM8b13Ft5Ssn+oAoadmjL5tyV18TEIIR+LwRbAqkBO/7rRDKmSDj2X5JiK8Y
         6cqcJfNoYWswyhhwk/5fd8l31FJfO7J3g7rR7T3sfcxghvvpnbWJysrbwYWtB+XzfYaR
         1H8haYAtvNUxTzIpHd+gPDtr0qci0ohLJspZtqG7TQk60/l40cr71P1Ub8KeaORyFnL+
         WAMQhAQZsn/V7Cbd94D+Q4Bm/JtKi/8JBbvX+O4yC8DEtaDeg75HUPO1HjRF+Anthm0e
         QgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ues0PsnnVMTN2sbMwsEgElj1LE6JXXdWEnRPN/tZ0o8=;
        b=LWGYMPOhT09IkBIMiOap+77B7p4xmmi5oKoZY0+cOGE10oGoiVv0YPgQw9UIE4yIeu
         FreJi3IClAItgaBq68on+MK3GKDkb8k1D5larAGuEx3Gc940XDRQh77ulPoeIMD9XGo0
         EnPc8YDPbAZsT7ojBpFhGlUXlOOMMxUawl4rqk08E5ZLVjMA/QHJFf4l3Le/rYuOOYiG
         x5MmIu3JfZWvdIBgYe6BuLV04hzY91yB7EgZfmDgTqkHtsHLEys2eLIBfKrMFNPQOq2C
         /venu7m++Fj+Ln6NxC7azZ8dQzSvplCMrhDVMvWSRb9quTnBVML3R2VXGGdP2a14sDAL
         aaVg==
X-Gm-Message-State: AOAM5320LS675oUb9pWQmsUSCmEx6otnB/+9haTDSCAwfSGQrWp/qGY/
        BojsLiR2OSa1/EzdPNqppzw=
X-Google-Smtp-Source: ABdhPJyirIebTfKJActCxB0+Ojr4+xV+GSbhqF9ARgewihQbqIEyIQhSLHFoGV8d5Y2rDpjPg5sjpw==
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr29770003wrx.55.1592211759463;
        Mon, 15 Jun 2020 02:02:39 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id o15sm24089516wrv.48.2020.06.15.02.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:02:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        julia.lawall@lip6.fr, jonas.gorski@gmail.com, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 4/8] mips: bmips: add BCM6358 clock definitions
Date:   Mon, 15 Jun 2020 11:02:27 +0200
Message-Id: <20200615090231.2932696-5-noltari@gmail.com>
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

Add header with BCM6358 definitions in order to be able to include it from
device tree files.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 include/dt-bindings/clock/bcm6358-clock.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 include/dt-bindings/clock/bcm6358-clock.h

diff --git a/include/dt-bindings/clock/bcm6358-clock.h b/include/dt-bindings/clock/bcm6358-clock.h
new file mode 100644
index 000000000000..980c9cac4765
--- /dev/null
+++ b/include/dt-bindings/clock/bcm6358-clock.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __DT_BINDINGS_CLOCK_BCM6358_H
+#define __DT_BINDINGS_CLOCK_BCM6358_H
+
+#define BCM6358_CLK_ENET	4
+#define BCM6358_CLK_ADSLPHY	5
+#define BCM6358_CLK_PCM		8
+#define BCM6358_CLK_SPI		9
+#define BCM6358_CLK_USBS	10
+#define BCM6358_CLK_SAR		11
+#define BCM6358_CLK_EMUSB	17
+#define BCM6358_CLK_ENET0	18
+#define BCM6358_CLK_ENET1	19
+#define BCM6358_CLK_USBSU	20
+#define BCM6358_CLK_EPHY	21
+
+#endif /* __DT_BINDINGS_CLOCK_BCM6358_H */
-- 
2.27.0

