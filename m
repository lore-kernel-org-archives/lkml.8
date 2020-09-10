Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D1CC2D0A8
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 048512087C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgIJCbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:31:18 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:61662 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730394AbgIJC2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:28:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 171BA40CA0;
        Thu, 10 Sep 2020 02:33:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1599698028; x=1601512429;
         bh=u0tD/dQH0K/+AzVwj70GEe2tWdob7q7dwNloaWvlhVY=; b=aQ6yzIdbg1gp
        K96lG7iDSjUR1MhDqBQ8aSdxVtIiF9G33RYYrDrsxI6VvOXMcdDFAD+2XBB3cz5p
        tUcOKSGXdgVMltc7Yi7LtdTnj7QktgwE2tOosBnS82YiWykz9rz4+4lAurhbtIBd
        hv3xiFfB6xnj/eA6Pu+lSph4jHFTKrb0c8FVl3TkTYoJzIQ1FnP+02c8K4tXlWVX
        kUQ+AhuXJT6K01Wv8ZaEVnBHEI64eBBiiecaJKE8mPG/OY5+hB8X3Wrt6ecUHp+c
        oCvDOOLHQ3/wwGpkz5GY6ndowiBKUMh5VBrnn0MlrK9U6GpUrSj+sWzLgN+arVja
        iPGei3U4AUGSm070yVOSuX2xFEyR6WtE0kZiFVVVKkvLh0VhYw48jxkTLuF24QQ0
        lZlYV06NJEoVSsvm6fbUmdPOUSD6YhZ49/yOtmFUq/Xc9/RLmrcSTHoAbJs24FzB
        jLKuXGuT34wTpvWVxvwA2HOosFvF+W74C+jCy25qXKGrtIqLxLxmuGw0oP/15o2E
        xsqdt2bYLfIkIa2Opfi3p6eg5Mhs6MU3pxmLBFF7lvmfJVJ16YDfF+CFuXeSVMIx
        dhgtQi1xCyKfSXzgixsczX/FKv8c9Hq1nRdjNeWbpUcJyVlAefF/E+tGwEjESS51
        SvwzhMf7xzMZiCkCN7+JqB/zYsnPPCk=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ib7Uh48itTmi; Thu, 10 Sep 2020 02:33:48 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 700E740A9B;
        Thu, 10 Sep 2020 02:33:48 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 08B5B2366;
        Thu, 10 Sep 2020 02:33:48 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc: fix file references
Date:   Thu, 10 Sep 2020 02:33:37 +0200
Message-Id: <20200910003337.9745-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch generated with

    ./scripts/documentation-file-ref-check --fix

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 .../bindings/display/tilcdc/tilcdc.txt           |  2 +-
 .../devicetree/bindings/media/i2c/tvp5150.txt    |  2 +-
 .../bindings/soc/qcom/qcom,smd-rpm.yaml          |  2 +-
 Documentation/scheduler/sched-capacity.rst       |  2 +-
 Documentation/scheduler/sched-energy.rst         |  2 +-
 Documentation/trace/kprobetrace.rst              |  2 +-
 MAINTAINERS                                      | 16 ++++++++--------
 drivers/net/appletalk/Kconfig                    |  2 +-
 drivers/net/hamradio/scc.c                       |  2 +-
 .../bindings/net/wireless/siliabs,wfx.txt        |  2 +-
 init/Kconfig                                     |  2 +-
 mm/Kconfig                                       |  2 +-
 mm/nommu.c                                       |  2 +-
 samples/kprobes/kprobe_example.c                 |  2 +-
 samples/kprobes/kretprobe_example.c              |  2 +-
 scripts/coccinelle/api/device_attr_show.cocci    |  2 +-
 16 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt b/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
index 8b2a71395647..3e64075ac7ec 100644
--- a/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
+++ b/Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt
@@ -37,7 +37,7 @@ Optional nodes:
    supports a single port with a single endpoint.
 
  - See also Documentation/devicetree/bindings/display/tilcdc/panel.txt and
-   Documentation/devicetree/bindings/display/bridge/ti,tfp410.txt for connecting
+   Documentation/devicetree/bindings/display/bridge/ti,tfp410.yaml for connecting
    tfp410 DVI encoder or lcd panel to lcdc
 
 [1] There is an errata about AM335x color wiring. For 16-bit color mode
diff --git a/Documentation/devicetree/bindings/media/i2c/tvp5150.txt b/Documentation/devicetree/bindings/media/i2c/tvp5150.txt
index 6c88ce858d08..719b2995dc17 100644
--- a/Documentation/devicetree/bindings/media/i2c/tvp5150.txt
+++ b/Documentation/devicetree/bindings/media/i2c/tvp5150.txt
@@ -56,7 +56,7 @@ Optional Connector Properties:
                   instead of using the autodetection mechnism. Please look at
                   [1] for more information.
 
-[1] Documentation/devicetree/bindings/display/connector/analog-tv-connector.txt.
+[1] Documentation/devicetree/bindings/display/connector/analog-tv-connector.yaml.
 
 Example - three input sources:
 #include <dt-bindings/display/sdtv-standards.h>
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index 468d658ce3e7..2684f22a1d85 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -20,7 +20,7 @@ description: |
   present and this subnode may contain children that designate regulator
   resources.
 
-  Refer to Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
+  Refer to Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
   for information on the regulator subnodes that can exist under the
   rpm_requests.
 
diff --git a/Documentation/scheduler/sched-capacity.rst b/Documentation/scheduler/sched-capacity.rst
index 00bf0d011e2a..9b7cbe43b2d1 100644
--- a/Documentation/scheduler/sched-capacity.rst
+++ b/Documentation/scheduler/sched-capacity.rst
@@ -365,7 +365,7 @@ giving it a high uclamp.min value.
 .. note::
 
   Wakeup CPU selection in CFS can be eclipsed by Energy Aware Scheduling
-  (EAS), which is described in Documentation/scheduling/sched-energy.rst.
+  (EAS), which is described in Documentation/scheduler/sched-energy.rst.
 
 5.1.3 Load balancing
 ~~~~~~~~~~~~~~~~~~~~
diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
index 78f850778982..001e09c95e1d 100644
--- a/Documentation/scheduler/sched-energy.rst
+++ b/Documentation/scheduler/sched-energy.rst
@@ -331,7 +331,7 @@ asymmetric CPU topologies for now. This requirement is checked at run-time by
 looking for the presence of the SD_ASYM_CPUCAPACITY flag when the scheduling
 domains are built.
 
-See Documentation/sched/sched-capacity.rst for requirements to be met for this
+See Documentation/scheduler/sched-capacity.rst for requirements to be met for this
 flag to be set in the sched_domain hierarchy.
 
 Please note that EAS is not fundamentally incompatible with SMP, but no
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index c1709165c553..10850a9e9af3 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -40,7 +40,7 @@ Synopsis of kprobe_events
  MEMADDR	: Address where the probe is inserted.
  MAXACTIVE	: Maximum number of instances of the specified function that
 		  can be probed simultaneously, or 0 for the default value
-		  as defined in Documentation/staging/kprobes.rst section 1.3.1.
+		  as defined in Documentation/trace/kprobes.rst section 1.3.1.
 
  FETCHARGS	: Arguments. Each probe can have up to 128 args.
   %REG		: Fetch register REG
diff --git a/MAINTAINERS b/MAINTAINERS
index dfffa1f534fa..7f4630828c41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1523,7 +1523,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/actions.yaml
 F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
-F:	Documentation/devicetree/bindings/dma/owl-dma.txt
+F:	Documentation/devicetree/bindings/dma/owl-dma.yaml
 F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt
 F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
@@ -5567,7 +5567,7 @@ DRM DRIVER FOR ROCKTECH JH057N00900 PANELS
 M:	Guido Günther <agx@sigxcpu.org>
 R:	Purism Kernel Team <kernel@puri.sm>
 S:	Maintained
-F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.txt
+F:	Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
 F:	drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
 
 DRM DRIVER FOR SAVAGE VIDEO CARDS
@@ -5815,7 +5815,7 @@ L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
 T:	git git://linuxtv.org/pinchartl/media drm/du/next
 F:	Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
-F:	Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
+F:	Documentation/devicetree/bindings/display/bridge/renesas,lvds.yaml
 F:	Documentation/devicetree/bindings/display/renesas,du.txt
 F:	drivers/gpu/drm/rcar-du/
 F:	drivers/gpu/drm/shmobile/
@@ -6942,7 +6942,7 @@ M:	Oleksij Rempel <o.rempel@pengutronix.de>
 R:	Pengutronix Kernel Team <kernel@pengutronix.de>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/i2c/i2c-imx.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-imx.yaml
 F:	drivers/i2c/busses/i2c-imx.c
 
 FREESCALE IMX LPI2C DRIVER
@@ -6950,7 +6950,7 @@ M:	Dong Aisheng <aisheng.dong@nxp.com>
 L:	linux-i2c@vger.kernel.org
 L:	linux-imx@nxp.com
 S:	Maintained
-F:	Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
 F:	drivers/i2c/busses/i2c-imx-lpi2c.c
 
 FREESCALE QORIQ DPAA ETHERNET DRIVER
@@ -11581,7 +11581,7 @@ MIPS GENERIC PLATFORM
 M:	Paul Burton <paulburton@kernel.org>
 L:	linux-mips@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/power/mti,mips-cpc.txt
+F:	Documentation/devicetree/bindings/power/mti,mips-cpc.yaml
 F:	arch/mips/generic/
 F:	arch/mips/tools/generic-board-config.sh
 
@@ -12435,7 +12435,7 @@ NXP SGTL5000 DRIVER
 M:	Fabio Estevam <festevam@gmail.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/sound/sgtl5000.txt
+F:	Documentation/devicetree/bindings/sound/sgtl5000.yaml
 F:	sound/soc/codecs/sgtl5000*
 
 NXP SJA1105 ETHERNET SWITCH DRIVER
@@ -14208,7 +14208,7 @@ QLOGIC QLA3XXX NETWORK DRIVER
 M:	GR-Linux-NIC-Dev@marvell.com
 L:	netdev@vger.kernel.org
 S:	Supported
-F:	Documentation/networking/device_drivers/ethernet/qlogic/LICENSE.qla3xxx
+F:	Documentation/networking/device_drivers/qlogic/LICENSE.qla3xxx
 F:	drivers/net/ethernet/qlogic/qla3xxx.*
 
 QLOGIC QLA4XXX iSCSI DRIVER
diff --git a/drivers/net/appletalk/Kconfig b/drivers/net/appletalk/Kconfig
index d4f22a2e5be4..43918398f0d3 100644
--- a/drivers/net/appletalk/Kconfig
+++ b/drivers/net/appletalk/Kconfig
@@ -48,7 +48,7 @@ config LTPC
 	  If you are in doubt, this card is the one with the 65C02 chip on it.
 	  You also need version 1.3.3 or later of the netatalk package.
 	  This driver is experimental, which means that it may not work.
-	  See the file <file:Documentation/networking/ltpc.rst>.
+	  See the file <file:Documentation/networking/device_drivers/appletalk/ltpc.rst>.
 
 config COPS
 	tristate "COPS LocalTalk PC support"
diff --git a/drivers/net/hamradio/scc.c b/drivers/net/hamradio/scc.c
index 1e915871baa7..36eeb80406f2 100644
--- a/drivers/net/hamradio/scc.c
+++ b/drivers/net/hamradio/scc.c
@@ -7,7 +7,7 @@
  *            ------------------
  *
  * You can find a subset of the documentation in 
- * Documentation/networking/device_drivers/wan/z8530drv.rst.
+ * Documentation/networking/device_drivers/hamradio/z8530drv.rst.
  */
 
 /*
diff --git a/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt b/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt
index 17db67559f5e..362af9f0b7e3 100644
--- a/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt
+++ b/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt
@@ -51,7 +51,7 @@ Required properties:
 In addition, it is recommended to declare a mmc-pwrseq on SDIO host above WFx.
 Without it, you may encounter issues with warm boot. mmc-pwrseq should be
 compatible with mmc-pwrseq-simple. Please consult
-Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt for more
+Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml for more
 information.
 
 Example:
diff --git a/init/Kconfig b/init/Kconfig
index d6a0b31b13dc..c0f56e455dce 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1986,7 +1986,7 @@ config MMAP_ALLOW_UNINITIALIZED
 	  userspace.  Since that isn't generally a problem on no-MMU systems,
 	  it is normally safe to say Y here.
 
-	  See Documentation/mm/nommu-mmap.rst for more information.
+	  See Documentation/admin-guide/mm/nommu-mmap.rst for more information.
 
 config SYSTEM_DATA_VERIFICATION
 	def_bool n
diff --git a/mm/Kconfig b/mm/Kconfig
index 6c974888f86f..e3ee7b32c637 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -383,7 +383,7 @@ config NOMMU_INITIAL_TRIM_EXCESS
 	  This option specifies the initial value of this option.  The default
 	  of 1 says that all excess pages should be trimmed.
 
-	  See Documentation/mm/nommu-mmap.rst for more information.
+	  See Documentation/admin-guide/mm/nommu-mmap.rst for more information.
 
 config TRANSPARENT_HUGEPAGE
 	bool "Transparent Hugepage Support"
diff --git a/mm/nommu.c b/mm/nommu.c
index 75a327149af1..0df7ca321314 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -5,7 +5,7 @@
  *  Replacement code for mm functions to support CPU's that don't
  *  have any form of memory management unit (thus no virtual memory).
  *
- *  See Documentation/mm/nommu-mmap.rst
+ *  See Documentation/admin-guide/mm/nommu-mmap.rst
  *
  *  Copyright (c) 2004-2008 David Howells <dhowells@redhat.com>
  *  Copyright (c) 2000-2003 David McCullough <davidm@snapgear.com>
diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index 240f2435ce6f..8b718943d603 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -5,7 +5,7 @@
  * stack trace and selected registers when _do_fork() is called.
  *
  * For more information on theory of operation of kprobes, see
- * Documentation/staging/kprobes.rst
+ * Documentation/trace/kprobes.rst
  *
  * You will see the trace data in /var/log/messages and on the console
  * whenever _do_fork() is invoked to create a new process.
diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
index 78a2da6fb3cd..69fd1235108a 100644
--- a/samples/kprobes/kretprobe_example.c
+++ b/samples/kprobes/kretprobe_example.c
@@ -11,7 +11,7 @@
  * If no func_name is specified, _do_fork is instrumented
  *
  * For more information on theory of operation of kretprobes, see
- * Documentation/staging/kprobes.rst
+ * Documentation/trace/kprobes.rst
  *
  * Build and insert the kernel module as done in the kprobe example.
  * You will see the trace data in /var/log/messages and on the console
diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
index d8ec4bb8ac41..a28dc061653a 100644
--- a/scripts/coccinelle/api/device_attr_show.cocci
+++ b/scripts/coccinelle/api/device_attr_show.cocci
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 ///
-/// From Documentation/filesystems/sysfs.txt:
+/// From Documentation/filesystems/sysfs.rst:
 ///  show() must not use snprintf() when formatting the value to be
 ///  returned to user space. If you can guarantee that an overflow
 ///  will never happen you can use sprintf() otherwise you must use
-- 
2.20.1

