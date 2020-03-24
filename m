Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FD8C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC39208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgCXOYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:24:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45071 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbgCXOYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:24:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGkTF-0006zr-IF; Tue, 24 Mar 2020 15:23:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 342401C0470;
        Tue, 24 Mar 2020 15:23:57 +0100 (CET)
Date:   Tue, 24 Mar 2020 14:23:56 -0000
From:   "tip-bot2 for Alexey Makhalov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vmware] x86/vmware: Make vmware_select_hypercall() __init
Cc:     Alexey Makhalov <amakhalov@vmware.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323195707.31242-2-amakhalov@vmware.com>
References: <20200323195707.31242-2-amakhalov@vmware.com>
MIME-Version: 1.0
Message-ID: <158505983688.28353.14563304680981102278.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     14388ae24544c4cc09056773c886839a2c8d256b
Gitweb:        https://git.kernel.org/tip/14388ae24544c4cc09056773c886839a2c8d256b
Author:        Alexey Makhalov <amakhalov@vmware.com>
AuthorDate:    Mon, 23 Mar 2020 19:57:03 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 09:26:04 +01:00

x86/vmware: Make vmware_select_hypercall() __init

vmware_select_hypercall() is used only by the __init
functions, and should be annotated with __init as well.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200323195707.31242-2-amakhalov@vmware.com
---
 arch/x86/kernel/cpu/vmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 46d7326..d280560 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -213,7 +213,7 @@ static void __init vmware_platform_setup(void)
 	vmware_set_capabilities();
 }
 
-static u8 vmware_select_hypercall(void)
+static u8 __init vmware_select_hypercall(void)
 {
 	int eax, ebx, ecx, edx;
 
