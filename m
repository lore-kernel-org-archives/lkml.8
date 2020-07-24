Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D298C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70002206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGXSvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 14:51:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGXSvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:51:51 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 635BF206D8;
        Fri, 24 Jul 2020 18:51:50 +0000 (UTC)
Date:   Fri, 24 Jul 2020 14:51:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Minor RST rant
Message-ID: <20200724145148.58836d66@oasis.local.home>
In-Reply-To: <20200724174130.GC23808@casper.infradead.org>
References: <20200724132200.51fd2065@oasis.local.home>
        <20200724174130.GC23808@casper.infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 18:41:30 +0100
Matthew Wilcox <willy@infradead.org> wrote:

> Great example.  Some people definitely go too far with rst markup, and
> we generally try to discourage it.  And I'm pretty sure we take patches

I'd send patches but I suck at markup ;-) [1]

> to remove excessive markup where it's gone too far [1].
> 
> You can see how this renders in html at
> https://www.kernel.org/doc/html/latest/filesystems/path-lookup.html or
> run 'make htmldocs' to build it locally.  Personally, I don't think
> the markup style it uses works very well in the html either.
> 
> I'd like to see this paragraph written as:
> 
> > It is tempting to describe the second kind as starting with a
> > component, but that isn't always accurate: a pathname can lack both
> > slashes and components, it can be empty, in other words.  This is
> > generally forbidden in POSIX, but some of the "*at()" system calls
> > in Linux permit it when the ``AT_EMPTY_PATH`` flag is given.  For
> > example, if you have an open file descriptor on an executable file you
> > can execute it by calling execveat() passing the file descriptor, an
> > empty path, and the ``AT_EMPTY_PATH`` flag.  
> 
> I think we're all pretty comfortable seeing function names adorned with
> a closing pair of parens.  The ``...`` to adorn constants feels OK to me,
> but maybe not to you?  If that feels excessive, can you suggest something
> that would distinguish between POSIX and AT_EMPTY_PATH?

Honestly, it's the context that distinguishes the two for me. I don't
need any markup. But yeah, the double backtick still seems awkward.
Funny thing is, markup like this:

  <b>AT_EMPTY_PATH</b>

doesn't bother me as much. Not sure why though :-/

My frustration with this stood out quite a bit because I went from one
file (with the same name) in .txt format, and went through that fast and
quickly where everything made a lot of sense, and then jumping to this
file, and feeling like I came to a stand-still in my understanding of
the material.

> 
> [1] Too far being a subjective measure, of course.  My preferences
> are on display in core-api/xarray.rst

[1] I maintain trace/ftrace.rst, but the markup in that was written by
others, and I gave a lot of pushback when I found that the markup made
it hard to read with "less".

-- Steve

