Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277BBC33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B1C2467A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgAJR7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:59:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59272 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbgAJR7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:59:22 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyZ4-00028p-VK; Fri, 10 Jan 2020 18:59:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9B6CF1C2D6C;
        Fri, 10 Jan 2020 18:59:18 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:59:18 -0000
From:   "tip-bot2 for kbuild test robot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Mark __cpa_flush_tlb() as static
Cc:     kbuild test robot <lkp@intel.com>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191123153023.bj6m66scjeubhbjg@4978f4969bb8>
References: <20191123153023.bj6m66scjeubhbjg@4978f4969bb8>
MIME-Version: 1.0
Message-ID: <157867915850.30329.8747100647906961007.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     da9144c5ad8943f9003ec4a6a0200637b4ba9ebd
Gitweb:        https://git.kernel.org/tip/da9144c5ad8943f9003ec4a6a0200637b4ba9ebd
Author:        kbuild test robot <lkp@intel.com>
AuthorDate:    Sat, 23 Nov 2019 23:30:23 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 10:12:55 +01:00

x86/mm/pat: Mark __cpa_flush_tlb() as static

Signed-off-by: kbuild test robot <lkp@intel.com>
Link: https://lkml.kernel.org/r/20191123153023.bj6m66scjeubhbjg@4978f4969bb8
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index d4ab493..2082339 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -331,7 +331,7 @@ static void cpa_flush_all(unsigned long cache)
 	on_each_cpu(__cpa_flush_all, (void *) cache, 1);
 }
 
-void __cpa_flush_tlb(void *data)
+static void __cpa_flush_tlb(void *data)
 {
 	struct cpa_data *cpa = data;
 	unsigned int i;
