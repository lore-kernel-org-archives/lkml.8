Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2646C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 21:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A3B8221E2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 21:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M0SB6Apg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3FcNCnQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgHNVZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 17:25:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39106 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgHNVZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 17:25:29 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597440327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+UPBM8vFr0h2/LYMrWplW6LR09KGF9bvBDV3GqNp6Os=;
        b=M0SB6Apg28/RJvVG/zdmLG2f4uh5MpqrDovNVofE/dMbAy6V83qYjumNZAwL7jzDUXvfDL
        mUJSk7Jt6FIoziKpY98uP4SMvLgs7MsIIsRnR1YKOMKu9USuIFvv63g/wFduYIh1Wpg2ja
        HonhAs3hP49MhnlAQ63LXwrUEm2/f4TwiwkJlVsLi0hzhakVV5hAbgHHlIyZ8rROnYTkU3
        jtZcYCcIiAoPQsvnYQ6oTMNizb9QY1t5aerpqjxFeMY7CJrX0q0tlnuudo9bWmtJveDhk6
        E2DEvS/AkLZF5Z4Of+eSEPys5IPKhYvea1Kg05vDOnCydlMXSx1ddxgusobndg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597440327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+UPBM8vFr0h2/LYMrWplW6LR09KGF9bvBDV3GqNp6Os=;
        b=3FcNCnQ+lOJUysUpQgMQmsYplakbmgnQFoEbhSw0IY7aaP/oA34Hh7fEA4afye0PdmBYhS
        xD1nldPhJU5e5lBQ==
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kieran Bingham <kbingham@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2][next] scripts/gdb: add utils.read_ulong()
Date:   Fri, 14 Aug 2020 23:31:24 +0206
Message-Id: <20200814212525.6118-2-john.ogness@linutronix.de>
In-Reply-To: <20200814212525.6118-1-john.ogness@linutronix.de>
References: <20200814212525.6118-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function for reading unsigned long values, which vary in size
depending on the architecture.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---

 based on next-20200814

 scripts/gdb/linux/utils.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/gdb/linux/utils.py b/scripts/gdb/linux/utils.py
index ea94221dbd39..ff7c1799d588 100644
--- a/scripts/gdb/linux/utils.py
+++ b/scripts/gdb/linux/utils.py
@@ -123,6 +123,13 @@ def read_u64(buffer, offset):
         return read_u32(buffer, offset + 4) + (read_u32(buffer, offset) << 32)
 
 
+def read_ulong(buffer, offset):
+    if get_long_type().sizeof == 8:
+        return read_u64(buffer, offset)
+    else:
+        return read_u32(buffer, offset)
+
+
 target_arch = None
 
 
-- 
2.20.1

