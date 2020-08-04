Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27100C433E4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D3492070A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+z3LaGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgHDEYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHDEYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 00:24:16 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9FBC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 21:24:16 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c10so975520pjn.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 21:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JngFG1EkTLo4BpqZhiJxszD1gfeCHHSLXHsexflvscw=;
        b=K+z3LaGknG3+dskAQIYMfnPKZZK9plCBb+szon+FT/j+2OfxNClUn1QhGrHJ5Y9/mP
         MTv0g3GD6cpoOaHa2uT6sx9vNEqrNbrpVbjR2I4/6Vm/K04cvprsA8wQDKhcmmIkuWvg
         wCxeQXSiWWFwz8jn5WI6+1sqASV2cs+MiO40IB5OOlV61y324Sq6VfZs/ca1Ow/tS+vG
         Hwn2cd1G7ea5W3GkQyif4XReLegm74iGrxoCxVIarH8ASnQgoY5hbPijDuvKv+712y/p
         UMkgde2b0G56XmiZUYIXsvA9wGnG2h5go9RxdWAuu01FYYkWLOOCCROHAdplkQyuBGy+
         vlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JngFG1EkTLo4BpqZhiJxszD1gfeCHHSLXHsexflvscw=;
        b=Lml//gXi+7pfdc5SVZRj6GsIWl2DBooFGnnpwvyQzpLPNGGh2gaZn0HlWz2JyU0pgz
         p9m6kIZ2MIxmM4J5v+JAVOBA8fUFO3gS+4qzG3jK3IGdwAH/x2o5mDjWyzt8+rsp2I6N
         TB6GgHVvebPSeS2vYkP6Wafor2sp3Q3FxWpmhFDn2kA0aYM1LeRDzC1WXTwtvzydYUMq
         9E1mAq9KdCkZKL6icu3VeULXC/KbUI2dSRDQIyFCWgqfy7W25qp/sLstvfAPHNq1sQaC
         +tbZyVoTgKqrpOxvmgSojyZOKamAnifXzkm5GsFpR96euI+AWZzDF646qMzLp4iegBjg
         kVtQ==
X-Gm-Message-State: AOAM5303ye8uDL52FbPRaMVqS0g0V49DTpJDQg6VlZMhXDKIKel0ekwb
        RKRK/ZIchrefZFZmrkBdcc7CDgOL
X-Google-Smtp-Source: ABdhPJzfpgnCKblnJGY/7G3hc88dXBossscj+e/PDs0c+uhVJluJnQ3C3XjLnEzx8zqlP4avaEL5mg==
X-Received: by 2002:a17:902:7246:: with SMTP id c6mr17804962pll.17.1596515055411;
        Mon, 03 Aug 2020 21:24:15 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id j130sm107809pgc.76.2020.08.03.21.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 21:24:14 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH 2/6] openrisc: uaccess: Fix sparse address space warnings
Date:   Tue,  4 Aug 2020 13:23:50 +0900
Message-Id: <20200804042354.3930694-3-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200804042354.3930694-1-shorne@gmail.com>
References: <20200804042354.3930694-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OpenRISC user access functions put_user(), get_user() and
clear_user() were missing proper sparse annotations.  This generated
warnings like the below.

This patch adds the annotations to fix the warnings.

Example warnings:

net/ipv4/ip_sockglue.c:759:29: warning: incorrect type in argument 1 (different address spaces)
net/ipv4/ip_sockglue.c:759:29:    expected void const volatile [noderef] __user *
net/ipv4/ip_sockglue.c:759:29:    got int const *__gu_addr
net/ipv4/ip_sockglue.c:764:29: warning: incorrect type in initializer (different address spaces)
net/ipv4/ip_sockglue.c:764:29:    expected unsigned char const *__gu_addr
net/ipv4/ip_sockglue.c:764:29:    got unsigned char [noderef] __user *

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/uaccess.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index 46e31bb4a9ad..f2fc5c4b88c3 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -100,7 +100,7 @@ extern long __put_user_bad(void);
 #define __put_user_check(x, ptr, size)					\
 ({									\
 	long __pu_err = -EFAULT;					\
-	__typeof__(*(ptr)) *__pu_addr = (ptr);				\
+	__typeof__(*(ptr)) __user *__pu_addr = (ptr);			\
 	if (access_ok(__pu_addr, size))			\
 		__put_user_size((x), __pu_addr, (size), __pu_err);	\
 	__pu_err;							\
@@ -173,7 +173,7 @@ struct __large_struct {
 #define __get_user_check(x, ptr, size)					\
 ({									\
 	long __gu_err = -EFAULT, __gu_val = 0;				\
-	const __typeof__(*(ptr)) * __gu_addr = (ptr);			\
+	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	if (access_ok(__gu_addr, size))			\
 		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
@@ -248,10 +248,10 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long size)
 #define INLINE_COPY_FROM_USER
 #define INLINE_COPY_TO_USER
 
-extern unsigned long __clear_user(void *addr, unsigned long size);
+extern unsigned long __clear_user(void __user *addr, unsigned long size);
 
 static inline __must_check unsigned long
-clear_user(void *addr, unsigned long size)
+clear_user(void __user *addr, unsigned long size)
 {
 	if (likely(access_ok(addr, size)))
 		size = __clear_user(addr, size);
-- 
2.26.2

