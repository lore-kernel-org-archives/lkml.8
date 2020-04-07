Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C64C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5525420768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q52IL4z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgDGQep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:34:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53930 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbgDGQeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:34:24 -0400
Received: from zn.tnic (p200300EC2F0B2700A94266E658FF3DDD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2700:a942:66e6:58ff:3ddd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5D3831EC0CE5;
        Tue,  7 Apr 2020 18:34:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586277263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D535GRgTfzao2ks3gudZO5Oy1QhvqY2ljmaSLAOsNHM=;
        b=Q52IL4z37GjhD6yvJ9BR7e1TCkQukTiEOiC1Z+LMcWxeSl9BigWaFoEpMHGnmoycDnsgE7
        KQoWhUOnFrkN5VEsU15CqQWWDEzRLlMVpOPaeBJ5CWs65+gTIUzPz3ifkAujIo26wxPmOy
        x43A+KViWmluoSIg3srg5JSIcd0Cx+4=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/9] x86/mce: Add a struct mce.kflags field
Date:   Tue,  7 Apr 2020 18:34:09 +0200
Message-Id: <20200407163414.18058-5-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200407163414.18058-1-bp@alien8.de>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200407163414.18058-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

There can be many different subsystems register on the mce handler
chain. Add a new bitmask field and define values so that handlers can
indicate whether they took any action to log or otherwise handle an
error.

The default handler at the end of the chain can use this information to
decide whether to print to the console log.

Boris suggested a generic name and leaving plenty of spare bits for
possible future use.

 [ bp: Move flag bits to the internal mce.h header and use BIT_ULL(). ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200214222720.13168-4-tony.luck@intel.com
---
 arch/x86/include/asm/mce.h      | 8 ++++++++
 arch/x86/include/uapi/asm/mce.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 689ac6e9c65f..5f04a24f30ea 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -129,6 +129,14 @@
 
 #define XEC(x, mask)			(((x) >> 16) & mask)
 
+/* mce.kflags flag bits for logging etc. */
+#define	MCE_HANDLED_CEC		BIT_ULL(0)
+#define	MCE_HANDLED_UC		BIT_ULL(1)
+#define	MCE_HANDLED_EXTLOG	BIT_ULL(2)
+#define	MCE_HANDLED_NFIT	BIT_ULL(3)
+#define	MCE_HANDLED_EDAC	BIT_ULL(4)
+#define	MCE_HANDLED_MCELOG	BIT_ULL(5)
+
 /*
  * This structure contains all data related to the MCE log.  Also
  * carries a signature to make it easier to find from external
diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
index 955c2a2e1cf9..5b59d80f1d4e 100644
--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -35,6 +35,7 @@ struct mce {
 	__u64 ipid;		/* MCA_IPID MSR: only valid on SMCA systems */
 	__u64 ppin;		/* Protected Processor Inventory Number */
 	__u32 microcode;	/* Microcode revision */
+	__u64 kflags;		/* Internal kernel use. See below */
 };
 
 #define MCE_GET_RECORD_LEN   _IOR('M', 1, int)
-- 
2.21.0

