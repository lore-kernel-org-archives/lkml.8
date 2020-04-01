Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7510BC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4226A20772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dIM/38LK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732984AbgDAUVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:21:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732441AbgDAUVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WxdFKtsVVN0bQtvpk47mBJIN2dJgsmvYV4GQBky07Qw=; b=dIM/38LKg5HoRDEnEeJwA9h2y4
        mxrdGtCGcqX/EBOQZBvVXJfUt7U4MESfuywAtG55Th1l7RwBiM90H2N5TjAlw5/YpIkmEB2JpeWrI
        6U0Frn0/tvrpg34/wGM0V6VCtlkPUjIq1ELus900JnPm4EpSsXhStsnCW1dzuKiUvyTV6Sks7I/Yc
        NMdqV5yTq9+l+cnNRoBovNT1CphscWmbg8Hf0O9haBg+4K2dZxsJaRANBqraoWSkzegGcS6Ub7PdJ
        3lGTuW6eYsVS0h7boNbUQPXVRpguSRAyvgINscPkpn8A2CvvFfqWzNHagRZj9rYkudHisJLvhxn42
        p09M96LA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJjr6-00027S-3f; Wed, 01 Apr 2020 20:20:56 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 92A5E981135; Wed,  1 Apr 2020 22:20:53 +0200 (CEST)
Date:   Wed, 1 Apr 2020 22:20:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz
Subject: Re: [PATCH v2] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200401202053.GI2452@worktop.programming.kicks-ass.net>
References: <20200331202315.zialorhlxmml6ec7@treble>
 <20200331204047.GF2452@worktop.programming.kicks-ass.net>
 <20200331211755.pb7f3wa6oxzjnswc@treble>
 <20200331212040.7lrzmj7tbbx2jgrj@treble>
 <20200331222703.GH2452@worktop.programming.kicks-ass.net>
 <d2cad75e-1708-f0bf-7f88-194bcb29e61d@redhat.com>
 <20200401170910.GX20730@hirez.programming.kicks-ass.net>
 <20200401133303.6773c574@gandalf.local.home>
 <20200401174544.GY20730@hirez.programming.kicks-ass.net>
 <20200401142015.60ac0a28@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401142015.60ac0a28@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 02:20:15PM -0400, Steven Rostedt wrote:
> On Wed, 1 Apr 2020 19:45:44 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > I believe what Julien is saying is the above logic is equivalent:
> > > 
> > > 	if (x != y &&
> > > 	    !(z && x == y + z))
> > > 
> > > is the same as:
> > > 
> > > 	if (x != y + z)  
> > 
> > It is not, the former will accept either x==y || x==y+z, while the
> > latter will only accept x==y+z.
> 
> No, the former accepts:
> 
> 	x==y || (z && x == y + z)
> 
> Which is the same as: x == y + z
> 
> As the second condition is only tested if z != 0, and x ==  y is the same
> as x == y + 0

Right, so it accepts both +0 and +z, while the latter will only accept
+z.

( in the iret case I had offset at +0 and stack_size at +40, while with
  the ftrace case I had both at +8; which is why I wrote the form that
  accepts +0 and +z )

Anyway, I tested it, and for the ftrace case (the only current user of
the hint) +z is correct for both offset and stack_size. I build both FP
and ORC variants.
