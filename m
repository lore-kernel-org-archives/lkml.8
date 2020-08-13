Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE5AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC62A20771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wop42E5j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L3mjj02s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHMKua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:50:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57868 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgHMKu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:50:29 -0400
Date:   Thu, 13 Aug 2020 12:50:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597315827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V7i1yZX8DIk+MQSTkmAin3ENIS5cbZh88bPdS9M7IIc=;
        b=Wop42E5jWlVlSx9kb9R+JiB3JOVibb4tCFU6a4HpAzC3fFREfzwuo+fNDfcUl7PYOifKAc
        y/B0YCZQmjTM32EdEPLWmurCWUqgc7nK/q63TIDM663CN1UJHE6NGwAPhfaxQyWQHmnwpV
        R2LD7rYDAcfHlFxasq8wxofP7atBfy0rFuCH+l6+LvhdPV6DdlhUvJL5RLkaMrfHQ0Y/JH
        p0caVVvExlqr2nr6M/0yDlccnB+eAjn1/jLQ57vkDBsaUuJjpL63DzhD3siZYv3YPstEYj
        vmCDu6pjGS5R+WNbNjaswC6mZaaQP4vH9RvtUCBnne1eb73+0qWNGpOVvocQTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597315827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V7i1yZX8DIk+MQSTkmAin3ENIS5cbZh88bPdS9M7IIc=;
        b=L3mjj02s95CVz8uisHiDXqScGCDBqsLNqdsDzxAzUBfjjeEBhsAFwHdbGZwqpuwJ7hkppy
        sC0HnltNFpaLMVBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2] x86/alternatives: Let __text_poke() acquire the pte lock
 with enabled interrupts
Message-ID: <20200813105026.bvugytmsso6muljw@linutronix.de>
References: <20200706164215.2502730-1-bigeasy@linutronix.de>
 <87eeoc53o2.fsf@nanos.tec.linutronix.de>
 <20200813104707.fxydmk6ctiwjql75@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200813104707.fxydmk6ctiwjql75@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pte lock is never acquired in-IRQ context so it does not require the
interrupts to be disabled.

RT complains here because the spinlock_t must not be acquired with
disabled interrupts.

use_temporary_mm() expects interrupts to be off because it invokes
switch_mm_irqs_off() and uses per-CPU (current active mm) data.

Move the PTE lock handling outside the interrupt disabled region.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2: Reword the patch description.

 arch/x86/kernel/alternative.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -875,8 +875,6 @@ static void *__text_poke(void *addr, con
 	 */
 	BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));
=20
-	local_irq_save(flags);
-
 	/*
 	 * Map the page without the global bit, as TLB flushing is done with
 	 * flush_tlb_mm_range(), which is intended for non-global PTEs.
@@ -893,6 +891,8 @@ static void *__text_poke(void *addr, con
 	 */
 	VM_BUG_ON(!ptep);
=20
+	local_irq_save(flags);
+
 	pte =3D mk_pte(pages[0], pgprot);
 	set_pte_at(poking_mm, poking_addr, ptep, pte);
=20
@@ -942,8 +942,8 @@ static void *__text_poke(void *addr, con
 	 */
 	BUG_ON(memcmp(addr, opcode, len));
=20
-	pte_unmap_unlock(ptep, ptl);
 	local_irq_restore(flags);
+	pte_unmap_unlock(ptep, ptl);
 	return addr;
 }
=20
