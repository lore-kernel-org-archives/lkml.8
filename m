Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5685EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDB02072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgC3Sju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgC3Sjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:39:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4433920714;
        Mon, 30 Mar 2020 18:39:49 +0000 (UTC)
Date:   Mon, 30 Mar 2020 14:39:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ftrace not showing the process names for all processes on
 syscall events
Message-ID: <20200330143947.33515a16@gandalf.local.home>
In-Reply-To: <ffd8aa59d88146fbb5a4cb02ea9b7440@AcuMS.aculab.com>
References: <3cdef49951734e83a14959628233d4f0@AcuMS.aculab.com>
        <20200330110855.437fe854@gandalf.local.home>
        <7dec110c2dc14792ba744419a4eb907e@AcuMS.aculab.com>
        <20200330140736.4b5f1667@gandalf.local.home>
        <ffd8aa59d88146fbb5a4cb02ea9b7440@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 18:14:37 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Steven Rostedt
> > Sent: 30 March 2020 19:08
> > On Mon, 30 Mar 2020 15:34:08 +0000
> > David Laight <David.Laight@ACULAB.COM> wrote:
> >   
> > > Oh, does the 'function_graph' code ignore tail calls?  
> > 
> > Yes and no ;-)  It works by dumb luck. As it was a year after function
> > graph tracing was live (some time in 2010 I believe) that someone brought
> > up tail calls, and I had to take a look at how it never crashed, and was
> > surprised that it "just worked". Here's a summary:  
> 
> 'Dumb luck' seems to be failing me :-)
> I'll look more closely tomorrow.

The tl;td; version is that the function graph tracer relies on a shadow
stack that it uses to save the original return address, as it replaces the
original return address with the address of the fgraph return trampoline.

Although a tail call causes the real stack to only contain one return
address, the shadow stack will contain a return address for every function,
even if it was a tail call. As that stack gets updated by the entry of the
function not the return side. The difference is, a tail call would cause
the shadow stack to just contain a call to the start of the fgraph return
trampoline, and not an address into the rest of the kernel.

-- Steve

