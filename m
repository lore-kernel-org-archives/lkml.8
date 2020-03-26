Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA93BC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9945C20772
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585187893;
	bh=TMOO7VsQlxZk4nfg/cWiZR8CxMNUJ70TyQJHVereHMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YwsE02PF/h/l7TExCY6Mqu1sZpx2rIj74AdSlHutAeV+VnArXNkLeM6UTOPMaTrFP
	 4QTZjva3YX4LfZsjW+RiJVKVVcx8WH68OdMVNA1MFY74A727sKCFJ/ySpjR2ujA1Vg
	 Fv6aGwd8zQhF17twgO/RzaR8hUlkc0jHPsKWLrnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgCZB6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 21:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727585AbgCZB6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 21:58:12 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 062C020714;
        Thu, 26 Mar 2020 01:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585187891;
        bh=TMOO7VsQlxZk4nfg/cWiZR8CxMNUJ70TyQJHVereHMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DAnV8aQLc3WN+j9ahySa0ijX+ycikZJg70i2pxw7CwnZEfGnosLL9nu0Fc48wbipH
         /hkYkTFh+5ueUo0ZMrH6yMPziUJsmUfbHaZDzaTgJ8FIImWWJGWx/akPSMtwrwDAec
         WNv9rcfHwy9VZN/IChz9u1eTpKjptOiFCABeoOz0=
Date:   Thu, 26 Mar 2020 10:58:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 05/13] perf/x86: Add perf text poke events for
 kprobes
Message-Id: <20200326105805.0723cd10325ad301de061743@kernel.org>
In-Reply-To: <20200324122150.GN20696@hirez.programming.kicks-ass.net>
References: <20200304090633.420-1-adrian.hunter@intel.com>
        <20200304090633.420-6-adrian.hunter@intel.com>
        <20200324122150.GN20696@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020 13:21:50 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> We optimize only after having already installed a regular probe, that
> is, what we're actually doing here is replacing INT3 with a JMP.d32. But
> the above will make it appear as if we're replacing the original text
> with a JMP.d32. Which doesn't make sense, since we've already poked an
> INT3 there and that poke will have had a corresponding
> perf_event_text_poke(), right? (except you didn't, see below)
> 
> At this point we'll already have constructed the optprobe trampoline,
> which contains however much of the original instruction (in whole) as
> will be overwritten by our 5 byte JMP.d32. And IIUC, we'll have a
> perf_event_text_poke() event for the whole of that already -- except I
> can't find that in the patches (again, see below).

Thanks Peter to point it out.

> 
> > @@ -454,9 +463,16 @@ void arch_optimize_kprobes(struct list_head *oplist)
> >   */
> >  void arch_unoptimize_kprobe(struct optimized_kprobe *op)
> >  {
> > +	u8 old[POKE_MAX_OPCODE_SIZE];
> > +	u8 new[POKE_MAX_OPCODE_SIZE] = { op->kp.opcode, };
> > +	size_t len = INT3_INSN_SIZE + DISP32_SIZE;
> > +
> > +	memcpy(old, op->kp.addr, len);
> >  	arch_arm_kprobe(&op->kp);
> >  	text_poke(op->kp.addr + INT3_INSN_SIZE,
> >  		  op->optinsn.copied_insn, DISP32_SIZE);
> > +	memcpy(new + INT3_INSN_SIZE, op->optinsn.copied_insn, DISP32_SIZE);
> 
> And then this is 'wrong' too. You've not written the original
> instruction, you've just written an INT3.
> 
> > +	perf_event_text_poke(op->kp.addr, old, len, new, len);
> >  	text_poke_sync();
> >  }
> 
> 
> So how about something like the below, with it you'll get 6 text_poke
> events:
> 
> 1:  old0 -> INT3
> 
>   // kprobe active
> 
> 2:  NULL -> optprobe_trampoline
> 3:  INT3,old1,old2,old3,old4 -> JMP32
> 
>   // optprobe active
> 
> 4:  JMP32 -> INT3,old1,old2,old3,old4
> 5:  optprobe_trampoline -> NULL
> 
>   // kprobe active
> 
> 6:  INT3 -> old0
> 
> 
> 
> Masami, did I get this all right?

Yes, you understand correctly. And there is also boosted kprobe
which runs probe.ainsn.insn directly and jump back to old place.
I guess it will also disturb Intel PT.

0:  NULL -> probe.ainsn.insn (if ainsn.boostable && !kp.post_handler)

> 1:  old0 -> INT3
> 
  // boosted kprobe active
> 
> 2:  NULL -> optprobe_trampoline
> 3:  INT3,old1,old2,old3,old4 -> JMP32
> 
>   // optprobe active
> 
> 4:  JMP32 -> INT3,old1,old2,old3,old4

   // optprobe disabled and kprobe active (this sometimes goes back to 3)

> 5:  optprobe_trampoline -> NULL
> 
  // boosted kprobe active
> 
> 6:  INT3 -> old0

7:  probe.ainsn.insn -> NULL (if ainsn.boostable && !kp.post_handler)

So you'll get 8 events in max.

Adrian, would you also need to trace the buffer which is used for
single stepping? If so, as you did, we need to trace p->ainsn.insn
always.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
