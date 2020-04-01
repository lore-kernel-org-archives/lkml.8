Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B179C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CA62080C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQpMoqpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbgDAKhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:37:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55767 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727386AbgDAKhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585737459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RUpxmRN4twru0bIi7VknK4K+lKRCP04ScEp4cAJ17Oo=;
        b=jQpMoqpA1xRQc2C2UmVmCAKgngBg47pInczF+R7ES8dFiyAKSrU4gEsaViN8p4H6hfMgNG
        NreIbyjXn/wNowXiDXq7EEVEEKHKxeWgN2Z3Khv7Ye7Ue5tglCeusQImhhTp2D55N+kRYz
        g2sGemMWyML47LeHdChuXb1pEdGL7rg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-OTHgpj1UNlCNqO1lIN--sg-1; Wed, 01 Apr 2020 06:37:36 -0400
X-MC-Unique: OTHgpj1UNlCNqO1lIN--sg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EAE18018C8;
        Wed,  1 Apr 2020 10:37:34 +0000 (UTC)
Received: from mail (ovpn-112-247.rdu2.redhat.com [10.10.112.247])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6778F5D9CD;
        Wed,  1 Apr 2020 10:37:31 +0000 (UTC)
Date:   Tue, 31 Mar 2020 20:32:03 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Mark Salter <msalter@redhat.com>,
        Jon Masters <jcm@jonmasters.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Michal Hocko <mhocko@kernel.org>, QI Fuli <qi.fuli@fujitsu.com>
Subject: Re: [PATCH 3/3] arm64: tlb: skip tlbi broadcast
Message-ID: <20200401003203.GA12536@redhat.com>
References: <20200223192520.20808-1-aarcange@redhat.com>
 <20200223192520.20808-4-aarcange@redhat.com>
 <20200309112242.GB2487@mbp>
 <20200314031609.GB2250@redhat.com>
 <20200316140906.GA6220@lakrids.cambridge.arm.com>
 <20200331094034.GA1131@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331094034.GA1131@C02TD0UTHF1T.local>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On Tue, Mar 31, 2020 at 10:45:11AM +0100, Mark Rutland wrote:
> Hi Andrea,
> 
> On Mon, Mar 16, 2020 at 02:09:07PM +0000, Mark Rutland wrote:
> > AFAICT, this series relies on:
> > 
> > * An ISB completing prior page table walks when updating TTBR. I don't
> >   believe this is necessarily the case, given how things work for an
> >   EL1->EL2 transition where there can be ongoing EL1 walks.
> 
> I've had confirmation that a DSB is necessary (after the MSR and ISB) to
> complete any ongoing translation table walks for the stale context.
> 
> Without a DSB, those walks can observe subsequent stores and encounter
> the usual set of CONSTRAINED UNPREDICTABLE behaviours (e.g. walking into
> MMIO with side-effects, continuing from amalgamted entries, etc). Those
> issues are purely to do with the walk, and apply regardless of whether
> the resulting translations are architecturally consumed.

Ok, sorry I didn't get it earlier... I attempted a quick fix below.

From ab30d8082be62fe24a97eceec5dbfeea8e278511 Mon Sep 17 00:00:00 2001
From: Andrea Arcangeli <aarcange@redhat.com>
Date: Tue, 31 Mar 2020 20:03:43 -0400
Subject: [PATCH 1/1] arm64: tlb: skip tlbi broadcast, fix speculative tlb
 lookups

Without DSB in between "MSR; ISB" and "atomic_dec(&nr_active_mm)"
there's the risk a speculative pagecache lookup may still be walking
pagetables of the unloaded asid after nr_active_mm has been
decreased. In such case the remote CPU could free the pagetables and
reuse the memory without first issuing a tlbi broadcast, while the
speculative tlb lookup still runs on the unloaded asid. For this
reason the speculative pagetable walks needs to be flushed before
decreasing nr_active_mm.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 arch/arm64/include/asm/mmu_context.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 9c66fe317e2f..d821ea3ce839 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -210,8 +210,18 @@ enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 	if (per_cpu(cpu_not_lazy_tlb, cpu) &&
 	    is_idle_task(tsk)) {
 		per_cpu(cpu_not_lazy_tlb, cpu) = false;
-		if (!system_uses_ttbr0_pan())
+		if (!system_uses_ttbr0_pan()) {
 			cpu_set_reserved_ttbr0();
+			/*
+			 * DSB will flush the speculative pagetable
+			 * walks on the old asid. It's required before
+			 * decreasing nr_active_mm because after
+			 * decreasing nr_active_mm the tlbi broadcast
+			 * may not happen on the unloaded asid before
+			 * the pagetables are freed.
+			 */
+			dsb(ish);
+		}
 		atomic_dec(&mm->context.nr_active_mm);
 	}
 	VM_WARN_ON(atomic_read(&mm->context.nr_active_mm) < 0);
@@ -249,6 +259,14 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	} else if (prev != next) {
 		atomic_inc(&next->context.nr_active_mm);
 		__switch_mm(next, cpu);
+		/*
+		 * DSB will flush the speculative pagetable walks on the old
+		 * asid. It's required before decreasing nr_active_mm because
+		 * after decreasing nr_active_mm the tlbi broadcast may not
+		 * happen on the unloaded asid before the pagetables are
+		 * freed.
+		 */
+		dsb(ish);
 		atomic_dec(&prev->context.nr_active_mm);
 	}
 	VM_WARN_ON(!atomic_read(&next->context.nr_active_mm));


I didn't test it yet, because this being a theoretical issue it is
better reviewed in the source.

> > * Walks never being initiated for `inactive` contexts within the current
> >   translation regime. e.g. while ASID x is installed, never starting a
> >   walk for ASID y. I can imagine that the architecture may permit a form
> >   of this starting with intermediate walk entries in the TLBs.
> 
> I'm still chasing this point.

Appreciated! I'll cross fingers you don't find the speculative lookups
can randomly start on unloaded ASID. That would also imply that it
would be impossible on arm64 to use different asid on different CPUs
as it is normally done on other arches.

Thanks,
Andrea

