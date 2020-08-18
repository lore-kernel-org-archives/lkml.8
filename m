Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55269C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A472083B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHRMbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:31:41 -0400
Received: from mail.loongson.cn ([114.242.206.163]:53538 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726635AbgHRMbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:31:39 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf93tyTtf4nAKAA--.15S2;
        Tue, 18 Aug 2020 20:30:38 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH] perf top: Skip side-band event setup if HAVE_LIBBPF_SUPPORT is not set
Date:   Tue, 18 Aug 2020 20:30:37 +0800
Message-Id: <1597753837-16222-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxf93tyTtf4nAKAA--.15S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4fGryrArW8ZFWrtF1rXrb_yoW8Ar1xpF
        Z09343GrW5W3y2v3ZxJF4SgFy3KFWrXw4I9FyIyr48ZwsxZwn5JayagFyYgFn8Z3yvy3WS
        vF4kKr45XF48AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6ryU
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFzuWDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I execute perf top without HAVE_LIBBPF_SUPPORT, there exists the
following segmentation fault, skip the side-band event setup to fix it,
this is similar with commit 1101c872c8c7 ("perf record: Skip side-band
event setup if HAVE_LIBBPF_SUPPORT is not set").

[yangtiezhu@linux perf]$ ./perf top

<SNIP>
perf: Segmentation fault
Obtained 6 stack frames.
./perf(sighandler_dump_stack+0x5c) [0x12011b604]
[0xffffffc010]
./perf(perf_mmap__read_init+0x3e) [0x1201feeae]
./perf() [0x1200d715c]
/lib64/libpthread.so.0(+0xab9c) [0xffee10ab9c]
/lib64/libc.so.6(+0x128f4c) [0xffedc08f4c]
Segmentation fault

I use git bisect to find commit b38d85ef49cf ("perf bpf: Decouple
creating the evlist from adding the SB event") is the first bad
commit, so also add the Fixes tag.

Fixes: b38d85ef49cf ("perf bpf: Decouple creating the evlist from adding the SB event")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/perf/builtin-top.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 994c230..7c64134 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1746,6 +1746,7 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
+#ifdef HAVE_LIBBPF_SUPPORT
 	if (!top.record_opts.no_bpf_event) {
 		top.sb_evlist = evlist__new();
 
@@ -1759,6 +1760,7 @@ int cmd_top(int argc, const char **argv)
 			goto out_delete_evlist;
 		}
 	}
+#endif
 
 	if (perf_evlist__start_sb_thread(top.sb_evlist, target)) {
 		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
-- 
2.1.0

