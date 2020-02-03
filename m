Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C67C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CBC2080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgBCSsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:48:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:39904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728444AbgBCSsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:48:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7B025AD55;
        Mon,  3 Feb 2020 18:48:39 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, f.fainelli@gmail.com,
        yamada.masahiro@socionext.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kbuild: Add config fragment merge functionality
Date:   Mon,  3 Feb 2020 19:48:18 +0100
Message-Id: <20200203184820.4433-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203184820.4433-1-nsaenzjulienne@suse.de>
References: <20200203184820.4433-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far this function was only used locally in powerpc, some other
architectures might benefit from it. Move it into
scripts/Makefile.defconf.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/powerpc/Makefile    | 12 +-----------
 scripts/Makefile.defconf | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 11 deletions(-)
 create mode 100644 scripts/Makefile.defconf

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index f35730548e42..517ef8ec774b 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -301,17 +301,7 @@ $(BOOT_TARGETS2): vmlinux
 bootwrapper_install:
 	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
-# Used to create 'merged defconfigs'
-# To use it $(call) it with the first argument as the base defconfig
-# and the second argument as a space separated list of .config files to merge,
-# without the .config suffix.
-define merge_into_defconfig
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
-		-m -O $(objtree) $(srctree)/arch/$(ARCH)/configs/$(1) \
-		$(foreach config,$(2),$(srctree)/arch/$(ARCH)/configs/$(config).config)
-	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
-endef
-
+include $(srctree)/scripts/Makefile.defconf
 PHONY += pseries_le_defconfig
 pseries_le_defconfig:
 	$(call merge_into_defconfig,pseries_defconfig,le)
diff --git a/scripts/Makefile.defconf b/scripts/Makefile.defconf
new file mode 100644
index 000000000000..ab332f7534f5
--- /dev/null
+++ b/scripts/Makefile.defconf
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+# Configuration heplers
+
+# Creates 'merged defconfigs'
+# ---------------------------------------------------------------------------
+# Usage:
+#   $(call merge_into_defconfig,base_config,config_fragment1 config_fragment2 ...)
+#
+# Input config fragments without '.config' suffix
+define merge_into_defconfig
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
+		-m -O $(objtree) $(srctree)/arch/$(ARCH)/configs/$(1) \
+		$(foreach config,$(2),$(srctree)/arch/$(ARCH)/configs/$(config).config)
+	+$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
+endef
-- 
2.25.0

