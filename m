Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EDCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 04:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E430E207D5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 04:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591330833;
	bh=mUYneMrzaiNn9rTCGEljoNFn994CQhp26djJwVh/jvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z+NEtT3KB2zeCz1vcgFh4jWEBfV4C+HNH3Yl9jGtHldDP54jXP1Zx5ZCSovl0aapW
	 ldnNHsBcDmUyfcL7bkJsZMF32z0IFJnDzEbQZ2tU/yueHM9A2s7l+K84cHIcGA/RGh
	 mcmLecYgaTS1brsAcpUB5LgUvMz6+uQ84oBMjMQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgFEEUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 00:20:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgFEEUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 00:20:31 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8A50206E6;
        Fri,  5 Jun 2020 04:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591330831;
        bh=mUYneMrzaiNn9rTCGEljoNFn994CQhp26djJwVh/jvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RP15mK3U/ux79hejNbii2Kkoc/Ho2za+adJCpaDB9KaeW1RhjneupZUO2K2ozftix
         vWbawHKQpD8H/5wjNPlb+1MRCrUQYl/M1z4Or8Xte02W7JU+8Ba+pyvuvnqUH7CezG
         dNcN8MleatmwCVj8vm0Z5dZO6tNU/j9TkRqZ0wyw=
Date:   Thu, 4 Jun 2020 21:20:29 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     syzbot <syzbot+e3c234427cd464510547@syzkaller.appspotmail.com>,
        brendanhiggins@google.com, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, rafael.j.wysocki@intel.com,
        sakari.ailus@linux.intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in media_devnode_release
Message-ID: <20200605042029.GL2667@sol.localdomain>
References: <0000000000004ae30305a653bc86@google.com>
 <08f732a9-986f-6dcf-87dd-075a9b4605d7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08f732a9-986f-6dcf-87dd-075a9b4605d7@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 10:38:50AM -0700, Randy Dunlap wrote:
> On 5/23/20 10:04 AM, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    c11d28ab Add linux-next specific files for 20200522
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17330172100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3f6dbdea4159fb66
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e3c234427cd464510547
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122eacba100000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fffa9a100000
> > 
> > The bug was bisected to:
> > 
> > commit 4ef12f7198023c09ad6d25b652bd8748c965c7fa
> > Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Date:   Wed May 13 15:18:40 2020 +0000
> > 
> >     kobject: Make sure the parent does not get released before its children
> 
> Hi,
> 
> Greg just sent a revert for this patch:
> https://lore.kernel.org/lkml/20200523152922.GA224858@kroah.com/
> 
> so all 3 of these reports should be cleared up soon.

Commit was reverted, so invalidating this bug report:

#syz invalid
