Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5D3C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B142137B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="HeY9gr8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgIBMR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 08:17:26 -0400
Received: from smtp1.axis.com ([195.60.68.17]:61410 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBMRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 08:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1710; q=dns/txt; s=axis-central1;
  t=1599049041; x=1630585041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/y6Use5/oT/VRDvJxU4PwCfmGC6ZvPkLgQE9J9EIwGE=;
  b=HeY9gr8Rropn0Q+HXF2uNgva/xIdWIXvx/CKhbnGrZ1IS48QDstzxQp/
   ho9yG3/UkOmlxYt/8Lr8aQ0wqBPmNjONpCLUAfpp7bVepj0sXjN/h+S8N
   kk9HngZ5i7YeLDNRRXJx+qQLhMOKKMa5DCgJwRmfrtOdH2CV2JE1IzxQx
   2JljWXfNREEyrhFW9p7yY89LF5QTcngAD51Qx8i6XPnFCoIJnA+AalNkL
   Y6VaGVOqjo5J/6Ea/GjCuzthwzeNxtuHzApX9x0ahu3W7vpi4toGyPoRh
   gEMF0jUSMXSoR3lAxnoHpvWG/galSusYT+m/ojAqz7KXWi190Qn0mq7iG
   Q==;
IronPort-SDR: 7tGnxBlU7jHCgbF40LrJI+4NjhysGgIf4Ph2563VWwnWsxbLqm1Xc3HSljX1Tztp/0RHIn3++C
 EXDH9zmv1a6fEAkTqmUi6OPkjDSlLR7w0nFjnQo1p+1L5Xt0EK10+XLLstVJoIgLBwRPQteHzX
 4TZo39it1vhE3hE/km7VywXsA3hXXorAZ3lx02WPyCgJUNP/P7lOgd+naATTdcP4zDfTGm448X
 8S00fZz7sHJ/JlCyYki9Jg168zKGcRk1Fj5L18YsLftUESZSo5V5U73kgp8x8eR1AOSGdbsLr1
 b8g=
X-IronPort-AV: E=Sophos;i="5.76,383,1592863200"; 
   d="scan'208";a="12474975"
Date:   Wed, 2 Sep 2020 14:17:19 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Joe Perches <joe@perches.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        kernel <kernel@axis.com>, "corbet@lwn.net" <corbet@lwn.net>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "john.ogness@linutronix.de" <john.ogness@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dynamic debug: allow printing to trace event
Message-ID: <20200902121719.ppj7nyzk2qic5dnq@axis.com>
References: <20200825153338.17061-1-vincent.whitchurch@axis.com>
 <20200825153338.17061-3-vincent.whitchurch@axis.com>
 <651f7ec449dfb28006bbc0b018d4f6e506bcda80.camel@perches.com>
 <20200826153203.1a65c35d@oasis.local.home>
 <9bfb4c4bd1415a8ce527a913730672508a8e8330.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9bfb4c4bd1415a8ce527a913730672508a8e8330.camel@perches.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 09:53:57PM +0200, Joe Perches wrote:
> On Wed, 2020-08-26 at 15:32 -0400, Steven Rostedt wrote:
> > On Tue, 25 Aug 2020 08:53:25 -0700
> > Joe Perches <joe@perches.com> wrote:
> > 
> > > > The print buffer is statically allocated and managed using code borrowed
> > > > from __ftrace_trace_stack() and is limited to 256 bytes (four of these
> > > > are allocated per CPU to handle the various contexts); anything larger
> > > > will be truncated.  
> > > 
> > > There is an effort to avoid using trace_printk and the like
> > > so perhaps this feature should have the same compile time
> > > guard.
> > 
> > No, this is fine for being in a production kernel. Basically, these are
> > simply debug printk()s that can also be put into the trace buffer. The
> > key difference to trace_printk() is that they are an event that needs
> > to be enabled to write into the buffer.
> 
> It just seems like a backdoor way to convert various pr_debug functions
> (dev_dbg/netdev_dbg, et al) into tracing.
> 
> What's the real value?  Timing data?  Something else?

I mentioned my use case for this in the commit message and why it works
much better than printk() for that, please let me know if it is unclear:

 When debugging device drivers, I've found it very useful to be able to
 redirect existing pr_debug()/dev_dbg() prints to the trace buffer
 instead of dmesg.  Among the many advantages of the trace buffer is that
 it can be dynamically resized, allows these prints to combined with
 other trace events, and doesn't fill up system logs.

This is my only use case for this, and I've used it very very often
during the years I've been carrying this patch locally.
