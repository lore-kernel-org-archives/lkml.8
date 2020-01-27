Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_QP_LONG_LINE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F530C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 07:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F6A21569
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 07:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUq9GFGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgA0Hod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 02:44:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27157 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725840AbgA0Hoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 02:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580111069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cgk5ltniD4pUWE/ugun0lf7eSPOqqhrokXvK949N91A=;
        b=jUq9GFGbOl9r2g957mnbpHIjT65gyUoap0fOSPh4Xxr7hzxT/eveWJ83hecMImPofG3wYb
        pF9tQJCTgfo0z2pe+pyBi3EbSXChAbiCBV4JGDzynv78r1807Qk2X3uQyBgA2LQmKurrM0
        2w1bJm/C8p8xxAutrZkPtwv0gSo0Z0Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-sM8yNzdJMA-PArNXpQOrpQ-1; Mon, 27 Jan 2020 02:44:28 -0500
X-MC-Unique: sM8yNzdJMA-PArNXpQOrpQ-1
Received: by mail-wr1-f72.google.com with SMTP id y7so5707385wrm.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 23:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Cgk5ltniD4pUWE/ugun0lf7eSPOqqhrokXvK949N91A=;
        b=rovWbTGhRSe5rQD1HWVNH5llbicCehHSh4dwoKkvKD1KGMCaLqyb1AhOI350x9pA2/
         bzgIBukx6s3lCIgKw76iX+qc+A4AbNknbdXa6C0U3Zk/rPC8tGj0RNwJycTY6plh2W+x
         2k95K94pvKBgVsP1fcqagYKt7ToejIYtJ1q0bU7HLYnmQh46fHDZraxcz1yybn8ZlB3c
         2PiW8jLuyWWGlgqYhROBIWNpv+WN9c1g06H0Q8+KdjbCF1DJSQusKZDfHsstZ+zwOz2D
         g7o8C8WbhaKlk++GnNWwA/Zw//NllCosuVMeJdqoJvywfTBc3jSM1t7oF0GrzeDClNda
         rZBg==
X-Gm-Message-State: APjAAAUbMwOew29z2m5rTG4il6OwI/koiHNSsLVuEnyGrd4DGc3Sh2Fr
        uVFUGn0jCmzYQqAO6ESVBlsGAYDM4+1vgVevWxLZuXJ4wW+xqjbPKHixi4tgsFkzwOGhgBRyyE7
        2xXBT2ZO8YfLVZOEI6r37HvW0
X-Received: by 2002:a1c:740b:: with SMTP id p11mr12687065wmc.78.1580111066671;
        Sun, 26 Jan 2020 23:44:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1ocqBD3vn89nb20n5UxszMK3570ERwKk9HGnb+QVXZOYpPK/eplHhDdxsbuKdcG5LuZQ7Zg==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr12687040wmc.78.1580111066401;
        Sun, 26 Jan 2020 23:44:26 -0800 (PST)
Received: from [10.221.9.52] ([88.128.92.76])
        by smtp.gmail.com with ESMTPSA id d12sm19402535wrp.62.2020.01.26.23.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2020 23:44:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5] mm/memory_hotplug: Fix remove_memory() lockdep splat
Date:   Mon, 27 Jan 2020 08:44:19 +0100
Message-Id: <A62F4627-8172-4DB6-A9C5-18B9B441E020@redhat.com>
References: <157991441887.2763922.4770790047389427325.stgit@dwillia2-desk3.amr.corp.intel.com>
Cc:     akpm@linux-foundation.org, Vishal Verma <vishal.l.verma@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <157991441887.2763922.4770790047389427325.stgit@dwillia2-desk3.amr.corp.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 25.01.2020 um 02:23 schrieb Dan Williams <dan.j.williams@intel.com>:
>=20
> =EF=BB=BFThe daxctl unit test for the dax_kmem driver currently triggers t=
he
> (false positive) lockdep splat below. It results from the fact that
> remove_memory_block_devices() is invoked under the mem_hotplug_lock()
> causing lockdep entanglements with cpu_hotplug_lock() and sysfs (kernfs
> active state tracking). It is a false positive because the sysfs
> attribute path triggering the memory remove is not the same attribute
> path associated with memory-block device.
>=20
> sysfs_break_active_protection() is not applicable since there is no real
> deadlock conflict, instead move memory-block device removal outside the
> lock. The mem_hotplug_lock() is not needed to synchronize the
> memory-block device removal vs the page online state, that is already
> handled by lock_device_hotplug(). Specifically, lock_device_hotplug() is
> sufficient to allow try_remove_memory() to check the offline state of
> the memblocks and be assured that any in progress online attempts are
> flushed / blocked by kernfs_drain() / attribute removal.
>=20
> The add_memory() path safely creates memblock devices under the
> mem_hotplug_lock(). There is no kernfs active state synchronization in
> the memblock device_register() path, so nothing to fix there.
>=20
> This change is only possible thanks to the recent change that refactored
> memory block device removal out of arch_remove_memory() (commit
> 4c4b7f9ba948 mm/memory_hotplug: remove memory block devices before
> arch_remove_memory()), and David's due diligence tracking down the
> guarantees afforded by kernfs_drain(). Not flagged for -stable since
> this only impacts ongoing development and lockdep validation, not a
> runtime issue.
>=20
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>    WARNING: possible circular locking dependency detected
>    5.5.0-rc3+ #230 Tainted: G           OE
>    ------------------------------------------------------
>    lt-daxctl/6459 is trying to acquire lock:
>    ffff99c7f0003510 (kn->count#241){++++}, at: kernfs_remove_by_name_ns+0x=
41/0x80
>=20
>    but task is already holding lock:
>    ffffffffa76a5450 (mem_hotplug_lock.rw_sem){++++}, at: percpu_down_write=
+0x20/0xe0
>=20
>    which lock already depends on the new lock.
>=20
>=20
>    the existing dependency chain (in reverse order) is:
>=20
>    -> #2 (mem_hotplug_lock.rw_sem){++++}:
>           __lock_acquire+0x39c/0x790
>           lock_acquire+0xa2/0x1b0
>           get_online_mems+0x3e/0xb0
>           kmem_cache_create_usercopy+0x2e/0x260
>           kmem_cache_create+0x12/0x20
>           ptlock_cache_init+0x20/0x28
>           start_kernel+0x243/0x547
>           secondary_startup_64+0xb6/0xc0
>=20
>    -> #1 (cpu_hotplug_lock.rw_sem){++++}:
>           __lock_acquire+0x39c/0x790
>           lock_acquire+0xa2/0x1b0
>           cpus_read_lock+0x3e/0xb0
>           online_pages+0x37/0x300
>           memory_subsys_online+0x17d/0x1c0
>           device_online+0x60/0x80
>           state_store+0x65/0xd0
>           kernfs_fop_write+0xcf/0x1c0
>           vfs_write+0xdb/0x1d0
>           ksys_write+0x65/0xe0
>           do_syscall_64+0x5c/0xa0
>           entry_SYSCALL_64_after_hwframe+0x49/0xbe
>=20
>    -> #0 (kn->count#241){++++}:
>           check_prev_add+0x98/0xa40
>           validate_chain+0x576/0x860
>           __lock_acquire+0x39c/0x790
>           lock_acquire+0xa2/0x1b0
>           __kernfs_remove+0x25f/0x2e0
>           kernfs_remove_by_name_ns+0x41/0x80
>           remove_files.isra.0+0x30/0x70
>           sysfs_remove_group+0x3d/0x80
>           sysfs_remove_groups+0x29/0x40
>           device_remove_attrs+0x39/0x70
>           device_del+0x16a/0x3f0
>           device_unregister+0x16/0x60
>           remove_memory_block_devices+0x82/0xb0
>           try_remove_memory+0xb5/0x130
>           remove_memory+0x26/0x40
>           dev_dax_kmem_remove+0x44/0x6a [kmem]
>           device_release_driver_internal+0xe4/0x1c0
>           unbind_store+0xef/0x120
>           kernfs_fop_write+0xcf/0x1c0
>           vfs_write+0xdb/0x1d0
>           ksys_write+0x65/0xe0
>           do_syscall_64+0x5c/0xa0
>           entry_SYSCALL_64_after_hwframe+0x49/0xbe
>=20
>    other info that might help us debug this:
>=20
>    Chain exists of:
>      kn->count#241 --> cpu_hotplug_lock.rw_sem --> mem_hotplug_lock.rw_sem=

>=20
>     Possible unsafe locking scenario:
>=20
>           CPU0                    CPU1
>           ----                    ----
>      lock(mem_hotplug_lock.rw_sem);
>                                   lock(cpu_hotplug_lock.rw_sem);
>                                   lock(mem_hotplug_lock.rw_sem);
>      lock(kn->count#241);
>=20
>     *** DEADLOCK ***
>=20
> No fixes tag as this has been a long standing issue that predated the
> addition of kernfs lockdep annotations.
>=20
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes since v4 [1]:
> - Drop the unnecessary consideration of mem->section_count.
>  kernfs_drain() + lock_device_hotplug() is sufficient protection
>  (David)
>=20
> [1]: http://lore.kernel.org/r/157869128062.2451572.4093315441083744888.stg=
it@dwillia2-desk3.amr.corp.intel.com
>=20
> mm/memory_hotplug.c |    9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 55ac23ef11c1..65ddaf3a2a12 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1763,8 +1763,6 @@ static int __ref try_remove_memory(int nid, u64 star=
t, u64 size)
>=20
>    BUG_ON(check_hotplug_memory_range(start, size));
>=20
> -    mem_hotplug_begin();
> -
>    /*
>     * All memory blocks must be offlined before removing memory.  Check
>     * whether all memory blocks in question are offline and return error
> @@ -1777,9 +1775,14 @@ static int __ref try_remove_memory(int nid, u64 sta=
rt, u64 size)
>    /* remove memmap entry */
>    firmware_map_remove(start, start + size, "System RAM");
>=20
> -    /* remove memory block devices before removing memory */
> +    /*
> +     * Memory block device removal under the device_hotplug_lock is
> +     * a barrier against racing online attempts.
> +     */
>    remove_memory_block_devices(start, size);
>=20
> +    mem_hotplug_begin();
> +
>    arch_remove_memory(nid, start, size, NULL);
>    memblock_free(start, size);
>    memblock_remove(start, size);
>=20
>=20

Thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>=

