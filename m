Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3B3C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875AC2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMQDTlFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgBNGmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:42:50 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44554 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgBNGmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:42:50 -0500
Received: by mail-ot1-f68.google.com with SMTP id h9so8133833otj.11;
        Thu, 13 Feb 2020 22:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YK5ShLRmBFVIyNa+AVJi5WDxNZ4pgm/RjqjDGl1K0Lo=;
        b=YMQDTlFeh4hva6rNIzVXBqVTm1c39bdUSXB8ryOhtsvHgeuKjEedWyVnRSY2rRX0C2
         9Lu9Jj1Tq/Wdbi+rKZ2XkPrBRgGwdowBRXdaDfHratiEwgUkyNcGaO55hunh4zm3L8TI
         b6Fd0mL+Cr3Rpjziy1NejI/xA10rUt4OEj9YCuC+F/6gJL8DfIZ5N84Zx5vFZ6+Kb8st
         ON+kJXIJhVlPmD4gOOKAEkInrwMJKy5oZ7SpssOQa/3/ug9ZfrhQ3gGopWg0yIqy23cY
         FxlEjvVEEKKvg5hjBTTPozb12KHYRJC59VqsGVart6+EvjSivnza2/o4/HYE+ZB+PC3X
         K+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YK5ShLRmBFVIyNa+AVJi5WDxNZ4pgm/RjqjDGl1K0Lo=;
        b=mfgMP5xbzP+06I1dda5+6APAr9zaPWbWRUhBDBNyQRnQEcMzSMq452kt3eo37bRdZp
         fc3HfaTXgTsjPMzEMy1F1uy5Tba6wWZnBGHHz+KczBZTzwUj2AOlxE+A8nmPQ1T7tusi
         kHVGVtVvgKyfYUqCRDwFoYpWZQ7945cXlOs/XLxPrHCcAjhjM0lu+FvHRfBlrqECLdXK
         CFSv/Z2u7NWL74urF8Z6jKMcv28qnpC1um4S0KSZMPWhjWO92OQzxzledFZ0B7UuD0Sj
         2zDeUtCgj+U+umy3qnopkOKVeZkbD4bZKUbrjzb4uom7M9KKqShfFjrLWpmjMBJg/kJD
         Xg8Q==
X-Gm-Message-State: APjAAAXA9JIsW6R62hG4axj6x9GYKol2A1Yv692aANgwF7Zt0JhDLFqw
        3MWzo6KPlHqOMRI0G+k6XZ0=
X-Google-Smtp-Source: APXvYqxPcNZsS+ISpqHnhAKW0nNYtz5xPmotvlSYx1s8wc7rEhBhVszFUhInp2/iUgw2zb53roGb/g==
X-Received: by 2002:a05:6830:1e37:: with SMTP id t23mr1143253otr.16.1581662568064;
        Thu, 13 Feb 2020 22:42:48 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id m2sm1514544oim.13.2020.02.13.22.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 22:42:47 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] s390/mm: Explicitly compare PAGE_DEFAULT_KEY against zero in storage_key_init_range
Date:   Thu, 13 Feb 2020 23:42:07 -0700
Message-Id: <20200214064207.10381-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

 In file included from ../arch/s390/purgatory/purgatory.c:10:
 In file included from ../include/linux/kexec.h:18:
 In file included from ../include/linux/crash_core.h:6:
 In file included from ../include/linux/elfcore.h:5:
 In file included from ../include/linux/user.h:1:
 In file included from ../arch/s390/include/asm/user.h:11:
 ../arch/s390/include/asm/page.h:45:6: warning: converting the result of
 '<<' to a boolean always evaluates to false
 [-Wtautological-constant-compare]
         if (PAGE_DEFAULT_KEY)
            ^
 ../arch/s390/include/asm/page.h:23:44: note: expanded from macro
 'PAGE_DEFAULT_KEY'
 #define PAGE_DEFAULT_KEY        (PAGE_DEFAULT_ACC << 4)
                                                  ^
 1 warning generated.

Explicitly compare this against zero to silence the warning as it is
intended to be used in a boolean context.

Fixes: de3fa841e429 ("s390/mm: fix compile for PAGE_DEFAULT_KEY != 0")
Link: https://github.com/ClangBuiltLinux/linux/issues/860
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/s390/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 85e944f04c70..1019efd85b9d 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -42,7 +42,7 @@ void __storage_key_init_range(unsigned long start, unsigned long end);
 
 static inline void storage_key_init_range(unsigned long start, unsigned long end)
 {
-	if (PAGE_DEFAULT_KEY)
+	if (PAGE_DEFAULT_KEY != 0)
 		__storage_key_init_range(start, end);
 }
 
-- 
2.25.0

