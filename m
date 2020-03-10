Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2445BC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E957520675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583847821;
	bh=ZbUxE4qmaJpjCh53VNItYQAdXkWgNpvqmaDLJujFXdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rVrDbouMis220PBqhoVHiCiiOHBZVPv7IDJG88q0Hv/8Gtugf4FGadBjqEgkfh0Xe
	 2gDWiG9dtkC4pKKg21lm3hKj1X+1EgV4NCcuysx5xaA3XmqBg+Al9D1apvGR9FkPIE
	 fXmQgUdu0VQ3cHe7IHyuSohdRGIkb9xTamQuwMyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgCJNnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:43:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgCJNnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:43:19 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33E0024696;
        Tue, 10 Mar 2020 13:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583847797;
        bh=ZbUxE4qmaJpjCh53VNItYQAdXkWgNpvqmaDLJujFXdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tq8OGCCRIXbvfhEHXhkYn953gqEza8TALJ2GJfpnJveGJN4kyoVEqw6f1ccbH4ZJO
         O7QSldLPofag3d/2s3Bb8cw83tF6g3SxIr2yw+njqpEEVFGC1MnF9fhOXNXa64nXi6
         p9ZHsukXomOloGVSSU4IvDt7sGgEpwcM/bhY7454=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jBfAB-0005w7-BT; Tue, 10 Mar 2020 14:43:15 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-media@vger.kernel.org
Subject: [PATCH v2 12/22] media: docs: split uAPI info from fimc.rst
Date:   Tue, 10 Mar 2020 14:43:03 +0100
Message-Id: <ecd443e3b29035e1fdd9ebb20a0d8c40ae4cacbb.1583847556.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583847556.git.mchehab+huawei@kernel.org>
References: <cover.1583847556.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file contains both driver develompent documentation and
userspace API.

Split on two, as they're usually read by different audiences.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../media/v4l-drivers/fimc-devel.rst          | 33 +++++++++++++++++++
 Documentation/media/v4l-drivers/fimc.rst      | 22 ++-----------
 Documentation/media/v4l-drivers/index.rst     |  1 +
 3 files changed, 36 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/media/v4l-drivers/fimc-devel.rst

diff --git a/Documentation/media/v4l-drivers/fimc-devel.rst b/Documentation/media/v4l-drivers/fimc-devel.rst
new file mode 100644
index 000000000000..956e3a9901f8
--- /dev/null
+++ b/Documentation/media/v4l-drivers/fimc-devel.rst
@@ -0,0 +1,33 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: <isonum.txt>
+
+The Samsung S5P/EXYNOS4 FIMC driver
+===================================
+
+Copyright |copy| 2012 - 2013 Samsung Electronics Co., Ltd.
+
+Files partitioning
+------------------
+
+- media device driver
+
+  drivers/media/platform/exynos4-is/media-dev.[ch]
+
+- camera capture video device driver
+
+  drivers/media/platform/exynos4-is/fimc-capture.c
+
+- MIPI-CSI2 receiver subdev
+
+  drivers/media/platform/exynos4-is/mipi-csis.[ch]
+
+- video post-processor (mem-to-mem)
+
+  drivers/media/platform/exynos4-is/fimc-core.c
+
+- common files
+
+  drivers/media/platform/exynos4-is/fimc-core.h
+  drivers/media/platform/exynos4-is/fimc-reg.h
+  drivers/media/platform/exynos4-is/regs-fimc.h
diff --git a/Documentation/media/v4l-drivers/fimc.rst b/Documentation/media/v4l-drivers/fimc.rst
index 74585ba48b7f..0b8ddc4a3008 100644
--- a/Documentation/media/v4l-drivers/fimc.rst
+++ b/Documentation/media/v4l-drivers/fimc.rst
@@ -38,26 +38,6 @@ Not currently supported
 - LCD writeback input
 - per frame clock gating (mem-to-mem)
 
-Files partitioning
-------------------
-
-- media device driver
-  drivers/media/platform/exynos4-is/media-dev.[ch]
-
-- camera capture video device driver
-  drivers/media/platform/exynos4-is/fimc-capture.c
-
-- MIPI-CSI2 receiver subdev
-  drivers/media/platform/exynos4-is/mipi-csis.[ch]
-
-- video post-processor (mem-to-mem)
-  drivers/media/platform/exynos4-is/fimc-core.c
-
-- common files
-  drivers/media/platform/exynos4-is/fimc-core.h
-  drivers/media/platform/exynos4-is/fimc-reg.h
-  drivers/media/platform/exynos4-is/regs-fimc.h
-
 User space interfaces
 ---------------------
 
@@ -74,6 +54,7 @@ connections of the MIPI-CSIS device(s) to the FIMC entities.
 The media device interface allows to configure the SoC for capturing image
 data from the sensor through more than one FIMC instance (e.g. for simultaneous
 viewfinder and still capture setup).
+
 Reconfiguration is done by enabling/disabling media links created by the driver
 during initialization. The internal device topology can be easily discovered
 through media entity and links enumeration.
@@ -116,6 +97,7 @@ sensor subdev -> mipi-csi subdev -> fimc subdev -> video node
 When we configure these devices through sub-device API at user space, the
 configuration flow must be from left to right, and the video node is
 configured as last one.
+
 When we don't use sub-device user space API the whole configuration of all
 devices belonging to the pipeline is done at the video node driver.
 The sysfs entry allows to instruct the capture node driver not to configure
diff --git a/Documentation/media/v4l-drivers/index.rst b/Documentation/media/v4l-drivers/index.rst
index 2d782a40a7b6..adf72937b119 100644
--- a/Documentation/media/v4l-drivers/index.rst
+++ b/Documentation/media/v4l-drivers/index.rst
@@ -70,6 +70,7 @@ For more details see the file COPYING in the source distribution of Linux.
 	cx2341x-devel
 	cx88-devel
 	davinci-vpbe-devel
+	fimc-devel
 	vimc-devel
 
 	cx2341x-uapi
-- 
2.24.1

