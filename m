Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2BFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F27C214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447381;
	bh=EQOKxm6aV10YMCrUx58JzOqXwaMehrIdJyBLmmicb8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Nrko2t8abKdBsrg1FI2I3i11HjJU7ITwf6iQW7E3ljL7t8ixbjpEPoQb/XzhhdXK
	 1LUtsoY1xY+4HSMV+I2V2BzHLwki3SdixPphcH84Yz3NanTiDS6kRkKJEf48BPPWE2
	 73yt5uP4KoV4cIuIIFbSZB2rRVMtqPBluy184aNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387672AbgFRC3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729552AbgFRBQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:16:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DE32206F1;
        Thu, 18 Jun 2020 01:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442970;
        bh=EQOKxm6aV10YMCrUx58JzOqXwaMehrIdJyBLmmicb8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPrmiImV2Cth03dhO0sy+pgFtZnaa2CPV4iTpKtNqbPuKoW3YBK6VuZHoU5+AlNmb
         Uyb0GxK4B2lTbOLSoIPkZod7f6zTRLAi05YZC67zbFaPJXkn22n+MydTyACY5ArhG4
         t/cFJgxgBU27/UYjIWLN5BtBErUl8z8NadB45thA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 374/388] x86/idt: Keep spurious entries unset in system_vectors
Date:   Wed, 17 Jun 2020 21:07:51 -0400
Message-Id: <20200618010805.600873-374-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit 1f1fbc70c10e81f70e9fbe2102d439c883269811 ]

With commit dc20b2d52653 ("x86/idt: Move interrupt gate initialization to
IDT code") non assigned system vectors are also marked as used in
'used_vectors' (now 'system_vectors') bitmap. This makes checks in
arch_show_interrupts() whether a particular system vector is allocated to
always pass and e.g. 'Hyper-V reenlightenment interrupts' entry always
shows up in /proc/interrupts.

Another side effect of having all unassigned system vectors marked as used
is that irq_matrix_debug_show() will wrongly count them among 'System'
vectors.

As it is now ensured that alloc_intr_gate() is not called after init, it is
possible to leave unused entries in 'system_vectors' unset to fix these
issues.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200428093824.1451532-4-vkuznets@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/idt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 87ef69a72c52..7bb4c3cbf4dc 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -318,7 +318,11 @@ void __init idt_setup_apic_and_irq_gates(void)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 	for_each_clear_bit_from(i, system_vectors, NR_VECTORS) {
-		set_bit(i, system_vectors);
+		/*
+		 * Don't set the non assigned system vectors in the
+		 * system_vectors bitmap. Otherwise they show up in
+		 * /proc/interrupts.
+		 */
 		entry = spurious_entries_start + 8 * (i - FIRST_SYSTEM_VECTOR);
 		set_intr_gate(i, entry);
 	}
-- 
2.25.1

