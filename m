Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6062AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3286F2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgE2UOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgE2UOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:14:42 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967ADC03E969;
        Fri, 29 May 2020 13:14:42 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jelOk-000794-SV; Fri, 29 May 2020 20:14:34 +0000
Date:   Fri, 29 May 2020 21:14:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michal Hocko <mhocko@suse.cz>, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: mmotm 2020-05-13-20-30 uploaded (objtool warnings)
Message-ID: <20200529201434.GH23230@ZenIV.linux.org.uk>
References: <20200528172005.GP2483@worktop.programming.kicks-ass.net>
 <20200529135750.GA1580@lst.de>
 <20200529143556.GE706478@hirez.programming.kicks-ass.net>
 <20200529145325.GB706518@hirez.programming.kicks-ass.net>
 <20200529153336.GC706518@hirez.programming.kicks-ass.net>
 <20200529160514.cyaytn33thphb3tz@treble>
 <20200529161253.GD706460@hirez.programming.kicks-ass.net>
 <20200529165011.o7vvhn4wcj6zjxux@treble>
 <CAHk-=wi7xda+zM=iRGXWbU9i8S7kbNaSfPhXVXR-vK6uEFNx_w@mail.gmail.com>
 <20200529200856.GG23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529200856.GG23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 09:08:56PM +0100, Al Viro wrote:
> On Fri, May 29, 2020 at 12:31:04PM -0700, Linus Torvalds wrote:
> > On Fri, May 29, 2020 at 9:50 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > >
> > > From staring at the asm I think the generated code is correct, it's just
> > > that the nested likelys with ftrace profiling cause GCC to converge the
> > > error/success paths.  But objtool doesn't do register value tracking so
> > > it's not smart enough to know that it's safe.
> > 
> > I'm surprised that gcc doesn't end up doing the obvious CSE and then
> > branch following and folding it all away in the end, but your patch is
> > obviously the right thing to do regardless, so ack on that.
> > 
> > Al - I think this had best go into your uaccess cleanup branch with
> > that csum-wrapper update, to avoid any unnecessary conflicts or
> > dependencies.
> 
> Sure, just let me verify that other branches don't introduce anything
> of that sort...

... they don't.

OK, folded, rebuild #for-next, pushed both out...
