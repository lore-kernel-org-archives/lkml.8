Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93D9C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A259020722
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584980072;
	bh=Zg2e1snHSH8ktLGWD4LUyssRH+/UT99zD4nAQ3YXUnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Uq1bAjBAGOFYRNNPS8pV4fQ7ZFYuIV9/HfvVr+4XgDeavdYAzxApiHdP/SuDqQEN3
	 ZqD+9cN/aKdgalK1XFcEQvaBf9l1gPPz8IG2DcFOjiuL6dEgSjuHFur4AxWy1xp7oM
	 ixD1NX2rMA8ewqgGbpD93hFH+FfHWcJ3GxarHt5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgCWQOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbgCWQOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:14:31 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0166320409;
        Mon, 23 Mar 2020 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584980070;
        bh=Zg2e1snHSH8ktLGWD4LUyssRH+/UT99zD4nAQ3YXUnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z4DWWl5m1bRIcSDjDwLnClsrzodADOWm3mSM76gNb4XwKLy//Lkupgj34JYUJZMu1
         x2DzzpqURsP7rkN1Ud0hbHD6d8HNwUf97qCDsZEucNNMKrGPrD8Ni073Ousjq8ibgU
         +o92qLGOEiDlCteuTnbnM2m3A0f1M04v/yactSIs=
Date:   Mon, 23 Mar 2020 17:14:28 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 2/3] lockdep: Merge hardirq_threaded and irq_config
 together
Message-ID: <20200323161427.GB5755@lenoir>
References: <20200323033207.32370-1-frederic@kernel.org>
 <20200323033207.32370-3-frederic@kernel.org>
 <20200323140220.GK2452@worktop.programming.kicks-ass.net>
 <20200323145314.v57acriqj2s6wry2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323145314.v57acriqj2s6wry2@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 03:53:14PM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-03-23 15:02:20 [+0100], Peter Zijlstra wrote:
> > On Mon, Mar 23, 2020 at 04:32:06AM +0100, Frederic Weisbecker wrote:
> > > These fields describe the same state: a code block running in hardirq
> > > that might be threaded under specific configurations.
> > > 
> > > Merge them together in the same field. Also rename the result as
> > > "hardirq_threadable" as we are talking about a possible state and not
> > > an actual one.
> > 
> > What isn't instantly obvious is that they cannot overlap. For instance
> > mainline with force threaded interrupt handlers on, can't that have the
> > irq_work nest inside a threaded handler ?
> 
> I remember we kept them due to the nesting. A threaded-interrupt can be
> interrupted by irq_work/hrtimer/posix-timer. 
> So in a threaded interrupt it is okay to use a sleeping lock. It is not
> okay with irq_work on-top - unless it is the non-atomic one.

Hmm, with the current layout which is:

    if (curr->hardirq_threaded || curr->irq_config)
        curr_inner = LD_WAIT_CONFIG;
    else
        curr_inner = LD_WAIT_SPIN;

you are not protected against that.

But anyway none of that should happen if hardirq_threaded and irq_config
are respectively only used when hardirq threads are disabled and irq_work
is always hardirq, right?

> 
> > I *think* it just about works out, but it definitely wants a little more
> > than this.
> 
> Sebastian
