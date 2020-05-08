Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D884CC54E4B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D43208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsuS/KY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgEHImg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:42:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29089 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726690AbgEHImg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588927354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ouBt4BfusFaa/lv0LTRbmOSgoxSr9cZTrvcQPivP5Jg=;
        b=WsuS/KY5MMKBiOajQSSbkj9bRrxJbryD/IUVamXAAM1FW9GRjkt6zwdHytSI6393QsmMZ7
        dOvROlUlWGq/6vhN6K82AKq+i2rMUd7RUQsZd0093B8Au+4j2pkEb5Shs4f9RteYqqxNAF
        pICuz/HQ3oaSnfgn+rOhRR02eNpR7z0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-l6nWo52fN4uNSj25Te985g-1; Fri, 08 May 2020 04:42:30 -0400
X-MC-Unique: l6nWo52fN4uNSj25Te985g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3D84461;
        Fri,  8 May 2020 08:42:28 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-181.ams2.redhat.com [10.36.113.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8F425C1B0;
        Fri,  8 May 2020 08:42:22 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        kexec@lists.infradead.org, Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Michal Hocko <mhocko@suse.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v4 0/4] mm/memory_hotplug: Interface to add driver-managed system ram
Date:   Fri,  8 May 2020 10:42:13 +0200
Message-Id: <20200508084217.9160-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I did some more testing to v3 and found issues with unloading the kmem
module, followed by reconfiguring the namespace.

kexec (via kexec_load()) can currently not properly handle memory added via
dax/kmem, and will have similar issues with virtio-mem. kexec-tools will
currently add all memory to the fixed-up initial firmware memmap. In case
of dax/kmem, this means that - in contrast to a proper reboot - how that
persistent memory will be used can no longer be configured by the kexec'd
kernel. In case of virtio-mem it will be harmful, because that memory
might contain inaccessible pieces that require coordination with hypervisor
first.

In both cases, we want to let the driver in the kexec'd kernel handle
detecting and adding the memory, like during an ordinary reboot.
Introduce add_memory_driver_managed(). More on the samentics are in patch
#1.

In the future, we might want to make this behavior configurable for
dax/kmem- either by configuring it in the kernel (which would then also
allow to configure kexec_file_load()) or in kexec-tools by also adding
"System RAM (kmem)" memory from /proc/iomem to the fixed-up initial
firmware memmap.

More on the motivation can be found in [1] and [2].

v3 -> v4:
- "device-dax: Don't leak kernel memory to user space after unloading kmem"
-- Added
- "device-dax: Add memory via add_memory_driver_managed()"
-- kstrdup_const() the resource name to be used for added memory
-- Remember if any hotremove failed / we still have memory added to the
   system and conditionally kfree_const().

v2 -> v3:
- Don't use flags for add_memory() and friends, provide
  add_memory_driver_managed() instead.
- Flag memory resources via IORESOURCE_MEM_DRIVER_MANAGED and handle them
  in kexec.
- Name memory resources "System RAM ($DRIVER)", visible via /proc/iomem
- Added more details to the patch descriptions, especially regarding the
  history of /sys/firmware/memmap
- Add a comment to the device-dax change. Dropped Dave's Ack as the

v1 -> v2:
- Don't change the resource name
- Rename the flag to MHP_NO_FIRMWARE_MEMMAP to reflect what it is doing
- Rephrase subjects/descriptions
- Use the flag for dax/kmem

[1] https://lkml.kernel.org/r/20200429160803.109056-1-david@redhat.com
[2] https://lkml.kernel.org/r/20200430102908.10107-1-david@redhat.com


David Hildenbrand (4):
  device-dax: Don't leak kernel memory to user space after unloading
    kmem
  mm/memory_hotplug: Introduce add_memory_driver_managed()
  kexec_file: Don't place kexec images on IORESOURCE_MEM_DRIVER_MANAGED
  device-dax: Add memory via add_memory_driver_managed()

 drivers/dax/dax-private.h      |  1 +
 drivers/dax/kmem.c             | 42 ++++++++++++++++++++---
 include/linux/ioport.h         |  1 +
 include/linux/memory_hotplug.h |  2 ++
 kernel/kexec_file.c            |  5 +++
 mm/memory_hotplug.c            | 62 +++++++++++++++++++++++++++++++---
 6 files changed, 104 insertions(+), 9 deletions(-)

-- 
2.25.4

