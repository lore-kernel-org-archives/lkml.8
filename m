Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1B5C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A0E24969
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgEHNGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728871AbgEHNFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542A4C05BD43;
        Fri,  8 May 2020 06:05:52 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2h2-0007or-1U; Fri, 08 May 2020 15:05:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E3ABD1C084B;
        Fri,  8 May 2020 15:05:09 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:09 -0000
From:   "tip-bot2 for Zou Wei" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Remove unneeded semicolons
Cc:     Hulk Robot <hulkci@huawei.com>, Zou Wei <zou_wei@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1588065523-71423-1-git-send-email-zou_wei@huawei.com>
References: <1588065523-71423-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Message-ID: <158894310981.8414.14196395004420434469.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8284bbeab75f1842dc11531356115c4d09abebc0
Gitweb:        https://git.kernel.org/tip/8284bbeab75f1842dc11531356115c4d09abebc0
Author:        Zou Wei <zou_wei@huawei.com>
AuthorDate:    Tue, 28 Apr 2020 17:18:43 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 30 Apr 2020 10:48:32 -03:00

perf tools: Remove unneeded semicolons

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
index 1ea9ada..89b3906 100644
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
