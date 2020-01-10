Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED46AC33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E6F2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgAJRCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:02:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgAJRCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:02:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EFCF2072E;
        Fri, 10 Jan 2020 17:02:48 +0000 (UTC)
Date:   Fri, 10 Jan 2020 12:02:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg KH <greg@kroah.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>, bugzilla@colorremedies.com
Subject: Re: [PATCH 3/3] tracing: Do not create directories if lockdown is
 in affect
Message-ID: <20200110120246.0f2bafe0@gandalf.local.home>
In-Reply-To: <20200110165404.GA1837739@kroah.com>
References: <20191205020459.023316620@goodmis.org>
        <20191205020548.446051018@goodmis.org>
        <20200110163105.GA17434@home.goodmis.org>
        <20200110165404.GA1837739@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 17:54:04 +0100
Greg KH <greg@kroah.com> wrote:

> Relying only on the Fixes: tag to get things picked up by stable is a
> sure way to get it on the "slow, and maybe eventually, hopefully, it
> might make it into stable" path :)

I've been numbed by all the AUTOSEL patches, where I tend to think
Fixes is becoming enough. That said, this particular patch, I thought
was going in the same release as what it fixed, which is why I never
added stable to it. :-/

> 
> I have over 1000 patches right now in that "bucket" that need to be
> checked to see if they are relevant for stable backporting, just since
> 5.4 was released.  I have automated a lot of it, but still, they require
> manual review.
> 
> I'll go queue this up now, as it's simplest just to ask us to take it
> after it hits Linus's tree :)

Again, I thought the AUTOSEL would pick it up, as it seems to pick
other patches I don't intend on going to stable quickly ;-)

-- Steve
