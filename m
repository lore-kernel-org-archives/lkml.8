Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB41C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41832073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBSyQSvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgBUNNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:13:13 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36654 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbgBUNNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:13:13 -0500
Received: by mail-pj1-f68.google.com with SMTP id gv17so729745pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UbQxTmlwUjL4hXs0Xi9xVM9POyVCGX+Aqi2z6Y33gQA=;
        b=NBSyQSvTYaiixAkt5QZu3FBgwn3sBWN6s8shdlXAjlh56T0uNhqYp9jLfz1OjQWFA3
         dtBEVh2+OTbdiP5mm1HCjDE4evDYMd/Zejq2G84V9iTnQvcbns34cOQunASl9nW/HA9/
         +mZGWKPfbNMyZuCIEaENugwFBRzJklX89ktm/YzYCSrCcNtJTLBGXkAcq9sOUbQ+acUS
         Cj/4UVkLTDN7K+uraz0zba2FI0JeMI0d91jN+q6rPrl7lFPSOUmxZJ//Dv4LhZn0edJM
         6jSxDBjaFFgeM08pJaN29k1nvaTZkTzFbCWgVL8XIqeuGzRXyYFcUTIQK90QT6C5EmAz
         9t5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UbQxTmlwUjL4hXs0Xi9xVM9POyVCGX+Aqi2z6Y33gQA=;
        b=hK1iczf98mgyhPQeA8wezSQmx1ob7F9efeb30lb4vHDFEFcxKPLXBtUmqNGc6D1mJY
         vIrOWdEyV/JdjUdQmcUkt3wGaGtHPpk1biI8r5+EuT/xmp69FCXUim9QrAkDC5QTvJyE
         JKIqc4PxJ0yiXfgdPe1hAN/cDalvkf72tEpbRjKY63al07W/ZmuExeEHLkJeSSmVXUft
         oi8h9GTe2A6zjOTgMP0MzxtD63R+AP66bRrXIueGf7jJyNWoTUyx/tXg3ZDCp5+J6Cwb
         PqMYUv0K8XZgxAMsaesqe3UyfcA8SFLVcvFOt5e0GJuJ/3U3U98eL99hXQ1lTixFCQ94
         KMpw==
X-Gm-Message-State: APjAAAW9x5PiQyYNZDxX2hLFDkzu+7f1es+cfqTZyN0q9sUX8jGeJsaP
        09TNW5ViSuyFRL5PAXFtdOo=
X-Google-Smtp-Source: APXvYqwQPOX+P1cMTGcL6xKG3ROvJyAavuSznSzyzN+7ig0KWjx4cuqsSTDLLcERyQiU4MEMuQn8+Q==
X-Received: by 2002:a17:902:7e4b:: with SMTP id a11mr36084349pln.61.1582290792531;
        Fri, 21 Feb 2020 05:13:12 -0800 (PST)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id v8sm2793697pfn.172.2020.02.21.05.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 05:13:12 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] ftrace: Fix warning unused but set variables
Date:   Fri, 21 Feb 2020 21:13:08 +0800
Message-Id: <1582290788-4975-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some dead code, no real bugs.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/ftrace.c            | 6 ++----
 kernel/trace/trace_events_hist.c | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3f7ee10..ae26d8a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4108,7 +4108,6 @@ static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 	struct ftrace_hash **orig_hash, *new_hash;
 	LIST_HEAD(process_mods);
 	char *func;
-	int ret;
 
 	mutex_lock(&ops->func_hash->regex_lock);
 
@@ -4161,7 +4160,7 @@ static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 
 	mutex_lock(&ftrace_lock);
 
-	ret = ftrace_hash_move_and_update_ops(ops, orig_hash,
+	ftrace_hash_move_and_update_ops(ops, orig_hash,
 					      new_hash, enable);
 	mutex_unlock(&ftrace_lock);
 
@@ -5512,7 +5511,6 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 	struct ftrace_hash **orig_hash;
 	struct trace_parser *parser;
 	int filter_hash;
-	int ret;
 
 	if (file->f_mode & FMODE_READ) {
 		iter = m->private;
@@ -5540,7 +5538,7 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 			orig_hash = &iter->ops->func_hash->notrace_hash;
 
 		mutex_lock(&ftrace_lock);
-		ret = ftrace_hash_move_and_update_ops(iter->ops, orig_hash,
+		ftrace_hash_move_and_update_ops(iter->ops, orig_hash,
 						      iter->hash, filter_hash);
 		mutex_unlock(&ftrace_lock);
 	} else {
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 483b3fd..29ce522 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6549,12 +6549,11 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
 	struct trace_event_file *file;
 	unsigned int i;
 	char *cmd;
-	int ret;
 
 	for (i = 0; i < hist_data->n_field_var_hists; i++) {
 		file = hist_data->field_var_hists[i]->hist_data->event_file;
 		cmd = hist_data->field_var_hists[i]->cmd;
-		ret = event_hist_trigger_func(&trigger_hist_cmd, file,
+		event_hist_trigger_func(&trigger_hist_cmd, file,
 					      "!hist", "hist", cmd);
 	}
 }
-- 
1.8.3.1

