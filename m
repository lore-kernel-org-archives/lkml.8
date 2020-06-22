Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DE9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D7A20776
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592854279;
	bh=CDMl9Mj/szvYn6o9TddGFWgTqsHrkjrdv1OxwGlEWf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OzGk9osZyYipdIfRemJlEGSZPAXZWeGEeN4Yp1aR0+0wgCSnbSOgJ0Gz6PsGawZyo
	 1hMgvoHR9fkWBW4GUGwj3JqIbC6wsgh3YIHS0lQXSERRl2eyPKQfCYzwCtsGvEmHR6
	 ijxBnq6mS5CHreDrkDjGfUk0kZg9P9UvD+39ZptM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgFVTbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbgFVTbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:31:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DCBD20776;
        Mon, 22 Jun 2020 19:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592854275;
        bh=CDMl9Mj/szvYn6o9TddGFWgTqsHrkjrdv1OxwGlEWf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PWpK7pPjONrZsljBOvbu1phO/3iPw89A0Bi4v07Ua94CsfNwKqmcM3B4flQfRq8U+
         StM3bW7Gr3oDSGcOfEmf6JTOZGDbwI0eGxa9uktWrBlbHsD9pH3wnkT5iQk9m0e0Dp
         N9Zek+Qt7bP9ew/BpmXKgxQnjQWj/6W7Lqj7VPkI=
Date:   Mon, 22 Jun 2020 21:31:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>,
        Nicolai Stange <nicstange@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: debugfs_create_u32_array() memory leaks
Message-ID: <20200622193109.GA2163148@kroah.com>
References: <20200619161734.25e99fa4@kicinski-fedora-PC1C0HJN>
 <20200620074542.GA2298609@kroah.com>
 <20200622122332.274c842e@kicinski-fedora-PC1C0HJN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622122332.274c842e@kicinski-fedora-PC1C0HJN>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 12:23:32PM -0700, Jakub Kicinski wrote:
> On Sat, 20 Jun 2020 09:45:42 +0200 Greg Kroah-Hartman wrote:
> > On Fri, Jun 19, 2020 at 04:17:34PM -0700, Jakub Kicinski wrote:
> > > Hi!
> > > 
> > > I'm trying to use debugfs_create_u32_array() in drivers/net/netdevsim
> > > and it causes memory leaks:
> > > 
> > > unreferenced object 0xffff8880546642a0 (size 16):
> > >   comm "test_udp_tuns.s", pid 2146, jiffies 4294928368 (age 3772.435s)
> > >   hex dump (first 16 bytes):
> > >     84 52 6a 4d 80 88 ff ff 04 00 00 00 f3 78 7e 89  .RjM.........x~.
> > >   backtrace:
> > >     [<000000006962a447>] debugfs_create_u32_array+0x3f/0x90
> > > 
> > > I can see that debugfs_create_u32_array() allocates a structure at
> > > create time that ends up assigned to inode->i_private, but I don't 
> > > see it freed anywhere.
> > > 
> > > Am I missing something? I'm pretty sure files get removed, cause the
> > > driver calls debugfs_remove_recursive() and no other file types leaks.  
> > 
> > Yeah, that's a bug, nice catch.  The debugfs_create*() functions should
> > not allocate local memory as we can't know to free that memory when the
> > file is removed.
> > 
> > Can you fix this up, or do you want me to?  I only see one in-kernel
> > user of this, so it shouldn't be that tough to do so.  The one user
> > never removes that file so that's why no one noticed this before.
> 
> Ah, I wasn't sure how to fix but since you say that create functions
> shouldn't allocate memory seems like the fix will be to make callers
> pass an equivalent of struct debugfs_blob_wrapper for u32.

Sounds good.

> I'm happy to send a patch to that effect - I have a process question
> tho - I need this change in net-next, should I sent the patch to you?
> Can it still make it into 5.8 (debugfs -> Linus -> net -> net-next) or
> perhaps can it go via net-next since there is no de facto bug in 5.8?

I can take a fix now, and get it into 5.8 if that makes things easier
for you.

thanks,

greg k-h
