Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DD2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A33622BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597919931;
	bh=ysS3LGq+470SGw6FYTetlB33DoPN5s8hyLYUhLe+03M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1X7reTCsM5iRPCss7MHfyWaXKEjfMQmHU1DumcDoi4NHy+wrLrPjvrMg6T36hc+Hi
	 sW6BG2WnyPO9hfSwqJhRE9mWnasbcO7+c/3kmYnjEeGZHxfRMyjVlg3JZdM9iriX2y
	 xqvVtA60ok/rE/E6SYtsid/HLRISLjqDfVQJf6/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgHTKio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729431AbgHTKSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:18:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C25872075E;
        Thu, 20 Aug 2020 10:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918683;
        bh=ysS3LGq+470SGw6FYTetlB33DoPN5s8hyLYUhLe+03M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ue0o29GhUEi+Q58BNHYkWZQorx1BilbieEr+s42tIZwgslRxN3kuUa/IpU19oE+W3
         BB6b8f1xo4TbwkZQILYvF+Ml4gQQG+Fw+VIP4ch6oSfF8KCKiXVtgI3+j2A0JGXSIp
         urFRiOiKlRqYL6wk5+PYENOZ7qNeRDGOY1PcK6X4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 028/149] ARM: percpu.h: fix build error
Date:   Thu, 20 Aug 2020 11:21:45 +0200
Message-Id: <20200820092127.086482863@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
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
@@ -16,6 +16,8 @@
 #ifndef _ASM_ARM_PERCPU_H_
 #define _ASM_ARM_PERCPU_H_
 
+#include <asm/thread_info.h>
+
 /*
  * Same as asm-generic/percpu.h, except that we store the per cpu offset
  * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7


