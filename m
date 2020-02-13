Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF44C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC18218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581632221;
	bh=GC3o1L9Dy/ZR1bFVYqPjewkxO9dcs3UD4eXhs4w5UMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=jNtZqDaZ/cacC/VHxL0seMjJkZ7IPA1ye/JmCQ7x0Rv4pO0AzdCmULEIiYp9ZjtTN
	 Cz31WIJujSyHfOphI9eOX32GnFwX8ExzwnYl7neWQs7IZ+kavzWv7b4Bsixyv6jBoI
	 +zs4cqdLBS+CjeX4FO38tR8eBgJ10WuewJtjJ+Wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgBMWRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:17:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:58832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgBMWQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:16:57 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9374621734;
        Thu, 13 Feb 2020 22:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581632217;
        bh=GC3o1L9Dy/ZR1bFVYqPjewkxO9dcs3UD4eXhs4w5UMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=FayMhEqIvwRftuAdTfe54aMcWL5PN0W1EYQ+OW4Akde8WJ+RyZDBBb8VF/0i6+lDE
         LoQy3hiOSLWAuOOHlrt0TRkxH3/yoSZWryl4OZTmtr0tmMM8oh3Ua3Zyvv7bsdqWDb
         ESApZjb+2GX1sEbLzVF1AEZ8YLD7clGzFYxf+YQ4=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] tracing: Check that number of vals matches number of synth  event fields
Date:   Thu, 13 Feb 2020 16:16:45 -0600
Message-Id: <2643328537a8f753c1018b1f4d1128e87ed8f043.1581630377.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1581630377.git.zanussi@kernel.org>
References: <cover.1581630377.git.zanussi@kernel.org>
In-Reply-To: <cover.1581630377.git.zanussi@kernel.org>
References: <cover.1581630377.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7276531d4036('tracing: Consolidate trace() functions')
inadvertently dropped the synth_event_trace() and
synth_event_trace_array() checks that verify the number of values
passed in matches the number of fields in the synthetic event being
traced, so add them back.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 913760d2d505..d931f1404505 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1885,6 +1885,9 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 		return ret;
 	}
 
+	if (n_vals != state.event->n_fields)
+		return -EINVAL;
+
 	va_start(args, n_vals);
 	for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
 		u64 val;
@@ -1960,6 +1963,9 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 		return ret;
 	}
 
+	if (n_vals != state.event->n_fields)
+		return -EINVAL;
+
 	for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
 		if (state.event->fields[i]->is_string) {
 			char *str_val = (char *)(long)vals[i];
-- 
2.14.1

