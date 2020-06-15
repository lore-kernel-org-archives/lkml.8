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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7070C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B740D2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZLjJlVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgFOJCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgFOJCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:02:40 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31D8C05BD43;
        Mon, 15 Jun 2020 02:02:39 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t18so16244677wru.6;
        Mon, 15 Jun 2020 02:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tsCLU7c5unBxnRP02RziNczP1dVrvUnmrxRghsZ+ccw=;
        b=EZLjJlVCmxfSEswylJgYWWxJWN/c0WUNjxypMwr6MOH5yYlc0F50EuRw//PvkLLPJm
         qU2bERbRr2e4c4+xTZq6a6e4ED69uN6WQPoFBWFXSwuSd6KUu6YxZBDBCfm3gatCEmUG
         AsqxT3jIzxjJ7GAWjCE2UrBganTPPnkDRVtzThFIn2Y1axscCELJn0LaD6JqdBzXaKrf
         i1WsoG+MWCe85wvdnDtX6Fx1hlTj4wihVqwYsz/c+AijrwgbCWJKO/c7w2jja+kpvfy/
         g04/tpokfHgW8R+AC/GL5ebKbvKyYMDGEtAs6kOt8h8r6x0El0PLzTyBGaBP01tgoNWS
         hJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tsCLU7c5unBxnRP02RziNczP1dVrvUnmrxRghsZ+ccw=;
        b=dQUOnQ0o7l23F90qrGWXIgjUSCx+g5f+a60lwNzlvlv1NfCZE1+wWe8zpVuOXiNgip
         MYMog2wFCBVjB88uhKu0XfWxUmQoG/jPvY6T4UfkXxM2hdvklk9X/mw2gN/Pw2CaSm8O
         pMar2E9bz5Q5ssgsK+THYX+NLWsU9OgIj6lpXT1mkWMDMd6l2vaCfonWsH/Jr08FXncL
         VsEnCs9we0sL075mV693uo85lG+rZfQZI9JSx0zdwQi2PrElQk7lK6RstZHAWKo/XrdV
         hpLeGxKw3+8PMue5Rxp55KOd5BJfOlkSnNclTzWNrRc0NO4pXxjTnFMMxX/NSqP9EdlA
         Dywg==
X-Gm-Message-State: AOAM5338zy7IdTd5NSHr0dZqsT1/nr06v4jHQEnBrL0bqg8FU6ca+HNm
        BV9nFLG0cpZIFAMQDsV25DA=
X-Google-Smtp-Source: ABdhPJyi1PE2q6tlPKD/XsNCFCOHrnFjIMxUTjwni1holsNvEaEXZT4I+ft7lPgtJD/228HhL9gSCg==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr27951100wrw.225.1592211758476;
        Mon, 15 Jun 2020 02:02:38 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id o15sm24089516wrv.48.2020.06.15.02.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:02:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        julia.lawall@lip6.fr, jonas.gorski@gmail.com, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 3/8] mips: bmips: add BCM6328 clock definitions
Date:   Mon, 15 Jun 2020 11:02:26 +0200
Message-Id: <20200615090231.2932696-4-noltari@gmail.com>
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

Add header with BCM6328 definitions in order to be able to include it from
device tree files.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 include/dt-bindings/clock/bcm6328-clock.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 include/dt-bindings/clock/bcm6328-clock.h

diff --git a/include/dt-bindings/clock/bcm6328-clock.h b/include/dt-bindings/clock/bcm6328-clock.h
new file mode 100644
index 000000000000..1f6a3103f3dc
--- /dev/null
+++ b/include/dt-bindings/clock/bcm6328-clock.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __DT_BINDINGS_CLOCK_BCM6328_H
+#define __DT_BINDINGS_CLOCK_BCM6328_H
+
+#define BCM6328_CLK_PHYMIPS	0
+#define BCM6328_CLK_ADSL_QPROC	1
+#define BCM6328_CLK_ADSL_AFE	2
+#define BCM6328_CLK_ADSL	3
+#define BCM6328_CLK_MIPS	4
+#define BCM6328_CLK_SAR		5
+#define BCM6328_CLK_PCM		6
+#define BCM6328_CLK_USBD	7
+#define BCM6328_CLK_USBH	8
+#define BCM6328_CLK_HSSPI	9
+#define BCM6328_CLK_PCIE	10
+#define BCM6328_CLK_ROBOSW	11
+
+#endif /* __DT_BINDINGS_CLOCK_BCM6328_H */
-- 
2.27.0

