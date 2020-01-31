Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC4CC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1640A214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgAaIrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 03:47:04 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39416 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbgAaIrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:47:04 -0500
Received: by mail-ed1-f65.google.com with SMTP id m13so6962201edb.6;
        Fri, 31 Jan 2020 00:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a4whMVybYrFM/VJAJPt+RDbk4EyD/C4nT92WrUXXMMQ=;
        b=NMnzy3wUlMymGlB7XruknFGb0FsFvwCkFYwpouYevIrG1sSPqgw+6NpuRZfEXcoeRF
         UdFzzQh7/2gGIP6BXKnW/jICZRJBrwKKo+n8ZsCtet3vHytDeQj+KsavtX/ta7rhbtDg
         NzBR4JrlIhMs8pRvQAXF3t/j+K9X/7T1NG3J7kr3mtDAb+CXbDDjJIm0loXIo6WaO9Gx
         II5QNdRxfESLC07ngffpMCotsqpP8SBshNGzV9Z5J44+yHavw/dqdoAv4IHF9zkLX5Y5
         leM8Tez2tt+c4nGQ1T9FXWRiiJbhLS0ai0Nkb2ZO0/hsw1z/A/gDx+f7ARNeNXS5+5j+
         Ss/g==
X-Gm-Message-State: APjAAAUDRZAPga6q3TAW4H4S1GBA7MRtLaoWXlGOPMtSdMXEehmHcCQk
        jtKQgNQcqM73Xcv8+OSNMrfbDvsMM5Y=
X-Google-Smtp-Source: APXvYqwVssG86O2ErBa6n9RNwfEo2zbOuBOpqzLbdB2yNiTtwkz3BXzSwlTSq0J98OUyvSyrwBqSug==
X-Received: by 2002:adf:e483:: with SMTP id i3mr10556484wrm.215.1580460113362;
        Fri, 31 Jan 2020 00:41:53 -0800 (PST)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id x7sm11034302wrq.41.2020.01.31.00.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 00:41:52 -0800 (PST)
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
Subject: [PATCH v3 04/12] ARM: dts: imx7d: cl-som-imx7: add emmicro,em3027 RTC
Date:   Fri, 31 Jan 2020 08:36:30 +0000
Message-Id: <20200131083638.6118-4-git@andred.net>
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

add/enable RTC support using the on-board EM3027 real time
clock on i2c2.

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
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index ec82f4738c4f..481bd3971c55 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -181,6 +181,11 @@
 		reg = <0x50>;
 		pagesize = <16>;
 	};
+
+	rtc@56 {
+		compatible = "emmicro,em3027";
+		reg = <0x56>;
+	};
 };
 
 &uart1 {
-- 
2.23.0.rc1

