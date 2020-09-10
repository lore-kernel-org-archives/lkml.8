Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC6AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C894D208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaW8IdSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgIJXkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgIJXkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:40:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CC2C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:40:04 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l191so5226834pgd.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AnsaKcjQA7XDzKaULTAgMjaBRBirV4L21FU5x5dUGKw=;
        b=gaW8IdSbf3GaFy6eEV++qACh3TrHYCYg+2WmSmuhspQ2uDt6L6BnFmJsGeojolYJUc
         HK6EM7/S5de6tgVHPcQoVRcMGKrLg+MylINLv8Z5jp8ovuRu6e8cwvp3O3sKcNGOWRa9
         ASrbCheOhgfeTfCxaKAEWUNKcpLTIhHOIufgHu+uiixW4IfCDKAS1aK4ZzyrN81gsFxG
         L5yAUgnAysa5RNrpiWMrEkKYGcUebfLx96svrrb+J+9PPnTGlxN+LPijaUcebxzDrEiu
         rfxqYsmo28NL94OGODXNW/dinC3XzbMkaQZf/EQbN0DknebmIObpNFlkucbpKMdkyJfT
         9V4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AnsaKcjQA7XDzKaULTAgMjaBRBirV4L21FU5x5dUGKw=;
        b=O82ZeLVqZKoph4dDEhSUYc9T8is3ZS9oVLUM5yv9jWvRyK41M/Cx69PFTILgiYDAw7
         iRnzIzHU7XaR0yHYwcbziZ0+PZaSjegtJSrPAxyIYs88JxQaVyg27hyWJyzlRaSMIY4G
         N3KkSA2sMpRtJkMjFhWZz1lK8PjyB56/i3TGcjM/i21wgwm3opseGu6v+QgJ3YlGAskU
         z4wSaSSeb9YqaXizJ6j/MvXdzarcc397qwBf+fmXBBY56PJjmCOUpbsQm2qVDyEgvYLj
         rOpZGPVA//aneZILaTk0lrp4p6h58BaEDs2Rrft2Uk7/4E8ecoL1FFSLsM/enqZPmRJi
         dlVg==
X-Gm-Message-State: AOAM533FyjuBlpTbSutnaRQSBiEaJeUfATTPT33AmTwBjp4XfLwMYoNN
        taJU10VoND9dwRsoNIo4gzo1STNZOSBK9Q==
X-Google-Smtp-Source: ABdhPJyXk862vTJ+5c4YYfnbPIuEKCO7z2v14OPFQkhzPJfuY6u6irLGz+HHLFJl831tjhY9XtvqDw==
X-Received: by 2002:a17:902:5996:b029:d0:89f1:9e2c with SMTP id p22-20020a1709025996b02900d089f19e2cmr66134pli.8.1599781203947;
        Thu, 10 Sep 2020 16:40:03 -0700 (PDT)
Received: from localhost (g168.115-65-169.ppp.wakwak.ne.jp. [115.65.169.168])
        by smtp.gmail.com with ESMTPSA id a15sm185866pfi.119.2020.09.10.16.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 16:40:03 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greentime Hu <green.hu@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3 3/3] openrisc: Fix issue with get_user for 64-bit values
Date:   Fri, 11 Sep 2020 08:39:40 +0900
Message-Id: <20200910233940.2132107-4-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910233940.2132107-1-shorne@gmail.com>
References: <20200910233940.2132107-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A build failure was raised by kbuild with the following error.

    drivers/android/binder.c: Assembler messages:
    drivers/android/binder.c:3861: Error: unrecognized keyword/register name `l.lwz ?ap,4(r24)'
    drivers/android/binder.c:3866: Error: unrecognized keyword/register name `l.addi ?ap,r0,0'

The issue is with 64-bit get_user() calls on openrisc.  I traced this to
a problem where in the internally in the get_user macros there is a cast
to long __gu_val this causes GCC to think the get_user call is 32-bit.
This binder code is really long and GCC allocates register r30, which
triggers the issue. The 64-bit get_user asm tries to get the 64-bit pair
register, which for r30 overflows the general register names and returns
the dummy register ?ap.

The fix here is to move the temporary variables into the asm macros.  We
use a 32-bit __gu_tmp for 32-bit and smaller macro and a 64-bit tmp in
the 64-bit macro.  The cast in the 64-bit macro has a trick of casting
through __typeof__((x)-(x)) which avoids the below warning.  This was
barrowed from riscv.

    arch/openrisc/include/asm/uaccess.h:240:8: warning: cast to pointer from integer of different size

I tested this is a small unit test to check reading between 64-bit and
32-bit pointers to 64-bit and 32-bit values in all combinations.  Also I
ran make C=1 to confirm no new sparse warnings came up.  It all looks
clean to me.

Link: https://lore.kernel.org/lkml/202008200453.ohnhqkjQ%25lkp@intel.com/
Signed-off-by: Stafford Horne <shorne@gmail.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
Changes since v2:
 - Add back temporary variables but move to a different place, as described in
   commit message.
Changes since v1:
 - New

 arch/openrisc/include/asm/uaccess.h | 33 ++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index f0390211236b..120f5005461b 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -165,19 +165,19 @@ struct __large_struct {
 
 #define __get_user_nocheck(x, ptr, size)			\
 ({								\
-	long __gu_err, __gu_val;				\
-	__get_user_size(__gu_val, (ptr), (size), __gu_err);	\
-	(x) = (__force __typeof__(*(ptr)))__gu_val;		\
+	long __gu_err;						\
+	__get_user_size((x), (ptr), (size), __gu_err);		\
 	__gu_err;						\
 })
 
 #define __get_user_check(x, ptr, size)					\
 ({									\
-	long __gu_err = -EFAULT, __gu_val = 0;				\
+	long __gu_err = -EFAULT;					\
 	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
-	if (access_ok(__gu_addr, size))			\
-		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
-	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
+	if (access_ok(__gu_addr, size))					\
+		__get_user_size((x), __gu_addr, (size), __gu_err);	\
+	else								\
+		(x) = (__typeof__(*(ptr))) 0;				\
 	__gu_err;							\
 })
 
@@ -191,11 +191,13 @@ do {									\
 	case 2: __get_user_asm(x, ptr, retval, "l.lhz"); break;		\
 	case 4: __get_user_asm(x, ptr, retval, "l.lwz"); break;		\
 	case 8: __get_user_asm2(x, ptr, retval); break;			\
-	default: (x) = __get_user_bad();				\
+	default: (x) = (__typeof__(*(ptr)))__get_user_bad();		\
 	}								\
 } while (0)
 
 #define __get_user_asm(x, addr, err, op)		\
+{							\
+	unsigned long __gu_tmp;				\
 	__asm__ __volatile__(				\
 		"1:	"op" %1,0(%2)\n"		\
 		"2:\n"					\
@@ -209,10 +211,14 @@ do {									\
 		"	.align 2\n"			\
 		"	.long 1b,3b\n"			\
 		".previous"				\
-		: "=r"(err), "=r"(x)			\
-		: "r"(addr), "i"(-EFAULT), "0"(err))
+		: "=r"(err), "=r"(__gu_tmp)		\
+		: "r"(addr), "i"(-EFAULT), "0"(err));	\
+	(x) = (__typeof__(*(addr)))__gu_tmp;		\
+}
 
 #define __get_user_asm2(x, addr, err)			\
+{							\
+	unsigned long long __gu_tmp;			\
 	__asm__ __volatile__(				\
 		"1:	l.lwz %1,0(%2)\n"		\
 		"2:	l.lwz %H1,4(%2)\n"		\
@@ -229,8 +235,11 @@ do {									\
 		"	.long 1b,4b\n"			\
 		"	.long 2b,4b\n"			\
 		".previous"				\
-		: "=r"(err), "=&r"(x)			\
-		: "r"(addr), "i"(-EFAULT), "0"(err))
+		: "=r"(err), "=&r"(__gu_tmp)		\
+		: "r"(addr), "i"(-EFAULT), "0"(err));	\
+	(x) = (__typeof__(*(addr)))(			\
+		(__typeof__((x)-(x)))__gu_tmp);		\
+}
 
 /* more complex routines */
 
-- 
2.26.2

