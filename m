Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E951C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3805206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2po0GTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgAPNOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:14:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33521 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgAPNOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:14:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so9889614pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 05:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8c+LvOlIaXBLMpBu+gnW139ZMvxJSLj7Fg/MJCqoms=;
        b=L2po0GTmDJ8kR90DFOh/ufd71rYkip97frpzmNT+4HWbSrpk9rgxTNGMqUCcRFtgwh
         r1Tafq1gj5s6qiworHQmH9T3KZDpehOyMpwoHysEWNaYxpdgBHZ0pXnhyvkkPlo0ULA8
         Ymb/en+q9WIlBpDNAS3jCkNHGkL7e54559MhdO4Ws3tdc3EUOzeJubG6ebYtkNRqD0JU
         x3FdCcyLhtLmeIYSQQrb4mZgnQdL5Hds7U3ggWzI+7gFfcgcXy9YfzWoBM9qjIE5kJJg
         x+LiE4XXAXH0XHc7bv5vlEB6qbLnmhzTf1py/7zsiaUSXrvpR+x/XHAfp+VFbfpux8HN
         SL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8c+LvOlIaXBLMpBu+gnW139ZMvxJSLj7Fg/MJCqoms=;
        b=FQGeJ8b7KmAqTSMRXczN9gn8RBrvLM3l9aLj4KUAPbHrqo8BsjWzDNRZJDz/TWYF4Z
         ZokyPIRdmH8ImKfpsq64KrU59qBIfoEJR5YdvrugI1Z5E3TrX/oE3Mht+R5lFR8nyArv
         2dqfI7dc3HjUCaxjb5z0Oec5tXPgVvFAQgBHeQIPjtewpwANdOGeF48UUxGcipgSoU3+
         SZm7N9XfLgE0K9WSSDJ6/2AG0f9tY3aIbR79FyEgQo2RQxNfYxFIcZnWSSF+p5AjfUIX
         UFMI/7om4U195kxGIx21qG6LCAnO/QE/ZaMzvJY2vFZ9t8yaFEWqz2q8fGNZTfXYLBMT
         CCVQ==
X-Gm-Message-State: APjAAAVBq11lv9O93DKh/QRtAtRpS7rdG1OZef+LmFYJpBfNBVquKljX
        AcD+AG/Rfyh01uqRNwoW/9o=
X-Google-Smtp-Source: APXvYqzAypaL2sxdWeKyCLNpEMehnVOUJkoJt1EeQHh6z5nBl19q2TL95svpni6xR6jP3Y9kMEgJow==
X-Received: by 2002:a63:360a:: with SMTP id d10mr38192453pga.366.1579180441706;
        Thu, 16 Jan 2020 05:14:01 -0800 (PST)
Received: from localhost.localdomain (FL1-122-135-105-104.tky.mesh.ad.jp. [122.135.105.104])
        by smtp.gmail.com with ESMTPSA id g8sm25516092pfh.43.2020.01.16.05.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:14:00 -0800 (PST)
From:   Masami Ichikawa <masami256@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     Masami Ichikawa <masami256@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Do not set trace clock  if tracefs lockdown is in effect
Date:   Thu, 16 Jan 2020 22:12:36 +0900
Message-Id: <20200116131236.3866925-1-masami256@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200116094707.3846565-1-masami256@gmail.com>
References: <20200116094707.3846565-1-masami256@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trace_clock option is not set and unstable clcok detected,
tracing_set_default_clock() sets trace_clock(ThinkPad A285 is one of
case). In that case, if lockdown is in effect, null pointer
dereference error happens in ring_buffer_set_clock().

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1788488
Signed-off-by: Masami Ichikawa <masami256@gmail.com>
---
 kernel/trace/trace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ddb7e7f5fe8d..5b6ee4aadc26 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9420,6 +9420,11 @@ __init static int tracing_set_default_clock(void)
 {
 	/* sched_clock_stable() is determined in late_initcall */
 	if (!trace_boot_clock && !sched_clock_stable()) {
+		if (security_locked_down(LOCKDOWN_TRACEFS)) {
+			pr_warn("Can not set tracing clock due to lockdown\n");
+			return -EPERM;
+		}
+
 		printk(KERN_WARNING
 		       "Unstable clock detected, switching default tracing clock to \"global\"\n"
 		       "If you want to keep using the local clock, then add:\n"
-- 
2.24.1

