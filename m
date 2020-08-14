Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAE0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F105920791
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="ogPWcSqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgHNNeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 09:34:18 -0400
Received: from smtp1.axis.com ([195.60.68.17]:55327 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgHNNeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 09:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1058; q=dns/txt; s=axis-central1;
  t=1597412056; x=1628948056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YVahuulwrH51eJacyIUw/4WvPqZAzfYdmsvREBEkBDM=;
  b=ogPWcSqSfgyYQ3d1Y/dxR+9cA1WwtOQx8jh69+8IzZxo4l29YFYc1bOl
   OwNos06/PxATjTLlRIzRdmKxPULwc/USNzJ5tmUfrxZE9kzsKp/aoG/PJ
   KI1ZfO9nZszZSI+BLHew9B0BSw0CyUHRiVivgpX7rnwKhHR0te9dKqL+A
   dTntfkqJZaCLNO0VzgOAK6EhpAeAgmcaHK4oBlV6VNmJKz6+ksuROCGVY
   l06VmcRlEbNLeaFIf8B46ZEthhB/BK+AUuy+XnlUO1Os0EusWhE6QtUkr
   QBx7ygcDdLeiLPnsVYwcdw7+FkDAdFOD+kNJzv/ZRgWEQyzGGSoDjvKqC
   A==;
IronPort-SDR: 0g5mw+43X0CZ0OKp+cCyiQOJdM6VOCqRs0sO/O6HaHf6thzvuzR2/vs90+DioZY8+BTPD4cKvY
 BjqVCIm1H0bau75MJGBqqi+JuxsDBAhbU2d2rwU7UvV2b84spO3lPt+WP8Jf4dVGzB+RJkFPFq
 OrxIS8TyUrPG1k4ZXwMRh16M+lh6tDKSplJ2rM61a//zO0iF7gm+WOLuH5bwjSds6m+qX0sAPT
 a4UVdd3EeTZ2eFZmMS5rPoqgG8ADupZQTVoIX0SpGot4knK6t9PG1gdN2WY29axeD9HV/NjNf0
 NHg=
X-IronPort-AV: E=Sophos;i="5.76,312,1592863200"; 
   d="scan'208";a="11808915"
Date:   Fri, 14 Aug 2020 15:34:15 +0200
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
Message-ID: <20200814133415.nbkehai2vp765an5@axis.com>
References: <20200721141105.16034-1-vincent.whitchurch@axis.com>
 <20200721173045.540ae500@oasis.local.home>
 <87eep3zmg9.fsf@jogness.linutronix.de>
 <20200722144952.2mewrgebgkyr2zyf@axis.com>
 <20200722112823.3ba72d31@oasis.local.home>
 <20200723105735.mqfkfbljjda7qz7n@axis.com>
 <20200723112644.7759f82f@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200723112644.7759f82f@oasis.local.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 05:26:44PM +0200, Steven Rostedt wrote:
> On Thu, 23 Jul 2020 12:57:35 +0200
> Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> 
> > Would it be acceptable to just use a fixed size for the event?  At least
> > for my own debugging use cases it's preferable to just have to increase
> > the trace buffer size in case it's insufficient, rather than to have to
> > restort to one-off debugging code.
> 
> There's two other options.
> 
> Option 1, is to allocate 256 bytes times 4 (in case of interruption,
> where you have a separate buffer for every context - normal, softirq,
> irq, nmi), and use it like I do for stack traces in the latest kernel
> (see __ftrace_stack_trace() in kernel/trace/trace.c)
> 
> Option 2, would be to use trace_array_vprintk(), but you need to create
> your own instance to do so to keep from messing with the top level buffer.

Thanks for the suggestions, I've sent out a v2 implementing option 1:

https://lore.kernel.org/lkml/20200814133151.7759-1-vincent.whitchurch@axis.com/
