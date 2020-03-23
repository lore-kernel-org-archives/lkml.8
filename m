Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615A1C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BCC2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgCWUme convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:42:34 -0400
Received: from poy.remlab.net ([94.23.215.26]:35310 "EHLO
        ns207790.ip-94-23-215.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgCWUme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:42:34 -0400
Received: from basile.remlab.net (87-92-31-51.bb.dnainternet.fi [87.92.31.51])
        (Authenticated sender: remi)
        by ns207790.ip-94-23-215.eu (Postfix) with ESMTPSA id 991185FB11;
        Mon, 23 Mar 2020 21:42:31 +0100 (CET)
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, will@kernel.org,
        james.morse@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: clean up trampoline vector loads
Date:   Mon, 23 Mar 2020 22:42:30 +0200
Message-ID: <2067644.cOvikPKVsA@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20200323190408.GE4892@mbp>
References: <1938400.7m7sAWtiY1@basile.remlab.net> <20200323121437.GC2597@C02TD0UTHF1T.local> <20200323190408.GE4892@mbp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le maanantaina 23. maaliskuuta 2020, 21.04.09 EET Catalin Marinas a écrit :
> On Mon, Mar 23, 2020 at 12:14:37PM +0000, Mark Rutland wrote:
> > On Mon, Mar 23, 2020 at 02:08:53PM +0200, Rémi Denis-Courmont wrote:
> > > Le maanantaina 23. maaliskuuta 2020, 14.07.00 EET Mark Rutland a écrit :
> > > > On Thu, Mar 19, 2020 at 11:14:05AM +0200, Rémi Denis-Courmont wrote:
> > > > > From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> > > > > 
> > > > > This switches from custom instruction patterns to the regular large
> > > > > memory model sequence with ADRP and LDR. In doing so, the ADD
> > > > > instruction can be eliminated in the SDEI handler, and the code no
> > > > > longer assumes that the trampoline vectors and the vectors address
> > > > > both
> > > > > start on a page boundary.
> > > > > 
> > > > > Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
> > > > > ---
> > > > > 
> > > > >  arch/arm64/kernel/entry.S | 9 ++++-----
> > > > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> > > > > index e5d4e30ee242..24f828739696 100644
> > > > > --- a/arch/arm64/kernel/entry.S
> > > > > +++ b/arch/arm64/kernel/entry.S
> > > > > @@ -805,9 +805,9 @@ alternative_else_nop_endif
> > > > > 
> > > > >  2:
> > > > >  	tramp_map_kernel	x30
> > > > >  
> > > > >  #ifdef CONFIG_RANDOMIZE_BASE
> > > > > 
> > > > > -	adr	x30, tramp_vectors + PAGE_SIZE
> > > > > +	adrp	x30, tramp_vectors + PAGE_SIZE
> > > > > 
> > > > >  alternative_insn isb, nop, ARM64_WORKAROUND_QCOM_FALKOR_E1003
> > > > > 
> > > > > -	ldr	x30, [x30]
> > > > > +	ldr	x30, [x30, #:lo12:__entry_tramp_data_start]
> > > > 
> > > > I think this is busted for !4K kernels once we reduce the alignment of
> > > > __entry_tramp_data_start.
> > > > 
> > > > The ADRP gives us a 64K aligned address (with bits 15:0 clear). The
> > > > lo12
> > > > relocation gives us bits 11:0, so we haven't accounted for bits 15:12.
> > > 
> > > IMU, ADRP gives a 4K aligned value, regardless of MMU (TCR) settings.
> > 
> > Sorry, I had erroneously assumed tramp_vectors was page aligned. The
> > issue still stands -- we haven't accounted for bits 15:12, as those can
> > differ between tramp_vectors and __entry_tramp_data_start.

Does that mean that the SDEI code never worked with page size > 4 KiB?

> Should we just use adrp on __entry_tramp_data_start? Anyway, the diff
> below doesn't solve the issue I'm seeing (only reverting patch 3).

AFAIU, the preexisting code uses the manual PAGE_SIZE offset because the offset 
in the main vmlinux does not match the architected offset inside the fixmap. If 
so, then using the symbol directly will not work at all.




> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index ca1340eb46d8..4cc9d1df3985 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -810,7 +810,7 @@ alternative_else_nop_endif
>  2:
>  	tramp_map_kernel	x30
>  #ifdef CONFIG_RANDOMIZE_BASE
> -	adrp	x30, tramp_vectors + PAGE_SIZE
> +	adrp	x30, __entry_tramp_data_start
>  alternative_insn isb, nop, ARM64_WORKAROUND_QCOM_FALKOR_E1003
>  	ldr	x30, [x30, #:lo12:__entry_tramp_data_start]
>  #else
> @@ -964,7 +964,7 @@ SYM_CODE_START(__sdei_asm_entry_trampoline)
>  1:	str	x4, [x1, #(SDEI_EVENT_INTREGS + S_ORIG_ADDR_LIMIT)]
> 
>  #ifdef CONFIG_RANDOMIZE_BASE
> -	adrp	x4, tramp_vectors + PAGE_SIZE
> +	adrp	x4, __sdei_asm_trampoline_next_handler
>  	ldr	x4, [x4, #:lo12:__sdei_asm_trampoline_next_handler]
>  #else
>  	ldr	x4, =__sdei_asm_handler


-- 
雷米‧德尼-库尔蒙
http://www.remlab.net/



