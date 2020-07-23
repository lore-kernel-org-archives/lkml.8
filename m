Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2376C433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71AAB20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="XSJZhWfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgGWLEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:04:49 -0400
Received: from smtp2.axis.com ([195.60.68.18]:27683 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbgGWLEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 07:04:48 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jul 2020 07:04:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1440; q=dns/txt; s=axis-central1;
  t=1595502288; x=1627038288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oQK1kdpUpuXo4gTgNIO2CBHLpqsKEGJmibRBMJIDPFs=;
  b=XSJZhWfTdw0By26/hWhbd/BhDqzycrxKi5uIp7co4O6TsnpCIktyOgFl
   qzMgp8XX/5oJO/OvkmIuO+v77MzBStaKxkKvmL23W6SR2gzB745lfOvA3
   3EpUqWBk/xPdrX4mRpltRXypTA7Ovu81+Ns77LURX1usgn3iatkVWaQgB
   //4No+CnNipFTHg+x7vIFmWrrVYqBvyVrX1uZZvdcdRrVdhQ/ebV7BXfO
   i6Z0NPRZBWYwWtmLXnboVrErEyed2r4O7d6aFMD2I/ngFabUqFs+Vh4AD
   xZUTvs8IooKJU+sdKcJ0vmFawz4Z3VuabC/4YAWL25zwKpb9yFAMnX+5+
   g==;
IronPort-SDR: 8w+4+M/QNSnOyVfaTn5eXV7ay9eFeN6MldZVb7DNZXNOO03+CNRr84npzdcOFzTX1iYLbxTRjZ
 v246GEz9OVu3aGBtELz9oxUPPVUoUUhkM5++FH0wHA7BR4lmLPoDQGo5gKU3qdxFk1v4nMO0tc
 XbD8SkekSMW+m8ih5GRuvfGAWmWLCS7Nvutv65sjy96JsgilBch0lti7IwTMmISFqz21YP6wfo
 xyX4eWRqTRmpTow6qdw5/ji/TtXDT+dUOE8L0+f711gWXdGFUPBebU/W53NzRst9KPIdf7hpUt
 JPY=
X-IronPort-AV: E=Sophos;i="5.75,386,1589234400"; 
   d="scan'208";a="10822194"
Date:   Thu, 23 Jul 2020 12:57:35 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     John Ogness <john.ogness@linutronix.de>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "mingo@redhat.com" <mingo@redhat.com>, kernel <kernel@axis.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dynamic debug: allow printing to trace event
Message-ID: <20200723105735.mqfkfbljjda7qz7n@axis.com>
References: <20200721141105.16034-1-vincent.whitchurch@axis.com>
 <20200721173045.540ae500@oasis.local.home>
 <87eep3zmg9.fsf@jogness.linutronix.de>
 <20200722144952.2mewrgebgkyr2zyf@axis.com>
 <20200722112823.3ba72d31@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200722112823.3ba72d31@oasis.local.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 05:28:23PM +0200, Steven Rostedt wrote:
> For you, I made this quick patch. If this works for you, I can make it
> into a formal patch. It includes a test use case in do_sys_openat2() to
> show the file name and file descriptor. Obviously, that wont be part of
> the final patch.

Thank you.  I had to replace the inline with an __attribute__((unused))
because otherwise my GCC errors out with "error: function
'find_vprintk_len' can never be inlined because it uses variable
argument lists".

Apart from that it works fine, but the several calls to vsnprintf() take
their toll and this method is twice as slow as the buffer-on-stack
implementation (and ftrace_vprintk()).  If I pass in a fixed size for
the __dynamic_array I get the same performance as the buffer-on-stack
method, but that's probably not surprising.

I know a dedicated trace event or a binary trace_printk() at the call
site of pr_debug() is always going to be more performant, but it would
be nice to avoid the extra slowdown if possible.

It's hard to guarantee that 256 bytes on the stack is safe on all
systems since these functions are called from lots of places.  

Would it be acceptable to just use a fixed size for the event?  At least
for my own debugging use cases it's preferable to just have to increase
the trace buffer size in case it's insufficient, rather than to have to
restort to one-off debugging code.
