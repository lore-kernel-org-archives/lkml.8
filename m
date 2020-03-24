Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539DDC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C200208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055571;
	bh=3uYIFyGwaBuZfOVVH3bfbQDJfqRIkb/5lCL2RWgSi5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZoXQ9JK7IkbkPV0r1ni5c89xgwrlwcBm9SYGFNMPJ7uw+6gLroDjY1wtjteyRfzau
	 BlDdbakcP0vCGMlwT4nFOOJaG0FK6eBZlHf0BNRrTzARZjnzfkOIzSCBq59humGqe+
	 EEreZvl5v8Z2JpaaHZokuOZAM8scwyhzXpHQ65jM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgCXNMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbgCXNMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:12:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F293E208CA;
        Tue, 24 Mar 2020 13:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055564;
        bh=3uYIFyGwaBuZfOVVH3bfbQDJfqRIkb/5lCL2RWgSi5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zh6pH5cQBDfHiBQ2JMSZC6739v8vY7pskjeQfFyaNtyr2Ddwt3SNiGC/um92+Kj7d
         6H0wr4Zqtcb7QXwWCn5QE3iGmU8BSJp0vpRAaPSebtojhapKyCa7ffpZmiQ1QxI/9Q
         tf6BDhvwUjv34GwYsomyqHF4f6bT44sQ/zRGrjHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alberto Mattea <alberto@mattea.info>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.19 25/65] usb: xhci: apply XHCI_SUSPEND_DELAY to AMD XHCI controller 1022:145c
Date:   Tue, 24 Mar 2020 14:10:46 +0100
Message-Id: <20200324130800.374024759@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130756.679112147@linuxfoundation.org>
References: <20200324130756.679112147@linuxfoundation.org>
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
@@ -128,7 +128,8 @@ static void xhci_pci_quirks(struct devic
 		xhci->quirks |= XHCI_AMD_PLL_FIX;
 
 	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
-		(pdev->device == 0x15e0 ||
+		(pdev->device == 0x145c ||
+		 pdev->device == 0x15e0 ||
 		 pdev->device == 0x15e1 ||
 		 pdev->device == 0x43bb))
 		xhci->quirks |= XHCI_SUSPEND_DELAY;


