Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC64C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D110B2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 04:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="b1p8qScJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgGUEEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 00:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgGUEEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 00:04:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19628C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:04:47 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id t11so10083709pfq.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 21:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=8WVvQB40RK6deZ4Cy8t+mvWJCvDXakAnuO2sCFnXikw=;
        b=b1p8qScJ8GMb4ibmmM5cZtXTLkFKOD3JrCeBI1OZKIm858b3i43FB7wdkJwsC0b6NR
         iZBQBCgY9/ko7mN2IszymALJ/LJ5iXQkaE8iA01ymARxxPXFRDqEzyAS8iaE3B1eI0DX
         HTEB3LrHTCXWnXgP5O2rbjCnWowYP78cMmmCUSEfIA4712jGTww+BNEVuqSmfhzKJwMU
         0sf4DWKT0Jf+WaPh9UfcAr4/T7pNn2I2ehMEI9tI0+BLnIrOD8Qzu2NwPb/5AtEMyR54
         p6aSUNCweq1bhauXUf+xb1AOsUa5jrRQ1AAXIT34vapUZD7KNWrCRyCvRPnFtvPGYUEW
         IzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8WVvQB40RK6deZ4Cy8t+mvWJCvDXakAnuO2sCFnXikw=;
        b=sMhHbxTQeSovURBb3fJxpsGeb9hu4ykl61LuFjKCoZeVHkoc9WdPhuqaPEjmfPW1C9
         XSWwO67ZM1g6UbnYFrOSqRLmGrAy4wRz15yW/jPsG5fUDxIYGt2hyeuelFmJbjWJPSdu
         Z+k8lyiNoPOAH/LrM10sSSAEN0lCuFQ2O9RvVaRhbXN7/mUwJIF/BrLo1Ep35QNz2AFL
         stRvEK8kTGRUqpyZemBJxrE/a2RkF2dq7YTo+ZNL62UcSwvHW9AAqJ00CIx6hQoFfilK
         CEM9g1kAtsCv3HB693YkljfikEaVqQqzx1cf4eN4HlQu1ns6VP+ljmakLGt1TNkM6OD3
         YONw==
X-Gm-Message-State: AOAM533O5ABO2G9HFYR1pTu9Y0/3lixb3XYxY3EbFTZ4G56dK7XD22Rm
        K0KJ3UYOzuNTBZaIQqux8Lwu/blzk5Q=
X-Google-Smtp-Source: ABdhPJwcorN1zvHIybHoAI5GKQ95HluyT6lT3U/PXCFvcD8tDszHDeZN5LygqdAtDnq4WsM835oBHg==
X-Received: by 2002:a62:6047:: with SMTP id u68mr21561090pfb.238.1595304286185;
        Mon, 20 Jul 2020 21:04:46 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id r204sm18981148pfc.134.2020.07.20.21.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 21:04:45 -0700 (PDT)
Date:   Mon, 20 Jul 2020 21:04:45 -0700 (PDT)
X-Google-Original-Date: Mon, 20 Jul 2020 21:04:43 PDT (-0700)
Subject:     Re: [PATCH] riscv: Select ARCH_HAS_DEBUG_VM_PGTABLE
In-Reply-To: <0d7d0c38-5b67-1793-47d7-b8a7714838ee@arm.com>
CC:     kernel@esmil.dk, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     anshuman.khandual@arm.com
Message-ID: <mhng-2f6b1241-9ab3-47a2-bc23-789d59a3fd8f@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 20:20:54 PDT (-0700), anshuman.khandual@arm.com wrote:
>
>
> On 07/15/2020 02:56 AM, Emil Renner Berthing wrote:
>> This allows the pgtable tests to be built.
>>
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> ---
>>
>> The tests seem to succeed both in Qemu and on the HiFive Unleashed
>>
>> Both with and without the recent additions in
>> https://lore.kernel.org/linux-riscv/1594610587-4172-1-git-send-email-anshuman.khandual@arm.com/
>
> That's great, thanks for testing.

Actually, looking at this I'm not sure it actually helps us any.  This changes
the behavior of two functions.  Pulling out the relevant sections, I see:

unsigned int __sw_hweight32(unsigned int w)
{
#ifdef CONFIG_ARCH_HAS_FAST_MULTIPLIER
        w -= (w >> 1) & 0x55555555;
        w =  (w & 0x33333333) + ((w >> 2) & 0x33333333);
        w =  (w + (w >> 4)) & 0x0f0f0f0f;
        return (w * 0x01010101) >> 24;
#else
        unsigned int res = w - ((w >> 1) & 0x55555555);
        res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
        res = (res + (res >> 4)) & 0x0F0F0F0F;
        res = res + (res >> 8);
        return (res + (res >> 16)) & 0x000000FF;
#endif
}

and

unsigned long memchr_inv(unsigned long value64)
{
#if defined(CONFIG_ARCH_HAS_FAST_MULTIPLIER) && BITS_PER_LONG == 64
        value64 *= 0x0101010101010101ULL;
#elif defined(CONFIG_ARCH_HAS_FAST_MULTIPLIER)
        value64 *= 0x01010101;
        value64 |= value64 << 32;
#else
        value64 |= value64 << 8;
        value64 |= value64 << 16;
        value64 |= value64 << 32;
#endif
	return value64;
}

GCC optimizer the multiplication out of the first one:

__sw_hweight32:
	li	a4,1431654400
	srliw	a5,a0,1
	addi	a4,a4,1365
	and	a5,a5,a4
	subw	a0,a0,a5
	li	a5,858992640
	srliw	a4,a0,2
	addi	a5,a5,819
	and	a0,a5,a0
	and	a5,a5,a4
	addw	a5,a0,a5
	srliw	a0,a5,4
	addw	a0,a0,a5
	li	a5,252645376
	addi	a5,a5,-241
	and	a5,a5,a0
	srliw	a0,a5,8
	addw	a5,a0,a5
	srliw	a0,a5,16
	addw	a0,a0,a5
	andi	a0,a0,0xff
	ret

__sw_hweight32:
	li	a5,1431654400
	srliw	a4,a0,1
	addi	a5,a5,1365
	and	a5,a5,a4
	subw	a0,a0,a5
	li	a5,858992640
	srliw	a4,a0,2
	addi	a5,a5,819
	and	a0,a5,a0
	and	a5,a5,a4
	addw	a5,a0,a5
	srliw	a0,a5,4
	addw	a5,a0,a5
	li	a0,252645376
	addi	a0,a0,-241
	and	a5,a0,a5
	slliw	a0,a5,8
	addw	a0,a0,a5
	slliw	a5,a0,16
	addw	a0,a0,a5
	srliw	a0,a0,24
	ret

so that doesn't matter.  The second one is really a wash: 

memchr_inv:
	ld	a5,.LC0
	mul	a0,a0,a5
	ret
.rodata
.LC0:
	.dword	72340172838076673

vs

memchr_inv:
	slli	a5,a0,8
	or	a5,a5,a0
	slli	a0,a5,16
	or	a0,a0,a5
	slli	a5,a0,32
	or	a0,a5,a0
	ret

It's unlikely that load ends up relaxed, so it's going to be two instructions.
That means we have 4 cycles to forward the load and multiply, for a cache hit.
IIRC the multiplier on the existing hardware isn't that fast -- GCC lists it as
imul as 10 cycles, but I remember it being more like 5 so that might just be an
architecture-inaccurate tuning in the generic pipeline model.  This is out of
the inner loop, so it's probably not all that important anyway.  The result
isn't used for a while so on a bigger machine it's probably worth picking the
smaller code path, but it seems like a very small thing to optimize for either
way.

I'm actually a bit surprised about this.  Do you have benchmarks that indicate
ARCH_HAS_FAST_MULTIPLIER is actually faster?  Otherwise I guess I'm going to
reject this, as it's really more
ARCH_HAS_FAST_MULTIPLIER_AND_FAST_LARGE_CONSTANTS than just
ARCH_HAS_FAST_MULTIPLIER.
