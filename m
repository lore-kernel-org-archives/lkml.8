Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10A7C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962E62467A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579002576;
	bh=i4WxfHulDwClQwI+AyWyLucUHwWvZtAdfLKsMeOSUoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1eydcF3PA0z4B3awlOtMpmpUCA/oaLgSrES6LkWKgXnRLbNNiEt4JmYudsvBJxD1m
	 ZEDewI6H5BKoMf3ur/qdep2waacpR6m4TpE3AIqw1pCxop/QCcV4SF9v0iv7gr9wWc
	 aSwdPRdiu3Er2asU5JZVJ7iKFcNanRO6euAP0CNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgANLtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:49:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:48594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgANLte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:49:34 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED1A824676;
        Tue, 14 Jan 2020 11:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579002574;
        bh=i4WxfHulDwClQwI+AyWyLucUHwWvZtAdfLKsMeOSUoE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dHHvlJ501rGqOxjy+LF4USGb6E+8nx7N7n2vZQRrh3YnnYRFzEpNIo/pnxHIg5r87
         T2jKkQ3GdZJSgfhZr/1/N5UITEBzGvd/obm8affsGmwK1rSEZWl93rqWo1keHw3scB
         bCedYeIwJgXM+94cYX/4mse0Bkf9RcsDobN+y/TU=
Date:   Tue, 14 Jan 2020 20:49:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip V2 0/2] kprobes: Fix RCU warning and cleanup
Message-Id: <20200114204928.897a7b062469fbcb608853b6@kernel.org>
In-Reply-To: <20200113192331.GK2935@paulmck-ThinkPad-P72>
References: <157535316659.16485.11817291759382261088.stgit@devnote2>
        <20191221035541.69fc05613351b8dabd6e1a44@kernel.org>
        <20200107211535.233e7ff396f867ee1348178b@kernel.org>
        <20200110211438.GE128013@google.com>
        <20200111083507.c32b85b1d47aa69928de530b@kernel.org>
        <20200112020537.GJ128013@google.com>
        <20200113121640.bfab48c105dae9b1918c2d82@kernel.org>
        <20200113220953.dccefd4846d004ee5a5b3295@kernel.org>
        <20200113192331.GK2935@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020 11:23:31 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Mon, Jan 13, 2020 at 10:09:53PM +0900, Masami Hiramatsu wrote:
> > Hi Joel,
> > 
> > On Mon, 13 Jan 2020 12:16:40 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > > > 
> > > > > > Hi Masami,
> > > > > > 
> > > > > > I believe I had commented before that I don't agree with this patch:
> > > > > > https://lore.kernel.org/lkml/157535318870.16485.6366477974356032624.stgit@devnote2/
> > > > > > 
> > > > > > The rationale you used is to replace RCU-api with non-RCU api just to avoid
> > > > > > warnings. I think a better approach is to use RCU api and pass the optional
> > > > > > expression to silence the false-positive warnings by informing the RCU API
> > > > > > about the fact that locks are held (similar to what we do for
> > > > > > rcu_dereference_protected()). The RCU API will do additional checking
> > > > > > (such as making sure preemption is disabled for safe RCU usage etc) as well.
> > > > > 
> > > > > Yes, that is what I did in [1/2] for get_kprobe().
> > > > > Let me clarify the RCU list usage in [2/2].
> > > > > 
> > > > > With the careful check, other list traversals never be done in non-sleepable
> > > > > context, those are always runs with kprobe_mutex held.
> > > > > If I correctly understand the Documentation/RCU/listRCU.rst, we should/can use
> > > > > non-RCU api for those cases, or do I miss something?
> > > > 
> > > > Yes, that is fine. However personally I prefer not to mix usage of
> > > > list_for_each_entry_rcu() and list_for_each_entry() on the same pointer
> > > > (kprobe_table). I think it is more confusing and error prone. Just use
> > > > list_for_each_entry_rcu() everywhere and pass the appropriate lockdep
> > > > expression, instead of calling lockdep_assert_held() independently. Is this
> > > > not doable?
> > > 
> > > Hmm, but isn't it more confusing that user just take a mutex but
> > > no rcu_read_lock() with list_for_each_entry_rcu()? In that case,
> > > sometimes it might sleep inside list_for_each_entry_rcu(), I thought
> > > that might be more confusing mind model for users...
> 
> The correct answer will be different in different situations.
> For example, code that might be called either with the mutex held or
> within an RCU read-side critical section will definitely need the _rcu()
> and the lockdep_is_held().  Code that looks OK to call from within
> RCU readers, but must not be (e.g., because it sleeps), will just as
> definitely need to avoid _rcu().

I see. So the patch [2/2] is just removing useless rcu_read_lock()
and use non RCU api for kprobe_table, because those code never be
called from rcu read-side critical section. (It makes a critical section
only for using RCU list operation)

>  (If the lack of _rcu() proves confusing,
> maybe list_for_each_entry() needs to grow an optional lockdep expression?)

That is OK for me, anyway the [2/2] also introduces some lockdep_assert_held()
instead of rcu_read_lock() so that lockdep can check sanity.

> 
> I am therefore personally OK with either approach, though in confusing
> cases a comment might help.
> 
> > I meant, do we always need to do something like below?
> > 
> > {
> > 	mutex_lock(&lock);
> > 	list_for_each_entry_rcu(list, ..., lockdep_is_held(&lock)) {
> > 		...
> > 	}
> > 	mutex_unlock(&lock);
> > }
> > 
> > BTW, I found another problem on this policy, since we don't have
> > list_for_each_*_safe() equivalents for RCU, we can not do a safe
> > loop on it. Should we call a find function for each time?
> 
> Good point.
> 
> RCU readers don't need _safe() because RCU grace periods provide this
> for free within RCU read-side critical sections.
> 
> So agreed, if you need _safe() on the update side, you would need to
> call list_for_each_entry_safe().  If this proves confusing due to RCU
> readers, maybe it should grow a lockdep expression?  In the meantime,
> lockdep_assert_held() could be used if needed to let people know that
> this should not be used in an RCU reader.

I think lockdep_assert_held() is enough.

> 
> Does that work, or am I missing part of the problem?
> 
> 							Thanx, Paul

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
