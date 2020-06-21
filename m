Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6952FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B26E22CF8
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgFUNf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 09:35:27 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:41156 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729676AbgFUNf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 09:35:27 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id E8F2F45378;
        Sun, 21 Jun 2020 13:35:22 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Zhang Rui <rui.zhang@intel.com>,
        =?UTF-8?q?Joakim=20L=C3=B6nnegren?= <joakimlonnegren@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: Documentation/driver-api
Date:   Sun, 21 Jun 2020 15:35:12 +0200
Message-Id: <20200621133512.46311-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 .../early-userspace/early_userspace_support.rst      |  4 ++--
 Documentation/driver-api/memory-devices/ti-gpmc.rst  |  2 +-
 Documentation/driver-api/mmc/mmc-tools.rst           |  2 +-
 Documentation/driver-api/nvdimm/nvdimm.rst           | 12 ++++++------
 Documentation/driver-api/nvdimm/security.rst         |  2 +-
 Documentation/driver-api/rapidio/rapidio.rst         |  4 ++--
 Documentation/driver-api/thermal/nouveau_thermal.rst |  2 +-
 Documentation/driver-api/usb/writing_usb_driver.rst  |  4 ++--
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/driver-api/early-userspace/early_userspace_support.rst b/Documentation/driver-api/early-userspace/early_userspace_support.rst
index 3deefb34046b..8a58c61932ff 100644
--- a/Documentation/driver-api/early-userspace/early_userspace_support.rst
+++ b/Documentation/driver-api/early-userspace/early_userspace_support.rst
@@ -92,7 +92,7 @@ You can obtain somewhat infrequent snapshots of klibc from
 https://www.kernel.org/pub/linux/libs/klibc/
 
 For active users, you are better off using the klibc git
-repository, at http://git.kernel.org/?p=libs/klibc/klibc.git
+repository, at https://git.kernel.org/?p=libs/klibc/klibc.git
 
 The standalone klibc distribution currently provides three components,
 in addition to the klibc library:
@@ -122,7 +122,7 @@ and a number of other utilities, so you can replace kinit and build
 custom initramfs images that meet your needs exactly.
 
 For questions and help, you can sign up for the early userspace
-mailing list at http://www.zytor.com/mailman/listinfo/klibc
+mailing list at https://www.zytor.com/mailman/listinfo/klibc
 
 How does it work?
 =================
diff --git a/Documentation/driver-api/memory-devices/ti-gpmc.rst b/Documentation/driver-api/memory-devices/ti-gpmc.rst
index 33efcb81f080..b1bb86871ad7 100644
--- a/Documentation/driver-api/memory-devices/ti-gpmc.rst
+++ b/Documentation/driver-api/memory-devices/ti-gpmc.rst
@@ -14,7 +14,7 @@ memory devices like
  * Pseudo-SRAM devices
 
 GPMC is found on Texas Instruments SoC's (OMAP based)
-IP details: http://www.ti.com/lit/pdf/spruh73 section 7.1
+IP details: https://www.ti.com/lit/pdf/spruh73 section 7.1
 
 
 GPMC generic timing calculation:
diff --git a/Documentation/driver-api/mmc/mmc-tools.rst b/Documentation/driver-api/mmc/mmc-tools.rst
index 54406093768b..a231e9644351 100644
--- a/Documentation/driver-api/mmc/mmc-tools.rst
+++ b/Documentation/driver-api/mmc/mmc-tools.rst
@@ -5,7 +5,7 @@ MMC tools introduction
 There is one MMC test tools called mmc-utils, which is maintained by Chris Ball,
 you can find it at the below public git repository:
 
-	http://git.kernel.org/cgit/linux/kernel/git/cjb/mmc-utils.git/
+	https://git.kernel.org/cgit/linux/kernel/git/cjb/mmc-utils.git/
 
 Functions
 =========
diff --git a/Documentation/driver-api/nvdimm/nvdimm.rst b/Documentation/driver-api/nvdimm/nvdimm.rst
index 79c0fd39f2af..e1bf4130cdfc 100644
--- a/Documentation/driver-api/nvdimm/nvdimm.rst
+++ b/Documentation/driver-api/nvdimm/nvdimm.rst
@@ -113,13 +113,13 @@ Supporting Documents
 --------------------
 
 ACPI 6:
-	http://www.uefi.org/sites/default/files/resources/ACPI_6.0.pdf
+	https://www.uefi.org/sites/default/files/resources/ACPI_6.0.pdf
 NVDIMM Namespace:
-	http://pmem.io/documents/NVDIMM_Namespace_Spec.pdf
+	https://pmem.io/documents/NVDIMM_Namespace_Spec.pdf
 DSM Interface Example:
-	http://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
+	https://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
 Driver Writer's Guide:
-	http://pmem.io/documents/NVDIMM_Driver_Writers_Guide.pdf
+	https://pmem.io/documents/NVDIMM_Driver_Writers_Guide.pdf
 
 Git Trees
 ---------
@@ -778,7 +778,7 @@ Why the Term "namespace"?
 
     2. The term originated to describe the sub-devices that can be created
        within a NVME controller (see the nvme specification:
-       http://www.nvmexpress.org/specifications/), and NFIT namespaces are
+       https://www.nvmexpress.org/specifications/), and NFIT namespaces are
        meant to parallel the capabilities and configurability of
        NVME-namespaces.
 
@@ -786,7 +786,7 @@ Why the Term "namespace"?
 LIBNVDIMM/LIBNDCTL: Block Translation Table "btt"
 -------------------------------------------------
 
-A BTT (design document: http://pmem.io/2014/09/23/btt.html) is a stacked
+A BTT (design document: https://pmem.io/2014/09/23/btt.html) is a stacked
 block device driver that fronts either the whole block device or a
 partition of a block device emitted by either a PMEM or BLK NAMESPACE.
 
diff --git a/Documentation/driver-api/nvdimm/security.rst b/Documentation/driver-api/nvdimm/security.rst
index ad9dea099b34..7aab71524116 100644
--- a/Documentation/driver-api/nvdimm/security.rst
+++ b/Documentation/driver-api/nvdimm/security.rst
@@ -138,6 +138,6 @@ another encrypted-key.
 This command is only available when the master security is enabled, indicated
 by the extended security status.
 
-[1]: http://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf
+[1]: https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf
 
 [2]: http://www.t13.org/documents/UploadedDocuments/docs2006/e05179r4-ACS-SecurityClarifications.pdf
diff --git a/Documentation/driver-api/rapidio/rapidio.rst b/Documentation/driver-api/rapidio/rapidio.rst
index fb8942d3ba85..74c552ad3eb8 100644
--- a/Documentation/driver-api/rapidio/rapidio.rst
+++ b/Documentation/driver-api/rapidio/rapidio.rst
@@ -356,7 +356,7 @@ NOTE:
     http://www.rapidio.org/education/technology_comparisons/
 
 [3] RapidIO support for Linux.
-    http://lwn.net/Articles/139118/
+    https://lwn.net/Articles/139118/
 
 [4] Matt Porter. RapidIO for Linux. Ottawa Linux Symposium, 2005
-    http://www.kernel.org/doc/ols/2005/ols2005v2-pages-43-56.pdf
+    https://www.kernel.org/doc/ols/2005/ols2005v2-pages-43-56.pdf
diff --git a/Documentation/driver-api/thermal/nouveau_thermal.rst b/Documentation/driver-api/thermal/nouveau_thermal.rst
index 37255fd6735d..79ece266cf6d 100644
--- a/Documentation/driver-api/thermal/nouveau_thermal.rst
+++ b/Documentation/driver-api/thermal/nouveau_thermal.rst
@@ -93,4 +93,4 @@ Thermal management on Nouveau is new and may not work on all cards. If you have
 inquiries, please ping mupuf on IRC (#nouveau, freenode).
 
 Bug reports should be filled on Freedesktop's bug tracker. Please follow
-http://nouveau.freedesktop.org/wiki/Bugs
+https://nouveau.freedesktop.org/wiki/Bugs
diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 0b3d9ff221bb..2176297e5765 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -318,6 +318,6 @@ linux-usb Mailing List Archives:
 https://lore.kernel.org/linux-usb/
 
 Programming Guide for Linux USB Device Drivers:
-http://lmu.web.psi.ch/docu/manuals/software_manuals/linux_sl/usb_linux_programming_guide.pdf
+https://lmu.web.psi.ch/docu/manuals/software_manuals/linux_sl/usb_linux_programming_guide.pdf
 
-USB Home Page: http://www.usb.org
+USB Home Page: https://www.usb.org
-- 
2.27.0

