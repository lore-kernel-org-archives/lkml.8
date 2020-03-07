Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4124C10F26
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 20:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9F32075A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 20:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583614774;
	bh=5d3Oip03/coW7PPRWqkmaJXd6+0g1van/+FSAiBvGgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lgKVgW2WZ30h9CqXSBk66fzlTu+O3SgEaJdAXfIulWbLhYjZQF/D9yjeJ7bennJyA
	 /ZZyG4KvXEPCTGV3Mbbgjw09X55nHQVxBmp2/3U+nLLk4J1rKogP6v+3o9NP9G1+Lf
	 kBO8N0fsvAB+jqhr440sr9Jzu71k9GhFrJVHqM4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgCGU7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 15:59:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgCGU7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 15:59:32 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4EB520684;
        Sat,  7 Mar 2020 20:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583614772;
        bh=5d3Oip03/coW7PPRWqkmaJXd6+0g1van/+FSAiBvGgU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jwr3HrLwzhKeT1MNi4405W6ajHbQO1VkY6Hk8xqcmkAHCUUTMLmGUOO9cBD/9VcaP
         T5GSMRBEwfhRT37kVexan1Hr03ly009hYQpDC+tclYYfTPuMhnv7GVTY4SnyBO18Nr
         MJhvsJh5fS8BxPbbutzrFtaF76hYYfcE5457ZAag=
Date:   Sat, 7 Mar 2020 12:59:31 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        david@redhat.com, richardw.yang@linux.intel.com,
        dan.j.williams@intel.com, osalvador@suse.de, rppt@linux.ibm.com
Subject: Re: [PATCH v3 1/7] mm/hotplug: fix hot remove failure in
 SPARSEMEM|!VMEMMAP case
Message-Id: <20200307125931.8e75709181f5c4bda40b1ee5@linux-foundation.org>
In-Reply-To: <20200307084229.28251-2-bhe@redhat.com>
References: <20200307084229.28251-1-bhe@redhat.com>
        <20200307084229.28251-2-bhe@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  7 Mar 2020 16:42:23 +0800 Baoquan He <bhe@redhat.com> wrote:

> In section_deactivate(), pfn_to_page() doesn't work any more after
> ms->section_mem_map is resetting to NULL in SPARSEMEM|!VMEMMAP case.
> It caused hot remove failure:
> 
> kernel BUG at mm/page_alloc.c:4806!
> invalid opcode: 0000 [#1] SMP PTI
> CPU: 3 PID: 8 Comm: kworker/u16:0 Tainted: G        W         5.5.0-next-20200205+ #340
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> RIP: 0010:free_pages+0x85/0xa0
> Call Trace:
>  __remove_pages+0x99/0xc0
>  arch_remove_memory+0x23/0x4d
>  try_remove_memory+0xc8/0x130
>  ? walk_memory_blocks+0x72/0xa0
>  __remove_memory+0xa/0x11
>  acpi_memory_device_remove+0x72/0x100
>  acpi_bus_trim+0x55/0x90
>  acpi_device_hotplug+0x2eb/0x3d0
>  acpi_hotplug_work_fn+0x1a/0x30
>  process_one_work+0x1a7/0x370
>  worker_thread+0x30/0x380
>  ? flush_rcu_work+0x30/0x30
>  kthread+0x112/0x130
>  ? kthread_create_on_node+0x60/0x60
>  ret_from_fork+0x35/0x40
> 
> Let's move the ->section_mem_map resetting after depopulate_section_memmap()
> to fix it.

Thanks.  I think I'll cherrypick this fix and shall await more
review/testing input on the rest of the series.

