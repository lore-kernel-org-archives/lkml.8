Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E397BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE20F208B6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="s4m0vWDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgGBPYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:24:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46394 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730174AbgGBPX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:23:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062FMUbb003889;
        Thu, 2 Jul 2020 15:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=R61Jh+hn64l5CJ9uvrtSxUHZqNe6xBjzDGrq0AjcO+0=;
 b=s4m0vWDYbrAvqLxVAY2sgAxwoPfNTx0Q0FH3Yh0mUXSUjkIBRtKybAoU5oEst/xGsd7Q
 YLelblo3aniqYZX/3dLGXdOvFTNqt/x50RaydkyCxlcEuL/G63l9hEZIpi2EljSCCpd0
 NYHlXCdO2gqnKL3JXRtmnW1z45pGW1UV+wHm5lPTM6lYEt3CgQvWqpUfjGbUoPSCOa7u
 BgDH58ErJ3JVlv++nRUlhDHBMayRfulOmL9DTVL6FgUiDa/5G4qD1fvv8+B7RTFbY73t
 rPEsMo16XqXzh0IUWYV08seQAcPi5OLwRmM8ZAUa6SPyf9F/RFZjjKGHVgHtQ4mu8QV+ Dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31wxrnh2wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 02 Jul 2020 15:23:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062EwmI5066438;
        Thu, 2 Jul 2020 15:21:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31xfvvs90u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jul 2020 15:21:45 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 062FLh2g021034;
        Thu, 2 Jul 2020 15:21:43 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jul 2020 15:20:51 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH RFC 1/7] x86: cpu: bugs.c: remove init attribute from functions and variables
Date:   Thu,  2 Jul 2020 18:18:21 +0300
Message-Id: <1593703107-8852-2-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com>
References: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007020106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=1 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007020107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in order to be able to call them after the system has booted.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 arch/x86/kernel/cpu/bugs.c   | 76 ++++++++++++++++++++++----------------------
 arch/x86/kernel/cpu/common.c |  4 +--
 arch/x86/kernel/cpu/cpu.h    |  4 +--
 arch/x86/kernel/cpu/tsx.c    |  6 ++--
 kernel/cpu.c                 |  2 +-
 5 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0b71970..7091947 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -34,14 +34,14 @@
 
 #include "cpu.h"
 
-static void __init spectre_v1_select_mitigation(void);
-static void __init spectre_v2_select_mitigation(void);
-static void __init ssb_select_mitigation(void);
-static void __init l1tf_select_mitigation(void);
-static void __init mds_select_mitigation(void);
-static void __init mds_print_mitigation(void);
-static void __init taa_select_mitigation(void);
-static void __init srbds_select_mitigation(void);
+static void spectre_v1_select_mitigation(void);
+static void spectre_v2_select_mitigation(void);
+static void ssb_select_mitigation(void);
+static void l1tf_select_mitigation(void);
+static void mds_select_mitigation(void);
+static void mds_print_mitigation(void);
+static void taa_select_mitigation(void);
+static void srbds_select_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR that always has to be preserved. */
 u64 x86_spec_ctrl_base;
@@ -52,14 +52,14 @@
  * The vendor and possibly platform specific bits which can be modified in
  * x86_spec_ctrl_base.
  */
-static u64 __ro_after_init x86_spec_ctrl_mask = SPEC_CTRL_IBRS;
+static u64 x86_spec_ctrl_mask = SPEC_CTRL_IBRS;
 
 /*
  * AMD specific MSR info for Speculative Store Bypass control.
  * x86_amd_ls_cfg_ssbd_mask is initialized in identify_boot_cpu().
  */
-u64 __ro_after_init x86_amd_ls_cfg_base;
-u64 __ro_after_init x86_amd_ls_cfg_ssbd_mask;
+u64 x86_amd_ls_cfg_base;
+u64 x86_amd_ls_cfg_ssbd_mask;
 
 /* Control conditional STIBP in switch_to() */
 DEFINE_STATIC_KEY_FALSE(switch_to_cond_stibp);
@@ -75,7 +75,7 @@
 DEFINE_STATIC_KEY_FALSE(mds_idle_clear);
 EXPORT_SYMBOL_GPL(mds_idle_clear);
 
-void __init check_bugs(void)
+void __ref check_bugs(void)
 {
 	identify_boot_cpu();
 
@@ -228,7 +228,7 @@ static void x86_amd_ssb_disable(void)
 #define pr_fmt(fmt)	"MDS: " fmt
 
 /* Default mitigation for MDS-affected CPUs */
-static enum mds_mitigations mds_mitigation __ro_after_init = MDS_MITIGATION_FULL;
+static enum mds_mitigations mds_mitigation = MDS_MITIGATION_FULL;
 static bool mds_nosmt __ro_after_init = false;
 
 static const char * const mds_strings[] = {
@@ -237,7 +237,7 @@ static void x86_amd_ssb_disable(void)
 	[MDS_MITIGATION_VMWERV]	= "Vulnerable: Clear CPU buffers attempted, no microcode",
 };
 
-static void __init mds_select_mitigation(void)
+static void mds_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off()) {
 		mds_mitigation = MDS_MITIGATION_OFF;
@@ -256,7 +256,7 @@ static void __init mds_select_mitigation(void)
 	}
 }
 
-static void __init mds_print_mitigation(void)
+static void mds_print_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MDS) || cpu_mitigations_off())
 		return;
@@ -296,7 +296,7 @@ enum taa_mitigations {
 };
 
 /* Default mitigation for TAA-affected CPUs */
-static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
+static enum taa_mitigations taa_mitigation = TAA_MITIGATION_VERW;
 static bool taa_nosmt __ro_after_init;
 
 static const char * const taa_strings[] = {
@@ -306,7 +306,7 @@ enum taa_mitigations {
 	[TAA_MITIGATION_TSX_DISABLED]	= "Mitigation: TSX disabled",
 };
 
-static void __init taa_select_mitigation(void)
+static void taa_select_mitigation(void)
 {
 	u64 ia32_cap;
 
@@ -410,7 +410,7 @@ enum srbds_mitigations {
 	SRBDS_MITIGATION_HYPERVISOR,
 };
 
-static enum srbds_mitigations srbds_mitigation __ro_after_init = SRBDS_MITIGATION_FULL;
+static enum srbds_mitigations srbds_mitigation = SRBDS_MITIGATION_FULL;
 
 static const char * const srbds_strings[] = {
 	[SRBDS_MITIGATION_OFF]		= "Vulnerable",
@@ -452,7 +452,7 @@ void update_srbds_msr(void)
 	wrmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
 }
 
-static void __init srbds_select_mitigation(void)
+static void srbds_select_mitigation(void)
 {
 	u64 ia32_cap;
 
@@ -498,7 +498,7 @@ enum spectre_v1_mitigation {
 	SPECTRE_V1_MITIGATION_AUTO,
 };
 
-static enum spectre_v1_mitigation spectre_v1_mitigation __ro_after_init =
+static enum spectre_v1_mitigation spectre_v1_mitigation =
 	SPECTRE_V1_MITIGATION_AUTO;
 
 static const char * const spectre_v1_strings[] = {
@@ -527,7 +527,7 @@ static bool smap_works_speculatively(void)
 	return true;
 }
 
-static void __init spectre_v1_select_mitigation(void)
+static void spectre_v1_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off()) {
 		spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
@@ -585,12 +585,12 @@ static int __init nospectre_v1_cmdline(char *str)
 #undef pr_fmt
 #define pr_fmt(fmt)     "Spectre V2 : " fmt
 
-static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
+static enum spectre_v2_mitigation spectre_v2_enabled =
 	SPECTRE_V2_NONE;
 
-static enum spectre_v2_user_mitigation spectre_v2_user_stibp __ro_after_init =
+static enum spectre_v2_user_mitigation spectre_v2_user_stibp =
 	SPECTRE_V2_USER_NONE;
-static enum spectre_v2_user_mitigation spectre_v2_user_ibpb __ro_after_init =
+static enum spectre_v2_user_mitigation spectre_v2_user_ibpb =
 	SPECTRE_V2_USER_NONE;
 
 #ifdef CONFIG_RETPOLINE
@@ -653,7 +653,7 @@ enum spectre_v2_user_cmd {
 	const char			*option;
 	enum spectre_v2_user_cmd	cmd;
 	bool				secure;
-} v2_user_options[] __initconst = {
+} v2_user_options[] = {
 	{ "auto",		SPECTRE_V2_USER_CMD_AUTO,		false },
 	{ "off",		SPECTRE_V2_USER_CMD_NONE,		false },
 	{ "on",			SPECTRE_V2_USER_CMD_FORCE,		true  },
@@ -663,13 +663,13 @@ enum spectre_v2_user_cmd {
 	{ "seccomp,ibpb",	SPECTRE_V2_USER_CMD_SECCOMP_IBPB,	false },
 };
 
-static void __init spec_v2_user_print_cond(const char *reason, bool secure)
+static void spec_v2_user_print_cond(const char *reason, bool secure)
 {
 	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) != secure)
 		pr_info("spectre_v2_user=%s forced on command line.\n", reason);
 }
 
-static enum spectre_v2_user_cmd __init
+static enum spectre_v2_user_cmd
 spectre_v2_parse_user_cmdline(enum spectre_v2_mitigation_cmd v2_cmd)
 {
 	char arg[20];
@@ -701,7 +701,7 @@ static void __init spec_v2_user_print_cond(const char *reason, bool secure)
 	return SPECTRE_V2_USER_CMD_AUTO;
 }
 
-static void __init
+static void
 spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 {
 	enum spectre_v2_user_mitigation mode = SPECTRE_V2_USER_NONE;
@@ -801,7 +801,7 @@ static void __init spec_v2_user_print_cond(const char *reason, bool secure)
 	const char *option;
 	enum spectre_v2_mitigation_cmd cmd;
 	bool secure;
-} mitigation_options[] __initconst = {
+} mitigation_options[] = {
 	{ "off",		SPECTRE_V2_CMD_NONE,		  false },
 	{ "on",			SPECTRE_V2_CMD_FORCE,		  true  },
 	{ "retpoline",		SPECTRE_V2_CMD_RETPOLINE,	  false },
@@ -810,13 +810,13 @@ static void __init spec_v2_user_print_cond(const char *reason, bool secure)
 	{ "auto",		SPECTRE_V2_CMD_AUTO,		  false },
 };
 
-static void __init spec_v2_print_cond(const char *reason, bool secure)
+static void spec_v2_print_cond(const char *reason, bool secure)
 {
 	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2) != secure)
 		pr_info("%s selected on command line.\n", reason);
 }
 
-static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
+static enum spectre_v2_mitigation_cmd spectre_v2_parse_cmdline(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_AUTO;
 	char arg[20];
@@ -862,7 +862,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	return cmd;
 }
 
-static void __init spectre_v2_select_mitigation(void)
+static void spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
 	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
@@ -1061,7 +1061,7 @@ void cpu_bugs_smt_update(void)
 #undef pr_fmt
 #define pr_fmt(fmt)	"Speculative Store Bypass: " fmt
 
-static enum ssb_mitigation ssb_mode __ro_after_init = SPEC_STORE_BYPASS_NONE;
+static enum ssb_mitigation ssb_mode = SPEC_STORE_BYPASS_NONE;
 
 /* The kernel command line selection */
 enum ssb_mitigation_cmd {
@@ -1082,7 +1082,7 @@ enum ssb_mitigation_cmd {
 static const struct {
 	const char *option;
 	enum ssb_mitigation_cmd cmd;
-} ssb_mitigation_options[]  __initconst = {
+} ssb_mitigation_options[] = {
 	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO },    /* Platform decides */
 	{ "on",		SPEC_STORE_BYPASS_CMD_ON },      /* Disable Speculative Store Bypass */
 	{ "off",	SPEC_STORE_BYPASS_CMD_NONE },    /* Don't touch Speculative Store Bypass */
@@ -1090,7 +1090,7 @@ enum ssb_mitigation_cmd {
 	{ "seccomp",	SPEC_STORE_BYPASS_CMD_SECCOMP }, /* Disable Speculative Store Bypass via prctl and seccomp */
 };
 
-static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
+static enum ssb_mitigation_cmd ssb_parse_cmdline(void)
 {
 	enum ssb_mitigation_cmd cmd = SPEC_STORE_BYPASS_CMD_AUTO;
 	char arg[20];
@@ -1122,7 +1122,7 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 	return cmd;
 }
 
-static enum ssb_mitigation __init __ssb_select_mitigation(void)
+static enum ssb_mitigation __ssb_select_mitigation(void)
 {
 	enum ssb_mitigation mode = SPEC_STORE_BYPASS_NONE;
 	enum ssb_mitigation_cmd cmd;
@@ -1402,7 +1402,7 @@ void x86_spec_ctrl_setup_ap(void)
 #define pr_fmt(fmt)	"L1TF: " fmt
 
 /* Default mitigation for L1TF-affected CPUs */
-enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_FLUSH;
+enum l1tf_mitigations l1tf_mitigation = L1TF_MITIGATION_FLUSH;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
 #endif
@@ -1448,7 +1448,7 @@ static void override_cache_bits(struct cpuinfo_x86 *c)
 	}
 }
 
-static void __init l1tf_select_mitigation(void)
+static void l1tf_select_mitigation(void)
 {
 	u64 half_pa;
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 95c090a..c11daa6 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1018,7 +1018,7 @@ static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 #define VULNWL_HYGON(family, whitelist)		\
 	VULNWL(HYGON, family, X86_MODEL_ANY, whitelist)
 
-static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
+static const struct x86_cpu_id cpu_vuln_whitelist[] = {
 	VULNWL(ANY,	4, X86_MODEL_ANY,	NO_SPECULATION),
 	VULNWL(CENTAUR,	5, X86_MODEL_ANY,	NO_SPECULATION),
 	VULNWL(INTEL,	5, X86_MODEL_ANY,	NO_SPECULATION),
@@ -1094,7 +1094,7 @@ static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 	{}
 };
 
-static bool __init cpu_matches(const struct x86_cpu_id *table, unsigned long which)
+static bool cpu_matches(const struct x86_cpu_id *table, unsigned long which)
 {
 	const struct x86_cpu_id *m = x86_match_cpu(table);
 
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 9d03369..bf025b8 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -51,9 +51,9 @@ enum tsx_ctrl_states {
 	TSX_CTRL_NOT_SUPPORTED,
 };
 
-extern __ro_after_init enum tsx_ctrl_states tsx_ctrl_state;
+extern enum tsx_ctrl_states tsx_ctrl_state;
 
-extern void __init tsx_init(void);
+extern void tsx_init(void);
 extern void tsx_enable(void);
 extern void tsx_disable(void);
 #else
diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index e2ad30e..7c46581 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -17,7 +17,7 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "tsx: " fmt
 
-enum tsx_ctrl_states tsx_ctrl_state __ro_after_init = TSX_CTRL_NOT_SUPPORTED;
+enum tsx_ctrl_states tsx_ctrl_state = TSX_CTRL_NOT_SUPPORTED;
 
 void tsx_disable(void)
 {
@@ -58,7 +58,7 @@ void tsx_enable(void)
 	wrmsrl(MSR_IA32_TSX_CTRL, tsx);
 }
 
-static bool __init tsx_ctrl_is_supported(void)
+static bool tsx_ctrl_is_supported(void)
 {
 	u64 ia32_cap = x86_read_arch_cap_msr();
 
@@ -84,7 +84,7 @@ static enum tsx_ctrl_states x86_get_tsx_auto_mode(void)
 	return TSX_CTRL_ENABLE;
 }
 
-void __init tsx_init(void)
+void tsx_init(void)
 {
 	char arg[5] = {};
 	int ret;
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6ff2578..fe67a01 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -391,7 +391,7 @@ void __weak arch_smt_update(void) { }
 #ifdef CONFIG_HOTPLUG_SMT
 enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
 
-void __init cpu_smt_disable(bool force)
+void cpu_smt_disable(bool force)
 {
 	if (!cpu_smt_possible())
 		return;
-- 
1.8.3.1

