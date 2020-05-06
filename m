Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06444C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D234C221F7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778625;
	bh=cryxoolwZQORYUYy7a5ctHZ8Vx9RfNNlzIea5qUqpKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PMc8dWKzwaITiSWIq44UvYX2YxwiYupdm3i7/OFsQ7rfrpZ1OpVwOVTZt2m3ujxH5
	 7Uj2t99Nvt1dLzzmbmu+FAF8zRjg1/rAodW/BikhS7K6APuch580/rZHyH47iOF5L0
	 HszB80RRzmuXZx3evTAsLTMhCj1omZfdMyy2FURM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgEFPXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:23:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729730AbgEFPXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:23:39 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24A4921582;
        Wed,  6 May 2020 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778619;
        bh=cryxoolwZQORYUYy7a5ctHZ8Vx9RfNNlzIea5qUqpKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xe3WuTG8XXC+ExDs0/1dASi4EYFLo1i+gMihoRLacBLixNIqdfej/n5zynuxP2f7v
         c/swTLeNWsBO1OajCE3/7OPO2ZNHshPKNOp6CY/fiGBOjaAVgcZ5FM8756MSU07mdD
         3mRd1d/WijAnSLygJ7R6Nni4of1YkUrhYTJvEgZU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Zou Wei <zou_wei@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/91] perf tools: Remove unneeded semicolons
Date:   Wed,  6 May 2020 12:21:18 -0300
Message-Id: <20200506152234.21977-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zou Wei <zou_wei@huawei.com>

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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/1588065523-71423-1-git-send-email-zou_wei@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index c94a002f295e..59d40f036587 100644
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
index 474dfd59d7eb..543d82fec556 100644
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
index a13f5817d6fc..68a7eb84561a 100644
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
index 0ccf10a0bf44..4ce109993e74 100644
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
index 359db2b1fcef..48c8f609441b 100644
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
index 1ea9adaef9c7..89b390623b63 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1181,7 +1181,7 @@ void cpu_map_data__synthesize(struct perf_record_cpu_map_data *data, struct perf
 		synthesize_mask((struct perf_record_record_cpu_map *)data->data, map, max);
 	default:
 		break;
-	};
+	}
 }
 
 static struct perf_record_cpu_map *cpu_map_event__new(struct perf_cpu_map *map)
diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 8593d3c200c6..f507dff713c9 100644
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
2.21.1

