Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F8CC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BD220A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586441799;
	bh=qSBdwBqxVuJv5Qo6Mx3dC9JonpFRPV5GNkT7l8hrZLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZCPrqB4z1OEF9wM3MJWbidRROPqYde7rGwP/zAY6CTYOxnJ498Zc0BNXezxiATNti
	 DKBnDVxK6NW41bYf2JffT5P0N6/AMXmWDhZPVAasp/eOI4q3LUp+cCt1PrHcLc5pq1
	 PC4NnrifMUpczlVo2C8FukUKmJ0G7dyUBbdTl3Oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgDIOQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:16:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgDIOQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:16:37 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D950A20771;
        Thu,  9 Apr 2020 14:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586441797;
        bh=qSBdwBqxVuJv5Qo6Mx3dC9JonpFRPV5GNkT7l8hrZLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xmA0S0r8zLPzXEREeHZpYtYep2s6Tkej7tyMsZ3q1/k9lwwxQY7QKZIZzIaOQIbsM
         6BETta3OwbHrHz3HoR7+amDXBwmjbfP+1mQs6937gYg07ZJRWnCQIuDloZhbi1BhGm
         lDmm9C2IAv1RW31VqIBeqUF/CAdbGSXlFLHA6+J0=
Date:   Thu, 9 Apr 2020 23:16:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "bibo,mao" <bibo.mao@intel.com>,
        "Ziqian SUN (Zamir)" <zsun@redhat.com>
Subject: Re: [RFC] kretprobe: Prevent triggering kretprobe from within
 kprobe_flush_task
Message-Id: <20200409231632.f84c81e335d197d3e53aa878@kernel.org>
In-Reply-To: <20200409125213.GA3309111@krava>
References: <20200408164641.3299633-1-jolsa@kernel.org>
        <20200409213806.7657ec27d1b5cbd8243505b9@kernel.org>
        <20200409125213.GA3309111@krava>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Apr 2020 14:52:13 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> On Thu, Apr 09, 2020 at 09:38:06PM +0900, Masami Hiramatsu wrote:
> > Hi Jiri,
> > 
> > On Wed,  8 Apr 2020 18:46:41 +0200
> > Jiri Olsa <jolsa@kernel.org> wrote:
> > 
> > > hi,
> > > Ziqian reported lockup when adding retprobe on _raw_spin_lock_irqsave.
> > 
> > Hmm, kprobe is lockless, but kretprobe involves spinlock.
> > Thus, eventually, I will blacklist the _raw_spin_lock_irqsave()
> > for kretprobe.
> 
> I thought of blacklisting, but we were using that kretprobe
> in a bcc script.. it's not overloaded by using bpf trampolines,
> but still might be useful
> 
> SNIP
> 
> > > The code within the kretprobe handler checks for probe reentrancy,
> > > so we won't trigger any _raw_spin_lock_irqsave probe in there.
> > > 
> > > The problem is in outside kprobe_flush_task, where we call:
> > > 
> > >   kprobe_flush_task
> > >     kretprobe_table_lock
> > >       raw_spin_lock_irqsave
> > >         _raw_spin_lock_irqsave
> > > 
> > > where _raw_spin_lock_irqsave triggers the kretprobe and installs
> > > kretprobe_trampoline handler on _raw_spin_lock_irqsave return.
> > 
> > Hmm, OK. In this case, I think we should mark this process is
> > going to die and never try to kretprobe on it.
> > 
> > > 
> > > The kretprobe_trampoline handler is then executed with already
> > > locked kretprobe_table_locks, and first thing it does is to
> > > lock kretprobe_table_locks ;-) the whole lockup path like:
> > > 
> > >   kprobe_flush_task
> > >     kretprobe_table_lock
> > >       raw_spin_lock_irqsave
> > >         _raw_spin_lock_irqsave ---> probe triggered, kretprobe_trampoline installed
> > > 
> > >         ---> kretprobe_table_locks locked
> > > 
> > >         kretprobe_trampoline
> > >           trampoline_handler
> > >             kretprobe_hash_lock(current, &head, &flags);  <--- deadlock
> > > 
> > > The change below sets current_kprobe in kprobe_flush_task, so the probe
> > > recursion protection check is hit and the probe is never set. It seems
> > > to fix the deadlock.
> > > 
> > > I'm not sure this is the best fix, any ideas are welcome ;-)
> > 
> > Hmm, this is a bit tricky to fix this issue. Of course, temporary disable
> > kprobes (and kretprobe) on an area by filling current_kprobe might
> > be a good idea, but it also involves other kprobes.
> > 
> > How about let kretprobe skip the task which state == TASK_DEAD ?
> 
> hum, isn't that considerable amount of paths (with state == TASK_DEAD)
> that we would kill kprobes for? someone might want to trace it

OK, and I found that even after calling kprobe_flush_task(), it may be
work because the task will not be switched. kretprobe instance will be
reclaimed.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
