Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC5BC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 07:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBB3206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 07:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An9h9hQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgBAH2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 02:28:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44668 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgBAH2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 02:28:02 -0500
Received: by mail-pl1-f195.google.com with SMTP id d9so3714310plo.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 23:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2tdGWkxDgfXpnJAdtjaUc34vzgvsJbHdiM8yHvDQB98=;
        b=An9h9hQfzeqnBoTwBSP5knDHWbGL/U1hHk77g4T1UX3kn2zFWcnPMO/w3oPqJx1OSC
         3MTc+fotYOu4KzvnZsmbBhg0OIb5bD/i5sOMK7CZrNwwbtHLjDM1N9ash0OPM2fVQGjY
         y3BoNY72E6Y8r7zUvP7fJupd3th8pb48FR7gsfMnUksabJlOldo+RT+m3xqr3S01Of/y
         cB4ZzdziuTbhmwdhGoKfPLwNdIwGkL/2xUfn+eGn3hzK0irwV9cHNRhvwu3mTPofKujQ
         pdfnKcFA9WWbnqKg+LfxDmblvHrme7l1Fpeb96LY1SKoAYhmLZ8odC+sW91PfTxEoWl4
         3ApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2tdGWkxDgfXpnJAdtjaUc34vzgvsJbHdiM8yHvDQB98=;
        b=GNxbSJ1FhZ+7EY+TAudsLpIkmct+rT5R5LcS9sDGIwjqTVftrKiRzWQbgxbgoXFIWV
         0OLmj4FM3CgG4TgH5/SatcZdZIcKjauootw78lQs9CE5XwO+3XjNyTN4mvMqRXyXE22/
         pXIA44yhS//mKfrWCJ2Vy8V+D7f2htnYk4LIDVmK66ibVbtRzoARdNV3BppgWX35rhr1
         ZKRH2KQ+70ZVF7ZTpklhrPSfjDaRgWLKpRx/MzPnY/aBPIQAEL2YEp2757ghYWQZt3xU
         taXAkhtEF25tX8Xd0glb16swau5Eo7xx6PLvGf9gJfIH9n/Iuq3qh2b+z5JPuYvhK5sa
         BD3w==
X-Gm-Message-State: APjAAAX2rV83Zc8AoQfrHq2uxXPkso2QgS527d1Y26UisSa2Khonzeuf
        ASctwgb8lsWmf0uVSkHkZHM=
X-Google-Smtp-Source: APXvYqwygurwb6XxragQeU2J4nosucSvNpYi7cYLGA2BgmCX8lvjSlMaH85x8gA+KWF9nQu0yGWQUQ==
X-Received: by 2002:a17:90a:5d85:: with SMTP id t5mr17043821pji.126.1580542082014;
        Fri, 31 Jan 2020 23:28:02 -0800 (PST)
Received: from localhost.localdomain ([103.211.17.237])
        by smtp.googlemail.com with ESMTPSA id h7sm13240735pfq.36.2020.01.31.23.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 23:28:01 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] tracing: Annotate ftrace_graph_hash pointer with __rcu
Date:   Sat,  1 Feb 2020 12:57:04 +0530
Message-Id: <20200201072703.17330-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following instances of sparse error
kernel/trace/ftrace.c:5664:29: error: incompatible types in comparison
kernel/trace/ftrace.c:5785:21: error: incompatible types in comparison
kernel/trace/ftrace.c:5864:36: error: incompatible types in comparison
kernel/trace/ftrace.c:5866:25: error: incompatible types in comparison

Use rcu_dereference_protected to access the __rcu annotated pointer.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 kernel/trace/ftrace.c | 2 +-
 kernel/trace/trace.h  | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9bf1f2cd515e..959ded08dc13 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5596,7 +5596,7 @@ static const struct file_operations ftrace_notrace_fops = {
 
 static DEFINE_MUTEX(graph_lock);
 
-struct ftrace_hash *ftrace_graph_hash = EMPTY_HASH;
+struct ftrace_hash __rcu *ftrace_graph_hash = EMPTY_HASH;
 struct ftrace_hash *ftrace_graph_notrace_hash = EMPTY_HASH;
 
 enum graph_filter_type {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 63bf60f79398..97dad3326020 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -950,22 +950,25 @@ extern void __trace_graph_return(struct trace_array *tr,
 				 unsigned long flags, int pc);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-extern struct ftrace_hash *ftrace_graph_hash;
+extern struct ftrace_hash __rcu *ftrace_graph_hash;
 extern struct ftrace_hash *ftrace_graph_notrace_hash;
 
 static inline int ftrace_graph_addr(struct ftrace_graph_ent *trace)
 {
 	unsigned long addr = trace->func;
 	int ret = 0;
+	struct ftrace_hash *hash;
 
 	preempt_disable_notrace();
 
-	if (ftrace_hash_empty(ftrace_graph_hash)) {
+	hash = rcu_dereference_protected(ftrace_graph_hash, !preemptible());
+
+	if (ftrace_hash_empty(hash)) {
 		ret = 1;
 		goto out;
 	}
 
-	if (ftrace_lookup_ip(ftrace_graph_hash, addr)) {
+	if (ftrace_lookup_ip(hash, addr)) {
 
 		/*
 		 * This needs to be cleared on the return functions
-- 
2.24.1

