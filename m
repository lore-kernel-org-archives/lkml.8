Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EF2C433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2A82065E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGXSmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 14:42:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgGXSmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:42:36 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1F152065E;
        Fri, 24 Jul 2020 18:42:35 +0000 (UTC)
Date:   Fri, 24 Jul 2020 14:42:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>
Subject: Re: Minor RST rant
Message-ID: <20200724144234.3227b501@oasis.local.home>
In-Reply-To: <20200724113325.44923f75@lwn.net>
References: <20200724132200.51fd2065@oasis.local.home>
        <20200724113325.44923f75@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 11:33:25 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> Give people a tool, some of them will make more use of it than you might
> like. I do my best to push back against excessive markup (which all of the
> above qualifies as, as far as I'm concerned), but I can't really even do
> that will all that goes through my tree, much less all the docs stuff
> merged by others.
> 
> The markup in question was seemingly added by Neil; I've added him to CC
> in case he wants to comment on it.

I saw Neil as the author and should have Cc'd him.

Neil, you can read my full email here:

  https://lore.kernel.org/r/20200724132200.51fd2065@oasis.local.home

> 
> I'm not sure what to do other than to continue to push for minimal use of
> intrusive markup.

Yeah, I really didn't expect an action item to come from this. It was
just some feedback, and perhaps you can use this as an example of "too
much markup" when dealing with others.

Looking at the web page that Matthew pointed out to, does make it much
easier to read. But one still needs to remember that a large audience
of this work is still those of us that will read the plain text.

My viewer of choice is "less" ;-)

-- Steve
