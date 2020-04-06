Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F51C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810EF206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a3AzdDdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgDFJQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:16:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59328 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgDFJQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=pozUv80YoSRHHvx9sVkpMZ7CBAgwyFGYde+t9E6Fl08=; b=a3AzdDdzO/gg8dpEwGMPQCN9wH
        Ud3ROlUqDiusUwrXUeDg9X7pdmbTCnVf60Dl5wrm5WfGx49mekafeM2aT33NabLWpZisI6LbXWPrv
        Vq+9tSpLzJPEE3xetdYp08N9BU0iJ0NJR8nU4Z+jDrV1tazi1RSLKTF0RogSgxD3Dbqd+hdPQ34+g
        u54c/1tSUYMg8e31V0VXkviN6ZnDJQDVLw5YzdWBOK6wbcsGyNyDGTuC1wT4A0OrX52/KG3/ZTUOr
        8pTAMkjI4hMakJ+niz+ekYs0hoSgjCa15wq13xCI/Ufbv9u/xbiMWT5GbsCsiJis9gwUF+7rFIu5W
        89t15qxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLNrG-00085S-6Z; Mon, 06 Apr 2020 09:15:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F5D23011DD;
        Mon,  6 Apr 2020 11:15:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E3382BAC6A65; Mon,  6 Apr 2020 11:15:51 +0200 (CEST)
Date:   Mon, 6 Apr 2020 11:15:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "chengjian (D)" <cj.chengjian@huawei.com>
Cc:     andrew.murray@arm.com, bristot@redhat.com,
        jakub.kicinski@netronome.com, Kees Cook <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        Li Bin <huawei.libin@huawei.com>, bobo.shaobowang@huawei.com,
        Will Deacon <will@kernel.org>
Subject: Re: Why is text_mutex used in jump_label_transform for x86_64
Message-ID: <20200406091551.GG20730@hirez.programming.kicks-ass.net>
References: <f7f686f2-4f28-1763-dd19-43eff6a5a8f2@huawei.com>
 <20200320102709.GC20696@hirez.programming.kicks-ass.net>
 <28edc3d5-83a3-43cb-3e64-7d0525d430f3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28edc3d5-83a3-43cb-3e64-7d0525d430f3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 04:39:11PM +0800, chengjian (D) wrote:
> 
> On 2020/3/20 18:27, Peter Zijlstra wrote:
> > It depends on the architecture details of how self-modifying code works.
> > In particular, x86 is a variable instruction length architecture and
> > needs extreme care -- it's implementation requires there only be a
> > single text modifier at any one time, hence the use of text_mutex.
> > 
> > ARM64 OTOH is, like most RISC based architectures, a fixed width
> > instruction architecture. And in particular it can re-write certain
> > (branch) instructions with impunity (see their
> > aarch64_insn_patch_text_nosync()). Which is why they don't need
> > additional serialization.
> 
> Hi, Peter
> 
> Thank you very much for your reply.
> 
> X86 is a variable-length instruction, only one byte modification of the
> instruction
> can be regarded as atomic. so we must be very careful when modifying
> instructions
> concurrently.

Close enough.

> For other architectures such as ARM64, the modification of some instructions
> can be
> considered atomic, (Eg. nop -> jmp/b). The set of instructions that can be
> executed
> by one thread of execution as they are being modified by another thread of
> execution
> without requiring explicit synchronization.
> 
> In ARM64 Architecture Reference Manual, I find that:
>     Concurrent modification and execution of instructions can lead to the
> resulting instruction performing any behavior
>     that can be achieved by executing any sequence of instructions that can
> be executed from the same Exception level,
>     except where each of the instruction before modification and the
> instruction after modification is one of a B, BL, BRK,
>     HVC, ISB, NOP, SMC, or SVC instruction.
>     For the B, BL, BRK, HVC, ISB, NOP, SMC, and SVC instructions the
> architecture guarantees that, after modification of the
>     instruction, behavior is consistent with execution of either:
>     • The instruction originally fetched.
>     • A fetch of the modified instruction
> 
> So we can safely modify jump_label for ARM64(from NOP to b or form b to
> NOP).
> 
> Is my understanding correct?

I think so; but I'm really not much of an ARM64 person. FWIW I think I
remember Will saying the same is true of ARM (32bit) and they could
implement the same optimization, but so far nobody has bothered doing
so. But please, ask an ARM64 maintainer and don't take my word for this.

