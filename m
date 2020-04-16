Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAADC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468CE221F7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 20:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgDPU6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:58:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:8859 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbgDPU6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 16:58:00 -0400
IronPort-SDR: dVOww/gUG3nahn+hxtXmDfRwDIGJZBxE2pIZUtg7nxcRPyTtIB2lEXgHh6YXq/vPJ+Gv14OuE1
 xi5yHl4W9R+g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 13:57:56 -0700
IronPort-SDR: EapNLMT0sdeJVT8AAYK4BgkWIX1d4l15yqiyzp8Ss1n6DvQ0E1XYZ4Eu+Q8M/6WHAP3v0zXtfG
 JxQzMn3uLqHQ==
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200"; 
   d="scan'208";a="427982534"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 13:57:55 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 3/3] x86/split_lock: Add Tremont family CPU models
Date:   Thu, 16 Apr 2020 13:57:54 -0700
Message-Id: <20200416205754.21177-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200416205754.21177-1-tony.luck@intel.com>
References: <20200416205754.21177-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tremont CPUs support IA32_CORE_CAPABILITIES bits to indicate
whether speciifc SKUs have support for split lock detection.

Fixes: 6650cdd9a8cc ("x86/split_lock: Enable split lock detection by kernel")
Cc: <stable@vger.kernel.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 3b43b2c91054..d559481b54a6 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1130,6 +1130,9 @@ void switch_to_sld(unsigned long tifn)
 static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,           0),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,           0),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	1),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	1),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	1),
 	{}
 };
 
-- 
2.21.1

