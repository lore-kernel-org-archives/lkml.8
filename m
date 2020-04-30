Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A254C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E4420873
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588263525;
	bh=fDDw8CUiWiLSO3QdJj2xM8TflOXwJKfxuSuTRCHZmLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zyCdjaoxBhr0Y0q+414PmYjljnZI2KQpwFp+zJTg8Emdi4YEfqQHBhdi+bdBdm82w
	 qJTCnoG5qsd0E12ITeFChCiIl57yY+SUl3SxihByh3S/T2eIE/uVVykGAezAdYBLdW
	 Vc7GmDTHLjgGqFD1Tq0D+cquWRZP2/f79c9qc6x0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgD3QSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbgD3QSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:18:38 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E4424953;
        Thu, 30 Apr 2020 16:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588263517;
        bh=fDDw8CUiWiLSO3QdJj2xM8TflOXwJKfxuSuTRCHZmLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hW8jITZN6VrKvdZ+oI070r43Rh2yWj68X3GMYffFDZBZmwMAlQai98wgclos6ywbQ
         9ghSwzy/4xHcRjW7lx5njvgv6A77g/U3AIon97i0GwYHouULVO29XrYMhig1KYzFr7
         OgSFVoRYnYdi55HGEqbUVSruL1+MqgfJ4vmUQsz0=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUBtU-00AxhD-2Z; Thu, 30 Apr 2020 18:18:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 08/19] docs: misc-devices/pci-endpoint-test.txt: convert to ReST
Date:   Thu, 30 Apr 2020 18:18:22 +0200
Message-Id: <6e0cbd6f37cfb6a21afdd1dcb0ed3ec3f14e64f9.1588263270.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588263270.git.mchehab+huawei@kernel.org>
References: <cover.1588263270.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Use titles markups;
- Adjust identation;
- use literal markup;
- Use the proper notation for footnotes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/misc-devices/index.rst          |  1 +
 .../misc-devices/pci-endpoint-test.rst        | 56 +++++++++++++++++++
 .../misc-devices/pci-endpoint-test.txt        | 41 --------------
 3 files changed, 57 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/misc-devices/pci-endpoint-test.rst
 delete mode 100644 Documentation/misc-devices/pci-endpoint-test.txt

diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index a72ab89e7d1a..17e77b6aa27c 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -22,5 +22,6 @@ fit into other categories.
    lis3lv02d
    max6875
    mic/index
+   pci-endpoint-test
    spear-pcie-gadget
    xilinx_sdfec
diff --git a/Documentation/misc-devices/pci-endpoint-test.rst b/Documentation/misc-devices/pci-endpoint-test.rst
new file mode 100644
index 000000000000..26e5d9ba146b
--- /dev/null
+++ b/Documentation/misc-devices/pci-endpoint-test.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+Driver for PCI Endpoint Test Function
+=====================================
+
+This driver should be used as a host side driver if the root complex is
+connected to a configurable PCI endpoint running ``pci_epf_test`` function
+driver configured according to [1]_.
+
+The "pci_endpoint_test" driver can be used to perform the following tests.
+
+The PCI driver for the test device performs the following tests:
+
+	#) verifying addresses programmed in BAR
+	#) raise legacy IRQ
+	#) raise MSI IRQ
+	#) raise MSI-X IRQ
+	#) read data
+	#) write data
+	#) copy data
+
+This misc driver creates /dev/pci-endpoint-test.<num> for every
+``pci_epf_test`` function connected to the root complex and "ioctls"
+should be used to perform the above tests.
+
+ioctl
+-----
+
+ PCITEST_BAR:
+	      Tests the BAR. The number of the BAR to be tested
+	      should be passed as argument.
+ PCITEST_LEGACY_IRQ:
+	      Tests legacy IRQ
+ PCITEST_MSI:
+	      Tests message signalled interrupts. The MSI number
+	      to be tested should be passed as argument.
+ PCITEST_MSIX:
+	      Tests message signalled interrupts. The MSI-X number
+	      to be tested should be passed as argument.
+ PCITEST_SET_IRQTYPE:
+	      Changes driver IRQ type configuration. The IRQ type
+	      should be passed as argument (0: Legacy, 1:MSI, 2:MSI-X).
+ PCITEST_GET_IRQTYPE:
+	      Gets driver IRQ type configuration.
+ PCITEST_WRITE:
+	      Perform write tests. The size of the buffer should be passed
+	      as argument.
+ PCITEST_READ:
+	      Perform read tests. The size of the buffer should be passed
+	      as argument.
+ PCITEST_COPY:
+	      Perform read tests. The size of the buffer should be passed
+	      as argument.
+
+.. [1] Documentation/PCI/endpoint/function/binding/pci-test.txt
diff --git a/Documentation/misc-devices/pci-endpoint-test.txt b/Documentation/misc-devices/pci-endpoint-test.txt
deleted file mode 100644
index 58ccca4416b1..000000000000
--- a/Documentation/misc-devices/pci-endpoint-test.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Driver for PCI Endpoint Test Function
-
-This driver should be used as a host side driver if the root complex is
-connected to a configurable PCI endpoint running *pci_epf_test* function
-driver configured according to [1].
-
-The "pci_endpoint_test" driver can be used to perform the following tests.
-
-The PCI driver for the test device performs the following tests
-	*) verifying addresses programmed in BAR
-	*) raise legacy IRQ
-	*) raise MSI IRQ
-	*) raise MSI-X IRQ
-	*) read data
-	*) write data
-	*) copy data
-
-This misc driver creates /dev/pci-endpoint-test.<num> for every
-*pci_epf_test* function connected to the root complex and "ioctls"
-should be used to perform the above tests.
-
-ioctl
------
- PCITEST_BAR: Tests the BAR. The number of the BAR to be tested
-	      should be passed as argument.
- PCITEST_LEGACY_IRQ: Tests legacy IRQ
- PCITEST_MSI: Tests message signalled interrupts. The MSI number
-	      to be tested should be passed as argument.
- PCITEST_MSIX: Tests message signalled interrupts. The MSI-X number
-	      to be tested should be passed as argument.
- PCITEST_SET_IRQTYPE: Changes driver IRQ type configuration. The IRQ type
-	      should be passed as argument (0: Legacy, 1:MSI, 2:MSI-X).
- PCITEST_GET_IRQTYPE: Gets driver IRQ type configuration.
- PCITEST_WRITE: Perform write tests. The size of the buffer should be passed
-		as argument.
- PCITEST_READ: Perform read tests. The size of the buffer should be passed
-	       as argument.
- PCITEST_COPY: Perform read tests. The size of the buffer should be passed
-	       as argument.
-
-[1] -> Documentation/PCI/endpoint/function/binding/pci-test.txt
-- 
2.25.4

