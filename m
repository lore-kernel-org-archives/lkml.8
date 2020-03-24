Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96A3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F2F20786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgCXKw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:52:27 -0400
Received: from foss.arm.com ([217.140.110.172]:60636 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgCXKw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:52:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC0B330E;
        Tue, 24 Mar 2020 03:52:26 -0700 (PDT)
Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2425D3F792;
        Tue, 24 Mar 2020 03:52:24 -0700 (PDT)
Date:   Tue, 24 Mar 2020 10:52:17 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     =?utf-8?B?UsOpbWk=?= Denis-Courmont <remi@remlab.net>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: clean up trampoline vector loads
Message-ID: <20200324105217.GA20256@C02TD0UTHF1T.local>
References: <1938400.7m7sAWtiY1@basile.remlab.net>
 <20200323121437.GC2597@C02TD0UTHF1T.local>
 <20200323190408.GE4892@mbp>
 <2067644.cOvikPKVsA@basile.remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2067644.cOvikPKVsA@basile.remlab.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 10:42:30PM +0200, Rémi Denis-Courmont wrote:
> Le maanantaina 23. maaliskuuta 2020, 21.04.09 EET Catalin Marinas a écrit :
> > On Mon, Mar 23, 2020 at 12:14:37PM +0000, Mark Rutland wrote:
> > > On Mon, Mar 23, 2020 at 02:08:53PM +0200, Rémi Denis-Courmont wrote:
> > > > Le maanantaina 23. maaliskuuta 2020, 14.07.00 EET Mark Rutland a écrit :
> > > > > On Thu, Mar 19, 2020 at 11:14:05AM +0200, Rémi Denis-Courmont wrote:
> > > > > > From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> > > > > > 
> > > > > > This switches from custom instruction patterns to the regular large
> > > > > > memory model sequence with ADRP and LDR. In doing so, the ADD
> > > > > > instruction can be eliminated in the SDEI handler, and the code no
> > > > > > longer assumes that the trampoline vectors and the vectors address
> > > > > > both
> > > > > > start on a page boundary.
> > > > > > 
> > > > > > Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> > > > > > ---
> > > > > > 
> > > > > >  arch/arm64/kernel/entry.S | 9 ++++-----
> > > > > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > > > > 
> > > > > > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > > > > > index e5d4e30ee242..24f828739696 100644
> > > > > > --- a/arch/arm64/kernel/entry.S
> > > > > > +++ b/arch/arm64/kernel/entry.S
> > > > > > @@ -805,9 +805,9 @@ alternative_else_nop_endif
> > > > > > 
> > > > > >  2:
> > > > > >  	tramp_map_kernel	x30
> > > > > >  
> > > > > >  #ifdef CONFIG_RANDOMIZE_BASE
> > > > > > 
> > > > > > -	adr	x30, tramp_vectors + PAGE_SIZE
> > > > > > +	adrp	x30, tramp_vectors + PAGE_SIZE
> > > > > > 
> > > > > >  alternative_insn isb, nop, ARM64_WORKAROUND_QCOM_FALKOR_E1003
> > > > > > 
> > > > > > -	ldr	x30, [x30]
> > > > > > +	ldr	x30, [x30, #:lo12:__entry_tramp_data_start]
> > > > > 
> > > > > I think this is busted for !4K kernels once we reduce the alignment of
> > > > > __entry_tramp_data_start.
> > > > > 
> > > > > The ADRP gives us a 64K aligned address (with bits 15:0 clear). The
> > > > > lo12
> > > > > relocation gives us bits 11:0, so we haven't accounted for bits 15:12.
> > > > 
> > > > IMU, ADRP gives a 4K aligned value, regardless of MMU (TCR) settings.
> > > 
> > > Sorry, I had erroneously assumed tramp_vectors was page aligned. The
> > > issue still stands -- we haven't accounted for bits 15:12, as those can
> > > differ between tramp_vectors and __entry_tramp_data_start.
> 
> Does that mean that the SDEI code never worked with page size > 4 KiB?

I think this happens to work, but is fragile. Because nothing happens to
get placed in .rodata between the _entry_tramp_data_start data and the
__sdei_asm_trampoline_next_handler data, the
__sdei_asm_trampoline_next_handler data doesn't spill into a separate
page from the _entry_tramp_data_start data.

If we did start adding stuff into .rodata between those two, there'd be
a bigger risk of things going wrong. That was why I suggested a
.entry.tramp.data section previously.

> > Should we just use adrp on __entry_tramp_data_start? Anyway, the diff
> > below doesn't solve the issue I'm seeing (only reverting patch 3).
> 
> AFAIU, the preexisting code uses the manual PAGE_SIZE offset because the offset 
> in the main vmlinux does not match the architected offset inside the fixmap. If 
> so, then using the symbol directly will not work at all.

Indeed. I can't see a neat way of avoiding this right now, so should we
drop these patches and leave the code as-is (but with comments as to the
special requirements that it has)?

Thanks,
Mark.
