Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C1FC2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE8E20714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759808;
	bh=m6uTusX3QKM1rf4TxbnopD7lVV6EztOv2sZpf0uTwsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jrhwkeXae906I8KSVoz4+1kdwxzUwfj2AtDeFXw/yyKAXknlXpdkAsQL/r3JzfAVp
	 DBcRYIK1oCIOtpmIrVAeaaZwyri+t0K/maIc0Ysiiawpj28BW1ruhAlCncYV/gKmlb
	 HHMd3BvRXw3Tnue/1Mok6DU1gGsI98udcX6Q8uF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389377AbgDAQk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389197AbgDAQkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:40:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3E672063A;
        Wed,  1 Apr 2020 16:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759247;
        bh=m6uTusX3QKM1rf4TxbnopD7lVV6EztOv2sZpf0uTwsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZkJUQoc15MrI7IMXEKsW+s4rjUApJBX+PXkgbhq3oFs0khxN7/8DCn2DGlvJhKiR+
         IkPHNt4GYMDr6TUvqXk6kpD9psXiBWFOxZ/cx6WnOeWnryuEelIMrYnBMSqu33Xizg
         5g3FZjbnvCUxgWB1IXrJgJoRoapaWatXRtUEEYvo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alberto Mattea <alberto@mattea.info>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.14 020/148] usb: xhci: apply XHCI_SUSPEND_DELAY to AMD XHCI controller 1022:145c
Date:   Wed,  1 Apr 2020 18:16:52 +0200
Message-Id: <20200401161554.357387148@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alberto Mattea <alberto@mattea.info>

commit 16263abc12d09871156a1c8650fb651f0e552f5e upstream.

This controller timeouts during suspend (S3) with
[  240.521724] xhci_hcd 0000:30:00.3: WARN: xHC save state timeout
[  240.521729] xhci_hcd 0000:30:00.3: ERROR mismatched command completion event
thus preventing the system from entering S3.
Moreover it remains in an undefined state where some connected devices stop
working until a reboot.
Apply the XHCI_SUSPEND_DELAY quirk to make it suspend properly.

CC: stable@vger.kernel.org
Signed-off-by: Alberto Mattea <alberto@mattea.info>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20200306150858.21904-3-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-pci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -140,7 +140,8 @@ static void xhci_pci_quirks(struct devic
 		xhci->quirks |= XHCI_AMD_PLL_FIX;
 
 	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
-		(pdev->device == 0x15e0 ||
+		(pdev->device == 0x145c ||
+		 pdev->device == 0x15e0 ||
 		 pdev->device == 0x15e1 ||
 		 pdev->device == 0x43bb))
 		xhci->quirks |= XHCI_SUSPEND_DELAY;


