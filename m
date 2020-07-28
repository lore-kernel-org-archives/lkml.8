Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB03C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 04:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF7D921775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 04:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbliRl//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgG1EYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 00:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgG1EYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 00:24:51 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3198EC061794;
        Mon, 27 Jul 2020 21:24:51 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u63so4589990oie.5;
        Mon, 27 Jul 2020 21:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/acPY9VLlTRiHv9DA9lq/Q62CiWAa35NOoQ1vhCiUdY=;
        b=EbliRl//T33Pg+uxpoypCcicC6qsVqFyCoYU/oNffbr0b8HrhBswtfUgEhtGMYGfwG
         PVvl3Fm0j6PrcdZkbNkXuNfbwoOKEKjY/7UKGYG5IPny9aZlyGFjJVEw7tAPTOH5/YFS
         fi6WCaODHgm1fwWKPncG6VL4fqOF6Mf4y/Pb0DkRnOLQmTp5DFpbJ0PUJKQMubSiWCf8
         bgLCe/PsQCESMO4LfW/Ziv9v8V4aoa7RUzgiTHbSqG4Qu/luzwThXTah7DVJ1Qgb9Dm0
         E4XQQXP4ubtE1sk3QV92FR2ROrRwZ5NnNQkWkgFPYZqZb51MfDifjDYsH108HH9mVwFh
         pMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/acPY9VLlTRiHv9DA9lq/Q62CiWAa35NOoQ1vhCiUdY=;
        b=W3GRPMuVNshXnr5fAAqRmbRpdchvAvTBpGPhF6C5JG0ywy9D7dyaMrLcBou3fgfB4j
         QTYfldy2H2WFFeBdE/CNBh2dxORh/eYVo24y7lBQWuIVfFOXBgijTsuo+RYu30GvbIKA
         n/PDDeAL6QUQeTFQt0GwPOw6qog+gqXHnRsXcAkpSuhO+CT0Dh1FRnC570tMWNxpS4Hi
         N2Y4lKGiAUQn5/XFIZ6YT6cGiObPRGZTjlg3cAP9oIziiUHMuJ4ckp/mRE5PipODCA2Z
         mWUNkuNeRuKnmw+wXxfsrGHyk2CuNKaUPnpykfpSvQ3Uq9VcZc7UZzVwndHqktTFukbo
         l8rQ==
X-Gm-Message-State: AOAM531HnRShmo+St7nYHZkLBfI193Mj2a/nLkPl4x35pRKEiM32+4nU
        yNrXhYkgB7+q6/1SGEWVgIxcQhP5Eak=
X-Google-Smtp-Source: ABdhPJwVuI3NZvh8gyh1eGmsE5ugA/FPJKwGgF1lRkYYkYe+k6iXg7q80qsRXfi1ds1YxRQWPiwO9A==
X-Received: by 2002:aca:1c12:: with SMTP id c18mr1903802oic.151.1595910290267;
        Mon, 27 Jul 2020 21:24:50 -0700 (PDT)
Received: from localhost.localdomain ([170.130.31.90])
        by smtp.gmail.com with ESMTPSA id v3sm765198oiv.45.2020.07.27.21.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 21:24:49 -0700 (PDT)
From:   Forest Crossman <cyrozap@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Forest Crossman <cyrozap@gmail.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] usb: xhci: Fix ASMedia ASM1142 DMA addressing
Date:   Mon, 27 Jul 2020 23:24:08 -0500
Message-Id: <20200728042408.180529-3-cyrozap@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728042408.180529-1-cyrozap@gmail.com>
References: <20200727090629.169701-1-cyrozap@gmail.com>
 <20200728042408.180529-1-cyrozap@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've confirmed that the ASMedia ASM1142 has the same problem as the
ASM2142/ASM3142, in that it too reports that it supports 64-bit DMA
addresses when in fact it does not. As with the ASM2142/ASM3142, this
can cause problems on systems where the upper bits matter, and adding
the XHCI_NO_64BIT_SUPPORT quirk completely fixes the issue.

Signed-off-by: Forest Crossman <cyrozap@gmail.com>
---
 drivers/usb/host/xhci-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index baa5af88ca67..3feaafebfe58 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -59,6 +59,7 @@
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_1			0x43bc
 #define PCI_DEVICE_ID_ASMEDIA_1042_XHCI			0x1042
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
+#define PCI_DEVICE_ID_ASMEDIA_1142_XHCI			0x1242
 #define PCI_DEVICE_ID_ASMEDIA_2142_XHCI			0x2142
 
 static const char hcd_name[] = "xhci_hcd";
@@ -268,7 +269,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
-		pdev->device == PCI_DEVICE_ID_ASMEDIA_2142_XHCI)
+	    (pdev->device == PCI_DEVICE_ID_ASMEDIA_1142_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_ASMEDIA_2142_XHCI))
 		xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
-- 
2.20.1

