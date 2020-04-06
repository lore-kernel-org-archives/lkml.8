Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6F8C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF0523A1C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586182228;
	bh=OgOGUCitRRP/T8mKYZLXW0xweJNWsGNMLQglNR9Ce8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r3e3B2FPWn3eIbt2zJRQKGdbS20ff6Spbk7yhEkgd8yNKWTArSVgWKteo26pMyb/0
	 0Bqrc21vP+57Rjkmj5dB2hP5bdm6KXFuRp14mJlprfczEYV2XJwgIIqINNstPuBVW0
	 3+NoBhK8q1ovzT8Q5ivIopGm4POllkTYm56WB4jA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgDFOK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbgDFOK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:10:27 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E12912395B;
        Mon,  6 Apr 2020 14:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586182225;
        bh=OgOGUCitRRP/T8mKYZLXW0xweJNWsGNMLQglNR9Ce8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CON5JSBs/tPWIZV3Nd9bYqXiekdGMRmbI5kIIE99ckLSpocYPhdy/06x90OACGYdO
         zPiEJLs8YCmx4ZHTayBxPyVjceHWp/QeglX+Oudhf97+w8INuAN8RTgdRClz6zIYBO
         wctIMM7IHW30WaN9QJtXvQiHGcK1LNpfV2locpwg=
Date:   Mon, 6 Apr 2020 15:10:20 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "chengjian (D)" <cj.chengjian@huawei.com>, andrew.murray@arm.com,
        bristot@redhat.com, jakub.kicinski@netronome.com,
        Kees Cook <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        Li Bin <huawei.libin@huawei.com>, bobo.shaobowang@huawei.com
Subject: Re: Why is text_mutex used in jump_label_transform for x86_64
Message-ID: <20200406141020.GB3178@willie-the-truck>
References: <f7f686f2-4f28-1763-dd19-43eff6a5a8f2@huawei.com>
 <20200320102709.GC20696@hirez.programming.kicks-ass.net>
 <28edc3d5-83a3-43cb-3e64-7d0525d430f3@huawei.com>
 <20200406091551.GG20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200406091551.GG20730@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 11:15:51AM +0200, Peter Zijlstra wrote:
> On Mon, Apr 06, 2020 at 04:39:11PM +0800, chengjian (D) wrote:
> > 
> > On 2020/3/20 18:27, Peter Zijlstra wrote:
> > > It depends on the architecture details of how self-modifying code works.
> > > In particular, x86 is a variable instruction length architecture and
> > > needs extreme care -- it's implementation requires there only be a
> > > single text modifier at any one time, hence the use of text_mutex.
> > > 
> > > ARM64 OTOH is, like most RISC based architectures, a fixed width
> > > instruction architecture. And in particular it can re-write certain
> > > (branch) instructions with impunity (see their
> > > aarch64_insn_patch_text_nosync()). Which is why they don't need
> > > additional serialization.
> > 
> > Hi, Peter
> > 
> > Thank you very much for your reply.
> > 
> > X86 is a variable-length instruction, only one byte modification of the
> > instruction
> > can be regarded as atomic. so we must be very careful when modifying
> > instructions
> > concurrently.
> 
> Close enough.
> 
> > For other architectures such as ARM64, the modification of some instructions
> > can be
> > considered atomic, (Eg. nop -> jmp/b). The set of instructions that can be
> > executed
> > by one thread of execution as they are being modified by another thread of
> > execution
> > without requiring explicit synchronization.
> > 
> > In ARM64 Architecture Reference Manual, I find that:
> >     Concurrent modification and execution of instructions can lead to the
> > resulting instruction performing any behavior
> >     that can be achieved by executing any sequence of instructions that can
> > be executed from the same Exception level,
> >     except where each of the instruction before modification and the
> > instruction after modification is one of a B, BL, BRK,
> >     HVC, ISB, NOP, SMC, or SVC instruction.
> >     For the B, BL, BRK, HVC, ISB, NOP, SMC, and SVC instructions the
> > architecture guarantees that, after modification of the
> >     instruction, behavior is consistent with execution of either:
> >     • The instruction originally fetched.
> >     • A fetch of the modified instruction
> > 
> > So we can safely modify jump_label for ARM64(from NOP to b or form b to
> > NOP).
> > 
> > Is my understanding correct?
> 
> I think so; but I'm really not much of an ARM64 person. FWIW I think I
> remember Will saying the same is true of ARM (32bit) and they could
> implement the same optimization, but so far nobody has bothered doing
> so. But please, ask an ARM64 maintainer and don't take my word for this.

On 32-bit there are complications with Thumb-2 instructions where you can
have a mixture of 16-bit and 32-bit encodings, so you have to be pretty
careful there.

For arm64, we have aarch64_insn_patch_text_nosync() which we use to toggle
jump labels.

Will
