Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B500C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515B9206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml0Gpa+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgC0Urm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:47:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55651 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgC0Url (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 16:47:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id z5so12886052wml.5;
        Fri, 27 Mar 2020 13:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=weESLclomst8MmxTjhXCwtiBQWPXpRNsfho6iSaQvR0=;
        b=ml0Gpa+YxAo2e20yL3Ahl+UF76HE4TWOlvdv6JAGZqbCLJZ29ZAsOEOgvtCBVtbewF
         VihGHGj2cb0I0BquQ59PsnPn/PCfzakOawIZ3dKZLFoU98yvWqnJ02oSXltWTU8DN3C6
         +8azV8x3FDQbx4+NzSN3efQQsq0OQBW5GZZOCp4Mn4NUpwjNQnS1YFDp3a7dy/Lq9QOy
         m40Y7oZaipD7e/PChVYTtVKX/JUEDJGa9whmlKms0BChQlHgYWuXjngFTiWbLMblmwNn
         77oeN3XjR1Y4Ny5MFiPPbQ5q1dCH8fmOrTtmfZfkCLikywFn/xjidd8TUwWg+By1VTCl
         XalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=weESLclomst8MmxTjhXCwtiBQWPXpRNsfho6iSaQvR0=;
        b=moVs5FEJ3v2swBxwUODkHLZAaK2eu+N+dsNaDlRYoS7vjfyQY8K6p6080Yb7lgx0gp
         DXEaQZ7bo0GM/pr8xpqesbOfjeC0IeCkChjQTyOsh/6zFQKhjfxLyO82QTLgxe5DXXRa
         QueXyJJy2GWz//1rfqh4I1wfotAfzC+XTsnfD/a4+zWl0g1laAlMYKtA4dsPGD8Id7eT
         jE6Bgu76X8wLCm+DrIlbAXB4kkEvs27s+j8Xbih9MGSyYkKsu21vlWAOpPiplP94ie+s
         upwN9OCEfZklSFNXGTEWApVDem7lg2bbPtTr1CXyubvH24MUm0XXd3wCEMbYJgRzIYwa
         GTSQ==
X-Gm-Message-State: ANhLgQ2x141eqQfB92T2BSiQK+5Ukt75CwCyHdIIhyR49Fl+WcqS2rDW
        LbS6aPmy+GwXClVm5ZyqMCWvYyagGXg=
X-Google-Smtp-Source: ADFU+vt3FsEDVB6dZJBiQX7+YCbhjisyRwSkjG0/zk0GcfnXhDVoDc406V4b/IzziRUi2gzIyQBwiw==
X-Received: by 2002:a05:600c:234f:: with SMTP id 15mr525258wmq.24.1585342059102;
        Fri, 27 Mar 2020 13:47:39 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id z129sm9661450wmb.7.2020.03.27.13.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 13:47:38 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        bcm-kernel-feedback-list@broadcom.com,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 2/4] usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
Date:   Fri, 27 Mar 2020 16:47:09 -0400
Message-Id: <20200327204711.10614-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327204711.10614-1-alcooperx@gmail.com>
References: <20200327204711.10614-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Broadcom STB SoC's to the xhci platform driver

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/host/xhci-brcm.c | 16 ++++++++++++++++
 drivers/usb/host/xhci-brcm.h | 16 ++++++++++++++++
 drivers/usb/host/xhci-plat.c | 11 +++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 drivers/usb/host/xhci-brcm.c
 create mode 100644 drivers/usb/host/xhci-brcm.h

diff --git a/drivers/usb/host/xhci-brcm.c b/drivers/usb/host/xhci-brcm.c
new file mode 100644
index 000000000000..bf8c0bfd1780
--- /dev/null
+++ b/drivers/usb/host/xhci-brcm.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Broadcom */
+
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "xhci.h"
+
+int xhci_plat_brcm_init_quirk(struct usb_hcd *hcd)
+{
+	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+
+	xhci->quirks |= XHCI_RESET_ON_RESUME;
+	return 0;
+}
+
diff --git a/drivers/usb/host/xhci-brcm.h b/drivers/usb/host/xhci-brcm.h
new file mode 100644
index 000000000000..e64800fae4d5
--- /dev/null
+++ b/drivers/usb/host/xhci-brcm.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, Broadcom */
+
+#ifndef _XHCI_BRCM_H
+#define _XHCI_BRCM_H
+
+#if IS_ENABLED(CONFIG_USB_XHCI_BRCM)
+int xhci_plat_brcm_init_quirk(struct usb_hcd *hcd);
+#else
+static inline int xhci_plat_brcm_init_quirk(struct usb_hcd *hcd)
+{
+	return 0;
+}
+#endif
+#endif /* _XHCI_BRCM_H */
+
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 315b4552693c..3e90a1207803 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -22,6 +22,7 @@
 
 #include "xhci.h"
 #include "xhci-plat.h"
+#include "xhci-brcm.h"
 #include "xhci-mvebu.h"
 #include "xhci-rcar.h"
 
@@ -112,6 +113,10 @@ static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen3 = {
 	SET_XHCI_PLAT_PRIV_FOR_RCAR(XHCI_RCAR_FIRMWARE_NAME_V3)
 };
 
+static const struct xhci_plat_priv xhci_plat_brcm = {
+	.init_quirk = xhci_plat_brcm_init_quirk,
+};
+
 static const struct of_device_id usb_xhci_of_match[] = {
 	{
 		.compatible = "generic-xhci",
@@ -147,6 +152,12 @@ static const struct of_device_id usb_xhci_of_match[] = {
 	}, {
 		.compatible = "renesas,rcar-gen3-xhci",
 		.data = &xhci_plat_renesas_rcar_gen3,
+	}, {
+		.compatible = "brcm,xhci-brcm-v2",
+		.data = &xhci_plat_brcm,
+	}, {
+		.compatible = "brcm,bcm7445-xhci",
+		.data = &xhci_plat_brcm,
 	},
 	{},
 };
-- 
2.17.1

