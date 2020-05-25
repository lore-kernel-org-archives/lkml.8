Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59615C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3857720723
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyUplGI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389764AbgEYKbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:31:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37155 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389373AbgEYKbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590402658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Tjh+ltjJrGCNlnFU+WVmr7LcnYdZcqi33gjE65+/QHI=;
        b=TyUplGI8c2ZP5h66rD62WcIHOW+kleU1/MP1bBsmvxgtf5RwECGsyKiZtX8t5G/ARCT2UZ
        /m+dd5XgFuPO5V9ObveMZiUzbwUxDUQZFeoXYewrQd3sJ5cputqpRr22ynEDJ+XUCvzlEs
        gFqSYMZd+uIV6+EV3wCvIeoZPkFNSOA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169--Oede7yyPZCuFjZcwIraWw-1; Mon, 25 May 2020 06:30:56 -0400
X-MC-Unique: -Oede7yyPZCuFjZcwIraWw-1
Received: by mail-wm1-f71.google.com with SMTP id g84so233428wmf.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 03:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Tjh+ltjJrGCNlnFU+WVmr7LcnYdZcqi33gjE65+/QHI=;
        b=lIk1Y+9Wt/yngiZc0rcYC4ga6cUoJxFyeJSSERse6Y9K1/TFUfdb3uji1jQtD7vAwu
         kEaSVVdrUU8f0yJ/5hCb2l31W5Xi6hPngXDdtAt/cKf4Rp8RiRmI5eZR5yz7Ubw35Glh
         ESdnchBvEHeJg856bczaUDpBdCh78zCEl+xWqCotL024hGg9k/D6snhX3QHzYbP/dmg5
         xGiPuqVdXAR8TjBXQKupG9Yl287NRyYk2YIpnELLQtQBJJS9Xqde+/8SGUo/1uHy8EnU
         7WWURliQo2QBfLkLxnPFpOK/B5tFkk/tWckCZnb9EsSahMeTlNsEzn5JgaYGqpHLG8tB
         4sbw==
X-Gm-Message-State: AOAM530lkZueM952Lo2B9ZydgG1LCq9QOxnE1KNZ2CMq1D7zlMGE95/L
        C0OcfHiHgWcxWyv5jQFGmYoVoflfmjds/d+QGXUYELxvnNJUK3zyvq2YacetiLqNUtRlXdgwp6/
        50pJFWVdWxKfbeTffX04YJfMa
X-Received: by 2002:a5d:40d2:: with SMTP id b18mr12013297wrq.131.1590402655376;
        Mon, 25 May 2020 03:30:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgOrrF27/Hn0VM1GmU3rUqzoyOepUfPocXD27ULwMBIu2ooviKdrTTzCDQq+mFLo1bwXdzwQ==
X-Received: by 2002:a5d:40d2:: with SMTP id b18mr12013273wrq.131.1590402655030;
        Mon, 25 May 2020 03:30:55 -0700 (PDT)
Received: from steredhat ([79.49.207.108])
        by smtp.gmail.com with ESMTPSA id o15sm4356417wmm.31.2020.05.25.03.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 03:30:54 -0700 (PDT)
Date:   Mon, 25 May 2020 12:30:51 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: io_uring: BUG: kernel NULL pointer dereference
Message-ID: <20200525103051.lztpbl33hsgv6grz@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
using fio and io_uring engine with SQPOLL and IOPOLL enabled, I had the
following issue that happens after 4/5 seconds fio has started.
Initially I had this issue on Linux v5.7-rc6, but I just tried also
Linux v5.7-rc7:

[   75.343479] nvme nvme0: pci function 0000:04:00.0
[   75.355110] nvme nvme0: 16/0/15 default/read/poll queues
[   75.364946]  nvme0n1: p1
[   82.739285] BUG: kernel NULL pointer dereference, address: 00000000000003b0
[   82.747054] #PF: supervisor read access in kernel mode
[   82.752785] #PF: error_code(0x0000) - not-present page
[   82.758516] PGD 800000046c042067 P4D 800000046c042067 PUD 461fcf067 PMD 0 
[   82.766186] Oops: 0000 [#1] SMP PTI
[   82.770076] CPU: 2 PID: 1307 Comm: io_uring-sq Not tainted 5.7.0-rc7 #11
[   82.777939] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 1.2.6 06/08/2015
[   82.786290] RIP: 0010:task_numa_work+0x4f/0x2c0
[   82.791341] Code: 18 4c 8b 25 e3 f0 8e 01 49 8b 9f 00 08 00 00 4d 8b af c8 00 00 00 49 39 c7 0f 85 e8 01 00 00 48 89 6d 00 41 f6 47 24 04 75 67 <48> 8b ab b0 03 00 00 48 85 ed 75 16 8b 3d 6f 68 94 01 e8 aa fb 04
[   82.812296] RSP: 0018:ffffaaa98415be10 EFLAGS: 00010246
[   82.818123] RAX: ffff953ee36b8000 RBX: 0000000000000000 RCX: 0000000000000000
[   82.826083] RDX: 0000000000000001 RSI: ffff953ee36b8000 RDI: ffff953ee36b8dc8
[   82.834042] RBP: ffff953ee36b8dc8 R08: 00000000001200db R09: ffff9542e3ad2e08
[   82.842002] R10: ffff9542ecd20070 R11: 0000000000000000 R12: 00000000fffca35b
[   82.849962] R13: 000000012a06a949 R14: ffff9542e3ad2c00 R15: ffff953ee36b8000
[   82.857922] FS:  0000000000000000(0000) GS:ffff953eefc40000(0000) knlGS:0000000000000000
[   82.866948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   82.873357] CR2: 00000000000003b0 CR3: 000000046bbd0002 CR4: 00000000001606e0
[   82.881316] Call Trace:
[   82.884046]  task_work_run+0x68/0xa0
[   82.888026]  io_sq_thread+0x252/0x3d0
[   82.892111]  ? finish_wait+0x80/0x80
[   82.896097]  kthread+0xf9/0x130
[   82.899598]  ? __ia32_sys_io_uring_enter+0x370/0x370
[   82.905134]  ? kthread_park+0x90/0x90
[   82.909217]  ret_from_fork+0x35/0x40
[   82.913203] Modules linked in: nvme nvme_core xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 tun bridge stp llc ip6table_mangle ip6table_nat iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter rfkill sunrpc intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul iTCO_wdt crc32_pclmul dcdbas ghash_clmulni_intel iTCO_vendor_support intel_cstate intel_uncore pcspkr intel_rapl_perf ipmi_ssif ixgbe mei_me mdio tg3 dca mei lpc_ich ipmi_si acpi_power_meter ipmi_devintf ipmi_msghandler ip_tables xfs libcrc32c mgag200 drm_kms_helper drm_vram_helper drm_ttm_helper ttm drm megaraid_sas crc32c_intel i2c_algo_bit wmi
[   82.990613] CR2: 00000000000003b0
[   82.994307] ---[ end trace 6d1725e8f60fece7 ]---
[   83.039157] RIP: 0010:task_numa_work+0x4f/0x2c0
[   83.044211] Code: 18 4c 8b 25 e3 f0 8e 01 49 8b 9f 00 08 00 00 4d 8b af c8 00 00 00 49 39 c7 0f 85 e8 01 00 00 48 89 6d 00 41 f6 47 24 04 75 67 <48> 8b ab b0 03 00 00 48 85 ed 75 16 8b 3d 6f 68 94 01 e8 aa fb 04
[   83.065165] RSP: 0018:ffffaaa98415be10 EFLAGS: 00010246
[   83.070993] RAX: ffff953ee36b8000 RBX: 0000000000000000 RCX: 0000000000000000
[   83.078953] RDX: 0000000000000001 RSI: ffff953ee36b8000 RDI: ffff953ee36b8dc8
[   83.086913] RBP: ffff953ee36b8dc8 R08: 00000000001200db R09: ffff9542e3ad2e08
[   83.094873] R10: ffff9542ecd20070 R11: 0000000000000000 R12: 00000000fffca35b
[   83.102833] R13: 000000012a06a949 R14: ffff9542e3ad2c00 R15: ffff953ee36b8000
[   83.110793] FS:  0000000000000000(0000) GS:ffff953eefc40000(0000) knlGS:0000000000000000
[   83.119821] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   83.126230] CR2: 00000000000003b0 CR3: 000000046bbd0002 CR4: 00000000001606e0
[  113.113624] nvme nvme0: I/O 219 QID 19 timeout, aborting
[  113.120135] nvme nvme0: Abort status: 0x0

Steps I did:

  $ modprobe nvme poll_queues=15
  $ fio fio_iou.job

This is the fio_iou.job that I used:

  [global]
  filename=/dev/nvme0n1
  ioengine=io_uring
  direct=1
  runtime=60
  ramp_time=5
  gtod_reduce=1

  cpus_allowed=4

  [job1]
  rw=randread
  bs=4K
  iodepth=1
  registerfiles
  sqthread_poll=1
  sqthread_poll_cpu=2
  hipri

I'll try to bisect, but I have some suspicions about:
b41e98524e42 io_uring: add per-task callback handler

Thanks,
Stefano

