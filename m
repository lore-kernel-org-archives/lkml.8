Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C461C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C9E20672
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgGUTRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:17:42 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:47048 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbgGUTRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:17:41 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 35E0FBC1AB;
        Tue, 21 Jul 2020 19:17:36 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org, mh12gx2825@gmail.com, ejyu99@gmail.com,
        yuehaibing@huawei.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] staging: comedi: ni: Replace HTTP links with HTTPS ones
Date:   Tue, 21 Jul 2020 21:17:29 +0200
Message-Id: <20200721191729.67847-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
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
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 drivers/staging/comedi/drivers/ni_6527.c         | 2 +-
 drivers/staging/comedi/drivers/ni_65xx.c         | 2 +-
 drivers/staging/comedi/drivers/ni_660x.c         | 2 +-
 drivers/staging/comedi/drivers/ni_670x.c         | 2 +-
 drivers/staging/comedi/drivers/ni_at_a2150.c     | 2 +-
 drivers/staging/comedi/drivers/ni_at_ao.c        | 2 +-
 drivers/staging/comedi/drivers/ni_atmio.c        | 2 +-
 drivers/staging/comedi/drivers/ni_atmio16d.c     | 2 +-
 drivers/staging/comedi/drivers/ni_daq_700.c      | 4 ++--
 drivers/staging/comedi/drivers/ni_labpc.c        | 4 ++--
 drivers/staging/comedi/drivers/ni_labpc_common.c | 2 +-
 drivers/staging/comedi/drivers/ni_labpc_isadma.c | 2 +-
 drivers/staging/comedi/drivers/ni_labpc_pci.c    | 2 +-
 drivers/staging/comedi/drivers/ni_pcidio.c       | 4 ++--
 drivers/staging/comedi/drivers/ni_pcimio.c       | 2 +-
 drivers/staging/comedi/drivers/ni_routes.c       | 2 +-
 drivers/staging/comedi/drivers/ni_usb6501.c      | 2 +-
 17 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/comedi/drivers/ni_6527.c b/drivers/staging/comedi/drivers/ni_6527.c
index 4d1eccb5041d..ba7f40b46c3a 100644
--- a/drivers/staging/comedi/drivers/ni_6527.c
+++ b/drivers/staging/comedi/drivers/ni_6527.c
@@ -486,6 +486,6 @@ static struct pci_driver ni6527_pci_driver = {
 };
 module_comedi_pci_driver(ni6527_driver, ni6527_pci_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi driver for National Instruments PCI-6527");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/ni_65xx.c b/drivers/staging/comedi/drivers/ni_65xx.c
index 996074e471d3..eb3f9f7109da 100644
--- a/drivers/staging/comedi/drivers/ni_65xx.c
+++ b/drivers/staging/comedi/drivers/ni_65xx.c
@@ -817,6 +817,6 @@ static struct pci_driver ni_65xx_pci_driver = {
 };
 module_comedi_pci_driver(ni_65xx_driver, ni_65xx_pci_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi driver for NI PCI-65xx static dio boards");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/ni_660x.c b/drivers/staging/comedi/drivers/ni_660x.c
index 75d5c9c24596..e60d0125bcb2 100644
--- a/drivers/staging/comedi/drivers/ni_660x.c
+++ b/drivers/staging/comedi/drivers/ni_660x.c
@@ -1250,6 +1250,6 @@ static struct pci_driver ni_660x_pci_driver = {
 };
 module_comedi_pci_driver(ni_660x_driver, ni_660x_pci_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi driver for NI 660x counter/timer boards");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/ni_670x.c b/drivers/staging/comedi/drivers/ni_670x.c
index 4e4ae31c8d0b..c197e47486be 100644
--- a/drivers/staging/comedi/drivers/ni_670x.c
+++ b/drivers/staging/comedi/drivers/ni_670x.c
@@ -277,6 +277,6 @@ static struct pci_driver ni_670x_pci_driver = {
 };
 module_comedi_pci_driver(ni_670x_driver, ni_670x_pci_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi low-level driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/ni_at_a2150.c b/drivers/staging/comedi/drivers/ni_at_a2150.c
index 76e8d047f71e..10ad7b88713e 100644
--- a/drivers/staging/comedi/drivers/ni_at_a2150.c
+++ b/drivers/staging/comedi/drivers/ni_at_a2150.c
@@ -777,6 +777,6 @@ static struct comedi_driver ni_at_a2150_driver = {
 };
 module_comedi_driver(ni_at_a2150_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi low-level driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/ni_at_ao.c b/drivers/staging/comedi/drivers/ni_at_ao.c
index 814895d01ffa..2a0fb4d460db 100644
--- a/drivers/staging/comedi/drivers/ni_at_ao.c
+++ b/drivers/staging/comedi/drivers/ni_at_ao.c
@@ -369,6 +369,6 @@ static struct comedi_driver ni_at_ao_driver = {
 };
 module_comedi_driver(ni_at_ao_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi driver for NI AT-AO-6/10 boards");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/ni_atmio.c b/drivers/staging/comedi/drivers/ni_atmio.c
index 2b7bfe0dd7f3..56c78da475e7 100644
--- a/drivers/staging/comedi/drivers/ni_atmio.c
+++ b/drivers/staging/comedi/drivers/ni_atmio.c
@@ -354,7 +354,7 @@ static struct comedi_driver ni_atmio_driver = {
 };
 module_comedi_driver(ni_atmio_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi low-level driver");
 MODULE_LICENSE("GPL");
 
diff --git a/drivers/staging/comedi/drivers/ni_atmio16d.c b/drivers/staging/comedi/drivers/ni_atmio16d.c
index 0bca7d752015..dffce1aa3e69 100644
--- a/drivers/staging/comedi/drivers/ni_atmio16d.c
+++ b/drivers/staging/comedi/drivers/ni_atmio16d.c
@@ -724,6 +724,6 @@ static struct comedi_driver atmio16d_driver = {
 };
 module_comedi_driver(atmio16d_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi low-level driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/ni_daq_700.c b/drivers/staging/comedi/drivers/ni_daq_700.c
index 81fd4c26a16f..d40fc89f9cef 100644
--- a/drivers/staging/comedi/drivers/ni_daq_700.c
+++ b/drivers/staging/comedi/drivers/ni_daq_700.c
@@ -34,8 +34,8 @@
  *
  * IRQ is assigned but not used.
  *
- * Manuals:	Register level:	http://www.ni.com/pdf/manuals/340698.pdf
- *		User Manual:	http://www.ni.com/pdf/manuals/320676d.pdf
+ * Manuals:	Register level:	https://www.ni.com/pdf/manuals/340698.pdf
+ *		User Manual:	https://www.ni.com/pdf/manuals/320676d.pdf
  */
 
 #include <linux/module.h>
diff --git a/drivers/staging/comedi/drivers/ni_labpc.c b/drivers/staging/comedi/drivers/ni_labpc.c
index c6cf37ccbc92..1f4a07bd1d26 100644
--- a/drivers/staging/comedi/drivers/ni_labpc.c
+++ b/drivers/staging/comedi/drivers/ni_labpc.c
@@ -27,7 +27,7 @@
  * Kernel-level ISA plug-and-play support for the lab-pc-1200 boards
  * has not yet been added to the driver, mainly due to the fact that
  * I don't know the device id numbers. If you have one of these boards,
- * please file a bug report at http://comedi.org/ so I can get the
+ * please file a bug report at https://comedi.org/ so I can get the
  * necessary information from you.
  *
  * The 1200 series boards have onboard calibration dacs for correcting
@@ -111,6 +111,6 @@ static struct comedi_driver labpc_driver = {
 };
 module_comedi_driver(labpc_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi driver for NI Lab-PC ISA boards");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/ni_labpc_common.c b/drivers/staging/comedi/drivers/ni_labpc_common.c
index ce0f85026277..dd97946eacaf 100644
--- a/drivers/staging/comedi/drivers/ni_labpc_common.c
+++ b/drivers/staging/comedi/drivers/ni_labpc_common.c
@@ -1358,6 +1358,6 @@ static void __exit labpc_common_exit(void)
 }
 module_exit(labpc_common_exit);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi helper for ni_labpc, ni_labpc_pci, ni_labpc_cs");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/ni_labpc_isadma.c b/drivers/staging/comedi/drivers/ni_labpc_isadma.c
index 5657736a9408..a551aca6e615 100644
--- a/drivers/staging/comedi/drivers/ni_labpc_isadma.c
+++ b/drivers/staging/comedi/drivers/ni_labpc_isadma.c
@@ -176,6 +176,6 @@ static void __exit ni_labpc_isadma_cleanup_module(void)
 }
 module_exit(ni_labpc_isadma_cleanup_module);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi NI Lab-PC ISA DMA support");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/ni_labpc_pci.c b/drivers/staging/comedi/drivers/ni_labpc_pci.c
index d7d5a7973558..ec180b0fedf7 100644
--- a/drivers/staging/comedi/drivers/ni_labpc_pci.c
+++ b/drivers/staging/comedi/drivers/ni_labpc_pci.c
@@ -128,5 +128,5 @@ static struct pci_driver labpc_pci_driver = {
 module_comedi_pci_driver(labpc_pci_comedi_driver, labpc_pci_driver);
 
 MODULE_DESCRIPTION("Comedi: National Instruments Lab-PC PCI-1200 driver");
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/ni_pcidio.c b/drivers/staging/comedi/drivers/ni_pcidio.c
index 8f3864799c19..623f8d08d13a 100644
--- a/drivers/staging/comedi/drivers/ni_pcidio.c
+++ b/drivers/staging/comedi/drivers/ni_pcidio.c
@@ -33,7 +33,7 @@
  * The PCI-6534 requires a firmware upload after power-up to work, the
  * firmware data and instructions for loading it with comedi_config
  * it are contained in the comedi_nonfree_firmware tarball available from
- * http://www.comedi.org
+ * https://www.comedi.org
  */
 
 #define USE_DMA
@@ -1005,6 +1005,6 @@ static struct pci_driver ni_pcidio_pci_driver = {
 };
 module_comedi_pci_driver(ni_pcidio_driver, ni_pcidio_pci_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi low-level driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/ni_pcimio.c b/drivers/staging/comedi/drivers/ni_pcimio.c
index c1d70eec24ab..6c813a490ba5 100644
--- a/drivers/staging/comedi/drivers/ni_pcimio.c
+++ b/drivers/staging/comedi/drivers/ni_pcimio.c
@@ -1472,6 +1472,6 @@ static struct pci_driver ni_pcimio_pci_driver = {
 };
 module_comedi_pci_driver(ni_pcimio_driver, ni_pcimio_pci_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi low-level driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/ni_routes.c b/drivers/staging/comedi/drivers/ni_routes.c
index 07cb970340db..c426a9286f15 100644
--- a/drivers/staging/comedi/drivers/ni_routes.c
+++ b/drivers/staging/comedi/drivers/ni_routes.c
@@ -556,7 +556,7 @@ static void __exit ni_routes_module_exit(void)
 module_init(ni_routes_module_init);
 module_exit(ni_routes_module_exit);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi helper for routing signals-->terminals for NI");
 MODULE_LICENSE("GPL");
 /* **** END simple module entry/exit functions **** */
diff --git a/drivers/staging/comedi/drivers/ni_usb6501.c b/drivers/staging/comedi/drivers/ni_usb6501.c
index 360e86a19fe3..5b6d9d783b2f 100644
--- a/drivers/staging/comedi/drivers/ni_usb6501.c
+++ b/drivers/staging/comedi/drivers/ni_usb6501.c
@@ -79,7 +79,7 @@
  *	RES: 00 01 00 0C 00 08 01 00 00 00 00 02
  *
  *
- *	Please  visit http://www.brickedbrain.com if you need
+ *	Please  visit https://www.brickedbrain.com if you need
  *	additional information or have any questions.
  *
  */
-- 
2.27.0

