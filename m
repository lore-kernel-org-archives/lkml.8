Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC405C38A2D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE28720857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnZCObWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgDQPCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:02:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60752 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728296AbgDQPCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587135725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TW9GKMvgpVoGQAKpbRkZDaLCYXUQd5fcsEo9OJKKyeU=;
        b=fnZCObWNyvyiGtHg3PIgZC9u63sIVl66ZL979/XLeWhXcKgwgDxNOYwJ8fDiWZdu77Ml21
        Lwig2H2cD0Rd77MjDUhiuYPV4aJL6M1HfAl67EedWjnzDFG6loNjsDQ1uyQDA0gbSDueFQ
        2JpU9doDH18xlPEDxPi6X72H0zMjoZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-AaD_PUg0OJqBlHU0pUVQ0A-1; Fri, 17 Apr 2020 11:02:01 -0400
X-MC-Unique: AaD_PUg0OJqBlHU0pUVQ0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 100748018A1;
        Fri, 17 Apr 2020 15:02:00 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-107.ams2.redhat.com [10.36.114.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F16AE9F9B5;
        Fri, 17 Apr 2020 15:01:57 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Kirill Smelkov <kirr@nexedi.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH RFC 1/2] s390/zcore: traverse resources instead of memblocks
Date:   Fri, 17 Apr 2020 17:01:50 +0200
Message-Id: <20200417150151.17239-2-david@redhat.com>
In-Reply-To: <20200417150151.17239-1-david@redhat.com>
References: <20200417150151.17239-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zcore memmap basically contains the first level of all system RAM fro=
m
/proc/iomem. We want to disable CONFIG_ARCH_KEEP_MEMBLOCK (e.g., to not
create memblocks for hotplugged/standby memory and save space), switch to
traversing system ram resources instead. During early boot, we create
resources for all early memblocks (including the crash kernel area). When
adding standby memory, we currently create both, memblocks and resources.

Note: As we don't have memory hotplug after boot (standby memory is added
via sclp during boot), we don't have to worry about races.

I am only able to test under KVM (where I hacked up zcore to still
create the memmap file)

root@vm0:~# cat /proc/iomem
00000000-2fffffff : System RAM
  10424000-10ec6fff : Kernel code
  10ec7000-1139a0e3 : Kernel data
  1177a000-11850fff : Kernel bss
30000000-3fffffff : Crash kernel

Result without this patch:
root@vm0:~# cat /sys/kernel/debug/zcore/memmap
0000000000000000 0000000040000000

Result with this patch:
root@vm0:~# cat /sys/kernel/debug/zcore/memmap
0000000000000000 0000000030000000 0000000030000000 0000000010000000

The difference is due to memblocks getting merged, resources (currently)
not. So we might have some more entries, but they describe the same
memory map.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: Kirill Smelkov <kirr@nexedi.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/s390/char/zcore.c | 61 ++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index 08f812475f5e..c40ac7d548d8 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -16,7 +16,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/debugfs.h>
-#include <linux/memblock.h>
+#include <linux/ioport.h>
=20
 #include <asm/asm-offsets.h>
 #include <asm/ipl.h>
@@ -139,35 +139,70 @@ static void release_hsa(void)
 	hsa_available =3D 0;
 }
=20
+struct zcore_memmap_info {
+	char *buf;
+	size_t length;
+};
+
 static ssize_t zcore_memmap_read(struct file *filp, char __user *buf,
 				 size_t count, loff_t *ppos)
 {
-	return simple_read_from_buffer(buf, count, ppos, filp->private_data,
-				       memblock.memory.cnt * CHUNK_INFO_SIZE);
+	struct zcore_memmap_info *info =3D filp->private_data;
+
+	return simple_read_from_buffer(buf, count, ppos, info->buf,
+				       info->length);
+}
+
+static int zcore_count_ram_resource(struct resource *res, void *arg)
+{
+	size_t *count =3D arg;
+
+	*count +=3D 1;
+	return 0;
+}
+
+static int zcore_process_ram_resource(struct resource *res, void *arg)
+{
+	char **buf =3D arg;
+
+	sprintf(*buf, "%016lx %016lx ", (unsigned long) res->start,
+		(unsigned long) resource_size(res));
+
+	*buf +=3D CHUNK_INFO_SIZE;
+	return 0;
 }
=20
 static int zcore_memmap_open(struct inode *inode, struct file *filp)
 {
-	struct memblock_region *reg;
+	struct zcore_memmap_info *info;
+	size_t count =3D 0;
 	char *buf;
-	int i =3D 0;
=20
-	buf =3D kcalloc(memblock.memory.cnt, CHUNK_INFO_SIZE, GFP_KERNEL);
+	walk_system_ram_res(0, ULONG_MAX, &count, zcore_count_ram_resource);
+
+	info =3D kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	buf =3D kcalloc(count, CHUNK_INFO_SIZE, GFP_KERNEL);
 	if (!buf) {
+		kfree(info);
 		return -ENOMEM;
 	}
-	for_each_memblock(memory, reg) {
-		sprintf(buf + (i++ * CHUNK_INFO_SIZE), "%016llx %016llx ",
-			(unsigned long long) reg->base,
-			(unsigned long long) reg->size);
-	}
-	filp->private_data =3D buf;
+	info->length =3D count * CHUNK_INFO_SIZE;
+	info->buf =3D buf;
+
+	walk_system_ram_res(0, ULONG_MAX, &buf, zcore_process_ram_resource);
+
+	filp->private_data =3D info;
 	return nonseekable_open(inode, filp);
 }
=20
 static int zcore_memmap_release(struct inode *inode, struct file *filp)
 {
-	kfree(filp->private_data);
+	struct zcore_memmap_info *info =3D filp->private_data;
+
+	kfree(info->buf);
+	kfree(info);
 	return 0;
 }
=20
--=20
2.25.1

