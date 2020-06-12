Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A996DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83AAB20792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591970232;
	bh=qiggyIcE7qbtQhCY+8kNF7cLJi+quWCbJ37ghWdEb24=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=W0sEeoYwGHpdR7JDEh7qmP9yh8cLfexjPDTG0BO1atQMwJ+1VQn5yG/VWJ55SLXfX
	 zkywGYshAxWyUKGMmw3k3VGvi/99yjCQV5bCNB7fCBEvcHEMIL4Ydf44EioNkcgIUN
	 VtswAguDk+zsQtPTPEFEPDKF/fMxtN5K7W53gL4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFLN5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgFLN5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:57:09 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6AD4206A4;
        Fri, 12 Jun 2020 13:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591970228;
        bh=qiggyIcE7qbtQhCY+8kNF7cLJi+quWCbJ37ghWdEb24=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SGTEbqh4DTpoz3GhDLb8nsg5Rmt6x415hbBLRp8uA+dgcQZak57tFzWquSwJidbs+
         +opRlqSTxqodOSz9xrMTT8+KgvCBOSqfVoHikXPqePwFWl0rLp4aZ7m2ShFJDzVNTO
         CxEAcOCCgJGKR4PGYGPzS03dTIEx6DBDTrK6Twnk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B4E853521A8D; Fri, 12 Jun 2020 06:57:08 -0700 (PDT)
Date:   Fri, 12 Jun 2020 06:57:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org, luto@kernel.org,
        x86@kernel.org, frederic@kernel.org, rostedt@goodmis.org,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        will@kernel.org, peterz@infradead.org
Subject: Re: [PATCH RFC] x86/entry: Ask RCU if it needs rcu_irq_{enter,exit}()
Message-ID: <20200612135708.GJ4455@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200611235305.GA32342@paulmck-ThinkPad-P72>
 <87ftb0d47a.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftb0d47a.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 11:27:21AM +0200, Thomas Gleixner wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> > +static __always_inline bool rcu_needs_irq_enter(void)
> > +{
> > +	return !IS_ENABLED(CONFIG_TINY_RCU) &&
> > +               (context_tracking_enabled_cpu(smp_processor_id()) || is_idle_task(current));
> 
> This reintroduces the #PF problem which started the whole conditional
> RCU entry discussion:
> 
>    https://lore.kernel.org/lkml/20200515235125.628629605@linutronix.de/
> 
> and which made us all come to the conclusion that we can do it always
> conditional. No biscuit for you. :)

We can only be thankful that source-code control systems mean that my
coding session yesterday afternoon will have no permanent effect.

Let this be a lesson to all of you:  Hacking RCU while sleep-deprived
is a really bad idea.  ;-)

							Thanx, Paul
