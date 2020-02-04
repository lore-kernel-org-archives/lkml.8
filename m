Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5020C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 05:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9695620674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 05:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqZW+ocT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgBDFGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 00:06:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57352 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725813AbgBDFGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 00:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580792813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=77aFIeWZ6g7NaVIYQN/nFVqyjpYjPXX41AYEjCL1ybk=;
        b=UqZW+ocT+PP250dlPN2qn6Z999XrJ7EWRNztRG6qEeNyxr4NCy75IykIi/btTfvlqCtG8D
        wuK2ai8au6nO+FN/+eRH2LyZNI8wOZwywzYxkcZa4Kap8tnmmhic2tUPIMY4KPDk68yhJ9
        dBYzpAo6WWD1+T2njVnwF6Z9CLIPNN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-4xlkwQ1bMKSfm9fi0BiRng-1; Tue, 04 Feb 2020 00:06:51 -0500
X-MC-Unique: 4xlkwQ1bMKSfm9fi0BiRng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3ABE48018A3;
        Tue,  4 Feb 2020 05:06:50 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-129.pek2.redhat.com [10.72.13.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D8F38E9E5;
        Tue,  4 Feb 2020 05:06:44 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        david@redhat.com, jgross@suse.com, bsingharora@gmail.com
Subject: [PATCH v3] mm/hotplug: Only respect mem= parameter during boot stage
Date:   Tue,  4 Feb 2020 13:06:43 +0800
Message-Id: <20200204050643.20925-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 357b4da50a62 ("x86: respect memory size limiting via mem=
parameter") a global varialbe max_mem_size is added to store
the value parsed from 'mem= ', then checked when memory region is
added. This truly stops those DIMMs from being added into system memory
during boot-time.

However, it also limits the later memory hotplug functionality. Any
DIMM can't be hotplugged any more if its region is beyond the
max_mem_size. We will get errors like:

[  216.387164] acpi PNP0C80:02: add_memory failed
[  216.389301] acpi PNP0C80:02: acpi_memory_enable_device() error
[  216.392187] acpi PNP0C80:02: Enumeration failure

This will cause issue in a known use case where 'mem=' is added to
the hypervisor. The memory that lies after 'mem=' boundary will be
assigned to KVM guests. After commit 357b4da50a62 merged, memory
can't be extended dynamically if system memory on hypervisor is not
sufficient.

So fix it by also checking if it's during boot-time restricting to add
memory. Otherwise, skip the restriction.

And also add this use case to document of 'mem=' kernel parameter.

Fixes: 357b4da50a62 ("x86: respect memory size limiting via mem= parameter")
Signed-off-by: Baoquan He <bhe@redhat.com>
---
v2->v3:
  In discussion of v1 and v2, People have concern about the use case
  related to the code change. So add the use case into patch log and
  document of 'mem=' in kernel-parameters.txt.

 Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++--
 mm/memory_hotplug.c                             |  8 +++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ddc5ccdd4cd1..b809767e5f74 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2533,13 +2533,22 @@
 			For details see: Documentation/admin-guide/hw-vuln/mds.rst
 
 	mem=nn[KMG]	[KNL,BOOT] Force usage of a specific amount of memory
-			Amount of memory to be used when the kernel is not able
-			to see the whole system memory or for test.
+			Amount of memory to be used in cases as follows:
+
+			1 for test;
+			2 when the kernel is not able to see the whole system memory;
+			3 memory that lies after 'mem=' boundary is excluded from
+			 the hypervisor, then assigned to KVM guests.
+
 			[X86] Work as limiting max address. Use together
 			with memmap= to avoid physical address space collisions.
 			Without memmap= PCI devices could be placed at addresses
 			belonging to unused RAM.
 
+			Note that this only takes effects during boot time since
+			in above case 3, memory may need be hot added after boot
+			if system memory of hypervisor is not sufficient.
+
 	mem=nopentium	[BUGS=X86-32] Disable usage of 4MB pages for kernel
 			memory.
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 36d80915ddc2..e6c75ceacf9a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -105,7 +105,13 @@ static struct resource *register_memory_resource(u64 start, u64 size)
 	unsigned long flags =  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 	char *resource_name = "System RAM";
 
-	if (start + size > max_mem_size)
+	/*
+	 * Make sure value parsed from 'mem=' only restricts memory adding
+	 * while booting, so that memory hotplug won't be impacted. Please
+	 * refer to document of 'mem=' in kernel-parameters.txt for more
+	 * details.
+	 */
+	if (start + size > max_mem_size && system_state < SYSTEM_RUNNING)
 		return ERR_PTR(-E2BIG);
 
 	/*
-- 
2.17.2

