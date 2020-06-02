Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC8BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8298206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgFBJTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:19:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:47613 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgFBJTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:19:46 -0400
IronPort-SDR: 95fyIx2KNj689JuMzlhSRlZNVP9QMtfkXD00v5Y/qRIiVcRvqZdJjmCFjKS//stLPdWZIAQ1YQ
 Bvhq+Wf2xscQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 02:19:46 -0700
IronPort-SDR: WAEaAvStENFfwLuhi6fndlAnkI991u1eUROelkM/wuQfncBweY8CD/sV16WBK/HlpHGXvH1DVI
 g+N8Dr7GVLkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="304175393"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 02 Jun 2020 02:19:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8D5882D2; Tue,  2 Jun 2020 12:19:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v1] x86/gdt: Replace u16 castings by bitwise & in GDT_ENTRY_INIT()
Date:   Tue,  2 Jun 2020 12:19:41 +0300
Message-Id: <20200602091941.29449-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that the original commit 1e5de18278e6
("x86: Introduce GDT_ENTRY_INIT()") used bitwise operations on the parameters
when the commit 38e9e81f4c81 ("x86/gdt: Use bitfields for initialization")
changed them to simple castings. The latter change recently made sparse not
happy about. To satisfy it return to bitwise operations in GDT_ENTRY_INIT().

Fixes: 38e9e81f4c81 ("x86/gdt: Use bitfields for initialization")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/desc_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/desc_defs.h b/arch/x86/include/asm/desc_defs.h
index a91f3b6e4f2a..0d17a86fc1df 100644
--- a/arch/x86/include/asm/desc_defs.h
+++ b/arch/x86/include/asm/desc_defs.h
@@ -22,9 +22,9 @@ struct desc_struct {
 
 #define GDT_ENTRY_INIT(flags, base, limit)			\
 	{							\
-		.limit0		= (u16) (limit),		\
+		.limit0		= ((limit) >> 0) & 0xFFFF,	\
 		.limit1		= ((limit) >> 16) & 0x0F,	\
-		.base0		= (u16) (base),			\
+		.base0		= ((base) >> 0) & 0xFFFF,	\
 		.base1		= ((base) >> 16) & 0xFF,	\
 		.base2		= ((base) >> 24) & 0xFF,	\
 		.type		= (flags & 0x0f),		\
-- 
2.27.0.rc2

