Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFC5C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D382208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgDMMw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:52:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:52674 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729545AbgDMMw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:52:26 -0400
IronPort-SDR: i4TBDX0gXk7RewAvWF1UZqhD6Zmm6gNPuwfjH0lzbY3Tpvz+pkTY+HCIcMK5bwtC9xndImT3qD
 o6ire0W5U5vw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 05:52:25 -0700
IronPort-SDR: dKxmAtmq7D8o917UyCFHbRHwuEhaL9V89NVIrOSilNXQI0KVXdoUAnAXBGWH3P5wqh7fW3xaQh
 ixmPtiOnpsOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="453149573"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 Apr 2020 05:52:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id C8FA395; Mon, 13 Apr 2020 15:52:21 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3, RESEND 1/8] khugepaged: Add self test
Date:   Mon, 13 Apr 2020 15:52:13 +0300
Message-Id: <20200413125220.663-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test checks if khugepaged is able to recover huge page where we
expect to do so. It only covers anon-THP for now.

Currently the test shows few failures. They are going to be addressed by
the following patches.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 tools/testing/selftests/vm/Makefile     |   1 +
 tools/testing/selftests/vm/khugepaged.c | 899 ++++++++++++++++++++++++
 2 files changed, 900 insertions(+)
 create mode 100644 tools/testing/selftests/vm/khugepaged.c

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 7f9a8a8c31da..981d0dc21f9e 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -18,6 +18,7 @@ TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
+TEST_GEN_FILES += khugepaged
 
 ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
 TEST_GEN_FILES += va_128TBswitch
diff --git a/tools/testing/selftests/vm/khugepaged.c b/tools/testing/selftests/vm/khugepaged.c
new file mode 100644
index 000000000000..34d945e71e2e
--- /dev/null
+++ b/tools/testing/selftests/vm/khugepaged.c
@@ -0,0 +1,899 @@
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <limits.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/mman.h>
+#include <sys/wait.h>
+
+#ifndef MADV_PAGEOUT
+#define MADV_PAGEOUT 21
+#endif
+
+#define BASE_ADDR ((void *)(1UL << 30))
+static unsigned long hpage_pmd_size;
+static unsigned long page_size;
+static int hpage_pmd_nr;
+
+#define THP_SYSFS "/sys/kernel/mm/transparent_hugepage/"
+
+enum thp_enabled {
+	THP_ALWAYS,
+	THP_MADVISE,
+	THP_NEVER,
+};
+
+static const char *thp_enabled_strings[] = {
+	"always",
+	"madvise",
+	"never",
+	NULL
+};
+
+enum thp_defrag {
+	THP_DEFRAG_ALWAYS,
+	THP_DEFRAG_DEFER,
+	THP_DEFRAG_DEFER_MADVISE,
+	THP_DEFRAG_MADVISE,
+	THP_DEFRAG_NEVER,
+};
+
+static const char *thp_defrag_strings[] = {
+	"always",
+	"defer",
+	"defer+madvise",
+	"madvise",
+	"never",
+	NULL
+};
+
+enum shmem_enabled {
+	SHMEM_ALWAYS,
+	SHMEM_WITHIN_SIZE,
+	SHMEM_ADVISE,
+	SHMEM_NEVER,
+	SHMEM_DENY,
+	SHMEM_FORCE,
+};
+
+static const char *shmem_enabled_strings[] = {
+	"always",
+	"within_size",
+	"advise",
+	"never",
+	"deny",
+	"force",
+	NULL
+};
+
+struct khugepaged_settings {
+	bool defrag;
+	unsigned int alloc_sleep_millisecs;
+	unsigned int scan_sleep_millisecs;
+	unsigned int max_ptes_none;
+	unsigned int max_ptes_swap;
+	unsigned long pages_to_scan;
+};
+
+struct settings {
+	enum thp_enabled thp_enabled;
+	enum thp_defrag thp_defrag;
+	enum shmem_enabled shmem_enabled;
+	bool debug_cow;
+	bool use_zero_page;
+	struct khugepaged_settings khugepaged;
+};
+
+static struct settings default_settings = {
+	.thp_enabled = THP_MADVISE,
+	.thp_defrag = THP_DEFRAG_ALWAYS,
+	.shmem_enabled = SHMEM_NEVER,
+	.debug_cow = 0,
+	.use_zero_page = 0,
+	.khugepaged = {
+		.defrag = 1,
+		.alloc_sleep_millisecs = 10,
+		.scan_sleep_millisecs = 10,
+	},
+};
+
+static struct settings saved_settings;
+static bool skip_settings_restore;
+
+static int exit_status;
+
+static void success(const char *msg)
+{
+	printf(" \e[32m%s\e[0m\n", msg);
+}
+
+static void fail(const char *msg)
+{
+	printf(" \e[31m%s\e[0m\n", msg);
+	exit_status++;
+}
+
+static int read_file(const char *path, char *buf, size_t buflen)
+{
+	int fd;
+	ssize_t numread;
+
+	fd = open(path, O_RDONLY);
+	if (fd == -1)
+		return 0;
+
+	numread = read(fd, buf, buflen - 1);
+	if (numread < 1) {
+		close(fd);
+		return 0;
+	}
+
+	buf[numread] = '\0';
+	close(fd);
+
+	return (unsigned int) numread;
+}
+
+static int write_file(const char *path, const char *buf, size_t buflen)
+{
+	int fd;
+	ssize_t numwritten;
+
+	fd = open(path, O_WRONLY);
+	if (fd == -1)
+		return 0;
+
+	numwritten = write(fd, buf, buflen - 1);
+	close(fd);
+	if (numwritten < 1)
+		return 0;
+
+	return (unsigned int) numwritten;
+}
+
+static int read_string(const char *name, const char *strings[])
+{
+	char path[PATH_MAX];
+	char buf[256];
+	char *c;
+	int ret;
+
+	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
+	if (ret >= PATH_MAX) {
+		printf("%s: Pathname is too long\n", __func__);
+		exit(EXIT_FAILURE);
+	}
+
+	if (!read_file(path, buf, sizeof(buf))) {
+		perror(path);
+		exit(EXIT_FAILURE);
+	}
+
+	c = strchr(buf, '[');
+	if (!c) {
+		printf("%s: Parse failure\n", __func__);
+		exit(EXIT_FAILURE);
+	}
+
+	c++;
+	memmove(buf, c, sizeof(buf) - (c - buf));
+
+	c = strchr(buf, ']');
+	if (!c) {
+		printf("%s: Parse failure\n", __func__);
+		exit(EXIT_FAILURE);
+	}
+	*c = '\0';
+
+	ret = 0;
+	while (strings[ret]) {
+		if (!strcmp(strings[ret], buf))
+			return ret;
+		ret++;
+	}
+
+	printf("Failed to parse %s\n", name);
+	exit(EXIT_FAILURE);
+}
+
+static void write_string(const char *name, const char *val)
+{
+	char path[PATH_MAX];
+	int ret;
+
+	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
+	if (ret >= PATH_MAX) {
+		printf("%s: Pathname is too long\n", __func__);
+		exit(EXIT_FAILURE);
+	}
+
+	if (!write_file(path, val, strlen(val) + 1)) {
+		perror(path);
+		exit(EXIT_FAILURE);
+	}
+}
+
+static const unsigned long read_num(const char *name)
+{
+	char path[PATH_MAX];
+	char buf[21];
+	int ret;
+
+	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
+	if (ret >= PATH_MAX) {
+		printf("%s: Pathname is too long\n", __func__);
+		exit(EXIT_FAILURE);
+	}
+
+	ret = read_file(path, buf, sizeof(buf));
+	if (ret < 0) {
+		perror("read_file(read_num)");
+		exit(EXIT_FAILURE);
+	}
+
+	return strtoul(buf, NULL, 10);
+}
+
+static void write_num(const char *name, unsigned long num)
+{
+	char path[PATH_MAX];
+	char buf[21];
+	int ret;
+
+	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
+	if (ret >= PATH_MAX) {
+		printf("%s: Pathname is too long\n", __func__);
+		exit(EXIT_FAILURE);
+	}
+
+	sprintf(buf, "%ld", num);
+	if (!write_file(path, buf, strlen(buf) + 1)) {
+		perror(path);
+		exit(EXIT_FAILURE);
+	}
+}
+
+static void write_settings(struct settings *settings)
+{
+	struct khugepaged_settings *khugepaged = &settings->khugepaged;
+
+	write_string("enabled", thp_enabled_strings[settings->thp_enabled]);
+	write_string("defrag", thp_defrag_strings[settings->thp_defrag]);
+	write_string("shmem_enabled",
+			shmem_enabled_strings[settings->shmem_enabled]);
+	write_num("debug_cow", settings->debug_cow);
+	write_num("use_zero_page", settings->use_zero_page);
+
+	write_num("khugepaged/defrag", khugepaged->defrag);
+	write_num("khugepaged/alloc_sleep_millisecs",
+			khugepaged->alloc_sleep_millisecs);
+	write_num("khugepaged/scan_sleep_millisecs",
+			khugepaged->scan_sleep_millisecs);
+	write_num("khugepaged/max_ptes_none", khugepaged->max_ptes_none);
+	write_num("khugepaged/max_ptes_swap", khugepaged->max_ptes_swap);
+	write_num("khugepaged/pages_to_scan", khugepaged->pages_to_scan);
+}
+
+static void restore_settings(int sig)
+{
+	if (skip_settings_restore)
+		goto out;
+
+	printf("Restore THP and khugepaged settings...");
+	write_settings(&saved_settings);
+	success("OK");
+	if (sig)
+		exit(EXIT_FAILURE);
+out:
+	exit(exit_status);
+}
+
+static void save_settings(void)
+{
+	printf("Save THP and khugepaged settings...");
+	saved_settings = (struct settings) {
+		.thp_enabled = read_string("enabled", thp_enabled_strings),
+		.thp_defrag = read_string("defrag", thp_defrag_strings),
+		.shmem_enabled =
+			read_string("shmem_enabled", shmem_enabled_strings),
+		.debug_cow = read_num("debug_cow"),
+		.use_zero_page = read_num("use_zero_page"),
+	};
+	saved_settings.khugepaged = (struct khugepaged_settings) {
+		.defrag = read_num("khugepaged/defrag"),
+		.alloc_sleep_millisecs =
+			read_num("khugepaged/alloc_sleep_millisecs"),
+		.scan_sleep_millisecs =
+			read_num("khugepaged/scan_sleep_millisecs"),
+		.max_ptes_none = read_num("khugepaged/max_ptes_none"),
+		.max_ptes_swap = read_num("khugepaged/max_ptes_swap"),
+		.pages_to_scan = read_num("khugepaged/pages_to_scan"),
+	};
+	success("OK");
+
+	signal(SIGTERM, restore_settings);
+	signal(SIGINT, restore_settings);
+	signal(SIGHUP, restore_settings);
+	signal(SIGQUIT, restore_settings);
+}
+
+static void adjust_settings(void)
+{
+
+	printf("Adjust settings...");
+	write_settings(&default_settings);
+	success("OK");
+}
+
+#define CHECK_HUGE_FMT "sed -ne " \
+	"'/^%lx/,/^AnonHugePages/{/^AnonHugePages:\\s*%ld kB/ q1}' " \
+	"/proc/%d/smaps"
+
+static bool check_huge(void *p)
+{
+	char *cmd;
+	int ret;
+
+	ret = asprintf(&cmd, CHECK_HUGE_FMT,
+			(unsigned long)p, hpage_pmd_size >> 10, getpid());
+	if (ret < 0) {
+		perror("asprintf(CHECK_FMT)");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = system(cmd);
+	free(cmd);
+	if (ret < 0 || !WIFEXITED(ret)) {
+		perror("system(check_huge)");
+		exit(EXIT_FAILURE);
+	}
+
+	return WEXITSTATUS(ret);
+}
+
+#define CHECK_SWAP_FMT "sed -ne " \
+	"'/^%lx/,/^Swap:/{/^Swap:\\s*%ld kB/ q1}' " \
+	"/proc/%d/smaps"
+
+static bool check_swap(void *p, unsigned long size)
+{
+	char *cmd;
+	int ret;
+
+	ret = asprintf(&cmd, CHECK_SWAP_FMT,
+			(unsigned long)p, size >> 10, getpid());
+	if (ret < 0) {
+		perror("asprintf(CHECK_SWAP)");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = system(cmd);
+	free(cmd);
+	if (ret < 0 || !WIFEXITED(ret)) {
+		perror("system(check_swap)");
+		exit(EXIT_FAILURE);
+	}
+
+	return WEXITSTATUS(ret);
+}
+
+static void *alloc_mapping(void)
+{
+	void *p;
+
+	p = mmap(BASE_ADDR, hpage_pmd_size, PROT_READ | PROT_WRITE,
+			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (p != BASE_ADDR) {
+		printf("Failed to allocate VMA at %p\n", BASE_ADDR);
+		exit(EXIT_FAILURE);
+	}
+
+	return p;
+}
+
+static void fill_memory(int *p, unsigned long start, unsigned long end)
+{
+	int i;
+
+	for (i = start / page_size; i < end / page_size; i++)
+		p[i * page_size / sizeof(*p)] = i + 0xdead0000;
+}
+
+static void validate_memory(int *p, unsigned long start, unsigned long end)
+{
+	int i;
+
+	for (i = start / page_size; i < end / page_size; i++) {
+		if (p[i * page_size / sizeof(*p)] != i + 0xdead0000) {
+			printf("Page %d is corrupted: %#x\n",
+					i, p[i * page_size / sizeof(*p)]);
+			exit(EXIT_FAILURE);
+		}
+	}
+}
+
+#define TICK 500000
+static bool wait_for_scan(const char *msg, char *p)
+{
+	int full_scans;
+	int timeout = 6; /* 3 seconds */
+
+	/* Sanity check */
+	if (check_huge(p)) {
+		printf("Unexpected huge page\n");
+		exit(EXIT_FAILURE);
+	}
+
+	madvise(p, hpage_pmd_size, MADV_HUGEPAGE);
+
+	/* Wait until the second full_scan completed */
+	full_scans = read_num("khugepaged/full_scans") + 2;
+
+	printf("%s...", msg);
+	while (timeout--) {
+		if (check_huge(p))
+			break;
+		if (read_num("khugepaged/full_scans") >= full_scans)
+			break;
+		printf(".");
+		usleep(TICK);
+	}
+
+	madvise(p, hpage_pmd_size, MADV_NOHUGEPAGE);
+
+	return !timeout;
+}
+
+static void alloc_at_fault(void)
+{
+	struct settings settings = default_settings;
+	char *p;
+
+	settings.thp_enabled = THP_ALWAYS;
+	write_settings(&settings);
+
+	p = alloc_mapping();
+	*p = 1;
+	printf("Allocate huge page on fault...");
+	if (check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+
+	write_settings(&default_settings);
+
+	madvise(p, page_size, MADV_DONTNEED);
+	printf("Split huge PMD on MADV_DONTNEED...");
+	if (!check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+	munmap(p, hpage_pmd_size);
+}
+
+static void collapse_full(void)
+{
+	void *p;
+
+	p = alloc_mapping();
+	fill_memory(p, 0, hpage_pmd_size);
+	if (wait_for_scan("Collapse fully populated PTE table", p))
+		fail("Timeout");
+	else if (check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+	validate_memory(p, 0, hpage_pmd_size);
+	munmap(p, hpage_pmd_size);
+}
+
+static void collapse_empty(void)
+{
+	void *p;
+
+	p = alloc_mapping();
+	if (wait_for_scan("Do not collapse empty PTE table", p))
+		fail("Timeout");
+	else if (check_huge(p))
+		fail("Fail");
+	else
+		success("OK");
+	munmap(p, hpage_pmd_size);
+}
+
+static void collapse_single_pte_entry(void)
+{
+	void *p;
+
+	p = alloc_mapping();
+	fill_memory(p, 0, page_size);
+	if (wait_for_scan("Collapse PTE table with single PTE entry present", p))
+		fail("Timeout");
+	else if (check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+	validate_memory(p, 0, page_size);
+	munmap(p, hpage_pmd_size);
+}
+
+static void collapse_max_ptes_none(void)
+{
+	int max_ptes_none = hpage_pmd_nr / 2;
+	struct settings settings = default_settings;
+	void *p;
+
+	settings.khugepaged.max_ptes_none = max_ptes_none;
+	write_settings(&settings);
+
+	p = alloc_mapping();
+
+	fill_memory(p, 0, (hpage_pmd_nr - max_ptes_none - 1) * page_size);
+	if (wait_for_scan("Do not collapse with max_ptes_none exeeded", p))
+		fail("Timeout");
+	else if (check_huge(p))
+		fail("Fail");
+	else
+		success("OK");
+	validate_memory(p, 0, (hpage_pmd_nr - max_ptes_none - 1) * page_size);
+
+	fill_memory(p, 0, (hpage_pmd_nr - max_ptes_none) * page_size);
+	if (wait_for_scan("Collapse with max_ptes_none PTEs empty", p))
+		fail("Timeout");
+	else if (check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+	validate_memory(p, 0, (hpage_pmd_nr - max_ptes_none) * page_size);
+
+	munmap(p, hpage_pmd_size);
+	write_settings(&default_settings);
+}
+
+static void collapse_swapin_single_pte(void)
+{
+	void *p;
+	p = alloc_mapping();
+	fill_memory(p, 0, hpage_pmd_size);
+
+	printf("Swapout one page...");
+	if (madvise(p, page_size, MADV_PAGEOUT)) {
+		perror("madvise(MADV_PAGEOUT)");
+		exit(EXIT_FAILURE);
+	}
+	if (check_swap(p, page_size)) {
+		success("OK");
+	} else {
+		fail("Fail");
+		goto out;
+	}
+
+	if (wait_for_scan("Collapse with swaping in single PTE entry", p))
+		fail("Timeout");
+	else if (check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+	validate_memory(p, 0, hpage_pmd_size);
+out:
+	munmap(p, hpage_pmd_size);
+}
+
+static void collapse_max_ptes_swap(void)
+{
+	int max_ptes_swap = read_num("khugepaged/max_ptes_swap");
+	void *p;
+
+	p = alloc_mapping();
+
+	fill_memory(p, 0, hpage_pmd_size);
+	printf("Swapout %d of %d pages...", max_ptes_swap + 1, hpage_pmd_nr);
+	if (madvise(p, (max_ptes_swap + 1) * page_size, MADV_PAGEOUT)) {
+		perror("madvise(MADV_PAGEOUT)");
+		exit(EXIT_FAILURE);
+	}
+	if (check_swap(p, (max_ptes_swap + 1) * page_size)) {
+		success("OK");
+	} else {
+		fail("Fail");
+		goto out;
+	}
+
+	if (wait_for_scan("Do not collapse with max_ptes_swap exeeded", p))
+		fail("Timeout");
+	else if (check_huge(p))
+		fail("Fail");
+	else
+		success("OK");
+	validate_memory(p, 0, hpage_pmd_size);
+
+	fill_memory(p, 0, hpage_pmd_size);
+	printf("Swapout %d of %d pages...", max_ptes_swap, hpage_pmd_nr);
+	if (madvise(p, max_ptes_swap * page_size, MADV_PAGEOUT)) {
+		perror("madvise(MADV_PAGEOUT)");
+		exit(EXIT_FAILURE);
+	}
+	if (check_swap(p, max_ptes_swap * page_size)) {
+		success("OK");
+	} else {
+		fail("Fail");
+		goto out;
+	}
+
+	if (wait_for_scan("Collapse with max_ptes_swap pages swapped out", p))
+		fail("Timeout");
+	else if (check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+	validate_memory(p, 0, hpage_pmd_size);
+out:
+	munmap(p, hpage_pmd_size);
+}
+
+static void collapse_single_pte_entry_compound(void)
+{
+	void *p;
+
+	p = alloc_mapping();
+
+	printf("Allocate huge page...");
+	madvise(p, hpage_pmd_size, MADV_HUGEPAGE);
+	fill_memory(p, 0, hpage_pmd_size);
+	if (check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+	madvise(p, hpage_pmd_size, MADV_NOHUGEPAGE);
+
+	printf("Split huge page leaving single PTE mapping compount page...");
+	madvise(p + page_size, hpage_pmd_size - page_size, MADV_DONTNEED);
+	if (!check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+
+	if (wait_for_scan("Collapse PTE table with single PTE mapping compount page", p))
+		fail("Timeout");
+	else if (check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+	validate_memory(p, 0, page_size);
+	munmap(p, hpage_pmd_size);
+}
+
+static void collapse_full_of_compound(void)
+{
+	void *p;
+
+	p = alloc_mapping();
+
+	printf("Allocate huge page...");
+	madvise(p, hpage_pmd_size, MADV_HUGEPAGE);
+	fill_memory(p, 0, hpage_pmd_size);
+	if (check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+
+	printf("Split huge page leaving single PTE page table full of compount pages...");
+	madvise(p, page_size, MADV_NOHUGEPAGE);
+	madvise(p, hpage_pmd_size, MADV_NOHUGEPAGE);
+	if (!check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+
+	if (wait_for_scan("Collapse PTE table full of compound pages", p))
+		fail("Timeout");
+	else if (check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+	validate_memory(p, 0, hpage_pmd_size);
+	munmap(p, hpage_pmd_size);
+}
+
+static void collapse_compound_extreme(void)
+{
+	void *p;
+	int i;
+
+	p = alloc_mapping();
+	for (i = 0; i < hpage_pmd_nr; i++) {
+		printf("\rConstruct PTE page table full of different PTE-mapped compound pages %3d/%d...",
+				i + 1, hpage_pmd_nr);
+
+		madvise(BASE_ADDR, hpage_pmd_size, MADV_HUGEPAGE);
+		fill_memory(BASE_ADDR, 0, hpage_pmd_size);
+		if (!check_huge(BASE_ADDR)) {
+			printf("Failed to allocate huge page\n");
+			exit(EXIT_FAILURE);
+		}
+		madvise(BASE_ADDR, hpage_pmd_size, MADV_NOHUGEPAGE);
+
+		p = mremap(BASE_ADDR - i * page_size,
+				i * page_size + hpage_pmd_size,
+				(i + 1) * page_size,
+				MREMAP_MAYMOVE | MREMAP_FIXED,
+				BASE_ADDR + 2 * hpage_pmd_size);
+		if (p == MAP_FAILED) {
+			perror("mremap+unmap");
+			exit(EXIT_FAILURE);
+		}
+
+		p = mremap(BASE_ADDR + 2 * hpage_pmd_size,
+				(i + 1) * page_size,
+				(i + 1) * page_size + hpage_pmd_size,
+				MREMAP_MAYMOVE | MREMAP_FIXED,
+				BASE_ADDR - (i + 1) * page_size);
+		if (p == MAP_FAILED) {
+			perror("mremap+alloc");
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	munmap(BASE_ADDR, hpage_pmd_size);
+	fill_memory(p, 0, hpage_pmd_size);
+	if (!check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+
+	if (wait_for_scan("Collapse PTE table full of different compound pages", p))
+		fail("Timeout");
+	else if (check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+
+	validate_memory(p, 0, hpage_pmd_size);
+	munmap(p, hpage_pmd_size);
+}
+
+static void collapse_fork(void)
+{
+	int wstatus;
+	void *p;
+
+	p = alloc_mapping();
+
+	printf("Allocate small page...");
+	fill_memory(p, 0, page_size);
+	if (!check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+
+	printf("Share small page over fork()...");
+	if (!fork()) {
+		/* Do not touch settings on child exit */
+		skip_settings_restore = true;
+		exit_status = 0;
+
+		if (!check_huge(p))
+			success("OK");
+		else
+			fail("Fail");
+
+		fill_memory(p, page_size, 2 * page_size);
+
+		if (wait_for_scan("Collapse PTE table with single page shared with parent process", p))
+			fail("Timeout");
+		else if (check_huge(p))
+			success("OK");
+		else
+			fail("Fail");
+
+		validate_memory(p, 0, page_size);
+		munmap(p, hpage_pmd_size);
+		exit(exit_status);
+	}
+
+	wait(&wstatus);
+	exit_status += WEXITSTATUS(wstatus);
+
+	printf("Check if parent still has small page...");
+	if (!check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+	validate_memory(p, 0, page_size);
+	munmap(p, hpage_pmd_size);
+}
+
+static void collapse_fork_compound(void)
+{
+	int wstatus;
+	void *p;
+
+	p = alloc_mapping();
+
+	printf("Allocate huge page...");
+	madvise(p, hpage_pmd_size, MADV_HUGEPAGE);
+	fill_memory(p, 0, hpage_pmd_size);
+	if (check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+
+	printf("Share huge page over fork()...");
+	if (!fork()) {
+		/* Do not touch settings on child exit */
+		skip_settings_restore = true;
+		exit_status = 0;
+
+		if (check_huge(p))
+			success("OK");
+		else
+			fail("Fail");
+
+		printf("Split huge page PMD in child process...");
+		madvise(p, page_size, MADV_NOHUGEPAGE);
+		madvise(p, hpage_pmd_size, MADV_NOHUGEPAGE);
+		if (!check_huge(p))
+			success("OK");
+		else
+			fail("Fail");
+		fill_memory(p, 0, page_size);
+
+		if (wait_for_scan("Collapse PTE table full of compound pages in child", p))
+			fail("Timeout");
+		else if (check_huge(p))
+			success("OK");
+		else
+			fail("Fail");
+
+		validate_memory(p, 0, hpage_pmd_size);
+		munmap(p, hpage_pmd_size);
+		exit(exit_status);
+	}
+
+	wait(&wstatus);
+	exit_status += WEXITSTATUS(wstatus);
+
+	printf("Check if parent still has huge page...");
+	if (check_huge(p))
+		success("OK");
+	else
+		fail("Fail");
+	validate_memory(p, 0, hpage_pmd_size);
+	munmap(p, hpage_pmd_size);
+}
+
+int main(void)
+{
+	setbuf(stdout, NULL);
+
+	page_size = getpagesize();
+	hpage_pmd_size = read_num("hpage_pmd_size");
+	hpage_pmd_nr = hpage_pmd_size / page_size;
+
+	default_settings.khugepaged.max_ptes_none = hpage_pmd_nr - 1;
+	default_settings.khugepaged.max_ptes_swap = hpage_pmd_nr / 8;
+	default_settings.khugepaged.pages_to_scan = hpage_pmd_nr * 8;
+
+	save_settings();
+	adjust_settings();
+
+	alloc_at_fault();
+	collapse_full();
+	collapse_empty();
+	collapse_single_pte_entry();
+	collapse_max_ptes_none();
+	collapse_swapin_single_pte();
+	collapse_max_ptes_swap();
+	collapse_single_pte_entry_compound();
+	collapse_full_of_compound();
+	collapse_compound_extreme();
+	collapse_fork();
+	collapse_fork_compound();
+
+	restore_settings(0);
+}
-- 
2.26.0

