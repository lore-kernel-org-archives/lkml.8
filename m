Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60364C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25B62206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597045617;
	bh=d7yZTMaajyYYDp1xUH/+msJ7BOrEiV5LPH4/r1jiZps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DRXv7qN56ob+tmmKln4Cb2L05Q6jGzsIbTw2AV+W4m873G6IUUUasEPs0QyLMyW7r
	 ZH3UQ+1ydxr1AYeUZOSS46fXUzQti3g18/Yb7Ul3zvQRdo5YmLLOw0zpVuNdOoCdx0
	 T+W6hhI2AJ5lLd92bPzsMjZrR4di7u0QGx+zRrt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgHJHq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgHJHqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:46:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF34D2065C;
        Mon, 10 Aug 2020 07:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597045615;
        bh=d7yZTMaajyYYDp1xUH/+msJ7BOrEiV5LPH4/r1jiZps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xUMoQJ0Rj1qEx67OX2Ceqywy2Yyj+2T8X3o+e9FmDy8FR2gT+SJGFsA/UQvR136dN
         CXt3WUVGCc0S2UXFpVGgzG9+umduUDstNjQc4eBhgYIN6uAYIMVf+Jd+R/xGfiV9Y4
         JmfripfRyZPVjP09oPKx/jtALkGprinOP82Pn2Bs=
Date:   Mon, 10 Aug 2020 09:47:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+a7e220df5a81d1ab400e@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, balbi@kernel.org, dan.carpenter@oracle.com,
        glider@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KMSAN: kernel-infoleak in raw_ioctl
Message-ID: <20200810074706.GD1529187@kroah.com>
References: <000000000000ce85c405ac744ff6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ce85c405ac744ff6@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 09, 2020 at 09:27:18AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ce8056d1 wip: changed copy_from_user where instrumented
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=141eb8b2900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3afe005fb99591f
> dashboard link: https://syzkaller.appspot.com/bug?extid=a7e220df5a81d1ab400e
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.

The irony of a kernel module written for syzbot testing, causing syzbot
reports....

