Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC37C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B025D206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqA7xGFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbgEVXLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 19:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731117AbgEVXLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 19:11:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495A1C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 16:11:12 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u22so4995880plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 16:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XwLJSYwASLEYgULcmxjHMYHm0gclCEZFExWcoADNDfk=;
        b=iqA7xGFH7nRzZSARF8J/6I87gXVGh2PeDk3JEKv2iZubsvfzUBXuI4+LMaQN/t5r73
         GxdIq3VmZYudQHfuCUBKXnoOEGklNrGsoBld+BCQJuSPZ5puYurVTAtOvqGVEizDcfnO
         dKZUzJA5p+9vV8xarJqChzjMdOUsTQnJzK3J9QWkk54jp7awFsugw4+nAjBNMkZT1rOp
         RAxAprQIszHXmayLMUAMIb7XqpQYhRwbqmJR69p7VJ56HF3l4Eoa4NSFxfSeS7TSjcHp
         4jMlmdQt34zQIhx5j8tuLcqneY31xwXOV+gzEpToqFrpH5koOfnGUMO/ZhzDvR6bv94X
         XJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XwLJSYwASLEYgULcmxjHMYHm0gclCEZFExWcoADNDfk=;
        b=Blqg8lYeU7VXqudaj+wx5UDG5dw73KQHpUTo6dLSNlDc91WXSe4LtL5ePEJn5aOd20
         5goY4a+t2QhY1KxZvhelQN76oKgxVg1v4Rv4vMntoqfbBtBSPbHFcMLv9GpXQ6YAvW6d
         ABjeuXDn1kHKzqscxOlGn07+EXKwHj3/rK+4LKKEZMZ3j62fGntAt44FByHs7NtI17cX
         P/oXy51nSRHT7bMxkRXwLhRLiBRPRUuRHN/mZKU2Pb8222U7z6s7N0UNDISSgnY3UKyA
         AqpPHntDClXdelOhdlT8F5qLT0D2XPQS+HG/WQXsgtnMZZk3uIHgrCV84pohZAbNeCAM
         Ikzg==
X-Gm-Message-State: AOAM533iBPt2qLHi1tAqgYCdWdo/xW/Kf+uaSID63fSQ6W0uXJI8pU5L
        vFO8B9zn8VQR7TWquvT9tRzKoyvk
X-Google-Smtp-Source: ABdhPJzWH+H30rB22gfRPrtAIbrZkJvP48IdUiW2B/+G2yBfRKCZi6tlnmd0/ESwRg3CPpeax+pm0Q==
X-Received: by 2002:a17:90a:ce17:: with SMTP id f23mr7495181pju.51.1590189071893;
        Fri, 22 May 2020 16:11:11 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:e00:d0d2:96ff:22ac:b8e6])
        by smtp.gmail.com with ESMTPSA id b24sm7454401pfi.4.2020.05.22.16.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:11:11 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: fix error paths in __get_user_{check,size}
Date:   Fri, 22 May 2020 16:10:56 -0700
Message-Id: <20200522231056.27879-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error paths in __get_user_check and __get_user_size directly assing 0 to
the result. It causes the following sparse warnings:

  sparse: warning: Using plain integer as NULL pointer

Convert 0 to the type pointed to by the user pointer before assigning it.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/uaccess.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index 445bb4cf3c28..0fd9b4086ae2 100644
--- a/arch/xtensa/include/asm/uaccess.h
+++ b/arch/xtensa/include/asm/uaccess.h
@@ -184,7 +184,7 @@ __asm__ __volatile__(					\
 	if (access_ok(__gu_addr, size))					\
 		__get_user_size((x), __gu_addr, (size), __gu_err);	\
 	else								\
-		(x) = 0;						\
+		(x) = (__typeof__(*(ptr)))0;				\
 	__gu_err;							\
 })
 
@@ -202,13 +202,15 @@ do {									\
 		u64 __x;						\
 		if (unlikely(__copy_from_user(&__x, ptr, 8))) {		\
 			retval = -EFAULT;				\
-			(x) = 0;					\
+			(x) = (__typeof__(*(ptr)))0;			\
 		} else {						\
 			(x) = *(__force __typeof__(*(ptr)) *)&__x;	\
 		}							\
 		break;							\
 	}								\
-	default: (x) = 0; __get_user_bad();				\
+	default:							\
+		(x) = (__typeof__(*(ptr)))0;				\
+		__get_user_bad();					\
 	}								\
 } while (0)
 
-- 
2.20.1

