Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FA0C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6FD20780
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvRlLVJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgC3SQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:16:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:50009 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbgC3SQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585592189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7DjDFsYHR6g0Apa3zR6vDBd2N+92jMQpUXuk9YaC+4o=;
        b=XvRlLVJmT+5KKxuS1Fou/4b0ZUE1kJhtqq1ganLm1aTraR0DxFrGjdpUnEa+C6nkp8jRbq
        9Yyq0sSfal+kti+wZQ1SkiE4RTah9s0ukhVyPKEgbEBvdsCTwePXemXOO886nZjnL5puYb
        40NwwuIxf/V6ys5VhqN2qA8REGYw1T4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-MQB-bG8gPSmah6nbFvMhxw-1; Mon, 30 Mar 2020 14:16:26 -0400
X-MC-Unique: MQB-bG8gPSmah6nbFvMhxw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0694ADB60;
        Mon, 30 Mar 2020 18:16:25 +0000 (UTC)
Received: from kasong-rh-laptop.redhat.com (ovpn-12-175.pek2.redhat.com [10.72.12.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9806797B01;
        Mon, 30 Mar 2020 18:16:19 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Young <dyoung@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>
Subject: [PATCH] crash_dump: remove saved_max_pfn
Date:   Tue, 31 Mar 2020 02:15:44 +0800
Message-Id: <20200330181544.1595733-1-kasong@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is no longer used.

saved_max_pfn was originally introduce in commit 92aa63a5a1bf ("[PATCH]
kdump: Retrieve saved max pfn"), used to make sure that user does not
try to read the physical memory beyond saved_max_pfn. But since
commit 921d58c0e699 ("vmcore: remove saved_max_pfn check")
it's no longer used for the check.

Only user left is Calary IOMMU, which start using it from
commit 95b68dec0d52 ("calgary iommu: use the first kernels TCE tables
in kdump"). But again, recently in commit 90dc392fc445 ("x86: Remove
the calgary IOMMU driver"), Calary IOMMU is removed and this variable
no longer have any user.

So just remove it.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/e820.c     | 8 --------
 include/linux/crash_dump.h | 2 --
 kernel/crash_dump.c        | 6 ------
 3 files changed, 16 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index c5399e80c59c..4d13c57f370a 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -910,14 +910,6 @@ static int __init parse_memmap_one(char *p)
 		return -EINVAL;
=20
 	if (!strncmp(p, "exactmap", 8)) {
-#ifdef CONFIG_CRASH_DUMP
-		/*
-		 * If we are doing a crash dump, we still need to know
-		 * the real memory size before the original memory map is
-		 * reset.
-		 */
-		saved_max_pfn =3D e820__end_of_ram_pfn();
-#endif
 		e820_table->nr_entries =3D 0;
 		userdef =3D 1;
 		return 0;
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 4664fc1871de..bc156285d097 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -97,8 +97,6 @@ extern void unregister_oldmem_pfn_is_ram(void);
 static inline bool is_kdump_kernel(void) { return 0; }
 #endif /* CONFIG_CRASH_DUMP */
=20
-extern unsigned long saved_max_pfn;
-
 /* Device Dump information to be filled by drivers */
 struct vmcoredd_data {
 	char dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Unique name of the dump */
diff --git a/kernel/crash_dump.c b/kernel/crash_dump.c
index 9c23ae074b40..92da32275af5 100644
--- a/kernel/crash_dump.c
+++ b/kernel/crash_dump.c
@@ -5,12 +5,6 @@
 #include <linux/errno.h>
 #include <linux/export.h>
=20
-/*
- * If we have booted due to a crash, max_pfn will be a very low value. W=
e need
- * to know the amount of memory that the previous kernel used.
- */
-unsigned long saved_max_pfn;
-
 /*
  * stores the physical address of elf header of crash image
  *
--=20
2.25.1

