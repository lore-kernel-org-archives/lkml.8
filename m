Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8614AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D08207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589814891;
	bh=JoM91Et6EiXBZzmbk7OOu4mjYY2QCV5w5R56UhHxUw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Iui67BLb7M51lqmylbNRbQA+Jc4Ixj4bcvHg9YwpJbKnlRsSspYdcNVIKnT4R1fXw
	 25hPPLUI8cHyKsCNCkRCEnaoBLKJ0AqkpgFqswzfwD4R0oEp/jJGuWccZRfHbdxmh0
	 K1QkPXOBDStusktSIK1dK8sHgNHeCi/UHb+tekN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgERPOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgERPOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:14:49 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EA1F20671;
        Mon, 18 May 2020 15:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589814889;
        bh=JoM91Et6EiXBZzmbk7OOu4mjYY2QCV5w5R56UhHxUw0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lb9iaIhklsRErpaFfMUhPUpl08X8tH3mCEAf1CEh1g5KABUupNGHfRDvfb7xkhVLC
         +E9vSBCeQSXDozQBF61RNVDFrR6WlJr+vgZfvONf4nDI24lpboyGpCrLfnP8EnKLMF
         og2/RXV5tgRWr2Q8ipRcW2O/BIVBDvxj4NqxSFnE=
Date:   Tue, 19 May 2020 00:14:43 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     "liwei (GF)" <liwei391@huawei.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Miller <davem@davemloft.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, liwei1412@163.com
Subject: Re: [PATCH 2/4] arm64: Extract kprobes_save_local_irqflag() and
 kprobes_restore_local_irqflag()
Message-Id: <20200519001443.a1d1843e7809a7a68530fda5@kernel.org>
In-Reply-To: <CAD=FV=XMSsMFpPzBckkWhP6iDR4WM+qdV7J=aQCBbbBit_rDwg@mail.gmail.com>
References: <20200509214159.19680-1-liwei391@huawei.com>
        <20200509214159.19680-3-liwei391@huawei.com>
        <CAD=FV=VVz4QnQ6AWAsCMxw6Zne6es0omvJ--Gnag=PXkMPt42g@mail.gmail.com>
        <d5bb9ccf-6047-13d9-45b3-18421629e83f@huawei.com>
        <CAD=FV=XMSsMFpPzBckkWhP6iDR4WM+qdV7J=aQCBbbBit_rDwg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 May 2020 09:17:21 -0700
Doug Anderson <dianders@chromium.org> wrote:

> Hi,
> 
> On Sat, May 16, 2020 at 1:47 AM liwei (GF) <liwei391@huawei.com> wrote:
> >
> > >> -               kprobes_save_local_irqflag(kcb, regs);
> > >> +               kernel_prepare_single_step(&kcb->saved_irqflag, regs);
> > >
> > > Is there some reason to have two functions?  It seems like every time
> > > you call kernel_enable_single_step() you'd want to call
> > > kernel_prepare_single_step().  ...and every time you call
> > > kernel_disable_single_step() you'd want to call
> > > kernel_cleanup_single_step().
> > >
> > > Maybe you can just add the flags parameter to
> > > kernel_enable_single_step() / kernel_disable_single_step() and put the
> > > code in there?
> > >
> >
> > As kernel_enable_single_step() / kernel_disable_single_step() are also called in
> > breakpoint_handler() and watchpoint_handler(), i am not sure it's a right thing
> > to put the daif flag prepare/cleanup into them, especially we don't have a context
> > to save the flags.
> 
> I think you misunderstood what I was suggesting.  Maybe better with
> examples?  I was suggesting doing this:
> 
> kcb->saved_irqflag = kernel_enable_single_step(regs);
> ...
> kernel_disable_single_step(kcb->saved_irqflag, regs);
> 
> To me that seems better than what you have now:
> 
> kcb->saved_irqflag = kernel_prepare_single_step(regs);
> kernel_enable_single_step(regs);
> ...
> kernel_cleanup_single_step(kcb->saved_irqflag, regs);
> kernel_disable_single_step();
> 
> ...or am I confused?

+1, this sounds good to me. Currently arch/arm64/kernel/probes/kprobes.c
has a code which sololy use kernel_disable_single_step() without regs
restoring, but it looks like a bug there. So maybe you need following patch.

Thank you,

-----
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Mon, 18 May 2020 23:08:28 +0900
Subject: [PATCH] arm64: kprobes: Restore saved interrupt flag before disabling
 single step

Restore the saved interrupt flag in kprobe_ctlblk to regs->pstate
when a page fault happens on single-stepping instruction.
Without this fix, we will lose the flag if it happens because
kcb->saved_irqflag only knows the previous flag.

Fixes: 2dd0e8d2d2a1 ("arm64: Kprobes with single stepping support")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/probes/kprobes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d1c95dcf1d78..73fb99770f69 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -308,6 +308,7 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 		if (!instruction_pointer(regs))
 			BUG();
 
+		kprobes_restore_local_irqflag(kcb, regs);
 		kernel_disable_single_step();
 
 		if (kcb->kprobe_status == KPROBE_REENTER)
-- 
2.25.1




-- 
Masami Hiramatsu <mhiramat@kernel.org>
