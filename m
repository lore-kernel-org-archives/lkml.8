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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3941C43463
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E03D2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGeGy4Cf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgG0JHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgG0JHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:07:14 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA47DC061794;
        Mon, 27 Jul 2020 02:07:14 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 93so1622823otx.2;
        Mon, 27 Jul 2020 02:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QIv3y28LLdjd0Z0UuZjwNSM39Rdl4ANvEBYBL0v3aMo=;
        b=CGeGy4Cfy/3OPffDWYm7sHz9JDo3QRf+dAxR5QcGA2Fn/B2QJa2O2dE7RmDF6PF7Dv
         SL0oPn40lN1g83ry/0nd9a+B78KpM2xemZvYY/eTAqafD91Ey7rAi/P5btrcIjtQEYLv
         j6vbbz/kpQ/ITmNyQruNut3zmeAIUzei3gMmJwnH0nb8IuCq//5g0lSVd5RMkLOk1L8K
         6njffm2G4WDJ98al11bPxAB9BRYHzNBW7a9yovYtpUFzoY6TPpzMGgbUJqBkRssq3sEb
         Yk19VhHbsUsPlcZaRZRKzxbB/HTo7htsYt01seDSi3Mzd8lRe54YhXEBAbgMRDWhh4kh
         0+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QIv3y28LLdjd0Z0UuZjwNSM39Rdl4ANvEBYBL0v3aMo=;
        b=IIjNXOEuivyY6IEN54XDCRK1z7NzEYOqVDRgYknfDwbfXrMqR/9YAMepuM1yj4quoG
         n1oJscJp27+cloJe1+ehJYr7oichPBxQuf9qP4TJYOQmcbUFuXdGRJH8t8gH1dlFv3sV
         KFESVsqcx/uEUd0h+YxA4mrTexyL1NIUyQ/9tjR7GQUPCrclmljKyK9h/4mwK66LSCjO
         TqDzxrA5IKYCaDr1yfRJDZ8a0Ibt4CIvxxhd3TN/MFQjI4tbWpfFMck7CktL2vsBrg8G
         vgGf6+oyqh5Rw7ZK49WNYDs/HCa+mo0vY/uZGuNqoCZmg3L+uOjQhB6M/MCa78BR1ZXX
         2E7A==
X-Gm-Message-State: AOAM5335WmrxHU09xrzkcUqpNRYWvl0p8A+DVl2mJxE+5qyd2EiqTpHi
        oDGyyB4P2StpJceOdvd8YupnQ4k0CN8=
X-Google-Smtp-Source: ABdhPJxINd9H/ErycRLQVrDETbDdJFOiXd95fnOzBtdeAkCKdRgvMN2fpMwhycNulqC19RvxMfI87Q==
X-Received: by 2002:a05:6830:19d9:: with SMTP id p25mr1823695otp.151.1595840833941;
        Mon, 27 Jul 2020 02:07:13 -0700 (PDT)
Received: from localhost.localdomain ([170.130.31.90])
        by smtp.gmail.com with ESMTPSA id q189sm1471297oic.15.2020.07.27.02.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 02:07:13 -0700 (PDT)
From:   Forest Crossman <cyrozap@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Forest Crossman <cyrozap@gmail.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] usb: xhci: define IDs for various ASMedia host controllers
Date:   Mon, 27 Jul 2020 04:06:28 -0500
Message-Id: <20200727090629.169701-2-cyrozap@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727090629.169701-1-cyrozap@gmail.com>
References: <20200727090629.169701-1-cyrozap@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

