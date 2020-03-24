Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7D0C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FD92080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585044939;
	bh=Ng776RDVUtwc7KQiVz21I8I2Wgral1f/GNSOxXixasQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sZ/DW/8yQ01LmVwasezBp4g+caLpYGLoueBJMOn2zPZCqUQv24/2l/7svtYNrQyF2
	 he4Yhkws0/Uz+kOpq5PYsUqdWjRmEnnV5JLXtD/t3s3qkGmfK8zMhMDkXdhYc2tMyG
	 RL89BkTw/JkSlgB1jRTdbQmwxY9QlyshhzOeeohY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgCXKPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbgCXKPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:15:24 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF9C92080C;
        Tue, 24 Mar 2020 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585044924;
        bh=Ng776RDVUtwc7KQiVz21I8I2Wgral1f/GNSOxXixasQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SrI1EStL6N2czPIvrLO/O+OPW/W3qsBSsCz4X8Ohr+eKhLangk0n+/HG47GtTyl6Z
         NKZ6KOMGNkxerLO+IS/pQvSM5FCWjhbJINtTwZRDWcM8kpijSD3WBycHC2Dk1SkpFS
         4Jlemtlv3MeOVM7t4cCRCOdDJtN6+JtuRvY+42Fc=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGgag-001pjR-8z; Tue, 24 Mar 2020 11:15:22 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 3/8] media: pci: move VIDEO_PCI_SKELETON to a different Kconfig
Date:   Tue, 24 Mar 2020 11:15:16 +0100
Message-Id: <8a09c8d2144c36f8d370f6ab069ff1c6e6d6fb00.1585044374.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585044374.git.mchehab+huawei@kernel.org>
References: <cover.1585044374.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The V4L2 PCI skeleton is not part of the V4L2 core. Move it
to appear together with the other PCI drivers, at the end,
as this is something that normal users don't even need to
bother.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/pci/Kconfig       | 10 ++++++++++
 drivers/media/v4l2-core/Kconfig | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/pci/Kconfig b/drivers/media/pci/Kconfig
index dcb3719f440e..9336f8446cf0 100644
--- a/drivers/media/pci/Kconfig
+++ b/drivers/media/pci/Kconfig
@@ -56,5 +56,15 @@ endif
 
 source "drivers/media/pci/intel/ipu3/Kconfig"
 
+config VIDEO_PCI_SKELETON
+	tristate "Skeleton PCI V4L2 driver"
+	depends on PCI
+	depends on SAMPLES
+	depends on VIDEO_V4L2 && VIDEOBUF2_CORE
+	depends on VIDEOBUF2_MEMOPS && VIDEOBUF2_DMA_CONTIG
+	help
+	  Enable build of the skeleton PCI driver, used as a reference
+	  when developing new drivers.
+
 endif #MEDIA_PCI_SUPPORT
 endif #PCI
diff --git a/drivers/media/v4l2-core/Kconfig b/drivers/media/v4l2-core/Kconfig
index 39e3fb30ba0b..26276b257eae 100644
--- a/drivers/media/v4l2-core/Kconfig
+++ b/drivers/media/v4l2-core/Kconfig
@@ -31,16 +31,6 @@ config VIDEO_FIXED_MINOR_RANGES
 
 	  When in doubt, say N.
 
-config VIDEO_PCI_SKELETON
-	tristate "Skeleton PCI V4L2 driver"
-	depends on PCI
-	depends on SAMPLES
-	depends on VIDEO_V4L2 && VIDEOBUF2_CORE
-	depends on VIDEOBUF2_MEMOPS && VIDEOBUF2_DMA_CONTIG
-	help
-	  Enable build of the skeleton PCI driver, used as a reference
-	  when developing new drivers.
-
 # Used by drivers that need tuner.ko
 config VIDEO_TUNER
 	tristate
-- 
2.24.1

