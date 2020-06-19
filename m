Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70982C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC0C20734
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405812AbgFSQxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387568AbgFSQxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:53:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A38BC0613EE;
        Fri, 19 Jun 2020 09:53:47 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jmKGs-0004iM-Io; Fri, 19 Jun 2020 18:53:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A424C1C06E5;
        Fri, 19 Jun 2020 18:46:01 +0200 (CEST)
Date:   Fri, 19 Jun 2020 16:46:01 -0000
From:   "tip-bot2 for Fabian Vogt" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/tpm: Verify event log header before parsing
Cc:     Fabian Vogt <fvogt@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1927248.evlx2EsYKh@linux-e202.suse.de>
References: <1927248.evlx2EsYKh@linux-e202.suse.de>
MIME-Version: 1.0
Message-ID: <159258516144.16989.5059538848068469375.tip-bot2@tip-bot2>
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

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     7dfc06a0f25b593a9f51992f540c0f80a57f3629
Gitweb:        https://git.kernel.org/tip/7dfc06a0f25b593a9f51992f540c0f80a57f3629
Author:        Fabian Vogt <fvogt@suse.de>
AuthorDate:    Mon, 15 Jun 2020 09:16:36 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Mon, 15 Jun 2020 14:37:02 +02:00

efi/tpm: Verify event log header before parsing

It is possible that the first event in the event log is not actually a
log header at all, but rather a normal event. This leads to the cast in
__calc_tpm2_event_size being an invalid conversion, which means that
the values read are effectively garbage. Depending on the first event's
contents, this leads either to apparently normal behaviour, a crash or
a freeze.

While this behaviour of the firmware is not in accordance with the
TCG Client EFI Specification, this happens on a Dell Precision 5510
with the TPM enabled but hidden from the OS ("TPM On" disabled, state
otherwise untouched). The EFI firmware claims that the TPM is present
and active and that it supports the TCG 2.0 event log format.

Fortunately, this can be worked around by simply checking the header
of the first event and the event log header signature itself.

Commit b4f1874c6216 ("tpm: check event log version before reading final
events") addressed a similar issue also found on Dell models.

Fixes: 6b0326190205 ("efi: Attempt to get the TCG2 event log in the boot stub")
Signed-off-by: Fabian Vogt <fvogt@suse.de>
Link: https://lore.kernel.org/r/1927248.evlx2EsYKh@linux-e202.suse.de
Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1165773
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/tpm_eventlog.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 4f8c90c..64356b1 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -81,6 +81,8 @@ struct tcg_efi_specid_event_algs {
 	u16 digest_size;
 } __packed;
 
+#define TCG_SPECID_SIG "Spec ID Event03"
+
 struct tcg_efi_specid_event_head {
 	u8 signature[16];
 	u32 platform_class;
@@ -171,6 +173,7 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 	int i;
 	int j;
 	u32 count, event_type;
+	const u8 zero_digest[sizeof(event_header->digest)] = {0};
 
 	marker = event;
 	marker_start = marker;
@@ -198,10 +201,19 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 	count = READ_ONCE(event->count);
 	event_type = READ_ONCE(event->event_type);
 
+	/* Verify that it's the log header */
+	if (event_header->pcr_idx != 0 ||
+	    event_header->event_type != NO_ACTION ||
+	    memcmp(event_header->digest, zero_digest, sizeof(zero_digest))) {
+		size = 0;
+		goto out;
+	}
+
 	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
 
 	/* Check if event is malformed. */
-	if (count > efispecid->num_algs) {
+	if (memcmp(efispecid->signature, TCG_SPECID_SIG,
+		   sizeof(TCG_SPECID_SIG)) || count > efispecid->num_algs) {
 		size = 0;
 		goto out;
 	}
