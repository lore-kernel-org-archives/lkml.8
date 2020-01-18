Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854F8C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F89D2072E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 17:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579370316;
	bh=4k9RswO6Z43hhSNoxVUDp0bE9tg1I+Q/uoKMi7Vl6Hg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CavxFvAyoqD2fK1ObopYEUwieB1hPCnIj7YqXnmtDdtzPFHvJM+ia2X2zZmsyM5Ot
	 i+rwt/1+Rg+qlGs3OEn5ttYZ2TuoBl4lg7xWYxmxeo1ZQ0JioJNHe4c9OaKRV60mV3
	 3b+sO5vYKEjyvWsWYEUTrAc5NYebjAVqyhK4IWa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgARR6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 12:58:34 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:35770 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgARR6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 12:58:34 -0500
Received: by mail-wr1-f43.google.com with SMTP id g17so25593228wro.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 09:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SPJZ3jT0+jF0/xP7XomHn9MjHOuP8PKLOofQxSoS7kg=;
        b=Hbuz8kh7y3MH/QHAz/G80yv2vJoxvMprkmx348E4NnREYA+G1vXhPjVPjto2/3m4xb
         oNirBHCYxGxoo7qERn93qIYNAIHF2YpeGWC0LgE24nivSJUlbjYRQnUgrQcu7Mgmpp0t
         UWnspjNq6SfH3NWyfGrzr0mwamDFmOVzAaAqKbCbYhjisMVgVlLHs8Jqi5INrsqSEIcF
         5ayxJpj34Le+5AkZeeZaiY5x0ApXJSTu8Cg3ToubnYtENTbB5RRPMmKtSTDDnxhd0d/X
         5ZrchoaVeYOW1gI2pFMlKRqsxYrlB80XFT+5z/w9mEdW9yy3c4ZF3uSQnw0m/JYxFXd4
         UEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=SPJZ3jT0+jF0/xP7XomHn9MjHOuP8PKLOofQxSoS7kg=;
        b=Qw5lUQOibRXJKu9J9lg3z/wA4BIjBuO9KO7vUO6Whw1rN+93V5Vp3qxjmUoG8XDZ+Y
         +nSYz/2P/G5pvmmx9dMeiRsjy3kog9BwsOKB7keYI4R4N4F/7BukMmy4pEdJp43TO0v+
         1PRn9h2Msm9/XF43GD5oZdcgs9eWEpoc/4RspqQQYu2zxHyIo4iQl+JMVT4ncMAhOTLE
         apLqqswMPdPnQ+gK/PCguby5fArNTsayvFlILDO1KPbTRDUtZ90pW/43UxBSd8a0dvZ/
         /Y/qUHZuQFWEwEZqYyU+JxnfasHb/4apfwGTXtiXFtjxM1a/1ni0VYHYro7ZsNWx1zfH
         xbbA==
X-Gm-Message-State: APjAAAWL8JykR7lgpqZyonDwiC1fkloNLXHpQ8GWXXOn+hyT7HYfiwvn
        T15rVvi0FY1mIaBDJeZJLoY=
X-Google-Smtp-Source: APXvYqyfgFQFwaa3fPOC/kAC3Q7/Hlsh8d7AjdpydFdrWwR1Zq2UQOlPcXr/y5CnOIXbtMJncajFOA==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr9634703wro.202.1579370310750;
        Sat, 18 Jan 2020 09:58:30 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id o16sm2594328wmc.18.2020.01.18.09.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 09:58:30 -0800 (PST)
Date:   Sat, 18 Jan 2020 18:58:28 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [GIT PULL] perf fixes
Message-ID: <20200118175828.GA88066@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 2167f1625c2f04a33145f325db0de285630f7bd1 perf/x86/intel/uncore: Remove PCIe3 unit for SNR

Tooling fixes, three Intel uncore driver fixes, plus an AUX events fix 
uncovered by the perf fuzzer.

 Thanks,

	Ingo

------------------>
Arnaldo Carvalho de Melo (1):
      perf map: Set kmap->kmaps backpointer for main kernel map chunks

Hewenliang (1):
      tools lib traceevent: Fix memory leakage in filter_event

Jin Yao (1):
      perf report: Fix incorrectly added dimensions as switch perf data file

Kan Liang (3):
      perf/x86/intel/uncore: Add PCI ID of IMC for Xeon E3 V5 Family
      perf/x86/intel/uncore: Fix missing marker for snr_uncore_imc_freerunning_events
      perf/x86/intel/uncore: Remove PCIe3 unit for SNR

Mark Rutland (1):
      perf: Correctly handle failed perf_get_aux_event()

Yuya Fujita (1):
      perf hists: Fix variable name's inconsistency in hists__for_each() macro


 arch/x86/events/intel/uncore_snb.c   |  6 ++++++
 arch/x86/events/intel/uncore_snbep.c | 25 +------------------------
 kernel/events/core.c                 |  4 +++-
 tools/lib/traceevent/parse-filter.c  |  4 +++-
 tools/perf/builtin-report.c          |  5 ++++-
 tools/perf/util/hist.h               |  4 ++--
 tools/perf/util/symbol-elf.c         |  3 +++
 7 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index dbaa1b088a30..c37cb12d0ef6 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -15,6 +15,7 @@
 #define PCI_DEVICE_ID_INTEL_SKL_HQ_IMC		0x1910
 #define PCI_DEVICE_ID_INTEL_SKL_SD_IMC		0x190f
 #define PCI_DEVICE_ID_INTEL_SKL_SQ_IMC		0x191f
+#define PCI_DEVICE_ID_INTEL_SKL_E3_IMC		0x1918
 #define PCI_DEVICE_ID_INTEL_KBL_Y_IMC		0x590c
 #define PCI_DEVICE_ID_INTEL_KBL_U_IMC		0x5904
 #define PCI_DEVICE_ID_INTEL_KBL_UQ_IMC		0x5914
@@ -657,6 +658,10 @@ static const struct pci_device_id skl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SKL_SQ_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SKL_E3_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* IMC */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_Y_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
@@ -826,6 +831,7 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
 	IMC_DEV(SKL_HQ_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core H Quad Core */
 	IMC_DEV(SKL_SD_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core S Dual Core */
 	IMC_DEV(SKL_SQ_IMC, &skl_uncore_pci_driver),  /* 6th Gen Core S Quad Core */
+	IMC_DEV(SKL_E3_IMC, &skl_uncore_pci_driver),  /* Xeon E3 V5 Gen Core processor */
 	IMC_DEV(KBL_Y_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core Y */
 	IMC_DEV(KBL_U_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core U */
 	IMC_DEV(KBL_UQ_IMC, &skl_uncore_pci_driver),  /* 7th Gen Core U Quad Core */
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index b10a5ec79e48..ad20220af303 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -369,11 +369,6 @@
 #define SNR_M2M_PCI_PMON_BOX_CTL		0x438
 #define SNR_M2M_PCI_PMON_UMASK_EXT		0xff
 
-/* SNR PCIE3 */
-#define SNR_PCIE3_PCI_PMON_CTL0			0x508
-#define SNR_PCIE3_PCI_PMON_CTR0			0x4e8
-#define SNR_PCIE3_PCI_PMON_BOX_CTL		0x4e4
-
 /* SNR IMC */
 #define SNR_IMC_MMIO_PMON_FIXED_CTL		0x54
 #define SNR_IMC_MMIO_PMON_FIXED_CTR		0x38
@@ -4328,27 +4323,12 @@ static struct intel_uncore_type snr_uncore_m2m = {
 	.format_group	= &snr_m2m_uncore_format_group,
 };
 
-static struct intel_uncore_type snr_uncore_pcie3 = {
-	.name		= "pcie3",
-	.num_counters	= 4,
-	.num_boxes	= 1,
-	.perf_ctr_bits	= 48,
-	.perf_ctr	= SNR_PCIE3_PCI_PMON_CTR0,
-	.event_ctl	= SNR_PCIE3_PCI_PMON_CTL0,
-	.event_mask	= SNBEP_PMON_RAW_EVENT_MASK,
-	.box_ctl	= SNR_PCIE3_PCI_PMON_BOX_CTL,
-	.ops		= &ivbep_uncore_pci_ops,
-	.format_group	= &ivbep_uncore_format_group,
-};
-
 enum {
 	SNR_PCI_UNCORE_M2M,
-	SNR_PCI_UNCORE_PCIE3,
 };
 
 static struct intel_uncore_type *snr_pci_uncores[] = {
 	[SNR_PCI_UNCORE_M2M]		= &snr_uncore_m2m,
-	[SNR_PCI_UNCORE_PCIE3]		= &snr_uncore_pcie3,
 	NULL,
 };
 
@@ -4357,10 +4337,6 @@ static const struct pci_device_id snr_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x344a),
 		.driver_data = UNCORE_PCI_DEV_FULL_DATA(12, 0, SNR_PCI_UNCORE_M2M, 0),
 	},
-	{ /* PCIe3 */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x334a),
-		.driver_data = UNCORE_PCI_DEV_FULL_DATA(4, 0, SNR_PCI_UNCORE_PCIE3, 0),
-	},
 	{ /* end: all zeroes */ }
 };
 
@@ -4536,6 +4512,7 @@ static struct uncore_event_desc snr_uncore_imc_freerunning_events[] = {
 	INTEL_UNCORE_EVENT_DESC(write,		"event=0xff,umask=0x21"),
 	INTEL_UNCORE_EVENT_DESC(write.scale,	"3.814697266e-6"),
 	INTEL_UNCORE_EVENT_DESC(write.unit,	"MiB"),
+	{ /* end: all zeroes */ },
 };
 
 static struct intel_uncore_ops snr_uncore_imc_freerunning_ops = {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index a1f8bde19b56..2173c23c25b4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11465,8 +11465,10 @@ SYSCALL_DEFINE5(perf_event_open,
 		}
 	}
 
-	if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader))
+	if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader)) {
+		err = -EINVAL;
 		goto err_locked;
+	}
 
 	/*
 	 * Must be under the same ctx::mutex as perf_install_in_context(),
diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index f3cbf86e51ac..20eed719542e 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1228,8 +1228,10 @@ filter_event(struct tep_event_filter *filter, struct tep_event *event,
 	}
 
 	filter_type = add_filter_type(filter, event->id);
-	if (filter_type == NULL)
+	if (filter_type == NULL) {
+		free_arg(arg);
 		return TEP_ERRNO__MEM_ALLOC_FAILED;
+	}
 
 	if (filter_type->filter)
 		free_arg(filter_type->filter);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 387311c67264..de988589d99b 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1076,6 +1076,7 @@ int cmd_report(int argc, const char **argv)
 	struct stat st;
 	bool has_br_stack = false;
 	int branch_mode = -1;
+	int last_key = 0;
 	bool branch_call_mode = false;
 #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
 	static const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
@@ -1450,7 +1451,8 @@ int cmd_report(int argc, const char **argv)
 		sort_order = sort_tmp;
 	}
 
-	if (setup_sorting(session->evlist) < 0) {
+	if ((last_key != K_SWITCH_INPUT_DATA) &&
+	    (setup_sorting(session->evlist) < 0)) {
 		if (sort_order)
 			parse_options_usage(report_usage, options, "s", 1);
 		if (field_order)
@@ -1530,6 +1532,7 @@ int cmd_report(int argc, const char **argv)
 	ret = __cmd_report(&report);
 	if (ret == K_SWITCH_INPUT_DATA) {
 		perf_session__delete(session);
+		last_key = K_SWITCH_INPUT_DATA;
 		goto repeat;
 	} else
 		ret = 0;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 45286900aacb..0aa63aeb58ec 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -339,10 +339,10 @@ static inline void perf_hpp__prepend_sort_field(struct perf_hpp_fmt *format)
 	list_for_each_entry_safe(format, tmp, &(_list)->sorts, sort_list)
 
 #define hists__for_each_format(hists, format) \
-	perf_hpp_list__for_each_format((hists)->hpp_list, fmt)
+	perf_hpp_list__for_each_format((hists)->hpp_list, format)
 
 #define hists__for_each_sort_list(hists, format) \
-	perf_hpp_list__for_each_sort_list((hists)->hpp_list, fmt)
+	perf_hpp_list__for_each_sort_list((hists)->hpp_list, format)
 
 extern struct perf_hpp_fmt perf_hpp__format[];
 
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 6658fbf196e6..1965aefccb02 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -920,6 +920,9 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		if (curr_map == NULL)
 			return -1;
 
+		if (curr_dso->kernel)
+			map__kmap(curr_map)->kmaps = kmaps;
+
 		if (adjust_kernel_syms) {
 			curr_map->start  = shdr->sh_addr + ref_reloc(kmap);
 			curr_map->end	 = curr_map->start + shdr->sh_size;
