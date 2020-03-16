Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC64BC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 04:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9333C20719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 04:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHezxfB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgCPEgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 00:36:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40449 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgCPEgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 00:36:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id t24so8990703pgj.7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 21:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x2aIrmW9cjK3AgpyGIiS7LfjEbJ0vHmekSq11XjW84U=;
        b=uHezxfB6KVcV9YYBFik9200F1Q4y/ehcQzB5jf54vlptqSWdZ3jJLn4xNpPBYgwIlK
         vmSD8ooYCjlXZloxDZHYtzylV1gGJ7By8PpRCjRyUT4PNvfQMXKI6Tgv2pAYhFtIyGdV
         lfhXu66n8BEGPws4QUjrFyfabLS8vrI4UTvtS0Dpu5RYuZBWgFsN+tumWcL0cj9eMwP1
         lQXV2zUL0UF78XXWQ8nqlc9Y9FAIN6u4gCw/N+4NGEi8kfcvzzU7BADywDAeRhFXu89d
         sKs8K0FFI9UeKscyTdBCyTIqN0HHULytKd8fplktKMe4unwI7B7lmFLOacuvBVqkPh4V
         rpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x2aIrmW9cjK3AgpyGIiS7LfjEbJ0vHmekSq11XjW84U=;
        b=FZvF52uX4RkrbXko2gOVh4lEeaQDCnIN8rAuk/M5b9up7AhM8v6VYOtldqFfX9Gci0
         nQR9J24Qtr7XdkO4oFm8FUasT0/9V4XVlywpRx/yM/2l0L/65d9C9oBM3ccKAdXXiEDZ
         qgRThYg+TbjdPKoKCX8BaRX61cp+BtZGm8GMommTb/01cuFGZiLd9YNSWC2pH5KHWb0x
         11IC7/nmHt2RsArJMKITGbatMoqURXT7qMbeeZ0YA7z8zF8LiJGM5h2KIHdpUgxqmTac
         ZAcR48Y7OlEqQRanFNjDwBwyE4SLppWhXxaqlfz+6vBmehYOacGnGRAHArRzIHAR2Yx+
         qvdA==
X-Gm-Message-State: ANhLgQ0S0KMrmWTQz0cfUG197cD1KdZCiYAQC4Q18egdnZ3rZGsit3ht
        xHQhbRZXttSQp6IXO7yyaQ==
X-Google-Smtp-Source: ADFU+vvD7ZY12Fv5AuWSMX8HBSYi+c/pA6BWamHOhmpp3/wxLvuyqf0jdFOYO2rfworbjAz/j+AM9w==
X-Received: by 2002:a63:5859:: with SMTP id i25mr24389370pgm.74.1584333402141;
        Sun, 15 Mar 2020 21:36:42 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d6sm18544296pjz.39.2020.03.15.21.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 21:36:41 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv6 3/3] mm/gup_benchemark: add LONGTERM_BENCHMARK test in gup fast path
Date:   Mon, 16 Mar 2020 12:34:04 +0800
Message-Id: <1584333244-10480-4-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1584333244-10480-1-git-send-email-kernelfans@gmail.com>
References: <1584333244-10480-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a PIN_FAST_LONGTERM_BENCHMARK ioctl to test longterm pin in gup fast
path.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/gup_benchmark.c                         | 7 +++++++
 tools/testing/selftests/vm/gup_benchmark.c | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
index be690fa..09fba20 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -10,6 +10,7 @@
 #define GUP_BENCHMARK		_IOWR('g', 3, struct gup_benchmark)
 #define PIN_FAST_BENCHMARK	_IOWR('g', 4, struct gup_benchmark)
 #define PIN_BENCHMARK		_IOWR('g', 5, struct gup_benchmark)
+#define PIN_FAST_LONGTERM_BENCHMARK	_IOWR('g', 6, struct gup_benchmark)

 struct gup_benchmark {
 	__u64 get_delta_usec;
@@ -101,6 +102,11 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 			nr = get_user_pages_fast(addr, nr, gup->flags,
 						 pages + i);
 			break;
+		case PIN_FAST_LONGTERM_BENCHMARK:
+			nr = get_user_pages_fast(addr, nr,
+					gup->flags | FOLL_LONGTERM,
+					pages + i);
+			break;
 		case GUP_LONGTERM_BENCHMARK:
 			nr = get_user_pages(addr, nr,
 					    gup->flags | FOLL_LONGTERM,
@@ -166,6 +172,7 @@ static long gup_benchmark_ioctl(struct file *filep, unsigned int cmd,
 	case GUP_BENCHMARK:
 	case PIN_FAST_BENCHMARK:
 	case PIN_BENCHMARK:
+	case PIN_FAST_LONGTERM_BENCHMARK:
 		break;
 	default:
 		return -EINVAL;
diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index 43b4dfe..f024ff3 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -21,6 +21,7 @@
 /* Similar to above, but use FOLL_PIN instead of FOLL_GET. */
 #define PIN_FAST_BENCHMARK	_IOWR('g', 4, struct gup_benchmark)
 #define PIN_BENCHMARK		_IOWR('g', 5, struct gup_benchmark)
+#define PIN_FAST_LONGTERM_BENCHMARK	_IOWR('g', 6, struct gup_benchmark)

 /* Just the flags we need, copied from mm.h: */
 #define FOLL_WRITE	0x01	/* check pte is writable */
@@ -44,7 +45,7 @@ int main(int argc, char **argv)
 	char *file = "/dev/zero";
 	char *p;

-	while ((opt = getopt(argc, argv, "m:r:n:f:abtTLUuwSH")) != -1) {
+	while ((opt = getopt(argc, argv, "m:r:n:f:abtTlLUuwSH")) != -1) {
 		switch (opt) {
 		case 'a':
 			cmd = PIN_FAST_BENCHMARK;
@@ -67,6 +68,9 @@ int main(int argc, char **argv)
 		case 'T':
 			thp = 0;
 			break;
+		case 'l':
+			cmd = PIN_FAST_LONGTERM_BENCHMARK;
+			break;
 		case 'L':
 			cmd = GUP_LONGTERM_BENCHMARK;
 			break;
--
2.7.5

