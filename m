Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5C1C433E3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9457E206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596459411;
	bh=47QAnSMoOVMr8QHQNgdXK4N904/7dAfTkxp4OLgXePU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TP+xK4+zRGf2p6PqA3wQPNlzTDCoYxLTnEx5TUrmiGzzD2vOkyppryEs5SmZlhG8f
	 JxeYcBsccpp8edv7Yyq7HECNS0CO+dDF3sOx13qEaCl3B6PKRpQ7ZeNrmxNWvKyhzA
	 Klg8CJWvPKSehH3LLzZ20n/Z1AdUZPeid1zxMubo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgHCMV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:21:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbgHCMVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:21:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1085C20738;
        Mon,  3 Aug 2020 12:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457313;
        bh=47QAnSMoOVMr8QHQNgdXK4N904/7dAfTkxp4OLgXePU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hYawputuZiS6r6a61BHzDLVOKnfxzrh0ebm4E/ZtKMX3Z+ha/amdNOOViUhRwUgud
         Dse81Drgbp3sIHHDHmsppanqt+hAgmOypC+nGKu+wYjLvK8Tr542gItUIzNN7jPqzp
         w1Z7A9p2R+5Rl3eBQmdy99Xu7QsHsEWlCx9zIqRE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.7 022/120] ARM: percpu.h: fix build error
Date:   Mon,  3 Aug 2020 14:18:00 +0200
Message-Id: <20200803121903.930048559@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121902.860751811@linuxfoundation.org>
References: <20200803121902.860751811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

commit aa54ea903abb02303bf55855fb51e3fcee135d70 upstream.

Fix build error for the case:
  defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)

config: keystone_defconfig

  CC      arch/arm/kernel/signal.o
  In file included from ../include/linux/random.h:14,
                    from ../arch/arm/kernel/signal.c:8:
  ../arch/arm/include/asm/percpu.h: In function ‘__my_cpu_offset’:
  ../arch/arm/include/asm/percpu.h:29:34: error: ‘current_stack_pointer’ undeclared (first use in this function); did you mean ‘user_stack_pointer’?
      : "Q" (*(const unsigned long *)current_stack_pointer));
                                     ^~~~~~~~~~~~~~~~~~~~~
                                     user_stack_pointer

Fixes: f227e3ec3b5c ("random32: update the net random state on interrupt and activity")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/include/asm/percpu.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/include/asm/percpu.h
+++ b/arch/arm/include/asm/percpu.h
@@ -5,6 +5,8 @@
 #ifndef _ASM_ARM_PERCPU_H_
 #define _ASM_ARM_PERCPU_H_
 
+#include <asm/thread_info.h>
+
 /*
  * Same as asm-generic/percpu.h, except that we store the per cpu offset
  * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7


