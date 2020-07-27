Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD28C43465
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC04F20714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOSDwWY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgG0JH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgG0JHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:07:24 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D9DC061794;
        Mon, 27 Jul 2020 02:07:24 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k22so13763102oib.0;
        Mon, 27 Jul 2020 02:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/acPY9VLlTRiHv9DA9lq/Q62CiWAa35NOoQ1vhCiUdY=;
        b=HOSDwWY6psSHAf/sxyIYNVWjM3iNUdh85IqFhWbqX5Ao9PyrG1IRT1ul6oaBSGiUos
         evcBLqvHIjxyc55ARGzkF4GwZXjwYkgN3viW9kDZb4UCUy3maE0cib9Imm6d6s/TXUTZ
         hYb6deEToFfEHwTBsAPZWdH6cce9w+pFImzoqSTMKpDHnovgRXeI1NSA1bV8AoobxR62
         sBNDCponYBD1D4FNHxk6g0wViEm1IlB4uMWutVJ3YVVRhAipWj49RAofWAeT/2zLMk7w
         2hLvY0kH+PfrCV9eVEp+pvhv8ayiZLKwPvfEBUYkQmfa8s2KcPlCVxY2JyD6i1Z10h6o
         0d5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/acPY9VLlTRiHv9DA9lq/Q62CiWAa35NOoQ1vhCiUdY=;
        b=e34jOrPlNOcIiQL+fhff707QBSK7668Ga2pOusTFNaJwd86Jtq6z2ytSALM6YVQObR
         3kLpX8SHDVRKhHhRgmXAGRKI5SVvqB1bkYb2OGI7dmcfZogk4Lev0Cj3YCnTjpmazIu9
         SHWUYQF6b/nULQZSdzJHlU0BibTbYTr65XRYZs1Pl3o7FsRZbdeJocQ21eD3CwHI4/vg
         x7G8w3It3JmrZPsy7lNXWeVVPx+6Kb7A2Z7rvFzJbfNdKyAARQzGB3nuYagOa/ccUVKN
         RRuDML21zpnGKDrYK8WQpKxMgrBLBJwh3WKnsNMZ98FW3HIuLXRAQ4M11qY7lGw0DvCF
         wYOw==
X-Gm-Message-State: AOAM533tarvK56k1FM/A3bd4MBX4tg6qCNklD8rq8DqE0hCGYrCTdRDu
        O9er+2SM1rS59jgpAvXELT02pyBGhBk=
X-Google-Smtp-Source: ABdhPJzOIsNkWrL5WqLHCj62fTSUlSegmCNnGQFl/mJG2tooJTSgdFQDYY0OYQXZ8+zYuXtKxWqgYA==
X-Received: by 2002:aca:3102:: with SMTP id x2mr6431919oix.57.1595840843892;
        Mon, 27 Jul 2020 02:07:23 -0700 (PDT)
Received: from localhost.localdomain ([170.130.31.90])
        by smtp.gmail.com with ESMTPSA id q189sm1471297oic.15.2020.07.27.02.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 02:07:23 -0700 (PDT)
From:   Forest Crossman <cyrozap@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Forest Crossman <cyrozap@gmail.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] usb: xhci: Fix ASMedia ASM1142 DMA addressing
Date:   Mon, 27 Jul 2020 04:06:29 -0500
Message-Id: <20200727090629.169701-3-cyrozap@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727090629.169701-1-cyrozap@gmail.com>
References: <20200727090629.169701-1-cyrozap@gmail.com>
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

