Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFCBC55192
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317C320704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587639689;
	bh=LPUFDnaEZF2l1RkEHwVDFsiBQqERKmfkjf3KsmGh1FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qQFqrAJ/j1aK5U2kwbJ/sEeiOBLNPq6erPGFhJjO6g/0AXvFww07iD6Psl7iwFDPF
	 JEtDIGqMq0+ybohEYy+8AO9oKiHXQAKT8uWNA1RUzgjPSJXOuZwOCGmYMGsKbZ5lXS
	 0wYoy46OQiswtdrrFLfB3YR+nh8Uu5HR7/fumvys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgDWLB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:01:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbgDWLB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:01:27 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB3CB20704;
        Thu, 23 Apr 2020 11:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587639686;
        bh=LPUFDnaEZF2l1RkEHwVDFsiBQqERKmfkjf3KsmGh1FE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LXYQ5a6iAfaU2fBIed8HcEl+jU25cEE2u9V2J2eUOs/XFnQGqLH2RH2OrxDdHkSna
         StIliHYwhfSzA/INtZuTq13Yqb8/3F5BOqqlp40JSEvq8YmAt9kjJybpfpArKcl3Yi
         LrKrRleI2XVUsHgiqPMlGdh75TAfllPVgWDwGkU8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: [PATCH 3/3] perf-probe: Do not show the skipped events
Date:   Thu, 23 Apr 2020 20:01:22 +0900
Message-Id: <158763968263.30755.12800484151476026340.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158763965400.30755.14484569071233923742.stgit@devnote2>
References: <158763965400.30755.14484569071233923742.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a probe point is expanded to several places (like inlined) and
if some of them are skipped because of blacklisted or __init function,
those trace_events has no event name. It must be skipped while showing
results.

Without this fix, you can see "(null):(null)" on the list,
===========
  # ./perf probe request_resource
  reserve_setup is out of .text, skip it.
  Added new events:
    (null):(null)        (on request_resource)
    probe:request_resource (on request_resource)

  You can now use it in all perf tools, such as:

  	perf record -e probe:request_resource -aR sleep 1

===========

With this fix, it is ignored.
===========
  # ./perf probe request_resource
  reserve_setup is out of .text, skip it.
  Added new events:
    probe:request_resource (on request_resource)

  You can now use it in all perf tools, such as:

  	perf record -e probe:request_resource -aR sleep 1

===========

Fixes: 5a51fcd1f30c ("perf probe: Skip kernel symbols which is out of .text")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 tools/perf/builtin-probe.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 70548df2abb9..6b1507566770 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -364,6 +364,9 @@ static int perf_add_probe_events(struct perf_probe_event *pevs, int npevs)
 
 		for (k = 0; k < pev->ntevs; k++) {
 			struct probe_trace_event *tev = &pev->tevs[k];
+			/* Skipped events have no event name */
+			if (!tev->event)
+				continue;
 
 			/* We use tev's name for showing new events */
 			show_perf_probe_event(tev->group, tev->event, pev,

