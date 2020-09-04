Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94A3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8254E206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599215714;
	bh=05Te+HixxeurS28FKnwyyjLfLGDIxAgo5O/92sKHlQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cQ+WXvkFDMawfBFyYbR1Uz4pR7L4o6v6NQraOg5x9CiHgbdlVCBCVgApRS2WXivEP
	 UwYSq8eXHhFisyk80zytudmZ9Wat4JCYLThWCS5CXepqLjXRoL5761tDrbpco+jjwv
	 bnrBwoAsFOy2gkJblQPW66SUvPQxB+oTCz4HvgUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgIDKey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:34:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730163AbgIDKeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:34:25 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E78EF206D4;
        Fri,  4 Sep 2020 10:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599215664;
        bh=05Te+HixxeurS28FKnwyyjLfLGDIxAgo5O/92sKHlQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ad8NhWq0ABlpwNpH803HRuu6wC1seJUXOZbZ9cO1UFFG0Zd8wv5rrGShoKB3LSlAp
         u+DoCbFdK/C6EUUr45wPjQ643ODJZQX5MJDaWBI1NssrGL2kWYi6Pxr7lw26h7SOXy
         Y0KvP/q2GzGfmIVE0V2gcG3xZmuTW2VoKhSdoPjs=
Date:   Fri, 4 Sep 2020 12:34:45 +0200
From:   'Greg KH' <gregkh@linuxfoundation.org>
To:     =?utf-8?B?77+977+9w6Lvv73vv70=?= <changki.kim@samsung.com>
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        masahiroy@kernel.org, rd.dunlap@gmail.com, krzk@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: printk: Add process name information to printk() output.
Message-ID: <20200904103445.GA2693206@kroah.com>
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com>
 <20200904082438.20707-1-changki.kim@samsung.com>
 <20200904090535.GA2440145@kroah.com>
 <000001d6829e$2226cc60$66746520$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000001d6829e$2226cc60$66746520$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 06:31:13PM +0900, ��â�� wrote:
> > On Fri, Sep 04, 2020 at 05:24:38PM +0900, Changki Kim wrote:
> > > Printk() meesages are the most basic and useful debug method.
> > > However, additional information needs in multi-processor.
> > > If we add messages with processor id and process name, we can find a
> > > problem only with messages when the problem occurs with H/W IP or CPU.
> > > This is very useful in narrowing down the scope of the problems.
> > >
> > > Therefore, instead of trying to help buffering, let's try to help
> > > reconstructing messages by saving caller information as of calling
> > > log_store() and adding it as "[$processor_id: $process_name:
> > $thread_id]"
> > > upon printing to consoles.
> > >
> > > Some examples for console output:
> > >
> > >   [    0.059580] [0:      swapper/0:    1] CPU: All CPU(s) started at
> EL1i
> > >   [    2.153157] [5:           init:    1] migov: complete to probe
> migov
> > >   [    7.441317] [4:           init:    1] NET: Registered protocol
> family 39
> > >   [   22.793389] [5:  kworker/u16:1:  184] SMP: stopping secondary CPUs
> > >
> > > Signed-off-by: Changki Kim <changki.kim@samsung.com>
> > > ---
> > >  kernel/printk/printk.c            | 20 ++++++++++++++++++--
> > >  kernel/printk/printk_ringbuffer.h |  7 +++++++
> > >  lib/Kconfig.debug                 | 16 ++++++++++++++++
> > >  3 files changed, 41 insertions(+), 2 deletions(-)
> > 
> > Isn't the CPU number already present if you want it today?  Why add it
> > again?
> > 
> > thanks,
> > 
> > greg k-h
> 
> CPU number isn't present now. If I enabled PRINTK_CALLER,
> then it is present cpu id or thread id.

Great, that should give you what you need here, right?

> The config isn't always present cpu id.

What do you mean?

> We need cpu id each each message.

Why each message?  What does that provide you?

And if PRINTK_CALLER does not work properly, please fix it.  I don't see
how it would not work any different from your patch, you shouldn't
duplicate things.

thanks,

greg k-h
