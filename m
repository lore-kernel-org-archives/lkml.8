Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEEDC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E6E206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580379277;
	bh=7+a/JdBuU0Ik2kLLVqVSrGbsAkLWIhTEzDwbXHfTo84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N59A+Cw/HXExDpg+yuHA+mbrYQjDegSrZC9j1hzjGzzjFYF7ABFP/ZkrnKlbXkYuQ
	 Z5jQdBlTdJZxfOgioPpHilvagQLGPpgmvwq24fMX/64XeBMMXs3sK9W5RAVYuBH7/U
	 Fs4iFHAFNz5GbQsSzf5FkesZvaCPVWRHd+EU1V6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgA3KOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:14:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgA3KOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:14:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6775A206D5;
        Thu, 30 Jan 2020 10:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580379275;
        bh=7+a/JdBuU0Ik2kLLVqVSrGbsAkLWIhTEzDwbXHfTo84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+6w+VlwvJ2VhG4DX2kkJ/tzqgan60dczqPTXcJpsm0sfqaNrGK8xpX/+m8T9aIyH
         nFycxwThI1a+58K19FxSd9bO1B0/VTdppr0f5Fm/qq2trZcr7uDq9LKlydCvWXw02H
         uCqsIouyCrmn8OmsZleBXEjE5zbHBDi6JXn5EI4U=
Date:   Thu, 30 Jan 2020 11:14:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+2b149e3a2468e54d2178@syzkaller.appspotmail.com>
Cc:     arnd@arndb.de, clemens@ladisch.de, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: upstream boot error: KASAN: slab-out-of-bounds Write in
 hpet_alloc
Message-ID: <20200130101433.GB866317@kroah.com>
References: <000000000000e3e280059d589ef4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e3e280059d589ef4@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 02:07:11AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    39bed42d Merge tag 'for-linus-hmm' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1569d9a5e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2646535f8818ae25
> dashboard link: https://syzkaller.appspot.com/bug?extid=2b149e3a2468e54d2178
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2b149e3a2468e54d2178@syzkaller.appspotmail.com

Fix is already in my tree and will show up in the next linux-next.

thanks,

greg k-h
