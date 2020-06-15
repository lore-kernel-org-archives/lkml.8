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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720DCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC4820663
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6fPh/ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgFOJC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbgFOJCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:02:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA25C061A0E;
        Mon, 15 Jun 2020 02:02:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r15so13978640wmh.5;
        Mon, 15 Jun 2020 02:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cJ0uxRdi9VEd/TOL8ED+lcxK3NI1zfgFx15e2ixS1k4=;
        b=e6fPh/icrbjbhyw0BeCx94yeiXcmNnPTJTSQjk1tm5EOL/UtIwcojt7fieEnRGLcQw
         YiUfaRwFFd/juPYoDUiOusjx9BFpAEtZHriY0u5z6IL1xtseQ5jUp1lEA7tt5oIARqxC
         m5J5Nw0oZtfG8Ty8MR+57WlsfhW8DjxUqhMq8jQpr/0MvbunUHIC9AN4AhAQMhP24LKU
         wF6zU32YdWcPe47uVmbH6AhLcZSw2lZlec7b9N1BlzQXKi0ylu9xeYa/eJO3mV3aBtRZ
         iNunjh0AjiQOKBf3dyZbZVLqK/exfU5DjpKDoXdZZc0T7oWdR3tDTfFZcGzvZhUo3e9T
         QOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cJ0uxRdi9VEd/TOL8ED+lcxK3NI1zfgFx15e2ixS1k4=;
        b=AFj2PpTVB8yRzYy29dT5iGU9OHBTBwnBgZwpzkhPimyMZA2nuA2MrLsgSwfbk72wTQ
         dNuFVB9I3r9qeqlNt0QQORdNZaxaXmZMKboYhC3NaWiYJRTNUOl16UzBA2f+GJoSLkLJ
         zMMg3YQ+XoJLLpgJC8a6fyLWGESwdCtx+/5sfomFj8TZg51bYoMGkYDGquhDtlGiIG/u
         hbviwsoW3A6zKu9OlVKr7dif//UIXtThcxc/9N6LwvvJUz85Jixe7/RNm/Js5wfmQKnj
         A62bBC5bfjPiXErBy0ALlxlqbQJovUBDzmsmTHGXJQqYfUi2/gkNOZ2oGQgG2JEpws9r
         CPmg==
X-Gm-Message-State: AOAM532uokt7PvfdEwj+Y8L/wfsoYh+GWerBl60xTBO1DCS508FSk4zS
        NoH1Xtv6265OIKCw9IzQ8BE=
X-Google-Smtp-Source: ABdhPJykT5vQvP9A9keEIoJeerQLZ0fPea/ZllQI8Xc8lISOTXMHBRJ0V3qK9KhCAGp2crETqhGNSg==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr11812966wmi.58.1592211761939;
        Mon, 15 Jun 2020 02:02:41 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id o15sm24089516wrv.48.2020.06.15.02.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:02:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        julia.lawall@lip6.fr, jonas.gorski@gmail.com, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 6/8] mips: bmips: add BCM6368 clock definitions
Date:   Mon, 15 Jun 2020 11:02:29 +0200
Message-Id: <20200615090231.2932696-7-noltari@gmail.com>
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

Add header with BCM6368 definitions in order to be able to include it from
device tree files.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 include/dt-bindings/clock/bcm6368-clock.h | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 include/dt-bindings/clock/bcm6368-clock.h

diff --git a/include/dt-bindings/clock/bcm6368-clock.h b/include/dt-bindings/clock/bcm6368-clock.h
new file mode 100644
index 000000000000..f161d5333883
--- /dev/null
+++ b/include/dt-bindings/clock/bcm6368-clock.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __DT_BINDINGS_CLOCK_BCM6368_H
+#define __DT_BINDINGS_CLOCK_BCM6368_H
+
+#define BCM6368_CLK_VDSL_QPROC		2
+#define BCM6368_CLK_VDSL_AFE		3
+#define BCM6368_CLK_VDSL_BONDING	4
+#define BCM6368_CLK_VDSL		5
+#define BCM6368_CLK_PHYMIPS		6
+#define BCM6368_CLK_SWPKT_USB		7
+#define BCM6368_CLK_SWPKT_SAR		8
+#define BCM6368_CLK_SPI			9
+#define BCM6368_CLK_USBD		10
+#define BCM6368_CLK_SAR			11
+#define BCM6368_CLK_ROBOSW		12
+#define BCM6368_CLK_UTOPIA		13
+#define BCM6368_CLK_PCM			14
+#define BCM6368_CLK_USBH		15
+#define BCM6368_CLK_DIS_GLESS		16
+#define BCM6368_CLK_NAND		17
+#define BCM6368_CLK_IPSEC		18
+
+#endif /* __DT_BINDINGS_CLOCK_BCM6368_H */
-- 
2.27.0

