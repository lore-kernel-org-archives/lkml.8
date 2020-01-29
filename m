Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896AAC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 00:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D32922522
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 00:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580257376;
	bh=u6C1MVo9jXhGL921CEjIZKyAAcJehXxHmbS6eFZQhjc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=SS6+X1cLDLXT3YWtUIcN9w2mxvFtXC+/md8LjFlMiUFL4GJVoqqUOeLpQDl7YdSNA
	 HqD0rhABqeWiizw/RYCxoz9mFhnw/osdcqGqXW7QMYZjq6/cNVE5pH1g2YfdFAwErP
	 xejgfRNKMJWZvjfU/+SIi6v/AxmY7yHsYpKffdV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgA2AWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 19:22:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgA2AWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 19:22:55 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A3DB2173E;
        Wed, 29 Jan 2020 00:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580257374;
        bh=u6C1MVo9jXhGL921CEjIZKyAAcJehXxHmbS6eFZQhjc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Jtv85/HYFicY6gu9wWS4weM5U4KubO3bs8Ui+oJHlNwIx/Wv/y5B3rjinppTv4EoM
         kVvSHpsbX7j5VeVQCpDurg6i4hgXRVEKutrNnZSOh5b//MFbjaSYSGen0MO4Ui4dSH
         hF4CgyDJ4IZXA0mQHeOI2ZTxcYiAeiXXITeOokjw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0084C352273D; Tue, 28 Jan 2020 16:22:53 -0800 (PST)
Date:   Tue, 28 Jan 2020 16:22:53 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
Message-ID: <20200129002253.GT2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200122165938.GA16974@willie-the-truck>
 <A5114711-B8DE-48DA-AFD0-62128AC08270@lca.pw>
 <20200122223851.GA45602@google.com>
 <A90E2B85-77CB-4743-AEC3-90D7836C4D47@lca.pw>
 <20200123093905.GU14914@hirez.programming.kicks-ass.net>
 <E722E6E0-26CB-440F-98D7-D182B57D1F43@lca.pw>
 <CANpmjNNo6yW-y-Af7JgvWi3t==+=02hE4-pFU4OiH8yvbT3Byg@mail.gmail.com>
 <20200128165655.GM14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128165655.GM14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 05:56:55PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 28, 2020 at 12:46:26PM +0100, Marco Elver wrote:
> 
> > > Marco, any thought on improving KCSAN for this to reduce the false
> > > positives?
> > 
> > Define 'false positive'.
> 
> I'll use it where the code as written is correct while the tool
> complains about it.

I could be wrong, but I would guess that Marco is looking for something
a little less subjective and a little more specific.  ;-)

> > From what I can tell, all 'false positives' that have come up are data
> > races where the consequences on the behaviour of the code is
> > inconsequential. In other words, all of them would require
> > understanding of the intended logic of the code, and understanding if
> > the worst possible outcome of a data race changes the behaviour of the
> > code in such a way that we may end up with an erroneously behaving
> > system.
> > 
> > As I have said before, KCSAN (or any data race detector) by definition
> > only works at the language level. Any semantic analysis, beyond simple
> > rules (such as ignore same-value stores) and annotations, is simply
> > impossible since the tool can't know about the logic that the
> > programmer intended.
> > 
> > That being said, if there are simple rules (like ignore same-value
> > stores) or other minimal annotations that can help reduce such 'false
> > positives', more than happy to add them.
> 
> OK, so KCSAN knows about same-value-stores? If so, that ->cpu =
> smp_processor_id() case really doesn't need annotation, right?

If smp_processor_id() returns the value already stored in ->cpu,
I believe that the default KCSAN setup refrains from complaining.

Which reminds me, I need to disable this in my RCU runs.  If I create a
bug that causes me to unknowingly access something that is supposed to
be CPU-private from the wrong CPU, I want to know about it.

> > What to do about osq_lock here? If people agree that no further
> > annotations are wanted, and the reasoning above concludes there are no
> > bugs, we can blacklist the file. That would, however, miss new data
> > races in future.
> 
> I'm still hoping to convince you that the other case is one of those
> 'simple-rules' too :-)

On this I must defer to Marco.

							Thanx, Paul
