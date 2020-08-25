Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7D8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D19D020782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="Ki/XfYV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHYPcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:32:33 -0400
Received: from smtp2.axis.com ([195.60.68.18]:42669 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbgHYPca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2284; q=dns/txt; s=axis-central1;
  t=1598369549; x=1629905549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FEYwXhWljaFx0OCs78pPD+h9euvq1wZYQ/pI8U2vu4Y=;
  b=Ki/XfYV13p2EqOHmbJHfunp/zSD1LKvEt+E99u+KX8hD75Cd+N9CiXUO
   5VBqkWD/wxB0v+MqIhqTAEp1b8s4jPiitV62j11FPRa337zaYG1wb/b8w
   9Salul4r02bMhEGeMEU1eLkrBBQ0lzX5Ads2ep5ZiSererX9wH3JoQ4ux
   1fpbrsF+pCqeC0cgXxfRCa1/X0MSiSLbPsIcXq2AgKgGWMhySbJNRASVq
   KrGobHYWCIjQRjEbeXzfi0GksY2dfJMRlx1zXxcv1yCn6vpKH45WCdsZs
   KTLAlnYg0XO/L/ZM6tnR5XVIDllU6T+NvukDRq8Khdks+iAFjqSTnWey/
   w==;
IronPort-SDR: O9KKHBLHejNa4FglqdFKgx6ChmeIyjuhpF8ry34KKfai+H0HoHNf2tMj5izCWsN+2VO2LG9k7Z
 mAr1QnwXZS7JJ1WhPhQSKJtiPc0C4K3O2ehZNt7S0m/6A5LOBT/JB/kfGjY4OiYo0bUHmmkkN/
 kA7CzpOti8EnoOd9IwUEronwoSFjYvH7QIrP6/JTZyoZJEMCQergDudQSeS9UvU+Ps/yOHgIyJ
 GAVy31z9ul6ez4MS/oz06Cw919SluLZ810peXtJ2eHC841Dfuy7KT3ZcfvxHzcvmk/MT7KjSB9
 mlE=
X-IronPort-AV: E=Sophos;i="5.76,353,1592863200"; 
   d="scan'208";a="11853079"
Date:   Tue, 25 Aug 2020 17:32:26 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jason Baron <jbaron@akamai.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>, kernel <kernel@axis.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "john.ogness@linutronix.de" <john.ogness@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dynamic debug: allow printing to trace event
Message-ID: <20200825153226.2wturxg7zu3bw5li@axis.com>
References: <20200814133151.7759-1-vincent.whitchurch@axis.com>
 <20200814131531.01b43c91@oasis.local.home>
 <461439ab-0720-e3cc-f49f-f294fbba4129@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <461439ab-0720-e3cc-f49f-f294fbba4129@akamai.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 11:30:34PM +0200, Jason Baron wrote:
> On 8/14/20 1:15 PM, Steven Rostedt wrote:
> > On Fri, 14 Aug 2020 15:31:51 +0200
> > Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> >> index aa9ff9e1c0b3..f599ed21ecc5 100644
> >> --- a/include/linux/dynamic_debug.h
> >> +++ b/include/linux/dynamic_debug.h
> >> @@ -27,13 +27,16 @@ struct _ddebug {
> >>  	 * writes commands to <debugfs>/dynamic_debug/control
> >>  	 */
> >>  #define _DPRINTK_FLAGS_NONE	0
> >> -#define _DPRINTK_FLAGS_PRINT	(1<<0) /* printk() a message using the format */
> >> +#define _DPRINTK_FLAGS_PRINTK	(1<<0) /* printk() a message using the format */
> > 
> > The above looks like a cleanup unrelated to this patch, and probably
> > should be on its own.
> 
> I read it as we used to have this one thing called 'print', which really meant
> printk, but now that we also have the ability to output to the trace buffer,
> what does 'print' mean now? So I read it as being part of this change.

Yes, that's what was intended, but I think it makes sense to split it
out as Steven suggested so I've done that now (and also renamed the
combined flag to the less ambiguous _DPRINTK_FLAGS_ENABLE).

>
> > 
> >>  #define _DPRINTK_FLAGS_INCL_MODNAME	(1<<1)
> >>  #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
> >>  #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
> >>  #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
> >> +#define _DPRINTK_FLAGS_TRACE		(1<<5)	
> >> +#define _DPRINTK_FLAGS_PRINT		(_DPRINTK_FLAGS_PRINTK | \
> >> +					 _DPRINTK_FLAGS_TRACE)
> 
> 
> Is _DPRINTK_FLAGS_PRINT actually used anywhere? Looks to me like
> it can be removed.

It's used from DYNAMIC_DEBUG_BRANCH() as well as from
lib/dynamic_debug.c to check if the location is enabled.

> This is a feature I've wanted for dynamic debug for a while. Thanks for
> implementing it!
> 
> Dynamic can be enabled on the command line in order to print things early
> in boot (I think ftrace can as well), I want to make sure that there are
> no ordering issues here? And things wouldn't blow up if we enable printing
> to the ftrace buffer early on via dyanmic debug?

I tried enabling all dynamic debug locations and tracing via the command
line and that worked fine:

 dyndbg="file * +x" trace_event=printk:*

