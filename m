Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323BCC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 04:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A0A82068E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 04:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgHPEKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 00:10:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9821 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726319AbgHPEKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 00:10:32 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8D4D062CA52734828924;
        Sat, 15 Aug 2020 20:23:41 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.229) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Sat, 15 Aug 2020 20:23:34 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        "John Hubbard" <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Christoph Hellwig" <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Dave Chinner" <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Jonathan Corbet" <corbet@lwn.net>, Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] mm/gup_benchmark: use pin_user_pages for FOLL_LONGTERM flag
Date:   Sun, 16 Aug 2020 00:20:56 +1200
Message-ID: <20200815122056.29508-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.202.229]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Documentation/core-api/pin_user_pages.rst, FOLL_PIN is a
prerequisite to FOLL_LONGTERM. Another way of saying that is,
FOLL_LONGTERM is a specific case, more restrictive case of FOLL_PIN.

Almost all kernel modules are using pin_user_pages() with FOLL_LONGTERM,
mm/gup_benchmark.c seems to the only exception in which FOLL_PIN is not
a prerequisite to FOLL_LONGTERM.

Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 mm/gup_benchmark.c                         | 23 +++++++++++-----------
 tools/testing/selftests/vm/gup_benchmark.c | 14 ++++++-------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
index be690fa66a46..464cae1fa3ea 100644
--- a/mm/gup_benchmark.c
+++ b/mm/gup_benchmark.c
@@ -6,10 +6,10 @@
 #include <linux/debugfs.h>
 
 #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
-#define GUP_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
-#define GUP_BENCHMARK		_IOWR('g', 3, struct gup_benchmark)
-#define PIN_FAST_BENCHMARK	_IOWR('g', 4, struct gup_benchmark)
-#define PIN_BENCHMARK		_IOWR('g', 5, struct gup_benchmark)
+#define GUP_BENCHMARK		_IOWR('g', 2, struct gup_benchmark)
+#define PIN_FAST_BENCHMARK	_IOWR('g', 3, struct gup_benchmark)
+#define PIN_BENCHMARK		_IOWR('g', 4, struct gup_benchmark)
+#define PIN_LONGTERM_BENCHMARK	_IOWR('g', 5, struct gup_benchmark)
 
 struct gup_benchmark {
 	__u64 get_delta_usec;
@@ -28,7 +28,6 @@ static void put_back_pages(unsigned int cmd, struct page **pages,
 
 	switch (cmd) {
 	case GUP_FAST_BENCHMARK:
-	case GUP_LONGTERM_BENCHMARK:
 	case GUP_BENCHMARK:
 		for (i = 0; i < nr_pages; i++)
 			put_page(pages[i]);
@@ -36,6 +35,7 @@ static void put_back_pages(unsigned int cmd, struct page **pages,
 
 	case PIN_FAST_BENCHMARK:
 	case PIN_BENCHMARK:
+	case PIN_LONGTERM_BENCHMARK:
 		unpin_user_pages(pages, nr_pages);
 		break;
 	}
@@ -50,6 +50,7 @@ static void verify_dma_pinned(unsigned int cmd, struct page **pages,
 	switch (cmd) {
 	case PIN_FAST_BENCHMARK:
 	case PIN_BENCHMARK:
+	case PIN_LONGTERM_BENCHMARK:
 		for (i = 0; i < nr_pages; i++) {
 			page = pages[i];
 			if (WARN(!page_maybe_dma_pinned(page),
@@ -101,11 +102,6 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 			nr = get_user_pages_fast(addr, nr, gup->flags,
 						 pages + i);
 			break;
-		case GUP_LONGTERM_BENCHMARK:
-			nr = get_user_pages(addr, nr,
-					    gup->flags | FOLL_LONGTERM,
-					    pages + i, NULL);
-			break;
 		case GUP_BENCHMARK:
 			nr = get_user_pages(addr, nr, gup->flags, pages + i,
 					    NULL);
@@ -118,6 +114,11 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
 			nr = pin_user_pages(addr, nr, gup->flags, pages + i,
 					    NULL);
 			break;
+		case PIN_LONGTERM_BENCHMARK:
+			nr = pin_user_pages(addr, nr,
+					    gup->flags | FOLL_LONGTERM,
+					    pages + i, NULL);
+			break;
 		default:
 			kvfree(pages);
 			ret = -EINVAL;
@@ -162,10 +163,10 @@ static long gup_benchmark_ioctl(struct file *filep, unsigned int cmd,
 
 	switch (cmd) {
 	case GUP_FAST_BENCHMARK:
-	case GUP_LONGTERM_BENCHMARK:
 	case GUP_BENCHMARK:
 	case PIN_FAST_BENCHMARK:
 	case PIN_BENCHMARK:
+	case PIN_LONGTERM_BENCHMARK:
 		break;
 	default:
 		return -EINVAL;
diff --git a/tools/testing/selftests/vm/gup_benchmark.c b/tools/testing/selftests/vm/gup_benchmark.c
index 43b4dfe161a2..31f8bb086907 100644
--- a/tools/testing/selftests/vm/gup_benchmark.c
+++ b/tools/testing/selftests/vm/gup_benchmark.c
@@ -15,12 +15,12 @@
 #define PAGE_SIZE sysconf(_SC_PAGESIZE)
 
 #define GUP_FAST_BENCHMARK	_IOWR('g', 1, struct gup_benchmark)
-#define GUP_LONGTERM_BENCHMARK	_IOWR('g', 2, struct gup_benchmark)
-#define GUP_BENCHMARK		_IOWR('g', 3, struct gup_benchmark)
+#define GUP_BENCHMARK		_IOWR('g', 2, struct gup_benchmark)
 
 /* Similar to above, but use FOLL_PIN instead of FOLL_GET. */
-#define PIN_FAST_BENCHMARK	_IOWR('g', 4, struct gup_benchmark)
-#define PIN_BENCHMARK		_IOWR('g', 5, struct gup_benchmark)
+#define PIN_FAST_BENCHMARK	_IOWR('g', 3, struct gup_benchmark)
+#define PIN_BENCHMARK		_IOWR('g', 4, struct gup_benchmark)
+#define PIN_LONGTERM_BENCHMARK	_IOWR('g', 5, struct gup_benchmark)
 
 /* Just the flags we need, copied from mm.h: */
 #define FOLL_WRITE	0x01	/* check pte is writable */
@@ -52,6 +52,9 @@ int main(int argc, char **argv)
 		case 'b':
 			cmd = PIN_BENCHMARK;
 			break;
+		case 'L':
+			cmd = PIN_LONGTERM_BENCHMARK;
+			break;
 		case 'm':
 			size = atoi(optarg) * MB;
 			break;
@@ -67,9 +70,6 @@ int main(int argc, char **argv)
 		case 'T':
 			thp = 0;
 			break;
-		case 'L':
-			cmd = GUP_LONGTERM_BENCHMARK;
-			break;
 		case 'U':
 			cmd = GUP_BENCHMARK;
 			break;
-- 
2.27.0


