Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B4BC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78A824655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583789143;
	bh=4ijyWSSxC94KiyiVpAgewDVgm3OYlVLJsPEZIanHANA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=auG/nEHFaZS08hgpTj2KUIkZ6/NjQPWA0ZnGk10n5J+7PiStQ0C2Rx8VgLO7GKUFk
	 BQ1VAHBz6qQWzBuIlhNRUR4kbhRZdYvSLnklr6qffFHil5aHquozI0TKoRWZTPZSdK
	 wa79ECa+1wkqiuZg6EIEGBRZKjTiD5PEgI0PHvpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCIVZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgCIVZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:25:41 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEB4D24649;
        Mon,  9 Mar 2020 21:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583789140;
        bh=4ijyWSSxC94KiyiVpAgewDVgm3OYlVLJsPEZIanHANA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fGWUkGD2WRdYJfopM72ugAJcMZLQTonjIoudRt5Pb38LVX1OOhjFEqrBDuVdoMLgZ
         JD56jgTuQB6iCjLqluR1xE1GzFsJPD03MGJpTuvyX7ZrepjDxG7TNw/LAVKJbSAOTi
         2c+tvBpHW6b0vKSdrVvoiyZgVoCYhCZUAU/PYrw4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9581B3522730; Mon,  9 Mar 2020 14:25:40 -0700 (PDT)
Date:   Mon, 9 Mar 2020 14:25:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: Instrumentation and RCU
Message-ID: <20200309212540.GV2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
 <20200309204710.GU2935@paulmck-ThinkPad-P72>
 <20200309165811.05603ce0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309165811.05603ce0@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 04:58:11PM -0400, Steven Rostedt wrote:
> On Mon, 9 Mar 2020 13:47:10 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Yeah, I know.  Just what the kernel doesn't need, yet another variant
> > of RCU...
> 
> And call this variant: yarcu (Yet Another RCU) (pronounced yar-ku ?)

I was thinking in terms of rcu_read_lock_trace(), but hey!

							Thanx, Paul
