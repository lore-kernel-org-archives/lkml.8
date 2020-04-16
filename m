Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9AAC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06073214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587051271;
	bh=QbwX/cYzHyWzd67ry82iq9jNyfuA+lBj+qA600TsiTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q9uNi9PNCmaz7JpaO+u1KX8Zplm/O+9YY5IeD4h84StImTkJYVzwV/hOz6inzywSF
	 E3KZZ9FEjUrCGmMKsl1zgjaQ7ZjljDR8j2/1/0uGbIiim5+qMxGyaku9z31n5bGFRH
	 M/U3BtYjJhsg+6KHig8DTmNKW0yJrjUwJvNJRQ/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634972AbgDPPe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898238AbgDPNk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:40:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F8DC218AC;
        Thu, 16 Apr 2020 13:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044459;
        bh=QbwX/cYzHyWzd67ry82iq9jNyfuA+lBj+qA600TsiTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s/fnn7pcRduf6otexAv+VM498/y2wwNIhoJdolhDw+MncTyvSqqhqZFscO8rwZZ78
         4tOjUkMkEJIPPK7v9sW9u+JRR9zSJm4qC46JZ44/J6CbLs0mAeJKgSD5HOdBLeYjoM
         URNSNwx3ToUxQ2DC1egpUN/Dcbog5LieFR6iF3Rw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 5.5 226/257] ftrace/kprobe: Show the maxactive number on kprobe_events
Date:   Thu, 16 Apr 2020 15:24:37 +0200
Message-Id: <20200416131354.086051025@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 6a13a0d7b4d1171ef9b80ad69abc37e1daa941b3 upstream.

Show maxactive parameter on kprobe_events.
This allows user to save the current configuration and
restore it without losing maxactive parameter.

Link: http://lkml.kernel.org/r/4762764a-6df7-bc93-ed60-e336146dce1f@gmail.com
Link: http://lkml.kernel.org/r/158503528846.22706.5549974121212526020.stgit@devnote2

Cc: stable@vger.kernel.org
Fixes: 696ced4fb1d76 ("tracing/kprobes: expose maxactive for kretprobe in kprobe_events")
Reported-by: Taeung Song <treeze.taeung@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_kprobe.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -918,6 +918,8 @@ static int trace_kprobe_show(struct seq_
 	int i;
 
 	seq_putc(m, trace_kprobe_is_return(tk) ? 'r' : 'p');
+	if (trace_kprobe_is_return(tk) && tk->rp.maxactive)
+		seq_printf(m, "%d", tk->rp.maxactive);
 	seq_printf(m, ":%s/%s", trace_probe_group_name(&tk->tp),
 				trace_probe_name(&tk->tp));
 


