Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD687C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED462068D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRrEiBHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgIIHur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:50:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20103 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729521AbgIIHun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599637841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vGyOk6KkR/XxaRsF4tGcmjHK4z5GfNfxYjweN6SPha8=;
        b=CRrEiBHtjnnBituzz/X30XKnd9dpFJsd3KnxlafCSauWP78MOph9YOwB8AzE8LCCb4YZ3W
        L8p0BIZ7mmgeKJJEbK8SnCV5t7k4RJX+r1tfih82Iz4Uk3+iwCCmQ8RQycaYZ+UvjDkjAM
        mnVTk9f9goWQswHY64zWHvUefBhLbLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-0g7HX4qqMzmHTgYqZXGsLw-1; Wed, 09 Sep 2020 03:50:38 -0400
X-MC-Unique: 0g7HX4qqMzmHTgYqZXGsLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7E74800597;
        Wed,  9 Sep 2020 07:50:36 +0000 (UTC)
Received: from kasong-rh-laptop.redhat.com (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 152BA100238C;
        Wed,  9 Sep 2020 07:50:27 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>
Subject: [RFC PATCH 0/3] Add writing support to vmcore for reusing oldmem
Date:   Wed,  9 Sep 2020 15:50:13 +0800
Message-Id: <20200909075016.104407-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently vmcore only supports reading, this patch series is an RFC
to add writing support to vmcore. It's x86_64 only yet, I'll add other
architecture later if there is no problem with this idea.

My purpose of adding writing support is to reuse the crashed kernel's
old memory in kdump kernel, reduce kdump memory pressure, and
allow kdump to run with a smaller crashkernel reservation.

This is doable because in most cases, after kernel panic, user only
interested in the crashed kernel itself, and userspace/cache/free
memory pages are not dumped. `makedumpfile` is widely used to skip
these pages. Kernel pages usually only take a small part of
the whole old memory. So there will be many reusable pages.

By adding writing support, userspace then can use these pages as a fast
and temporary storage. This helps reduce memory pressure in many ways.

For example, I've written a POC program based on this, it will find
the reusable pages, and creates an NBD device which maps to these pages.
The NBD device can then be used as swap, or to hold some temp files
which previouly live in RAM.

The link of the POC tool: https://github.com/ryncsn/kdumpd

I tested it on x86_64 on latest Fedora by using it as swap with
following step in kdump kernel:

  1. Install this tool in kdump initramfs
  2. Execute following command in kdump:
     /sbin/modprobe nbd nbds_max=1
     /bin/kdumpd &
     /sbin/mkswap /dev/nbd0
     /sbin/swapon /dev/nbd0
  3. Observe the swap is being used:
     SwapTotal:        131068 kB
     SwapFree:         121852 kB

It helped to reduce the crashkernel from 168M to 110M for a successful
kdump run over NFSv3. There are still many workitems that could be done
based on this idea, eg. move the initramfs content to the old memory,
which may help reduce another ~10-20M of memory.

It's have been a long time issue that kdump suffers from OOM issue
with limited crashkernel memory. So reusing old memory could be very
helpful.

This method have it's limitation:
- Swap only works for userspace. But kdump userspace is a major memory
  consumer, so in general this should be helpful enough.
- For users who want to dump the whole memory area, this won't help as
  there is no reusable page.

I've tried other ways to improve the crashkernel value, eg.
- Reserve some smaller memory segments in first kernel for crashkernel: It's
  only a suppliment of the default crashkernel reservation and only make
  crashkernel value more adjustable, still not solving the real problem.

- Reuse old memory, but hotplug chunk of reusable old memory into
  kdump kernel's memory:
  It's hard to find large chunk of continuous memory, especially on
  systems with heavy workload, the reusable regions could be very
  fragmental. So it can only hotplug small fragments of memories,
  which looks hackish, and may have a high page table overhead.

- Implement the old memory based based block device as a kernel
  module. It doesn't looks good to have a module for this sole
  usage and it don't have much performance/implementation advantage
  compared to this RFC.

Besides, keeping all the complex logic of parsing reusing old memory
logic in userspace seems a better idea.

And as a plus, this could make it more doable and reasonable to
have n crashkernel=auto param. If there is a swap, then userspace
will have less memory pressure. crashkernel=auto can focus on the
kernel usage.

Kairui Song (3):
  vmcore: simplify read_from_olemem
  vmcore: Add interface to write to old mem
  x86_64: implement copy_to_oldmem_page

 arch/x86/kernel/crash_dump_64.c |  49 ++++++++--
 fs/proc/vmcore.c                | 154 ++++++++++++++++++++++++++------
 include/linux/crash_dump.h      |  18 +++-
 3 files changed, 180 insertions(+), 41 deletions(-)

-- 
2.26.2

