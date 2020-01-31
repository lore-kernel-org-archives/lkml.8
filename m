Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16702C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA04F20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580459323;
	bh=FxoY6cZlXPjXsWVnIRhDIqdynt4r+rtbZulaa2ymBiA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LMbEDsUcpUHHvCr8G3/myxwYoFTZaBf/2AiA+uLhEEneprEtqE9y7qRx/znmgsGrf
	 j6Anf6rOlyhwe51qlRnlr7uMMmVStMZLqoglPBNGqyglBVc30JUAYtgBkdFhEUIDoj
	 g3nd/2e4xeuMePDlrZqpmatr5zRRPA+xtaqXP2Ik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgAaI2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 03:28:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:33666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728099AbgAaI2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:28:43 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D13206F0;
        Fri, 31 Jan 2020 08:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580459322;
        bh=FxoY6cZlXPjXsWVnIRhDIqdynt4r+rtbZulaa2ymBiA=;
        h=From:To:Cc:Subject:Date:From;
        b=UgEiJpBxDVZN3XmGLXFX0cx8hR7aE8nGxdHprEqMN2cBfhuyaOVkrD4HW5Fc0jeNq
         VwoDUHXUYGi4vnI/CLQrEh7GKCLjJ7GXJzM4Lv98OcmMSReHEOoKcznuvJp2MQuLym
         o1xVlAP21HhTSsZF1hpVTtCTIXyLiEVEn3w5BBBs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        openrisc@lists.librecores.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2] openrisc: configs: Cleanup CONFIG_CROSS_COMPILE
Date:   Fri, 31 Jan 2020 09:28:33 +0100
Message-Id: <1580459313-16926-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CROSS_COMPILE is gone since commit f1089c92da79 ("kbuild: remove
CONFIG_CROSS_COMPILE support").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Update also docs.
---
 Documentation/openrisc/openrisc_port.rst   | 4 ++--
 arch/openrisc/configs/or1ksim_defconfig    | 1 -
 arch/openrisc/configs/simple_smp_defconfig | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/openrisc/openrisc_port.rst b/Documentation/openrisc/openrisc_port.rst
index a18747a8d191..4b2c437942a0 100644
--- a/Documentation/openrisc/openrisc_port.rst
+++ b/Documentation/openrisc/openrisc_port.rst
@@ -37,8 +37,8 @@ or Stafford's toolchain build and release scripts.
 
 Build the Linux kernel as usual::
 
-	make ARCH=openrisc defconfig
-	make ARCH=openrisc
+	make ARCH=openrisc CROSS_COMPILE="or1k-linux-" defconfig
+	make ARCH=openrisc CROSS_COMPILE="or1k-linux-"
 
 3) Running on FPGA (optional)
 
diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
index d8ff4f8ffb88..75f2da324d0e 100644
--- a/arch/openrisc/configs/or1ksim_defconfig
+++ b/arch/openrisc/configs/or1ksim_defconfig
@@ -1,4 +1,3 @@
-CONFIG_CROSS_COMPILE="or1k-linux-"
 CONFIG_NO_HZ=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
index 64278992df9c..ff49d868e040 100644
--- a/arch/openrisc/configs/simple_smp_defconfig
+++ b/arch/openrisc/configs/simple_smp_defconfig
@@ -1,4 +1,3 @@
-CONFIG_CROSS_COMPILE="or1k-linux-"
 CONFIG_LOCALVERSION="-simple-smp"
 CONFIG_NO_HZ=y
 CONFIG_LOG_BUF_SHIFT=14
-- 
2.7.4

