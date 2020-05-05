Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13442C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB305206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgEESqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 14:46:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:12607 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbgEESqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 14:46:49 -0400
IronPort-SDR: Nrie9m902qG7hC7UmYGycGsmH0Qp7VeJoRUntPyZI2AJgzgmetUAQNqAWGtQnLRCs9J4IK0oOE
 PEBRvwkNwhRg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 11:46:49 -0700
IronPort-SDR: Zl0erL2P/LHcga8DoFAsH/CBgpruycTzPlOtKFEzODlGgqHhZIIT3uUrhepGIon31y4mixTlSb
 lu6PfPfsVO/Q==
X-IronPort-AV: E=Sophos;i="5.73,356,1583222400"; 
   d="scan'208";a="461495172"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 11:46:49 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, Jue Wang <juew@google.com>,
        Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm: Don't try to change poison pages to uncacheable in a guest
Date:   Tue,  5 May 2020 11:46:48 -0700
Message-Id: <20200505184648.2264-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An interesting thing happened when a guest Linux instance took
a machine check. The VMM unmapped the bad page from guest physical
space and passed the machine check to the guest.

Linux took all the normal actions to offline the page from the process
that was using it. But then guest Linux crashed because it said there
was a second machine check inside the kernel with this stack trace:

do_memory_failure
    set_mce_nospec
         set_memory_uc
              _set_memory_uc
                   change_page_attr_set_clr
                        cpa_flush
                             clflush_cache_range_opt

This was odd, because a CLFLUSH instruction shouldn't raise a machine
check (it isn't consuming the data). Further investigation showed that
the VMM had passed in another machine check because is appeared that the
guest was accessing the bad page.

Fix is to check whether Linux is running as a guest. If it is, there is no
point in trying to change the cache mode of the bad page. The VMM has taken
the whole page away.

Reported-by: Jue Wang <juew@google.com>
Tested-by: Jue Wang <juew@google.com>
Fixes: 284ce4011ba6 ("x86/memory_failure: Introduce {set, clear}_mce_nospec()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/set_memory.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index ec2c0a094b5d..e8b7e8a82d7a 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -91,6 +91,14 @@ static inline int set_mce_nospec(unsigned long pfn)
 	unsigned long decoy_addr;
 	int rc;
 
+	/*
+	 * If we are running as a guest, then the hypervisor
+	 * will have removed all access from the page. So no
+	 * point trying to make it uncacheable
+	 */
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return 0;
+
 	/*
 	 * Mark the linear address as UC to make sure we don't log more
 	 * errors because of speculative access to the page.
-- 
2.21.1

