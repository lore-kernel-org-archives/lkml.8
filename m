Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35861C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 196B32081A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgF3XqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:46:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:13148 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbgF3XpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 19:45:25 -0400
IronPort-SDR: eaJaHODaF8Ee9s2zi8BbmgkdomD7IXUAJ1uFLAtWb/j4YlNlDAXfEWGiw3qaeyQ130fTF+yr0f
 +XOElnXmW6IA==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="143893349"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="143893349"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 16:45:19 -0700
IronPort-SDR: GeT/ckjKwMJQl1DBqGH+pOCXGqHfXhWGoz51qRDi499akJMp6d5xsgkznBDatAYIAHPfIAbq/a
 +xaB/oIqhxPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="386842563"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jun 2020 16:44:53 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Joerg Roedel" <joro@8bytes.org>, "Ingo Molnar" <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "H Peter Anvin" <hpa@zytor.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Felix Kuehling" <Felix.Kuehling@amd.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, iommu@lists.linux-foundation.org,
        "amd-gfx" <amd-gfx@lists.freedesktop.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 06/12] x86/msr-index: Define IA32_PASID MSR
Date:   Tue, 30 Jun 2020 16:44:36 -0700
Message-Id: <1593560682-40814-7-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1593560682-40814-1-git-send-email-fenghua.yu@intel.com>
References: <1593560682-40814-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IA32_PASID MSR (0xd93) contains the Process Address Space Identifier
(PASID), a 20-bit value. Bit 31 must be set to indicate the value
programmed in the MSR is valid. Hardware uses PASID to identify process
address space and direct responses to the right address space.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Change "identify process" to "identify process address space" in the
  commit message (Thomas)

 arch/x86/include/asm/msr-index.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e8370e64a155..e5f699ff1dd6 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -237,6 +237,9 @@
 #define MSR_IA32_LASTINTFROMIP		0x000001dd
 #define MSR_IA32_LASTINTTOIP		0x000001de
 
+#define MSR_IA32_PASID			0x00000d93
+#define MSR_IA32_PASID_VALID		BIT_ULL(31)
+
 /* DEBUGCTLMSR bits (others vary by model): */
 #define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
 #define DEBUGCTLMSR_BTF_SHIFT		1
-- 
2.19.1

