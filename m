Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A59EC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C969820674
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845231;
	bh=KWUWdMBADgn5gMykUcybBQ4xBivDbrrAUduc1Xak4GE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DKHb490W0i26OnhrEqFeZWMs6YfWQ0Tbx7+/UO55TBOla7u7gPiEozSkJi/bNTfGB
	 CsLwVBLCxFNVmqGWBRuJ0uIkjNvvEv4tREKvkqDetSV8gszxmaWqhTHazTB+kKhq8Y
	 lH7gfvYeCAlJcmvR1RuFpqGXnkgZYWDAlPCWHs34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgCJNAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730129AbgCJNA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:00:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8321E20674;
        Tue, 10 Mar 2020 13:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845226;
        bh=KWUWdMBADgn5gMykUcybBQ4xBivDbrrAUduc1Xak4GE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2VEdeM0gMEcRcbnAq3wmoXs/FFFUsbAoLCgztiyNUTOiIgwf3/SDhPpSYoZlyixk5
         ZAsTjj5HnES1ksWcOmYJPLaHmODHAOzpFKh18DiWTbBvB6WDWHeXUN7Pt6EgBFA4Ug
         QGhxPJQmy5sQlBoCfukKaTaQjhmrDWmSEfiW/ko4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.5 106/189] s390/pci: Fix unexpected write combine on resource
Date:   Tue, 10 Mar 2020 13:39:03 +0100
Message-Id: <20200310123650.411911992@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Schnelle <schnelle@linux.ibm.com>

commit df057c914a9c219ac8b8ed22caf7da2f80c1fe26 upstream.

In the initial MIO support introduced in

commit 71ba41c9b1d9 ("s390/pci: provide support for MIO instructions")

zpci_map_resource() and zpci_setup_resources() default to using the
mio_wb address as the resource's start address. This means users of the
mapping, which includes most drivers, will get write combining on PCI
Stores. This may lead to problems when drivers expect write through
behavior when not using an explicit ioremap_wc().

Cc: stable@vger.kernel.org
Fixes: 71ba41c9b1d9 ("s390/pci: provide support for MIO instructions")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/pci/pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -424,7 +424,7 @@ static void zpci_map_resources(struct pc
 
 		if (zpci_use_mio(zdev))
 			pdev->resource[i].start =
-				(resource_size_t __force) zdev->bars[i].mio_wb;
+				(resource_size_t __force) zdev->bars[i].mio_wt;
 		else
 			pdev->resource[i].start = (resource_size_t __force)
 				pci_iomap_range_fh(pdev, i, 0, 0);
@@ -531,7 +531,7 @@ static int zpci_setup_bus_resources(stru
 			flags |= IORESOURCE_MEM_64;
 
 		if (zpci_use_mio(zdev))
-			addr = (unsigned long) zdev->bars[i].mio_wb;
+			addr = (unsigned long) zdev->bars[i].mio_wt;
 		else
 			addr = ZPCI_ADDR(entry);
 		size = 1UL << zdev->bars[i].size;


