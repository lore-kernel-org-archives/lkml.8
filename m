Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A17C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDED208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="vPuVLZ89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgBQOLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:11:36 -0500
Received: from mail-db8eur05on2111.outbound.protection.outlook.com ([40.107.20.111]:6208
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726873AbgBQOLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:11:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeNPMb9CIe/0e0nY6QMjxyFJKasjOZH4AhoGnUziZPwk3vHhnVM6ovretEA6J8UBCU6JtTovzHsg6oA6alB3HlUHoQdbRrnCI0cyCqR5hLMDEkoSZh3lnoh2FzSk/I2iVX0FgqFixelxL+4dQB+lmfU8dXUCo7TU4sY+qH3Ap+06JC8eBIdQJLc9GNX06bZyeUW0HNQWVQrb4HUQbCYOWfLsnCS+tyaLMsPyKwjH0n7v705vYzSzUwKvhL5s/HRhJtzB+lSZsryHDcurNCDd6RkKOYpOKQujLw0HEcuK1z6bj5iSSK8iGvhACQ5rNZV3FFrccyjMBPD3xugl+YGM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2g6idMDSr+/6Eot15j7rYNzN7Irz/osm4vncPtl9y2E=;
 b=ghcUmW7j5j6PEgo43QgjHrsANJQBLwq/8bJ9STFgysaG8kVqnzpGyI2WIutfx5P8jpc/sfk9a+1k8BikmEoRIjNYpYgYFE5LQ3PHqdQxqoCV4H45QN81RK2eQWSoOwOSYBvTliekG7X+NRj+amoIKJ8iLHK+7NXVzvX9/1Q35tXEwXxDHzyDvaHREaJEirauiEitFyoFLR3rON/mbIz0JLEKFCvGyyoWmd809RNIrWGtyUxOrYwCFFC675s+HUs0YCoRfR51EQt5oN0TTRqFMAOXQVZvf9mHALWWrLK04sdgWB8ZM1DViPrsdVz17+mZ+/Jf7A6CiIUl2ThfsWt22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2g6idMDSr+/6Eot15j7rYNzN7Irz/osm4vncPtl9y2E=;
 b=vPuVLZ89833MM4kOm9TfC/wzBMGeZY8qdAOiOBEicb6ZZzhOsEwneZl+Vywe+uQR+Njb7CUyUTSbAWxIFfqVu2C89VDtx3U7CTtcuEhSdzxAq+6jkwERsxFIDT7kVLUcW3qFexcu7p+m5qBDcjPMbhPTUxUWecg7GQuOua6aVq4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
Received: from VI1PR07MB5040.eurprd07.prod.outlook.com (20.177.203.20) by
 VI1PR07MB5056.eurprd07.prod.outlook.com (20.177.203.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.12; Mon, 17 Feb 2020 14:11:27 +0000
Received: from VI1PR07MB5040.eurprd07.prod.outlook.com
 ([fe80::20c4:7ce8:f735:316e]) by VI1PR07MB5040.eurprd07.prod.outlook.com
 ([fe80::20c4:7ce8:f735:316e%2]) with mapi id 15.20.2750.010; Mon, 17 Feb 2020
 14:11:27 +0000
From:   Alexander X Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v6 2/2] ARM: ftrace: Add MODULE_PLTS support
Date:   Mon, 17 Feb 2020 15:09:55 +0100
Message-Id: <20200217140955.211661-3-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200217140955.211661-1-alexander.sverdlin@nokia.com>
References: <20200217140955.211661-1-alexander.sverdlin@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P191CA0004.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::14)
 To VI1PR07MB5040.eurprd07.prod.outlook.com (2603:10a6:803:9c::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvdell.emea.nsn-net.net (131.228.32.181) by HE1P191CA0004.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Mon, 17 Feb 2020 14:11:26 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [131.228.32.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc84eef7-e7aa-4167-ef83-08d7b3b34715
X-MS-TrafficTypeDiagnostic: VI1PR07MB5056:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR07MB505663B213CE5DC95DB0C69D88160@VI1PR07MB5056.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-Forefront-PRVS: 0316567485
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(189003)(199004)(26005)(6506007)(6666004)(4326008)(86362001)(2616005)(6916009)(52116002)(1076003)(956004)(478600001)(54906003)(186003)(6486002)(8936002)(8676002)(2906002)(81166006)(66946007)(81156014)(66476007)(5660300002)(66556008)(6512007)(36756003)(16526019)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB5056;H:VI1PR07MB5040.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3SFLmv6NPbHx6iETxxurtJdY/Nx1cNWxBqQruEpUuSP1fHQLEPNgcnp8ZyM4zgQMtPPB+hyKgP8YXqwCMVQ4KHwQ8f2L7jHSD8Oa3qijvs00ModJW21r+UT8mdphD0NT8oSJo/ZdwSCQ5mmrbCgQircaR5Us2icVKqL+umDced73HGAgNIShznzzQhQ5DX/pJuTdO63YBZzeQ0XdmjNZjHJ/h8V+5bLHSjVyprv4KCdBYAaXaZH2Spx/69/Tzeu4Y6NYjWPUw1ro+bZgqCursMmvQ7La9v3emNClNg4FOY2YqUauLO6oH+SMo4tAUGrwfI607ieZM01xZQ4xp4t0L5F7Z/q7s6irUBHo3Zpyfs1UDXpwsoOd/mafqKxZ/cj9Xhm7n1CcuiT3uQumpH6mb5tqfq0/aCd4irANK0RjDkF7jKhLw4nMWDy8icEj9fM
X-MS-Exchange-AntiSpam-MessageData: +GeGbF2ZuZrzqo0oOO6RsSIrI2EZDcJVQGp/TCgWAlst1701OrDhq+Cplrq+fnTN9XWPCqQGBn8rkMCcDrbkrTkzNjpPZ1xClklny+lEbd428JQ8wWd6U/VMhHQEiZttm5AJHLDUnsbGq7LoZbu60Q==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc84eef7-e7aa-4167-ef83-08d7b3b34715
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2020 14:11:27.0551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzQ3U1e2tBEdvOowLxvPtgVyNzyUakbzkhSOijZoUUwIXXEHnzrWr4/ko2xfoMpGgXHrOTIlEc08R5qgOBeEDnnVt/WX0y1lmPxnh0hdW48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB5056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

Teach ftrace_make_call() and ftrace_make_nop() about PLTs.
Teach PLT code about FTRACE and all its callbacks.
Otherwise the following might happen:

------------[ cut here ]------------
WARNING: CPU: 14 PID: 2265 at .../arch/arm/kernel/insn.c:14 __arm_gen_branch+0x83/0x8c()
...
Hardware name: LSI Axxia AXM55XX
[<c0314a49>] (unwind_backtrace) from [<c03115e9>] (show_stack+0x11/0x14)
[<c03115e9>] (show_stack) from [<c0519f51>] (dump_stack+0x81/0xa8)
[<c0519f51>] (dump_stack) from [<c032185d>] (warn_slowpath_common+0x69/0x90)
[<c032185d>] (warn_slowpath_common) from [<c03218f3>] (warn_slowpath_null+0x17/0x1c)
[<c03218f3>] (warn_slowpath_null) from [<c03143cf>] (__arm_gen_branch+0x83/0x8c)
[<c03143cf>] (__arm_gen_branch) from [<c0314337>] (ftrace_make_nop+0xf/0x24)
[<c0314337>] (ftrace_make_nop) from [<c038ebcb>] (ftrace_process_locs+0x27b/0x3e8)
[<c038ebcb>] (ftrace_process_locs) from [<c0378d79>] (load_module+0x11e9/0x1a44)
[<c0378d79>] (load_module) from [<c037974d>] (SyS_finit_module+0x59/0x84)
[<c037974d>] (SyS_finit_module) from [<c030e981>] (ret_fast_syscall+0x1/0x18)
---[ end trace e1b64ced7a89adcc ]---
------------[ cut here ]------------
WARNING: CPU: 14 PID: 2265 at .../kernel/trace/ftrace.c:1979 ftrace_bug+0x1b1/0x234()
...
Hardware name: LSI Axxia AXM55XX
[<c0314a49>] (unwind_backtrace) from [<c03115e9>] (show_stack+0x11/0x14)
[<c03115e9>] (show_stack) from [<c0519f51>] (dump_stack+0x81/0xa8)
[<c0519f51>] (dump_stack) from [<c032185d>] (warn_slowpath_common+0x69/0x90)
[<c032185d>] (warn_slowpath_common) from [<c03218f3>] (warn_slowpath_null+0x17/0x1c)
[<c03218f3>] (warn_slowpath_null) from [<c038e87d>] (ftrace_bug+0x1b1/0x234)
[<c038e87d>] (ftrace_bug) from [<c038ebd5>] (ftrace_process_locs+0x285/0x3e8)
[<c038ebd5>] (ftrace_process_locs) from [<c0378d79>] (load_module+0x11e9/0x1a44)
[<c0378d79>] (load_module) from [<c037974d>] (SyS_finit_module+0x59/0x84)
[<c037974d>] (SyS_finit_module) from [<c030e981>] (ret_fast_syscall+0x1/0x18)
---[ end trace e1b64ced7a89adcd ]---
ftrace failed to modify [<e9ef7006>] 0xe9ef7006
actual: 02:f0:3b:fa
ftrace record flags: 0
(0) expected tramp: c0314265

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/include/asm/ftrace.h |  3 +++
 arch/arm/include/asm/module.h |  1 +
 arch/arm/kernel/ftrace.c      | 46 +++++++++++++++++++++++++++++++++++++++++--
 arch/arm/kernel/module-plts.c | 44 +++++++++++++++++++++++++++++++++++++----
 4 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index 48ec1d0..a4dbac0 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -15,6 +15,9 @@ extern void __gnu_mcount_nc(void);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 struct dyn_arch_ftrace {
+#ifdef CONFIG_ARM_MODULE_PLTS
+	struct module *mod;
+#endif
 };
 
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 78e4c16..961fedb 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -30,6 +30,7 @@ struct plt_entries {
 
 struct mod_plt_sec {
 	struct elf32_shdr	*plt;
+	struct plt_entries	*plt_ent;
 	int			plt_count;
 };
 
diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
index 10499d4..75830e5 100644
--- a/arch/arm/kernel/ftrace.c
+++ b/arch/arm/kernel/ftrace.c
@@ -70,6 +70,19 @@ int ftrace_arch_code_modify_post_process(void)
 
 static unsigned long ftrace_call_replace(unsigned long pc, unsigned long addr)
 {
+	s32 offset = addr - pc;
+	s32 blim = 0xfe000008;
+	s32 flim = 0x02000004;
+
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
+		blim = 0xff000004;
+		flim = 0x01000002;
+	}
+
+	if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS) &&
+	    (offset < blim || offset > flim))
+		return 0;
+
 	return arm_gen_branch_link(pc, addr);
 }
 
@@ -123,10 +136,22 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long new, old;
 	unsigned long ip = rec->ip;
+	unsigned long aaddr = adjust_address(rec, addr);
 
 	old = ftrace_nop_replace(rec);
 
-	new = ftrace_call_replace(ip, adjust_address(rec, addr));
+	new = ftrace_call_replace(ip, aaddr);
+
+#ifdef CONFIG_ARM_MODULE_PLTS
+	if (!new) {
+		struct module *mod = rec->arch.mod;
+
+		if (mod) {
+			aaddr = get_module_plt(mod, ip, aaddr);
+			new = ftrace_call_replace(ip, aaddr);
+		}
+	}
+#endif
 
 	return ftrace_modify_code(rec->ip, old, new, true);
 }
@@ -151,12 +176,29 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 int ftrace_make_nop(struct module *mod,
 		    struct dyn_ftrace *rec, unsigned long addr)
 {
+	unsigned long aaddr = adjust_address(rec, addr);
 	unsigned long ip = rec->ip;
 	unsigned long old;
 	unsigned long new;
 	int ret;
 
-	old = ftrace_call_replace(ip, adjust_address(rec, addr));
+#ifdef CONFIG_ARM_MODULE_PLTS
+	/* mod is only supplied during module loading */
+	if (!mod)
+		mod = rec->arch.mod;
+	else
+		rec->arch.mod = mod;
+#endif
+
+	old = ftrace_call_replace(ip, aaddr);
+
+#ifdef CONFIG_ARM_MODULE_PLTS
+	if (!old && mod) {
+		aaddr = get_module_plt(mod, ip, aaddr);
+		old = ftrace_call_replace(ip, aaddr);
+	}
+#endif
+
 	new = ftrace_nop_replace(rec);
 	ret = ftrace_modify_code(ip, old, new, true);
 
diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index d330e9e..a0524ad 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/elf.h>
+#include <linux/ftrace.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sort.h>
@@ -20,19 +21,52 @@
 						    (PLT_ENT_STRIDE - 8))
 #endif
 
+static const u32 fixed_plts[] = {
+#ifdef CONFIG_FUNCTION_TRACER
+	FTRACE_ADDR,
+	MCOUNT_ADDR,
+#endif
+};
+
 static bool in_init(const struct module *mod, unsigned long loc)
 {
 	return loc - (u32)mod->init_layout.base < mod->init_layout.size;
 }
 
+static void prealloc_fixed(struct mod_plt_sec *pltsec, struct plt_entries *plt)
+{
+	int i;
+
+	if (!ARRAY_SIZE(fixed_plts) || pltsec->plt_count)
+		return;
+	pltsec->plt_count = ARRAY_SIZE(fixed_plts);
+
+	for (i = 0; i < ARRAY_SIZE(plt->ldr); ++i)
+		plt->ldr[i] = PLT_ENT_LDR;
+
+	BUILD_BUG_ON(sizeof(fixed_plts) > sizeof(plt->lit));
+	memcpy(plt->lit, fixed_plts, sizeof(fixed_plts));
+}
+
 u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
 {
 	struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
 							  &mod->arch.init;
+	struct plt_entries *plt;
+	int idx;
+
+	/* cache the address, ELF header is available only during module load */
+	if (!pltsec->plt_ent)
+		pltsec->plt_ent = (struct plt_entries *)pltsec->plt->sh_addr;
+	plt = pltsec->plt_ent;
 
-	struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
-	int idx = 0;
+	prealloc_fixed(pltsec, plt);
+
+	for (idx = 0; idx < ARRAY_SIZE(fixed_plts); ++idx)
+		if (plt->lit[idx] == val)
+			return (u32)&plt->ldr[idx];
 
+	idx = 0;
 	/*
 	 * Look for an existing entry pointing to 'val'. Given that the
 	 * relocations are sorted, this will be the last entry we allocated.
@@ -180,8 +214,8 @@ static unsigned int count_plts(const Elf32_Sym *syms, Elf32_Addr base,
 int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
-	unsigned long core_plts = 0;
-	unsigned long init_plts = 0;
+	unsigned long core_plts = ARRAY_SIZE(fixed_plts);
+	unsigned long init_plts = ARRAY_SIZE(fixed_plts);
 	Elf32_Shdr *s, *sechdrs_end = sechdrs + ehdr->e_shnum;
 	Elf32_Sym *syms = NULL;
 
@@ -236,6 +270,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	mod->arch.core.plt->sh_size = round_up(core_plts * PLT_ENT_SIZE,
 					       sizeof(struct plt_entries));
 	mod->arch.core.plt_count = 0;
+	mod->arch.core.plt_ent = NULL;
 
 	mod->arch.init.plt->sh_type = SHT_NOBITS;
 	mod->arch.init.plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
@@ -243,6 +278,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	mod->arch.init.plt->sh_size = round_up(init_plts * PLT_ENT_SIZE,
 					       sizeof(struct plt_entries));
 	mod->arch.init.plt_count = 0;
+	mod->arch.init.plt_ent = NULL;
 
 	pr_debug("%s: plt=%x, init.plt=%x\n", __func__,
 		 mod->arch.core.plt->sh_size, mod->arch.init.plt->sh_size);
-- 
2.4.6

