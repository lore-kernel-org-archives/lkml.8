Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A81FC4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769E920578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 15:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgCOPQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 11:16:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50141 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbgCOPQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 11:16:12 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jDUzp-0001hs-3L; Sun, 15 Mar 2020 16:16:09 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 2FA7AFFB8B;
        Sun, 15 Mar 2020 16:16:08 +0100 (CET)
Date:   Sun, 15 Mar 2020 15:14:38 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] efi/urgent for 5.6-rc6
Message-ID: <158428527861.14940.12920965330771600615.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest efi/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2020-03-15

up to:  d6c066fda90d: efi: Add a sanity check to efivar_store_raw()

Two EFI fixes:

 - Prevent a race and buffer overflow in the sysfs efivars interface which
   causes kernel memory corruption.

 - Add the missing NULL pointer checks in efivar_store_raw()

Thanks,

	tglx

------------------>
Vladis Dronov (2):
      efi: Fix a race and a buffer overflow while reading efivars via sysfs
      efi: Add a sanity check to efivar_store_raw()


 drivers/firmware/efi/efivars.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index 7576450c8254..aff3dfb4d7ba 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -83,13 +83,16 @@ static ssize_t
 efivar_attr_read(struct efivar_entry *entry, char *buf)
 {
 	struct efi_variable *var = &entry->var;
+	unsigned long size = sizeof(var->Data);
 	char *str = buf;
+	int ret;
 
 	if (!entry || !buf)
 		return -EINVAL;
 
-	var->DataSize = 1024;
-	if (efivar_entry_get(entry, &var->Attributes, &var->DataSize, var->Data))
+	ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
+	var->DataSize = size;
+	if (ret)
 		return -EIO;
 
 	if (var->Attributes & EFI_VARIABLE_NON_VOLATILE)
@@ -116,13 +119,16 @@ static ssize_t
 efivar_size_read(struct efivar_entry *entry, char *buf)
 {
 	struct efi_variable *var = &entry->var;
+	unsigned long size = sizeof(var->Data);
 	char *str = buf;
+	int ret;
 
 	if (!entry || !buf)
 		return -EINVAL;
 
-	var->DataSize = 1024;
-	if (efivar_entry_get(entry, &var->Attributes, &var->DataSize, var->Data))
+	ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
+	var->DataSize = size;
+	if (ret)
 		return -EIO;
 
 	str += sprintf(str, "0x%lx\n", var->DataSize);
@@ -133,12 +139,15 @@ static ssize_t
 efivar_data_read(struct efivar_entry *entry, char *buf)
 {
 	struct efi_variable *var = &entry->var;
+	unsigned long size = sizeof(var->Data);
+	int ret;
 
 	if (!entry || !buf)
 		return -EINVAL;
 
-	var->DataSize = 1024;
-	if (efivar_entry_get(entry, &var->Attributes, &var->DataSize, var->Data))
+	ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
+	var->DataSize = size;
+	if (ret)
 		return -EIO;
 
 	memcpy(buf, var->Data, var->DataSize);
@@ -199,6 +208,9 @@ efivar_store_raw(struct efivar_entry *entry, const char *buf, size_t count)
 	u8 *data;
 	int err;
 
+	if (!entry || !buf)
+		return -EINVAL;
+
 	if (in_compat_syscall()) {
 		struct compat_efi_variable *compat;
 
@@ -250,14 +262,16 @@ efivar_show_raw(struct efivar_entry *entry, char *buf)
 {
 	struct efi_variable *var = &entry->var;
 	struct compat_efi_variable *compat;
+	unsigned long datasize = sizeof(var->Data);
 	size_t size;
+	int ret;
 
 	if (!entry || !buf)
 		return 0;
 
-	var->DataSize = 1024;
-	if (efivar_entry_get(entry, &entry->var.Attributes,
-			     &entry->var.DataSize, entry->var.Data))
+	ret = efivar_entry_get(entry, &var->Attributes, &datasize, var->Data);
+	var->DataSize = datasize;
+	if (ret)
 		return -EIO;
 
 	if (in_compat_syscall()) {

