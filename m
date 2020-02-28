Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3F5C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB173246BE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQb3ZBk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgB1LfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:35:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34610 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1LfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:35:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so1596198pfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 03:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ouTGWuIUR4ceNSkskbl9Csp7Y8Pui/2+vsjeiQPYtso=;
        b=IQb3ZBk1vuHvPHxRxGSKJCYTi8d30EqOzK2cHF2dZg+4pwg4qVI45YOAN+3U/mimRQ
         GAu6KBfoDzJhMJAZsOjhi1sj+qocX8+zCwiHI3UlNzB0BEu7FB0VIQxssualMf3nON+S
         FzjmVy498QDo9y2ei1T2ZRZhhYiHYEUzXKoY7DklI2j7uFgw2psu+hFQaHRkZ6WK2hWN
         jyeEamqcwPOpi7fTiZdt+iOGED7GWqk8YuWQeo+7bRU3R+4g96avicc2ZacjMD6vmKdL
         odfmN5kbK+1fvy1uNTYymPjRDNUU68fY2cFyIxwpN0z1NJPndEC0x7tKRRwtJmM+qpjH
         VyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ouTGWuIUR4ceNSkskbl9Csp7Y8Pui/2+vsjeiQPYtso=;
        b=D+pEp1H+Agbdv3NvQfGCFRV4jCPrGQq2cSjIilPoOIuxbUGkySROUgghUB+mAiWg/x
         pFBqOeVU54D8fYa+iC8+c/GqIKV19v2VDJ3itiGeUySP3MOjbk4AUnE0hOwRTsjfJG6b
         ZZ1z0m5ULDKNfbi8NZEJXXbesb8+znSVQcvIaly4yfKtLVHcf3NgA6ZZN2AAj++tk1Zd
         LLhohZz7PEb3C0Zj/Mf6o/UimjYMWkGpoe8iqtoeLs4gN0viAWjDtt4NiVlFEwCUmNOb
         qtYZ83yIPlbOqHzK0xQJwypqkATNI44qB/S3jrfaxroA2cfeD8lulfQM8NJu7dqsG3oG
         rLEA==
X-Gm-Message-State: APjAAAUOMETf1A5FoWZJM0BVJA3KBA+LgvOBnqc0G0yMMDd+t/ESX/FT
        y7hbVoDvMnEJivrA8aEntw==
X-Google-Smtp-Source: APXvYqwT4s9eUrkPHKnI8fgZNrAbSk5HCS7MHbN9UD+OioNjos79T6t0N5IxmNUiH9pBXZYSIbQvuA==
X-Received: by 2002:a62:7d16:: with SMTP id y22mr3962132pfc.220.1582889709431;
        Fri, 28 Feb 2020 03:35:09 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d14sm11402168pfq.117.2020.02.28.03.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 03:35:08 -0800 (PST)
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
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCHv5 3/3] mm/gup_benchemark: add LONGTERM_BENCHMARK test in gup fast path
Date:   Fri, 28 Feb 2020 19:32:30 +0800
Message-Id: <1582889550-9101-4-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1582889550-9101-1-git-send-email-kernelfans@gmail.com>
References: <1582889550-9101-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a GUP_LONGTERM_BENCHMARK ioctl to test longterm pin in gup fast
path.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Shuah Khan <shuah@kernel.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/gup_benchmark.c                         | 7 +++++++
 tools/testing/selftests/vm/gup_benchmark.c | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
index 8dba38e..bf61e7a 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -8,6 +8,7 @@
 #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
 #define GUP_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
 #define GUP_BENCHMARK		_IOWR('g', 3, struct gup_benchmark)
+#define GUP_FAST_LONGTERM_BENCHMARK	_IOWR('g', 4, struct gup_benchmark)
 
 struct gup_benchmark {
 	__u64 get_delta_usec;
@@ -57,6 +58,11 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 			nr = get_user_pages_fast(addr, nr, gup->flags,
 						 pages + i);
 			break;
+		case GUP_FAST_LONGTERM_BENCHMARK:
+			nr = get_user_pages_fast(addr, nr,
+					(gup->flags & 1) | FOLL_LONGTERM,
+					 pages + i);
+			break;
 		case GUP_LONGTERM_BENCHMARK:
 			nr = get_user_pages(addr, nr,
 					    gup->flags | FOLL_LONGTERM,
@@ -103,6 +109,7 @@ static long gup_benchmark_ioctl(struct file *filep, unsigned int cmd,
 
 	switch (cmd) {
 	case GUP_FAST_BENCHMARK:
+	case GUP_FAST_LONGTERM_BENCHMARK:
 	case GUP_LONGTERM_BENCHMARK:
 	case GUP_BENCHMARK:
 		break;
diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index 389327e..5a01c538 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -17,6 +17,7 @@
 #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
 #define GUP_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
 #define GUP_BENCHMARK		_IOWR('g', 3, struct gup_benchmark)
+#define GUP_FAST_LONGTERM_BENCHMARK	_IOWR('g', 4, struct gup_benchmark)
 
 /* Just the flags we need, copied from mm.h: */
 #define FOLL_WRITE	0x01	/* check pte is writable */
@@ -40,7 +41,7 @@ int main(int argc, char **argv)
 	char *file = "/dev/zero";
 	char *p;
 
-	while ((opt = getopt(argc, argv, "m:r:n:f:tTLUwSH")) != -1) {
+	while ((opt = getopt(argc, argv, "m:r:n:f:tTlLUwSH")) != -1) {
 		switch (opt) {
 		case 'm':
 			size = atoi(optarg) * MB;
@@ -57,6 +58,9 @@ int main(int argc, char **argv)
 		case 'T':
 			thp = 0;
 			break;
+		case 'l':
+			cmd = GUP_FAST_LONGTERM_BENCHMARK;
+			break;
 		case 'L':
 			cmd = GUP_LONGTERM_BENCHMARK;
 			break;
-- 
2.7.5

