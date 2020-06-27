Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3C2C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 15:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30BB5218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 15:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQLB2DVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgF0PTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 11:19:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49456 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725975AbgF0PTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 11:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593271179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=pLA2ZYrXjaL3qNNgdGWEbBRjUO8cxQczAoaM3QLMn2M=;
        b=LQLB2DVLOmmWD9+IQjhgRTBbBwvNJMe3UJ3v1L6D3EGtMzFpenSgYFdLEpW6+adJ0KcfcI
        PvaHCA84HYQn0x36bS0FofeOrkwBmYBVMGTndETOZ4Ltl9DmFp1/tmMUm3zWjUfaiExc82
        UOhuoiWYblgkgf4TRM43HBUoo5aF09M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-poHTuCxmNM2kPa9fbnWUcg-1; Sat, 27 Jun 2020 11:19:30 -0400
X-MC-Unique: poHTuCxmNM2kPa9fbnWUcg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A2881085937;
        Sat, 27 Jun 2020 15:19:29 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF0E160BF4;
        Sat, 27 Jun 2020 15:19:14 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v9 07/11] signal_info: only print context if it is available.
Date:   Sat, 27 Jun 2020 11:18:07 -0400
Message-Id: <1593271091-30188-8-git-send-email-rgb@redhat.com>
In-Reply-To: <1593271091-30188-1-git-send-email-rgb@redhat.com>
References: <1593271091-30188-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 src/auditd-event.c    | 20 +++++++++++++++-----
 src/auditd-reconfig.c |  2 --
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/src/auditd-event.c b/src/auditd-event.c
index e6b2a961f02b..800f4d83bc83 100644
--- a/src/auditd-event.c
+++ b/src/auditd-event.c
@@ -1323,13 +1323,16 @@ static void reconfigure(struct auditd_event *e)
 	const char *ctx = nconf->sender_ctx;
 	struct timeval tv;
 	char txt[MAX_AUDIT_MESSAGE_LENGTH];
+	int txt_len;
 	char date[40];
 	unsigned int seq_num;
 	int need_size_check = 0, need_reopen = 0, need_space_check = 0;
 
-	snprintf(txt, sizeof(txt),
-		"config change requested by pid=%d auid=%u subj=%s",
-		pid, uid, ctx);
+	txt_len = snprintf(txt, sizeof(txt),
+		"config change requested by pid=%d auid=%u", pid, uid);
+	if (ctx)
+		snprintf(txt + txt_len, sizeof(txt) - txt_len,
+			 " subj=%s", ctx);
 	audit_msg(LOG_NOTICE, "%s", txt);
 
 	/* Do the reconfiguring. These are done in a specific
@@ -1578,8 +1581,15 @@ static void reconfigure(struct auditd_event *e)
 
 	e->reply.type = AUDIT_DAEMON_CONFIG;
 	e->reply.len = snprintf(e->reply.msg.data, MAX_AUDIT_MESSAGE_LENGTH-2, 
-	"%s: op=reconfigure state=changed auid=%u pid=%d subj=%s res=success",
-		date, uid, pid, ctx );
+				"%s: op=reconfigure state=changed auid=%u pid=%d",
+				date, uid, pid);
+	if (ctx)
+		e->reply.len += snprintf(e->reply.msg.data + e->reply.len,
+					 MAX_AUDIT_MESSAGE_LENGTH-2 - e->reply.len,
+					 " subj=%s", ctx);
+	e->reply.len += snprintf(e->reply.msg.data + e->reply.len,
+				 MAX_AUDIT_MESSAGE_LENGTH-2 - e->reply.len,
+				 " res=success");
 	e->reply.message = e->reply.msg.data;
 	free((char *)ctx);
 }
diff --git a/src/auditd-reconfig.c b/src/auditd-reconfig.c
index f5b00e6d1dc7..1af402526c4e 100644
--- a/src/auditd-reconfig.c
+++ b/src/auditd-reconfig.c
@@ -106,8 +106,6 @@ static void *config_thread_main(void *arg)
 		if (e->reply.len > 24)
 			new_config.sender_ctx = 
 				strdup(e->reply.signal_info->ctx);
-		else
-			new_config.sender_ctx = strdup("?"); 
 		memcpy(e->reply.msg.data, &new_config, sizeof(new_config));
 		e->reply.conf = (struct daemon_conf *)e->reply.msg.data;
 		e->reply.type = AUDIT_DAEMON_RECONFIG;
-- 
1.8.3.1

