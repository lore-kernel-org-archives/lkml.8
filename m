Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746EBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458CE2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPJ8MjMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCMOQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:16:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33632 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgCMOQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:16:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id a25so12323504wrd.0;
        Fri, 13 Mar 2020 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bSpghWAMwr8Q+uEFRygw1e/iYUietdP6cX8XvjepZ+U=;
        b=EPJ8MjMjDnDTgKA2OhGgCSXfsmAgm76W53Tnwy+u1uWTTDZH9zPuJk2ktTkbQpRuIs
         YyFkcdmmYOlUPj/t9VsUIAxs7e1rOw0dKSJrcsRpNZLtcLXDP4+eVc7KnrwbylpWLI1F
         gfTKn0aRhAv4o45b0qbrpm7PEeQ9dKIZdGKMHOGSsBCVprijy3O35vE7wemVldA3+MC0
         dISFBR21knHcNnTMcbu/WeoXuSimCySQlkvaq67H2l4gyeb40M5FY9CuDN3hq5k9Frab
         eDtXeUprWtAvJJe8zLcVSWVod3Ff/WaXWYuMoIICXS7QbNRzbvQLz/X2sH0OQO3MHTkw
         MVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bSpghWAMwr8Q+uEFRygw1e/iYUietdP6cX8XvjepZ+U=;
        b=gN4fzcwAGePP3bsdbe20Bp14ISP4IaNDtiKo5dLq/IBLE9p54xFnkrb9ULckzvoKbh
         c//l4NhaGlNiWhDNpjLqRAQICPVL7PJy1vosHAfNEIwWz3V/da1qGMiZKyP/jzDCAhVa
         8vVsfRmynRmO4JEhnH0YHH3dhFM8K7Tx7rxcLWe1FGA0WgrueaBvXv9TsAiVfqr5kM62
         c6mUozfW0bHaX5/uRAyl4shwcYzg1TLnc+URj5QJQUvX4bT7XxhZXhMZ43mdFmwZszWq
         y5fzXdQ43DthBUOj6k3n3lAsC32vZs4R933lQVyZKKi+epAoDb+JvcBJKMN+VMNafD/y
         zbXg==
X-Gm-Message-State: ANhLgQ0y18DeXPxZgpZ6A/5n9z1Tbo/n1TTr+VKn1iSvtfQ18na59p75
        52W0LAoSAVMtm5EoZy5cT5aCU+zNnrE=
X-Google-Smtp-Source: ADFU+vtbfqar6i4PqR8gi5ztuonO7jZmi9+FQlxWumWKx0m2H9MUmcanCn3YizpEN5I9Nivd+WrF+w==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr18297940wrv.308.1584108986387;
        Fri, 13 Mar 2020 07:16:26 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id l83sm17561422wmf.43.2020.03.13.07.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 07:16:25 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH 2/4] usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
Date:   Fri, 13 Mar 2020 10:15:43 -0400
Message-Id: <20200313141545.31943-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313141545.31943-1-alcooperx@gmail.com>
References: <20200313141545.31943-1-alcooperx@gmail.com>
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
index d90cd5ec09cf..9314620b8fad 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -24,6 +24,7 @@
 #include "xhci-plat.h"
 #include "xhci-mvebu.h"
 #include "xhci-rcar.h"
+#include "xhci-brcm.h"
 
 static struct hc_driver __read_mostly xhci_plat_hc_driver;
 
@@ -112,6 +113,10 @@ static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen3 = {
 	SET_XHCI_PLAT_PRIV_FOR_RCAR(XHCI_RCAR_FIRMWARE_NAME_V3)
 };
 
+static const struct xhci_plat_priv xhci_plat_brcm = {
+	.init_quirk = xhci_plat_brcm_init_quirk
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

