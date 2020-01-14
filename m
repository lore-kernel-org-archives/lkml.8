Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86600C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A01524658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SjtQKbTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgANUI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 15:08:57 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:53180 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726839AbgANUI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 15:08:56 -0500
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D3C6F406F9;
        Tue, 14 Jan 2020 20:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1579032536; bh=wjCdDOgqMcTow7rOK3qtHSf4KaODrAl2GNRfmy2/+is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SjtQKbTngrT3ska2dntdhM9s2u0knGXeuUobsuIq+6lVd6q/fNNSeBGZnaH95NTkZ
         TVq2B2D7Vxhux3LHvio/QJw5MCr/vSc27nNLtbSOtyUYW9R7xAxxZUdTcbgrIBmpTE
         QQk4osqd6NNEUCaRb1vZFye+nWoktKMOvSTEsiFAmeEKs3JrIVUcShEBAAACL2aDs3
         dh7vXux/M9re2CDAmuZ0YLMwvsRezR7CG2XymtlWBcd+oOsrYljL/q/ceabsBYnmiK
         J6aLksgzKT/zpigz9GdmDd4tYcxa3srMKfUPZAmWqML7C9zInWzgOWsvwlxOGcMpkx
         a82DXgyl2yqFg==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.25])
        by mailhost.synopsys.com (Postfix) with ESMTP id 51704A0097;
        Tue, 14 Jan 2020 20:08:55 +0000 (UTC)
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC 1/4] asm-generic/uaccess: don't define inline functions if noinline lib/* in use
Date:   Tue, 14 Jan 2020 12:08:43 -0800
Message-Id: <20200114200846.29434-2-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114200846.29434-1-vgupta@synopsys.com>
References: <20200114200846.29434-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 generic varaints of strncpy_from_user() / strnlen_user()
 (1). inline version in asm-generic/uaccess.h
 (2). optimized word-at-a-time version in lib/*

This patch disables #1 if #2 selected. This allows arches to continue
reusing asm-generic/uaccess.h for rest of code

This came up when switching ARC to generic word-at-a-time interface

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/asm-generic/uaccess.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index e935318804f8..74c14211377b 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -227,6 +227,7 @@ __strncpy_from_user(char *dst, const char __user *src, long count)
 }
 #endif
 
+#ifndef CONFIG_GENERIC_STRNCPY_FROM_USER
 static inline long
 strncpy_from_user(char *dst, const char __user *src, long count)
 {
@@ -234,6 +235,7 @@ strncpy_from_user(char *dst, const char __user *src, long count)
 		return -EFAULT;
 	return __strncpy_from_user(dst, src, count);
 }
+#endif
 
 /*
  * Return the size of a string (including the ending 0)
@@ -244,6 +246,7 @@ strncpy_from_user(char *dst, const char __user *src, long count)
 #define __strnlen_user(s, n) (strnlen((s), (n)) + 1)
 #endif
 
+#ifndef CONFIG_GENERIC_STRNLEN_USER
 /*
  * Unlike strnlen, strnlen_user includes the nul terminator in
  * its returned count. Callers should check for a returned value
@@ -255,6 +258,7 @@ static inline long strnlen_user(const char __user *src, long n)
 		return 0;
 	return __strnlen_user(src, n);
 }
+#endif
 
 /*
  * Zero Userspace
-- 
2.20.1

