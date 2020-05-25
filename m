Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A18C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 00:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39F6120823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 00:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590367028;
	bh=6f6uDamrn5fdTL4fuGZAu7lxCPgqe/0V8dDMczKBM78=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=OA/BqEOq6ozOW+QKCndB50xBiC52D5MvsNBi4tEIOZ6ycbux7p8NmrdEPfo9RjIYT
	 uVHroYdJZbIR/5YAPK1XzOggc43L532sT6iSM0rSRnm1H3Xi+mfh/A+ObdM5Fr7NRA
	 i7Jg79v90j/DXralIf7pXG8GoKIgvAWJokC5nNfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbgEYAhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 20:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388014AbgEYAhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 20:37:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B015920787;
        Mon, 25 May 2020 00:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590367026;
        bh=6f6uDamrn5fdTL4fuGZAu7lxCPgqe/0V8dDMczKBM78=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UVJMrlCU6YCVZFhiLeKuc2icYHVARnkh3qG8bMiisJpE1EnXaU8AQLkfCRWwQNGMS
         3kSArGrfz0lpZTFM4Gpp2HdcGBpkYXSI+6Bs+z2jLtyVm1/RcgRroR8VblWLMAiybJ
         wHXPGG680+t2MEn0kUUl/yQGRWecO4tERLQG7iI8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 94FB43522681; Sun, 24 May 2020 17:37:06 -0700 (PDT)
Date:   Sun, 24 May 2020 17:37:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        elver@google.com
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20200525003706.GA13789@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200522033119.1bbd99c5@canb.auug.org.au>
 <20200521173520.GL6608@willie-the-truck>
 <20200522171708.5f392fde@canb.auug.org.au>
 <20200522174944.1a1732fa@canb.auug.org.au>
 <20200523001223.GA23921@paulmck-ThinkPad-P72>
 <20200523064643.GA27431@zn.tnic>
 <87a71zq8ml.fsf@nanos.tec.linutronix.de>
 <20200523150614.GP2869@paulmck-ThinkPad-P72>
 <871rnaqxor.fsf@nanos.tec.linutronix.de>
 <20200523212345.GR2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523212345.GR2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 02:23:45PM -0700, Paul E. McKenney wrote:
> On Sat, May 23, 2020 at 09:05:24PM +0200, Thomas Gleixner wrote:
> > "Paul E. McKenney" <paulmck@kernel.org> writes:
> > > On Sat, May 23, 2020 at 11:54:26AM +0200, Thomas Gleixner wrote:
> > >> core/rcu is the one which diverged and caused the merge conflict with
> > >> PPC to happen twice. So Paul needs to remove the stale core/rcu bits and
> > >> rebase on the current version (which is not going to change again).
> > >
> > > So there will be another noinstr-rcu-* tag, and I will rebase on top
> > > of that, correct?  If so, fair enough!
> > 
> > Here you go: noinstr-rcu-220-05-23
> > 
> > I wanted this to be 2020 and not 220 but I noticed after pushing it
> > out. I guess it still does the job :)
> 
> Now -that- is what I call an old-school tag name!!!  ;-)
> 
> I remerged, rebased, and pushed to -rcu branch "dev".
> 
> If it survives testing, I will reset -rcu branch "rcu/next" as well.

And passed!  The compile times are back to their old selves on my
laptop as well.

Thank you for setting this up, Thomas!!!

							Thanx, Paul
