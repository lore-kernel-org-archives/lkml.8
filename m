Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB65CC10F27
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 23:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840692075E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 23:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ul6nKurM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgCGWzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 17:55:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50029 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726138AbgCGWzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 17:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583621740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+rNcJxrVWwYcvfrtJi72ELJuI7ojNOfm3cddFv7e+dQ=;
        b=Ul6nKurMi9IlyalxVpsqiyvjttNNRN+9cU7YeZuBcsc5f8Csh5XEVsuciq64x+PJribIbc
        W2vIEldXsELAyQ7UZgCTsRCyhpZCFf+015IhD8J2xOtlKHPt0b9FNIAt7XTbdYtdF0zsGp
        wHvDdplguxHrUxRSv1tkQpMBxN9HlUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-DtkrUQVTPsmsn-r1jFnqeg-1; Sat, 07 Mar 2020 17:55:38 -0500
X-MC-Unique: DtkrUQVTPsmsn-r1jFnqeg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE95D477;
        Sat,  7 Mar 2020 22:55:36 +0000 (UTC)
Received: from localhost (ovpn-12-26.pek2.redhat.com [10.72.12.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28CD146;
        Sat,  7 Mar 2020 22:55:32 +0000 (UTC)
Date:   Sun, 8 Mar 2020 06:55:30 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        david@redhat.com, richardw.yang@linux.intel.com,
        dan.j.williams@intel.com, osalvador@suse.de, rppt@linux.ibm.com
Subject: Re: [PATCH v3 1/7] mm/hotplug: fix hot remove failure in
 SPARSEMEM|!VMEMMAP case
Message-ID: <20200307225530.GC27711@MiWiFi-R3L-srv>
References: <20200307084229.28251-1-bhe@redhat.com>
 <20200307084229.28251-2-bhe@redhat.com>
 <20200307125931.8e75709181f5c4bda40b1ee5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307125931.8e75709181f5c4bda40b1ee5@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/20 at 12:59pm, Andrew Morton wrote:
> On Sat,  7 Mar 2020 16:42:23 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > In section_deactivate(), pfn_to_page() doesn't work any more after
> > ms->section_mem_map is resetting to NULL in SPARSEMEM|!VMEMMAP case.
> > It caused hot remove failure:
> > 
> > kernel BUG at mm/page_alloc.c:4806!
> > invalid opcode: 0000 [#1] SMP PTI
> > CPU: 3 PID: 8 Comm: kworker/u16:0 Tainted: G        W         5.5.0-next-20200205+ #340
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> > Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> > RIP: 0010:free_pages+0x85/0xa0
> > Call Trace:
> >  __remove_pages+0x99/0xc0
> >  arch_remove_memory+0x23/0x4d
> >  try_remove_memory+0xc8/0x130
> >  ? walk_memory_blocks+0x72/0xa0
> >  __remove_memory+0xa/0x11
> >  acpi_memory_device_remove+0x72/0x100
> >  acpi_bus_trim+0x55/0x90
> >  acpi_device_hotplug+0x2eb/0x3d0
> >  acpi_hotplug_work_fn+0x1a/0x30
> >  process_one_work+0x1a7/0x370
> >  worker_thread+0x30/0x380
> >  ? flush_rcu_work+0x30/0x30
> >  kthread+0x112/0x130
> >  ? kthread_create_on_node+0x60/0x60
> >  ret_from_fork+0x35/0x40
> > 
> > Let's move the ->section_mem_map resetting after depopulate_section_memmap()
> > to fix it.
> 
> Thanks.  I think I'll cherrypick this fix and shall await more
> review/testing input on the rest of the series.

Sure, thanks.

