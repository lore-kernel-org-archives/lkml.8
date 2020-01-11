Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763E9C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41ACB2064C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736543;
	bh=GYAiOy07T+ykLeb+hCT6lXSIG+xqYiuRzQzeHMN3wWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PQycYa+KzG29aU3sIqCCtfiVS6ryLgGpLv+YdunAgA7FHPjtV+BdHbSoUWKFKs5RE
	 qg/xhxY2FYwww5d2R1IXhznyG8zRawcWkXh849pgQ9hgRfQpSr+1q9ylRdOXebJzgG
	 qPCQiBww62xrz1GUa+9cycUBrkL206kqTdB5DMCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgAKJzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 04:55:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbgAKJzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 04:55:40 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC8EE2072E;
        Sat, 11 Jan 2020 09:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736539;
        bh=GYAiOy07T+ykLeb+hCT6lXSIG+xqYiuRzQzeHMN3wWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RFO2wN+X6uo8PYy5Oi1qPumygeXGmYI5vAdtIxe7WAYdxnDzZqq3CCDt5lioseN6H
         U1YIssjsUQR6CNi0hboOWuIzY2KpqczBL2sywN4e45nOpBLcmd14ymwMllgQc7+hiX
         RK9csZ/asdMfMlkkme7EFFsDxMZqMyTEqQODywWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 47/59] parisc: Fix compiler warnings in debug_core.c
Date:   Sat, 11 Jan 2020 10:49:56 +0100
Message-Id: <20200111094848.684629462@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094835.417654274@linuxfoundation.org>
References: <20200111094835.417654274@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

[ Upstream commit 75cf9797006a3a9f29a3a25c1febd6842a4a9eb2 ]

Fix this compiler warning:
kernel/debug/debug_core.c: In function ‘kgdb_cpu_enter’:
arch/parisc/include/asm/cmpxchg.h:48:3: warning: value computed is not used [-Wunused-value]
   48 |  ((__typeof__(*(ptr)))__xchg((unsigned long)(x), (ptr), sizeof(*(ptr))))
arch/parisc/include/asm/atomic.h:78:30: note: in expansion of macro ‘xchg’
   78 | #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
      |                              ^~~~
kernel/debug/debug_core.c:596:4: note: in expansion of macro ‘atomic_xchg’
  596 |    atomic_xchg(&kgdb_active, cpu);
      |    ^~~~~~~~~~~

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/include/asm/cmpxchg.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm/cmpxchg.h
index 0a90b965cccb..9849bef2a766 100644
--- a/arch/parisc/include/asm/cmpxchg.h
+++ b/arch/parisc/include/asm/cmpxchg.h
@@ -43,8 +43,14 @@ __xchg(unsigned long x, __volatile__ void *ptr, int size)
 **		if (((unsigned long)p & 0xf) == 0)
 **			return __ldcw(p);
 */
-#define xchg(ptr, x) \
-	((__typeof__(*(ptr)))__xchg((unsigned long)(x), (ptr), sizeof(*(ptr))))
+#define xchg(ptr, x)							\
+({									\
+	__typeof__(*(ptr)) __ret;					\
+	__typeof__(*(ptr)) _x_ = (x);					\
+	__ret = (__typeof__(*(ptr)))					\
+		__xchg((unsigned long)_x_, (ptr), sizeof(*(ptr)));	\
+	__ret;								\
+})
 
 /* bug catcher for when unsupported size is used - won't link */
 extern void __cmpxchg_called_with_bad_pointer(void);
-- 
2.20.1



