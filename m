Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50CBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2E52074B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390051AbgE1Mud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389941AbgE1Mu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:50:28 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C319C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 05:50:28 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeHzK-00Gqq8-P8; Thu, 28 May 2020 12:50:22 +0000
Date:   Thu, 28 May 2020 13:50:22 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [git pull] coredump infoleak fix
Message-ID: <20200528125022.GK23230@ZenIV.linux.org.uk>
References: <20200527213447.GH23230@ZenIV.linux.org.uk>
 <20200528070255.GA790247@gmail.com>
 <20200528070552.GJ23230@ZenIV.linux.org.uk>
 <20200528074442.GB790247@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528074442.GB790247@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 09:44:42AM +0200, Ingo Molnar wrote:
> 
> * Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > On Thu, May 28, 2020 at 09:02:55AM +0200, Ingo Molnar wrote:
> > 
> > > Looks good to me.
> > > 
> > > I'm wondering, shouldn't we also zero-initialize the dump data to 
> > > begin with? See the patch below (untested).
> > 
> > Note that this hides the bug from KASAN, though ;-)  And the bug
> > is not just infoleak - not all components are "all zeroes" in the
> > init state.
> 
> Yeah, but is zero-init really a problem though? Wouldn't it be 
> 'better' to have all zeroes if the dump doesn't fit? But I might be 
> missing something ...

"Doesn't fit" case is irrelevant for coredump - it gets a full-sized
buffer there.  And you do not copy the components in init state into
it.  Note that the set actually written will be different for different
threads; it's _not_ "everything in xcr0".

See the comments in front of fpstate_sanitize_xstate():

 * When executing XSAVEOPT (or other optimized XSAVE instructions), if
 * a processor implementation detects that an FPU state component is still
 * (or is again) in its initialized state, it may clear the corresponding
 * bit in the header.xfeatures field, and can skip the writeout of registers
 * to the corresponding memory layout.

The part about cleared bits in header.xfeatures, that is.  That, BTW,
is why you need xfeatures_mxcsr_quirk() thing - XFEATURES_FP in xcr0 is
always set (xsetbv would throw a GPF if you tried to clear it there),
but the same bit in the header might very well be clear.  For the
threads that have FPU registers in init state, which is _not_ all-zeroes.
If not for that, xfeatures_mxcsr_quirk() would always return true.

============================================
13.11         OPERATION OF XSAVES
The operation of XSAVES is similar to that of XSAVEC. The main differences
are (1) XSAVES can be executed only if CPL = 0; (2) XSAVES can operate on
the state components whose bits are set in XCR0 | IA32_XSS and can thus
operate on supervisor state components; and (3) XSAVES uses the modified
optimization (see Section 13.6). See Section 13.2 for details of how to
determine whether XSAVES is supported.

The XSAVES instruction takes a single memory operand, which is an XSAVE
area. In addition, the register pair EDX:EAX is an implicit operand used
as a state-component bitmap (see Section 13.1) called the instruction mask.
EDX:EAX & (XCR0 | IA32_XSS) (the logical AND the instruction mask with the
logical OR of XCR0 and IA32_XSS) is the requested-feature bitmap (RFBM)
of the state components to be saved.

The following conditions cause execution of the XSAVES instruction to
generate a fault:

*   If the XSAVE feature set is not enabled (CR4.OSXSAVE = 0), an
    invalid-opcode exception (#UD) occurs.
*   If CR0.TS[bit 3] is 1, a device-not-available exception (#NM) occurs.
*   If CPL > 0 or if the address of the XSAVE area is not 64-byte aligned,
    a general-protection exception (#GP) occurs.

If none of these conditions cause a fault, execution of XSAVES writes the
XSTATE_BV field of the XSAVE header (see Section 13.4.2), setting
XSTATE_BV[i] (0 <= i <= 63) as follows:
*   If RFBM[i] = 0, XSTATE_BV[i] is written as 0.
*   If RFBM[i] = 1, XSTATE_BV[i] is set to the value of XINUSE[i] (see below
    for an exception made for XSTATE_BV[1]). Section 13.6 defines XINUSE to
    describe the processor init optimization and specifies the initial
    configuration of each state component. The nature of that optimization
    implies the following:
    -- If state component i is in its initial configuration, XSTATE_BV[i]
       may be written with either 0 or 1.
    -- If state component i is not in its initial configuration, XSTATE_BV[i]
       is written with 1.
    XINUSE[1] pertains only to the state of the XMM registers and not to MXCSR.
    However, if RFBM[1] = 1 and MXCSR does not have the value 1F80H, XSAVES
    writes XSTATE_BV[1] as 1 even if XINUSE[1] = 0.
    (As explained in Section 13.6, the initial configurations of some state
    components may depend on whether the processor is in 64-bit mode.)
============================================

IOW, copy_xstate_to_kernel()/copy_xstate_to_user() needs not only to map
from compacted format to standard one; it also needs to compensate for
that "we might skip saving the components that are in init state; we'll
report which ones got skipped by way of ->header.xfeatures" thing.

Again, those leaked uninit chunks are *not* in the same places for all
threads.  Without any overflows, etc. involved.  And at least for
the set 0 (x87 registers) the init state is not all-zeroes, so blanket
memset() done first is not going to give the right results.
