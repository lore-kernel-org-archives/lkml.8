Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7607FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 446F42071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgFOVjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:39:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55473 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFOVjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:39:00 -0400
Received: from ip-109-41-2-3.web.vodafone.de ([109.41.2.3] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jkwoY-00087y-2Y; Mon, 15 Jun 2020 21:38:46 +0000
Date:   Mon, 15 Jun 2020 23:38:43 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     Cyril Hrubis <chrubis@suse.cz>,
        kernel test robot <rong.a.chen@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>, ltp@lists.linux.it,
        Serge Hallyn <serge@hallyn.com>
Subject: Re: [LTP] 303cc571d1: ltp.setns01.fail
Message-ID: <20200615213843.2ojgm3ob7kp3qq6a@wittgenstein>
References: <20200615085836.GR12456@shao2-debian>
 <20200615091850.GA3373@yuki.lan>
 <1101600340.15989438.1592229781375.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1101600340.15989438.1592229781375.JavaMail.zimbra@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 10:03:01AM -0400, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
> > Hi!
> > > setns01     6  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > > errno=EBADF(9): Bad file descriptor
> > > setns01     0  TINFO  :  setns(12, 0x20000)
> > > setns01     7  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > > errno=EBADF(9): Bad file descriptor
> > > setns01     0  TINFO  :  setns(12, 0x40000000)
> > > setns01     8  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > > errno=EBADF(9): Bad file descriptor
> > > setns01     0  TINFO  :  setns(12, 0x20000000)
> > > setns01     9  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > > errno=EBADF(9): Bad file descriptor
> > > setns01     0  TINFO  :  setns(12, 0x4000000)
> > > setns01    10  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
> > > errno=EBADF(9): Bad file descriptor
> > 
> > The messages here are a bit cryptic, I will fix that later on, but what
> > it means here is that the errno has changed from EINVAL to EBADF in a
> > case we pass file descriptor to a regular file to setns().
> 
> I posted a series that accepts both errnos about week ago:
>   https://lists.linux.it/pipermail/ltp/2020-June/017467.html

When you used to pass an fd that referred to an open file but the file
was not a nsfd the kernel would report EINVAL. Since the pidfd support
this now reports EBADF. While that is a user visible change it is not a
particular worrying one but something we should still fix. Here's the
patch that fixes this:

diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index b03df67621d0..cd356630a311 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -531,7 +531,7 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
        } else if (!IS_ERR(pidfd_pid(file))) {
                err = check_setns_flags(flags);
        } else {
-               err = -EBADF;
+               err = -EINVAL;
        }
        if (err)
                goto out;

I'll send a pr for this to Linus this week (or next since I'm on
vacation this week) and get this fixed. Thanks for spotting this. What's
the Reported-by: line format that LTP uses?

Christian
