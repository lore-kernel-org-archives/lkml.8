Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96470C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 14:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE6920663
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 14:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgFGOmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 10:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgFGOmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 10:42:01 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D24C08C5C3;
        Sun,  7 Jun 2020 07:42:01 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jhwUi-004fd3-1z; Sun, 07 Jun 2020 14:41:52 +0000
Date:   Sun, 7 Jun 2020 15:41:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Miller <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git pull] a couple of sparc ptrace fixes
Message-ID: <20200607144152.GM23230@ZenIV.linux.org.uk>
References: <20200531010414.GW23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531010414.GW23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 02:04:14AM +0100, Al Viro wrote:
> The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:
> 
>   Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-davem
> 
> for you to fetch changes up to cf51e129b96847f969bfb8af1ee1516a01a70b39:
> 
>   sparc32: fix register window handling in genregs32_[gs]et() (2020-05-20 13:29:37 -0400)
> 
> ----------------------------------------------------------------
> Al Viro (2):
>       sparc64: fix misuses of access_process_vm() in genregs32_[sg]et()
>       sparc32: fix register window handling in genregs32_[gs]et()
> 
>  arch/sparc/kernel/ptrace_32.c | 228 ++++++++++++++++++------------------------
>  arch/sparc/kernel/ptrace_64.c |  17 +---
>  2 files changed, 101 insertions(+), 144 deletions(-)

Grrr...  

sparc32 fix had breakage of its own; I've pushed a fix into #for-davem.  Fixup
follows.  Could you pull it?

commit 9d964e1b82d8182184153b70174f445ea616f053
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat Jun 6 23:44:24 2020 -0400

    fix a braino in "sparc32: fix register window handling in genregs32_[gs]et()"
    
    lost npc in PTRACE_SETREGSET, breaking PTRACE_SETREGS as well
    
    Fixes: cf51e129b968 "sparc32: fix register window handling in genregs32_[gs]et()"
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/arch/sparc/kernel/ptrace_32.c b/arch/sparc/kernel/ptrace_32.c
index 60f7205ebe40..646dd58169ec 100644
--- a/arch/sparc/kernel/ptrace_32.c
+++ b/arch/sparc/kernel/ptrace_32.c
@@ -168,12 +168,17 @@ static int genregs32_set(struct task_struct *target,
 	if (ret || !count)
 		return ret;
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				 &regs->y,
+				 &regs->npc,
 				 34 * sizeof(u32), 35 * sizeof(u32));
 	if (ret || !count)
 		return ret;
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &regs->y,
+				 35 * sizeof(u32), 36 * sizeof(u32));
+	if (ret || !count)
+		return ret;
 	return user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
-					 35 * sizeof(u32), 38 * sizeof(u32));
+					 36 * sizeof(u32), 38 * sizeof(u32));
 }
 
 static int fpregs32_get(struct task_struct *target,
