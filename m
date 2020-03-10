Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0935C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3AD624691
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583838982;
	bh=LkriAOURqU9UOCmiyBps3rGhYSJ1TUjpiEHx7MunH1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Eey1xL7/Yr1imFz4YgtxgLrl9YVhC63smVN9gwfoR+IPuUZnxx0vyNfAnrA+vIYzl
	 t6FIj3JjObLsQurw2+uOlmNEIybY7FDJXbo2Hn0zkd6aNnv06Tw6WHtNiR87Gml53G
	 vd9iW2kKYx1aInXYDFqPtDCHExGZyiDEsZXXjx4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgCJLQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgCJLQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:16:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9739024699;
        Tue, 10 Mar 2020 11:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583838980;
        bh=LkriAOURqU9UOCmiyBps3rGhYSJ1TUjpiEHx7MunH1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMe6nUMBaScagEra0nKu5K+bWIyJYeumeGdIPns1pRXT/e/7rBWR/DE+TIoC0eQUh
         NhfCtg/Z03KNEQ/V12eRtOnFvNU6P/Nw7u/kv94BDmEZ2OhoqyfOlI7R2qQiBNo9kY
         aODtdiQYTsdL2OMyt8HycrOVQheH9bKnyo6Syjbo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/19] tools lib traceevent: Remove extra '\n' in print_event_time()
Date:   Tue, 10 Mar 2020 08:15:38 -0300
Message-Id: <20200310111551.25160-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200310111551.25160-1-acme@kernel.org>
References: <20200310111551.25160-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If the precision of print_event_time() is zero or greater than the
timestamp, it uses a different format. But that format had an extra new
line at the end, and caused the output to not look right:

cpus=2
           sleep-3946  [001]111264306005
: function:             inotify_inode_queue_event
           sleep-3946  [001]111264307158
: function:             __fsnotify_parent
           sleep-3946  [001]111264307637
: function:             inotify_dentry_parent_queue_event
           sleep-3946  [001]111264307989
: function:             fsnotify
           sleep-3946  [001]111264308401
: function:             audit_syscall_exit

Fixes: 38847db9740a ("libtraceevent, perf tools: Changes in tep_print_event_* APIs")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200303231852.6ab6882f@oasis.local.home
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index beaa8b8c08ff..e1bd2a93c6db 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5541,7 +5541,7 @@ static void print_event_time(struct tep_handle *tep, struct trace_seq *s,
 	if (p10 > 1 && p10 < time)
 		trace_seq_printf(s, "%5llu.%0*llu", time / p10, prec, time % p10);
 	else
-		trace_seq_printf(s, "%12llu\n", time);
+		trace_seq_printf(s, "%12llu", time);
 }
 
 struct print_event_type {
-- 
2.21.1

