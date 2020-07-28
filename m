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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948A2C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 04:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E960206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 04:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAuDFI9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgG1EYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 00:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgG1EYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 00:24:44 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB92CC061794;
        Mon, 27 Jul 2020 21:24:42 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id x1so1386244oox.6;
        Mon, 27 Jul 2020 21:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6By5SfnNIDwmjg0WLVB2DqJYuJR6Qu02u0iZQ5kWyI=;
        b=dAuDFI9dnbVkbYzFUYi/+2WFElJ2MZxrP8gDpR9By8UvpbItQngZCjl95r4DxqHeNB
         jso0IlyIvozOlJ0S1bm9cn1aPtHkqjUCmoe1k1up7ICHAGVw8jDVWaZoEcqJu0UW57qi
         bkENSM+2t6treImeF5HDwD6f1IzoX6Nq7tKEUpus/W7pIwErmvfdZaa1pGLkuiW91ZNX
         729ZkfUFScal1isl1OJ/Xjaeg7XDrlDeDNMKG1NDbtlfUBT6EVTdImftwQfLzo1R5DpG
         iQn0mvjU2unYfv9bYPPRhxRd5+vAtblReNEZJWdXB9m3rZMGr168JT9ixFHD4v6AitD+
         Dilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6By5SfnNIDwmjg0WLVB2DqJYuJR6Qu02u0iZQ5kWyI=;
        b=EHGq++2JcOEG+lfgP+EGIZiH0VpvrORZjWoNbuJWqUUryNHqRD2YiyiETynomSMBN4
         XBa6Y+y92miQU+Ph4YctCL/F2yec6ZPDng59q/d4u0m0fZFJmD4DSUz/ai3DXWxHXcnv
         bBFBMiIwlfdWH+El6+Oop7O1WPEDvIQpl2loBz4AE+hkuScD3UtAWCr+MT970srYhj69
         929uNWhy0tJX9MtHsQzgE0vZeHev06TG37CI3AFqZBXiSNf5r0mKxbyDFehy1JOFi3L2
         Z6Ja/Nc7uShZIi32yi2VRRJyCLcnogsthHjaghPndVpqDL29akoSRbT/fu9rruENIPk+
         NMhA==
X-Gm-Message-State: AOAM530RRIq9t46/2GB6TuskOj5rkiEpsqJCtutD+PE5aad7jVY0ak4X
        WR+e+jJa9Ur/jKgsSZ9LxLfh9sX35To=
X-Google-Smtp-Source: ABdhPJxcgewRgW8chxnfbttiUp/D8r3Wsm64RD3yBFMqg9eyF8Vi2jV7IVsAROk+CIjrhR/XfmrgsQ==
X-Received: by 2002:a4a:57c1:: with SMTP id u184mr23382493ooa.41.1595910282016;
        Mon, 27 Jul 2020 21:24:42 -0700 (PDT)
Received: from localhost.localdomain ([170.130.31.90])
        by smtp.gmail.com with ESMTPSA id v3sm765198oiv.45.2020.07.27.21.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 21:24:41 -0700 (PDT)
From:   Forest Crossman <cyrozap@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Forest Crossman <cyrozap@gmail.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] usb: xhci: define IDs for various ASMedia host controllers
Date:   Mon, 27 Jul 2020 23:24:07 -0500
Message-Id: <20200728042408.180529-2-cyrozap@gmail.com>
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

Not all ASMedia host controllers have a device ID that matches its part
number. #define some of these IDs to make it clearer at a glance which
chips require what quirks.

Signed-off-by: Forest Crossman <cyrozap@gmail.com>
---
 drivers/usb/host/xhci-pci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 9234c82e70e4..baa5af88ca67 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -57,7 +57,9 @@
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_3			0x43ba
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_2			0x43bb
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_1			0x43bc
+#define PCI_DEVICE_ID_ASMEDIA_1042_XHCI			0x1042
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
+#define PCI_DEVICE_ID_ASMEDIA_2142_XHCI			0x2142
 
 static const char hcd_name[] = "xhci_hcd";
 
@@ -260,13 +262,13 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_LPM_SUPPORT;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
-			pdev->device == 0x1042)
+		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
-			pdev->device == 0x1142)
+		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
-			pdev->device == 0x2142)
+		pdev->device == PCI_DEVICE_ID_ASMEDIA_2142_XHCI)
 		xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
-- 
2.20.1

