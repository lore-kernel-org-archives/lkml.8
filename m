Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EF1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCAD8206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405682AbgFSQql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733248AbgFSQqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:46:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8642C061795;
        Fri, 19 Jun 2020 09:46:02 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jmK9Q-00043p-0f; Fri, 19 Jun 2020 18:46:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AA0FC1C0085;
        Fri, 19 Jun 2020 18:45:59 +0200 (CEST)
Date:   Fri, 19 Jun 2020 16:45:59 -0000
From:   "tip-bot2 for Philipp Fent" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub: Fix path separator regression
Cc:     Philipp Fent <fent@in.tum.de>, Ard Biesheuvel <ardb@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200615115109.7823-1-fent@in.tum.de>
References: <20200615115109.7823-1-fent@in.tum.de>
MIME-Version: 1.0
Message-ID: <159258515942.16989.6902120610711926134.tip-bot2@tip-bot2>
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

Commit-ID:     7a88a6227dc7f2e723bba11ece05e57bd8dce8e4
Gitweb:        https://git.kernel.org/tip/7a88a6227dc7f2e723bba11ece05e57bd8dce8e4
Author:        Philipp Fent <fent@in.tum.de>
AuthorDate:    Mon, 15 Jun 2020 13:51:09 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Mon, 15 Jun 2020 19:43:59 +02:00

efi/libstub: Fix path separator regression

Commit 9302c1bb8e47 ("efi/libstub: Rewrite file I/O routine") introduced a
regression that made a couple of (badly configured) systems fail to
boot [1]: Until 5.6, we silently accepted Unix-style file separators in
EFI paths, which might violate the EFI standard, but are an easy to make
mistake. This fix restores the pre-5.7 behaviour.

[1] https://bbs.archlinux.org/viewtopic.php?id=256273

Fixes: 9302c1bb8e47 ("efi/libstub: Rewrite file I/O routine")
Signed-off-by: Philipp Fent <fent@in.tum.de>
Link: https://lore.kernel.org/r/20200615115109.7823-1-fent@in.tum.de
[ardb: rewrite as chained if/else statements]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/file.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index 2005e33..630caa6 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -102,12 +102,20 @@ static int find_file_option(const efi_char16_t *cmdline, int cmdline_len,
 	if (!found)
 		return 0;
 
+	/* Skip any leading slashes */
+	while (cmdline[i] == L'/' || cmdline[i] == L'\\')
+		i++;
+
 	while (--result_len > 0 && i < cmdline_len) {
-		if (cmdline[i] == L'\0' ||
-		    cmdline[i] == L'\n' ||
-		    cmdline[i] == L' ')
+		efi_char16_t c = cmdline[i++];
+
+		if (c == L'\0' || c == L'\n' || c == L' ')
 			break;
-		*result++ = cmdline[i++];
+		else if (c == L'/')
+			/* Replace UNIX dir separators with EFI standard ones */
+			*result++ = L'\\';
+		else
+			*result++ = c;
 	}
 	*result = L'\0';
 	return i;
