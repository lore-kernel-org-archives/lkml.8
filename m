Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BDEC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52738208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCEU4b convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:56:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:57260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgCEU4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:56:30 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9B9020801;
        Thu,  5 Mar 2020 20:56:29 +0000 (UTC)
Date:   Thu, 5 Mar 2020 15:56:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [v5] Documentation: bootconfig: Update boot configuration
 documentation
Message-ID: <20200305155628.09a1e1d4@gandalf.local.home>
In-Reply-To: <2d5df2ac-443b-cc31-c2bf-78947f81dd00@web.de>
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
        <20200305142505.714a5121@gandalf.local.home>
        <2d5df2ac-443b-cc31-c2bf-78947f81dd00@web.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 21:10:21 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> >> I suggest to take another look at review comments for previous patch versions.  
> >
> > I have, and I believe Masami has satisfactory addressed them,  
> 
> I agree to parts of the shown software evolution.
> 
> 
> > if they needed addressing.  
> 
> Remaining issues will eventually be clarified under other circumstances.
> 
> 
> >> Do you identify any feedback as a bug report (or clarification request) here?  
> >
> > I still don't have the foggiest clue what you are talking about.  
> 
> It seems that a few reminders can help here.
> 
> 
> > What bug are you reporting?  
> 
> Examples:
> 
> * Another typo
>   “… contain only alphabets, …”
>   https://lore.kernel.org/linux-doc/967d6fee-e0cd-c53f-c1f6-b367a979762c@web.de/
>   https://lkml.org/lkml/2020/3/5/247

Legitimate but not critical.

> 
> * Use case explanation
>   https://lore.kernel.org/linux-doc/f3c51b0a-2a55-6523-96e2-4f9ef0635d9f@web.de/
>   https://lkml.org/lkml/2020/3/5/429

I believe what Masami has is sufficient.

> 
> * Challenges for the safe application of key hierarchies
>   “kernel.ftrace”?
>   https://lore.kernel.org/linux-doc/c4a0bc10-a38b-6ea9-e125-7a37f667e61a@web.de/
>   https://lkml.org/lkml/2020/2/28/363

Again, what Masami has is sufficient.

> 
> * Feature request for syntax description
>   https://lore.kernel.org/linux-doc/2390b729-1b0b-26b5-66bc-92e40e3467b1@web.de/
>   https://lkml.org/lkml/2020/2/27/1869
> 

Masami's reply to you was sufficient.

Of your examples, only one do I see can be applied, but is just a minor
change in wording.

I don't know where you are going with this, and unless you plan on
submitting patches, I think this document is complete as is.

-- Steve
