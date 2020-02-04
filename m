Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094E0C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9432084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgBDNqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:46:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbgBDNqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:46:49 -0500
Received: from oasis.local.home (unknown [212.187.182.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E7D320730;
        Tue,  4 Feb 2020 13:46:47 +0000 (UTC)
Date:   Tue, 4 Feb 2020 08:46:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] tracing: Changes for 5.6
Message-ID: <20200204084642.450b6ebd@oasis.local.home>
In-Reply-To: <CAHk-=wg2Wk9ZgVBDCBHa3-b0fSfByiRJnGA_F8snMy=3HHg_gw@mail.gmail.com>
References: <20200204053155.127c3f1e@oasis.local.home>
        <CAHk-=wjfjO+h6bQzrTf=YCZA53Y3EDyAs3Z4gEsT7icA3u_Psw@mail.gmail.com>
        <20200204072856.0da60613@oasis.local.home>
        <CAHk-=wg2Wk9ZgVBDCBHa3-b0fSfByiRJnGA_F8snMy=3HHg_gw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2020 13:19:06 +0000
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> Because it strikes me that the bootconfig should be the special case
> (ie "bootconfig does setup for boot-time tracing"), and that you
> should explicitly say "I want you to read the extended config" on the
> regular kernel command line.
> 
> So from looking at this, I do have to say that I'd have a slight
> preference for simply making this be an option like
> "config=bootconfig" that says "extend cmdline with the data from the
> 'bootconfig' file".

OK, I like this idea. As the current approach "silently" adds the boot
config, it may be surprising to someone that the configs are changing
(if they don't know to look for /proc/bootconfig).

Having a "config=bootconfig" required for reading makes it implicit
that a bootconfig is added to the existing command line, from just
looking at /proc/cmdline, and removing an added "config=bootconfig" 

> 
> Would that be horribly painful for your uses?
> 

I have no problem with this approach. Masami, are you OK with this?

I'll send a v2 implementing this change shortly.

-- Steve
