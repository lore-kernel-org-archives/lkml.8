Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4E5C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C355A20CC7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dYQcBCM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgDITgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:36:07 -0400
Received: from mail.efficios.com ([167.114.26.124]:47244 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgDITgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:36:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C2231280F71;
        Thu,  9 Apr 2020 15:36:03 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lC_i8lCrEUZf; Thu,  9 Apr 2020 15:36:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 579F7281090;
        Thu,  9 Apr 2020 15:35:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 579F7281090
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1586460959;
        bh=i7YJaBdodyswtMtM5mlqG58TPDPhAxSk6tVePqUUpaI=;
        h=From:To:Date:Message-Id;
        b=dYQcBCM9EQc2bIwBBMuXoSUxgn7aHD4t36A9Jmv62ymw4frKBGk9dFqlykdbU/1e3
         oxMQTjz3QSB1IV/QwNrMrF3x1GlErqgFy1+HEsejYb4791Odua4qhPEJHHPNhz//qJ
         5xa41CLfOCEJOTQw7uscpzE+XeGMve/vH3vV+uC68U2oHMI7Poj+99FLw/M631E/bm
         zZ3JJ/1zS5oHaqJJjEWA5LRCqmKjUK9rC45VKuX03vBM4cfylnvAAhv3dv0xaer5wH
         yJb1T8OKvP7SENEUO4LXqk0i9XlPgs8RgNfK08/T5B6z9BXNpa296kK6aHO9K+h4Z8
         A++4RrlcNu/fw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qGJct0Y9jzXT; Thu,  9 Apr 2020 15:35:59 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 6D36D28097B;
        Thu,  9 Apr 2020 15:35:58 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC PATCH 4/9] stacktrace: export-GPL stack_trace_save_user
Date:   Thu,  9 Apr 2020 15:35:38 -0400
Message-Id: <20200409193543.18115-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
References: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stack_trace_save symbol is already exported GPL. Add a GPL export
for the stack_trace_save_user symbol as well.

This is useful for tracers implemented as kernel modules.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
 kernel/stacktrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 2af66e449aa6..c8c48444bd39 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -240,6 +240,7 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
 
 	return c.len;
 }
+EXPORT_SYMBOL_GPL(stack_trace_save_user);
 #endif
 
 #else /* CONFIG_ARCH_STACKWALK */
-- 
2.17.1

