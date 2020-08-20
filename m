Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF9CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9F1206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597920921;
	bh=80d02pedfTpF3cSJbY6um8Fk5bv/JNoyRNqEAFcDkBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yy9s66z3ngq0ELXUbr35hdgI+EexYrR/2jilSIKijCb7+rGVkbCDo/YO6+MT6Lau+
	 Uh8Ix5BRX5hTFUNKj3JXv2wmbV2qxHVMJcYJSVzeGk29PLXEFbyGzaU66y3X78LW+X
	 2sY4n3dOEaKab3+W7RpAtPOJ3iT5lOfWQY9ZdUUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgHTKzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731157AbgHTKOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:14:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B23A20724;
        Thu, 20 Aug 2020 10:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918454;
        bh=80d02pedfTpF3cSJbY6um8Fk5bv/JNoyRNqEAFcDkBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N3wMT0kw8qHm/ksn4r+AFdozLRNzMO88B2kHNxL51ortA4PX+9D13NMVvPjaKSZnZ
         a1HyzHA2dXa2OXPZRp55z95O2leurhuLYfemDHMMsd9KhpHNg40V4xIlOc8+42UxCz
         OapqHvo3aVcgXP+P+gQKnXaWv+tjaYGw60RbIdSs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 175/228] powerpc: Fix circular dependency between percpu.h and mmu.h
Date:   Thu, 20 Aug 2020 11:22:30 +0200
Message-Id: <20200820091616.323325226@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

commit 0c83b277ada72b585e6a3e52b067669df15bcedb upstream.

Recently random.h started including percpu.h (see commit
f227e3ec3b5c ("random32: update the net random state on interrupt and
activity")), which broke corenet64_smp_defconfig:

  In file included from /linux/arch/powerpc/include/asm/paca.h:18,
                   from /linux/arch/powerpc/include/asm/percpu.h:13,
                   from /linux/include/linux/random.h:14,
                   from /linux/lib/uuid.c:14:
  /linux/arch/powerpc/include/asm/mmu.h:139:22: error: unknown type name 'next_tlbcam_idx'
    139 | DECLARE_PER_CPU(int, next_tlbcam_idx);

This is due to a circular header dependency:
  asm/mmu.h includes asm/percpu.h, which includes asm/paca.h, which
  includes asm/mmu.h

Which means DECLARE_PER_CPU() isn't defined when mmu.h needs it.

We can fix it by moving the include of paca.h below the include of
asm-generic/percpu.h.

This moves the include of paca.h out of the #ifdef __powerpc64__, but
that is OK because paca.h is almost entirely inside #ifdef
CONFIG_PPC64 anyway.

It also moves the include of paca.h out of the #ifdef CONFIG_SMP,
which could possibly break something, but seems to have no ill
effects.

Fixes: f227e3ec3b5c ("random32: update the net random state on interrupt and activity")
Cc: stable@vger.kernel.org # v5.8
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200804130558.292328-1-mpe@ellerman.id.au
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/percpu.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/include/asm/percpu.h
+++ b/arch/powerpc/include/asm/percpu.h
@@ -10,8 +10,6 @@
 
 #ifdef CONFIG_SMP
 
-#include <asm/paca.h>
-
 #define __my_cpu_offset local_paca->data_offset
 
 #endif /* CONFIG_SMP */
@@ -19,4 +17,6 @@
 
 #include <asm-generic/percpu.h>
 
+#include <asm/paca.h>
+
 #endif /* _ASM_POWERPC_PERCPU_H_ */


