Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51BEC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 11:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BDB21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 11:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582026632;
	bh=MSQMEr8/X8jyl/lO4pX5AF1skDj7s9X7KlOL2Iv7x+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2YhRt3VX5WZWhYjQgxkYNInNFKEPFwhkIydzsJLBkqOmalf3+2dtV543YrFDB0pud
	 VYCYdVuE0jfVrcuxPVHb11PDSGYP88eN+MewBRtRBKEk+9QnEQxXQNwRVJYvXpSitp
	 r7Uym817SL+Rqvby+r+lbUfTqBljoXH8J9xHbho8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgBRLub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 06:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgBRLub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 06:50:31 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2BFC207FD;
        Tue, 18 Feb 2020 11:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582026629;
        bh=MSQMEr8/X8jyl/lO4pX5AF1skDj7s9X7KlOL2Iv7x+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F/Qi0Pw9wch5TLlaX1Psb0ymv+ZQd/8s5aF1+GyFvfoTwHYhyLxRaSQPPuZrn3V5x
         d5UZ2bhsvZi+HuQpemRRtQf4Ni25f+1ixBDH3lyzLNqmdHPWTKXXYocISh6cmlnQaq
         XYNYSbCCO5V+y0PEHrlIfuzFnlO3vVM5AY9fKXXU=
Date:   Tue, 18 Feb 2020 20:50:25 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     linux-kernel@vger.kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, David Miller <davem@davemloft.net>,
        gregkh@linuxfoundation.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3] kretprobe: percpu support
Message-Id: <20200218205025.4047cf0506f56b18f9a989c4@kernel.org>
In-Reply-To: <CAMOZA0L14CjA97UHj7V1tPuOtesrUykYPj3_vgbF3JQWS3bcaw@mail.gmail.com>
References: <20200218005659.91318-1-lrizzo@google.com>
        <20200218165529.39e761c4be828285cc060279@kernel.org>
        <CAMOZA0L14CjA97UHj7V1tPuOtesrUykYPj3_vgbF3JQWS3bcaw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 01:39:40 -0800
Luigi Rizzo <lrizzo@google.com> wrote:

> On Mon, Feb 17, 2020 at 11:55 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Luigi,
> >
> > On Mon, 17 Feb 2020 16:56:59 -0800
> > Luigi Rizzo <lrizzo@google.com> wrote:
> >
> > > kretprobe uses a list protected by a single lock to allocate a
> > > kretprobe_instance in pre_handler_kretprobe(). This works poorly with
> > > concurrent calls.
> >
> > Yes, there are several potential performance issue and the recycle
> > instance is one of them. However, I think this spinlock is not so racy,
> > but noisy (especially on many core machine) right?
> 
> correct, it is especially painful on 2+ sockets and many-core systems
> when attaching kretprobes on otherwise uncontended paths.
> 
> >
> > Racy lock is the kretprobe_hash_lock(), I would like to replace it
> > with ftrace's per-task shadow stack. But that will be available
> > only if CONFIG_FUNCTION_GRAPH_TRACER=y (and instance has no own
> > payload).
> >
> > > This patch offers a simplified fix: the percpu_instance flag indicates
> > > that we allocate one instance per CPU, and the allocation is contention
> > > free, but we allow only have one pending entry per CPU (this could be
> > > extended to a small constant number without much trouble).
> >
> > OK, the percpu instance idea is good to me, and I think it should be
> > default option. Unless user specifies the number of instances, it should
> > choose percpu instance by default.
> 
> That was my initial implementation, which would not even need the
> percpu_instance
> flag in struct kretprobe. However, I felt that changing the default
> would have subtle
> side effects (e.g., only one outstanding call per CPU) so I thought it
> would be better
> to leave the default unchanged and make the flag explicit.
> 
> > Moreover, this makes things a bit complicated, can you add per-cpu
> > instance array? If it is there, we can remove the old recycle rp insn
> > code.
> 
> Can you clarify what you mean by "per-cpu instance array" ?
> Do you mean allowing multiple outstanding entries per cpu?

Yes, either allocating it on percpu area or allocating arraies
on percpu pointer is OK. e.g.

	instance_size = sizeof(*rp->pcpu) + rp->data_size;
	rp->pcpu = __alloc_percpu(instance_size * array_size,
				  __alignof__(*rp->pcpu));

And we will search free ri on the percpu array by checking ri->rp == NULL. 

Thank you,

> 
> I will address your code comments in an updated patch.
> 
> thanks
> luigi


-- 
Masami Hiramatsu <mhiramat@kernel.org>
