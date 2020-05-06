Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78930C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C99720753
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbgEFWQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 18:16:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:20245 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728621AbgEFWQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 18:16:46 -0400
IronPort-SDR: Es1fyK6Rn9d1RwDB5NQH93rFwFIMhHPoXrvsBZ8wSR8qZ3b8SqByZLuiUw0Z427iDmK0j6xvlv
 TMYSlYZBNinA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 15:16:45 -0700
IronPort-SDR: V2kACGW0PQU6PzLQIKVx1rVBi9Gh9gkpBV+dpZ8kc15itB0rekEz5FwZn4Tm4jtyBHw7a89ogk
 VFWMPPml7WzA==
X-IronPort-AV: E=Sophos;i="5.73,360,1583222400"; 
   d="scan'208";a="284782467"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 15:16:45 -0700
Received: from ndsouza-desktop.jf.intel.com (ndsouza-desktop.jf.intel.com [10.54.74.186])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 364A3636E;
        Wed,  6 May 2020 22:16:44 +0000 (UTC)
From:   Nelson D'Souza <nelson.dsouza@linux.intel.com>
To:     tglx@linutronix.de, bp@alien8.de
Cc:     mingo@redhat.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v1] x86/cpu/tsx: Change the TSX default from "off" to "auto"
Date:   Wed,  6 May 2020 15:14:59 -0700
Message-Id: <20200506221459.29104-1-nelson.dsouza@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are now several commercially available processors that have h/w
fixes for the TSX Async Abort (TAA) issue as indicated by enumerating
the ARCH_CAPABILITIES "TAA_NO" bit.

Change the default setting to "auto" so that these CPUs will leave
TSX enabled by default.

This can still be overridden by the kernel cmdline parameter
tsx=on|off|auto

Signed-off-by: Nelson D'Souza <nelson.dsouza@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/Kconfig | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d6104ea8af0..b444205c964a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1905,7 +1905,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 choice
 	prompt "TSX enable mode"
 	depends on CPU_SUP_INTEL
-	default X86_INTEL_TSX_MODE_OFF
+	default X86_INTEL_TSX_MODE_AUTO
 	help
 	  Intel's TSX (Transactional Synchronization Extensions) feature
 	  allows to optimize locking protocols through lock elision which
@@ -1915,8 +1915,13 @@ choice
 	  to form side channel attacks (e.g. TAA) and chances are there
 	  will be more of those attacks discovered in the future.
 
-	  Therefore TSX is not enabled by default (aka tsx=off). An admin
-	  might override this decision by tsx=on the command line parameter.
+	  The default setting for TSX Mode is set to auto. This will enable
+	  TSX feature for platforms that are not vulnerable to the TAA issue.
+
+	  TSX feature will continue to be disabled on platforms that are
+	  vulnerable to TAA and support disabling TSX via the updated microcode.
+
+	  An admin might override this decision by a kernel command line parameter.
 	  Even with TSX enabled, the kernel will attempt to enable the best
 	  possible TAA mitigation setting depending on the microcode available
 	  for the particular machine.
-- 
2.24.1

