Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B445AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2B320730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="curn2VB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgDGUsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:48:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39991 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726386AbgDGUsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586292484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SNNnS6jMNs/mcFt0zu+7szoqfaJA8/rEUBbigfZagbs=;
        b=curn2VB0kp+PD0QMXwiZoXLQnK9gATolmErkWB3fzpsM6AeP0sG6/gC9YxZPZnfi/fIN2S
        UC71dtWCMjWUI3koWj2ETgdHM/gKUUWeQzc/pO2nhdh4pUDlX0DCAHKWSv9t7mbLv1fVEp
        3WYcsDCT+erVwN5QuHs7A5z7mRCPlcA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-3nJAQkqGNUWOvlJZcH4fEg-1; Tue, 07 Apr 2020 16:48:00 -0400
X-MC-Unique: 3nJAQkqGNUWOvlJZcH4fEg-1
Received: by mail-wr1-f69.google.com with SMTP id v14so2749049wrq.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 13:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SNNnS6jMNs/mcFt0zu+7szoqfaJA8/rEUBbigfZagbs=;
        b=apVNojCxSxHCXXIkZG8XrLq0hNBWG1riBZm4cDuK1aIC+5w26iMBwlO3PGrdvPvivk
         jYl7FtDSnX4vg222bD/Lz11VfYdzCVl7NzBaZlyT6BvBLHeblOEow1KeEP6Du3snvxon
         WXmYPF+n035ntICYqqojIF+ZR0/ICw/ejQDhp2Tm0jtawlSH8QaG0Bgfj57YBRYItg8b
         qL21LqQuhnvETFCeKGfnx84oK5DYLKiPSXXnXsdOESUhxcEovT1HYeipUkaUrtREC3sj
         RASfrg+0kXm+W8yycHbv9gP9vMOG6YMjuvgibH8LsxtMyv87EG3HPaOvZRse5ptvm8w9
         YmoQ==
X-Gm-Message-State: AGi0PuZCIe3sIr8tpFcr4LM2BYAnWZPedh/XptgdPeRVWUnGvqESV28G
        t1G0HqPn3u/PPTIixcxW5jkXuJMrkRyThsHTEV3bpWkI2lDZMOkn0yNHw3Y89JiV2co1wf0WP+q
        w6zKWP06Jr1ZbvuDmvMra8JfT
X-Received: by 2002:adf:ff85:: with SMTP id j5mr4399368wrr.332.1586292478473;
        Tue, 07 Apr 2020 13:47:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypLn3OvfUzYyhWD+1bLiZR8CGLlW8+JmrgXrPqP6ByTbcA+eAxOaiqPdrRt4b8c5q5+FioxHEQ==
X-Received: by 2002:adf:ff85:: with SMTP id j5mr4399354wrr.332.1586292478219;
        Tue, 07 Apr 2020 13:47:58 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::3])
        by smtp.gmail.com with ESMTPSA id l15sm502142wmi.48.2020.04.07.13.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 13:47:57 -0700 (PDT)
Date:   Tue, 7 Apr 2020 16:47:54 -0400
From:   Peter Xu <peterx@redhat.com>
To:     syzbot <syzbot+a8c70b7f3579fc0587dc@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, bgeffon@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Subject: Re: WARNING: bad unlock balance in __get_user_pages_remote
Message-ID: <20200407204754.GA66033@xz-x1>
References: <00000000000005c65d05a2b90e70@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00000000000005c65d05a2b90e70@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 01:16:11PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    7e634208 Merge tag 'acpi-5.7-rc1-2' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=169498ede00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=12205d036cec317f
> dashboard link: https://syzkaller.appspot.com/bug?extid=a8c70b7f3579fc0587dc
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a41543e00000
> 
> The bug was bisected to:
> 
> commit 71335f37c5e8ec9225285206f7f875057b9737ad
> Author: Peter Xu <peterx@redhat.com>
> Date:   Thu Apr 2 04:08:53 2020 +0000
> 
>     mm/gup: allow to react to fatal signals
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17dba9b3e00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=143ba9b3e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=103ba9b3e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a8c70b7f3579fc0587dc@syzkaller.appspotmail.com
> Fixes: 71335f37c5e8 ("mm/gup: allow to react to fatal signals")
> 
> =====================================
> WARNING: bad unlock balance detected!
> 5.6.0-syzkaller #0 Not tainted
> -------------------------------------
> syz-executor.0/8429 is trying to release lock (&mm->mmap_sem) at:
> [<ffffffff819fbf60>] __get_user_pages_locked mm/gup.c:1366 [inline]
> [<ffffffff819fbf60>] __get_user_pages_remote mm/gup.c:1831 [inline]
> [<ffffffff819fbf60>] __get_user_pages_remote+0x540/0x740 mm/gup.c:1806
> but there are no more locks to release!
> 
> other info that might help us debug this:
> no locks held by syz-executor.0/8429.
> 
> stack backtrace:
> CPU: 0 PID: 8429 Comm: syz-executor.0 Not tainted 5.6.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x188/0x20d lib/dump_stack.c:118
>  __lock_release kernel/locking/lockdep.c:4633 [inline]
>  lock_release+0x586/0x800 kernel/locking/lockdep.c:4941
>  up_read+0x79/0x750 kernel/locking/rwsem.c:1573
>  __get_user_pages_locked mm/gup.c:1366 [inline]
>  __get_user_pages_remote mm/gup.c:1831 [inline]
>  __get_user_pages_remote+0x540/0x740 mm/gup.c:1806
>  pin_user_pages_remote+0x67/0xa0 mm/gup.c:2897
>  process_vm_rw_single_vec mm/process_vm_access.c:108 [inline]
>  process_vm_rw_core.isra.0+0x423/0x940 mm/process_vm_access.c:218
>  process_vm_rw+0x21f/0x240 mm/process_vm_access.c:286
>  __do_sys_process_vm_writev mm/process_vm_access.c:308 [inline]
>  __se_sys_process_vm_writev mm/process_vm_access.c:303 [inline]
>  __x64_sys_process_vm_writev+0xdf/0x1b0 mm/process_vm_access.c:303
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> RIP: 0033:0x45c879
> Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fa1008bac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000137
> RAX: ffffffffffffffda RBX: 00007fa1008bb6d4 RCX: 000000000045c879
> RDX: 0000000000000001 RSI: 0000000020c22000 RDI: 0000000000000009
> RBP: 000000000076bf00 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000020c22fa0 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 000000000000085d R14: 00000000004cb1ee R15: 000000000076bf0c
> ------------[ cut here ]------------
> DEBUG_RWSEMS_WARN_ON(tmp < 0): count = 0xffffffffffffff00, magic = 0xffff888094028338, owner = 0x3, curr 0xffff888093cbc500, list empty
> WARNING: CPU: 0 PID: 8429 at kernel/locking/rwsem.c:1435 __up_read kernel/locking/rwsem.c:1435 [inline]
> WARNING: CPU: 0 PID: 8429 at kernel/locking/rwsem.c:1435 up_read+0x5f9/0x750 kernel/locking/rwsem.c:1574

Indeed the original commit is problematic, sorry for that.

Fix should be attached below.  According to syzbot document it should
understand the attached patch inline in the email and apply upon the
tree, then I think what we need is just:

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Thanks,

8<-----------------------------------------------------------------------
From 1be80593076b9630265e118696e74fa17276124f Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 7 Apr 2020 16:34:50 -0400
Subject: [PATCH] mm/gup: Mark lock taken only after a successful retake

It's definitely incorrect to mark the lock as taken even if
down_read_killable() failed.  It's overlooked when we switched from
down_read() to down_read_killable() because down_read() won't fail
while down_read_killable() could.

Reported-by: syzbot+a8c70b7f3579fc0587dc@syzkaller.appspotmail.com
Fixes: 71335f37c5e8 ("mm/gup: allow to react to fatal signals")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index da3e03185144..1f9a9b3a5869 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1328,7 +1328,6 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 		if (fatal_signal_pending(current))
 			break;
 
-		*locked = 1;
 		ret = down_read_killable(&mm->mmap_sem);
 		if (ret) {
 			BUG_ON(ret > 0);
@@ -1337,6 +1336,7 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 			break;
 		}
 
+		*locked = 1;
 		ret = __get_user_pages(tsk, mm, start, 1, flags | FOLL_TRIED,
 				       pages, NULL, locked);
 		if (!*locked) {
-- 
2.24.1

-- 
Peter Xu

