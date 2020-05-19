Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9CDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306B8205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589880616;
	bh=n1SYNx+nqeY3RrskAQmJB/fo2huuZpc8H4cex65aZbg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Ll7SIUzcHjb1dBrjYukQicvBO6O9uMDfQCzqSmdhzAUV2HTcF1ot1rwYw2Sjwgvvi
	 Vx1vFC3c0uEIB68gRiWgmntYBxaf/nrw3u/QavRFW0pRtD1pdwLCqEVVsJ/79QrNwV
	 jLl4xmT5R4s+K2bgVHzbd096fDwA3KmcB1bZCCfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgESJaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 05:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbgESJaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 05:30:15 -0400
Received: from localhost.localdomain (unknown [122.182.207.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C9AA207C4;
        Tue, 19 May 2020 09:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589880614;
        bh=n1SYNx+nqeY3RrskAQmJB/fo2huuZpc8H4cex65aZbg=;
        h=From:To:Cc:Subject:Date:From;
        b=l4NvE6zQ/ZisItjJ+oZkR/w4eG03j4mXp+qLc8/+x8UiLtJi50ccRssVE1x8C1OnY
         zF5ZI6pcKx5q7TXGS+3RQhNsKJocf6rxmTWzF8wpsLeI2zIRCI8IhDcEHkm7XwdZrf
         UGdCyArs72uPHbLI7wfZlWItPpG4u5lHHMjAnlrI=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] usb: xhci: make symbols static
Date:   Tue, 19 May 2020 15:00:02 +0530
Message-Id: <20200519093002.1152144-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When renesas module is not built, we get compiler warning on xhci driver
with W=1

  CC [M]  drivers/usb/host/xhci-rcar.o
drivers/usb/host/xhci-pci.h:13:5: warning: no previous prototype for ‘renesas_xhci_check_request_fw’ [-Wmissing-prototypes]
 int renesas_xhci_check_request_fw(struct pci_dev *dev,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/usb/host/xhci-pci.h:19:6: warning: no previous prototype for ‘renesas_xhci_pci_exit’ [-Wmissing-prototypes]
 void renesas_xhci_pci_exit(struct pci_dev *dev) { };
      ^~~~~~~~~~~~~~~~~~~~~

We have defined these symbols when CONFIG_USB_XHCI_PCI_RENESAS is not
defined, but missed making then static.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 8bd5741e3145 ("usb: renesas-xhci: Add the renesas xhci driver")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/usb/host/xhci-pci.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.h b/drivers/usb/host/xhci-pci.h
index 4d749556e350..acd7cf0a1706 100644
--- a/drivers/usb/host/xhci-pci.h
+++ b/drivers/usb/host/xhci-pci.h
@@ -10,13 +10,13 @@ int renesas_xhci_check_request_fw(struct pci_dev *dev,
 void renesas_xhci_pci_exit(struct pci_dev *dev);
 
 #else
-int renesas_xhci_check_request_fw(struct pci_dev *dev,
-				  const struct pci_device_id *id)
+static int renesas_xhci_check_request_fw(struct pci_dev *dev,
+					 const struct pci_device_id *id)
 {
 	return 0;
 }
 
-void renesas_xhci_pci_exit(struct pci_dev *dev) { };
+static void renesas_xhci_pci_exit(struct pci_dev *dev) { };
 
 #endif
 
-- 
2.25.4

