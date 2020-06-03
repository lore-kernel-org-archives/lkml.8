Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB45C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74045206A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgFCPyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:54:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:47179 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgFCPyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:54:52 -0400
IronPort-SDR: JAIUVHJq30aBNtltDZVD4cPoAL24/ror3YLfXi2VLO/qTonukQqfBrA0fqsVRyY0MPvWUc0V9w
 NslNMjtPvZMQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 08:54:51 -0700
IronPort-SDR: 3OuyG+o15echHNONUAbMWVdaqKv3TUhIX0CyIfh576dJHbHBVBW+cGeUEezjkZDgBox3jdaczV
 Z5eruKKcEFGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,468,1583222400"; 
   d="scan'208";a="471182681"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jun 2020 08:54:51 -0700
Received: from [10.249.225.188] (abudanko-mobl.ccr.corp.intel.com [10.249.225.188])
        by linux.intel.com (Postfix) with ESMTP id 0F46C58045A;
        Wed,  3 Jun 2020 08:54:48 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v7 03/13] perf evlist: implement control command handling
 functions
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com>
Organization: Intel Corp.
Message-ID: <88988ce1-52d3-21e7-f0dc-bac5fde63cb2@linux.intel.com>
Date:   Wed, 3 Jun 2020 18:54:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement functions of initialization, finalization and processing
of control command messages coming from control file descriptors.
Allocate control file descriptor as a static descriptor at struct
pollfd object of evsel_list using perf_evlist__add_pollfd_stat().

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/evlist.c | 128 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h |  17 ++++++
 2 files changed, 145 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 47541b5cab46..fbd98f741af9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1718,3 +1718,131 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 	}
 	return leader;
 }
+
+int evlist__initialize_ctlfd(struct evlist *evlist, int fd, int ack)
+{
+	if (fd == -1) {
+		pr_debug("Control descriptor is not initialized\n");
+		return 0;
+	}
+
+	evlist->ctl_fd.pos = perf_evlist__add_pollfd_stat(&evlist->core, fd, POLLIN);
+	if (evlist->ctl_fd.pos < 0) {
+		evlist->ctl_fd.pos = -1;
+		pr_err("Failed to add ctl fd entry: %m\n");
+		return -1;
+	}
+
+	evlist->ctl_fd.fd = fd;
+	evlist->ctl_fd.ack = ack;
+
+	return 0;
+}
+
+int evlist__finalize_ctlfd(struct evlist *evlist)
+{
+	if (evlist->ctl_fd.pos == -1)
+		return 0;
+
+	evlist->core.pollfd.stat_entries[evlist->ctl_fd.pos].fd = -1;
+	evlist->ctl_fd.pos = -1;
+	evlist->ctl_fd.ack = -1;
+	evlist->ctl_fd.fd = -1;
+
+	return 0;
+}
+
+static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
+			      char *cmd_data, size_t data_size)
+{
+	int err;
+	char c;
+	size_t bytes_read = 0;
+
+	memset(cmd_data, 0, data_size--);
+
+	do {
+		err = read(evlist->ctl_fd.fd, &c, 1);
+		if (err > 0) {
+			if (c == '\n' || c == '\0')
+				break;
+			cmd_data[bytes_read++] = c;
+			if (bytes_read == data_size)
+				break;
+		} else {
+			if (err == -1)
+				pr_err("Failed to read from ctlfd %d: %m\n", evlist->ctl_fd.fd);
+			break;
+		}
+	} while (1);
+
+	pr_debug("Message from ctl_fd: \"%s%s\"\n", cmd_data,
+		 bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
+
+	if (err > 0) {
+		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
+			     strlen(EVLIST_CTL_CMD_ENABLE_TAG))) {
+			*cmd = EVLIST_CTL_CMD_ENABLE;
+		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
+				    strlen(EVLIST_CTL_CMD_DISABLE_TAG))) {
+			*cmd = EVLIST_CTL_CMD_DISABLE;
+		}
+	}
+
+	return err;
+}
+
+static int evlist__ctlfd_ack(struct evlist *evlist)
+{
+	int err;
+
+	if (evlist->ctl_fd.ack == -1)
+		return 0;
+
+	err = write(evlist->ctl_fd.ack, EVLIST_CTL_CMD_ACK_TAG,
+		    sizeof(EVLIST_CTL_CMD_ACK_TAG));
+	if (err == -1)
+		pr_err("failed to write to ctl_ack_fd %d: %m\n", evlist->ctl_fd.ack);
+
+	return err;
+}
+
+int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
+{
+	int err = 0;
+	char cmd_data[EVLIST_CTL_CMD_MAX_LEN];
+	int ctlfd_pos = evlist->ctl_fd.pos;
+	struct pollfd *stat_entries = evlist->core.pollfd.stat_entries;
+
+	if (ctlfd_pos == -1 || !stat_entries[ctlfd_pos].revents)
+		return 0;
+
+	if (stat_entries[ctlfd_pos].revents & POLLIN) {
+		err = evlist__ctlfd_recv(evlist, cmd, cmd_data,
+					 EVLIST_CTL_CMD_MAX_LEN);
+		if (err > 0) {
+			switch (*cmd) {
+			case EVLIST_CTL_CMD_ENABLE:
+				evlist__enable(evlist);
+				break;
+			case EVLIST_CTL_CMD_DISABLE:
+				evlist__disable(evlist);
+				break;
+			case EVLIST_CTL_CMD_ACK:
+			case EVLIST_CTL_CMD_UNSUPPORTED:
+			default:
+				pr_debug("ctlfd: unsupported %d\n", *cmd);
+				break;
+			}
+			if (!(*cmd == EVLIST_CTL_CMD_ACK || *cmd == EVLIST_CTL_CMD_UNSUPPORTED))
+				evlist__ctlfd_ack(evlist);
+		}
+	}
+
+	if (stat_entries[ctlfd_pos].revents & (POLLHUP | POLLERR))
+		evlist__finalize_ctlfd(evlist);
+	else
+		stat_entries[ctlfd_pos].revents = 0;
+
+	return err;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 0d8b361f1c8e..bccf0a970371 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -360,4 +360,21 @@ void perf_evlist__force_leader(struct evlist *evlist);
 struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
 						 struct evsel *evsel,
 						bool close);
+#define EVLIST_CTL_CMD_ENABLE_TAG  "enable"
+#define EVLIST_CTL_CMD_DISABLE_TAG "disable"
+#define EVLIST_CTL_CMD_ACK_TAG     "ack\n"
+
+#define EVLIST_CTL_CMD_MAX_LEN 64
+
+enum evlist_ctl_cmd {
+	EVLIST_CTL_CMD_UNSUPPORTED = 0,
+	EVLIST_CTL_CMD_ENABLE,
+	EVLIST_CTL_CMD_DISABLE,
+	EVLIST_CTL_CMD_ACK
+};
+
+int evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
+int evlist__finalize_ctlfd(struct evlist *evlist);
+int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
+
 #endif /* __PERF_EVLIST_H */
-- 
2.24.1

