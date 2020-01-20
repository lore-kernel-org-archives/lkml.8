Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7957C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C17422314
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579534350;
	bh=+Q76fSCqJVSD3BE6qeKMsO6YLozN5zqXlRrMeY4rfzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KNjmZHQO85GtfRDz7hbVyTi4K8BofpC0Lx92jvWa5Bh/NDvvGOBQD1XT8+NfJ1V71
	 YAZfZZ3qjIbkJgtJfN2AiQk4zeencsgZ+2DByBI8h+jIiGDAJ0DxMEWkgG0645pe80
	 gbYSscnawlkVAnXhfuOnirGqJFk/qj9ryHvJnzL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgATPc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:32:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATPc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:32:29 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FAA321D7E;
        Mon, 20 Jan 2020 15:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579534348;
        bh=+Q76fSCqJVSD3BE6qeKMsO6YLozN5zqXlRrMeY4rfzg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CCDDYm6+dL2Ig3ZVqUJIb8tK8qSZWU/P1q2xVTwsuTOAvY7c4yw7d+KSSOr56rTwe
         YHI/pSjSHpD6Zjwz6i+UdRzGC7ppRZqHhBNw/OYaDvtyGeRuSHNkpnUKJzadXaftsH
         6YGMP1PszZCCFebBTTCjAqgxBUcTVO5GMt7NDXys=
Date:   Tue, 21 Jan 2020 00:32:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= 
        <thoiland@redhat.com>, Jean-Tsung Hsiao <jhsiao@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/uprobe: Fix double perf_event linking on
 multiprobe uprobe
Message-Id: <20200121003223.b823d8ccefc38f3220869618@kernel.org>
In-Reply-To: <20200120124022.GA14897@hirez.programming.kicks-ass.net>
References: <157862073931.1800.3800576241181489174.stgit@devnote2>
        <20200120124022.GA14897@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020 13:40:22 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Jan 10, 2020 at 10:45:39AM +0900, Masami Hiramatsu wrote:
> 
> > diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> > index 4ee703728aec..03e4e180058d 100644
> > --- a/kernel/trace/trace_probe.h
> > +++ b/kernel/trace/trace_probe.h
> > @@ -230,6 +230,7 @@ struct trace_probe_event {
> >  	struct trace_event_call		call;
> >  	struct list_head 		files;
> >  	struct list_head		probes;
> > +	char				data[0];
> >  };
> 
> Would it make sense to make the above:
> 
> 	struct trace_uprobe_filter	filter[0];
> 
> instead? That would ensure that alignment is respected. While I think
> the current code works by accident.

Hmm, if we consider the alignment, shouldn't we allocate the structure
with the alignment gap? Currently it just added the 
sizeof(struct trace_uprobe_filter) when kzalloc().

In this case, I think we should introduce a new data structure,
trace_uprobe_event.

Thank you,

> 
> > @@ -264,6 +263,14 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
> >  }
> >  NOKPROBE_SYMBOL(process_fetch_insn)
> >  
> > +static struct trace_uprobe_filter *
> > +trace_uprobe_get_filter(struct trace_uprobe *tu)
> > +{
> > +	struct trace_probe_event *event = tu->tp.event;
> > +
> > +	return (struct trace_uprobe_filter *)&event->data[0];
> > +}
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
