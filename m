Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC48BC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEA120769
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 17:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbgDHRRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 13:17:46 -0400
Received: from foss.arm.com ([217.140.110.172]:41594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbgDHRRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 13:17:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20B1031B;
        Wed,  8 Apr 2020 10:17:45 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4929B3F52E;
        Wed,  8 Apr 2020 10:17:44 -0700 (PDT)
Date:   Wed, 8 Apr 2020 18:17:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Fredrik Strupe <fredrik@strupe.net>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will.deacon@arm.com
Subject: Re: [PATCH v2] arm64: armv8_deprecated: Fix undef_hook mask for
 thumb setend
Message-ID: <20200408171741.GB2481@gaia>
References: <911db2f1-e078-a460-32ee-154a0b4de5d4@strupe.net>
 <20200407092744.GA2665@gaia>
 <a2b345a4-30a0-3218-8c8d-e84ec2317dc9@arm.com>
 <0d7b582a-1bd0-9db2-2fdc-04fc887f64c6@strupe.net>
 <20200408090111.GA27331@gaia>
 <9979396e-5d01-0cfe-722f-3a4f6e81dc01@strupe.net>
 <ab77076b-774d-9158-bc0c-3cfdd36b6e37@strupe.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab77076b-774d-9158-bc0c-3cfdd36b6e37@strupe.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 01:29:41PM +0200, Fredrik Strupe wrote:
> For thumb instructions, call_undef_hook() in traps.c first reads a u16,
> and if the u16 indicates a T32 instruction (u16 >= 0xe800), a second
> u16 is read, which then makes up the the lower half-word of a T32
> instruction. For T16 instructions, the second u16 is not read,
> which makes the resulting u32 opcode always have the upper half set to
> 0.
> 
> However, having the upper half of instr_mask in the undef_hook set to 0
> masks out the upper half of all thumb instructions - both T16 and T32.
> This results in trapped T32 instructions with the lower half-word equal
> to the T16 encoding of setend (b650) being matched, even though the upper
> half-word is not 0000 and thus indicates a T32 opcode.
> 
> An example of such a T32 instruction is eaa0b650, which should raise a
> SIGILL since T32 instructions with an eaa prefix are unallocated as per
> Arm ARM, but instead works as a SETEND because the second half-word is set
> to b650.
> 
> This patch fixes the issue by extending instr_mask to include the
> upper u32 half, which will still match T16 instructions where the upper
> half is 0, but not T32 instructions.
> 
> Signed-off-by: Fredrik Strupe <fredrik@strupe.net>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Fixes: 2d888f48e056 ("arm64: Emulate SETEND for AArch32 tasks")

Queued for 5.7. Thanks.

-- 
Catalin
