Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C08EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5451C208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhw69oSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgIIHvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbgIIHux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599637851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oFGgC/FDoYZhSU8b4Uab79sGJ0NrKz3NI9qlx3SDNNs=;
        b=bhw69oSvjvAzYVaeLkvmqsOuNcwRrBy7szDS/lK1NA08QkHyTeSOX6ySq41J2I/F1ybxOw
        NSXficLxbrYtYtuWuVII5x8mccX23JwfFNAkQP+wiiV/5nu6yBbMZsaUQu696UtLTqNcBL
        OUoPDbNLvtS+geE3K+fS3AoHGfhqALc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-PFolikKPMSOFIyJSvQOpIQ-1; Wed, 09 Sep 2020 03:50:50 -0400
X-MC-Unique: PFolikKPMSOFIyJSvQOpIQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04D48802B6C;
        Wed,  9 Sep 2020 07:50:49 +0000 (UTC)
Received: from kasong-rh-laptop.redhat.com (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7717F100238C;
        Wed,  9 Sep 2020 07:50:45 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH 3/3] x86_64: implement copy_to_oldmem_page
Date:   Wed,  9 Sep 2020 15:50:16 +0800
Message-Id: <20200909075016.104407-4-kasong@redhat.com>
In-Reply-To: <20200909075016.104407-1-kasong@redhat.com>
References: <20200909075016.104407-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous commit introduced writing support for vmcore, it requires
per-architecture implementation for the writing function.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/crash_dump_64.c | 49 +++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 045e82e8945b..ec80da75b287 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -13,7 +13,7 @@
 
 static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 				  unsigned long offset, int userbuf,
-				  bool encrypted)
+				  bool encrypted, bool is_write)
 {
 	void  *vaddr;
 
@@ -28,13 +28,25 @@ static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 	if (!vaddr)
 		return -ENOMEM;
 
-	if (userbuf) {
-		if (copy_to_user((void __user *)buf, vaddr + offset, csize)) {
-			iounmap((void __iomem *)vaddr);
-			return -EFAULT;
+	if (is_write) {
+		if (userbuf) {
+			if (copy_from_user(vaddr + offset, (void __user *)buf, csize)) {
+				iounmap((void __iomem *)vaddr);
+				return -EFAULT;
+			}
+		} else {
+			memcpy(vaddr + offset, buf, csize);
 		}
-	} else
-		memcpy(buf, vaddr + offset, csize);
+	} else {
+		if (userbuf) {
+			if (copy_to_user((void __user *)buf, vaddr + offset, csize)) {
+				iounmap((void __iomem *)vaddr);
+				return -EFAULT;
+			}
+		} else {
+			memcpy(buf, vaddr + offset, csize);
+		}
+	}
 
 	set_iounmap_nonlazy();
 	iounmap((void __iomem *)vaddr);
@@ -57,7 +69,7 @@ static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 			 unsigned long offset, int userbuf)
 {
-	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, false);
+	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, false, false);
 }
 
 /**
@@ -68,7 +80,26 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
 				   unsigned long offset, int userbuf)
 {
-	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, true);
+	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, true, false);
+}
+
+/**
+ * copy_to_oldmem_page - similar to copy_oldmem_page but in opposite direction.
+ */
+ssize_t copy_to_oldmem_page(unsigned long pfn, char *src, size_t csize,
+		unsigned long offset, int userbuf)
+{
+	return __copy_oldmem_page(pfn, src, csize, offset, userbuf, false, true);
+}
+
+/**
+ * copy_to_oldmem_page_encrypted - similar to copy_oldmem_page_encrypted but
+ * in opposite direction.
+ */
+ssize_t copy_to_oldmem_page_encrypted(unsigned long pfn, char *src, size_t csize,
+		unsigned long offset, int userbuf)
+{
+	return __copy_oldmem_page(pfn, src, csize, offset, userbuf, true, true);
 }
 
 ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
-- 
2.26.2

