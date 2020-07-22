Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06D3C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DDC2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0egeaGBL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8AwDzGp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733145AbgGVWsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:48:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52888 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVWsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:48:43 -0400
Date:   Wed, 22 Jul 2020 22:48:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595458120;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=t2l/L4GhLeSrLGygotuLLBQFdMatIcVBkwwJ3F40Si0=;
        b=0egeaGBLVPeyAJkpRH1O5ct5bPcjoL5nYsOOeFPWe4J1V3UZtLVd1mr7bbcP5fVUQm3PPA
        q4V6DS2qtnK+qibNeJ8WgN5bXyyRiSGbojUYA7tSo77JkHiftOVqpKMl9ZUTNTrbkbRMTN
        H+uyy8buer0uZYlcNS08uzlZ6pf6FJ02AAt41WnR0r7h21QRCYM/pScyuVQT6ZwoUM/wNp
        WonxCJLTFGG/BTqC4fSCuM6YBtljBrW5FHRD8fef/wS3opNBirl/8ARIXlmw2kfdNEy8eg
        rnpcE7mHqgMDF3ohMkjiUtyv/HmwXOhbpsDrY/ETYdA3tZ3i42bb8APl5ZKKkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595458120;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=t2l/L4GhLeSrLGygotuLLBQFdMatIcVBkwwJ3F40Si0=;
        b=8AwDzGp1KUpgS5C4ZnTH1U60XRP/4tPe1h9QTGxf6fXMoN5+uOMiEB4Z89bbWLv9NbH1FS
        Q8ZX0/7ebNdrCiAQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/efivars: Expose RT service availability via
 efivars abstraction
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159545811944.4006.1233251520166773134.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     f88814cc2578c121e6edef686365036db72af0ed
Gitweb:        https://git.kernel.org/tip/f88814cc2578c121e6edef686365036db72af0ed
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 08 Jul 2020 13:01:57 +03:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 09 Jul 2020 10:14:29 +03:00

efi/efivars: Expose RT service availability via efivars abstraction

Commit

  bf67fad19e493b ("efi: Use more granular check for availability for variable services")

introduced a check into the efivarfs, efi-pstore and other drivers that
aborts loading of the module if not all three variable runtime services
(GetVariable, SetVariable and GetNextVariable) are supported. However, this
results in efivarfs being unavailable entirely if only SetVariable support
is missing, which is only needed if you want to make any modifications.
Also, efi-pstore and the sysfs EFI variable interface could be backed by
another implementation of the 'efivars' abstraction, in which case it is
completely irrelevant which services are supported by the EFI firmware.

So make the generic 'efivars' abstraction dependent on the availibility of
the GetVariable and GetNextVariable EFI runtime services, and add a helper
'efivar_supports_writes()' to find out whether the currently active efivars
abstraction supports writes (and wire it up to the availability of
SetVariable for the generic one).

Then, use the efivar_supports_writes() helper to decide whether to permit
efivarfs to be mounted read-write, and whether to enable efi-pstore or the
sysfs EFI variable interface altogether.

Fixes: bf67fad19e493b ("efi: Use more granular check for availability for variable services")
Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi-pstore.c |  5 +----
 drivers/firmware/efi/efi.c        | 12 ++++++++----
 drivers/firmware/efi/efivars.c    |  5 +----
 drivers/firmware/efi/vars.c       |  6 ++++++
 fs/efivarfs/super.c               |  6 +++---
 include/linux/efi.h               |  1 +
 6 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index c2f1d4e..feb7fe6 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -356,10 +356,7 @@ static struct pstore_info efi_pstore_info = {
 
 static __init int efivars_pstore_init(void)
 {
-	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
-		return 0;
-
-	if (!efivars_kobject())
+	if (!efivars_kobject() || !efivar_supports_writes())
 		return 0;
 
 	if (efivars_pstore_disable)
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5114cae..fdd1db0 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -176,11 +176,13 @@ static struct efivar_operations generic_ops;
 static int generic_ops_register(void)
 {
 	generic_ops.get_variable = efi.get_variable;
-	generic_ops.set_variable = efi.set_variable;
-	generic_ops.set_variable_nonblocking = efi.set_variable_nonblocking;
 	generic_ops.get_next_variable = efi.get_next_variable;
 	generic_ops.query_variable_store = efi_query_variable_store;
 
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
+		generic_ops.set_variable = efi.set_variable;
+		generic_ops.set_variable_nonblocking = efi.set_variable_nonblocking;
+	}
 	return efivars_register(&generic_efivars, &generic_ops, efi_kobj);
 }
 
@@ -382,7 +384,8 @@ static int __init efisubsys_init(void)
 		return -ENOMEM;
 	}
 
-	if (efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES)) {
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE |
+				      EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME)) {
 		efivar_ssdt_load();
 		error = generic_ops_register();
 		if (error)
@@ -416,7 +419,8 @@ static int __init efisubsys_init(void)
 err_remove_group:
 	sysfs_remove_group(efi_kobj, &efi_subsys_attr_group);
 err_unregister:
-	if (efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
+	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE |
+				      EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME))
 		generic_ops_unregister();
 err_put:
 	kobject_put(efi_kobj);
diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index 26528a4..dcea137 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -680,11 +680,8 @@ int efivars_sysfs_init(void)
 	struct kobject *parent_kobj = efivars_kobject();
 	int error = 0;
 
-	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
-		return -ENODEV;
-
 	/* No efivars has been registered yet */
-	if (!parent_kobj)
+	if (!parent_kobj || !efivar_supports_writes())
 		return 0;
 
 	printk(KERN_INFO "EFI Variables Facility v%s %s\n", EFIVARS_VERSION,
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 5f2a4d1..973eef2 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -1229,3 +1229,9 @@ out:
 	return rv;
 }
 EXPORT_SYMBOL_GPL(efivars_unregister);
+
+int efivar_supports_writes(void)
+{
+	return __efivars && __efivars->ops->set_variable;
+}
+EXPORT_SYMBOL_GPL(efivar_supports_writes);
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 12c66f5..28bb568 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -201,6 +201,9 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_d_op		= &efivarfs_d_ops;
 	sb->s_time_gran         = 1;
 
+	if (!efivar_supports_writes())
+		sb->s_flags |= SB_RDONLY;
+
 	inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
 	if (!inode)
 		return -ENOMEM;
@@ -252,9 +255,6 @@ static struct file_system_type efivarfs_type = {
 
 static __init int efivarfs_init(void)
 {
-	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
-		return -ENODEV;
-
 	if (!efivars_kobject())
 		return -ENODEV;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index bb35f33..05c47f8 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -994,6 +994,7 @@ int efivars_register(struct efivars *efivars,
 int efivars_unregister(struct efivars *efivars);
 struct kobject *efivars_kobject(void);
 
+int efivar_supports_writes(void);
 int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
 		void *data, bool duplicates, struct list_head *head);
 
