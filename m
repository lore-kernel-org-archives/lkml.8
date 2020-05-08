Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A78C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5797821835
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941535;
	bh=dH39vX1jFQ/TFkb+BTCWZyIAmD9Vcg+f2I8YszPGVZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dyaa1/nXDobNa81nMko9pH6B3TN6Fyf6wIEdKeDIA0zO5Ym8mEzMOaJ3AdHRM+mVA
	 mA+lSoOpGG1M4DT4L9UD8FcJ69e/s6OfW9HCrFlY5jRWNocuAdsrlJVSVNMGRbM2dU
	 m2oYp21ZcG6Qpz/4rBRUgEpNksoPT+RtCj17plHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgEHMiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbgEHMit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:38:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84BCE2495F;
        Fri,  8 May 2020 12:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941529;
        bh=dH39vX1jFQ/TFkb+BTCWZyIAmD9Vcg+f2I8YszPGVZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzUFFMlHhbVwyZ17tHLluL05vAdum7e9jA6gse5WBFK4xpYwvrGlu3CnVJS4fgO6r
         joiCkPYfDBZP45akVXnPO+7FFG3noKAwS9MxOQzKb3rttl8oJZgO9dFz2OcAUriCry
         1lgJFJNr+ocW3GqW4IjZioDE4aW8ZcqUglMtsL14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 069/312] powerpc/pci/of: Parse unassigned resources
Date:   Fri,  8 May 2020 14:31:00 +0200
Message-Id: <20200508123129.400872881@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Kardashevskiy <aik@ozlabs.ru>

commit dead1c845dbe97e0061dae2017eaf3bd8f8f06ee upstream.

The pseries platform uses the PCI_PROBE_DEVTREE method of PCI probing
which reads "assigned-addresses" of every PCI device and initializes
the device resources. However if the property is missing or zero sized,
then there is no fallback of any kind and the PCI resources remain
undiscovered, i.e. pdev->resource[] array remains empty.

This adds a fallback which parses the "reg" property in pretty much same
way except it marks resources as "unset" which later make Linux assign
those resources proper addresses.

This has an effect when:
1. a hypervisor failed to assign any resource for a device;
2. /chosen/linux,pci-probe-only=0 is in the DT so the system may try
assigning a resource.
Neither is likely to happen under PowerVM.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/pci_of_scan.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -82,10 +82,16 @@ static void of_pci_parse_addrs(struct de
 	const __be32 *addrs;
 	u32 i;
 	int proplen;
+	bool mark_unset = false;
 
 	addrs = of_get_property(node, "assigned-addresses", &proplen);
-	if (!addrs)
-		return;
+	if (!addrs || !proplen) {
+		addrs = of_get_property(node, "reg", &proplen);
+		if (!addrs || !proplen)
+			return;
+		mark_unset = true;
+	}
+
 	pr_debug("    parse addresses (%d bytes) @ %p\n", proplen, addrs);
 	for (; proplen >= 20; proplen -= 20, addrs += 5) {
 		flags = pci_parse_of_flags(of_read_number(addrs, 1), 0);
@@ -110,6 +116,8 @@ static void of_pci_parse_addrs(struct de
 			continue;
 		}
 		res->flags = flags;
+		if (mark_unset)
+			res->flags |= IORESOURCE_UNSET;
 		res->name = pci_name(dev);
 		region.start = base;
 		region.end = base + size - 1;


