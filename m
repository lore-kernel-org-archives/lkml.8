Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC04AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9753F204EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbgEVSae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730838AbgEVSaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:30:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E73C08C5C0;
        Fri, 22 May 2020 11:30:20 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jcCQz-0002lW-FX; Fri, 22 May 2020 20:30:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 28E1F1C0095;
        Fri, 22 May 2020 20:30:17 +0200 (CEST)
Date:   Fri, 22 May 2020 18:30:17 -0000
From:   "tip-bot2 for Lenny Szubowicz" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub/x86: Avoid EFI map buffer alloc in
 allocate_e820()
Cc:     Lenny Szubowicz <lszubowi@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159017221704.17951.4059011817062465149.tip-bot2@tip-bot2>
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

Commit-ID:     fd62619598069c974739476d1851a00d665041d7
Gitweb:        https://git.kernel.org/tip/fd62619598069c974739476d1851a00d665041d7
Author:        Lenny Szubowicz <lszubowi@redhat.com>
AuthorDate:    Thu, 07 May 2020 14:33:32 -04:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 14 May 2020 11:11:18 +02:00

efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820()

In allocate_e820(), call the EFI get_memory_map() service directly
instead of indirectly via efi_get_memory_map(). This avoids allocation
of a buffer and return of the full EFI memory map, which is not needed
here and would otherwise need to be freed.

Routine allocate_e820() only needs to know how many EFI memory
descriptors there are in the map to allocate an adequately sized
e820ext buffer, if it's needed. Note that since efi_get_memory_map()
returns a memory map buffer sized with extra headroom, allocate_e820()
now needs to explicitly factor that into the e820ext size calculation.

Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h  | 13 +++++++++++++-
 drivers/firmware/efi/libstub/mem.c      |  2 +--
 drivers/firmware/efi/libstub/x86-stub.c | 24 +++++++++---------------
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 67d2694..6294399 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -92,6 +92,19 @@ extern __pure efi_system_table_t  *efi_system_table(void);
 #define EFI_LOCATE_BY_REGISTER_NOTIFY		1
 #define EFI_LOCATE_BY_PROTOCOL			2
 
+/*
+ * An efi_boot_memmap is used by efi_get_memory_map() to return the
+ * EFI memory map in a dynamically allocated buffer.
+ *
+ * The buffer allocated for the EFI memory map includes extra room for
+ * a minimum of EFI_MMAP_NR_SLACK_SLOTS additional EFI memory descriptors.
+ * This facilitates the reuse of the EFI memory map buffer when a second
+ * call to ExitBootServices() is needed because of intervening changes to
+ * the EFI memory map. Other related structures, e.g. x86 e820ext, need
+ * to factor in this headroom requirement as well.
+ */
+#define EFI_MMAP_NR_SLACK_SLOTS	8
+
 struct efi_boot_memmap {
 	efi_memory_desc_t	**map;
 	unsigned long		*map_size;
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 869a79c..09f4fa0 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -5,8 +5,6 @@
 
 #include "efistub.h"
 
-#define EFI_MMAP_NR_SLACK_SLOTS	8
-
 static inline bool mmap_has_headroom(unsigned long buff_size,
 				     unsigned long map_size,
 				     unsigned long desc_size)
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 05ccb22..f0339b5 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -606,24 +606,18 @@ static efi_status_t allocate_e820(struct boot_params *params,
 				  struct setup_data **e820ext,
 				  u32 *e820ext_size)
 {
-	unsigned long map_size, desc_size, buff_size;
-	struct efi_boot_memmap boot_map;
-	efi_memory_desc_t *map;
+	unsigned long map_size, desc_size, map_key;
 	efi_status_t status;
-	__u32 nr_desc;
+	__u32 nr_desc, desc_version;
 
-	boot_map.map		= &map;
-	boot_map.map_size	= &map_size;
-	boot_map.desc_size	= &desc_size;
-	boot_map.desc_ver	= NULL;
-	boot_map.key_ptr	= NULL;
-	boot_map.buff_size	= &buff_size;
+	/* Only need the size of the mem map and size of each mem descriptor */
+	map_size = 0;
+	status = efi_bs_call(get_memory_map, &map_size, NULL, &map_key,
+			     &desc_size, &desc_version);
+	if (status != EFI_BUFFER_TOO_SMALL)
+		return (status != EFI_SUCCESS) ? status : EFI_UNSUPPORTED;
 
-	status = efi_get_memory_map(&boot_map);
-	if (status != EFI_SUCCESS)
-		return status;
-
-	nr_desc = buff_size / desc_size;
+	nr_desc = map_size / desc_size + EFI_MMAP_NR_SLACK_SLOTS;
 
 	if (nr_desc > ARRAY_SIZE(params->e820_table)) {
 		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
