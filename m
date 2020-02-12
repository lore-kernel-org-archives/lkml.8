Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A446C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA80D2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgBLUrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:47:08 -0500
Received: from mga03.intel.com ([134.134.136.65]:27753 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729054AbgBLUqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:46:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 12:46:53 -0800
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="281335112"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 12:46:52 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] x86/mce: Add new "handled" field to "struct mce"
Date:   Wed, 12 Feb 2020 12:46:50 -0800
Message-Id: <20200212204652.1489-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212204652.1489-1-tony.luck@intel.com>
References: <20200212204652.1489-1-tony.luck@intel.com>
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

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/uapi/asm/mce.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
index 955c2a2e1cf9..99ca07f7b078 100644
--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -35,8 +35,17 @@ struct mce {
 	__u64 ipid;		/* MCA_IPID MSR: only valid on SMCA systems */
 	__u64 ppin;		/* Protected Processor Inventory Number */
 	__u32 microcode;	/* Microcode revision */
+	__u32 handled;		/* Bitmap of logging/handling actions */
 };
 
+/* handled flag bits */
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

