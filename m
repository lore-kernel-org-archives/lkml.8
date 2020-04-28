Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2513C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8C3220757
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgD1JMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:12:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3363 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726462AbgD1JMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:12:39 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6869499AD9B950E77A03;
        Tue, 28 Apr 2020 17:12:37 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Apr 2020 17:12:30 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] perf tools: Remove unneeded semicolon
Date:   Tue, 28 Apr 2020 17:18:43 +0800
Message-ID: <1588065523-71423-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warnings:

tools/perf/builtin-diff.c:1565:2-3: Unneeded semicolon
tools/perf/builtin-lock.c:778:2-3: Unneeded semicolon
tools/perf/builtin-mem.c:126:2-3: Unneeded semicolon
tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c:555:2-3: Unneeded semicolon
tools/perf/util/ordered-events.c:317:2-3: Unneeded semicolon
tools/perf/util/synthetic-events.c:1131:2-3: Unneeded semicolon
tools/perf/util/trace-event-read.c:78:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 tools/perf/builtin-diff.c                               | 2 +-
 tools/perf/builtin-lock.c                               | 2 +-
 tools/perf/builtin-mem.c                                | 2 +-
 tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c | 2 +-
 tools/perf/util/ordered-events.c                        | 2 +-
 tools/perf/util/synthetic-events.c                      | 2 +-
 tools/perf/util/trace-event-read.c                      | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index c94a002..59d40f0 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1562,7 +1562,7 @@ hpp__entry_pair(struct hist_entry *he, struct hist_entry *pair,
 
 	default:
 		BUG_ON(1);
-	};
+	}
 }
 
 static void
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 474dfd5..543d82f 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -775,7 +775,7 @@ static void dump_threads(void)
 		pr_info("%10d: %s\n", st->tid, thread__comm_str(t));
 		node = rb_next(node);
 		thread__put(t);
-	};
+	}
 }
 
 static void dump_map(void)
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index a13f581..68a7eb8 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -123,7 +123,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 
 		rec_argv[i++] = "-e";
 		rec_argv[i++] = perf_mem_events__name(j);
-	};
+	}
 
 	if (all_user)
 		rec_argv[i++] = "--all-user";
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
index 0ccf10a..4ce1099 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.c
@@ -552,7 +552,7 @@ static int intel_pt_do_get_packet(const unsigned char *buf, size_t len,
 		break;
 	default:
 		break;
-	};
+	}
 
 	if (!(byte & BIT(0))) {
 		if (byte == 0)
diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 359db2b..48c8f60 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -314,7 +314,7 @@ static int __ordered_events__flush(struct ordered_events *oe, enum oe_flush how,
 	case OE_FLUSH__NONE:
 	default:
 		break;
-	};
+	}
 
 	pr_oe_time(oe->next_flush, "next_flush - ordered_events__flush PRE  %s, nr_events %u\n",
 		   str[how], oe->nr_events);
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 9d4aa95..2523be6 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1128,7 +1128,7 @@ void cpu_map_data__synthesize(struct perf_record_cpu_map_data *data, struct perf
 		synthesize_mask((struct perf_record_record_cpu_map *)data->data, map, max);
 	default:
 		break;
-	};
+	}
 }
 
 static struct perf_record_cpu_map *cpu_map_event__new(struct perf_cpu_map *map)
diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 8593d3c..f507dff 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -75,7 +75,7 @@ static void skip(int size)
 		r = size > BUFSIZ ? BUFSIZ : size;
 		do_read(buf, r);
 		size -= r;
-	};
+	}
 }
 
 static unsigned int read4(struct tep_handle *pevent)
-- 
2.6.2

