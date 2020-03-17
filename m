Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FC5C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414542073E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584456888;
	bh=lCdLEJ5w0ZRwfZb7Xc7NwaWoCZT37OUHOWlWSj57v6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=asd1pYKAR0C9lHrtFuFb9jTF3DbIDjxPbu3tJVIl5lOD7/e18oAQk6WB2WUTVmbmr
	 fc5aa/EhOHQvzJ1JisV2nsRewpKKGG7xm0u7qhkxzzDENjzlr1D1CTM59vaPlcq/Pm
	 xtTalUhgEmCumuAM1ZfRDoC1QLKMVqW0zTQzXc6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgCQOyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:54:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbgCQOyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:54:31 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5254620735;
        Tue, 17 Mar 2020 14:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584456870;
        bh=lCdLEJ5w0ZRwfZb7Xc7NwaWoCZT37OUHOWlWSj57v6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Djw9jFOmPVxugYNlt7C0HBMWT+aNtPhjpQIY7HubEC1HmKNR2QVXCfav5TZcdI21d
         MHQRonO5QctE4EIaQ93hoVZIqzEuDSKIFY7/q11VB9V+nNIYRpm4RTp3qnuOEHeme/
         iaJDADaRIHzNun8GSiXS2ZcLmFAmkQl8YUKWsR/o=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEDbw-000AML-CZ; Tue, 17 Mar 2020 15:54:28 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/17] docs: arm64: booting.rst: get rid of some warnings
Date:   Tue, 17 Mar 2020 15:54:11 +0100
Message-Id: <7f4f13e03c2d0c5a30db4eb209eaa5aef339de94.1584456635.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584456635.git.mchehab+huawei@kernel.org>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of those warnings:

    Documentation/arm64/booting.rst:253: WARNING: Unexpected indentation.
    Documentation/arm64/booting.rst:259: WARNING: Block quote ends without a blank line; unexpected unindent.

By adding an extra blank lines where needed.

While here, use list markups on some places, as otherwise Sphinx
will consider the next lines as continuation of the privious ones.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/arm64/booting.rst | 36 ++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
index a3f1a47b6f1c..e50186092948 100644
--- a/Documentation/arm64/booting.rst
+++ b/Documentation/arm64/booting.rst
@@ -173,7 +173,9 @@ Before jumping into the kernel, the following conditions must be met:
 - Caches, MMUs
 
   The MMU must be off.
+
   Instruction cache may be on or off.
+
   The address range corresponding to the loaded kernel image must be
   cleaned to the PoC. In the presence of a system cache or other
   coherent masters with caches enabled, this will typically require
@@ -238,6 +240,7 @@ Before jumping into the kernel, the following conditions must be met:
   - The DT or ACPI tables must describe a GICv2 interrupt controller.
 
   For CPUs with pointer authentication functionality:
+
   - If EL3 is present:
 
     - SCR_EL3.APK (bit 16) must be initialised to 0b1
@@ -249,18 +252,22 @@ Before jumping into the kernel, the following conditions must be met:
     - HCR_EL2.API (bit 41) must be initialised to 0b1
 
   For CPUs with Activity Monitors Unit v1 (AMUv1) extension present:
+
   - If EL3 is present:
-    CPTR_EL3.TAM (bit 30) must be initialised to 0b0
-    CPTR_EL2.TAM (bit 30) must be initialised to 0b0
-    AMCNTENSET0_EL0 must be initialised to 0b1111
-    AMCNTENSET1_EL0 must be initialised to a platform specific value
-    having 0b1 set for the corresponding bit for each of the auxiliary
-    counters present.
+
+    - CPTR_EL3.TAM (bit 30) must be initialised to 0b0
+    - CPTR_EL2.TAM (bit 30) must be initialised to 0b0
+    - AMCNTENSET0_EL0 must be initialised to 0b1111
+    - AMCNTENSET1_EL0 must be initialised to a platform specific value
+      having 0b1 set for the corresponding bit for each of the auxiliary
+      counters present.
+
   - If the kernel is entered at EL1:
-    AMCNTENSET0_EL0 must be initialised to 0b1111
-    AMCNTENSET1_EL0 must be initialised to a platform specific value
-    having 0b1 set for the corresponding bit for each of the auxiliary
-    counters present.
+
+    - AMCNTENSET0_EL0 must be initialised to 0b1111
+    - AMCNTENSET1_EL0 must be initialised to a platform specific value
+      having 0b1 set for the corresponding bit for each of the auxiliary
+      counters present.
 
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
@@ -304,7 +311,8 @@ following manner:
   Documentation/devicetree/bindings/arm/psci.yaml.
 
 - Secondary CPU general-purpose register settings
-  x0 = 0 (reserved for future use)
-  x1 = 0 (reserved for future use)
-  x2 = 0 (reserved for future use)
-  x3 = 0 (reserved for future use)
+
+  - x0 = 0 (reserved for future use)
+  - x1 = 0 (reserved for future use)
+  - x2 = 0 (reserved for future use)
+  - x3 = 0 (reserved for future use)
-- 
2.24.1

