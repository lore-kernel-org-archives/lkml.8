Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC7FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 03:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD3E7208C7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 03:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593833697;
	bh=DwnW4KHO8DYEljlqVPhBYinwJJ3evXr/9FwF+yD4CN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2mVLCZPIa+TMIxykxwbPqVK1ycLF4/3jVWH+nFPnzZmcIhUN1YyX6J873rWFRy7Yk
	 b9bJPul/RacaxbEe2pT0+EkYKPwBnASiR0VbwIQQKeDv8NsbdRNbMpbTqxVAczQW8U
	 J2hcy8WWamOxVamNBGuYKo9elH9NM+lwU3tIJ8ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGDDe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 23:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgGDDez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 23:34:55 -0400
Received: from localhost.localdomain (89.208.247.74.16clouds.com [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6401D20899;
        Sat,  4 Jul 2020 03:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593833694;
        bh=DwnW4KHO8DYEljlqVPhBYinwJJ3evXr/9FwF+yD4CN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekniUIMB/mW40lSgqx4piqYh4sT4fOnQFgYmOx1uFIxDzFsxtt8CEWi8yoUo8sqls
         0GdPVbA8Bcm2F7y4YbicLcWGl/PjwiX4PexX+R1OyGGQo0SO3A9XK11Fs6iolmCb5r
         QyyppUSWMTR3hpKbXiYkmP2GVAjiynauB4km0lIQ=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        me@packi.ch, bjorn.topel@gmail.com, atish.patra@wdc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V1 3/5] riscv: Fixup compile error BUILD_BUG_ON failed
Date:   Sat,  4 Jul 2020 03:34:17 +0000
Message-Id: <1593833659-26224-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593833659-26224-1-git-send-email-guoren@kernel.org>
References: <1593833659-26224-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Unfortunately, the current code couldn't be compiled:

  CC      arch/riscv/kernel/patch.o
In file included from ./include/linux/kernel.h:11,
                 from ./include/linux/list.h:9,
                 from ./include/linux/preempt.h:11,
                 from ./include/linux/spinlock.h:51,
                 from arch/riscv/kernel/patch.c:6:
In function ‘fix_to_virt’,
    inlined from ‘patch_map’ at arch/riscv/kernel/patch.c:37:17:
./include/linux/compiler.h:392:38: error: call to ‘__compiletime_assert_205’ declared with attribute error: BUILD_BUG_ON failed: idx >= __end_of_fixed_addresses
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^
./include/linux/compiler.h:373:4: note: in definition of macro ‘__compiletime_assert’
    prefix ## suffix();    \
    ^~~~~~
./include/linux/compiler.h:392:2: note: in expansion of macro ‘_compiletime_assert’
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
  ^~~~~~~~~~~~~~~~
./include/asm-generic/fixmap.h:32:2: note: in expansion of macro ‘BUILD_BUG_ON’
  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
  ^~~~~~~~~~~~

Because fix_to_virt(, idx) needs a const value, not a dynamic variable of
reg-a0 or BUILD_BUG_ON failed with "idx >= __end_of_fixed_addresses".

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Zong Li <zong.li@sifive.com>
---
Changelog V2:
 - Use __always_inline as same as fix_to_virt
 - Use const "const unsigned int" for 2th param

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/kernel/patch.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index d4a64df..3179a4e 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -20,7 +20,12 @@ struct patch_insn {
 };
 
 #ifdef CONFIG_MMU
-static void *patch_map(void *addr, int fixmap)
+/*
+ * The fix_to_virt(, idx) needs a const value (not a dynamic variable of
+ * reg-a0) or BUILD_BUG_ON failed with "idx >= __end_of_fixed_addresses".
+ * So use '__always_inline' and 'const unsigned int fixmap' here.
+ */
+static __always_inline void *patch_map(void *addr, const unsigned int fixmap)
 {
 	uintptr_t uintaddr = (uintptr_t) addr;
 	struct page *page;
@@ -37,7 +42,6 @@ static void *patch_map(void *addr, int fixmap)
 	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
 					 (uintaddr & ~PAGE_MASK));
 }
-NOKPROBE_SYMBOL(patch_map);
 
 static void patch_unmap(int fixmap)
 {
-- 
2.7.4

