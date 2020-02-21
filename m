Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A578FC35653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7315124653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582280573;
	bh=HKlbipbezigcjRV0JxrSd089dDGKVqPRmt5W9SS/rwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=e5Z8eGzbKBnw/ByGNrOeZQttDTSPdA6B52jhvRfaDd3z5hF7LN/qUI4vAalDi33qr
	 nLbfsWUCJGSNTel8R1hbiUA/b+GjgcroncAWejkwb4TZqx+CfdQ1cW0SsQpEFiIpON
	 qy668MGdY/kbKD4f/YpOk7I7dC3eQP9wbD+7aUg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgBUKWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:22:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbgBUKWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:22:51 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0524E222C4;
        Fri, 21 Feb 2020 10:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582280571;
        bh=HKlbipbezigcjRV0JxrSd089dDGKVqPRmt5W9SS/rwA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dIKaeUmkqyv0XrtFca0m7PMwEsPvt5cnYgHwqASMDxfC9P4PFbgQGYm4TcgHt8fDB
         Avw0QEQi+uzFSpgq9Q5PxWuLqm/9BsYyzjMHz0G4IQooWzAOVsajZMjm0ayWfSUe0g
         3J4VOCOBV6jnO8oI64ROQky5H1rH1gFTIkbLx/AQ=
Date:   Fri, 21 Feb 2020 19:22:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Have synthetic event test use
 raw_smp_processor_id()
Message-Id: <20200221192247.1b3f693f3023470b9f8a2068@kernel.org>
In-Reply-To: <20200220215236.268b4990@oasis.local.home>
References: <20200220162950.35162579@gandalf.local.home>
        <1582236880.12738.5.camel@kernel.org>
        <20200221092230.6ec9160d0ae135b14f29fd8c@kernel.org>
        <20200220215236.268b4990@oasis.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 21:52:36 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 21 Feb 2020 09:22:30 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Thu, 20 Feb 2020 16:14:40 -0600
> > Tom Zanussi <zanussi@kernel.org> wrote:
> > 
> > > Hi Steve,
> > > 
> > > On Thu, 2020-02-20 at 16:29 -0500, Steven Rostedt wrote:  
> > > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > > > 
> > > > The test code that tests synthetic event creation pushes in as one of
> > > > its
> > > > test fields the current CPU using "smp_processor_id()". As this is
> > > > just
> > > > something to see if the value is correctly passed in, and the actual
> > > > CPU
> > > > used does not matter, use raw_smp_processor_id(), otherwise with
> > > > debug
> > > > preemption enabled, a warning happens as the smp_processor_id() is
> > > > called
> > > > without preemption enabled.
> > > > 
> > > > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> > > 
> > > Makes sense - I guess it's simpler than Masami's and fine for this
> > > purpose.
> > > 
> > > Reviewed-by: Tom Zanussi <zanussi@kernel.org>  
> > 
> > Hmm, can we reserve ring buffer on CPU1 and commit it on CPU2?
> > Shouldn't we disable preemption between them?
> > 
> 
> I don't think it matters. There's nothing that checks it. And if one
> was concerned about the content of the CPU, one could always enable
> scheduling events and see the task migrate.

Ah, OK I confirmed that the preemption is disabled in ring_buffer_nest_start()
so it should not happen.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> -- Steve
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
