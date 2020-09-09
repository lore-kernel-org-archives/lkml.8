Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F753C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13923206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjcUDHwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgIIHu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:50:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26358 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728911AbgIIHuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599637850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8IVQYBd0mVL/4F97PRNEyo0IEIUlNYzoqekQ6AK1Hsc=;
        b=HjcUDHwUk4iDxkbPk0OBNU8b57iEA4b5kKxUjF1c7Rbd4RmW0JnTLKxqRF2/Xmy2zbUOxG
        SN5bWeOISucS9IlDL1pWDoxvvu5IJefzAbLX0a54jl5iGYrTFyHY4QGAjFxvBRLTDIGYzZ
        KCskMzc7NDZdWpleFkcWP8bWSxQqEv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557--_ChITQRP2yEses2TLqlWQ-1; Wed, 09 Sep 2020 03:50:46 -0400
X-MC-Unique: -_ChITQRP2yEses2TLqlWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECFFE1009441;
        Wed,  9 Sep 2020 07:50:44 +0000 (UTC)
Received: from kasong-rh-laptop.redhat.com (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CAA21002D49;
        Wed,  9 Sep 2020 07:50:41 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH 2/3] vmcore: Add interface to write to old mem
Date:   Wed,  9 Sep 2020 15:50:15 +0800
Message-Id: <20200909075016.104407-3-kasong@redhat.com>
In-Reply-To: <20200909075016.104407-1-kasong@redhat.com>
References: <20200909075016.104407-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmcore is used as the interface to access crashed kernel's memory in
kdump, and currently vmcore only supports reading.

Adding writing support is useful for enabling userspace making better
use of the old memory.

For kdump, `makedumpfile` is widely used to reduce the dumped vmcore
size, and in most setup, it will drop user space memory, caches. This
means these memory pages are reusable.

Kdump runs in limited pre-reserved memory region, so if these old memory
pages are reused, it can help reduce memory pressure in kdump kernel,
hence allow first kernel to reserve less memory for kdump.

Adding write support to vmcore is the first step, then user space can
do IO on the old mem. There are multiple ways to reuse the memory, for
example, userspace can register a NBD device, and redirect the IO on the
device to old memory. The NBD device can be used as swap, or used to
hold some temp files.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 fs/proc/vmcore.c           | 129 +++++++++++++++++++++++++++++++++----
 include/linux/crash_dump.h |  18 ++++--
 2 files changed, 131 insertions(+), 16 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 124c2066f3e5..23acc0f2ecd7 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -103,9 +103,9 @@ static int pfn_is_ram(unsigned long pfn)
 }
 
 /* Reads a page from the oldmem device from given offset. */
-ssize_t read_from_oldmem(char *buf, size_t count,
-			 u64 *ppos, int userbuf,
-			 bool encrypted)
+static ssize_t oldmem_rw_page(char *buf, size_t count,
+			      u64 *ppos, int userbuf,
+			      bool encrypted, bool is_write)
 {
 	unsigned long pfn, offset;
 	size_t nr_bytes, to_copy = count;
@@ -119,20 +119,33 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 
 		/* If pfn is not ram, return zeros for sparse dump files */
 		if (pfn_is_ram(pfn) == 0) {
-			memset(buf, 0, nr_bytes);
-		} else {
-			if (encrypted)
-				tmp = copy_oldmem_page_encrypted(pfn, buf,
-								 nr_bytes,
-								 offset,
-								 userbuf);
+			if (is_write)
+				return -EINVAL;
 			else
-				tmp = copy_oldmem_page(pfn, buf, nr_bytes,
-						       offset, userbuf);
+				memset(buf, 0, nr_bytes);
+		} else {
+			if (encrypted) {
+				tmp = is_write ?
+					copy_to_oldmem_page_encrypted(pfn, buf,
+								      nr_bytes,
+								      offset,
+								      userbuf) :
+					copy_oldmem_page_encrypted(pfn, buf,
+								   nr_bytes,
+								   offset,
+								   userbuf);
+			} else {
+				tmp = is_write ?
+					copy_to_oldmem_page(pfn, buf, nr_bytes,
+							    offset, userbuf) :
+					copy_oldmem_page(pfn, buf, nr_bytes,
+							offset, userbuf);
+			}
 
 			if (tmp < 0)
 				return tmp;
 		}
+
 		*ppos += nr_bytes;
 		buf += nr_bytes;
 		to_copy -= nr_bytes;
@@ -143,6 +156,22 @@ ssize_t read_from_oldmem(char *buf, size_t count,
 	return count;
 }
 
+/* Reads a page from the oldmem device from given offset. */
+ssize_t read_from_oldmem(char *buf, size_t count,
+			 u64 *ppos, int userbuf,
+			 bool encrypted)
+{
+	return oldmem_rw_page(buf, count, ppos, userbuf, encrypted, 0);
+}
+
+/* Writes a page to the oldmem device of given offset. */
+ssize_t write_to_oldmem(char *buf, size_t count,
+			u64 *ppos, int userbuf,
+			bool encrypted)
+{
+	return oldmem_rw_page(buf, count, ppos, userbuf, encrypted, 1);
+}
+
 /*
  * Architectures may override this function to allocate ELF header in 2nd kernel
  */
@@ -184,6 +213,26 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
 	return remap_pfn_range(vma, from, pfn, size, prot);
 }
 
+/*
+ * Architectures which support writing to oldmem overrides this.
+ */
+ssize_t __weak
+copy_to_oldmem_page(unsigned long pfn, char *buf, size_t csize,
+			   unsigned long offset, int userbuf)
+{
+	return -EOPNOTSUPP;
+}
+
+/*
+ * Architectures which support memory encryption override this.
+ */
+ssize_t __weak
+copy_to_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
+			   unsigned long offset, int userbuf)
+{
+	return copy_to_oldmem_page(pfn, buf, csize, offset, userbuf);
+}
+
 /*
  * Architectures which support memory encryption override this.
  */
@@ -394,6 +443,61 @@ static ssize_t read_vmcore(struct file *file, char __user *buffer,
 	return __read_vmcore((__force char *) buffer, buflen, fpos, 1);
 }
 
+/*
+ * Write to the old memory region, overriding ELF headers is not allowed.
+ * On error, negative value is returned otherwise number of bytes wrote
+ * are returned.
+ */
+static ssize_t __write_vmcore(char *buffer, size_t buflen, loff_t *fpos,
+			     int userbuf)
+{
+	ssize_t acc = 0, tmp;
+	size_t tsz;
+	u64 start;
+	struct vmcore *m = NULL;
+
+	if (buflen == 0 || *fpos >= vmcore_size)
+		return 0;
+
+	/* trim buflen to not go beyond EOF */
+	if (buflen > vmcore_size - *fpos)
+		buflen = vmcore_size - *fpos;
+
+	/* Deny writing to ELF headers */
+	if (*fpos < elfcorebuf_sz + elfnotes_sz)
+		return -EPERM;
+
+	list_for_each_entry(m, &vmcore_list, list) {
+		if (*fpos < m->offset + m->size) {
+			tsz = (size_t)min_t(unsigned long long,
+					    m->offset + m->size - *fpos,
+					    buflen);
+			start = m->paddr + *fpos - m->offset;
+			tmp = write_to_oldmem(buffer, tsz, &start,
+					      userbuf, mem_encrypt_active());
+			if (tmp < 0)
+				return tmp;
+			buflen -= tsz;
+			*fpos += tsz;
+			buffer += tsz;
+			acc += tsz;
+
+			/* leave now if filled buffer already */
+			if (buflen == 0)
+				return acc;
+		}
+	}
+
+	return acc;
+}
+
+
+static ssize_t write_vmcore(struct file *file, const char __user *buffer,
+			   size_t buflen, loff_t *fpos)
+{
+	return __write_vmcore((__force char *) buffer, buflen, fpos, 1);
+}
+
 /*
  * The vmcore fault handler uses the page cache and fills data using the
  * standard __vmcore_read() function.
@@ -662,6 +766,7 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 
 static const struct proc_ops vmcore_proc_ops = {
 	.proc_read	= read_vmcore,
+	.proc_write	= write_vmcore,
 	.proc_lseek	= default_llseek,
 	.proc_mmap	= mmap_vmcore,
 };
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index a5192b718dbe..8d8e75c08073 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -26,10 +26,15 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
 				  unsigned long size, pgprot_t prot);
 
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
-						unsigned long, int);
+				unsigned long, int);
 extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
 					  size_t csize, unsigned long offset,
 					  int userbuf);
+extern ssize_t copy_to_oldmem_page(unsigned long pfn, char *buf, size_t csize,
+				   unsigned long offset, int userbuf);
+extern ssize_t copy_to_oldmem_page_encrypted(unsigned long pfn, char *buf,
+					     size_t csize, unsigned long offset,
+					     int userbuf);
 
 void vmcore_cleanup(void);
 
@@ -119,10 +124,15 @@ static inline int vmcore_add_device_dump(struct vmcoredd_data *data)
 ssize_t read_from_oldmem(char *buf, size_t count,
 			 u64 *ppos, int userbuf,
 			 bool encrypted);
+ssize_t write_to_oldmem(char *buf, size_t count,
+			u64 *ppos, int userbuf,
+			bool encrypted);
 #else
-static inline ssize_t read_from_oldmem(char *buf, size_t count,
-				       u64 *ppos, int userbuf,
-				       bool encrypted)
+static inline ssize_t read_from_oldmem(char*, size_t, u64*, int, bool)
+{
+	return -EOPNOTSUPP;
+}
+static inline ssize_t write_to_oldmem(char*, size_t, u64*, int, bool);
 {
 	return -EOPNOTSUPP;
 }
-- 
2.26.2

