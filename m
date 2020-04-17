Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A55C38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77147221E9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgDQJVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730106AbgDQJVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:21:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21357C061A0C;
        Fri, 17 Apr 2020 02:21:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jPNBv-000577-NU; Fri, 17 Apr 2020 11:21:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 329E91C0072;
        Fri, 17 Apr 2020 11:21:43 +0200 (CEST)
Date:   Fri, 17 Apr 2020 09:21:42 -0000
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Drop bogus comment about mce.kflags
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200415195826.GA13681@agluck-desk2.amr.corp.intel.com>
References: <20200415195826.GA13681@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Message-ID: <158711530270.28353.8482037623626742412.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     f82cdff1aa7f6dcf6625c7219342a6e5c977098d
Gitweb:        https://git.kernel.org/tip/f82cdff1aa7f6dcf6625c7219342a6e5c977098d
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 15 Apr 2020 12:58:26 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 17 Apr 2020 11:12:21 +02:00

x86/mce: Drop bogus comment about mce.kflags

The bit definitions for kflags are for internal use only. A
late edit moved them from uapi/asm/mce.h to the internal
x86 <asm/mce.h>, but the comment saying "See below" was
accidentally left here.

Delete "See below". Just labelling this field as internal
kernel use is sufficient.

Fixes: 1de08dccd383 ("x86/mce: Add a struct mce.kflags field")
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200415195826.GA13681@agluck-desk2.amr.corp.intel.com
---
 arch/x86/include/uapi/asm/mce.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
index 5b59d80..db9adc0 100644
--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -35,7 +35,7 @@ struct mce {
 	__u64 ipid;		/* MCA_IPID MSR: only valid on SMCA systems */
 	__u64 ppin;		/* Protected Processor Inventory Number */
 	__u32 microcode;	/* Microcode revision */
-	__u64 kflags;		/* Internal kernel use. See below */
+	__u64 kflags;		/* Internal kernel use */
 };
 
 #define MCE_GET_RECORD_LEN   _IOR('M', 1, int)
