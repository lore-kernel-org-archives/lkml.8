Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910B4C4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60447206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tw6kKo2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgBZQ20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:28:26 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57622 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgBZQ2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cxDmKJums1Yw5hsbamtZg0/vSQBgjr5D+7wgCmatioE=; b=tw6kKo2Duv8Hk8DCmU2Xw/Ra/J
        Qnq5Oq+a1gJJf1W+EIJgu71Gh+AELvvQbZryiwZaIIQiHvqweVidrqUqkMKRu/TdF/Yv8FBFzQ1iW
        J8HDAjmwh6oI3xPDzfKwH+0jIUV5pQGwlAiz2zhTZMAfWQlRSbAxsscMr3Y0qPGXB+GyOa6bvgA8d
        PWOCPkck7w9LLWjBAVW4oc3dKLYa/HS9aJ36azl10ZoeLRJ0AiApUh+YNrq4eGxFEWJhX6a4xXdQt
        yaRjCjPmeRF4dtUHulb3JolKDB+RwKalmxxPveWvINFMTsjho+0tV/ISCHaqqTN9xECPJlr/QS6Wy
        bhemJkyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6zXh-0001Jt-FF; Wed, 26 Feb 2020 16:28:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F689300130;
        Wed, 26 Feb 2020 17:26:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF42F2B746023; Wed, 26 Feb 2020 17:28:11 +0100 (CET)
Date:   Wed, 26 Feb 2020 17:28:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 13/16] x86/entry: Move irqflags and context tracking to C
 for simple idtentries
Message-ID: <20200226162811.GA18400@hirez.programming.kicks-ass.net>
References: <20200225223321.231477305@linutronix.de>
 <20200225224145.444611199@linutronix.de>
 <20200226080538.GO18400@hirez.programming.kicks-ass.net>
 <20200226092018.GR18400@hirez.programming.kicks-ass.net>
 <CALCETrXYbmrVvYQzBDp8YP+-UyF3KPDgcK__HuNmpdsMBJYDVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXYbmrVvYQzBDp8YP+-UyF3KPDgcK__HuNmpdsMBJYDVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 07:11:39AM -0800, Andy Lutomirski wrote:

> In some sense, this is a weakness of the magic macro approach.  Some
> of the entries just want to have code that runs before all the entry
> fixups.  This is an example of it.  So are the cr2 reads.  It can all
> be made to work, but it's a bit gross.

Right. In my current pile (new patche since last posting) I also have
one that makes #DB save-clear/restore DR7.

I got it early enough that only a watchpoint on the task stack can still
screw us over, since I also included your patch that excludes
cpu_entry_area.

Pushing it earlier still would require calling into C from the entry
stack, which I know is on your todo list, but we're not quite there yet.
