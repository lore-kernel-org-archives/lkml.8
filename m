Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED781C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85312051A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgCWTEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:04:13 -0400
Received: from foss.arm.com ([217.140.110.172]:53372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbgCWTEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:04:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B40CC31B;
        Mon, 23 Mar 2020 12:04:12 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB8EA3F52E;
        Mon, 23 Mar 2020 12:04:11 -0700 (PDT)
Date:   Mon, 23 Mar 2020 19:04:09 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>,
        will@kernel.org, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: clean up trampoline vector loads
Message-ID: <20200323190408.GE4892@mbp>
References: <1938400.7m7sAWtiY1@basile.remlab.net>
 <20200319091407.51449-1-remi@remlab.net>
 <20200323120700.GB2597@C02TD0UTHF1T.local>
 <2345780.q8flsOIESp@basile.remlab.net>
 <20200323121437.GC2597@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200323121437.GC2597@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 12:14:37PM +0000, Mark Rutland wrote:
> On Mon, Mar 23, 2020 at 02:08:53PM +0200, Rémi Denis-Courmont wrote:
> > Le maanantaina 23. maaliskuuta 2020, 14.07.00 EET Mark Rutland a écrit :
> > > On Thu, Mar 19, 2020 at 11:14:05AM +0200, Rémi Denis-Courmont wrote:
> > > > From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> > > > 
> > > > This switches from custom instruction patterns to the regular large
> > > > memory model sequence with ADRP and LDR. In doing so, the ADD
> > > > instruction can be eliminated in the SDEI handler, and the code no
> > > > longer assumes that the trampoline vectors and the vectors address both
> > > > start on a page boundary.
> > > > 
> > > > Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> > > > ---
> > > > 
> > > >  arch/arm64/kernel/entry.S | 9 ++++-----
> > > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > > > index e5d4e30ee242..24f828739696 100644
> > > > --- a/arch/arm64/kernel/entry.S
> > > > +++ b/arch/arm64/kernel/entry.S
> > > > @@ -805,9 +805,9 @@ alternative_else_nop_endif
> > > > 
> > > >  2:
> > > >  	tramp_map_kernel	x30
> > > >  
> > > >  #ifdef CONFIG_RANDOMIZE_BASE
> > > > 
> > > > -	adr	x30, tramp_vectors + PAGE_SIZE
> > > > +	adrp	x30, tramp_vectors + PAGE_SIZE
> > > > 
> > > >  alternative_insn isb, nop, ARM64_WORKAROUND_QCOM_FALKOR_E1003
> > > > 
> > > > -	ldr	x30, [x30]
> > > > +	ldr	x30, [x30, #:lo12:__entry_tramp_data_start]
> > > 
> > > I think this is busted for !4K kernels once we reduce the alignment of
> > > __entry_tramp_data_start.
> > > 
> > > The ADRP gives us a 64K aligned address (with bits 15:0 clear). The lo12
> > > relocation gives us bits 11:0, so we haven't accounted for bits 15:12.
> > 
> > IMU, ADRP gives a 4K aligned value, regardless of MMU (TCR) settings.
> 
> Sorry, I had erroneously assumed tramp_vectors was page aligned. The
> issue still stands -- we haven't accounted for bits 15:12, as those can
> differ between tramp_vectors and __entry_tramp_data_start.

Should we just use adrp on __entry_tramp_data_start? Anyway, the diff
below doesn't solve the issue I'm seeing (only reverting patch 3).

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index ca1340eb46d8..4cc9d1df3985 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -810,7 +810,7 @@ alternative_else_nop_endif
 2:
 	tramp_map_kernel	x30
 #ifdef CONFIG_RANDOMIZE_BASE
-	adrp	x30, tramp_vectors + PAGE_SIZE
+	adrp	x30, __entry_tramp_data_start
 alternative_insn isb, nop, ARM64_WORKAROUND_QCOM_FALKOR_E1003
 	ldr	x30, [x30, #:lo12:__entry_tramp_data_start]
 #else
@@ -964,7 +964,7 @@ SYM_CODE_START(__sdei_asm_entry_trampoline)
 1:	str	x4, [x1, #(SDEI_EVENT_INTREGS + S_ORIG_ADDR_LIMIT)]
 
 #ifdef CONFIG_RANDOMIZE_BASE
-	adrp	x4, tramp_vectors + PAGE_SIZE
+	adrp	x4, __sdei_asm_trampoline_next_handler
 	ldr	x4, [x4, #:lo12:__sdei_asm_trampoline_next_handler]
 #else
 	ldr	x4, =__sdei_asm_handler

-- 
Catalin
