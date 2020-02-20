Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D89C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1F7206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1YBxbjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgBTQcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:32:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60080 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728991AbgBTQbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582216313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hu9KAoP+d+FuB6NSsYkumcpLIf53o6Lws7b+TrSB9Ig=;
        b=G1YBxbjr1WnSjlDjWybXvz7dbAOOA8QvPUibWQf4lYd1x6irT4Hx9qpuWpbqcDZllsrN9/
        n+XBLfs35XnxSOs6mblHrP944EhDY7aZcMC3pJVBEvL+wLFYFQ1neTQvovh9Aq2wmuClxK
        FFH+1wQ0u48JyCINM1kHgsWQmNY9iB8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-VxdkjvqtPwiCY7fRwLF9Iw-1; Thu, 20 Feb 2020 11:31:51 -0500
X-MC-Unique: VxdkjvqtPwiCY7fRwLF9Iw-1
Received: by mail-qv1-f71.google.com with SMTP id g6so2945245qvp.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:31:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hu9KAoP+d+FuB6NSsYkumcpLIf53o6Lws7b+TrSB9Ig=;
        b=p7pLNes88jbaOvNmhh9NCSVUC0QUJWpCRxXyfcQnmmj1BCL0uP/bC3HHxc3uFiioEN
         NfVF/+fVJDApY+7km1XqNvB6x0MqSVc2uWYL33lGv2ll8Vt5hg7zv5TtWMyO5njZUFyr
         N2oC1ZmqosVKq3DoyBlDjCJqUnbXk3077vU9d5o7B5Ew/IRTy+mABWnKP+ixxJcdEzdq
         dFReVozYC53ayweXSXZW6fEGBY6wOD9QWgj12bJK9UdKn37eOn70tjMaxYcyF9if1Gv0
         1MKjkjR3YgpuptclD0bWkkvmVhVvnNrlUOfydAJ76KxX4DNS9NZOPhVQVQqcgvk9dVsl
         zbjQ==
X-Gm-Message-State: APjAAAWrHYa2Eadk9rQa0UkRJoqeTZGPTqoORZ9WGdNfPpqSGEc76wup
        mC1zLVnNpiMsMU399QGH6x8502caWB9IhwWPbUikGjFIKFVZC5/1H099DVhEuHaqLYNqMMhZw9B
        HQyQt+Z2Q4oQEOzyaeLKUwi58
X-Received: by 2002:ac8:33f4:: with SMTP id d49mr27491689qtb.145.1582216310794;
        Thu, 20 Feb 2020 08:31:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqxA3t4ShAWPo3ObhjySrMwF7y3AXDbWDLT1gDtaAdHabUXDKEjMSd/n9w/14zt2gVO57cj+LA==
X-Received: by 2002:ac8:33f4:: with SMTP id d49mr27491642qtb.145.1582216310387;
        Thu, 20 Feb 2020 08:31:50 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.75])
        by smtp.gmail.com with ESMTPSA id l19sm42366qkl.3.2020.02.20.08.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:31:49 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Brian Geffon <bgeffon@google.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Bobby Powers <bobbypowers@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH v6 19/19] userfaultfd: selftests: add write-protect test
Date:   Thu, 20 Feb 2020 11:31:12 -0500
Message-Id: <20200220163112.11409-20-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220163112.11409-1-peterx@redhat.com>
References: <20200220163112.11409-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds uffd tests for write protection.

Instead of introducing new tests for it, let's simply squashing uffd-wp
tests into existing uffd-missing test cases.  Changes are:

(1) Bouncing tests

  We do the write-protection in two ways during the bouncing test:

  - By using UFFDIO_COPY_MODE_WP when resolving MISSING pages: then
    we'll make sure for each bounce process every single page will be
    at least fault twice: once for MISSING, once for WP.

  - By direct call UFFDIO_WRITEPROTECT on existing faulted memories:
    To further torture the explicit page protection procedures of
    uffd-wp, we split each bounce procedure into two halves (in the
    background thread): the first half will be MISSING+WP for each
    page as explained above.  After the first half, we write protect
    the faulted region in the background thread to make sure at least
    half of the pages will be write protected again which is the first
    half to test the new UFFDIO_WRITEPROTECT call.  Then we continue
    with the 2nd half, which will contain both MISSING and WP faulting
    tests for the 2nd half and WP-only faults from the 1st half.

(2) Event/Signal test

  Mostly previous tests but will do MISSING+WP for each page.  For
  sigbus-mode test we'll need to provide standalone path to handle the
  write protection faults.

For all tests, do statistics as well for uffd-wp pages.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 157 +++++++++++++++++++----
 1 file changed, 133 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 3911a9ccb0bb..61e5cfeb1350 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -54,6 +54,7 @@
 #include <linux/userfaultfd.h>
 #include <setjmp.h>
 #include <stdbool.h>
+#include <assert.h>
 
 #include "../kselftest.h"
 
@@ -76,6 +77,8 @@ static int test_type;
 #define ALARM_INTERVAL_SECS 10
 static volatile bool test_uffdio_copy_eexist = true;
 static volatile bool test_uffdio_zeropage_eexist = true;
+/* Whether to test uffd write-protection */
+static bool test_uffdio_wp = false;
 
 static bool map_shared;
 static int huge_fd;
@@ -90,6 +93,7 @@ pthread_attr_t attr;
 struct uffd_stats {
 	int cpu;
 	unsigned long missing_faults;
+	unsigned long wp_faults;
 };
 
 /* pthread_mutex_t starts at page offset 0 */
@@ -139,9 +143,29 @@ static void uffd_stats_reset(struct uffd_stats *uffd_stats,
 	for (i = 0; i < n_cpus; i++) {
 		uffd_stats[i].cpu = i;
 		uffd_stats[i].missing_faults = 0;
+		uffd_stats[i].wp_faults = 0;
 	}
 }
 
+static void uffd_stats_report(struct uffd_stats *stats, int n_cpus)
+{
+	int i;
+	unsigned long long miss_total = 0, wp_total = 0;
+
+	for (i = 0; i < n_cpus; i++) {
+		miss_total += stats[i].missing_faults;
+		wp_total += stats[i].wp_faults;
+	}
+
+	printf("userfaults: %llu missing (", miss_total);
+	for (i = 0; i < n_cpus; i++)
+		printf("%lu+", stats[i].missing_faults);
+	printf("\b), %llu wp (", wp_total);
+	for (i = 0; i < n_cpus; i++)
+		printf("%lu+", stats[i].wp_faults);
+	printf("\b)\n");
+}
+
 static int anon_release_pages(char *rel_area)
 {
 	int ret = 0;
@@ -262,10 +286,15 @@ struct uffd_test_ops {
 	void (*alias_mapping)(__u64 *start, size_t len, unsigned long offset);
 };
 
-#define ANON_EXPECTED_IOCTLS		((1 << _UFFDIO_WAKE) | \
+#define SHMEM_EXPECTED_IOCTLS		((1 << _UFFDIO_WAKE) | \
 					 (1 << _UFFDIO_COPY) | \
 					 (1 << _UFFDIO_ZEROPAGE))
 
+#define ANON_EXPECTED_IOCTLS		((1 << _UFFDIO_WAKE) | \
+					 (1 << _UFFDIO_COPY) | \
+					 (1 << _UFFDIO_ZEROPAGE) | \
+					 (1 << _UFFDIO_WRITEPROTECT))
+
 static struct uffd_test_ops anon_uffd_test_ops = {
 	.expected_ioctls = ANON_EXPECTED_IOCTLS,
 	.allocate_area	= anon_allocate_area,
@@ -274,7 +303,7 @@ static struct uffd_test_ops anon_uffd_test_ops = {
 };
 
 static struct uffd_test_ops shmem_uffd_test_ops = {
-	.expected_ioctls = ANON_EXPECTED_IOCTLS,
+	.expected_ioctls = SHMEM_EXPECTED_IOCTLS,
 	.allocate_area	= shmem_allocate_area,
 	.release_pages	= shmem_release_pages,
 	.alias_mapping = noop_alias_mapping,
@@ -298,6 +327,21 @@ static int my_bcmp(char *str1, char *str2, size_t n)
 	return 0;
 }
 
+static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
+{
+	struct uffdio_writeprotect prms = { 0 };
+
+	/* Write protection page faults */
+	prms.range.start = start;
+	prms.range.len = len;
+	/* Undo write-protect, do wakeup after that */
+	prms.mode = wp ? UFFDIO_WRITEPROTECT_MODE_WP : 0;
+
+	if (ioctl(ufd, UFFDIO_WRITEPROTECT, &prms))
+		fprintf(stderr, "clear WP failed for address 0x%Lx\n",
+			start), exit(1);
+}
+
 static void *locking_thread(void *arg)
 {
 	unsigned long cpu = (unsigned long) arg;
@@ -436,7 +480,10 @@ static int __copy_page(int ufd, unsigned long offset, bool retry)
 	uffdio_copy.dst = (unsigned long) area_dst + offset;
 	uffdio_copy.src = (unsigned long) area_src + offset;
 	uffdio_copy.len = page_size;
-	uffdio_copy.mode = 0;
+	if (test_uffdio_wp)
+		uffdio_copy.mode = UFFDIO_COPY_MODE_WP;
+	else
+		uffdio_copy.mode = 0;
 	uffdio_copy.copy = 0;
 	if (ioctl(ufd, UFFDIO_COPY, &uffdio_copy)) {
 		/* real retval in ufdio_copy.copy */
@@ -493,15 +540,21 @@ static void uffd_handle_page_fault(struct uffd_msg *msg,
 		fprintf(stderr, "unexpected msg event %u\n",
 			msg->event), exit(1);
 
-	if (bounces & BOUNCE_VERIFY &&
-	    msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
-		fprintf(stderr, "unexpected write fault\n"), exit(1);
+	if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP) {
+		wp_range(uffd, msg->arg.pagefault.address, page_size, false);
+		stats->wp_faults++;
+	} else {
+		/* Missing page faults */
+		if (bounces & BOUNCE_VERIFY &&
+		    msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
+			fprintf(stderr, "unexpected write fault\n"), exit(1);
 
-	offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
-	offset &= ~(page_size-1);
+		offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
+		offset &= ~(page_size-1);
 
-	if (copy_page(uffd, offset))
-		stats->missing_faults++;
+		if (copy_page(uffd, offset))
+			stats->missing_faults++;
+	}
 }
 
 static void *uffd_poll_thread(void *arg)
@@ -587,11 +640,30 @@ static void *uffd_read_thread(void *arg)
 static void *background_thread(void *arg)
 {
 	unsigned long cpu = (unsigned long) arg;
-	unsigned long page_nr;
+	unsigned long page_nr, start_nr, mid_nr, end_nr;
+
+	start_nr = cpu * nr_pages_per_cpu;
+	end_nr = (cpu+1) * nr_pages_per_cpu;
+	mid_nr = (start_nr + end_nr) / 2;
+
+	/* Copy the first half of the pages */
+	for (page_nr = start_nr; page_nr < mid_nr; page_nr++)
+		copy_page_retry(uffd, page_nr * page_size);
 
-	for (page_nr = cpu * nr_pages_per_cpu;
-	     page_nr < (cpu+1) * nr_pages_per_cpu;
-	     page_nr++)
+	/*
+	 * If we need to test uffd-wp, set it up now.  Then we'll have
+	 * at least the first half of the pages mapped already which
+	 * can be write-protected for testing
+	 */
+	if (test_uffdio_wp)
+		wp_range(uffd, (unsigned long)area_dst + start_nr * page_size,
+			nr_pages_per_cpu * page_size, true);
+
+	/*
+	 * Continue the 2nd half of the page copying, handling write
+	 * protection faults if any
+	 */
+	for (page_nr = mid_nr; page_nr < end_nr; page_nr++)
 		copy_page_retry(uffd, page_nr * page_size);
 
 	return NULL;
@@ -753,17 +825,31 @@ static int faulting_process(int signal_test)
 	}
 
 	for (nr = 0; nr < split_nr_pages; nr++) {
+		int steps = 1;
+		unsigned long offset = nr * page_size;
+
 		if (signal_test) {
 			if (sigsetjmp(*sigbuf, 1) != 0) {
-				if (nr == lastnr) {
+				if (steps == 1 && nr == lastnr) {
 					fprintf(stderr, "Signal repeated\n");
 					return 1;
 				}
 
 				lastnr = nr;
 				if (signal_test == 1) {
-					if (copy_page(uffd, nr * page_size))
-						signalled++;
+					if (steps == 1) {
+						/* This is a MISSING request */
+						steps++;
+						if (copy_page(uffd, offset))
+							signalled++;
+					} else {
+						/* This is a WP request */
+						assert(steps == 2);
+						wp_range(uffd,
+							 (__u64)area_dst +
+							 offset,
+							 page_size, false);
+					}
 				} else {
 					signalled++;
 					continue;
@@ -776,8 +862,13 @@ static int faulting_process(int signal_test)
 			fprintf(stderr,
 				"nr %lu memory corruption %Lu %Lu\n",
 				nr, count,
-				count_verify[nr]), exit(1);
-		}
+				count_verify[nr]);
+	        }
+		/*
+		 * Trigger write protection if there is by writting
+		 * the same value back.
+		 */
+		*area_count(area_dst, nr) = count;
 	}
 
 	if (signal_test)
@@ -799,6 +890,11 @@ static int faulting_process(int signal_test)
 				nr, count,
 				count_verify[nr]), exit(1);
 		}
+		/*
+		 * Trigger write protection if there is by writting
+		 * the same value back.
+		 */
+		*area_count(area_dst, nr) = count;
 	}
 
 	if (uffd_test_ops->release_pages(area_dst))
@@ -902,6 +998,8 @@ static int userfaultfd_zeropage_test(void)
 	uffdio_register.range.start = (unsigned long) area_dst;
 	uffdio_register.range.len = nr_pages * page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	if (test_uffdio_wp)
+		uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		fprintf(stderr, "register failure\n"), exit(1);
 
@@ -947,6 +1045,8 @@ static int userfaultfd_events_test(void)
 	uffdio_register.range.start = (unsigned long) area_dst;
 	uffdio_register.range.len = nr_pages * page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	if (test_uffdio_wp)
+		uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		fprintf(stderr, "register failure\n"), exit(1);
 
@@ -977,7 +1077,8 @@ static int userfaultfd_events_test(void)
 		return 1;
 
 	close(uffd);
-	printf("userfaults: %ld\n", stats.missing_faults);
+
+	uffd_stats_report(&stats, 1);
 
 	return stats.missing_faults != nr_pages;
 }
@@ -1007,6 +1108,8 @@ static int userfaultfd_sig_test(void)
 	uffdio_register.range.start = (unsigned long) area_dst;
 	uffdio_register.range.len = nr_pages * page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	if (test_uffdio_wp)
+		uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
 		fprintf(stderr, "register failure\n"), exit(1);
 
@@ -1139,6 +1242,8 @@ static int userfaultfd_stress(void)
 		uffdio_register.range.start = (unsigned long) area_dst;
 		uffdio_register.range.len = nr_pages * page_size;
 		uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+		if (test_uffdio_wp)
+			uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
 		if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register)) {
 			fprintf(stderr, "register failure\n");
 			return 1;
@@ -1193,6 +1298,11 @@ static int userfaultfd_stress(void)
 		if (stress(uffd_stats))
 			return 1;
 
+		/* Clear all the write protections if there is any */
+		if (test_uffdio_wp)
+			wp_range(uffd, (unsigned long)area_dst,
+				 nr_pages * page_size, false);
+
 		/* unregister */
 		if (ioctl(uffd, UFFDIO_UNREGISTER, &uffdio_register.range)) {
 			fprintf(stderr, "unregister failure\n");
@@ -1231,10 +1341,7 @@ static int userfaultfd_stress(void)
 		area_src_alias = area_dst_alias;
 		area_dst_alias = tmp_area;
 
-		printf("userfaults:");
-		for (cpu = 0; cpu < nr_cpus; cpu++)
-			printf(" %lu", uffd_stats[cpu].missing_faults);
-		printf("\n");
+		uffd_stats_report(uffd_stats, nr_cpus);
 	}
 
 	if (err)
@@ -1274,6 +1381,8 @@ static void set_test_type(const char *type)
 	if (!strcmp(type, "anon")) {
 		test_type = TEST_ANON;
 		uffd_test_ops = &anon_uffd_test_ops;
+		/* Only enable write-protect test for anonymous test */
+		test_uffdio_wp = true;
 	} else if (!strcmp(type, "hugetlb")) {
 		test_type = TEST_HUGETLB;
 		uffd_test_ops = &hugetlb_uffd_test_ops;
-- 
2.24.1

