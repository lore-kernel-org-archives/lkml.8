Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DECC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB4020738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598336144;
	bh=4Ys01Quvr/gd6AZTKP/iqgZLXjT13MOc/IDtxKyLkLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ij7ACR20guxo/H9XvLwxU3VyFQ1zbO0uA247NlZrnkALOSZ779D7uTyewy6p8SvL8
	 fkxQJzYu9kQx4Gpj3U+GuLpueLHgrJ+44a6RPydS43XpwCz0jotdcoIfO0YEoWDFuq
	 ffALicwo4EG6vRNO705ans0SDqxHQ952/TaTL6Zc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgHYGPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgHYGPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:15:43 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0688B204FD;
        Tue, 25 Aug 2020 06:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598336142;
        bh=4Ys01Quvr/gd6AZTKP/iqgZLXjT13MOc/IDtxKyLkLQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HV6kvZ4Dd37J+2DemTZVu2CCmBeufhRzjBxFcLYnpPHjjJ6hwNjM3vUBGCm8FtEtB
         v3v97KRZq1nvpMdEzpT9uLJHTAS6nsHnpXlFzvNuVaZdQrw5siL7dVKfWo1qgStts7
         B2M951JEOA2XhurFHVsMYyUT1PPw582xRgboY7vY=
Date:   Tue, 25 Aug 2020 15:15:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-Id: <20200825151538.f856d701a34f4e0561a64932@kernel.org>
In-Reply-To: <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
        <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
        <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddy,

On Mon, 24 Aug 2020 16:41:58 +0000
"Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com> wrote:

> > -----Original Message-----
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > Sent: Monday, August 24, 2020 11:54 PM
> > To: Eddy Wu (RD-TW) <Eddy_Wu@trendmicro.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>; linux-kernel@vger.kernel.org; x86@kernel.org; David S. Miller <davem@davemloft.net>
> > Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function entry is not optimized (trigger by int3 breakpoint)
> >
> >
> > This message was sent from outside of Trend Micro. Please do not click links or open attachments unless you recognise the source of this
> > email and know the content is safe.
> >
> >
> > On Mon, 24 Aug 2020 12:02:58 +0000
> > "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com> wrote:
> >
> > > Greetings!
> > >
> > > Starting from kernel 5.8 (x86_64), kretprobe handler will always missed if corresponding kprobe on function entry is not optimized
> > (using break point instead).
> >
> > Oops, good catch. I always enabled ftrace hook for kretprobe, I didn't noticed that.
> >
> > > Step to reproduce this:
> > > 1) Build the kretprobe example module (CONFIG_SAMPLE_KRETPROBES=m)
> > > 2) Disable jump optimization (`sysctl debug.kprobes-optimization=0` or register any kprobe.post_handler at same location)
> > > 3) Insert the kretprobe_example module
> > > 4) Launch some process to trigger _do_fork
> > > 5) Remove kretprobe_example module
> > > 6) dmesg shows that all probing instances are missed
> > >
> > > Example output:
> > > # sysctl debug.kprobes-optimization=0
> > > debug.kprobes-optimization = 0
> > > # insmod samples/kprobes/kretprobe_example.ko
> > > # ls > /dev/null
> > > # rmmod kretprobe_example
> > > # dmesg
> > > [48555.067295] Planted return probe at _do_fork: 0000000038ae0211
> > > [48560.229459] kretprobe at 0000000038ae0211 unregistered
> > > [48560.229460] Missed probing 3 instances of _do_fork
> > >
> > > After bisecting, I found this behavior seems to introduce by this commit: (5.8-rc1)
> > > 0d00449c7a28a1514595630735df383dec606812 x86: Replace ist_enter() with nmi_enter()
> > > This make kprobe_int3_handler() effectively running as NMI context, which pre_handler_kretprobe() explicitly checked to prevent
> > recursion.
> >
> > Thanks for the bisecting!
> >
> > >
> > > (in_nmi() check appears from v3.17)
> > > f96f56780ca584930bb3a2769d73fd9a101bcbbe kprobes: Skip kretprobe hit in NMI context to avoid deadlock
> > >
> > > To make kretprobe work again with int3 breakpoint, I think we can replace the in_nmi() check with in_nmi() == (1 << NMI_SHIFT) at
> > kprobe_int3_handler() and skip kretprobe if nested NMI.
> >
> > Ah, I see. Now int3 is a kind of NMI, so in the handler in_nmi() always returns !0.
> >
> > > Did a quick test on 5.9-rc2 and it seems to be working.
> > > I'm not sure if it is the best way to do since it may also require change to other architecture as well, any thought?
> >
> > Hmm, this behavior is arch-dependent. So I think we need an weak function like this.
> >
> > @kernel/kprobes.c
> >
> > bool __weak arch_kprobe_in_nmi(void)
> > {
> >         return in_nmi()
> > }
> >
> > @arch/x86/kernel/kprobes/core.c
> >
> > bool arch_kprobe_in_nmi(void)
> > {
> >        /*
> >         * Since the int3 is one of NMI, we have to check in_nmi() is
> >         * bigger than 1 << NMI_SHIFT instead of !0.
> >         */
> >        return in_nmi() > (1 << NMI_SHIFT);
> > }
> >
> > And use arch_kprobe_in_nmi() instead of in_nmi() in kprobes.c.
> >
> > Thanks,
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>
> 
> Kretprobe might still trigger from NMI with nmi counter == 1 (if entry kprobe is jump-optimized).

Ah, right. Hmm, in that case, we can store the int3 status in 
the kprobe_ctlblk and refer it in the handler.


> The arch- dependent weak function looks cleaner than doing this in kprobe_int3_handler() under x86/, but I don't know if there is a way to check if called by specific int3 handler or not.
> 
> My original patch below, need to change all architecture support kretprobe though

OK, here is my fix. This will not change the other arches. please try it.


From 24390dffe6eb9a3e95f7d46a528a1dcfd716dc81 Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Tue, 25 Aug 2020 01:37:00 +0900
Subject: [PATCH] kprobes/x86: Fixes NMI context check on x86

Since commit 0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()")
made int3 as one of NMI, in_nmi() in kprobe handlers always returns !0.
Thus the kretprobe handlers always skipped the execution on x86 if it
is using int3. (CONFIG_KPROBES_ON_FTRACE=n and
echo 0 > /proc/sys/debug/kprobe_optimization)

To avoid this issue, introduce arch_kprobe_in_nmi() and check the
in_nmi() count is bigger than 1 << NMI_SHIFT on x86 if the handler
has been invoked from kprobe_int3_handler. By default, the
arch_kprobe_in_nmi() will be same as in_nmi().

Fixes: 0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()")
Reported-by: Eddy Wu <Eddy_Wu@trendmicro.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/x86/include/asm/kprobes.h |  1 +
 arch/x86/kernel/kprobes/core.c | 18 ++++++++++++++++++
 kernel/kprobes.c               |  8 +++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index 143bc9abe99c..ddb24feb95ad 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -98,6 +98,7 @@ struct kprobe_ctlblk {
 	unsigned long kprobe_old_flags;
 	unsigned long kprobe_saved_flags;
 	struct prev_kprobe prev_kprobe;
+	bool 	in_int3;
 };
 
 extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 2ca10b770cff..649d467c8231 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -583,6 +583,20 @@ static nokprobe_inline void restore_btf(void)
 	}
 }
 
+bool arch_kprobe_in_nmi(void)
+{
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	if (kcb->in_int3) {
+		/*
+		 * Since the int3 is one of NMI, we have to check in_nmi() is
+		 * bigger than 1 << NMI_SHIFT instead of !0.
+		 */
+		return in_nmi() > (1 << NMI_SHIFT);
+	} else
+		return in_nmi();
+}
+
 void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
 	unsigned long *sara = stack_addr(regs);
@@ -697,6 +711,7 @@ int kprobe_int3_handler(struct pt_regs *regs)
 				return 1;
 		} else {
 			set_current_kprobe(p, regs, kcb);
+			kcb->in_int3 = true;
 			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
 
 			/*
@@ -710,6 +725,7 @@ int kprobe_int3_handler(struct pt_regs *regs)
 				setup_singlestep(p, regs, kcb, 0);
 			else
 				reset_current_kprobe();
+			kcb->in_int3 = false;
 			return 1;
 		}
 	} else if (*addr != INT3_INSN_OPCODE) {
@@ -994,7 +1010,9 @@ int kprobe_debug_handler(struct pt_regs *regs)
 
 	if ((kcb->kprobe_status != KPROBE_REENTER) && cur->post_handler) {
 		kcb->kprobe_status = KPROBE_HIT_SSDONE;
+		kcb->in_int3 = true;
 		cur->post_handler(cur, regs, 0);
+		kcb->in_int3 = false;
 	}
 
 	/* Restore back the original saved kprobes variables and continue. */
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 287b263c9cb9..9564928fb882 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1927,6 +1927,12 @@ unsigned long __weak arch_deref_entry_point(void *entry)
 }
 
 #ifdef CONFIG_KRETPROBES
+
+bool __weak arch_kprobe_in_nmi(void)
+{
+	return in_nmi();
+}
+
 /*
  * This kprobe pre_handler is registered with every kretprobe. When probe
  * hits it will set up the return probe.
@@ -1943,7 +1949,7 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 	 * statistical counter, so that the user is informed that
 	 * something happened:
 	 */
-	if (unlikely(in_nmi())) {
+	if (unlikely(arch_kprobe_in_nmi())) {
 		rp->nmissed++;
 		return 0;
 	}
-- 
2.25.1


-- 
Masami Hiramatsu <mhiramat@kernel.org>
