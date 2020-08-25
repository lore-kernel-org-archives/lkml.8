Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36948C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1175920782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="QpnaK3Zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgHYPjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:39:54 -0400
Received: from smtp1.axis.com ([195.60.68.17]:16385 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgHYPjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2177; q=dns/txt; s=axis-central1;
  t=1598369992; x=1629905992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4ZlMcg4Ilu92hAGYdNwpPVPQERB0KU5QHaM832tUSMk=;
  b=QpnaK3ZuliZc7kWA3Ry06+iNt8bW8aNlhpYs9WO34LHzpxj2FjFMsIGd
   MqYwvKVJ5KLQRIyIRJA8pMdz1ybj78vJfmUvXnE5574AZKRlPNuh/QUD+
   sakNceQluVgkNO/ruIQH5mepCAYeLkoTP884EEl9gmboCFQUCuJRgA6RG
   dMJ9K6aCzs0zbtOdQV6U4QBP8J2BI8EZ4zclacSaKAKHRX4h7gQhnGREh
   0xxWqNv67dE0BJBdhal4eqoTr3XHFFjvy2EQmrcyrcXNGVEsD7MiRlZr5
   KeAbAyDArw/2GsCnam/YOV4pqThWKHtd7BcVOr0oh8C7PNEKYqswUUbyd
   A==;
IronPort-SDR: GicodpmnvNdbSYQufObWJs/0uPHoR7NL5lyFo5bVpCT8MHriZ3wFNSXTMuF7A85iCEPOKCcKCY
 hH6IBvCC8BzDZX2b6F5uX/AWjowGVMmgBW8ySHNDmDqwJpCWbG0RzZXlLs32GRxDymJzWBnM7N
 gHSjHLnidMd2Wpn2ix2JRrn7GOLX4jOXkl3mHmnOLfReMvMoYOL3EJtNso0RX8K+Ma/CsEJ8E5
 PRLbDuKo7QuEWAADogXvatgHZE+3sqJPNwJMmSTxomU9BgcVYzUzzk02l9rcTsHj4ZHYoLtI2u
 R0k=
X-IronPort-AV: E=Sophos;i="5.76,353,1592863200"; 
   d="scan'208";a="12200131"
Date:   Tue, 25 Aug 2020 17:39:50 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "jbaron@akamai.com" <jbaron@akamai.com>,
        "mingo@redhat.com" <mingo@redhat.com>, kernel <kernel@axis.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "john.ogness@linutronix.de" <john.ogness@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dynamic debug: allow printing to trace event
Message-ID: <20200825153950.zza53vsl6wsehgh2@axis.com>
References: <20200814133151.7759-1-vincent.whitchurch@axis.com>
 <20200814131531.01b43c91@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200814131531.01b43c91@oasis.local.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 07:15:31PM +0200, Steven Rostedt wrote:
> On Fri, 14 Aug 2020 15:31:51 +0200
> Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> > index aa9ff9e1c0b3..f599ed21ecc5 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -27,13 +27,16 @@ struct _ddebug {
> >  	 * writes commands to <debugfs>/dynamic_debug/control
> >  	 */
> >  #define _DPRINTK_FLAGS_NONE	0
> > -#define _DPRINTK_FLAGS_PRINT	(1<<0) /* printk() a message using the format */
> > +#define _DPRINTK_FLAGS_PRINTK	(1<<0) /* printk() a message using the format */
> 
> The above looks like a cleanup unrelated to this patch, and probably
> should be on its own.

I've moved this and the other renaming hunk out to a separate patch.

> >  #define _DPRINTK_FLAGS_INCL_MODNAME	(1<<1)
> >  #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
> >  #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
> >  #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
> > +#define _DPRINTK_FLAGS_TRACE		(1<<5)	
> > +#define _DPRINTK_FLAGS_PRINT		(_DPRINTK_FLAGS_PRINTK | \
> > +					 _DPRINTK_FLAGS_TRACE)
> >  #if defined DEBUG
> > -#define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
> > +#define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINTK
> >  #else
> >  #define _DPRINTK_FLAGS_DEFAULT 0
> >  #endif
> > diff --git a/include/trace/events/printk.h b/include/trace/events/printk.h
> > index 13d405b2fd8b..6c89121a1669 100644
> > --- a/include/trace/events/printk.h
> > +++ b/include/trace/events/printk.h
> > @@ -7,7 +7,7 @@
> >  
> >  #include <linux/tracepoint.h>
> >  
> > -TRACE_EVENT(console,
> > +DECLARE_EVENT_CLASS(printk,
> >  	TP_PROTO(const char *text, size_t len),
> >  
> >  	TP_ARGS(text, len),
> > @@ -31,6 +31,16 @@ TRACE_EVENT(console,
> >  
> >  	TP_printk("%s", __get_str(msg))
> >  );
> > +
> > +DEFINE_EVENT(printk, console,
> > +	TP_PROTO(const char *text, size_t len),
> > +	TP_ARGS(text, len)
> > +);
> > +
> > +DEFINE_EVENT(printk, dynamic,
> 
> Can we call this "dynamic_printk" or "printk_dynamic", as
> trace_dynamic() is too generic.

I went for "dyndbg" (printk:dyndbg / trace_dyndbg()) which is the
documented name of the infrastructure.
