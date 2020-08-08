Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DD6C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2630206D8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iF9WF3wG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgHHXHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHHXHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:07:06 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346A1C061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 16:07:06 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a79so3090391pfa.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 16:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yp0yxUA9Qr5sfN9dJnZ4FZ8o2dyuV6wPYjNmelJkcMo=;
        b=iF9WF3wGU+2/gWAr8dnN9renOmkqTc4zq3LZ5XLVP10CXyaGqO/KxePCis+hRy4hc+
         fz/SbbuRUrKdrxTG/KIuv4IiwcEuwwUxWpkWFLY2IpSfErWITs5aJuGs2QbIa46I6yRg
         qGb9r+f7JoxU55BRk/Mw/GcdQ2Nmp3kaNTv0A/iFIqKlgoyLNqmN0aftAJEaRWrPkwBr
         IoXOxzSkwQgFfK8RfpVKDw+2pBP0h/pN8+KUjJOKQ9HopXhVwvdx+prkBGYBkX+WMImY
         CISWu6uFdL8ZsMPh7Idj4tnSe168WI03aw3wSeYfqim0rjeObINfpGYuCrEd6su+s+ay
         bH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yp0yxUA9Qr5sfN9dJnZ4FZ8o2dyuV6wPYjNmelJkcMo=;
        b=LVv2MQWqLAolUk89L2jeIApFAZltTEa5N3hxXLkiQwAepufW2bo0MewN9OClqfhHJB
         F0W8iNhGFIiLwkeJboXgD/QZ9sP/M3TZVeLSpTVs3Ig9VIrW5hUwRsG7WUWRiVt0OT9c
         t/+rCTmdvg+y2XMKZ2yuvfhvWIr5d2dhxxyxWbnJJhJXcNgX3ZCRqN230h4XnU8CHU/h
         UJOXGAiSibYSU+fJjcLpWUAkWrw5DzpazMjzcMgPrLBPSbl24S37KpWpszWto2e96Mxc
         UTJjg5WLOQHtT/qreCvYpw6jKiAvoFJszJJg2oAG+3tCbN/joe2/JYnXWQyLoCdjx+EK
         fV5Q==
X-Gm-Message-State: AOAM532QebBd1Cp04C0eVoc4Q6/hJzJ13XeivfzL0T9opratMsBuD9OB
        YhRCOlrBUF+fCfS3jvDxLOdW8z1E
X-Google-Smtp-Source: ABdhPJxvMhp5c76/vMVB3aaIKE6ijLz+owCcy0I5Lr2AhsCmPmt4yeJBZjtck9mFAC/bZlIlb/dj2A==
X-Received: by 2002:aa7:9219:: with SMTP id 25mr19490136pfo.4.1596928024575;
        Sat, 08 Aug 2020 16:07:04 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id m62sm16305354pje.18.2020.08.08.16.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 16:07:03 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH v3 2/6] openrisc: uaccess: Fix sparse address space warnings
Date:   Sun,  9 Aug 2020 08:06:43 +0900
Message-Id: <20200808230647.833047-3-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200808230647.833047-1-shorne@gmail.com>
References: <20200808230647.833047-1-shorne@gmail.com>
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
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
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

