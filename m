Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD17C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B0821655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780038;
	bh=Ens5UUpjWtivdK8yQTqbbZLKVP6iDjs3ochWH2LfmWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zNTqZw3mQw9FC1i+hVpPQwS7YHr+p+aL+jmVNyPxUY43xi2STZWxbnWgezNvqPH22
	 aOaTVKq0PGyVjB5FZ4q/CjMCWtq2jlEwAkePmt/tX0zfnUCa8zuFVODlNGTv6LYlB5
	 FedNk8WA5jm5RooIUoJFtFwdrLEkhURDq+BbNh0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgCISx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727574AbgCISxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:53:54 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71B17215A4;
        Mon,  9 Mar 2020 18:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780034;
        bh=Ens5UUpjWtivdK8yQTqbbZLKVP6iDjs3ochWH2LfmWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RkDSHxihYSYqqa9yjvffCM7ZwKjRV6ubGmf5oHxNDsTRjZaHs9HKLwnyMACGLHSgd
         jn3UvE01otRpSmR0bRNuw60P/P+mWDhaS4df0cWGFRjV8CmHTVDCiz356hLi3QxUsg
         zd5hbZ/bYfHXE92znp+PZ1cs1ZB0wpPREkc5xcUI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>, stable@vger.kernel.org
Subject: [PATCH 5/6] perf probe: Fix to delete multiple probe event
Date:   Mon,  9 Mar 2020 15:53:22 -0300
Message-Id: <20200309185323.22583-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200309185323.22583-1-acme@kernel.org>
References: <20200309185323.22583-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

When we put an event with multiple probes, perf-probe fails to delete
with filters. This comes from a failure to list up the event name
because of overwrapping its name.

To fix this issue, skip to list up the event which has same name.

Without this patch:

  # perf probe -l \*
    probe_perf:map__map_ip (on perf_sample__fprintf_brstackoff:21@
    probe_perf:map__map_ip (on perf_sample__fprintf_brstackoff:25@
    probe_perf:map__map_ip (on append_inlines:12@util/machine.c in
    probe_perf:map__map_ip (on unwind_entry:19@util/machine.c in /
    probe_perf:map__map_ip (on map__map_ip@util/map.h in /home/mhi
    probe_perf:map__map_ip (on map__map_ip@util/map.h in /home/mhi
  # perf probe -d \*
  "*" does not hit any event.
    Error: Failed to delete events. Reason: No such file or directory (Code: -2)

With it:

  # perf probe -d \*
  Removed event: probe_perf:map__map_ip
  #

Fixes: 72363540c009 ("perf probe: Support multiprobe event")
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Reported-by: He Zhe <zhe.he@windriver.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: stable@vger.kernel.org
Link: http://lore.kernel.org/lkml/158287666197.16697.7514373548551863562.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 0f5fda11675f..8c852948513e 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -206,6 +206,9 @@ static struct strlist *__probe_file__get_namelist(int fd, bool include_group)
 		} else
 			ret = strlist__add(sl, tev.event);
 		clear_probe_trace_event(&tev);
+		/* Skip if there is same name multi-probe event in the list */
+		if (ret == -EEXIST)
+			ret = 0;
 		if (ret < 0)
 			break;
 	}
-- 
2.21.1

