Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042D2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F5220786
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iEvtvxg0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vB3xOeJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgGGO7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgGGO7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:59:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC20C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:59:41 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594133979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W42dHyCRa8fXUYeFJuQuDMETLy5ADl16+A8/qW62pEs=;
        b=iEvtvxg0AshlWoTvWvS6Mpf4XzFKtjP8Hb3fuVbA+YXh1s/YWMRn27JhBCO6wsg4GC/Jw4
        zYENzUkYxySH+cOv6zVgKxp5K+wvyS3/PkWR5xTw8AUN5kXrFX4k1t+yY/Q3e7/FBh85aR
        KQmawGwFpP9NuxOv5nXCr+aukc5zpR6pzzf4vsth0cmp0WZslvfpbVjSq/Um1+9ZYx0ScZ
        TZ51zD57LtzDdVyMb+mG9Zqv43Z2JSf5ZkXd8Lz4Ap//ilJv00vA5K1owTnsbtKdQ8USIh
        F+Ngo7ogPWNS2GBr72SQVvI7rxKwvUFDZ3kOdPQjC2P73asTHYdVMSe5WoQUeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594133979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W42dHyCRa8fXUYeFJuQuDMETLy5ADl16+A8/qW62pEs=;
        b=vB3xOeJSc2U5GL8GWOfBVn0oYiHRwBGBu8gpZnHRZyTUF91gZstVpK/09CIHBgzkn5Lc4s
        6WVw4VENSq2S7vCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] crash: add VMCOREINFO macro to define offset in a struct declared by typedef
Date:   Tue,  7 Jul 2020 17:05:29 +0206
Message-Id: <20200707145932.8752-2-john.ogness@linutronix.de>
In-Reply-To: <20200707145932.8752-1-john.ogness@linutronix.de>
References: <20200707145932.8752-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing macro VMCOREINFO_OFFSET() can't be used for structures
declared via typedef because "struct" is not part of type definition.

Create another macro for this purpose.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/crash_core.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 525510a9f965..43b51c9df571 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -53,6 +53,9 @@ phys_addr_t paddr_vmcoreinfo_note(void);
 #define VMCOREINFO_OFFSET(name, field) \
 	vmcoreinfo_append_str("OFFSET(%s.%s)=%lu\n", #name, #field, \
 			      (unsigned long)offsetof(struct name, field))
+#define VMCOREINFO_TYPE_OFFSET(name, field) \
+	vmcoreinfo_append_str("OFFSET(%s.%s)=%lu\n", #name, #field, \
+			      (unsigned long)offsetof(name, field))
 #define VMCOREINFO_LENGTH(name, value) \
 	vmcoreinfo_append_str("LENGTH(%s)=%lu\n", #name, (unsigned long)value)
 #define VMCOREINFO_NUMBER(name) \
-- 
2.20.1

