Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76653C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5696B206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbgG1P2b convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730637AbgG1P2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:28:31 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 475BA206D4;
        Tue, 28 Jul 2020 15:28:30 +0000 (UTC)
Date:   Tue, 28 Jul 2020 11:28:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     peterz@infradead.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>
Subject: Re: Minor RST rant
Message-ID: <20200728112828.459307a5@oasis.local.home>
In-Reply-To: <20200728125252.GW119549@hirez.programming.kicks-ass.net>
References: <20200724132200.51fd2065@oasis.local.home>
        <20200724113325.44923f75@lwn.net>
        <20200728125252.GW119549@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 14:52:52 +0200
peterz@infradead.org wrote:

> On Fri, Jul 24, 2020 at 11:33:25AM -0600, Jonathan Corbet wrote:
> 
> > I'm not sure what to do other than to continue to push for minimal use of
> > intrusive markup.  
> 
> Perhaps make it clearer in:
> 
>   Documentation/doc-guide/

Well, it's currently in:

https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#specific-guidelines-for-the-kernel-documentation

	Please don’t go overboard with reStructuredText markup. Keep it
	simple. For the most part the documentation should be plain text
	with just enough consistency in formatting that it can be
	converted to other formats.

But perhaps we should stress that in other locations and make it more
prevalent in the documentation.

> 
> because people claim they follow that, but the result is that I get
> completely unreadable garbage from them.
> 
> Like I've written many times before, I'm starting to loathe RST, it's an
> absolute failure. I'm near the point where I'm looking to write a script
> that will silently convert any RST crap to plain text in my commit
> script.

Sometimes I do look at the html output on kernel.org, and it is nicely
organized. The future of developers will probably prefer that format
over plain text whether we like it or not, so I encourage that we
continue using RST. That said, people still need to be very careful not
to make their markup in the text files focused so much on the html
output, that they make it unreadable for the rest of us.

I think Jon has been doing a great job at having the rst files still be
readable in their raw formats, but people still get carried away.
Instead of writing scripts to rip it out, we need to continue the
conversations to educate people that some of us need these files to
remain readable as plain text.

-- Steve
