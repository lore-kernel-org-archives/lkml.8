Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505E7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 18:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16627206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 18:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CRWTYhDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgHNSQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 14:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgHNSQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 14:16:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAF0C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 11:16:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p138so10849916yba.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 11:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=h6D6mPQC0dkbUFdjYF/8h1Cll/wJX5U3u9YPEmeHq4c=;
        b=CRWTYhDiW2xoKrzb3ZOfLsbcI9K+eBO2GkuVe4tynXm5mGDJixMz7LsG5j2DkkcUj1
         rsX3FojxDXycuG9ie2S2fSTGxRZtzZlUN0wJfvwTviLQf+JAHF3ume/wowJ0bgMOarNu
         iCBeKpXyc+j1WtllXQR7PgoTQLwkqYVnasFmWqCCsnH6FUtKFSMHZUDW/Tc+AulCbppK
         eQvqt3+K9hB703xNaQzbkfTeqa/CQbWq5vwcWLY+1w6Aw5FZR+YXnmFmsqp68zJhY9ur
         2W5wmfTBQj1mzNoiA2wuIU9RoDyuc9tdnPv7gUbdzHJN3rhJWkhO90UOAwmz5rmoy9t5
         TzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=h6D6mPQC0dkbUFdjYF/8h1Cll/wJX5U3u9YPEmeHq4c=;
        b=MgJsSv6s3rSdJpsxGHaBn08b2unRVBhe/Ug/dhMp1sSJPsUPdl66apd5KRE2PlAkQf
         yUHLdNtIPkYOxQB+v9ySREVELqynxMUn8MAcv/ubJrgxyeHtwAdkDRF8xUIHFfg/7Laa
         1SGrzD8mRE1jSfHlm7sxRxxPquMGlc2I3bKZbqL2VF40mGeE+h8pADDM5pQ6h9Jmk4BL
         0433vWVTtZnWQG1keU3nf01nfTL7vzD06KATI8+k9cDV+klU59TYu32e1GpAXFVC6xRK
         DktYBEDPsPr8g6DepIT5pW1a9Uniy4+OENmz4szSDP4FHflxGHD46zlj2xCb94aAZuda
         lx/w==
X-Gm-Message-State: AOAM5307/PIdXZXHc1B6RVU99Fp6vL5znaGK/FNauL8ZMMfbFb6dTDLP
        PsWpPR82Js/e1vg2D/7bepjOvRS7CPO5mw==
X-Google-Smtp-Source: ABdhPJzV0Gxf42D6wqkogVBJjQOlOftzn54kb14DOiJyNEKK+61QE7nbPGgtmfbPTTlRau7U7tfmHpQ6xNGqSg==
X-Received: by 2002:a25:5105:: with SMTP id f5mr5654939ybb.262.1597428989238;
 Fri, 14 Aug 2020 11:16:29 -0700 (PDT)
Date:   Fri, 14 Aug 2020 11:16:17 -0700
Message-Id: <20200814181617.442787-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH] x86/fsgsbase/64: Fix NULL deref in 86_fsgsbase_read_task
From:   Eric Dumazet <edumazet@google.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jann Horn <jannh@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot found its way in 86_fsgsbase_read_task() [1]

Fix is to make sure ldt pointer is not NULL.

[1]
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 6866 Comm: syz-executor262 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:x86_fsgsbase_read_task+0x16d/0x310 arch/x86/kernel/process_64.c:393
Code: 3c 02 00 0f 85 7c 01 00 00 4c 8b a5 80 04 00 00 44 0f b7 eb 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 08 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 30 01 00 00 45 3b 6c 24 08 0f
RSP: 0018:ffffc90001677db8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000008 RDI: 0000000000000008
RBP: ffff88809eaf9780 R08: 0000000000000000 R09: ffff88809eaf9c17
R10: ffffed1013d5f382 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000020000080
FS:  0000000000000000(0000) GS:ffff8880ae600000(0063) knlGS:0000000009cf4840
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020000080 CR3: 000000009fa0d000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 putreg32+0x3ab/0x530 arch/x86/kernel/ptrace.c:876
 genregs32_set arch/x86/kernel/ptrace.c:1026 [inline]
 genregs32_set+0xa4/0x100 arch/x86/kernel/ptrace.c:1006
 copy_regset_from_user include/linux/regset.h:326 [inline]
 ia32_arch_ptrace arch/x86/kernel/ptrace.c:1061 [inline]
 compat_arch_ptrace+0x36c/0xd90 arch/x86/kernel/ptrace.c:1198
 __do_compat_sys_ptrace kernel/ptrace.c:1420 [inline]
 __se_compat_sys_ptrace kernel/ptrace.c:1389 [inline]
 __ia32_compat_sys_ptrace+0x220/0x2f0 kernel/ptrace.c:1389
 do_syscall_32_irqs_on arch/x86/entry/common.c:84 [inline]
 __do_fast_syscall_32+0x57/0x80 arch/x86/entry/common.c:126
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:149
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7fe9569
Code: 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000ffd99e7c EFLAGS: 00000217 ORIG_RAX: 000000000000001a
RAX: ffffffffffffffda RBX: 000000000000000d RCX: 0000000000001ad1
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000001ad1
RBP: 000000000000003c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace f79c8042700af7c5 ]---
RIP: 0010:x86_fsgsbase_read_task+0x16d/0x310 arch/x86/kernel/process_64.c:393
Code: 3c 02 00 0f 85 7c 01 00 00 4c 8b a5 80 04 00 00 44 0f b7 eb 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 08 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 30 01 00 00 45 3b 6c 24 08 0f
RSP: 0018:ffffc90001677db8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000008 RDI: 0000000000000008
RBP: ffff88809eaf9780 R08: 0000000000000000 R09: ffff88809eaf9c17
R10: ffffed1013d5f382 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000020000080
FS:  0000000000000000(0000) GS:ffff8880ae600000(0063) knlGS:0000000009cf4840
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020000080 CR3: 000000009fa0d000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Fixes: 07e1d88adaae ("x86/fsgsbase/64: Fix ptrace() to read the FS/GS base accurately")
Co-developed-by: Jann Horn <jannh@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Markus T Metzger <markus.t.metzger@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/process_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index d6f946707270e41d4aa04e4069b1b4eb82afd687..8393ee1aa9c89b3712b7aef510149d73762ef314 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -390,7 +390,7 @@ unsigned long x86_fsgsbase_read_task(struct task_struct *task,
 		 */
 		mutex_lock(&task->mm->context.lock);
 		ldt = task->mm->context.ldt;
-		if (unlikely(idx >= ldt->nr_entries))
+		if (unlikely(ldt == NULL || idx >= ldt->nr_entries))
 			base = 0;
 		else
 			base = get_desc_base(ldt->entries + idx);
-- 
2.28.0.220.ged08abb693-goog

