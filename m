Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C26C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB162078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389734AbgEYKKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:10:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:42446 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389356AbgEYKKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:10:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3A29DAA35;
        Mon, 25 May 2020 10:10:37 +0000 (UTC)
Date:   Mon, 25 May 2020 12:10:33 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for May 21 (objtool warnings)
In-Reply-To: <22332d9b-5e9f-5474-adac-9b3e39861aee@infradead.org>
Message-ID: <alpine.LSU.2.21.2005251101030.24984@pobox.suse.cz>
References: <20200522001209.07c19400@canb.auug.org.au> <22332d9b-5e9f-5474-adac-9b3e39861aee@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020, Randy Dunlap wrote:

> On 5/21/20 7:12 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20200519:
> > 

These are indeed caused by -flive-patching
 
> on x86_64:
> 
> fs/open.o: warning: objtool: chmod_common()+0x104: unreachable instruction
> fs/namei.o: warning: objtool: do_renameat2()+0x482: unreachable instruction

Two "funny" ones. When CONFIG_FILE_LOCKING is not set, break_deleg_wait() 
is just BUG(). GCC decides to isra optimize it to break_deleg_wait.isra.0 
and call it in chmod_common() and do_renameat2() instead of just inline 
it.

chmod_common() with -flive-patching:

     981:       e8 f7 fe ff ff          callq  87d <break_deleg_wait.isra.0>
     986:       41 89 c4                mov    %eax,%r12d
     989:       85 c0                   test   %eax,%eax
     98b:       0f 84 76 ff ff ff       je     907 <chmod_common+0x7b>
     991:       48 89 df                mov    %rbx,%rdi
     994:       e8 00 00 00 00          callq  999 <chmod_common+0x10d>
                        995: R_X86_64_PLT32     __tsan_read8-0x4

without:

     985:       e8 f3 fe ff ff          callq  87d <break_deleg_wait.isra.0>
     98a:       48 89 df                mov    %rbx,%rdi
     98d:       e8 00 00 00 00          callq  992 <chmod_common+0x106>
                        98e: R_X86_64_PLT32     __tsan_read8-0x4

The error checking of break_deleg_wait() is correctly compiled out, 
because it is unreachable.

I wondered how come objtool (correctly) says the instructions are 
unreachable. It means it knows that break_deleg_wait.isra.0 is a dead end
(dead_end_function() returns true while checking INSN_CALL). And of course
"return 0;" in break_deleg_wait() is compiled out.

000000000000087d <break_deleg_wait.isra.0>:
     87d:       55                      push   %rbp
     87e:       48 89 e5                mov    %rsp,%rbp
     881:       48 8b 7d 08             mov    0x8(%rbp),%rdi
     885:       e8 00 00 00 00          callq  88a <break_deleg_wait.isra.0+0xd>
                        886: R_X86_64_PLT32     __tsan_func_entry-0x4
     88a:       0f 0b                   ud2    

One way to fix it is to mark break_deleg_wait() as __always_inline. Then 
it all works.

Note: there are more functions calling break_deleg_wait() with this 
pattern.

I'll try to find out which optimization does this, because it is a 
slightly different scenario than hiding __noreturn from the callees. 
Probably -fno-ipa-pure-const again.

> kernel/exit.o: warning: objtool: __ia32_sys_exit_group()+0x2e: unreachable instruction

Easy one. do_group_exit() is noreturn and should be marked as such.

> Full randconfig file is attached.
> 
> 
> -- 
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for reporting, Randy.

Miroslav

---
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ac8bd95b5fe8..2b79932e924d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2546,7 +2546,7 @@ static inline int try_break_deleg(struct inode *inode, struct inode **delegated_
 	return 0;
 }
 
-static inline int break_deleg_wait(struct inode **delegated_inode)
+static __always_inline int break_deleg_wait(struct inode **delegated_inode)
 {
 	BUG();
 	return 0;
diff --git a/kernel/exit.c b/kernel/exit.c
index ed56917d50e3..9437c1ca37c5 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -876,7 +876,7 @@ SYSCALL_DEFINE1(exit, int, error_code)
  * Take down every thread in the group.  This is called by fatal signals
  * as well as by sys_exit_group (below).
  */
-void
+void __noreturn
 do_group_exit(int exit_code)
 {
 	struct signal_struct *sig = current->signal;
