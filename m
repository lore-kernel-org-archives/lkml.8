Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF3DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89512076E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592853817;
	bh=fLrKl7xv+RCqsK4LIxDXGEdyn0DEHAKPi26mm96AHYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZxdJajuuK4cvojImd9+BRYd3tzWfF/NsxMbjd/6gRD8mMV9mbzArDIVKcT307BVxS
	 HdR3uZ9SFVB+YNDS7E5QEocGfeQjA4m8VrsvL7JvKd10q5npW2KyMAq/KtjB1u/436
	 7rTUjBAcLmtij3XGw4hXripJlQ/AWTZLmR2PrUs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgFVTXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgFVTXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:23:35 -0400
Received: from kicinski-fedora-PC1C0HJN (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B74A2073E;
        Mon, 22 Jun 2020 19:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592853814;
        bh=fLrKl7xv+RCqsK4LIxDXGEdyn0DEHAKPi26mm96AHYw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g2DlrdCK+RrslFeJbYbStlAeXwZYv4FiPOyFEvTEr/WHMJhjWfE3sX4cm8JxBRRva
         dlBJxQ2ULvTgw1KJYALIbNsP9iHbUu2IHcEoRjbqpXnBLf2OZ0KhYzVr41rEpVZV9h
         RhZfdPXGdrcWXwHu6kV2y59c4fRHEEs0lBIsHSDY=
Date:   Mon, 22 Jun 2020 12:23:32 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ronald =?UTF-8?B?VHNjaGFsw6Ry?= <ronald@innovation.ch>,
        Nicolai Stange <nicstange@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: debugfs_create_u32_array() memory leaks
Message-ID: <20200622122332.274c842e@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20200620074542.GA2298609@kroah.com>
References: <20200619161734.25e99fa4@kicinski-fedora-PC1C0HJN>
        <20200620074542.GA2298609@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jun 2020 09:45:42 +0200 Greg Kroah-Hartman wrote:
> On Fri, Jun 19, 2020 at 04:17:34PM -0700, Jakub Kicinski wrote:
> > Hi!
> > 
> > I'm trying to use debugfs_create_u32_array() in drivers/net/netdevsim
> > and it causes memory leaks:
> > 
> > unreferenced object 0xffff8880546642a0 (size 16):
> >   comm "test_udp_tuns.s", pid 2146, jiffies 4294928368 (age 3772.435s)
> >   hex dump (first 16 bytes):
> >     84 52 6a 4d 80 88 ff ff 04 00 00 00 f3 78 7e 89  .RjM.........x~.
> >   backtrace:
> >     [<000000006962a447>] debugfs_create_u32_array+0x3f/0x90
> > 
> > I can see that debugfs_create_u32_array() allocates a structure at
> > create time that ends up assigned to inode->i_private, but I don't 
> > see it freed anywhere.
> > 
> > Am I missing something? I'm pretty sure files get removed, cause the
> > driver calls debugfs_remove_recursive() and no other file types leaks.  
> 
> Yeah, that's a bug, nice catch.  The debugfs_create*() functions should
> not allocate local memory as we can't know to free that memory when the
> file is removed.
> 
> Can you fix this up, or do you want me to?  I only see one in-kernel
> user of this, so it shouldn't be that tough to do so.  The one user
> never removes that file so that's why no one noticed this before.

Ah, I wasn't sure how to fix but since you say that create functions
shouldn't allocate memory seems like the fix will be to make callers
pass an equivalent of struct debugfs_blob_wrapper for u32.

I'm happy to send a patch to that effect - I have a process question
tho - I need this change in net-next, should I sent the patch to you?
Can it still make it into 5.8 (debugfs -> Linus -> net -> net-next) or
perhaps can it go via net-next since there is no de facto bug in 5.8?
