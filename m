Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA52C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C0720829
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAOHJES7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgGQL2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgGQL23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:28:29 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A916C061755;
        Fri, 17 Jul 2020 04:28:29 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id e4so7744246oib.1;
        Fri, 17 Jul 2020 04:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KpZSMSOiIQZq8CyamrA/cFs/7Iv54XIN60oRvTIJGts=;
        b=mAOHJES7KyL/n8YfSQIN/eN6GDRElqFD2CYG2P86oB8JcK5F2kRKlbYPr7fT8vUqEX
         BC8d9fVrpxMEr3WiMGGNO7RlaGwSI9WshQ5XR2nj6N1yLc+Fb1QBEqjTtPmG9dRbZioH
         ukVwLz2yYrGJVcQW5ykOwCPTCOavKzW9x/CQg8fnxp1CzJajCz22M1JwvBMsDplfV0SU
         xf6rkuQ+pDqjc2xBBCUAJHAys2nT1d3azvN+Hk3kaXvhgkZPvowkFIpXkPrvmOz6vPP2
         BQRDwlH4nncgUOJGzx7lapoIUux775FqZ1r7Rd3cV+VRwxtsUQLIT4a6B+eW2mpPmiRF
         pFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KpZSMSOiIQZq8CyamrA/cFs/7Iv54XIN60oRvTIJGts=;
        b=NRckfR3MeFA2XMYi33G20YHLWtC0ZZr11ELU16GZQMP7E0Epbu5vMAmVoyCYhcDq36
         yiD7jLCckp9WILpLJuGlCS8SnXIeZWrEy319SD58Ppqbo3IE2zpB1eZR4kXTrivJZUz/
         UCHPM2uYM7kfVLDvBtsZXxoF/m6Jfd4EbQ5NqgcA+yxbzKKgEX8MxMptZ/PPfdE8jW/E
         8KUPoFouZeCaOj8DYkQ/2WZ+kk49PUGIk8cOX6UnnOhstW7zuTcw6S9+kvZOFjZrBOx1
         Qk5XyZAPYO11CNu3W1yTTj9efoR8OIzjXYuUZXhD4/U+u4OPuoVnpFSyCgcKQzDKnY2b
         TjVA==
X-Gm-Message-State: AOAM532wnPq2WOJtcR7OMPkfr/Nb8vLxvs/Tz8cPcguNC7/kxrK/FWay
        KFtsn08yOkgRRKwZevRw5yxfvswGVxA=
X-Google-Smtp-Source: ABdhPJzcUa/CENx+1oHYc5uYbc3KX2O8Eu77Ni0ISogLFfB44arhOlnmoUVBafi1uaiFsJdaNO5coA==
X-Received: by 2002:aca:f05:: with SMTP id 5mr6670289oip.93.1594985308347;
        Fri, 17 Jul 2020 04:28:28 -0700 (PDT)
Received: from localhost.localdomain ([170.130.31.90])
        by smtp.gmail.com with ESMTPSA id g207sm1719358oib.43.2020.07.17.04.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 04:28:27 -0700 (PDT)
From:   Forest Crossman <cyrozap@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Forest Crossman <cyrozap@gmail.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci: Fix ASM2142/ASM3142 DMA addressing
Date:   Fri, 17 Jul 2020 06:27:34 -0500
Message-Id: <20200717112734.328432-1-cyrozap@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASM2142/ASM3142 (same PCI IDs) does not support full 64-bit DMA
addresses, which can cause silent memory corruption or IOMMU errors on
platforms that use the upper bits. Add the XHCI_NO_64BIT_SUPPORT quirk
to fix this issue.

Signed-off-by: Forest Crossman <cyrozap@gmail.com>
---
 drivers/usb/host/xhci-pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index ef513c2fb843..9234c82e70e4 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -265,6 +265,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
 			pdev->device == 0x1142)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
+	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
+			pdev->device == 0x2142)
+		xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI)
-- 
2.20.1

