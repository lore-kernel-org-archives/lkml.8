Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B46C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 09:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF4A20734
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 09:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgGSJ3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 05:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGSJ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 05:29:40 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193F8C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 02:29:40 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 9D8F4BC053;
        Sun, 19 Jul 2020 09:29:33 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     linux@armlinux.org.uk, arnd@arndb.de, linus.walleij@linaro.org,
        vincenzo.frascino@arm.com, f.fainelli@gmail.com,
        bgolaszewski@baylibre.com, sboyd@kernel.org,
        geert+renesas@glider.be, gregory.0xf0@gmail.com,
        masahiroy@kernel.org, ndesaulniers@google.com, rppt@linux.ibm.com,
        akpm@linux-foundation.org, nico@fluxnic.net, stefan@agner.ch,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH for v5.9] ARM: Replace HTTP links with HTTPS ones
Date:   Sun, 19 Jul 2020 11:29:27 +0200
Message-Id: <20200719092927.57346-1-grandmaster@al2klimov.de>
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


 arch/arm/Kconfig             | 4 ++--
 arch/arm/mach-sa1100/Kconfig | 2 +-
 arch/arm/mm/proc-xscale.S    | 2 +-
 arch/arm/tools/mach-types    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2ac74904a3ce..ce71c15fbc0e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -127,7 +127,7 @@ config ARM
 	  handhelds such as the Compaq IPAQ.  ARM-based PCs are no longer
 	  manufactured, but legacy ARM-based PC hardware remains popular in
 	  Europe.  There is an ARM Linux project with a web page at
-	  <http://www.arm.linux.org.uk/>.
+	  <https://www.arm.linux.org.uk/>.
 
 config ARM_HAS_SG_CHAIN
 	bool
@@ -1199,7 +1199,7 @@ config SMP
 
 	  See also <file:Documentation/x86/i386/IO-APIC.rst>,
 	  <file:Documentation/admin-guide/lockup-watchdogs.rst> and the SMP-HOWTO available at
-	  <http://tldp.org/HOWTO/SMP-HOWTO.html>.
+	  <https://tldp.org/HOWTO/SMP-HOWTO.html>.
 
 	  If you don't know what to do here, say N.
 
diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index 66e79fa9ba2b..f17f0460046b 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -159,7 +159,7 @@ config SA1100_SIMPAD
 	  FLASH. The SL4 version got 64 MB RAM and 32 MB FLASH and a
 	  PCMCIA-Slot. The version for the Germany Telecom (DTAG) is the same
 	  like CL4 in additional it has a PCMCIA-Slot. For more information
-	  visit <http://www.usa.siemens.com/> or <http://www.siemens.ch/>.
+	  visit <https://www.usa.siemens.com/> or <https://www.siemens.ch/>.
 
 config SA1100_SSP
 	tristate "Generic PIO SSP"
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index d82590aa71c0..a5e048ab6f7c 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -425,7 +425,7 @@ ENDPROC(xscale_dma_unmap_area)
  *
  * See erratum #25 of "Intel 80200 Processor Specification Update",
  * revision January 22, 2003, available at:
- *     http://www.intel.com/design/iio/specupdt/273415.htm
+ *     https://www.intel.com/design/iio/specupdt/273415.htm
  */
 .macro a0_alias basename
 	.globl xscale_80200_A0_A1_\basename
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 9e74c7ff6b04..e79be40e38cd 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -4,7 +4,7 @@
 #
 # Up to date versions of this file can be obtained from:
 #
-#   http://www.arm.linux.org.uk/developer/machines/download.php
+#   https://www.arm.linux.org.uk/developer/machines/download.php
 #
 # Please do not send patches to this file; it is automatically generated!
 # To add an entry into this database, please see Documentation/arm/arm.rst,
-- 
2.27.0

