Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1ACC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F25BB206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgGPOeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:34:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:56771 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbgGPOeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:34:17 -0400
IronPort-SDR: hAYzpIC+VOtaPPDmX9aPbPpTpiAVEVIlAnq/G/C8q8UrTWiODP4CKadme0071IK4AKha7JCYbN
 y/prNz3+mCRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="150767023"
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="150767023"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 07:34:13 -0700
IronPort-SDR: 7qC5wsr5C//EBv04ybAzcCMrqCAlx3x+UuYzqgqtUbk8PMWlZY1dbPjjOsNA9l+QHw/+6gEjjK
 vEhCU457cONw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="286499220"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 16 Jul 2020 07:34:11 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jw4xf-002Avc-UW; Thu, 16 Jul 2020 17:34:11 +0300
Date:   Thu, 16 Jul 2020 17:34:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        sakari.ailus@linux.intel.com, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Subject: Re: kernel oops in 'typec_ucsi' due to commit 'drivers property:
 When no children in primary, try secondary'
Message-ID: <20200716143411.GN3703480@smile.fi.intel.com>
References: <7affdd923186c5ce8c7dcf7cbe7b826eaa3ac8b2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7affdd923186c5ce8c7dcf7cbe7b826eaa3ac8b2.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:17:03AM +0300, Maxim Levitsky wrote:
> Hi!
> 
> Few days ago I bisected a regression on 5.8 kernel:
> 
> I have nvidia rtx 2070s and its USB type C port driver (which is open source)
> started to crash on load:

I'm looking at this, but I have questions:
- any pointers to the device tree excerpt which this tries to iterate over
- can you provide full Code: line?

Only way I see, why it happens, is that fwnode is not initialized properly
somewhere (means it has garbage in the secondary pointer).

> [  +0.000043] CPU: 19 PID: 31281 Comm: kworker/19:1 Tainted: P        W  O      5.8.0-rc3.stable #133
> [  +0.000045] Hardware name: Gigabyte Technology Co., Ltd. TRX40 DESIGNARE/TRX40 DESIGNARE, BIOS F4c 03/05/2020
> [  +0.000030] Workqueue: events_long ucsi_init_work [typec_ucsi]
> [  +0.000048] RIP: 0010:device_get_next_child_node+0x5b/0xb0
> [  +0.000024] Code: 18 48 85 db 74 24 48 8b 43 08 48 85 c0 74 1b 48 8b 40 50 48 85 c0 74 12 48 89 ee 48 89 df ff d0 48 85 c0 74 05 5b 5d 41 5c c3 <48> 8b 03 48 85 c0 74 f3 48>
> [  +0.000065] RSP: 0018:ffffc900038d7e08 EFLAGS: 00010246
> [  +0.000044] RAX: ffff889fb6b62f00 RBX: 0000000000000000 RCX: 0000000000000001
> [  +0.000027] RDX: ffff889fb6fd4a70 RSI: 0000000000000000 RDI: ffff889fb6b63608
> [  +0.000046] RBP: 0000000000000000 R08: 0000000000000001 R09: 7fffffffffffffff
> [  +0.000024] R10: 00002075ce282580 R11: 000000000062de3e R12: ffff889fb6b63608
> [  +0.000043] R13: 0000000000010000 R14: ffff889fb6b63018 R15: 0000000000000001
> [  +0.000044] FS:  0000000000000000(0000) GS:ffff889fbe4c0000(0000) knlGS:0000000000000000
> [  +0.000024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000042] CR2: 0000000000000000 CR3: 000000175621b000 CR4: 0000000000340ea0
> [  +0.000046] Call Trace:
> [  +0.000030]  ucsi_init+0x213/0x530 [typec_ucsi]
> [  +0.000028]  ucsi_init_work+0x12/0x20 [typec_ucsi]
> [  +0.000049]  process_one_work+0x1d2/0x390
> [  +0.000027]  worker_thread+0x4a/0x3b0
> [  +0.000025]  ? process_one_work+0x390/0x390
> [  +0.000049]  kthread+0xf9/0x130
> [  +0.000026]  ? kthread_park+0x90/0x90
> [  +0.000028]  ret_from_fork+0x1f/0x30
> [  +0.000048] Modules linked in: ucsi_ccg typec_ucsi typec hfsplus cdrom ntfs msdos vfio_pci vfio_virqfd vfio_iommu_type1 vfio vhost_net vhost vhost_iotlb tap xfs rfcomm xt_M>
> [  +0.000039]  usb_storage ext4 mbcache jbd2 amdgpu gpu_sched ttm drm_kms_helper syscopyarea sysfillrect ahci sysimgblt fb_sys_fops crc32_pclmul libahci crc32c_intel igb ccp >
> [  +0.000289] CR2: 0000000000000000
> [  +0.000026] ---[ end trace 38ebb9aebd55fbff ]---
> [  +0.014201] RIP: 0010:device_get_next_child_node+0x5b/0xb0
> [  +0.000030] Code: 18 48 85 db 74 24 48 8b 43 08 48 85 c0 74 1b 48 8b 40 50 48 85 c0 74 12 48 89 ee 48 89 df ff d0 48 85 c0 74 05 5b 5d 41 5c c3 <48> 8b 03 48 85 c0 74 f3 48>
> [  +0.000075] RSP: 0018:ffffc900038d7e08 EFLAGS: 00010246
> [  +0.000027] RAX: ffff889fb6b62f00 RBX: 0000000000000000 RCX: 0000000000000001
> [  +0.000048] RDX: ffff889fb6fd4a70 RSI: 0000000000000000 RDI: ffff889fb6b63608
> [  +0.000049] RBP: 0000000000000000 R08: 0000000000000001 R09: 7fffffffffffffff
> [  +0.000027] R10: 00002075ce282580 R11: 000000000062de3e R12: ffff889fb6b63608
> [  +0.000049] R13: 0000000000010000 R14: ffff889fb6b63018 R15: 0000000000000001
> [  +0.000050] FS:  0000000000000000(0000) GS:ffff889fbe4c0000(0000) knlGS:0000000000000000
> [  +0.000027] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000050] CR2: 0000000000000000 CR3: 000000175621b000 CR4: 0000000000340ea0
> 
> I bisected this, while passing the UCSI controller to a VM, and this
> is the result:
> 
> git bisect start
> # good: [3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162] Linux 5.7
> git bisect good 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162
> # bad: [48778464bb7d346b47157d21ffde2af6b2d39110] Linux 5.8-rc2
> git bisect bad 48778464bb7d346b47157d21ffde2af6b2d39110
> # good: [a98f670e41a99f53acb1fb33cee9c6abbb2e6f23] Merge tag 'media/v5.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> git bisect good a98f670e41a99f53acb1fb33cee9c6abbb2e6f23
> # good: [081096d98bb23946f16215357b141c5616b234bf] Merge tag 'tty-5.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
> git bisect good 081096d98bb23946f16215357b141c5616b234bf
> # bad: [3a2a8751742133a7bbc49b9d1bcbd52e212edff6] Merge tag 'for-v5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply
> git bisect bad 3a2a8751742133a7bbc49b9d1bcbd52e212edff6
> # bad: [a1e81f9654eef650d3ee35c94a8cab00b5cd379c] m68k: implement flush_icache_user_range
> git bisect bad a1e81f9654eef650d3ee35c94a8cab00b5cd379c
> # good: [c336c022503d1be719ca06f2526c211709e3d2d3] staging: wfx: remove false positive warning
> git bisect good c336c022503d1be719ca06f2526c211709e3d2d3
> # good: [05c8a4fc44a916dd897769ca69b42381f9177ec4] habanalabs: correctly cast u64 to void*
> git bisect good 05c8a4fc44a916dd897769ca69b42381f9177ec4
> # good: [a3975dea1696b7c81319dc4b66e3c378dd47ccfb] Merge tag 'iio-for-5.8c' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next
> git bisect good a3975dea1696b7c81319dc4b66e3c378dd47ccfb
> # bad: [f558b8364e19f9222e7976c64e9367f66bab02cc] Merge tag 'driver-core-5.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> git bisect bad f558b8364e19f9222e7976c64e9367f66bab02cc
> # good: [b6d90ef9a439b4ef73a350789bf766a1339a703d] staging: vchi: Get rid of not implemented function declarations
> git bisect good b6d90ef9a439b4ef73a350789bf766a1339a703d
> # good: [93d2e4322aa74c1ad1e8c2160608eb9a960d69ff] of: platform: Batch fwnode parsing when adding all top level devices
> git bisect good 93d2e4322aa74c1ad1e8c2160608eb9a960d69ff
> # bad: [c2c076166b5880eabe068ce1cab30bf6edeeea1a] firmware_loader: change enum fw_opt to u32
> git bisect bad c2c076166b5880eabe068ce1cab30bf6edeeea1a
> # bad: [2cd38fd15e4ebcfe917a443734820269f8b5ba2b] driver core: Remove unnecessary is_fwnode_dev variable in device_add()
> git bisect bad 2cd38fd15e4ebcfe917a443734820269f8b5ba2b
> # good: [c82c83c330654c5639960ebc3dabbae53c43f79e] driver core: platform: Fix spelling errors in platform.c
> git bisect good c82c83c330654c5639960ebc3dabbae53c43f79e
> # bad: [114dbb4fa7c4053a51964d112e2851e818e085c6] drivers property: When no children in primary, try secondary
> git bisect bad 114dbb4fa7c4053a51964d112e2851e818e085c6
> # first bad commit: [114dbb4fa7c4053a51964d112e2851e818e085c6] drivers property: When no children in primary, try secondary
> 
> 
> Reverting the commit helped fix this oops.
> 
> My .config attached.
> If any more info is needed I'll be happy to provide it,
> and of course test patches.
> 
> Best regards,
> 	Maxim Levitsky



-- 
With Best Regards,
Andy Shevchenko


