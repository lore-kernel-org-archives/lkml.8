Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691ACC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CA3206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgCEWpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:45:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:5017 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbgCEWps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:45:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 14:45:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,519,1574150400"; 
   d="scan'208";a="234674613"
Received: from minkleyx-mobl1.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.252.207.66])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2020 14:45:47 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 07/27] tools/power/x86/intel-speed-select: Store topology information
Date:   Thu,  5 Mar 2020 14:45:18 -0800
Message-Id: <20200305224538.490864-8-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
References: <20200305224538.490864-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the CPU is offline, the topology information (core-id, package-id,
die-id) is not accessible via sysfs. So when user selects a config level
more than base config 0 and offlined CPUs to match the config level,
to return to base config he has to manually online CPUs before. Without
this CPUs information mapping from Punit CPU numbering will lot work
as it needs atlest package id for each CPU.

To avoid this additional steps store the topology information in a file
, which is created on the very first run after boot. Since system boots
in base config and all CPUs are online, we can get information about
every CPU.

Once any of the APIs like get_physical_package_id(),
get_physical_core_id() or get_physical_die_id() fails to read from
sysfs, read from the stored mapping file.

This mapping file is stored in /tmp file system. so on every boot
it is recreated to make sure that any new CPUs are added to the
system before boot are taken into account.

But don't use the stored physical device id  when trying to get
information for CPU to send message in for_each_online_package_in_set().
Here use the real value from syfs and in case fails try the next CPU.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel-speed-select/isst-config.c      | 143 ++++++++++++++++--
 1 file changed, 132 insertions(+), 11 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index c773c6cc02a5..4773970cda9b 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -62,6 +62,13 @@ struct _cpu_map {
 };
 struct _cpu_map *cpu_map;
 
+struct cpu_topology {
+	short cpu;
+	short core_id;
+	short pkg_id;
+	short die_id;
+};
+
 void debug_printf(const char *format, ...)
 {
 	va_list args;
@@ -176,25 +183,137 @@ int out_format_is_json(void)
 	return out_format_json;
 }
 
+static int get_stored_topology_info(int cpu, int *core_id, int *pkg_id, int *die_id)
+{
+	const char *pathname = "/tmp/isst_cpu_topology.dat";
+	struct cpu_topology cpu_top;
+	FILE *fp;
+	int ret;
+
+	fp = fopen(pathname, "rb");
+	if (!fp)
+		return -1;
+
+	ret = fseek(fp, cpu * sizeof(cpu_top), SEEK_SET);
+	if (ret)
+		goto err_ret;
+
+	ret = fread(&cpu_top, sizeof(cpu_top), 1, fp);
+	if (ret != 1) {
+		ret = -1;
+		goto err_ret;
+	}
+
+	*pkg_id = cpu_top.pkg_id;
+	*core_id = cpu_top.core_id;
+	*die_id = cpu_top.die_id;
+	ret = 0;
+
+err_ret:
+	fclose(fp);
+
+	return ret;
+}
+
+static void store_cpu_topology(void)
+{
+	const char *pathname = "/tmp/isst_cpu_topology.dat";
+	FILE *fp;
+	int i;
+
+	fp = fopen(pathname, "rb");
+	if (fp) {
+		/* Mapping already exists */
+		fclose(fp);
+		return;
+	}
+
+	fp = fopen(pathname, "wb");
+	if (!fp) {
+		fprintf(stderr, "Can't create file:%s\n", pathname);
+		return;
+	}
+
+	for (i = 0; i < topo_max_cpus; ++i) {
+		struct cpu_topology cpu_top;
+
+		cpu_top.core_id = parse_int_file(0,
+			"/sys/devices/system/cpu/cpu%d/topology/core_id", i);
+		if (cpu_top.core_id < 0)
+			cpu_top.core_id = -1;
+
+		cpu_top.pkg_id = parse_int_file(0,
+			"/sys/devices/system/cpu/cpu%d/topology/physical_package_id", i);
+		if (cpu_top.pkg_id < 0)
+			cpu_top.pkg_id = -1;
+
+		cpu_top.die_id = parse_int_file(0,
+			"/sys/devices/system/cpu/cpu%d/topology/die_id", i);
+		if (cpu_top.die_id < 0)
+			cpu_top.die_id = -1;
+
+		cpu_top.cpu = i;
+
+		if (fwrite(&cpu_top, sizeof(cpu_top), 1, fp) != 1) {
+			fprintf(stderr, "Can't write to:%s\n", pathname);
+			break;
+		}
+	}
+
+	fclose(fp);
+}
+
 int get_physical_package_id(int cpu)
 {
-	return parse_int_file(
-		0, "/sys/devices/system/cpu/cpu%d/topology/physical_package_id",
-		cpu);
+	int ret;
+
+	ret = parse_int_file(0,
+			"/sys/devices/system/cpu/cpu%d/topology/physical_package_id",
+			cpu);
+	if (ret < 0) {
+		int core_id, pkg_id, die_id;
+
+		ret = get_stored_topology_info(cpu, &core_id, &pkg_id, &die_id);
+		if (!ret)
+			return pkg_id;
+	}
+
+	return ret;
 }
 
 int get_physical_core_id(int cpu)
 {
-	return parse_int_file(
-		0, "/sys/devices/system/cpu/cpu%d/topology/core_id", cpu);
+	int ret;
+
+	ret = parse_int_file(0,
+			"/sys/devices/system/cpu/cpu%d/topology/core_id",
+			cpu);
+	if (ret < 0) {
+		int core_id, pkg_id, die_id;
+
+		ret = get_stored_topology_info(cpu, &core_id, &pkg_id, &die_id);
+		if (!ret)
+			return core_id;
+	}
+
+	return ret;
 }
 
 int get_physical_die_id(int cpu)
 {
 	int ret;
 
-	ret = parse_int_file(0, "/sys/devices/system/cpu/cpu%d/topology/die_id",
-			     cpu);
+	ret = parse_int_file(0,
+			"/sys/devices/system/cpu/cpu%d/topology/die_id",
+			cpu);
+	if (ret < 0) {
+		int core_id, pkg_id, die_id;
+
+		ret = get_stored_topology_info(cpu, &core_id, &pkg_id, &die_id);
+		if (!ret)
+			return die_id;
+	}
+
 	if (ret < 0)
 		ret = 0;
 
@@ -266,11 +385,12 @@ static void for_each_online_package_in_set(void (*callback)(int, void *, void *,
 		die_id = get_physical_die_id(i);
 		if (die_id < 0)
 			die_id = 0;
-		pkg_id = get_physical_package_id(i);
-		if (pkg_id < 0) {
-			fprintf(stderr, "Failed to get package id, CPU %d may be offline\n", i);
+
+		pkg_id = parse_int_file(0,
+			"/sys/devices/system/cpu/cpu%d/topology/physical_package_id", i);
+		if (pkg_id < 0)
 			continue;
-		}
+
 		/* Create an unique id for package, die combination to store */
 		pkg_id = (MAX_PACKAGE_COUNT * pkg_id + die_id);
 
@@ -2352,6 +2472,7 @@ static void cmdline(int argc, char **argv)
 	printf("Intel(R) Speed Select Technology\n");
 	printf("Executing on CPU model:%d[0x%x]\n", cpu_model, cpu_model);
 	set_max_cpu_num();
+	store_cpu_topology();
 	set_cpu_present_cpu_mask();
 	set_cpu_target_cpu_mask();
 
-- 
2.24.1

