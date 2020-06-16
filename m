Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CEEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976A5215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgFPMWF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbgFPMV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:21:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4877CC08C5C3;
        Tue, 16 Jun 2020 05:21:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAb4-0004aM-4R; Tue, 16 Jun 2020 14:21:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A334E1C0095;
        Tue, 16 Jun 2020 14:21:45 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:45 -0000
From:   "tip-bot2 for Roman Sudarikov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Expose an Uncore unit to IIO
 PMON mapping
Cc:     kbuild test robot <lkp@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Roman Sudarikov <roman.sudarikov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200601083543.30011-4-alexander.antonov@linux.intel.com>
References: <20200601083543.30011-4-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159231010539.16989.5355439873405205903.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bb42b3d39781d7fcd3be7f9f9bf11b6661b5fdf1
Gitweb:        https://git.kernel.org/tip/bb42b3d39781d7fcd3be7f9f9bf11b6661b5fdf1
Author:        Roman Sudarikov <roman.sudarikov@linux.intel.com>
AuthorDate:    Mon, 01 Jun 2020 11:35:43 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:09:51 +02:00

perf/x86/intel/uncore: Expose an Uncore unit to IIO PMON mapping

Current version supports a server line starting Intel® Xeon® Processor
Scalable Family and introduces mapping for IIO Uncore units only.
Other units can be added on demand.

IIO stack to PMON mapping is exposed through:
    /sys/devices/uncore_iio_<pmu_idx>/dieX
    where dieX is file which holds "Segment:Root Bus" for PCIe root port,
    which can be monitored by that IIO PMON block.

Details are explained in Documentation/ABI/testing/sysfs-devices-mapping

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Link: https://lkml.kernel.org/r/20200601083543.30011-4-alexander.antonov@linux.intel.com
---
 Documentation/ABI/testing/sysfs-devices-mapping |  33 +++-
 arch/x86/events/intel/uncore.h                  |   9 +-
 arch/x86/events/intel/uncore_snbep.c            | 191 +++++++++++++++-
 3 files changed, 233 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-mapping

diff --git a/Documentation/ABI/testing/sysfs-devices-mapping b/Documentation/ABI/testing/sysfs-devices-mapping
new file mode 100644
index 0000000..490ccfd
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-mapping
@@ -0,0 +1,33 @@
+What:           /sys/devices/uncore_iio_x/dieX
+Date:           February 2020
+Contact:        Roman Sudarikov <roman.sudarikov@linux.intel.com>
+Description:
+                Each IIO stack (PCIe root port) has its own IIO PMON block, so
+                each dieX file (where X is die number) holds "Segment:Root Bus"
+                for PCIe root port, which can be monitored by that IIO PMON
+                block.
+                For example, on 4-die Xeon platform with up to 6 IIO stacks per
+                die and, therefore, 6 IIO PMON blocks per die, the mapping of
+                IIO PMON block 0 exposes as the following:
+
+                $ ls /sys/devices/uncore_iio_0/die*
+                -r--r--r-- /sys/devices/uncore_iio_0/die0
+                -r--r--r-- /sys/devices/uncore_iio_0/die1
+                -r--r--r-- /sys/devices/uncore_iio_0/die2
+                -r--r--r-- /sys/devices/uncore_iio_0/die3
+
+                $ tail /sys/devices/uncore_iio_0/die*
+                ==> /sys/devices/uncore_iio_0/die0 <==
+                0000:00
+                ==> /sys/devices/uncore_iio_0/die1 <==
+                0000:40
+                ==> /sys/devices/uncore_iio_0/die2 <==
+                0000:80
+                ==> /sys/devices/uncore_iio_0/die3 <==
+                0000:c0
+
+                Which means:
+                IIO PMU 0 on die 0 belongs to PCI RP on bus 0x00, domain 0x0000
+                IIO PMU 0 on die 1 belongs to PCI RP on bus 0x40, domain 0x0000
+                IIO PMU 0 on die 2 belongs to PCI RP on bus 0x80, domain 0x0000
+                IIO PMU 0 on die 3 belongs to PCI RP on bus 0xc0, domain 0x0000
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 594a2fe..105fdc6 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -182,6 +182,15 @@ int uncore_pcibus_to_physid(struct pci_bus *bus);
 ssize_t uncore_event_show(struct kobject *kobj,
 			  struct kobj_attribute *attr, char *buf);
 
+static inline struct intel_uncore_pmu *dev_to_uncore_pmu(struct device *dev)
+{
+	return container_of(dev_get_drvdata(dev), struct intel_uncore_pmu, pmu);
+}
+
+#define to_device_attribute(n)	container_of(n, struct device_attribute, attr)
+#define to_dev_ext_attribute(n)	container_of(n, struct dev_ext_attribute, attr)
+#define attr_to_ext_attr(n)	to_dev_ext_attribute(to_device_attribute(n))
+
 extern int __uncore_max_dies;
 #define uncore_max_dies()	(__uncore_max_dies)
 
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 045c2d2..62e88ad 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -273,6 +273,30 @@
 #define SKX_CPUNODEID			0xc0
 #define SKX_GIDNIDMAP			0xd4
 
+/*
+ * The CPU_BUS_NUMBER MSR returns the values of the respective CPUBUSNO CSR
+ * that BIOS programmed. MSR has package scope.
+ * |  Bit  |  Default  |  Description
+ * | [63]  |    00h    | VALID - When set, indicates the CPU bus
+ *                       numbers have been initialized. (RO)
+ * |[62:48]|    ---    | Reserved
+ * |[47:40]|    00h    | BUS_NUM_5 — Return the bus number BIOS assigned
+ *                       CPUBUSNO(5). (RO)
+ * |[39:32]|    00h    | BUS_NUM_4 — Return the bus number BIOS assigned
+ *                       CPUBUSNO(4). (RO)
+ * |[31:24]|    00h    | BUS_NUM_3 — Return the bus number BIOS assigned
+ *                       CPUBUSNO(3). (RO)
+ * |[23:16]|    00h    | BUS_NUM_2 — Return the bus number BIOS assigned
+ *                       CPUBUSNO(2). (RO)
+ * |[15:8] |    00h    | BUS_NUM_1 — Return the bus number BIOS assigned
+ *                       CPUBUSNO(1). (RO)
+ * | [7:0] |    00h    | BUS_NUM_0 — Return the bus number BIOS assigned
+ *                       CPUBUSNO(0). (RO)
+ */
+#define SKX_MSR_CPU_BUS_NUMBER		0x300
+#define SKX_MSR_CPU_BUS_VALID_BIT	(1ULL << 63)
+#define BUS_NUM_STRIDE			8
+
 /* SKX CHA */
 #define SKX_CHA_MSR_PMON_BOX_FILTER_TID		(0x1ffULL << 0)
 #define SKX_CHA_MSR_PMON_BOX_FILTER_LINK	(0xfULL << 9)
@@ -3612,6 +3636,170 @@ static struct intel_uncore_ops skx_uncore_iio_ops = {
 	.read_counter		= uncore_msr_read_counter,
 };
 
+static inline u8 skx_iio_stack(struct intel_uncore_pmu *pmu, int die)
+{
+	return pmu->type->topology[die] >> (pmu->pmu_idx * BUS_NUM_STRIDE);
+}
+
+static umode_t
+skx_iio_mapping_visible(struct kobject *kobj, struct attribute *attr, int die)
+{
+	struct intel_uncore_pmu *pmu = dev_to_uncore_pmu(kobj_to_dev(kobj));
+
+	/* Root bus 0x00 is valid only for die 0 AND pmu_idx = 0. */
+	return (!skx_iio_stack(pmu, die) && pmu->pmu_idx) ? 0 : attr->mode;
+}
+
+static ssize_t skx_iio_mapping_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct pci_bus *bus = pci_find_next_bus(NULL);
+	struct intel_uncore_pmu *uncore_pmu = dev_to_uncore_pmu(dev);
+	struct dev_ext_attribute *ea = to_dev_ext_attribute(attr);
+	long die = (long)ea->var;
+
+	/*
+	 * Current implementation is for single segment configuration hence it's
+	 * safe to take the segment value from the first available root bus.
+	 */
+	return sprintf(buf, "%04x:%02x\n", pci_domain_nr(bus),
+					   skx_iio_stack(uncore_pmu, die));
+}
+
+static int skx_msr_cpu_bus_read(int cpu, u64 *topology)
+{
+	u64 msr_value;
+
+	if (rdmsrl_on_cpu(cpu, SKX_MSR_CPU_BUS_NUMBER, &msr_value) ||
+			!(msr_value & SKX_MSR_CPU_BUS_VALID_BIT))
+		return -ENXIO;
+
+	*topology = msr_value;
+
+	return 0;
+}
+
+static int die_to_cpu(int die)
+{
+	int res = 0, cpu, current_die;
+	/*
+	 * Using cpus_read_lock() to ensure cpu is not going down between
+	 * looking at cpu_online_mask.
+	 */
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		current_die = topology_logical_die_id(cpu);
+		if (current_die == die) {
+			res = cpu;
+			break;
+		}
+	}
+	cpus_read_unlock();
+	return res;
+}
+
+static int skx_iio_get_topology(struct intel_uncore_type *type)
+{
+	int i, ret;
+	struct pci_bus *bus = NULL;
+
+	/*
+	 * Verified single-segment environments only; disabled for multiple
+	 * segment topologies for now except VMD domains.
+	 * VMD domains start at 0x10000 to not clash with ACPI _SEG domains.
+	 */
+	while ((bus = pci_find_next_bus(bus))
+		&& (!pci_domain_nr(bus) || pci_domain_nr(bus) > 0xffff))
+		;
+	if (bus)
+		return -EPERM;
+
+	type->topology = kcalloc(uncore_max_dies(), sizeof(u64), GFP_KERNEL);
+	if (!type->topology)
+		return -ENOMEM;
+
+	for (i = 0; i < uncore_max_dies(); i++) {
+		ret = skx_msr_cpu_bus_read(die_to_cpu(i), &type->topology[i]);
+		if (ret) {
+			kfree(type->topology);
+			type->topology = NULL;
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static struct attribute_group skx_iio_mapping_group = {
+	.is_visible	= skx_iio_mapping_visible,
+};
+
+static const struct attribute_group *skx_iio_attr_update[] = {
+	&skx_iio_mapping_group,
+	NULL,
+};
+
+static int skx_iio_set_mapping(struct intel_uncore_type *type)
+{
+	char buf[64];
+	int ret;
+	long die = -1;
+	struct attribute **attrs = NULL;
+	struct dev_ext_attribute *eas = NULL;
+
+	ret = skx_iio_get_topology(type);
+	if (ret)
+		return ret;
+
+	/* One more for NULL. */
+	attrs = kcalloc((uncore_max_dies() + 1), sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		goto err;
+
+	eas = kcalloc(uncore_max_dies(), sizeof(*eas), GFP_KERNEL);
+	if (!eas)
+		goto err;
+
+	for (die = 0; die < uncore_max_dies(); die++) {
+		sprintf(buf, "die%ld", die);
+		sysfs_attr_init(&eas[die].attr.attr);
+		eas[die].attr.attr.name = kstrdup(buf, GFP_KERNEL);
+		if (!eas[die].attr.attr.name)
+			goto err;
+		eas[die].attr.attr.mode = 0444;
+		eas[die].attr.show = skx_iio_mapping_show;
+		eas[die].attr.store = NULL;
+		eas[die].var = (void *)die;
+		attrs[die] = &eas[die].attr.attr;
+	}
+	skx_iio_mapping_group.attrs = attrs;
+
+	return 0;
+err:
+	for (; die >= 0; die--)
+		kfree(eas[die].attr.attr.name);
+	kfree(eas);
+	kfree(attrs);
+	kfree(type->topology);
+	type->attr_update = NULL;
+	return -ENOMEM;
+}
+
+static void skx_iio_cleanup_mapping(struct intel_uncore_type *type)
+{
+	struct attribute **attr = skx_iio_mapping_group.attrs;
+
+	if (!attr)
+		return;
+
+	for (; *attr; attr++)
+		kfree((*attr)->name);
+	kfree(attr_to_ext_attr(*skx_iio_mapping_group.attrs));
+	kfree(skx_iio_mapping_group.attrs);
+	skx_iio_mapping_group.attrs = NULL;
+	kfree(type->topology);
+}
+
 static struct intel_uncore_type skx_uncore_iio = {
 	.name			= "iio",
 	.num_counters		= 4,
@@ -3626,6 +3814,9 @@ static struct intel_uncore_type skx_uncore_iio = {
 	.constraints		= skx_uncore_iio_constraints,
 	.ops			= &skx_uncore_iio_ops,
 	.format_group		= &skx_uncore_iio_format_group,
+	.attr_update		= skx_iio_attr_update,
+	.set_mapping		= skx_iio_set_mapping,
+	.cleanup_mapping	= skx_iio_cleanup_mapping,
 };
 
 enum perf_uncore_iio_freerunning_type_id {
