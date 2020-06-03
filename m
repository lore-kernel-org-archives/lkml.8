Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D405C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0134920674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgFCRfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:35:09 -0400
Received: from mga14.intel.com ([192.55.52.115]:40771 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgFCRez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:34:55 -0400
IronPort-SDR: MRj5xfyAcddDBZ41DXK3LqjRyWhwXRaUHvef+I4qdba7csV8QFmp2LyIqHSJkE4I24xmMkZ1O3
 Fuv04K7QdJ4A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 10:33:52 -0700
IronPort-SDR: UEpJgJCNMYlkl3DSUf6/mQMTVai4u47l2xaA8qjYJu/1BjNiP2gJs7+UJtblPju4WpsllCbG3B
 1SyocBgNdKpQ==
X-IronPort-AV: E=Sophos;i="5.73,468,1583222400"; 
   d="scan'208";a="378173379"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 10:33:52 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpu: Add Sapphire Rapids CPU model number
Date:   Wed,  3 Jun 2020 10:33:52 -0700
Message-Id: <20200603173352.15506-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latest edition (039) of "Intel Architecture Instruction Set Extensions
and Future Features Programming Reference" includes three new CPU model
numbers. Linux already has the two Ice Lake server ones. Add the new
model number for Sapphire Rapids.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
I'd appreciate this being merged to Linus, even though it wasn't posted
before the merge window opened. It will avoid it being a dependency for
other patch series (perf, edac, ...)

FYI: ISE039 is here today (not included in commit message because the URL
isn't long term stable).

https://software.intel.com/content/dam/develop/public/us/en/documents/architecture-instruction-set-extensions-programming-reference.pdf

 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 8f1e94f29a16..a338a6deb950 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -89,6 +89,8 @@
 #define INTEL_FAM6_COMETLAKE		0xA5
 #define INTEL_FAM6_COMETLAKE_L		0xA6
 
+#define INTEL_FAM6_SAPPHIRERAPIDS_X	0x8F
+
 /* "Small Core" Processors (Atom) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
-- 
2.21.1

