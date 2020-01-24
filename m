Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05165C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8EA2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391919AbgAXTLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:11:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43074 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404072AbgAXTLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:11:25 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv4MU-0007en-3J; Fri, 24 Jan 2020 20:11:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E5D441C1A6A;
        Fri, 24 Jan 2020 20:11:11 +0100 (CET)
Date:   Fri, 24 Jan 2020 19:11:11 -0000
From:   "tip-bot2 for Qianggui Song" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: interrupt-controller: New binding for
 Meson-A1 SoCs
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191216123645.10099-2-qianggui.song@amlogic.com>
References: <20191216123645.10099-2-qianggui.song@amlogic.com>
MIME-Version: 1.0
Message-ID: <157989307176.396.7118482229326973192.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fd6765b4c991bb9e4dd6b384b529166db82e5931
Gitweb:        https://git.kernel.org/tip/fd6765b4c991bb9e4dd6b384b529166db82e5931
Author:        Qianggui Song <qianggui.song@amlogic.com>
AuthorDate:    Mon, 16 Dec 2019 20:36:42 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 20 Jan 2020 19:10:05 

dt-bindings: interrupt-controller: New binding for Meson-A1 SoCs

Update dt-binding document for GPIO interrupt controller of Meson-A1 SoCs

Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20191216123645.10099-2-qianggui.song@amlogic.com
---
 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
index 684bb1c..23b18b9 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
@@ -17,6 +17,7 @@ Required properties:
     "amlogic,meson-axg-gpio-intc" for AXG SoCs (A113D, A113X)
     "amlogic,meson-g12a-gpio-intc" for G12A SoCs (S905D2, S905X2, S905Y2)
     "amlogic,meson-sm1-gpio-intc" for SM1 SoCs (S905D3, S905X3, S905Y3)
+    "amlogic,meson-a1-gpio-intc" for A1 SoCs (A113L)
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller.
 - #interrupt-cells : Specifies the number of cells needed to encode an
