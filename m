Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2571AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8D92072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946713;
	bh=yCnnmnrL8bLn9e8bY/dSWzWtulChL8RsibXQVL+oxy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kOyLPz0x6Ae2RqeyA/y6mUp+wRHmaj+Rg1OLwaUe3zvj1LPFYmKVu+nKpp1ArUxUe
	 pGIxzqL+IxLghg+AXHhK7RSRGi0ODNtitVb+NOgWZ/xzFSnEaR1ru+Z0aZ9phlOlEL
	 0Mu+hICEeJQJ7dOTltzNSUrNqs91XpmZLKitQWwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391269AbgFWUcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391242AbgFWUbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:31:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B22F52072E;
        Tue, 23 Jun 2020 20:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944307;
        bh=yCnnmnrL8bLn9e8bY/dSWzWtulChL8RsibXQVL+oxy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mHx/1WjHFD6x+kBqP4zdMJy5J4vQ69Ynb96a5OQaznHR3N2CVpL5llfhyyzzejt7K
         LETbKXr8mpSY0bwqMXZ9aE/KpBQaVPbVAw49rAztud26HYE6COsXk3/uQOfLstI+zU
         CCxYgSr6nSlscc1Rv8lVnldy7qnL86eBypioJVHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 253/314] x86/idt: Keep spurious entries unset in system_vectors
Date:   Tue, 23 Jun 2020 21:57:28 +0200
Message-Id: <20200623195351.031629578@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 87ef69a72c52e..7bb4c3cbf4dcd 100644
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



