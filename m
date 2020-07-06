Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33270C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036A0206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u4F+7aE2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="26tDryE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgGFQmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:42:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55670 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729500AbgGFQmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:42:25 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594053743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gEVJsPceN/fHxYmnHe+PN+piF0gnfPqlWXqfVUDU7n0=;
        b=u4F+7aE2my96lPVoOS2LTrOc21ynXiTYsV3VJa9JILAfj/rsZOOcfnS/bRmOAcMEGTZfFm
        Y371V5ozg5XsdwJ+kMPCTPoIT56r/YERxL+GpvRzPyxeQrw1PgsLGe5Yryiv66drBUrKYs
        SqKHYk/jwN9jkgC4pmj6IFEWoxcte0faSojERkRL8dfPQJPg2r/j1/YbtJ9qhCJJv8htCu
        YyK0+JpZ9tqEmZuy2Cd4oTPeENl0ptC9cCUa6QC/Nks4WRd7OGlMa5GwVd7fcThU1dbiJN
        KlI52nL9vnCfhO135LlV+byFf8iIbihX4hmOfBBauiyi7bUMQAFDneio5cRF0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594053743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gEVJsPceN/fHxYmnHe+PN+piF0gnfPqlWXqfVUDU7n0=;
        b=26tDryE3GYlZ+P9OoGycBfQ6RjkalWL/LxRPu0njk2xNjWOmvD+kPuBw904JyOQSPzxnwM
        yUU/N7s7j7CGdGCQ==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] x86/alternatives: Let __text_poke() acquire the pte lock with enabled interrupts
Date:   Mon,  6 Jul 2020 18:42:15 +0200
Message-Id: <20200706164215.2502730-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pte lock is never acquired from an IRQ-off region so it does not
require the interrupts to be disabled.
RT complains here because the spinlock_t must not be acquired with
disabled interrupts.

use_temporary_mm() expects interrupts to be off because it invokes
switch_mm_irqs_off() and uses per-CPU (current active mm) data.

Move local_irq_save() after the the pte lock has been acquired. Move
local_irq_restore() after the pte lock has been released.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/alternative.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8fd39ff74a499..7c59a87ebbde8 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -872,8 +872,6 @@ static void *__text_poke(void *addr, const void *opcode=
, size_t len)
 	 */
 	BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));
=20
-	local_irq_save(flags);
-
 	/*
 	 * Map the page without the global bit, as TLB flushing is done with
 	 * flush_tlb_mm_range(), which is intended for non-global PTEs.
@@ -890,6 +888,8 @@ static void *__text_poke(void *addr, const void *opcode=
, size_t len)
 	 */
 	VM_BUG_ON(!ptep);
=20
+	local_irq_save(flags);
+
 	pte =3D mk_pte(pages[0], pgprot);
 	set_pte_at(poking_mm, poking_addr, ptep, pte);
=20
@@ -939,8 +939,8 @@ static void *__text_poke(void *addr, const void *opcode=
, size_t len)
 	 */
 	BUG_ON(memcmp(addr, opcode, len));
=20
-	pte_unmap_unlock(ptep, ptl);
 	local_irq_restore(flags);
+	pte_unmap_unlock(ptep, ptl);
 	return addr;
 }
=20
--=20
2.27.0

