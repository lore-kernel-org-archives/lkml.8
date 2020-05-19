Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A74C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F8E207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589876158;
	bh=yJ7fQn1NM95tpi8PU4m61fRGPoc8lwpzDb11CKAj0so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vPqW1YSsIEHwpzSqwdwLNa7OVe8rSVMBD+1htAmOjWh+LZpkEo03S41B+fzZ03iA7
	 Ar5JJq7XcQrHj2H4FDTm088mS0G2Fs0C5YOEV/ExsFNl6kdhUJn+MlxxQWfIAOKX+r
	 useaiI5CxapTFBOdS603eesMzUaZPPbEEDjs50/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgESIP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgESIP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:15:57 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 504B420709;
        Tue, 19 May 2020 08:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589876156;
        bh=yJ7fQn1NM95tpi8PU4m61fRGPoc8lwpzDb11CKAj0so=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DQG3fiAM/dNkN3TrVzzD/YLGD7Yp+f9/SSBXWXOp71gI4M9jQba3W7vhqiHk0PNu0
         WgvlAah532itEJXBqUtN54gGvhJZu+xpfFrQwxtygVx3L+C3LSu0Y1xIH68nbfgSf1
         F7HCHXgWNOuwJKy0joGSnNyhY/KIOi/q3jmKHOb0=
Date:   Tue, 19 May 2020 09:15:51 +0100
From:   Will Deacon <will@kernel.org>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <khuey@pernos.co>
Subject: Re: arm64: Register modification during syscall entry/exit stop
Message-ID: <20200519081551.GA9980@willie-the-truck>
References: <CABV8kRz0mKSc=u1LeonQSLroKJLOKWOWktCoGji2nvEBc=e7=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABV8kRz0mKSc=u1LeonQSLroKJLOKWOWktCoGji2nvEBc=e7=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keno,

On Mon, May 18, 2020 at 09:05:30PM -0400, Keno Fischer wrote:
> Continuing my theme of "weird things I encounter
> while trying to use ptrace on arm64", I ran into the
> effect of the following code in the syscall entry/exit
> reporting:
> 
> ```
> /*
> * A scratch register (ip(r12) on AArch32, x7 on AArch64) is
> * used to denote syscall entry/exit:
> */
> regno = (is_compat_task() ? 12 : 7);
> saved_reg = regs->regs[regno];
> regs->regs[regno] = dir;
> ```
> 
> This seems very weird to me. I can't think of any
> other architecture that does something similar
> (other than unicore32 apparently, but the ptrace
> support there seems like it might have just been
> copied from ARM). I'm able to work around this
> in my application, but it adds another stumbling block.

Yes, we inherited this from ARM and I think strace relies on it. In
hindsight, it is a little odd, although x7 is a parameter register in the
PCS and so it won't be live on entry to a system call.

> Some examples of things that happen:
> - Writes to x7 during syscall exit stops are ignored, so
>   if the ptracer tries to emulate a setjmp-type thing, it
>   might miss this register (ptracers sometimes like to do
>   this to manually serialize execution between different
>   threads, puppeteering a single thread of execution
>   between different register states).
> - Reads from x7 are incorrect, so if the ptracer saves
>   a register state and later tries to set it back to the task,
>   it may get x7 incorrect, but user space may be expecting
>   the register to be preserved (when might this happen? -
>   consider a ptracer that wants to modify some syscall
>   arguments, it modifies the arguments, restarts the syscall
>   but then incurs a signal, so it tries to restore the original
>   registers to let userspace deal with the signal without
>   being confused - expect signal traps don't ignore x7
>   modifications, so x7 may have been unexpectedly
>   modified).
> - We now have seccomp traps, which kind of look and
>   act like syscall-entry traps, but don't have this behavior,
>   so it's not particularly reliable for ptracers to use.
> 
> Furthermore, it seems unnecessary to me on modern
> kernels. We now have PTRACE_GET_SYSCALL_INFO,
> which exposes this information without lying to the ptracer
> about the tracee's registers.
> 
> I understand, we can't just change this, since people may
> be relying on it, but I would like to propose adding a ptrace
> option (PTRACE_O_ARM_REGSGOOD?) that turns this
> behavior off. Now, I don't think we currently have any other
> arch-specific ptrace options, so maybe there is a different
> option that would be preferable (e.g. could be a different
> regset), but I do think it would be good to have a way to
> operate on the real x7 value. As I said, I can work around it,
> but hopefully I will be able to save a future implementer
> some headache.

I'm not opposed to extending ptrace so that we can try to wean people off
this interface, but I think we need some concrete situations where the
current behaviour actually causes a problem. Although the examples you've
listed above are interesting, I don't see why x7 is important in any of
them (and we only support up to 6 system call arguments).

Will
