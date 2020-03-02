Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07562C3F2D4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7191246B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583134709;
	bh=aDljDUmpxo5+LqlPw9cl71njG/iu1AXa0I0vgjceotE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CcnKknxdFJ3pv/DN9bXEA5OvLN5J/5DXCi4bt+6k5h7rr1SxFP32KiFCMTYYNpfZn
	 fO4WztkdsqTakBEN1AHBg5AWd27V0RXPCSyZow5POuvgXxoW+srWDRGWNSzN7/dIOK
	 5gL1FC38PrGYF8EsXyYTFYBZT+5EuMyDgT3OQ9Jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCBHiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:38:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:44754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgCBHiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:38:17 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ED41246B4;
        Mon,  2 Mar 2020 07:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583134694;
        bh=aDljDUmpxo5+LqlPw9cl71njG/iu1AXa0I0vgjceotE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjnK1v3kLtHAyfR6CVm0X1QQjCj5cbJIcZzUtpzGCVRXC6X5F7IPS+gJnNI729Doh
         iyXpKc40SCIIrew5BTlpXf4fybhDkpQbwer3asNH7ohHFJksbXNybBHJvzSZN5hcT1
         28ePbq09Hf8b4d1SUUjZcXkfcYrDYqieAfIkMBVo=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8feV-0003VV-Qz; Mon, 02 Mar 2020 08:38:11 +0100
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 02/12] docs: dt: convert usage-model.txt to ReST
Date:   Mon,  2 Mar 2020 08:37:57 +0100
Message-Id: <0432bc8cdb6abb8618eac89d68db7441b613106d.1583134242.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1583134242.git.mchehab+samsung@kernel.org>
References: <cover.1583134242.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

- Add a SPDX header;
- Adjust document title;
- Use footnoote markups;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to devicetree/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/devicetree/index.rst            |  1 +
 Documentation/devicetree/of_unittest.txt      |  2 +-
 .../{usage-model.txt => usage-model.rst}      | 35 +++++++++++--------
 include/linux/mfd/core.h                      |  2 +-
 4 files changed, 23 insertions(+), 17 deletions(-)
 rename Documentation/devicetree/{usage-model.txt => usage-model.rst} (97%)

diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
index a11efe26f205..7a6aad7d384a 100644
--- a/Documentation/devicetree/index.rst
+++ b/Documentation/devicetree/index.rst
@@ -7,4 +7,5 @@ Open Firmware and Device Tree
 .. toctree::
    :maxdepth: 1
 
+   usage-model
    writing-schema
diff --git a/Documentation/devicetree/of_unittest.txt b/Documentation/devicetree/of_unittest.txt
index 3e4e7d48ae93..9fdd2de9b770 100644
--- a/Documentation/devicetree/of_unittest.txt
+++ b/Documentation/devicetree/of_unittest.txt
@@ -11,7 +11,7 @@ architecture.
 
 It is recommended to read the following documents before moving ahead.
 
-[1] Documentation/devicetree/usage-model.txt
+[1] Documentation/devicetree/usage-model.rst
 [2] http://www.devicetree.org/Device_Tree_Usage
 
 OF Selftest has been designed to test the interface (include/linux/of.h)
diff --git a/Documentation/devicetree/usage-model.txt b/Documentation/devicetree/usage-model.rst
similarity index 97%
rename from Documentation/devicetree/usage-model.txt
rename to Documentation/devicetree/usage-model.rst
index 33a8aaac02a8..326d7af10c5b 100644
--- a/Documentation/devicetree/usage-model.txt
+++ b/Documentation/devicetree/usage-model.rst
@@ -1,14 +1,18 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
 Linux and the Device Tree
--------------------------
+=========================
+
 The Linux usage model for device tree data
 
-Author: Grant Likely <grant.likely@secretlab.ca>
+:Author: Grant Likely <grant.likely@secretlab.ca>
 
 This article describes how Linux uses the device tree.  An overview of
 the device tree data format can be found on the device tree usage page
-at devicetree.org[1].
+at devicetree.org\ [1]_.
 
-[1] http://devicetree.org/Device_Tree_Usage
+.. [1] http://devicetree.org/Device_Tree_Usage
 
 The "Open Firmware Device Tree", or simply Device Tree (DT), is a data
 structure and language for describing hardware.  More specifically, it
@@ -57,7 +61,7 @@ Tree (FDT) was created which could be passed to the kernel as a binary
 blob without requiring a real Open Firmware implementation.  U-Boot,
 kexec, and other bootloaders were modified to support both passing a
 Device Tree Binary (dtb) and to modify a dtb at boot time.  DT was
-also added to the PowerPC boot wrapper (arch/powerpc/boot/*) so that
+also added to the PowerPC boot wrapper (``arch/powerpc/boot/*``) so that
 a dtb could be wrapped up with the kernel image to support booting
 existing non-DT aware firmware.
 
@@ -68,7 +72,7 @@ out of mainline (nios) have some level of DT support.
 
 2. Data Model
 -------------
-If you haven't already read the Device Tree Usage[1] page,
+If you haven't already read the Device Tree Usage\ [1]_ page,
 then go read it now.  It's okay, I'll wait....
 
 2.1 High Level View
@@ -88,6 +92,7 @@ duplication and make it easier to support a wide range of hardware
 with a single kernel image.
 
 Linux uses DT data for three major purposes:
+
 1) platform identification,
 2) runtime configuration, and
 3) device population.
@@ -117,7 +122,7 @@ The 'compatible' property contains a sorted list of strings starting
 with the exact name of the machine, followed by an optional list of
 boards it is compatible with sorted from most compatible to least.  For
 example, the root compatible properties for the TI BeagleBoard and its
-successor, the BeagleBoard xM board might look like, respectively:
+successor, the BeagleBoard xM board might look like, respectively::
 
 	compatible = "ti,omap3-beagleboard", "ti,omap3450", "ti,omap3";
 	compatible = "ti,omap3-beagleboard-xm", "ti,omap3450", "ti,omap3";
@@ -183,7 +188,7 @@ configuration data like the kernel parameters string and the location
 of an initrd image.
 
 Most of this data is contained in the /chosen node, and when booting
-Linux it will look something like this:
+Linux it will look something like this::
 
 	chosen {
 		bootargs = "console=ttyS0,115200 loglevel=8";
@@ -251,9 +256,9 @@ platform devices roughly correspond to device nodes at the root of the
 tree and children of simple memory mapped bus nodes.
 
 About now is a good time to lay out an example.  Here is part of the
-device tree for the NVIDIA Tegra board.
+device tree for the NVIDIA Tegra board::
 
-/{
+  /{
 	compatible = "nvidia,harmony", "nvidia,tegra20";
 	#address-cells = <1>;
 	#size-cells = <1>;
@@ -313,7 +318,7 @@ device tree for the NVIDIA Tegra board.
 		i2s-controller = <&i2s1>;
 		i2s-codec = <&wm8903>;
 	};
-};
+  };
 
 At .init_machine() time, Tegra board support code will need to look at
 this DT and decide which nodes to create platform_devices for.
@@ -379,13 +384,13 @@ device tree support code reflects that and makes the above example
 simpler.  The second argument to of_platform_populate() is an
 of_device_id table, and any node that matches an entry in that table
 will also get its child nodes registered.  In the Tegra case, the code
-can look something like this:
+can look something like this::
 
-static void __init harmony_init_machine(void)
-{
+  static void __init harmony_init_machine(void)
+  {
 	/* ... */
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
+  }
 
 "simple-bus" is defined in the Devicetree Specification as a property
 meaning a simple memory mapped bus, so the of_platform_populate() code
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index d01d1299e49d..21718c8b2b48 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -74,7 +74,7 @@ struct mfd_cell {
 
 	/*
 	 * Device Tree compatible string
-	 * See: Documentation/devicetree/usage-model.txt Chapter 2.2 for details
+	 * See: Documentation/devicetree/usage-model.rst Chapter 2.2 for details
 	 */
 	const char		*of_compatible;
 
-- 
2.21.1

