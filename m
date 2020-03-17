Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83337C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1842075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584478921;
	bh=U57LyJghsjeiPtAtTLPXCjGsnVcnXSXPnKEiXhlMHk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2aSsrdzg8QJoGIQrMeQpGQmzlCq+mp1jIkfDEzS4wT3SkKZKuwbDmCLwoCFXqypUX
	 WAJda9KS6U5Q02c7J39gBNK2hmr+wCGabmhDZLPYo0DVOYf5miEzWq+SJzugb8KRx1
	 ddPzMdzrLcxd9ctQ95qkM9yxabl+9FRDkcOyda6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgCQVCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbgCQVB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:01:59 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 251D42051A;
        Tue, 17 Mar 2020 21:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584478919;
        bh=U57LyJghsjeiPtAtTLPXCjGsnVcnXSXPnKEiXhlMHk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AdjUeQBkECR3/3jMUEzPlKStC/EKe86EYt7MekRUU8J7qVCc2PecOGBC5Q0RvTnjl
         2SYKAlC4uFBF0S2+SkBPdbAlFN2dxNJvdXWD95/IItFhmZkAZRDqtYhkfoydnRP1M+
         e2r2otpHwEJOtVu886GnbWU00FAjpDxRH2wRPWrY=
Date:   Tue, 17 Mar 2020 21:01:54 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] arm64: fix the missing ktpi= cmdline check in
 arm64_kernel_unmapped_at_el0()
Message-ID: <20200317210154.GA19752@willie-the-truck>
References: <20200317114708.109283-1-yaohongbo@huawei.com>
 <20200317121050.GH8831@lakrids.cambridge.arm.com>
 <20200317124323.GA16200@willie-the-truck>
 <20200317135719.GH3971@sirena.org.uk>
 <20200317151813.GA16579@willie-the-truck>
 <20200317163638.GI3971@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317163638.GI3971@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 04:36:38PM +0000, Mark Brown wrote:
> On Tue, Mar 17, 2020 at 03:18:14PM +0000, Will Deacon wrote:
> > On Tue, Mar 17, 2020 at 01:57:19PM +0000, Mark Brown wrote:
> > > On Tue, Mar 17, 2020 at 12:43:24PM +0000, Will Deacon wrote:
> > > > On Tue, Mar 17, 2020 at 12:10:51PM +0000, Mark Rutland wrote:
> > > > > On Tue, Mar 17, 2020 at 07:47:08PM +0800, Hongbo Yao wrote:
> 
> > > > > > -	return arm64_use_ng_mappings;
> > > > > > +	return arm64_use_ng_mappings &&
> > > > > > +		cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
> 
> > > > This probably isn't the right fix, since this will mean that early mappings
> > > > will be global and we'll have to go through the painful page-table rewrite
> > > > logic when the cap gets enabled for KASLR-enabled kernels.
> 
> > > Aren't we looking for a rewrite from non-global to global here (disable
> > > KPTI where we would otherwise have it), which we don't currently have
> > > code for?
> 
> > What I mean is that cpus_have_const_cap() will be false initially, so we'll
> > put down global mappings early on because PTE_MAYBE_NG will be 0, which
> > means that we'll have to invoke the rewriting code if we then realise we
> > want non-global mappings after the caps are finalised.
> 
> Ah, I see - a different case to the one originally reported but also an
> issue.
> 
> > > That is probably a good idea but I think that runs too late to affect
> > > the early mappings, they're done based on kaslr_requires_kpti() well
> > > before we start secondaries.  My first pass not having paged everything
> > > back in yet is that there needs to be command line parsing in
> > > kaslr_requires_kpti() but as things stand the command line isn't
> > > actually ready then...
> 
> > Yeah, and I think you probably run into chicken and egg problems mapping
> 
> The whole area is just a mess.
> 
> > the thing. With the change above, it's true that /some/ mappings will
> > still be nG if you pass kpti=off, but I was hoping that didn't really matter
> > :)
> 
> > What was the behaviour prior to your patch? If it used to work without
> > any nG mappings, then I suppose we should try to restore that behaviour.
> 
> I'd need to go back and retest to confirm but it looks like always had
> the issue that we'd install some nG mappings early even with KPTI
> disabled on the command line so your change is just restoring the
> previous behaviour and we're no worse than we were before.

Urgh, this code brings back really bad memories :( :( :(

I just ran 5.4 and it looks like we leave everything non-global with KASLR,
even when "kpti=off". Great -- that means we're ok with my patch! Well, we
would be except that when we finalise the linear mapping we'll end up trying
to transition the old non-global entry to global, which is a break-before-make
violation (we panic early in __create_pgd_mapping()).

Staring more at the code, I think we're conflating the global/non-global
mappings with whether or not the kpti trampoline is active and it looks like
this might lead to other issues in mainline right now -- for example, I
don't think we clear TPIDRRO_EL0 properly for native tasks because the
arm64_kernel_unmapped_at_el0() check in tls_thread_switch() will defer the
zeroing to the trampoline code, but that might not even run!

So I've hacked the following, which appears to work but damn I'd like
somebody else to look at this. I also have a nagging feeling that you
implemented it like this at some point, but we tried to consolidate things
during review.

Thoughts?

Will

--->8

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index e4d862420bb4..d79ce6df9e12 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -29,11 +29,9 @@ typedef struct {
  */
 #define ASID(mm)	((mm)->context.id.counter & 0xffff)
 
-extern bool arm64_use_ng_mappings;
-
 static inline bool arm64_kernel_unmapped_at_el0(void)
 {
-	return arm64_use_ng_mappings;
+	return cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
 }
 
 typedef void (*bp_hardening_cb_t)(void);
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 6f87839f0249..1305e28225fc 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -23,11 +23,13 @@
 
 #include <asm/pgtable-types.h>
 
+extern bool arm64_use_ng_mappings;
+
 #define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
 #define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
 
-#define PTE_MAYBE_NG		(arm64_kernel_unmapped_at_el0() ? PTE_NG : 0)
-#define PMD_MAYBE_NG		(arm64_kernel_unmapped_at_el0() ? PMD_SECT_NG : 0)
+#define PTE_MAYBE_NG		(arm64_use_ng_mappings ? PTE_NG : 0)
+#define PMD_MAYBE_NG		(arm64_use_ng_mappings ? PMD_SECT_NG : 0)
 
 #define PROT_DEFAULT		(_PROT_DEFAULT | PTE_MAYBE_NG)
 #define PROT_SECT_DEFAULT	(_PROT_SECT_DEFAULT | PMD_MAYBE_NG)
