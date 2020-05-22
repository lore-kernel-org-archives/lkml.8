Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5A9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA9920757
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mi6AGVnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbgEVVmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 17:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731033AbgEVVmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:42:14 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896AEC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:42:14 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j21so5602415pgb.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GCdpqksdEQ8eOMgD/HeQaMyUeYodk/YD8+VXvzwnuBg=;
        b=mi6AGVnD3HKGHYWtiQQx/i5gPZUL3dF201rW6+tZvS1caUZP1SHEv1C+N4m02hlIj9
         LIQn0k8d0q+WgZW+vFsVlgxnv4BFVK4JBtiZ2NuDJTUAyuqcnSNaWlKoMIVq2/qaO6ZC
         jOistPykwRXjN40NpVnhom96ljTid5YbZz/Zphfx1KsusvwUh8OBbI5SSmYoZ3xlQ8X0
         A3QiYAy/tD7AHCInVh1LjqnePq+tATpwigKlo9rspwW6OI8n4SnIMUD9MJgdAppFSErK
         4ffvOEaD+QjaI5ANjrm7xzwsCNLShc8cDDBbyA7INFk1Kt/w6m/CDx+30fWyljbPwIcR
         wjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GCdpqksdEQ8eOMgD/HeQaMyUeYodk/YD8+VXvzwnuBg=;
        b=BhVWUNYKUcL4O/6f3uCsNhJCsCnTe+eo7WXeejl8cTZcRElNHXiMpVuwxSKSN0490w
         VhLdJYLEs46aJZBjJq0ZToGjPd0AoUycnJF/Ir3q/AAGpOFajMH1ftb/++BXjna3uRLU
         9jFokThLOyNsSFiy2uJ3C0HV9BlDFgW2cQoabrnTG3hMGzlGlHgckzl6Br/GLou2nl7L
         GGP5EvFmQe1wFdJQi/KQzK6seQJH51V8ENU4AlSpGhirA0ZjSIiEKuzWMZsNuYul+Qw1
         cjtKWnW+SggAWaZnzXk/BbuKLCty9tA4lPaY9C3rqzZgbAyJVe315ij8XqKAOaIN1Whk
         xgjA==
X-Gm-Message-State: AOAM533TGik+VAy8NEdNsDxi67RAgE5mQabf6FcfY+fDQFTI+6sSgDHf
        dohIx15o0jyYOiepodkMLVk=
X-Google-Smtp-Source: ABdhPJxQZPeY6JoRt+dhKDmjnybyLwMEeNePFJElDiQpTLZWDm/LDxLF6ztcxWp5WMy9aHAZ7n+ZHQ==
X-Received: by 2002:a63:1103:: with SMTP id g3mr15688372pgl.206.1590183734186;
        Fri, 22 May 2020 14:42:14 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:e00:d0d2:96ff:22ac:b8e6])
        by smtp.gmail.com with ESMTPSA id 4sm7625098pff.18.2020.05.22.14.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 14:42:13 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 1/3] xtensa: add missing __user annotations to __{get,put}_user_check
Date:   Fri, 22 May 2020 14:41:51 -0700
Message-Id: <20200522214153.30163-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522214153.30163-1-jcmvbkbc@gmail.com>
References: <20200522214153.30163-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__get_user_check and __put_user_check use temporary pointer but don't
mark it as __user, resulting in sparse warnings:

  sparse: warning: incorrect type in initializer (different address spaces)
  sparse:    expected long *__pu_addr
  sparse:    got long [noderef] <asn:1> *ret

  sparse: warning: incorrect type in argument 1 (different address spaces)
  sparse:    expected void [noderef] <asn:1> *to
  sparse:    got long *__pu_addr

Add __user annotation to temporary pointer in __get_user_check and
__put_user_check.

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index 47b7702aaa40..754a7c96b9da 100644
--- a/arch/xtensa/include/asm/uaccess.h
+++ b/arch/xtensa/include/asm/uaccess.h
@@ -84,7 +84,7 @@ extern long __put_user_bad(void);
 #define __put_user_check(x, ptr, size)					\
 ({									\
 	long __pu_err = -EFAULT;					\
-	__typeof__(*(ptr)) *__pu_addr = (ptr);				\
+	__typeof__(*(ptr)) __user *__pu_addr = (ptr);			\
 	if (access_ok(__pu_addr, size))			\
 		__put_user_size((x), __pu_addr, (size), __pu_err);	\
 	__pu_err;							\
@@ -180,7 +180,7 @@ __asm__ __volatile__(					\
 #define __get_user_check(x, ptr, size)					\
 ({									\
 	long __gu_err = -EFAULT;					\
-	const __typeof__(*(ptr)) *__gu_addr = (ptr);			\
+	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
 	if (access_ok(__gu_addr, size))					\
 		__get_user_size((x), __gu_addr, (size), __gu_err);	\
 	else								\
-- 
2.20.1

