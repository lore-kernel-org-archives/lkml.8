Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A51C433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506BD2065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261463;
	bh=l3dUy7lUhgee3ydzzfEtI33EPmTQWil48PbmbYiKmsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VM9+H/afMrUxrPeNEXdd7VbE8A1osg+K08s6Af0IG6CAHjn/FgNrfFAvIYOrT4NqU
	 9pTmhZyFU/mmH/6fWT9qcYzTAhCJurOUITEO4ivMmXSYOkzEhF+pkhbHceiwTqoPtZ
	 c7Qpjmth14jN8N8fSC2+YK1Ufog+1tyvCNwdtMfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbgGTQLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733271AbgGTQK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:10:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1F982065E;
        Mon, 20 Jul 2020 16:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261459;
        bh=l3dUy7lUhgee3ydzzfEtI33EPmTQWil48PbmbYiKmsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xhT4bdwYAJ8m4sQCBhdngZoREFe3Io6QWARVgCZcWAzz6AuU/loaRb9Eu8PEwYDYs
         iQD2THUB/ybOaUgnX42JXZyJTFOwX/YCuD3UEZe5Gl88G3ZYppjoOtXUyxBYWsPLJX
         R19D+vdGluMSOPVdWqIFsRM9GZw/WQ8RFiwu4K7I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 5.7 124/244] PCI/PM: Call .bridge_d3() hook only if non-NULL
Date:   Mon, 20 Jul 2020 17:36:35 +0200
Message-Id: <20200720152831.735772926@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

commit c3aaf086701d05a82c8156ee8620af41e5a7d6fe upstream.

26ad34d510a8 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports") added
the struct pci_platform_pm_ops.bridge_d3() function pointer and
platform_pci_bridge_d3() to use it.

The .bridge_d3() op is implemented by acpi_pci_platform_pm, but not by
mid_pci_platform_pm.  We don't expect platform_pci_bridge_d3() to be called
on Intel MID platforms, but nothing in the code itself would prevent that.

Check the .bridge_d3() pointer for NULL before calling it.

Fixes: 26ad34d510a8 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -868,7 +868,9 @@ static inline bool platform_pci_need_res
 
 static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 {
-	return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;
+	if (pci_platform_pm && pci_platform_pm->bridge_d3)
+		return pci_platform_pm->bridge_d3(dev);
+	return false;
 }
 
 /**


