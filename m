Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB0BC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D111220735
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588790792;
	bh=XTmDNV/ZsBnYfje7jioNFGKlv3IcopUwbb8tFnmZDss=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ct2DAmwFPazinqG3E7j15bkyp6FBt6QIt9aa+Hx9HEbGIfK/Mgy9GXVvhYS2O9TUb
	 WcpZtPTaD21RK9PpGmsHP4jvLWZdubz9GIhpqxFHHtByrvjjCpflK8xpZX26Uvc7Ec
	 E1IPylSsswsukGEdwt0EgBow/+ft8LhxJ1bA9lzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbgEFSqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728619AbgEFSqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:46:31 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D32AD20708;
        Wed,  6 May 2020 18:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588790790;
        bh=XTmDNV/ZsBnYfje7jioNFGKlv3IcopUwbb8tFnmZDss=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=o8Ra2HgQFTquWaSCsLID/U+dxQNzRqA68sMAJLeFvKZMcgRy9OBFkaKdFDeffCCEP
         OcVW6k72CNTfcAgRs/TT6XV7O3QPH1vy82xRVXObHaOeoMwReMgEeZIZGZun4QJDbR
         +zHpEz68Tza509oeJ/VN9MwRXXXT+bzKv/pX81eY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C4FCC352306C; Wed,  6 May 2020 11:46:30 -0700 (PDT)
Date:   Wed, 6 May 2020 11:46:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 1 03/36] sched: Clean up scheduler_ipi()
Message-ID: <20200506184630.GF2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200505131602.633487962@linutronix.de>
 <20200505134058.361859938@linutronix.de>
 <f969427d-a151-2c69-a779-a2b602e39d9e@oracle.com>
 <20200506153300.GB5281@hirez.programming.kicks-ass.net>
 <20200506182856.GD2869@paulmck-ThinkPad-P72>
 <20200506183703.GJ5298@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506183703.GJ5298@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 08:37:03PM +0200, Peter Zijlstra wrote:
> On Wed, May 06, 2020 at 11:28:56AM -0700, Paul E. McKenney wrote:
> > I still see warnings of the form "leave instruction with modified stack
> > frame" from older complilers and of the form "undefined stack state"
> > from newer compilers.  I am running stock objtool versions, so I am
> > guessing that this is at least one reason for these warnings.
> 
> Part 5, patch 2, might be responsible. I still have to look at curing
> that.

Very good, I will await further patches.

							Thanx, Paul
