Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3994CC34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102BB2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJ+37AVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgBRVBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:01:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52316 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726339AbgBRVBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582059676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=m+ygBrnWZowsoqkGOsRWCuWV30iRorVWTp4y42Mq020=;
        b=PJ+37AVmb99cjzSQcSffTqMcmbNIWLTBEFvMaRjEekjQYRWjO899XD8GX9v5YynDL2xlkT
        /8rX0CaQq6W1bmed6hEcvF1AxJaQBjXnliRXFnlRIs5mfKwVfbc1b83cd5SfoY2+148qIn
        slUiSwH1IA6bka17pdz++YhIuz+4LTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-x5_KBtwzOH2H-zOfbyzQfQ-1; Tue, 18 Feb 2020 16:01:12 -0500
X-MC-Unique: x5_KBtwzOH2H-zOfbyzQfQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0732D1084432;
        Tue, 18 Feb 2020 21:01:11 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-16.rdu2.redhat.com [10.10.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B9DA90F46;
        Tue, 18 Feb 2020 21:01:03 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>, sgrubb@redhat.com,
        omosnace@redhat.com, eparis@parisplace.org,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak120] audit: trigger accompanying records when no rules present
Date:   Tue, 18 Feb 2020 16:00:37 -0500
Message-Id: <e75e80e820f215d2311941e083580827f6c1dbb6.1582059594.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there are no audit rules registered, mandatory records (config,
etc.) are missing their accompanying records (syscall, proctitle, etc.).

This is due to audit context dummy set on syscall entry based on absence
of rules that signals that no other records are to be printed.

Clear the dummy bit in auditsc_set_stamp() when the first record of an
event is generated.

Please see upstream github issue
https://github.com/linux-audit/audit-kernel/issues/120

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 4effe01ebbe2..31195d122344 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2176,6 +2176,8 @@ int auditsc_get_stamp(struct audit_context *ctx,
 	t->tv_sec  = ctx->ctime.tv_sec;
 	t->tv_nsec = ctx->ctime.tv_nsec;
 	*serial    = ctx->serial;
+	if (ctx->dummy)
+		ctx->dummy = 0;
 	if (!ctx->prio) {
 		ctx->prio = 1;
 		ctx->current_state = AUDIT_RECORD_CONTEXT;
-- 
1.8.3.1

