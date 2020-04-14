Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D636C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752E9206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436569AbgDNIWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407125AbgDNIUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:20:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6962EC008749;
        Tue, 14 Apr 2020 01:20:52 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOGoM-0006HD-CW; Tue, 14 Apr 2020 10:20:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F11C01C0450;
        Tue, 14 Apr 2020 10:20:49 +0200 (CEST)
Date:   Tue, 14 Apr 2020 08:20:49 -0000
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub/file: Merge file name buffers to reduce
 stack usage
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200409130434.6736-8-ardb@kernel.org>
References: <20200409130434.6736-8-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <158685244958.28353.5775000940179796579.tip-bot2@tip-bot2>
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

Commit-ID:     464fb126d98a047953040cc9c754801dbda54e5d
Gitweb:        https://git.kernel.org/tip/464fb126d98a047953040cc9c754801dbda54e5d
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 09 Apr 2020 15:04:32 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 14 Apr 2020 08:32:15 +02:00

efi/libstub/file: Merge file name buffers to reduce stack usage

Arnd reports that commit

  9302c1bb8e47 ("efi/libstub: Rewrite file I/O routine")

reworks the file I/O routines in a way that triggers the following
warning:

  drivers/firmware/efi/libstub/file.c:240:1: warning: the frame size
            of 1200 bytes is larger than 1024 bytes [-Wframe-larger-than=]

We can work around this issue dropping an instance of efi_char16_t[256]
from the stack frame, and reusing the 'filename' field of the file info
struct that we use to obtain file information from EFI (which contains
the file name even though we already know it since we used it to open
the file in the first place)

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200409130434.6736-8-ardb@kernel.org
---
 drivers/firmware/efi/libstub/file.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index d4c7e5f..ea66b1f 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -29,30 +29,31 @@
  */
 #define EFI_READ_CHUNK_SIZE	SZ_1M
 
+struct finfo {
+	efi_file_info_t info;
+	efi_char16_t	filename[MAX_FILENAME_SIZE];
+};
+
 static efi_status_t efi_open_file(efi_file_protocol_t *volume,
-				  efi_char16_t *filename_16,
+				  struct finfo *fi,
 				  efi_file_protocol_t **handle,
 				  unsigned long *file_size)
 {
-	struct {
-		efi_file_info_t info;
-		efi_char16_t	filename[MAX_FILENAME_SIZE];
-	} finfo;
 	efi_guid_t info_guid = EFI_FILE_INFO_ID;
 	efi_file_protocol_t *fh;
 	unsigned long info_sz;
 	efi_status_t status;
 
-	status = volume->open(volume, &fh, filename_16, EFI_FILE_MODE_READ, 0);
+	status = volume->open(volume, &fh, fi->filename, EFI_FILE_MODE_READ, 0);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err("Failed to open file: ");
-		efi_char16_printk(filename_16);
+		efi_char16_printk(fi->filename);
 		efi_printk("\n");
 		return status;
 	}
 
-	info_sz = sizeof(finfo);
-	status = fh->get_info(fh, &info_guid, &info_sz, &finfo);
+	info_sz = sizeof(struct finfo);
+	status = fh->get_info(fh, &info_guid, &info_sz, fi);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err("Failed to get file info\n");
 		fh->close(fh);
@@ -60,7 +61,7 @@ static efi_status_t efi_open_file(efi_file_protocol_t *volume,
 	}
 
 	*handle = fh;
-	*file_size = finfo.info.file_size;
+	*file_size = fi->info.file_size;
 	return EFI_SUCCESS;
 }
 
@@ -146,13 +147,13 @@ static efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 
 	alloc_addr = alloc_size = 0;
 	do {
-		efi_char16_t filename[MAX_FILENAME_SIZE];
+		struct finfo fi;
 		unsigned long size;
 		void *addr;
 
 		offset = find_file_option(cmdline, cmdline_len,
 					  optstr, optstr_size,
-					  filename, ARRAY_SIZE(filename));
+					  fi.filename, ARRAY_SIZE(fi.filename));
 
 		if (!offset)
 			break;
@@ -166,7 +167,7 @@ static efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 				return status;
 		}
 
-		status = efi_open_file(volume, filename, &file, &size);
+		status = efi_open_file(volume, &fi, &file, &size);
 		if (status != EFI_SUCCESS)
 			goto err_close_volume;
 
