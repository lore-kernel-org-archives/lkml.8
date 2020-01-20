Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E099FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF050207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lMjKXplV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgATMky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:40:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgATMkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A7ASFk0z2TqRbFR1ju+tc68fwEGsQHIpdYzXYGrSwZo=; b=lMjKXplVRQnT4b5Hzw6FVcROW
        xOXSREB58PdNkolgu3G438vAfj57OrnS3ZgeMQUUTk/M5oEKAuTCczYTUKic6QWzzXHsoHrqsqg71
        X8RyKIoWyRPQ2CFtOLYdV9mRg0khhHKEJUBAEVpl5MB8q/1Lgw3rB2LY2aLhPvKWUVcvTzCeNrYYK
        K/VfH6+weyZ2v24BV6pcMVLo4Ye3wT+hilHMAH7EFQ630BJkm72KNTq4jMdXRbozOoOG2HYDlkFE2
        N1hb0UDz6Zt6ioH9SMtFhw8mvspGMnawzZQo3EU1uy93DuRPkxk/2L1OW0FVdWQj1rMf32lSZ4AlQ
        Nxws13U7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itWLx-0003Xd-1h; Mon, 20 Jan 2020 12:40:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA1B93035D4;
        Mon, 20 Jan 2020 13:38:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AF8E2B29B4BF; Mon, 20 Jan 2020 13:40:22 +0100 (CET)
Date:   Mon, 20 Jan 2020 13:40:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <thoiland@redhat.com>,
        Jean-Tsung Hsiao <jhsiao@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/uprobe: Fix double perf_event linking on
 multiprobe uprobe
Message-ID: <20200120124022.GA14897@hirez.programming.kicks-ass.net>
References: <157862073931.1800.3800576241181489174.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157862073931.1800.3800576241181489174.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 10:45:39AM +0900, Masami Hiramatsu wrote:

> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 4ee703728aec..03e4e180058d 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -230,6 +230,7 @@ struct trace_probe_event {
>  	struct trace_event_call		call;
>  	struct list_head 		files;
>  	struct list_head		probes;
> +	char				data[0];
>  };

Would it make sense to make the above:

	struct trace_uprobe_filter	filter[0];

instead? That would ensure that alignment is respected. While I think
the current code works by accident.

> @@ -264,6 +263,14 @@ process_fetch_insn(struct fetch_insn *code, struct pt_regs *regs, void *dest,
>  }
>  NOKPROBE_SYMBOL(process_fetch_insn)
>  
> +static struct trace_uprobe_filter *
> +trace_uprobe_get_filter(struct trace_uprobe *tu)
> +{
> +	struct trace_probe_event *event = tu->tp.event;
> +
> +	return (struct trace_uprobe_filter *)&event->data[0];
> +}


