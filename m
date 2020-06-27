Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374ADC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 23:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D7B820706
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 23:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593301475;
	bh=d04eqpCgpXgxOLYZqH/WyKrVLxH+G/xevPPndAeOyCQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=dzMxgB9bgWS6Z0WMdZJuaZliSMJbmRbl1lJ14hcr0iQUf2wZAe67Rx1ivk8/8qAY+
	 s7PMUeoH11eHvQgrhwrhnfip5njPWoGYWAZq86iV+L3lLj8Qk0EdDwjORx5EVIy9Sv
	 LAWOTNgzrXJz8xmED3d0l59QSJDNSc7czGyZa7G4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgF0Xod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 19:44:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgF0Xoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 19:44:32 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1360420702;
        Sat, 27 Jun 2020 23:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593301472;
        bh=d04eqpCgpXgxOLYZqH/WyKrVLxH+G/xevPPndAeOyCQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SUPaGrT5PNtnqRh5VEM3mQlc29OZd9/jo+jc6MwU3uw+MjCN/hCVWLA8q+/RBI169
         O5d2BDWUNXGvW9DtPVryJRtAb4fuY5+Vj0Yeyti1kmPPiBF9dDC+9iaVuW89pC0zGE
         GGWJsjkHzLFSQLi9q12QOcfmiiWKH2VaXkR7oiJA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F2F82352308E; Sat, 27 Jun 2020 16:44:31 -0700 (PDT)
Date:   Sat, 27 Jun 2020 16:44:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <Kernel-team@fb.com>
Subject: Re: [PATCH tick-sched] Clarify "NOHZ: local_softirq_pending" warning
Message-ID: <20200627234431.GJ9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200627214629.GH9247@paulmck-ThinkPad-P72>
 <83B12EF8-3792-4943-A548-5DB0C6FC71D1@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83B12EF8-3792-4943-A548-5DB0C6FC71D1@amacapital.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 03:14:14PM -0700, Andy Lutomirski wrote:
> 
> > On Jun 27, 2020, at 2:46 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Sat, Jun 27, 2020 at 02:02:15PM -0700, Andy Lutomirski wrote:
> >>> On Fri, Jun 26, 2020 at 2:05 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>> 
> >>> Currently, can_stop_idle_tick() prints "NOHZ: local_softirq_pending HH"
> >>> (where "HH" is the hexadecimal softirq vector number) when one or more
> >>> non-RCU softirq handlers are still enablded when checking to stop the
> >>> scheduler-tick interrupt.  This message is not as enlightening as one
> >>> might hope, so this commit changes it to "NOHZ tick-stop error: Non-RCU
> >>> local softirq work is pending, handler #HH.
> >> 
> >> Thank you!  It would be even better if it would explain *why* the
> >> problem happened, but I suppose this code doesn't actually know.
> > 
> > Glad to help!
> > 
> > To your point, is it possible to bisect the appearance of this message,
> > or is it as usual non-reproducible?  (Hey, had to ask!)
> > 
> >                            
> 
> In this particular case, I tracked it down by good old fashioned sleuthing for bugs, but it’s still unclear to me precisely how NOHZ gets involved. The bug is that we were entering the kernel from usermode, doing nmi_enter(), turning on interrupts, maybe getting a page fault, raising a signal, turning off interrupts, nmi_exit(), and back to usermode, with the signal still queued and undelivered.  This is all kinds of bad, but I still don’t understand what softirqs or idle have to do with it.
> 
> But I have the bug fixed now!

Glad you found it!

							Thanx, Paul
