Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96A8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2ED92065D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595337904;
	bh=Dednb+Q83bm0lVRNGspexnSq9x8K2wzcR3ronI9FHiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EDLvlktocgdGVE31dkH2B2kMYiwhFpRNOcsNSrL/s6we7h/pfVGvxT9gnTRAJL90D
	 Gbm9JRS+U+mYRbzUfM3693hFq+8mpDUA/Z1SS8k/zMOlAzWfKa/5melXdKKYi58utX
	 qVf1GBngZjwSy5UghVyjI+T+j0LduQgkhfYCuz0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgGUNZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgGUNZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:25:01 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D486A20792;
        Tue, 21 Jul 2020 13:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595337901;
        bh=Dednb+Q83bm0lVRNGspexnSq9x8K2wzcR3ronI9FHiM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TT2EGQ4sEi9oPTFl2jIc5CjrPLprHrc54FqZNULoOIK2Raml45Zsjmajj4agclAdU
         5wP5WKd4jjhXhHLvwCqsnQ5LI6BmGRuI7ptPkPJARap2oXgJXL+abNMovsVmvQ00+w
         csNqAXZPVzgWD3bY9F05Np9RvMkv+hBBkgRGN0OE=
Date:   Tue, 21 Jul 2020 22:24:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 3/3] arm64: implement KPROBES_ON_FTRACE
Message-Id: <20200721222455.e99fb8660f69f61ad1bc8942@kernel.org>
In-Reply-To: <20191226182607.06770598a00507090a046951@kernel.org>
References: <20191225172625.69811b3e@xhacker.debian>
        <20191225173001.6c0e3fb2@xhacker.debian>
        <20191226115707.902545688aa90b34e2e550b3@kernel.org>
        <20191226110348.146bb80b@xhacker.debian>
        <20191226121108.0cd1b078@xhacker.debian>
        <20191226182607.06770598a00507090a046951@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

Would you be still working on this series?

If you are still want to put a probe on func+4, it is OK if you can
completely emulate the 1st instruction. (lr save on the stack and
change the regs->sp)

Thank you,

On Thu, 26 Dec 2019 18:26:07 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 26 Dec 2019 04:25:24 +0000
> Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> 
> > > > > +/*
> > > > > + * In arm64 FTRACE_WITH_REGS implementation, we patch two nop instructions:
> > > > > + * the lr saver and bl ftrace-entry. Both these instructions are claimed
> > > > > + * by ftrace and we should allow probing on either instruction.  
> > > >
> > > > No, the 2nd bl ftrace-entry must not be probed.
> > > > The pair of lr-saver and bl ftrace-entry is tightly coupled. You can not
> > > > decouple it.  
> > > 
> > > This is the key. different viewing of this results in different implementation.
> > > I'm just wondering why are the two instructions considered as coupled. I think
> > > here we met similar situation as powerpc: https://lkml.org/lkml/2019/6/18/646
> > > the "mflr r0" equals to lr-saver here, branch to _mcount equals to bl ftrace-entry
> > > could you please kindly comment more?
> > > 
> > > Thanks in advance
> > > 
> > 
> > hmm, I think I may get some part of your opinion. In v7 implementation:
> > 
> > if probe on func+4, that's bl ftrace-entry, similar as mcount call on
> > other architectures, we allow this probe as normal.
> > 
> > if probe on func+0, the first param ip in kprobe_ftrace_handler() points
> > to func+4(this is adjusted by ftrace), regs->ip points to func+8, so in
> > kprobe_ftrace_handler() we modify regs->ip to func+0 to call kprobe
> > pre handler, then modify regs->ip to func+8 to call kprobe post handler.
> > As can be seen, the first two instructions are considered as a virtual
> > mcount call. From this point of view, lr saver and the bl <ftrace-entry>
> > is coupled.
> 
> Yes, this is good. But probing on func+4 is meaningless. Both func+0 and
> func+4 call a handler with same pt_regs. And it should have the stack
> pointer which is NOT modified by lr-saver and regs->lr must point original
> call address. (ftrace regs caller must do this fixup for supporting live
> patching correctly)
> 
> And in this case, func+4 has fake pt_regs because it skips lr-saver's
> effects.
> 
> And even if you fixed up the pt_regs, there is another problem of what
> user expects on the target instructions.
> 
> As you know, dynamic ftrace will fill the instruction with NOP (2 NOPs
> in arm64), in this case, maybe pt_regs are same except pc on func+0 and
> func+4. But if ftrace already enabled on the function, user will see
> there are lr-saver and bl, oops. In this case we have to change pt_regs
> between func+0 and func+4. So it depends on the current mode.
> 
> However, IMHO, it is not worth to pay such simulation cost. No one want
> to probe such simulated intermediate address. It is easy to expect the
> result from the code. Moreover, the func+4 will not appear on debuginfo
> because those 2 special insturctions are just appended by the compiler,
> not generated by the code.
> 
> So I don't think we need to support func+4. We only need func+0, or func+8
> (this must be same as func+0 except regs->pc anyway)
> 
> Thank you,
> 
> > 
> > If we split patch3 into two:
> > one to support kprobes func+4
> > the second to support kprobe on func+0
> > it would be much clearer.
> > 
> > Then the key here is whether we could allow both kprobes on func+0 and func+4
> > 
> > Thanks
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
