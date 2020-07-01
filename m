Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49E5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E1920760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgGASsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:48:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:46504 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgGASsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:48:24 -0400
IronPort-SDR: wAC1aanLtz6bsNsy2MgdND79oy80/njIqx0LE72cX3I79RmbhBMJLSvTHQc7xDM/afV2oT77ac
 v1c3fa2MzhZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="144195057"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="144195057"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 11:48:23 -0700
IronPort-SDR: aSOCtV9x7MtfgKy7FttALCYlGfxY+1d1G77RWRwld9EfTil8Yrcw78qevyCTXLpqDqAXgeckqj
 Ms7uQDMvClWQ==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="455207787"
Received: from sawhitac-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.111.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 11:48:22 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        kernel test robot <lkp@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vincent Chen <vincent.chen@sifive.com>,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] riscv: asm/gdb_xml.h: use __maybe_used to make W=1 warnings go away
Date:   Wed,  1 Jul 2020 13:47:49 -0500
Message-Id: <20200701184751.84008-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0day/kbuild reports warnings with the ASoC codecs compiled with W=1.

In file included from arch/riscv/include/asm/kgdb.h:109,
                 from include/linux/kgdb.h:20,
                 from include/linux/fb.h:5,
                 from include/drm/drm_crtc.h:31,
                 from sound/soc/codecs/hdmi-codec.c:19:

arch/riscv/include/asm/gdb_xml.h:23:19: warning:
'riscv_gdb_stub_cpuxml' defined but not used [-Wunused-const-variable=]
   23 | static const char riscv_gdb_stub_cpuxml[2048] =
      |                   ^~~~~~~~~~~~~~~~~~~~~
arch/riscv/include/asm/gdb_xml.h:16:19: warning:
'riscv_gdb_stub_target_desc' defined but not used [-Wunused-const-variable=]
   16 | static const char riscv_gdb_stub_target_desc[256] =
      |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
arch/riscv/include/asm/gdb_xml.h:13:19: warning:
'gdb_xfer_read_cpuxml' defined but not used [-Wunused-const-variable=]
   13 | static const char gdb_xfer_read_cpuxml[39] =
      |                   ^~~~~~~~~~~~~~~~~~~~
arch/riscv/include/asm/gdb_xml.h:10:19: warning:
'gdb_xfer_read_target' defined but not used [-Wunused-const-variable=]
   10 | static const char gdb_xfer_read_target[31] = "qXfer:features:read:target.xml:";
      |                   ^~~~~~~~~~~~~~~~~~~~
arch/riscv/include/asm/gdb_xml.h:7:19: warning:
'riscv_gdb_stub_feature' defined but not used [-Wunused-const-variable=]
    7 | static const char riscv_gdb_stub_feature[64] =
      |                   ^~~~~~~~~~~~~~~~~~~~~~

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---

I don't know if this is the right way of solving this issue but this
error is now consistently thrown in kbuild compile-test reports w/
W=1.

 arch/riscv/include/asm/gdb_xml.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/gdb_xml.h b/arch/riscv/include/asm/gdb_xml.h
index 041b45f5b997..c28fc1a1d230 100644
--- a/arch/riscv/include/asm/gdb_xml.h
+++ b/arch/riscv/include/asm/gdb_xml.h
@@ -4,23 +4,23 @@
 #define __ASM_GDB_XML_H_
 
 #define kgdb_arch_gdb_stub_feature riscv_gdb_stub_feature
-static const char riscv_gdb_stub_feature[64] =
+static __maybe_unused const char riscv_gdb_stub_feature[64] =
 			"PacketSize=800;qXfer:features:read+;";
 
-static const char gdb_xfer_read_target[31] = "qXfer:features:read:target.xml:";
+static __maybe_unused const char gdb_xfer_read_target[31] = "qXfer:features:read:target.xml:";
 
 #ifdef CONFIG_64BIT
-static const char gdb_xfer_read_cpuxml[39] =
+static __maybe_unused const char gdb_xfer_read_cpuxml[39] =
 			"qXfer:features:read:riscv-64bit-cpu.xml";
 
-static const char riscv_gdb_stub_target_desc[256] =
+static __maybe_unused const char riscv_gdb_stub_target_desc[256] =
 "l<?xml version=\"1.0\"?>"
 "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">"
 "<target>"
 "<xi:include href=\"riscv-64bit-cpu.xml\"/>"
 "</target>";
 
-static const char riscv_gdb_stub_cpuxml[2048] =
+static __maybe_unused const char riscv_gdb_stub_cpuxml[2048] =
 "l<?xml version=\"1.0\"?>"
 "<!DOCTYPE feature SYSTEM \"gdb-target.dtd\">"
 "<feature name=\"org.gnu.gdb.riscv.cpu\">"
-- 
2.25.1

