Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD9FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF8C2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584835;
	bh=bJ5vHl2H8/BvNDVhsIs4pfBDlyCaMBFtm0KMc8o1C+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Ace7QefyIE/lZYjM3X9wbQXFAN257f8CQ86Uy3nYLNtGZRk0jRErnLsURPptKKMZ
	 8RHf4RFNrL4Tgw+51y8Wr4NDkonxKYtOg3O6GCs7lru024/EEiW0JbEPqed6wnMFx1
	 pLkRB/LYzXBnArIAhR7FZLL42eicnkma2Vsx7BHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394923AbgFSQkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388682AbgFSOpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:45:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB6DD20DD4;
        Fri, 19 Jun 2020 14:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577933;
        bh=bJ5vHl2H8/BvNDVhsIs4pfBDlyCaMBFtm0KMc8o1C+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVq0+ljMw04z6ayGMABrS869t8yVvY1NZ0T9gsGZ//du5HZ58EOuO2Cg07DVfEOMC
         TdXWiqhHYHCKONrc2Koo1VkiRCIOy4+mjv8wqDhNh/mFpmjA3JlGt+pXHnhQ/908Ce
         N0AjA/JtZOqaksr/m4hFU77HSxBOSaeGwThstwd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaochun Lee <lixc17@lenovo.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.14 019/190] x86/PCI: Mark Intel C620 MROMs as having non-compliant BARs
Date:   Fri, 19 Jun 2020 16:31:04 +0200
Message-Id: <20200619141634.432134989@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaochun Lee <lixc17@lenovo.com>

commit 1574051e52cb4b5b7f7509cfd729b76ca1117808 upstream.

The Intel C620 Platform Controller Hub has MROM functions that have non-PCI
registers (undocumented in the public spec) where BAR 0 is supposed to be,
which results in messages like this:

  pci 0000:00:11.0: [Firmware Bug]: reg 0x30: invalid BAR (can't size)

Mark these MROM functions as having non-compliant BARs so we don't try to
probe any of them.  There are no other BARs on these devices.

See the Intel C620 Series Chipset Platform Controller Hub Datasheet,
May 2019, Document Number 336067-007US, sec 2.1, 35.5, 35.6.

[bhelgaas: commit log, add 0xa26d]
Link: https://lore.kernel.org/r/1589513467-17070-1-git-send-email-lixiaochun.2888@163.com
Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/pci/fixup.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -572,6 +572,10 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IN
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_invalid_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0xa1ec, pci_invalid_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0xa1ed, pci_invalid_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0xa26c, pci_invalid_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0xa26d, pci_invalid_bar);
 
 /*
  * Device [1022:7808]


