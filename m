Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB3EC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D1720801
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgCETZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 14:25:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgCETZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 14:25:08 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5124E207FD;
        Thu,  5 Mar 2020 19:25:07 +0000 (UTC)
Date:   Thu, 5 Mar 2020 14:25:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [v5] Documentation: bootconfig: Update boot configuration
 documentation
Message-ID: <20200305142505.714a5121@gandalf.local.home>
In-Reply-To: <af5d4af0-9e06-cc6e-c29e-4c4eebdb9b0e@web.de>
References: <158339065180.26602.26457588086834858.stgit@devnote2>
        <158339066140.26602.7533299987467005089.stgit@devnote2>
        <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
        <3fb124a6-07d2-7a40-8981-07561aeb3c1e@web.de>
        <f823204d-dcd1-2159-a525-02f15562e1af@infradead.org>
        <29c599ef-991d-a253-9f27-5999fb55b228@web.de>
        <997f73af-dc6c-bc8b-12ba-69270ee4b95d@infradead.org>
        <dbef7b77-945a-585e-12fe-b5e30eb1a6bc@web.de>
        <e20f52a0-e522-c2cf-17a4-384a1f3308bc@infradead.org>
        <ecaffba3-fccd-32ee-763a-a2ec84a65148@web.de>
        <20200305140004.535eeb1a@gandalf.local.home>
        <af5d4af0-9e06-cc6e-c29e-4c4eebdb9b0e@web.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 20:14:00 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> >>>> Which of the possibly unanswered issues do you find not concrete enough so far?  
> >>>
> >>> e.g.:  
> >>>>>>  Will the clarification become more constructive for remaining challenges?  
> >>
> >> Do you expect that known open issues need to be repeated for each patch revision?  
> >
> > I'm clueless about what you are talking about.  
> 
> I suggest to take another look at review comments for previous patch versions.

I have, and I believe Masami has satisfactory addressed them, if they
needed addressing.

> 
> 
> > Yes there's communication difficulties.  
> 
> I hope that we can reduce them somehow.

Then please be more specific in your correspondence.

> 
> 
> >> How do you think about the desired tracking of bug reports
> >> also for this software?  
> >
> > What does that statement have to do with this patch series????  
> 
> Do you identify any feedback as a bug report (or clarification request) here?

I still don't have the foggiest clue what you are talking about. What bug
are you reporting?

-- Steve
