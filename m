Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19A6C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A552469B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgAMTKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 14:10:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39943 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbgAMTJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 14:09:47 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ir55d-0000y2-87; Mon, 13 Jan 2020 20:09:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1C7411C18DF;
        Mon, 13 Jan 2020 20:09:27 +0100 (CET)
Date:   Mon, 13 Jan 2020 19:09:26 -0000
From:   "tip-bot2 for Dmitry Safonov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] x86/vdso: Add time napespace page
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-23-dima@arista.com>
References: <20191112012724.250792-23-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157894256689.19145.7705447890779194117.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f02341d83a4d071dbc85431fa3d51c0dcd02dec9
Gitweb:        https://git.kernel.org/tip/f02341d83a4d071dbc85431fa3d51c0dcd02dec9
Author:        Dmitry Safonov <dima@arista.com>
AuthorDate:    Tue, 12 Nov 2019 01:27:11 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 13 Jan 2020 08:10:55 +01:00

x86/vdso: Add time napespace page

To support time namespaces in the VDSO with a minimal impact on regular non
time namespace affected tasks, the namespace handling needs to be hidden in
a slow path.

The most obvious place is vdso_seq_begin(). If a task belongs to a time
namespace then the VVAR page which contains the system wide VDSO data is
replaced with a namespace specific page which has the same layout as the
VVAR page. That page has vdso_data->seq set to 1 to enforce the slow path
and vdso_data->clock_mode set to VCLOCK_TIMENS to enforce the time
namespace handling path.

The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
update of the VDSO data is in progress, is not really affecting regular
tasks which are not part of a time namespace as the task is spin waiting
for the update to finish and vdso_data->seq to become even again.

If a time namespace task hits that code path, it invokes the corresponding
time getter function which retrieves the real VVAR page, reads host time
and then adds the offset for the requested clock which is stored in the
special VVAR page.

Allocate the time namespace page among VVAR pages and place vdso_data on
it.  Provide __arch_get_timens_vdso_data() helper for VDSO code to get the
code-relative position of VVARs on that special page.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-23-dima@arista.com

---
 arch/x86/Kconfig                         |  1 +
 arch/x86/entry/vdso/vdso-layout.lds.S    | 11 +++++++++--
 arch/x86/entry/vdso/vdso2c.c             |  3 +++
 arch/x86/include/asm/vdso.h              |  1 +
 arch/x86/include/asm/vdso/gettimeofday.h |  8 ++++++++
 arch/x86/include/asm/vvar.h              |  5 ++++-
 6 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5e89499..a2488c3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -124,6 +124,7 @@ config X86
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_TIME_NS
 	select GUP_GET_PTE_LOW_HIGH		if X86_PAE
 	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
 	select HAVE_ACPI_APEI			if ACPI
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index 2330daa..ea7e015 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -16,8 +16,8 @@ SECTIONS
 	 * segment.
 	 */
 
-	vvar_start = . - 3 * PAGE_SIZE;
-	vvar_page = vvar_start;
+	vvar_start = . - 4 * PAGE_SIZE;
+	vvar_page  = vvar_start;
 
 	/* Place all vvars at the offsets in asm/vvar.h. */
 #define EMIT_VVAR(name, offset) vvar_ ## name = vvar_page + offset;
@@ -26,6 +26,13 @@ SECTIONS
 
 	pvclock_page = vvar_start + PAGE_SIZE;
 	hvclock_page = vvar_start + 2 * PAGE_SIZE;
+	timens_page  = vvar_start + 3 * PAGE_SIZE;
+
+#undef _ASM_X86_VVAR_H
+	/* Place all vvars in timens too at the offsets in asm/vvar.h. */
+#define EMIT_VVAR(name, offset) timens_ ## name = timens_page + offset;
+#include <asm/vvar.h>
+#undef EMIT_VVAR
 
 	. = SIZEOF_HEADERS;
 
diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 3a4d8d4..3842873 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -75,12 +75,14 @@ enum {
 	sym_vvar_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
+	sym_timens_page,
 };
 
 const int special_pages[] = {
 	sym_vvar_page,
 	sym_pvclock_page,
 	sym_hvclock_page,
+	sym_timens_page,
 };
 
 struct vdso_sym {
@@ -93,6 +95,7 @@ struct vdso_sym required_syms[] = {
 	[sym_vvar_page] = {"vvar_page", true},
 	[sym_pvclock_page] = {"pvclock_page", true},
 	[sym_hvclock_page] = {"hvclock_page", true},
+	[sym_timens_page] = {"timens_page", true},
 	{"VDSO32_NOTE_MASK", true},
 	{"__kernel_vsyscall", true},
 	{"__kernel_sigreturn", true},
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 230474e..bbcdc7b 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -21,6 +21,7 @@ struct vdso_image {
 	long sym_vvar_page;
 	long sym_pvclock_page;
 	long sym_hvclock_page;
+	long sym_timens_page;
 	long sym_VDSO32_NOTE_MASK;
 	long sym___kernel_sigreturn;
 	long sym___kernel_rt_sigreturn;
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 52c3bcd..6ee1f7d 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -21,6 +21,7 @@
 #include <clocksource/hyperv_timer.h>
 
 #define __vdso_data (VVAR(_vdso_data))
+#define __timens_vdso_data (TIMENS(_vdso_data))
 
 #define VDSO_HAS_TIME 1
 
@@ -56,6 +57,13 @@ extern struct ms_hyperv_tsc_page hvclock_page
 	__attribute__((visibility("hidden")));
 #endif
 
+#ifdef CONFIG_TIME_NS
+static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
+{
+	return __timens_vdso_data;
+}
+#endif
+
 #ifndef BUILD_VDSO32
 
 static __always_inline
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index ff2de30..183e98e 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -33,9 +33,12 @@ extern char __vvar_page;
 
 #define DECLARE_VVAR(offset, type, name)				\
 	extern type vvar_ ## name[CS_BASES]				\
-	__attribute__((visibility("hidden")));
+	__attribute__((visibility("hidden")));				\
+	extern type timens_ ## name[CS_BASES]				\
+	__attribute__((visibility("hidden")));				\
 
 #define VVAR(name) (vvar_ ## name)
+#define TIMENS(name) (timens_ ## name)
 
 #define DEFINE_VVAR(type, name)						\
 	type name[CS_BASES]						\
