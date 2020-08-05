Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF12DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 926412063A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRb0olEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHEVHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHEVHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 17:07:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF608C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 14:07:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 17so3257990pfw.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JngFG1EkTLo4BpqZhiJxszD1gfeCHHSLXHsexflvscw=;
        b=vRb0olEwiG/Js2ATUV13Bc/LTdwpm5CDHz0zYOPPXDLQ7Nd+qHyAa2GNpcnvVFvCwh
         zUn6tWgcq7MtGMGxTBijDbj7cOnmaXfMLjJv5w9aOPiWUMZJ04uVmAt/29a5NeREZ6aT
         5CcQZH7GaRdkWqAZrHcIwWvOj1IlAOY6o7z8ogXdRR1Cyfd3MemzUNbQwAeC2iOHWiD4
         xEbuKeb1NNf81yh7lA5Hfx1ahP1mrXodr5M2cRLSxalt2PT7dpib/hjSQg49a1ld0WK1
         UeX+PeRcNGT9xJlRZj60iowG5bllUdEaBg4fb9Lx5YY/r9tsBfnp96pISz/h1LNbo97K
         hG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JngFG1EkTLo4BpqZhiJxszD1gfeCHHSLXHsexflvscw=;
        b=V/S9de5uOPWp1PWUdwc6QDbuKTALPKUrIR521/SBdR5aU+UtBiO5E/z9BJvh8KSjvR
         QMV9rBvspqgCJbTk4QrB8WNNPCIyyo90xmHPNK8UY6L8ZDKKXKrMHMy8LYEPwXmYfixO
         FopH79lmTNDGa16aT0+FTtXRtnzjmIBJTENnHtfHBObRGVTdWBW900VxOsi3i0uSlo5U
         FIb3sfTaikkGeW2DcuAAtGNimtcfc6MpAqsk5GqrxDXfsLCRmDb5R2yBql1ao5YPKNcS
         QOW6iPxCEAo9wYHY2U/R5n3029MHYLvOx71pYV82c42eW+HKWgmC7hMiLsZ59UH1dmZX
         ukfw==
X-Gm-Message-State: AOAM532JCRkAA06T1/9ZMF5mf2G1ppl+k/NqGJiE/pO8tpv6oHdrtQKw
        T37/XeuYkpYz6O4F9t2GdH7Aj2ZR
X-Google-Smtp-Source: ABdhPJzyd4xGR6WgmMUFF1ie18j6wvBJNgLAcJlDGUbsxYG8G6RlHGUDfeW0V3dxac/VrOa+Y/uhtA==
X-Received: by 2002:a65:4c4e:: with SMTP id l14mr3570458pgr.200.1596661666883;
        Wed, 05 Aug 2020 14:07:46 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id x18sm4382508pfc.93.2020.08.05.14.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:07:46 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH v2 2/6] openrisc: uaccess: Fix sparse address space warnings
Date:   Thu,  6 Aug 2020 06:07:21 +0900
Message-Id: <20200805210725.310301-3-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200805210725.310301-1-shorne@gmail.com>
References: <20200805210725.310301-1-shorne@gmail.com>
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

