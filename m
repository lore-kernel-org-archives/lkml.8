Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62A5C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707782469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582900482;
	bh=st/JhqZfXx68Vtalr2fPLfiiO80txyvp8AZS55d7ra8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t3J26xdfZgnwgjdGZHe8m8ihv3Z2RHtUnmAHREM1WofcgEVm/Bj+wE4l4aUMtINy7
	 YF+v8T+N4cJr6aqO0+uHDqn1EZ1SRN4EbTLVxGQJOBb0/Lp8C04MkhkjlkcffNYruf
	 giY7lZgZv3YdKFdjTqsOrtymlyJ0zhAIZGYixs5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgB1Oel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:34:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgB1Oek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:34:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82A4C2469F;
        Fri, 28 Feb 2020 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582900479;
        bh=st/JhqZfXx68Vtalr2fPLfiiO80txyvp8AZS55d7ra8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WBjTaXnmvEDuLbVlaTcLL3BwcSe6IWSolt0I2TUz9UGMkWYdclamgFpN3srsJsTmv
         FCb2dRSn4aoLmvPg3vkmU1A4OwBPX5W8jpvX7vyBdE8GsSWsz4E/IkUMm8d4j+avcK
         i/sdgsv1l2J+7DFTm97F2IP4VO5OzLbY8aYfGbCI=
Date:   Fri, 28 Feb 2020 15:34:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.com>
Cc:     syzbot <syzbot+26183d9746e62da329b8@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in tty_unthrottle
Message-ID: <20200228143436.GB3054483@kroah.com>
References: <000000000000be57bf059f8aa7b9@google.com>
 <6590a26d-8234-67a8-16e0-6391da6765d9@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6590a26d-8234-67a8-16e0-6391da6765d9@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 02:34:48PM +0100, Jiri Slaby wrote:
> On 27. 02. 20, 9:39, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    f8788d86 Linux 5.6-rc3 git tree:       upstream 
> > console output:
> > https://syzkaller.appspot.com/x/log.txt?x=1102d22de00000 kernel
> > config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f 
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=26183d9746e62da329b8 
> > compiler:       clang version 10.0.0
> > (https://github.com/llvm/llvm-project/
> > c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > 
> > Unfortunately, I don't have any reproducer for this crash yet.
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the
> > commit: Reported-by:
> > syzbot+26183d9746e62da329b8@syzkaller.appspotmail.com
> 
> So trying below, but there is no reproducer for the issue, so I am not
> sure if it triggers any action at all.
> 
> #syz test:
> git://git.kernel.org/pub/scm/linux/kernel/git/jirislaby/linux.git vc_sel

Ah, yeah, no reproducer :(

Ok, I'll queue these up and see what happens, thanks!

greg k-h
