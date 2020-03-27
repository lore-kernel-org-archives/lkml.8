Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600BDC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C87120714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgC0Iqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:46:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:42032 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgC0Iqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:46:47 -0400
IronPort-SDR: 7tyILDxBlZqJgoUoLMvR+Y5nxyU7Fpp0MSWQ5stwjoXVgFi8cwTSDdh887+NLuoEF5kJIFTxsb
 qrTTsO0boSww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 01:46:47 -0700
IronPort-SDR: spE80RhqPa7BhOMjk9uNEuWivCMu4iHwTxd7KwNmH+dDQ4HO0ZfoLXN7wnCPNZ2HJqCir5X7z0
 ZcQ8CTohXFjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="scan'208";a="251080112"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 27 Mar 2020 01:46:47 -0700
Received: from [10.249.36.56] (abudanko-mobl.ccr.corp.intel.com [10.249.36.56])
        by linux.intel.com (Postfix) with ESMTP id A65AE5805B4;
        Fri, 27 Mar 2020 01:46:44 -0700 (PDT)
Subject: [PATCH v1 2/8] perf evlist: implement control command handling
 functions
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
Organization: Intel Corp.
Message-ID: <1760b862-7a4a-3930-1a53-04667c71cf6f@linux.intel.com>
Date:   Fri, 27 Mar 2020 11:46:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement functions of initialization, finalization and processing
of control commands coming from control file descriptors.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/evlist.c | 100 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h |  12 +++++
 2 files changed, 112 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1afd87cfa027..56b01a22963b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1834,3 +1834,103 @@ void perf_evlist__stop_sb_thread(struct evlist *evlist)
 	pthread_join(evlist->thread.th, NULL);
 	evlist__delete(evlist);
 }
+
+int perf_evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack)
+{
+	if (ctl_fd == -1) {
+		pr_debug("Control descriptor is not initialized\n");
+		return 0;
+	}
+
+	evlist->ctl_fd_pos = perf_evlist__add_pollfd(&evlist->core, ctl_fd, NULL, POLLIN);
+	if (evlist->ctl_fd_pos < 0) {
+		evlist->ctl_fd_pos = -1;
+		pr_err("Failed to add ctl fd entry: %m\n");
+		return -1;
+	}
+
+	evlist->ctl_fd = ctl_fd;
+	evlist->ctl_fd_ack = ctl_fd_ack;
+
+	return 0;
+}
+
+int perf_evlist__finalize_ctlfd(struct evlist *evlist)
+{
+	if (evlist->ctl_fd_pos == -1)
+		return 0;
+
+	evlist->core.pollfd.entries[evlist->ctl_fd_pos].fd = -1;
+	evlist->ctl_fd_pos = -1;
+	evlist->ctl_fd_ack = -1;
+	evlist->ctl_fd = -1;
+
+	return 0;
+}
+
+static int perf_evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
+{
+	int err;
+	char buf[2];
+
+	err = read(evlist->ctl_fd, &buf, sizeof(buf));
+	if (err > 0)
+		*cmd = buf[0];
+	else if (err == -1)
+		pr_err("Failed to read from ctlfd %d: %m\n", evlist->ctl_fd);
+
+	return err;
+}
+
+static int perf_evlist__ctlfd_ack(struct evlist *evlist)
+{
+	int err;
+	char buf[2] = {CTL_CMD_ACK, '\n'};
+
+	if (evlist->ctl_fd_ack == -1)
+		return 0;
+
+	err = write(evlist->ctl_fd_ack, buf, sizeof(buf));
+	if (err == -1)
+		pr_err("failed to write to ctl_ack_fd %d: %m\n", evlist->ctl_fd_ack);
+
+	return err;
+}
+
+int perf_evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
+{
+	int err = 0;
+	int ctlfd_pos = evlist->ctl_fd_pos;
+	struct pollfd *entries = evlist->core.pollfd.entries;
+
+	if (!entries[ctlfd_pos].revents)
+		return 0;
+
+	if (entries[ctlfd_pos].revents & POLLIN) {
+		err = perf_evlist__ctlfd_recv(evlist, cmd);
+		if (err > 0) {
+			switch (*cmd) {
+			case CTL_CMD_RESUME:
+				evlist__enable(evlist);
+				break;
+			case CTL_CMD_PAUSE:
+				evlist__disable(evlist);
+				break;
+			case CTL_CMD_ACK:
+			case CTL_CMD_UNSUPPORTED:
+			default:
+				pr_debug("ctlfd: unsupported %d\n", *cmd);
+				break;
+			}
+			if (!(*cmd == CTL_CMD_ACK || *cmd == CTL_CMD_UNSUPPORTED))
+				perf_evlist__ctlfd_ack(evlist);
+		}
+	}
+
+	if (entries[ctlfd_pos].revents & (POLLHUP | POLLERR))
+		perf_evlist__finalize_ctlfd(evlist);
+	else
+		entries[ctlfd_pos].revents = 0;
+
+	return err;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index ac3dd895ef8f..a94b2993fafc 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -361,4 +361,16 @@ void perf_evlist__force_leader(struct evlist *evlist);
 struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
 						 struct evsel *evsel,
 						bool close);
+
+enum evlist_ctl_cmd {
+	CTL_CMD_UNSUPPORTED = 0,
+	CTL_CMD_RESUME = 'r',
+	CTL_CMD_PAUSE = 'p',
+	CTL_CMD_ACK = 'a'
+};
+
+int perf_evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
+int perf_evlist__finalize_ctlfd(struct evlist *evlist);
+int perf_evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
+
 #endif /* __PERF_EVLIST_H */
-- 
2.24.1


