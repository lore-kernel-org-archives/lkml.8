Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD463C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D23020705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgAaIsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 03:48:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50487 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgAaIsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:48:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so6966972wmb.0;
        Fri, 31 Jan 2020 00:48:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sMmbpncOJ0ZaEaTp6uD1F3mJKzNvU9i5QAcT7nrh4JY=;
        b=taKZC9bUFSpkLtDWwagZqFjJrmmfH0HbDtYdkUPFjSuAs5iSCJS+QWW4LHCxIGb9KP
         N9GJ3JB3zT/Icnmuq6Za2kXCKFz1aJyKEOSiR/Ja5JzdB6g/mqfdo2r16PSp/fum1AFq
         cI2l+U9GAa/4Lw2HkPKAGh8rihQu1msjitVVhvg0VIL0KRZpiWqxDI6esSPdu9q3H67q
         80XlWsz4S4jD4PdNVZPihlAJiuHvSHhTkvOKdAPIxb8z5Qvdwt0bWc3EK7sYQwFV+M/J
         HnZh3wl+rv6N1huzjfDTr7D8NkSQN3Z0aBuse0tJbM4WDmiykLTm8HQei7e2cGv8Cnzg
         BJng==
X-Gm-Message-State: APjAAAXpMptjafk2H39fOBN8KAAIOyU+h09t2RNqHWW5R2bAov19cJib
        ffF1q/fgG10ycJQTxc+dBcUgBn4OlHE=
X-Google-Smtp-Source: APXvYqzKcapyTjD9nBiBSyVMOTcqge1oPKD3TaBRMVfA2GO5FZ48/UrkimVNYtSOgOOLzu22AYMvKA==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr11000810wmc.137.1580460117691;
        Fri, 31 Jan 2020 00:41:57 -0800 (PST)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id x7sm11034302wrq.41.2020.01.31.00.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 00:41:57 -0800 (PST)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Ilya Ledvich <ilya@compulab.co.il>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 08/12] ARM: dts: imx7d: cl-som-imx7: update UART1 (debug) clock
Date:   Fri, 31 Jan 2020 08:36:34 +0000
Message-Id: <20200131083638.6118-8-git@andred.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200131083638.6118-1-git@andred.net>
References: <20200131083638.6118-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

assign OSC as uart1 (debug) clock to achieve low power,
so that the PLL doesn't need to be kept on

Signed-off-by: André Draszik <git@andred.net>
Cc: Ilya Ledvich <ilya@compulab.co.il>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index d4637a8ca223..f80be855b4ec 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -222,7 +222,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
 	assigned-clocks = <&clks IMX7D_UART1_ROOT_SRC>;
-	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
 	status = "okay";
 };
 
-- 
2.23.0.rc1

