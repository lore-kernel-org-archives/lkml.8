Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0D0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA0D6207DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgHZTyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:54:01 -0400
Received: from smtprelay0156.hostedemail.com ([216.40.44.156]:53306 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726798AbgHZTyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:54:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 40A721801BD68;
        Wed, 26 Aug 2020 19:54:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: elbow93_170ed9027067
X-Filterd-Recvd-Size: 2163
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 26 Aug 2020 19:53:58 +0000 (UTC)
Message-ID: <9bfb4c4bd1415a8ce527a913730672508a8e8330.camel@perches.com>
Subject: Re: [PATCH v3 2/2] dynamic debug: allow printing to trace event
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        jbaron@akamai.com, mingo@redhat.com,
        Nicolas Boichat <drinkcat@chromium.org>, kernel@axis.com,
        corbet@lwn.net, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org
Date:   Wed, 26 Aug 2020 12:53:57 -0700
In-Reply-To: <20200826153203.1a65c35d@oasis.local.home>
References: <20200825153338.17061-1-vincent.whitchurch@axis.com>
         <20200825153338.17061-3-vincent.whitchurch@axis.com>
         <651f7ec449dfb28006bbc0b018d4f6e506bcda80.camel@perches.com>
         <20200826153203.1a65c35d@oasis.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-26 at 15:32 -0400, Steven Rostedt wrote:
> On Tue, 25 Aug 2020 08:53:25 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > > The print buffer is statically allocated and managed using code borrowed
> > > from __ftrace_trace_stack() and is limited to 256 bytes (four of these
> > > are allocated per CPU to handle the various contexts); anything larger
> > > will be truncated.  
> > 
> > There is an effort to avoid using trace_printk and the like
> > so perhaps this feature should have the same compile time
> > guard.
> 
> No, this is fine for being in a production kernel. Basically, these are
> simply debug printk()s that can also be put into the trace buffer. The
> key difference to trace_printk() is that they are an event that needs
> to be enabled to write into the buffer.

It just seems like a backdoor way to convert various pr_debug functions
(dev_dbg/netdev_dbg, et al) into tracing.

What's the real value?  Timing data?  Something else?


