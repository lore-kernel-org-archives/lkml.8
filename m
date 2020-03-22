Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C4CC54FCF
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DB820724
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 16:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCVQ2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:28:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:4097 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgCVQ2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 12:28:42 -0400
IronPort-SDR: I3mH5QzG+RHPOWloEMyTy4sljVW+AYo8utugHI8kv7T2BhCN2NdQ+flAFXsMSbuHCWUbs6h6Hr
 JQt2UWoh7YwA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 09:28:42 -0700
IronPort-SDR: xjxO2EKMTrcHuqu+2bBXG9RZo4A2aIqynGuLHSmjXlIVizBScPoZEIlPf6VPVravz0jgNm2qgE
 QoxhnnnY/Sbg==
X-IronPort-AV: E=Sophos;i="5.72,293,1580803200"; 
   d="scan'208";a="445552569"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 09:28:41 -0700
Subject: [PATCH v2 2/6] x86/numa: Add 'nohmat' option
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, ard.biesheuvel@linaro.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, joao.m.martins@oracle.com
Date:   Sun, 22 Mar 2020 09:12:35 -0700
Message-ID: <158489355512.1457606.5473443384722523736.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable parsing of the HMAT for debug, to workaround broken platform
instances, or cases where it is otherwise not wanted.

Cc: x86@kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/numa.c       |    2 ++
 drivers/acpi/numa/hmat.c |    8 +++++++-
 include/acpi/acpi_numa.h |    8 ++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 9c1266b2628c..250a013cbbe0 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -41,6 +41,8 @@ static __init int numa_setup(char *opt)
 		return numa_emu_cmdline(opt + 5);
 	if (!strncmp(opt, "noacpi", 6))
 		disable_srat();
+	if (!strncmp(opt, "nohmat", 6))
+		disable_hmat();
 	return 0;
 }
 early_param("numa", numa_setup);
diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 2c32cfb72370..a12e36a12618 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -26,6 +26,12 @@
 #include <linux/sysfs.h>
 
 static u8 hmat_revision;
+static int hmat_disable __initdata;
+
+void __init disable_hmat(void)
+{
+	hmat_disable = 1;
+}
 
 static LIST_HEAD(targets);
 static LIST_HEAD(initiators);
@@ -814,7 +820,7 @@ static __init int hmat_init(void)
 	enum acpi_hmat_type i;
 	acpi_status status;
 
-	if (srat_disabled())
+	if (srat_disabled() || hmat_disable)
 		return 0;
 
 	status = acpi_get_table(ACPI_SIG_SRAT, 0, &tbl);
diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
index 8784183b2204..0e9302285f14 100644
--- a/include/acpi/acpi_numa.h
+++ b/include/acpi/acpi_numa.h
@@ -27,4 +27,12 @@ static inline void disable_srat(void)
 {
 }
 #endif				/* CONFIG_ACPI_NUMA */
+
+#ifdef CONFIG_ACPI_HMAT
+extern void disable_hmat(void);
+#else				/* CONFIG_ACPI_HMAT */
+static inline void disable_hmat(void)
+{
+}
+#endif				/* CONFIG_ACPI_HMAT */
 #endif				/* __ACP_NUMA_H */

