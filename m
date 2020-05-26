Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2E9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB72820776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVjFVak2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbgEZMV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 08:21:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31041 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbgEZMV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 08:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590495718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=soLiUMo1lnFMwt1Vi+a2BILbN4jeczbvV9zPKest7O4=;
        b=jVjFVak2lisq2YxjUt96Ycb3eEgXc4tdRjy6q1hhODXsyN95qvdrzXjFHJBrMYkOcM/vJz
        ePgi8/yxsLfd9K1q8v8JF6ycyhOQ8wpguGfs3sguHJKpKqrqRZpDrhFM1fLdXP+CA8oI1a
        E/G0MlVHX8n5q6TPMbLQTwdGPBwyE5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-UVGk70JiOa6mSY0lpXqE5w-1; Tue, 26 May 2020 08:21:54 -0400
X-MC-Unique: UVGk70JiOa6mSY0lpXqE5w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6B391005510;
        Tue, 26 May 2020 12:21:52 +0000 (UTC)
Received: from llong.com (ovpn-115-53.rdu2.redhat.com [10.10.115.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76C827A8A0;
        Tue, 26 May 2020 12:21:48 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH] x86, spinlock: Remove obsolete ticket spinlock macros and types
Date:   Tue, 26 May 2020 08:20:14 -0400
Message-Id: <20200526122014.25241-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though the x86 ticket spinlock code has been removed in the
commit cfd8983f03c7 ("x86, locking/spinlocks: Remove ticket (spin)lock
implementation") a while ago, there are still some ticket spinlock
specific macros and types left in the asm/spinlock_types.h header file
that are no longer used. Remove those as well to avoid confusion.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/include/asm/spinlock_types.h | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/x86/include/asm/spinlock_types.h b/arch/x86/include/asm/spinlock_types.h
index bf3e34b25afc..323db6c5852a 100644
--- a/arch/x86/include/asm/spinlock_types.h
+++ b/arch/x86/include/asm/spinlock_types.h
@@ -3,29 +3,7 @@
 #define _ASM_X86_SPINLOCK_TYPES_H
 
 #include <linux/types.h>
-
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-#define __TICKET_LOCK_INC	2
-#define TICKET_SLOWPATH_FLAG	((__ticket_t)1)
-#else
-#define __TICKET_LOCK_INC	1
-#define TICKET_SLOWPATH_FLAG	((__ticket_t)0)
-#endif
-
-#if (CONFIG_NR_CPUS < (256 / __TICKET_LOCK_INC))
-typedef u8  __ticket_t;
-typedef u16 __ticketpair_t;
-#else
-typedef u16 __ticket_t;
-typedef u32 __ticketpair_t;
-#endif
-
-#define TICKET_LOCK_INC	((__ticket_t)__TICKET_LOCK_INC)
-
-#define TICKET_SHIFT	(sizeof(__ticket_t) * 8)
-
 #include <asm-generic/qspinlock_types.h>
-
 #include <asm-generic/qrwlock_types.h>
 
 #endif /* _ASM_X86_SPINLOCK_TYPES_H */
-- 
2.18.1

