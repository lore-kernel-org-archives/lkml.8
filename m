Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5519C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A766206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbgEVSaV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbgEVSaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:30:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C812C05BD43;
        Fri, 22 May 2020 11:30:20 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jcCQy-0002kn-1L; Fri, 22 May 2020 20:30:16 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 535801C0095;
        Fri, 22 May 2020 20:30:15 +0200 (CEST)
Date:   Fri, 22 May 2020 18:30:15 -0000
From:   tip-bot2 for =?utf-8?q?Lo=C3=AFc?= Yhuel <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] tpm: check event log version before reading final events
Cc:     loic.yhuel@gmail.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512040113.277768-1-loic.yhuel@gmail.com>
References: <20200512040113.277768-1-loic.yhuel@gmail.com>
MIME-Version: 1.0
Message-ID: <159017221514.17951.2596829896883867713.tip-bot2@tip-bot2>
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

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     b4f1874c62168159fdb419ced4afc77c1b51c475
Gitweb:        https://git.kernel.org/tip/b4f1874c62168159fdb419ced4afc77c1b51c475
Author:        Loïc Yhuel <loic.yhuel@gmail.com>
AuthorDate:    Tue, 12 May 2020 06:01:13 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Sun, 17 May 2020 11:46:50 +02:00

tpm: check event log version before reading final events

This fixes the boot issues since 5.3 on several Dell models when the TPM
is enabled. Depending on the exact grub binary, booting the kernel would
freeze early, or just report an error parsing the final events log.

We get an event log in the SHA-1 format, which doesn't have a
tcg_efi_specid_event_head in the first event, and there is a final events
table which doesn't match the crypto agile format.
__calc_tpm2_event_size reads bad "count" and "efispecid->num_algs", and
either fails, or loops long enough for the machine to be appear frozen.

So we now only parse the final events table, which is per the spec always
supposed to be in the crypto agile format, when we got a event log in this
format.

Fixes: c46f3405692de ("tpm: Reserve the TPM final events table")
Fixes: 166a2809d65b2 ("tpm: Don't duplicate events from the final event log in the TCG2 log")
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1779611
Signed-off-by: Loïc Yhuel <loic.yhuel@gmail.com>
Link: https://lore.kernel.org/r/20200512040113.277768-1-loic.yhuel@gmail.com
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Matthew Garrett <mjg59@google.com>
[ardb: warn when final events table is missing or in the wrong format]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/tpm.c | 5 +++--
 drivers/firmware/efi/tpm.c         | 5 ++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 1d59e10..e9a6846 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -54,7 +54,7 @@ void efi_retrieve_tpm2_eventlog(void)
 	efi_status_t status;
 	efi_physical_addr_t log_location = 0, log_last_entry = 0;
 	struct linux_efi_tpm_eventlog *log_tbl = NULL;
-	struct efi_tcg2_final_events_table *final_events_table;
+	struct efi_tcg2_final_events_table *final_events_table = NULL;
 	unsigned long first_entry_addr, last_entry_addr;
 	size_t log_size, last_entry_size;
 	efi_bool_t truncated;
@@ -127,7 +127,8 @@ void efi_retrieve_tpm2_eventlog(void)
 	 * Figure out whether any events have already been logged to the
 	 * final events structure, and if so how much space they take up
 	 */
-	final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
+	if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
+		final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
 	if (final_events_table && final_events_table->nr_events) {
 		struct tcg_pcr_event2_head *header;
 		int offset;
diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 31f9f0e..0543fbf 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -62,8 +62,11 @@ int __init efi_tpm_eventlog_init(void)
 	tbl_size = sizeof(*log_tbl) + log_tbl->size;
 	memblock_reserve(efi.tpm_log, tbl_size);
 
-	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR)
+	if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR ||
+	    log_tbl->version != EFI_TCG2_EVENT_LOG_FORMAT_TCG_2) {
+		pr_warn(FW_BUG "TPM Final Events table missing or invalid\n");
 		goto out;
+	}
 
 	final_tbl = early_memremap(efi.tpm_final_log, sizeof(*final_tbl));
 
