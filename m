Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CAFC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B86C21D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YD3e92xT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbgCJNVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:21:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30328 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731157AbgCJNVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583846463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=OWKLC6YFTswPrseeFy+IPkjasajYnHDmIwP6eT4uoEA=;
        b=YD3e92xT0y6G3pAd1AdUbbbLVzxUQ1rcK54TeNyjdT9OiyZm/b5OCrYGdqAGbUcSMoQQMD
        9mf0F0GrCqU3mhklZtu1DTQ54rWxYEVkE3HfIsYjXVgfEUMPxLzUAxF8hnuRiQc5x4F5Im
        LQzG0G60dXatcke0a5ymnANavExiXLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-zzPzheoIOOm5WmAtUd9nyA-1; Tue, 10 Mar 2020 09:20:59 -0400
X-MC-Unique: zzPzheoIOOm5WmAtUd9nyA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D142F107ACC9;
        Tue, 10 Mar 2020 13:20:57 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-16.rdu2.redhat.com [10.10.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F03948F363;
        Tue, 10 Mar 2020 13:20:50 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>, sgrubb@redhat.com,
        omosnace@redhat.com, eparis@parisplace.org,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH V2 ghak120] audit: trigger accompanying records when no rules present
Date:   Tue, 10 Mar 2020 09:20:17 -0400
Message-Id: <199b556aae531db6e08f2711b1751e976f8bd48a.1583801740.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there are no audit rules registered, mandatory records (config,
etc.) are missing their accompanying records (syscall, proctitle, etc.).

This is due to audit context dummy set on syscall entry based on absence
of rules that signals that no other records are to be printed.

Clear the dummy bit if any record is generated.

The proctitle context and dummy checks are pointless since the
proctitle record will not be printed if no syscall records are printed.

Please see upstream github issue
https://github.com/linux-audit/audit-kernel/issues/120

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
Chagelog:
v2:
- unconditionally clear dummy
- create audit_clear_dummy accessor function
- remove proctitle context and dummy checks
---
 kernel/audit.c   | 1 +
 kernel/audit.h   | 8 ++++++++
 kernel/auditsc.c | 3 ---
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 17b0d523afb3..b96331e1976d 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1798,6 +1798,7 @@ struct audit_buffer *audit_log_start(struct audit_context *ctx, gfp_t gfp_mask,
 	}
 
 	audit_get_stamp(ab->ctx, &t, &serial);
+	audit_clear_dummy(ab->ctx);
 	audit_log_format(ab, "audit(%llu.%03lu:%u): ",
 			 (unsigned long long)t.tv_sec, t.tv_nsec/1000000, serial);
 
diff --git a/kernel/audit.h b/kernel/audit.h
index 6fb7160412d4..2eed4d231624 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -290,6 +290,13 @@ extern bool audit_tree_match(struct audit_chunk *chunk,
 extern void audit_filter_inodes(struct task_struct *tsk,
 				struct audit_context *ctx);
 extern struct list_head *audit_killed_trees(void);
+
+static inline void audit_clear_dummy(struct audit_context *ctx)
+{
+	if (ctx)
+		ctx->dummy = 0;
+}
+
 #else /* CONFIG_AUDITSYSCALL */
 #define auditsc_get_stamp(c, t, s) 0
 #define audit_put_watch(w) {}
@@ -323,6 +330,7 @@ static inline int audit_signal_info_syscall(struct task_struct *t)
 }
 
 #define audit_filter_inodes(t, c) AUDIT_DISABLED
+#define audit_clear_dummy(c) {}
 #endif /* CONFIG_AUDITSYSCALL */
 
 extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 4effe01ebbe2..814406a35db1 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1406,9 +1406,6 @@ static void audit_log_proctitle(void)
 	struct audit_context *context = audit_context();
 	struct audit_buffer *ab;
 
-	if (!context || context->dummy)
-		return;
-
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_PROCTITLE);
 	if (!ab)
 		return;	/* audit_panic or being filtered */
-- 
1.8.3.1

