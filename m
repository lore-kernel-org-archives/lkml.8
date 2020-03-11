Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049A4C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99A6222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583885283;
	bh=g39hZYjK6rEH/w4jL8wEMDdT6KvVomIpQxXbaVy0qR0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=LEFbNKpwPwLlWiXCBS0SGdWBhg1ZF5XGE6vBtbDl/D5TOioDDIDsS8gjnCMIQtU/x
	 EXLye9WtVp3HV46Z1Ld8OWmf6GjZlPaiAU94V3S+tTokJgIf6I4m5orkF9Gn0zM0xP
	 km4ytBdfNLh+s+EkEf9MOpfi2+AP6UDMXZCWcV5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgCKAIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 20:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgCKAIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 20:08:02 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17DBE2146E;
        Wed, 11 Mar 2020 00:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583885281;
        bh=g39hZYjK6rEH/w4jL8wEMDdT6KvVomIpQxXbaVy0qR0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=s9zdji+p/4F3WfC34emMPpd9oux6PjjaUihsOx9o6xe/yom75sc3lISSPxzvoTyN4
         oXb5TI3QvaRMw3RaSVaqFvcAaf6SierNFhI/Cabl14YkedrGCbDCB2IfQuaJnYhka/
         wT6RCCxIFJES16upalgPcntEOWf4JLJ/vALbI1/g=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DCF2135229CC; Tue, 10 Mar 2020 17:08:00 -0700 (PDT)
Date:   Tue, 10 Mar 2020 17:08:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        fweisbec <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] tracepoint: rcuidle: use rcu_is_watching() and tree-rcu
Message-ID: <20200311000800.GM2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200310202054.5880-1-mathieu.desnoyers@efficios.com>
 <20200310205319.GH2935@paulmck-ThinkPad-P72>
 <561555431.24628.1583883873699.JavaMail.zimbra@efficios.com>
 <20200310235219.GL2935@paulmck-ThinkPad-P72>
 <1425816045.24643.1583884577489.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425816045.24643.1583884577489.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 07:56:17PM -0400, Mathieu Desnoyers wrote:
> ----- On Mar 10, 2020, at 7:52 PM, paulmck paulmck@kernel.org wrote:
> 
> > On Tue, Mar 10, 2020 at 07:44:33PM -0400, Mathieu Desnoyers wrote:
> >> ----- On Mar 10, 2020, at 4:53 PM, paulmck paulmck@kernel.org wrote:
> >> 
> >> > On Tue, Mar 10, 2020 at 04:20:54PM -0400, Mathieu Desnoyers wrote:
> >> >> commit e6753f23d961 ("tracepoint: Make rcuidle tracepoint callers use
> >> >> SRCU") aimed at improving performance of rcuidle tracepoints by using
> >> >> SRCU rather than temporarily enabling tree-rcu every time.
> >> >> 
> >> >> commit 865e63b04e9b ("tracing: Add back in rcu_irq_enter/exit_irqson()
> >> >> for rcuidle tracepoints") adds back the high-overhead enabling of
> >> >> tree-rcu because perf expects RCU to be watching when called from
> >> >> rcuidle tracepoints.
> >> >> 
> >> >> It turns out that by using "rcu_is_watching()" and conditionally
> >> >> calling the high-overhead rcu_irq_enter/exit_irqson(), the original
> >> >> motivation for using SRCU in the first place disappears.
> >> > 
> >> > Adding Alexei on CC for his thoughts, given that these were his
> >> > benchmarks.  I believe that he also has additional use cases.
> >> 
> >> Good point! Sorry I forgot to add Alexei to my CC list for that
> >> patch.
> >> 
> >> > But given the use cases you describe, this seems plausible.  This does
> >> > mean that tracepoints cannot be attached to the CPU-hotplug code that
> >> > runs on the incoming/outgoing CPU early/late in that process, though
> >> > that might be OK.
> >> 
> >> Do you mean standard tracepoints or rcuidle tracepoints ?
> >> 
> >> Are there any such tracepoints early/late in the cpu hotplug code today ?
> > 
> > I have no idea.  You would know better than I.  However, I would expect
> > that the same common-code issue that applies to exception-entry/exit
> > code might also apply to the CPU hotplug code.
> 
> I would also expect early/late CPU hotplug states to fall into the same
> category of "low-level entry/exit" code which Thomas would like to hide
> from instrumentation.

That decision I must leave to you guys.

							Thanx, Paul
