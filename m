Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41781C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A13206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgBUCwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:52:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:42468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbgBUCwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:52:38 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7EF2206EF;
        Fri, 21 Feb 2020 02:52:37 +0000 (UTC)
Date:   Thu, 20 Feb 2020 21:52:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Have synthetic event test use
 raw_smp_processor_id()
Message-ID: <20200220215236.268b4990@oasis.local.home>
In-Reply-To: <20200221092230.6ec9160d0ae135b14f29fd8c@kernel.org>
References: <20200220162950.35162579@gandalf.local.home>
        <1582236880.12738.5.camel@kernel.org>
        <20200221092230.6ec9160d0ae135b14f29fd8c@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 09:22:30 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 20 Feb 2020 16:14:40 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > On Thu, 2020-02-20 at 16:29 -0500, Steven Rostedt wrote:  
> > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > > 
> > > The test code that tests synthetic event creation pushes in as one of
> > > its
> > > test fields the current CPU using "smp_processor_id()". As this is
> > > just
> > > something to see if the value is correctly passed in, and the actual
> > > CPU
> > > used does not matter, use raw_smp_processor_id(), otherwise with
> > > debug
> > > preemption enabled, a warning happens as the smp_processor_id() is
> > > called
> > > without preemption enabled.
> > > 
> > > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> > 
> > Makes sense - I guess it's simpler than Masami's and fine for this
> > purpose.
> > 
> > Reviewed-by: Tom Zanussi <zanussi@kernel.org>  
> 
> Hmm, can we reserve ring buffer on CPU1 and commit it on CPU2?
> Shouldn't we disable preemption between them?
> 

I don't think it matters. There's nothing that checks it. And if one
was concerned about the content of the CPU, one could always enable
scheduling events and see the task migrate.

-- Steve

