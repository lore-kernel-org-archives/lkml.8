Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8A3C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 15:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9151B2071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 15:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590246375;
	bh=fNU94PIFqW/vrhKGVesQWvCcqNVIkxzhGnzfchbKHFk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=VHYJYxx7GIqa8ob1X2eEnJtLb9fBmKVMe3patpqVXPpfg9xuLZbmK5p7XNzPSraa6
	 rRNDYoqgWy865eR0ytR+HPSNc04upcIyVigo2DzxALoAMx2t3ojfKD4lNqMBAhyLbh
	 yOs0i2CLPS/DRQ4vxSYbh36ritmAKxzurYKktr1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387919AbgEWPGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 11:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387815AbgEWPGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 11:06:14 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31B5920759;
        Sat, 23 May 2020 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590246374;
        bh=fNU94PIFqW/vrhKGVesQWvCcqNVIkxzhGnzfchbKHFk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ow3u7zzJgRGiMF1R/LzhoBimrLtRj1vveQ1nljZhIT7khki3bjfek2hEJvicz+FNR
         h4m3gDvK5pITtbQ0oNeEPs1XVmPPQIGu2XSWOyUW2hMNzURC/IS4fU2Kfm5+7otyLB
         3iUjnVQD4EZLxo6g30qdlEsztFCPTmNeF6O6ZlZQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1600B352267C; Sat, 23 May 2020 08:06:14 -0700 (PDT)
Date:   Sat, 23 May 2020 08:06:14 -0700
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
Message-ID: <20200523150614.GP2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200522033119.1bbd99c5@canb.auug.org.au>
 <20200521173520.GL6608@willie-the-truck>
 <20200522171708.5f392fde@canb.auug.org.au>
 <20200522174944.1a1732fa@canb.auug.org.au>
 <20200523001223.GA23921@paulmck-ThinkPad-P72>
 <20200523064643.GA27431@zn.tnic>
 <87a71zq8ml.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a71zq8ml.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 11:54:26AM +0200, Thomas Gleixner wrote:
> Borislav Petkov <bp@alien8.de> writes:
> 
> > On Fri, May 22, 2020 at 05:12:23PM -0700, Paul E. McKenney wrote:
> >> Marco, Thomas, is there any better setup I can provide Stephen?  Or
> >> is the next-20200519 -rcu tree the best we have right now?
> >
> > I've queued the fixes yesterday into tip:locking/kcsan and tglx said
> > something about you having to rebase anyway. I guess you can find him on
> > IRC at some point later. :)
> 
> locking/kcsan is not the problem (it just has more fixes on top)
> 
> core/rcu is the one which diverged and caused the merge conflict with
> PPC to happen twice. So Paul needs to remove the stale core/rcu bits and
> rebase on the current version (which is not going to change again).

So there will be another noinstr-rcu-* tag, and I will rebase on top
of that, correct?  If so, fair enough!

							Thanx, Paul
