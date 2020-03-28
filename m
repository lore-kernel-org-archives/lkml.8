Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF73C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FC820717
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC1SHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 14:07:19 -0400
Received: from mx.sdf.org ([205.166.94.20]:54286 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgC1SHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 14:07:19 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SI7B3a022693
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 18:07:11 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SI7BeD000981;
        Sat, 28 Mar 2020 18:07:11 GMT
Date:   Sat, 28 Mar 2020 18:07:11 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     linux-kernel@vger.kernel.org,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        lkml@sdf.org
Subject: Re: [RFC PATCH v1 09/50] <linux/random.h> prandom_u32_max() for
 power-of-2 ranges
Message-ID: <20200328180711.GC5859@SDF.ORG>
References: <202003281643.02SGh9n2025458@sdf.org>
 <20200328103229.132a047f@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328103229.132a047f@hermes.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 10:32:29AM -0700, Stephen Hemminger wrote:
> On Sat, 16 Mar 2019 02:32:04 -0400
> George Spelvin <lkml@sdf.org> wrote:
> 
>> +static inline u32 prandom_u32_max(u32 range)
>>  {
>> -	return (u32)(((u64) prandom_u32() * ep_ro) >> 32);
>> +	/*
>> +	 * If the range is a compile-time constant power of 2, then use
>> +	 * a simple shift.  This is mathematically equivalent to the
>> +	 * multiplication, but GCC 8.3 doesn't optimize that perfectly.
>> +	 *
>> +	 * We could do an AND with a mask, but
>> +	 * 1) The shift is the same speed on a decent CPU,
>> +	 * 2) It's generally smaller code (smaller immediate), and
>> +	 * 3) Many PRNGs have trouble with their low-order bits;
>> +	 *    using the msbits is generaly preferred.
>> +	 */
>> +	if (__builtin_constant_p(range) && (range & (range - 1)) == 0)
>> +		return prandom_u32() / (u32)(0x100000000 / range);
>> +	else
>> +		return reciprocal_scale(prandom_u32(), range);

> The optimization is good, but I don't think that the compiler
> is able to propogate the constant property into the function.
> Did you actually check the generated code?

Yes, I checked repeatedly during development.  I just rechecked the
exact code (it's been a while), and verified that

unsigned foo(void)
{
	return prandom_u32_max(256);
}

compiles to
foo:
.LFB1:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	prandom_u32@PLT
	shrl	$24, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE1:
	.size	foo, .-foo

But you prompted me to check a few other architectures, and
it's true for them too.  E.g. m68k:

foo:
        jsr prandom_u32
        moveq #24,%d1
        lsr.l %d1,%d0
        rts

(68k is one architecture where the mask is faster than the shift,
so I could handle it separately, but it makes the code even uglier.
Basically, use masks for small ranges, and shifts for large ranges,
and an arch-dependent threshold that depends on the available
immediate constant range.)

ARM, PowerPC, and MIPS all have some hideously large function preamble
code, but the core is a right shift.  E.g.

foo:
.LFB1:
	.cfi_startproc
	stwu 1,-16(1)
	.cfi_def_cfa_offset 16
	mflr 0
	.cfi_register 65, 0
	bcl 20,31,.L2
.L2:
	stw 30,8(1)
	.cfi_offset 30, -8
	mflr 30
	addis 30,30,.LCTOC1-.L2@ha
	stw 0,20(1)
	addi 30,30,.LCTOC1-.L2@l
	.cfi_offset 65, 4
	bl prandom_u32+32768@plt
	lwz 0,20(1)
	lwz 30,8(1)
	addi 1,1,16
	.cfi_restore 30
	.cfi_def_cfa_offset 0
	srwi 3,3,24
	mtlr 0
	.cfi_restore 65
	blr
