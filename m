Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46153C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 00:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FDC020714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 00:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="I+eFnlLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgG1A3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 20:29:43 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:32381 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbgG1A3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 20:29:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595896183; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=D+Z7yUUloXsYlhU9r6t09bpfS3kWC/9+jPPFCACQA1U=; b=I+eFnlLzxOe8VQU/B1xHA+bfQKNMY48lrjwmEe7kp8pEhmFTcG68B+eK7RFtHSIsfXftl0Tp
 ArqZSTZQtYW2hxgZHGLrdLxPrDODozGqxTZnqj8h8IMQvZw7sYrNTV/lqlwj89lqv6Uydm0W
 SEUa0SBMXIOao2xnOMgBFRpKdik=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-west-2.postgun.com with SMTP id
 5f1f7169634c4259e3dcfbed (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Jul 2020 00:29:29
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C82DDC433CB; Tue, 28 Jul 2020 00:29:28 +0000 (UTC)
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C69BCC433C9;
        Tue, 28 Jul 2020 00:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C69BCC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingweiz@codeaurora.org
Date:   Tue, 28 Jul 2020 08:29:22 +0800
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Ingo Molnar <mingo@redhat.com>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] tracing: add flag to control different traces
Message-ID: <20200728002922.GB10290@codeaurora.org>
References: <20200726025931.30510-1-tingwei@codeaurora.org>
 <20200726025931.30510-3-tingwei@codeaurora.org>
 <20200727144550.7aa40c61@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727144550.7aa40c61@oasis.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,
On Tue, Jul 28, 2020 at 02:45:50AM +0800, Steven Rostedt wrote:
> On Sun, 26 Jul 2020 10:59:27 +0800
> Tingwei Zhang <tingwei@codeaurora.org> wrote:
> 
> 
> > diff --git a/include/linux/trace.h b/include/linux/trace.h
> > index 7fd86d3c691f..d2fdf9be84b5 100644
> > --- a/include/linux/trace.h
> > +++ b/include/linux/trace.h
> > @@ -3,6 +3,9 @@
> >  #define _LINUX_TRACE_H
> >  
> >  #ifdef CONFIG_TRACING
> > +
> > +#define TRACE_EXPORT_FUNCTION	BIT_ULL(0)
> 
> All the flags variables below are defined as "int". Why the BIT_ULL()?
> BIT(0) should work just fine. The ULL makes one think these flags will
> be used for unsigned long variables, which it is not.
> 

That's my mistake.  Thanks for point that out. I'll fix it in next
revision.

> -- Steve
> 
> 
> > +
> 
> >  struct trace_export {
> >  	struct trace_export __rcu	*next;
> >  	void (*write)(struct trace_export *, const void *, unsigned int);
> > +	int flags;
> >  };
> >  
> >  int register_ftrace_export(struct trace_export *export);
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index bb62269724d5..8f1e66831e9e 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -2747,33 +2747,37 @@ trace_buffer_unlock_commit_nostack(struct
> trace_buffer *buffer,
> >  
> >  static void
> >  trace_process_export(struct trace_export *export,
> > -	       struct ring_buffer_event *event)
> > +	       struct ring_buffer_event *event, int flag)
> >  {
> >  	struct trace_entry *entry;
> >  	unsigned int size = 0;
> >  
> > -	entry = ring_buffer_event_data(event);
> > -	size = ring_buffer_event_length(event);
> > -	export->write(export, entry, size);
> > +	if (export->flags & flag) {
> > +		entry = ring_buffer_event_data(event);
> > +		size = ring_buffer_event_length(event);
> > +		export->write(export, entry, size);
> > +	}
> >  }
