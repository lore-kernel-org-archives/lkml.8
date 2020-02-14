Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84FBC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988592082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgBNW2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:28:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:5120 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgBNW1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:27:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 14:27:22 -0800
X-IronPort-AV: E=Sophos;i="5.70,442,1574150400"; 
   d="scan'208";a="227756435"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 14:27:22 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] x86/mce: Add new "kflags" field to "struct mce"
Date:   Fri, 14 Feb 2020 14:27:16 -0800
Message-Id: <20200214222720.13168-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214222720.13168-1-tony.luck@intel.com>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200214222720.13168-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There can be many different subsystems register on the mce handler
chain. Add a new bitmask field and define values so that handlers
can indicate whether they took any action to log or otherwise
handle an error.

The default handler at the end of the chain can use this information
to decide whether to print to the console log.

Boris suggested a generic name and leaving plenty of spare bits
for possible future use.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/uapi/asm/mce.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
index 955c2a2e1cf9..f8395812520b 100644
--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -35,8 +35,17 @@ struct mce {
 	__u64 ipid;		/* MCA_IPID MSR: only valid on SMCA systems */
 	__u64 ppin;		/* Protected Processor Inventory Number */
 	__u32 microcode;	/* Microcode revision */
+	__u64 kflags;		/* Internal kernel use. See below */
 };
 
+/* kflags flag bits for logging etc. */
+#define	MCE_HANDLED_CEC		BIT(0)
+#define	MCE_HANDLED_UC		BIT(1)
+#define	MCE_HANDLED_EXTLOG	BIT(2)
+#define	MCE_HANDLED_NFIT	BIT(3)
+#define	MCE_HANDLED_EDAC	BIT(4)
+#define	MCE_HANDLED_MCELOG	BIT(5)
+
 #define MCE_GET_RECORD_LEN   _IOR('M', 1, int)
 #define MCE_GET_LOG_LEN      _IOR('M', 2, int)
 #define MCE_GETCLEAR_FLAGS   _IOR('M', 3, int)
-- 
2.21.1

