Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4DEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A52E920759
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595878519;
	bh=xsoGM31kW2VrPyMnU5Snl46HwG9kOCh/rN4IW3/JF0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F2S15vS7I8c5nh0sBoRMNdhWNYJsu9vXbGhCNUGro2gHpvC9p/MaoTn1/yBR7hOJA
	 Y+dRRkklvxKTha228HGyPDtBUfY4IFLD57XlHNuORpM2AbeSFsmEFM9eRwNuPhP8x1
	 FwoJ+B2I/MSrJ+nLUHyUn4xrlkeCsg0TkAASsQ5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgG0TfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgG0TfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:35:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAFD120738;
        Mon, 27 Jul 2020 19:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595878517;
        bh=xsoGM31kW2VrPyMnU5Snl46HwG9kOCh/rN4IW3/JF0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2jC35nd4Q0ZjnCUAnY73gev9iFF2t2wk0UuRnoUMz8dSiFq8MP+4YlRbgmATlLtIG
         qaae1QhTZ0V2A18mlAkLEJNCLOIS1lpliii17qB8BUfSv4v9/sHPFw4zfNJNB+fbUR
         igL3KYajQoAZfzyXPbROFj/A2AF2V9hsO87EM/+A=
Date:   Mon, 27 Jul 2020 21:35:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200727193512.GA236164@kroah.com>
References: <alpine.LSU.2.11.2007231549540.1016@eggly.anvils>
 <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
 <20200724152424.GC17209@redhat.com>
 <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
 <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com>
 <20200725101445.GB3870@redhat.com>
 <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
 <alpine.LSU.2.11.2007251343370.3804@eggly.anvils>
 <alpine.LSU.2.11.2007252100230.5376@eggly.anvils>
 <alpine.LSU.2.11.2007261246530.6812@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2007261246530.6812@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 01:30:32PM -0700, Hugh Dickins wrote:
> On Sat, 25 Jul 2020, Hugh Dickins wrote:
> > On Sat, 25 Jul 2020, Hugh Dickins wrote:
> > > On Sat, 25 Jul 2020, Linus Torvalds wrote:
> > > > On Sat, Jul 25, 2020 at 3:14 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > > > >
> > > > > Heh. I too thought about this. And just in case, your patch looks correct
> > > > > to me. But I can't really comment this behavioural change. Perhaps it
> > > > > should come in a separate patch?
> > > > 
> > > > We could do that. At the same time, I think both parts change how the
> > > > waitqueue works that it might as well just be one "fix page_bit_wait
> > > > waitqueue usage".
> > > > 
> > > > But let's wait to see what Hugh's numbers say.
> > > 
> > > Oh no, no no: sorry for getting your hopes up there, I won't come up
> > > with any numbers more significant than "0 out of 10" machines crashed.
> > > I know it would be *really* useful if I could come up with performance
> > > comparisons, or steer someone else to do so: but I'm sorry, cannot.
> > > 
> > > Currently it's actually 1 out of 10 machines crashed, for the same
> > > driverland issue seen last time, maybe it's a bad machine; and another
> > > 1 out of the 10 machines went AWOL for unknown reasons, but probably
> > > something outside the kernel got confused by the stress.  No reason
> > > to suspect your changes at all (but some unanalyzed "failure"s, of
> > > dubious significance, accumulating like last time).
> > > 
> > > I'm optimistic: nothing has happened to warn us off your changes.
> > 
> > Less optimistic now, I'm afraid.
> > 
> > The machine I said had (twice) crashed coincidentally in driverland
> > (some USB completion thing): that machine I set running a comparison
> > kernel without your changes this morning, while the others still
> > running with your changes; and it has now passed the point where it
> > twice crashed before (the most troublesome test), without crashing.
> > 
> > Surprising: maybe still just coincidence, but I must look closer at
> > the crashes.
> > 
> > The others have now completed, and one other crashed in that
> > troublesome test, but sadly without yielding any crash info.
> > 
> > I've just set comparison runs going on them all, to judge whether
> > to take the "failure"s seriously; and I'll look more closely at them.
> 
> The comparison runs have not yet completed (except for the one started
> early), but they have all got past the most interesting tests, and it's
> clear that they do not have the "failure"s seen with your patches.
> 
> >From that I can only conclude that your patches make a difference.
> 
> I've deduced nothing useful from the logs, will have to leave that
> to others here with more experience of them.  But my assumption now
> is that you have successfully removed one bottleneck, so the tests
> get somewhat further and now stick in the next bottleneck, whatever
> that may be.  Which shows up as "failure", where the unlock_page()
> wake_up_page_bit() bottleneck had allowed the tests to proceed in
> a more serially sedate way.
> 
> The xhci handle_cmd_completion list_del bugs (on an older version
> of the driver): weird, nothing to do with page wakeups, I'll just
> have to assume that it's some driver bug exposed by the greater
> stress allowed down, and let driver people investigate (if it
> still manifests) when we take in your improvements.

Linus just pointed me at this thread.

If you could run:
	echo -n 'module xhci_hcd =p' > /sys/kernel/debug/dynamic_debug/control
and run the same workload to see if anything shows up in the log when
xhci crashes, that would be great.

Although if you are using an "older version" of the driver, there's not
much I can suggest except update to a newer one :)

thanks,

greg k-h
