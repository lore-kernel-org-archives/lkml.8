Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A222CC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6449F24677
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKY3nWz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgBLUNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:13:05 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:42972 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBLUNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:13:05 -0500
Received: by mail-il1-f195.google.com with SMTP id x2so2871732ila.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=hRyzGKLbru+GVibzqSI+tf4K6tKv1T5KHUBTcqBIqNw=;
        b=rKY3nWz6c7K6iRwc8S/4CbOATqBxUwb6UC1nfumo2Q9SxdkSrM2yBYoR+j9LHkkM58
         GuA0ltgHs6lbYiVwNFsy2kkD/Mc2ihcKdG/b9sReXieDqQ8JCddK8prkgjhbPTwsv2kM
         70hU1lA96LYLQ1lcrRUObYZznvcOCAc37Yz7H1J4n7NSy77QrI6IkhOYWmDpvYVWSb+o
         E2pVpNytH7aILjKIWJ48WvaebSvErMea1O2Wg5nfmwPaWeFI+WcyVUT1BZ82Bx7P7ZZ4
         r3zAptDz0HzKsdTIecBeSMxAnCHZEDSd5vXck+EjpBTb9qfXFoSMahLzRwSTc74RBqMG
         xU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=hRyzGKLbru+GVibzqSI+tf4K6tKv1T5KHUBTcqBIqNw=;
        b=LivzXpLLdL5lLwGzk+y61dr+fNoX+MQCEWhn0Fo0RzzNX57tFnFwCnaxbxg2HQri5w
         xyIBlMNctuswsKv6kdEjVIhU8QMQ21piHAtnfuEniRA9PC5lqzfG4UZ+YeaxWZyWxsgH
         x9m+g0rxt7x2SYzD0zTALDCE+2byMoJjn6r1JI3T6ZnauHF0lXs5ojqHjwLhtT831Dnn
         u1AcA8tCHE/og/q3yEz9ddHRnn5Mw2zUBA+Libd0quKKTf36nvMwH6nA4UKD7cQN0zyc
         aC/1oEdOjeiphqTJmYqzfb6tlO6HSFIfj2ZGgrPuXAK1alk16UnoDMhKc9Dylf7JNVVE
         8t5A==
X-Gm-Message-State: APjAAAV9gNiE0uBT+tDmDClL081CdYpzYIpm0iJqMrSJOYpY7NFyHcFu
        aKlVmZVTNG9z+pgBTvbF2cs=
X-Google-Smtp-Source: APXvYqz1tylTf+OQ7h+CQkKCv2u73K6P40XQqhzZcn/SjSsr1hYGsmxUTYr13cBKXe7MVbUM6A3wGg==
X-Received: by 2002:a92:8656:: with SMTP id g83mr13252186ild.9.1581538384126;
        Wed, 12 Feb 2020 12:13:04 -0800 (PST)
Received: from tzanussi-mobl ([2601:246:3:ceb0:468:9cb0:2637:feaf])
        by smtp.googlemail.com with ESMTPSA id h6sm42695iom.43.2020.02.12.12.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 12:13:03 -0800 (PST)
Message-ID: <1581538382.25773.5.camel@gmail.com>
Subject: [PATCH v2] tracing: Remove bogus 64-bit synth_event_trace() vararg
 assumption
From:   Tom Zanussi <tzanussi@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Date:   Wed, 12 Feb 2020 14:13:02 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vararg code in synth_event_trace() assumed the args were 64 bit
which is not the case on 32-bit systems.  Just use long which should
work on every system.

Also remove all the u64 casts from the synth event test module, which
also cause compile warnings on 32-bit compiles.

This fixes the bug reported by the kernel test robot/Rong Chen as
reported here:

https://lore.kernel.org/lkml/20200212113444.GS12867@shao2-debian/

With this commit, the lkp-tests tests now pass, as do the synth/kprobe
event test modules and selftests on x86_64.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/synth_event_gen_test.c | 24 ++++++++++++------------
 kernel/trace/trace_events_hist.c    |  6 +++---
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
index 4aefe003cb7c..f0e14106048c 100644
--- a/kernel/trace/synth_event_gen_test.c
+++ b/kernel/trace/synth_event_gen_test.c
@@ -111,11 +111,11 @@ static int __init test_gen_synth_cmd(void)
 	/* Create some bogus values just for testing */
 
 	vals[0] = 777;			/* next_pid_field */
-	vals[1] = (u64)"hula hoops";	/* next_comm_field */
+	vals[1] = (long)"hula hoops";	/* next_comm_field */
 	vals[2] = 1000000;		/* ts_ns */
 	vals[3] = 1000;			/* ts_ms */
 	vals[4] = smp_processor_id();	/* cpu */
-	vals[5] = (u64)"thneed";	/* my_string_field */
+	vals[5] = (long)"thneed";	/* my_string_field */
 	vals[6] = 598;			/* my_int_field */
 
 	/* Now generate a gen_synth_test event */
@@ -218,11 +218,11 @@ static int __init test_empty_synth_event(void)
 	/* Create some bogus values just for testing */
 
 	vals[0] = 777;			/* next_pid_field */
-	vals[1] = (u64)"tiddlywinks";	/* next_comm_field */
+	vals[1] = (long)"tiddlywinks";	/* next_comm_field */
 	vals[2] = 1000000;		/* ts_ns */
 	vals[3] = 1000;			/* ts_ms */
 	vals[4] = smp_processor_id();	/* cpu */
-	vals[5] = (u64)"thneed_2.0";	/* my_string_field */
+	vals[5] = (long)"thneed_2.0";	/* my_string_field */
 	vals[6] = 399;			/* my_int_field */
 
 	/* Now trace an empty_synth_test event */
@@ -290,11 +290,11 @@ static int __init test_create_synth_event(void)
 	/* Create some bogus values just for testing */
 
 	vals[0] = 777;			/* next_pid_field */
-	vals[1] = (u64)"tiddlywinks";	/* next_comm_field */
+	vals[1] = (long)"tiddlywinks";	/* next_comm_field */
 	vals[2] = 1000000;		/* ts_ns */
 	vals[3] = 1000;			/* ts_ms */
 	vals[4] = smp_processor_id();	/* cpu */
-	vals[5] = (u64)"thneed";	/* my_string_field */
+	vals[5] = (long)"thneed";	/* my_string_field */
 	vals[6] = 398;			/* my_int_field */
 
 	/* Now generate a create_synth_test event */
@@ -330,7 +330,7 @@ static int __init test_add_next_synth_val(void)
 		goto out;
 
 	/* next_comm_field */
-	ret = synth_event_add_next_val((u64)"slinky", &trace_state);
+	ret = synth_event_add_next_val((long)"slinky", &trace_state);
 	if (ret)
 		goto out;
 
@@ -350,7 +350,7 @@ static int __init test_add_next_synth_val(void)
 		goto out;
 
 	/* my_string_field */
-	ret = synth_event_add_next_val((u64)"thneed_2.01", &trace_state);
+	ret = synth_event_add_next_val((long)"thneed_2.01", &trace_state);
 	if (ret)
 		goto out;
 
@@ -396,12 +396,12 @@ static int __init test_add_synth_val(void)
 	if (ret)
 		goto out;
 
-	ret = synth_event_add_val("next_comm_field", (u64)"silly putty",
+	ret = synth_event_add_val("next_comm_field", (long)"silly putty",
 				  &trace_state);
 	if (ret)
 		goto out;
 
-	ret = synth_event_add_val("my_string_field", (u64)"thneed_9",
+	ret = synth_event_add_val("my_string_field", (long)"thneed_9",
 				  &trace_state);
 	if (ret)
 		goto out;
@@ -424,11 +424,11 @@ static int __init test_trace_synth_event(void)
 	/* Trace some bogus values just for testing */
 	ret = synth_event_trace(create_synth_test, 7,	/* number of values */
 				444,			/* next_pid_field */
-				(u64)"clackers",	/* next_comm_field */
+				"clackers",		/* next_comm_field */
 				1000000,		/* ts_ns */
 				1000,			/* ts_ms */
 				smp_processor_id(),	/* cpu */
-				(u64)"Thneed",		/* my_string_field */
+				"Thneed",		/* my_string_field */
 				999);			/* my_int_field */
 	return ret;
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 483b3fd1094f..b8dd28f546d8 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1887,12 +1887,12 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 
 	va_start(args, n_vals);
 	for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
-		u64 val;
+		long val;
 
-		val = va_arg(args, u64);
+		val = va_arg(args, long);
 
 		if (state.event->fields[i]->is_string) {
-			char *str_val = (char *)(long)val;
+			char *str_val = (char *)val;
 			char *str_field = (char *)&state.entry->fields[n_u64];
 
 			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
-- 
2.14.1

