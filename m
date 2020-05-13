Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEDFC2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B65923126
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgEMIAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:00:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:47461 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbgEMIAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:00:07 -0400
IronPort-SDR: 4TJe/zd0A1jlrScUiMCC/dcaMK6gz7peDRkGnOZmZrHaw/cDmwGZ+AEoabyjXSFnW/rlpywNXw
 L9Qk7TywAPxw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 01:00:07 -0700
IronPort-SDR: 8RXeo4PxMRpiUHAQ7B+czY8GOWqKNy88UzY2T2dg56WWddlh9TrRTuyJjAdDIyp8UBgPezvi+D
 AMVK/d2sxydQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,387,1583222400"; 
   d="scan'208";a="371827276"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2020 01:00:06 -0700
Received: from [10.249.229.18] (abudanko-mobl.ccr.corp.intel.com [10.249.229.18])
        by linux.intel.com (Postfix) with ESMTP id 0E1BD580646;
        Wed, 13 May 2020 01:00:03 -0700 (PDT)
Subject: [PATCH v3 2/9] perf evlist: implement control command handling
 functions
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
Organization: Intel Corp.
Message-ID: <ffcdb43a-8f7d-b16f-d59b-19293037af84@linux.intel.com>
Date:   Wed, 13 May 2020 11:00:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
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
 tools/perf/util/evlist.c | 128 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h |  17 ++++++
 2 files changed, 145 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index aa61619fa304..ea14794e7389 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1707,3 +1707,131 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 	}
 	return leader;
 }
+
+int evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack)
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
+int evlist__finalize_ctlfd(struct evlist *evlist)
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
+		err = read(evlist->ctl_fd, &c, 1);
+		if (err > 0) {
+			if (c == '\n' || c == '\0')
+				break;
+			cmd_data[bytes_read++] = c;
+			if (bytes_read == data_size)
+				break;
+		} else {
+			if (err == -1)
+				pr_err("Failed to read from ctlfd %d: %m\n", evlist->ctl_fd);
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
+	if (evlist->ctl_fd_ack == -1)
+		return 0;
+
+	err = write(evlist->ctl_fd_ack, EVLIST_CTL_CMD_ACK_TAG,
+		    sizeof(EVLIST_CTL_CMD_ACK_TAG));
+	if (err == -1)
+		pr_err("failed to write to ctl_ack_fd %d: %m\n", evlist->ctl_fd_ack);
+
+	return err;
+}
+
+int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
+{
+	int err = 0;
+	char cmd_data[EVLIST_CTL_CMD_MAX_LEN];
+	int ctlfd_pos = evlist->ctl_fd_pos;
+	struct pollfd *entries = evlist->core.pollfd.entries;
+
+	if (!entries[ctlfd_pos].revents)
+		return 0;
+
+	if (entries[ctlfd_pos].revents & POLLIN) {
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
+	if (entries[ctlfd_pos].revents & (POLLHUP | POLLERR))
+		evlist__finalize_ctlfd(evlist);
+	else
+		entries[ctlfd_pos].revents = 0;
+
+	return err;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 62f259d89b41..0554f8d2a65b 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -358,4 +358,21 @@ void perf_evlist__force_leader(struct evlist *evlist);
 struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
 						 struct evsel *evsel,
 						bool close);
+#define EVLIST_CTL_CMD_ENABLE_TAG  "enable"
+#define EVLIST_CTL_CMD_DISABLE_TAG "disable"
+#define EVLIST_CTL_CMD_ACK_TAG	   "ack\n"
+
+#define EVLIST_CTL_CMD_MAX_LEN	64
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


