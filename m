Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66148C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B6F2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgEETnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 15:43:01 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40960 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgEETnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:43:01 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3Sz-0000zc-E9; Tue, 05 May 2020 13:42:57 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jW3Sy-0003WK-3A; Tue, 05 May 2020 13:42:56 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 05 May 2020 14:39:32 -0500
Message-ID: <87h7wujhmz.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jW3Sy-0003WK-3A;;;mid=<87h7wujhmz.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19L4HMNcSPaWzPpAyNF2T7kOhipYhZQrjA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: exec: Promised cleanups after introducing exec_update_mutex
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In the patchset that introduced exec_update_mutex there were a few last
minute discoveries and fixes that left the code in a state that can
be very easily be improved.

During the merge window we discussed the first three of these patches
and I promised I would resend them.

What the first patch does is it makes the the calls in the binfmts:
	flush_old_exec();
        /* set the personality */
        setup_new_exec();
        install_exec_creds();

With no sleeps or anything in between.

At the conclusion of this set of changes the the calls in the binfmts
are:
	begin_new_exec();
        /* set the personality */
        setup_new_exec();

The intent is to make the code easier to follow and easier to change.

Eric W. Biederman (7):
      binfmt: Move install_exec_creds after setup_new_exec to match binfmt_elf
      exec: Make unlocking exec_update_mutex explict
      exec: Rename the flag called_exec_mmap point_of_no_return
      exec: Merge install_exec_creds into setup_new_exec
      exec: In setup_new_exec cache current in the local variable me
      exec: Move most of setup_new_exec into flush_old_exec
      exec: Rename flush_old_exec begin_new_exec

 Documentation/trace/ftrace.rst |   2 +-
 arch/x86/ia32/ia32_aout.c      |   4 +-
 fs/binfmt_aout.c               |   3 +-
 fs/binfmt_elf.c                |   3 +-
 fs/binfmt_elf_fdpic.c          |   3 +-
 fs/binfmt_flat.c               |   4 +-
 fs/exec.c                      | 162 ++++++++++++++++++++---------------------
 include/linux/binfmts.h        |  10 +--
 kernel/events/core.c           |   2 +-
 9 files changed, 92 insertions(+), 101 deletions(-)

---

These changes are against v5.7-rc3.

My intention once everything passes code reveiw is to place these
changes in a topic branch in my tree and then into linux-next, and
eventually to send Linus a pull when the next merge window opens.
Unless someone has a better idea.

I am a little concerned that I might conflict with the ongoing coredump
cleanups.

I have several follow up sets of changes with additional cleanups as
well but I am trying to keep everything small enough that the code can
be reviewed.

After enough cleanups I hope to reopen the conversation of dealing with
the livelock situation with cred_guard_mutex.  As I think figuring out
what to do becomes much easier once several of my planned
cleanups/improvements have been made.

But ultimately I just want to get exec to the point where when
we have disucssions on how to make exec better the code is in good
enough shape we can actually address the issues we see.

Eric
