Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ADEC35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B205F217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 14:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhgngSOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgBHOLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 09:11:09 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42848 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbgBHOLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 09:11:09 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so2053864otd.9;
        Sat, 08 Feb 2020 06:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cWwOu9a6Z1tLizrwqoz4gJCJrtA9tbQqyQC9xeUEbAk=;
        b=IhgngSOUWZuvS1yoCpBIkBgYZSyuHDMJxKhnvk+9BKkLidnOBtpGJ2UYyjuXV49rtx
         Y7QKwAzxZQHMYk1aOqyHV93VNWOd/cuOuh1zsHex5pBJnBP7Qz3qh1cwExoQfwGJwOnl
         AY4Fjocfx7JqExG7KllMr+Q8w4PzGI+fzGTheyLHi91hFNrEHKqpxhBOkFCX58ghhrZ7
         O5+Cv+qa2eqDfsZs+1NFITd/XiyY0eRNSfF96tSCDpSIuXjjS7qf3On2Ci20nGG0jKL3
         KwdYlEh54/XhY6ALIDTam4B9xD0+dQu9Tw8OaV5nqf+myj/cO2H5yG/4kbrrVzCH0rVn
         wAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cWwOu9a6Z1tLizrwqoz4gJCJrtA9tbQqyQC9xeUEbAk=;
        b=ebzIAw0F53vj7ygxlsEqd+2OM0ERdotPgGS8ddPILdVTkxvdzg7NTW9JTBBT+79pNI
         vQe90hVFZuenynlRgbhS4V7lumzRnlGyoTIAh6xKIHCEiadP/KalwgReuSVO+BCMwEa/
         ICHrUnlSCQLOa37/0ySyTlHKNZWMKo4antb0KTSjk1JQM9TzwJ7HQItW6EjmW1QXYEUP
         mDo0D1QQUTkCs9xJwCPJlBXuP2ZZ0iy0lx1dGrm5wDaP9JePIMRtUl4iI5M82ZwLs8bP
         g4rG04d8FGZe+NDi2Ftn5zneZgGnheO0dNcL92B7/PwE1ZKn5f6yW6H19eq4HAQ54GXW
         jU4Q==
X-Gm-Message-State: APjAAAU+gRnJnHv5PT0Zq2LJsXuATXPMp0N1vQ8p+aBrai675j1jun0h
        u1C5YAW35y3KQHDK+fQ4KSM=
X-Google-Smtp-Source: APXvYqweQ+tULOjiAGitJKPoVJw+WP/OV7bz5HFmJf3cwWIUuPUIDbrvec0qcD37tzw7hMVA9XlnNQ==
X-Received: by 2002:a9d:6212:: with SMTP id g18mr3705409otj.187.1581171068359;
        Sat, 08 Feb 2020 06:11:08 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id c36sm2294461otb.55.2020.02.08.06.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 06:11:08 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] s390/kaslr: Fix casts in get_random
Date:   Sat,  8 Feb 2020 07:10:52 -0700
Message-Id: <20200208141052.48476-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../arch/s390/boot/kaslr.c:78:25: warning: passing 'char *' to parameter
of type 'const u8 *' (aka 'const unsigned char *') converts between
pointers to integer
types with different sign [-Wpointer-sign]
                                  (char *) entropy, (char *) entropy,
                                                    ^~~~~~~~~~~~~~~~
../arch/s390/include/asm/cpacf.h:280:28: note: passing argument to
parameter 'src' here
                            u8 *dest, const u8 *src, long src_len)
                                                ^
2 warnings generated.

Fix the cast to match what else is done in this function.

Fixes: b2d24b97b2a9 ("s390/kernel: add support for kernel address space layout randomization (KASLR)")
Link: https://github.com/ClangBuiltLinux/linux/issues/862
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/s390/boot/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/boot/kaslr.c b/arch/s390/boot/kaslr.c
index 5d12352545c5..5591243d673e 100644
--- a/arch/s390/boot/kaslr.c
+++ b/arch/s390/boot/kaslr.c
@@ -75,7 +75,7 @@ static unsigned long get_random(unsigned long limit)
 		*(unsigned long *) prng.parm_block ^= seed;
 		for (i = 0; i < 16; i++) {
 			cpacf_kmc(CPACF_KMC_PRNG, prng.parm_block,
-				  (char *) entropy, (char *) entropy,
+				  (u8 *) entropy, (u8 *) entropy,
 				  sizeof(entropy));
 			memcpy(prng.parm_block, entropy, sizeof(entropy));
 		}
-- 
2.25.0

