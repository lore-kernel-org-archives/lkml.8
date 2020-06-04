Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12102C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C03C2207D8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="Uu9EHb3N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ztGMO1kO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgFDA7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 20:59:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48429 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730357AbgFDA7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 20:59:47 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3BA165C00A4;
        Wed,  3 Jun 2020 20:59:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 03 Jun 2020 20:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ZgoXrlkPqR4CVxHEWNljIO5tqBh
        tvs0WuBYZvvCCFLw=; b=Uu9EHb3N0S9fjpj9QRmzV4pqLDxlOpJNi6fr8zftD6a
        VaZLAgzF2WX/zjJWJYAw0mr78xfdsMslYe8b8bsitqjHwHqnfgFekyt4cUIPL5QS
        0V8JExAnITciOa5itivALQkmK0SquU5h27++KM2AyUdGqOnn/OesijFgCeiNN/Fa
        qGMBfX/Xw/mkWUp3X+1ZrIm+Jd9zOxK2woj5J2r/g0IZ6+CrnoDE8xKvkFB45sH9
        4KwVQha/abwA5O5lXlWggKH2MbaqX+z3UB0QAsk8mlDCYC84Cda4SE1074yr1pzJ
        UNI7EP4QcoNT6JzRaAUCUCI6GEh5b1YdqUartUmXq1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ZgoXrl
        kPqR4CVxHEWNljIO5tqBhtvs0WuBYZvvCCFLw=; b=ztGMO1kO61Iqd1+wzYlOvz
        5U8fcm9Hs5owf69P7bGifJJO/TV9nf1awNB5xzlBKf5PvJntkqTqeneJkzMkE+Q1
        9ITmLZfNmnWccCLcfhahP74hN55JrT/Wngbyws9bg/1aqtOp9QIA3XIuc/tCaUZt
        tv3l2vkYrkGWTAh6jFIVt7H/UM1uZS6PgU46Q0nqPWR85Z1U4yakU7ZkZvtU/Oxu
        Y4XJ/1Z6bDi4+PtW9eaV+C/n5V5AlbyqROVwI2Xkq3IeMJVgZFhuTeD9UkGVa5Tk
        OpuXHV3jMhIbcGLcP1ZRVhcsWKl+AdWcbikZyVfSeR6jAajbeNrq1L0oBabt/Fjg
        ==
X-ME-Sender: <xms:ZUfYXp3Nj6Q5HGTd8eI6gxQ7sgutUy_73yJpQIIMaA946muhd2xrNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudegtddgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehmtderredttddvnecuhfhrohhmpeetnhgurhgv
    shcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtffrrg
    htthgvrhhnpefgueehveehhedtuefgvdejuedujeeukeelteekkeevjeduheegvddtfeev
    heelkeenucfkphepieejrdduiedtrddvudejrddvhedtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghssegrnhgrrhgriigvlhdr
    uggv
X-ME-Proxy: <xmx:ZkfYXgG2pz7CiIGXO4hrwzry1EzMPMTZEFZTKGo4NxmauPbvAi_iuQ>
    <xmx:ZkfYXp68OfnuWtDxtOuZtWPRDuUYBnWYD0bNu8xUW2B-GByT-SR6Pw>
    <xmx:ZkfYXm2vlifQni_6rw-I6bJEfFCjd0Z4SQNQy3pkBl2rcqOyLR-0FQ>
    <xmx:Z0fYXhTItegeGwBbOWVUAFzinEx-4L3vw1LeYVXrw_axp6Gr_MeWTA>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id 663D7328005E;
        Wed,  3 Jun 2020 20:59:17 -0400 (EDT)
Date:   Wed, 3 Jun 2020 17:59:16 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCHSET v5 0/12] Add support for async buffered reads
Message-ID: <20200604005916.niy2mejjcsx4sv6t@alap3.anarazel.de>
References: <20200526195123.29053-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="phl2npw7hpcjbj6l"
Content-Disposition: inline
In-Reply-To: <20200526195123.29053-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--phl2npw7hpcjbj6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I was trying to benchmark the benefits of this for the io_uring using
postgres I am working on. The initial results where quite promising
(reducing cpu usage significantly, to lower than non-uring sync io). But
unfortunately trying another workload triggered both panics and before
that seemingly returned wrong data.

I first saw that problem with b360d424ce02, which was
linux-block/async-buffered.6 at the time. After hitting the issue, I
updated to the current linux-block/async-buffered.6, but the problem
persists.

The workload that triggers the bug within a few seconds is postgres
doing a parallel sequential scan of a large table (and aggregating the
data, but that shouldn't matter). In the triggering case that boils down
to 9 processes sequentially reading a number of 1GB files (we chunk
tables internally into smaller files). Each process will read a 512kB
chunk of the file on its own, and then claim the next 512kB from a
shared memory location. Most of the IO will be READV requests, reading
16 * 8kB into postgres' buffer pool (which may or may not be neighboring
8kB pages).

The io submissions in this case will all be done to the same io_uring,
targeting MAP_HUGETLB | MAP_SHARED | MAP_ANONYMOUS memory. The data is
on xfs.

The benchmark starts with dropping caches, which helpfully is visible in
dmesg... That takes a few seconds, so the actual buffered io_uring load
starts soon after.

[  125.526092] tee (7775): drop_caches: 3
[  146.264327] kill_fasync: bad magic number in fasync_struct!

After this, but before the oops, I see some userspace memory or
non-io-uring pipe reads being corrupted.


[  146.264327] kill_fasync: bad magic number in fasync_struct!
[  146.285175] kill_fasync: bad magic number in fasync_struct!
[  146.290793] kill_fasync: bad magic number in fasync_struct!
[  146.285175] kill_fasync: bad magic number in fasync_struct!
[  146.290793] kill_fasync: bad magic number in fasync_struct!
[  157.071979] BUG: kernel NULL pointer dereference, address: 0000000000000020
[  157.078945] #PF: supervisor read access in kernel mode
[  157.084082] #PF: error_code(0x0000) - not-present page
[  157.089225] PGD 0 P4D 0
[  157.091763] Oops: 0000 [#1] SMP NOPTI
[  157.095429] CPU: 3 PID: 7756 Comm: postgres Not tainted 5.7.0-rc7-andres-00133-gc8707bf69395 #41
[  157.104208] Hardware name: Supermicro SYS-7049A-T/X11DAi-N, BIOS 3.2 11/13/2019
[  157.111518] RIP: 0010:xfs_log_commit_cil+0x356/0x7f0
[  157.116478] Code: 00 00 48 89 7e 08 49 89 76 30 48 89 11 48 89 4a 08 8b 4c 24 2c 48 89 85 c0 00 00 00 48 89 85 c8 00 00 00 49 8b 46 20 45 31 c9 <8b> 70 20 85 f6 0f 84 d9 02 00 00 45 31 c0 85 c9 7e 4f 41 8b 46 2c
[  157.135226] RSP: 0018:ffffc90021fefb00 EFLAGS: 00010246
[  157.140452] RAX: 0000000000000000 RBX: ffff8897a9ea80b0 RCX: 0000000000000458
[  157.147582] RDX: ffff8897a9ea80c0 RSI: ffff88afc39a1200 RDI: ffff88afb1ae2c18
[  157.154715] RBP: ffff8897a9ea8000 R08: ffffc90021fefb30 R09: 0000000000000000
[  157.161848] R10: 0000000000000084 R11: 0000000000000012 R12: ffff8897721bd400
[  157.168983] R13: ffff88afb1ae2c00 R14: ffff88afb19860c0 R15: ffff8897a9ea80a0
[  157.176115] FS:  00007ffbbe9a1980(0000) GS:ffff8897e0cc0000(0000) knlGS:0000000000000000
[  157.184199] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  157.189946] CR2: 0000000000000020 CR3: 000000179c0ac005 CR4: 00000000007606e0
[  157.197081] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  157.204212] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  157.211343] PKRU: 55555554
[  157.214048] Call Trace:
[  157.216498]  __xfs_trans_commit+0xa1/0x340
[  157.220596]  xfs_create+0x4cc/0x5e0
[  157.224087]  xfs_generic_create+0x241/0x310
[  157.228274]  path_openat+0xdb7/0x1020
[  157.231940]  do_filp_open+0x91/0x100
[  157.235518]  ? __sys_recvfrom+0xe4/0x170
[  157.239444]  ? _cond_resched+0x19/0x30
[  157.243196]  do_sys_openat2+0x215/0x2d0
[  157.247037]  do_sys_open+0x44/0x80
[  157.250443]  do_syscall_64+0x48/0x130
[  157.254108]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  157.259161] RIP: 0033:0x7ffbc0ded307
[  157.262738] Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85 c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 33 0c 25
[  157.281485] RSP: 002b:00007fff520a4940 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[  157.289052] RAX: ffffffffffffffda RBX: 00005561dc02eca0 RCX: 00007ffbc0ded307
[  157.296185] RDX: 0000000000000241 RSI: 00005561dc013470 RDI: 00000000ffffff9c
[  157.303317] RBP: 00005561dc013470 R08: 0000000000000004 R09: 0000000000000001
[  157.310447] R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000241
[  157.317575] R13: 00005561dc02eca0 R14: 0000000000000001 R15: 0000000000000000
[  157.324705] Modules linked in: isst_if_common squashfs nls_iso8859_1 nls_cp437 snd_hda_codec_realtek vfat snd_hda_codec_generic fat iwlmvm ledtrig_audio snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp snd_hda_intel snd_intel_dspcfg iwlwifi efi_pstore btusb snd_hda_codec btrtl btbcm efivars snd_hwdep btintel snd_hda_core iTCO_wdt iTCO_vendor_support mei_me mei loop coretemp hid_logitech_hidpp hid_logitech_dj hid_lenovo amdgpu gpu_sched i40e ixgbe ast drm_vram_helper drm_ttm_helper ttm mdio xhci_pci xhci_hcd
[  157.370249] CR2: 0000000000000020

There's a lot more of these later, some interspersed (possibly related
to grabbing the output via serial->bmc->network->ipmitool). I've
attached the whole dmesg and .config.

What would be helpful for debugging? Should I try the v5 branch instead?

I'll try setting up a VM + passing through NVME to be able to test this
without fear... In one instance I did see some minor corruption on
another device & fs (ext4 on dm-crypt on nvme). It's all backed up,
but...

Greetings,

Andres Freund

--phl2npw7hpcjbj6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

[    0.000000] Linux version 5.7.0-rc7-andres-00133-gc8707bf69395 (andres@awork3) (gcc version 9.3.0 (Debian 9.3.0-13), GNU ld (GNU Binutils for Debian) 2.34) #41 SMP Wed Jun 3 16:12:42 PDT 2020
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.7.0-rc7-andres-00133-gc8707bf69395 root=/dev/mapper/awork3--vg-root ro apparmor=0 console=ttyS1,115200 console=tty0 systemd.unified_cgroup_hierarchy intel_iommu=on nvme.poll_queues=2 nvme.write_queues=2 quiet
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: xstate_offset[5]:  960, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]: 1024, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1536, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: xstate_offset[9]: 2560, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x2ff, context size is 2568 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000003dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000003e000-0x000000000003ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000040000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000069eb5fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000069eb6000-0x000000006bfb5fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006bfb6000-0x000000006c4edfff] usable
[    0.000000] BIOS-e820: [mem 0x000000006c4ee000-0x000000006d32ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000006d330000-0x000000006f966fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006f967000-0x000000006fb33fff] type 20
[    0.000000] BIOS-e820: [mem 0x000000006fb34000-0x000000006fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000070000000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000fe7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed44fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000303fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.70 by American Megatrends
[    0.000000] efi:  ACPI 2.0=0x6c4ee000  ACPI=0x6c4ee000  SMBIOS=0x6f5d6000  SMBIOS 3.0=0x6f5d5000  MEMATTR=0x67805018  ESRT=0x64261c98
[    0.000000] SMBIOS 3.2.1 present.
[    0.000000] DMI: Supermicro SYS-7049A-T/X11DAi-N, BIOS 3.2 11/13/2019
[    0.000000] tsc: Detected 2500.000 MHz processor
[    0.000411] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000412] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000418] last_pfn = 0x3040000 max_arch_pfn = 0x400000000
[    0.000420] MTRR default type: uncachable
[    0.000421] MTRR fixed ranges enabled:
[    0.000422]   00000-9FFFF write-back
[    0.000423]   A0000-FFFFF uncachable
[    0.000424] MTRR variable ranges enabled:
[    0.000425]   0 base 000000000000 mask 3FE000000000 write-back
[    0.000426]   1 base 002000000000 mask 3FF000000000 write-back
[    0.000427]   2 base 003000000000 mask 3FFFC0000000 write-back
[    0.000428]   3 base 000080000000 mask 3FFF80000000 uncachable
[    0.000429]   4 base 000070000000 mask 3FFFFC000000 uncachable
[    0.000429]   5 disabled
[    0.000429]   6 disabled
[    0.000430]   7 disabled
[    0.000430]   8 disabled
[    0.000431]   9 disabled
[    0.000763] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000867] e820: update [mem 0x70000000-0x73ffffff] usable ==> reserved
[    0.000868] e820: update [mem 0x80000000-0xffffffff] usable ==> reserved
[    0.000870] x2apic: enabled by BIOS, switching to x2apic ops
[    0.000871] last_pfn = 0x70000 max_arch_pfn = 0x400000000
[    0.000877] esrt: Reserving ESRT space from 0x0000000064261c98 to 0x0000000064261cd0.
[    0.000881] e820: update [mem 0x64261000-0x64261fff] usable ==> reserved
[    0.000895] Using GB pages for direct mapping
[    0.000897] BRK [0x07201000, 0x07201fff] PGTABLE
[    0.000898] BRK [0x07202000, 0x07202fff] PGTABLE
[    0.000899] BRK [0x07203000, 0x07203fff] PGTABLE
[    0.001151] BRK [0x07204000, 0x07204fff] PGTABLE
[    0.001224] BRK [0x07205000, 0x07205fff] PGTABLE
[    0.001280] BRK [0x07206000, 0x07206fff] PGTABLE
[    0.001376] Secure boot could not be determined
[    0.001377] RAMDISK: [mem 0x0e5ab000-0x232ccfff]
[    0.001382] ACPI: Early table checksum verification disabled
[    0.001385] ACPI: RSDP 0x000000006C4EE000 000024 (v02 ALASKA)
[    0.001388] ACPI: XSDT 0x000000006C4EE0D0 000124 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.001393] ACPI: FACP 0x000000006C68AE70 000114 (v06 ALASKA A M I    01072009 INTL 20091013)
[    0.001397] ACPI: DSDT 0x000000006C4EE290 19CBDA (v02 ALASKA A M I    01072009 INTL 20091013)
[    0.001400] ACPI: FACS 0x000000006D2EC080 000040
[    0.001402] ACPI: FPDT 0x000000006C68AF88 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.001404] ACPI: FIDT 0x000000006C68AFD0 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.001406] ACPI: SPMI 0x000000006C68B070 000041 (v05 ALASKA A M I    00000000 AMI. 00000000)
[    0.001408] ACPI: SSDT 0x000000006C68B0B8 00046C (v02 INTEL  ADDRXLAT 00000001 INTL 20140828)
[    0.001411] ACPI: MCFG 0x000000006C68B528 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
[    0.001413] ACPI: HPET 0x000000006C68B568 000038 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.001415] ACPI: APIC 0x000000006C68B5A0 000C5E (v03 ALASKA A M I    00000000 INTL 20091013)
[    0.001417] ACPI: MIGT 0x000000006C68C200 000040 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.001419] ACPI: MSCT 0x000000006C68C240 000064 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.001422] ACPI: PCAT 0x000000006C68C2A8 000088 (v02 ALASKA A M I    00000002 INTL 20091013)
[    0.001424] ACPI: PCCT 0x000000006C68C330 00006E (v01 ALASKA A M I    00000002 INTL 20091013)
[    0.001426] ACPI: RASF 0x000000006C68C3A0 000030 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.001428] ACPI: SLIT 0x000000006C68C3D0 00012C (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.001430] ACPI: SRAT 0x000000006C68C500 0016B0 (v03 ALASKA A M I    00000002 INTL 20091013)
[    0.001432] ACPI: SVOS 0x000000006C68DBB0 000032 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.001434] ACPI: WDDT 0x000000006C68DBE8 000040 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.001437] ACPI: OEM1 0x000000006C68DC28 015174 (v02 INTEL  CPU EIST 00003000 INTL 20140828)
[    0.001439] ACPI: OEM2 0x000000006C6A2DA0 017554 (v02 INTEL  CPU  HWP 00003000 INTL 20140828)
[    0.001441] ACPI: SSDT 0x000000006C6BA2F8 019D00 (v02 INTEL  SSDT  PM 00004000 INTL 20140828)
[    0.001444] ACPI: OEM3 0x000000006C6D3FF8 013344 (v02 INTEL  CPU  TST 00003000 INTL 20140828)
[    0.001446] ACPI: SSDT 0x000000006C6E7340 00065B (v02 ALASKA A M I    00000000 INTL 20091013)
[    0.001448] ACPI: VFCT 0x000000006C6E79A0 00DE84 (v01 ALASKA A M I    00000001 AMD  31504F47)
[    0.001451] ACPI: SPCR 0x000000006C6F5828 000050 (v02 A M I  APTIO V  01072009 AMI. 0005000E)
[    0.001453] ACPI: UEFI 0x000000006C6F5878 00005C (v01 INTEL  RstUefiV 00000000      00000000)
[    0.001455] ACPI: SSDT 0x000000006C6F58D8 001B4E (v02 INTEL  SpsNm    00000002 INTL 20140828)
[    0.001458] ACPI: DMAR 0x000000006C6F7428 0002D8 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.001460] ACPI: HEST 0x000000006C6F7700 0000A8 (v01 ALASKA A M I    00000001 INTL 00000001)
[    0.001462] ACPI: BERT 0x000000006C6F77A8 000030 (v01 ALASKA A M I    00000001 INTL 00000001)
[    0.001464] ACPI: ERST 0x000000006C6F77D8 000230 (v01 ALASKA A M I    00000001 INTL 00000001)
[    0.001466] ACPI: EINJ 0x000000006C6F7A08 000150 (v01 ALASKA A M I    00000001 INTL 00000001)
[    0.001469] ACPI: WSMT 0x000000006C6F7B58 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.001474] ACPI: Local APIC address 0xfee00000
[    0.001475] Setting APIC routing to cluster x2apic.
[    0.001551] SRAT: PXM 0 -> APIC 0x0000 -> Node 0
[    0.001551] SRAT: PXM 0 -> APIC 0x0002 -> Node 0
[    0.001552] SRAT: PXM 0 -> APIC 0x0004 -> Node 0
[    0.001552] SRAT: PXM 0 -> APIC 0x0006 -> Node 0
[    0.001553] SRAT: PXM 0 -> APIC 0x0008 -> Node 0
[    0.001554] SRAT: PXM 0 -> APIC 0x0010 -> Node 0
[    0.001554] SRAT: PXM 0 -> APIC 0x0012 -> Node 0
[    0.001555] SRAT: PXM 0 -> APIC 0x0014 -> Node 0
[    0.001555] SRAT: PXM 0 -> APIC 0x0016 -> Node 0
[    0.001556] SRAT: PXM 0 -> APIC 0x0018 -> Node 0
[    0.001556] SRAT: PXM 1 -> APIC 0x0020 -> Node 1
[    0.001557] SRAT: PXM 1 -> APIC 0x0022 -> Node 1
[    0.001557] SRAT: PXM 1 -> APIC 0x0024 -> Node 1
[    0.001558] SRAT: PXM 1 -> APIC 0x0026 -> Node 1
[    0.001558] SRAT: PXM 1 -> APIC 0x0028 -> Node 1
[    0.001559] SRAT: PXM 1 -> APIC 0x0030 -> Node 1
[    0.001559] SRAT: PXM 1 -> APIC 0x0032 -> Node 1
[    0.001559] SRAT: PXM 1 -> APIC 0x0034 -> Node 1
[    0.001560] SRAT: PXM 1 -> APIC 0x0036 -> Node 1
[    0.001560] SRAT: PXM 1 -> APIC 0x0038 -> Node 1
[    0.001561] SRAT: PXM 0 -> APIC 0x0001 -> Node 0
[    0.001561] SRAT: PXM 0 -> APIC 0x0003 -> Node 0
[    0.001562] SRAT: PXM 0 -> APIC 0x0005 -> Node 0
[    0.001562] SRAT: PXM 0 -> APIC 0x0007 -> Node 0
[    0.001563] SRAT: PXM 0 -> APIC 0x0009 -> Node 0
[    0.001563] SRAT: PXM 0 -> APIC 0x0011 -> Node 0
[    0.001564] SRAT: PXM 0 -> APIC 0x0013 -> Node 0
[    0.001564] SRAT: PXM 0 -> APIC 0x0015 -> Node 0
[    0.001565] SRAT: PXM 0 -> APIC 0x0017 -> Node 0
[    0.001565] SRAT: PXM 0 -> APIC 0x0019 -> Node 0
[    0.001566] SRAT: PXM 1 -> APIC 0x0021 -> Node 1
[    0.001566] SRAT: PXM 1 -> APIC 0x0023 -> Node 1
[    0.001567] SRAT: PXM 1 -> APIC 0x0025 -> Node 1
[    0.001567] SRAT: PXM 1 -> APIC 0x0027 -> Node 1
[    0.001568] SRAT: PXM 1 -> APIC 0x0029 -> Node 1
[    0.001568] SRAT: PXM 1 -> APIC 0x0031 -> Node 1
[    0.001568] SRAT: PXM 1 -> APIC 0x0033 -> Node 1
[    0.001569] SRAT: PXM 1 -> APIC 0x0035 -> Node 1
[    0.001569] SRAT: PXM 1 -> APIC 0x0037 -> Node 1
[    0.001570] SRAT: PXM 1 -> APIC 0x0039 -> Node 1
[    0.001575] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[    0.001575] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x183fffffff]
[    0.001576] ACPI: SRAT: Node 1 PXM 1 [mem 0x1840000000-0x303fffffff]
[    0.001580] NUMA: Initialized distance table, cnt=2
[    0.001582] NUMA: Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x100000000-0x183fffffff] -> [mem 0x00000000-0x183fffffff]
[    0.001585] NODE_DATA(0) allocated [mem 0x183fffc000-0x183fffffff]
[    0.001589] NODE_DATA(1) allocated [mem 0x303fff9000-0x303fffcfff]
[    0.001747] Zone ranges:
[    0.001747]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.001748]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.001749]   Normal   [mem 0x0000000100000000-0x000000303fffffff]
[    0.001750] Movable zone start for each node
[    0.001751] Early memory node ranges
[    0.001752]   node   0: [mem 0x0000000000001000-0x000000000003dfff]
[    0.001752]   node   0: [mem 0x0000000000040000-0x000000000009ffff]
[    0.001753]   node   0: [mem 0x0000000000100000-0x0000000069eb5fff]
[    0.001754]   node   0: [mem 0x000000006bfb6000-0x000000006c4edfff]
[    0.001754]   node   0: [mem 0x000000006fb34000-0x000000006fffffff]
[    0.001755]   node   0: [mem 0x0000000100000000-0x000000183fffffff]
[    0.001762]   node   1: [mem 0x0000001840000000-0x000000303fffffff]
[    0.001995] Zeroed struct page in unavailable ranges: 22441 pages
[    0.001996] Initmem setup node 0 [mem 0x0000000000001000-0x000000183fffffff]
[    0.001998] On node 0 totalpages: 24815703
[    0.001999]   DMA zone: 64 pages used for memmap
[    0.001999]   DMA zone: 24 pages reserved
[    0.002000]   DMA zone: 3997 pages, LIFO batch:0
[    0.002067]   DMA32 zone: 6755 pages used for memmap
[    0.002068]   DMA32 zone: 432314 pages, LIFO batch:63
[    0.009716]   Normal zone: 380928 pages used for memmap
[    0.009718]   Normal zone: 24379392 pages, LIFO batch:63
[    0.394229] Initmem setup node 1 [mem 0x0000001840000000-0x000000303fffffff]
[    0.394231] On node 1 totalpages: 25165824
[    0.394232]   Normal zone: 393216 pages used for memmap
[    0.394232]   Normal zone: 25165824 pages, LIFO batch:63
[    0.823383] ACPI: PM-Timer IO Port: 0x508
[    0.823385] ACPI: Local APIC address 0xfee00000
[    0.823401] ACPI: X2APIC_NMI (uid[0xffffffff] high level lint[0x1])
[    0.823403] ACPI: LAPIC_NMI (acpi_id[0xff] dfl edge lint[0x1])
[    0.823422] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.823426] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24-31
[    0.823430] IOAPIC[2]: apic_id 10, version 32, address 0xfec08000, GSI 32-39
[    0.823433] IOAPIC[3]: apic_id 11, version 32, address 0xfec10000, GSI 40-47
[    0.823437] IOAPIC[4]: apic_id 12, version 32, address 0xfec18000, GSI 48-55
[    0.823441] IOAPIC[5]: apic_id 15, version 32, address 0xfec20000, GSI 72-79
[    0.823445] IOAPIC[6]: apic_id 16, version 32, address 0xfec28000, GSI 80-87
[    0.823449] IOAPIC[7]: apic_id 17, version 32, address 0xfec30000, GSI 88-95
[    0.823453] IOAPIC[8]: apic_id 18, version 32, address 0xfec38000, GSI 96-103
[    0.823457] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.823458] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.823460] ACPI: IRQ0 used by override.
[    0.823461] ACPI: IRQ9 used by override.
[    0.823464] Using ACPI (MADT) for SMP configuration information
[    0.823466] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.823469] ACPI: SPCR: console: uart,io,0x2f8,115200
[    0.823471] smpboot: Allowing 40 CPUs, 0 hotplug CPUs
[    0.823491] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.823493] PM: hibernation: Registered nosave memory: [mem 0x0003e000-0x0003ffff]
[    0.823494] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.823496] PM: hibernation: Registered nosave memory: [mem 0x64261000-0x64261fff]
[    0.823498] PM: hibernation: Registered nosave memory: [mem 0x69eb6000-0x6bfb5fff]
[    0.823499] PM: hibernation: Registered nosave memory: [mem 0x6c4ee000-0x6d32ffff]
[    0.823500] PM: hibernation: Registered nosave memory: [mem 0x6d330000-0x6f966fff]
[    0.823500] PM: hibernation: Registered nosave memory: [mem 0x6f967000-0x6fb33fff]
[    0.823501] PM: hibernation: Registered nosave memory: [mem 0x70000000-0x8fffffff]
[    0.823502] PM: hibernation: Registered nosave memory: [mem 0x90000000-0xfcffffff]
[    0.823502] PM: hibernation: Registered nosave memory: [mem 0xfd000000-0xfe7fffff]
[    0.823503] PM: hibernation: Registered nosave memory: [mem 0xfe800000-0xfed1ffff]
[    0.823503] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed44fff]
[    0.823504] PM: hibernation: Registered nosave memory: [mem 0xfed45000-0xfeffffff]
[    0.823504] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.823506] [mem 0x90000000-0xfcffffff] available for PCI devices
[    0.823509] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.831225] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:40 nr_node_ids:2
[    0.834245] percpu: Embedded 54 pages/cpu s182232 r8192 d30760 u262144
[    0.834254] pcpu-alloc: s182232 r8192 d30760 u262144 alloc=1*2097152
[    0.834255] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 20 21 22 23 24 25
[    0.834259] pcpu-alloc: [0] 26 27 28 29 -- -- -- -- [1] 10 11 12 13 14 15 16 17
[    0.834262] pcpu-alloc: [1] 18 19 30 31 32 33 34 35 [1] 36 37 38 39 -- -- -- --
[    0.834290] Built 2 zonelists, mobility grouping on.  Total pages: 49200540
[    0.834290] Policy zone: Normal
[    0.834292] Kernel command line: BOOT_IMAGE=/vmlinuz-5.7.0-rc7-andres-00133-gc8707bf69395 root=/dev/mapper/awork3--vg-root ro apparmor=0 console=ttyS1,115200 console=tty0 systemd.unified_cgroup_hierarchy intel_iommu=on nvme.poll_queues=2 nvme.write_queues=2 quiet
[    0.834447] DMAR: IOMMU enabled
[    0.834488] printk: log_buf_len individual max cpu contribution: 4096 bytes
[    0.834489] printk: log_buf_len total cpu_extra contributions: 159744 bytes
[    0.834489] printk: log_buf_len min size: 131072 bytes
[    0.834637] printk: log_buf_len: 524288 bytes
[    0.834638] printk: early log buf free: 113584(86%)
[    0.834993] mem auto-init: stack:off, heap alloc:off, heap free:off
[    1.273144] Memory: 196262256K/199926108K available (20486K kernel code, 2439K rwdata, 15292K rodata, 1784K init, 2144K bss, 3663852K reserved, 0K cma-reserved)
[    1.273702] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=40, Nodes=2
[    1.273727] ftrace: allocating 57952 entries in 227 pages
[    1.296364] ftrace: allocated 227 pages with 5 groups
[    1.296644] rcu: Hierarchical RCU implementation.
[    1.296645] rcu: 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=40.
[    1.296646] rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
[    1.296646] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=40
[    1.300110] NR_IRQS: 33024, nr_irqs: 2104, preallocated irqs: 16
[    1.300438] random: get_random_bytes called from start_kernel+0x5c7/0x790 with crng_init=0
[    1.300525] Console: colour dummy device 80x25
[    1.300533] printk: console [tty0] enabled
[    1.300558] printk: console [ttyS1] enabled
[    1.300635] mempolicy: Enabling automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl
[    1.300638] ACPI: Core revision 20200326
[    1.302496] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    1.302538] APIC: Switch to symmetric I/O mode setup
[    1.302540] DMAR: Host address width 46
[    1.302541] DMAR: DRHD base: 0x000000d37fc000 flags: 0x0
[    1.302546] DMAR: dmar0: reg_base_addr d37fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    1.302547] DMAR: DRHD base: 0x000000e0ffc000 flags: 0x0
[    1.302551] DMAR: dmar1: reg_base_addr e0ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    1.302552] DMAR: DRHD base: 0x000000ee7fc000 flags: 0x0
[    1.302556] DMAR: dmar2: reg_base_addr ee7fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    1.302557] DMAR: DRHD base: 0x000000fbffc000 flags: 0x0
[    1.302560] DMAR: dmar3: reg_base_addr fbffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    1.302560] DMAR: DRHD base: 0x000000aaffc000 flags: 0x0
[    1.302565] DMAR: dmar4: reg_base_addr aaffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    1.302566] DMAR: DRHD base: 0x000000b87fc000 flags: 0x0
[    1.302569] DMAR: dmar5: reg_base_addr b87fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    1.302569] DMAR: DRHD base: 0x000000c5ffc000 flags: 0x0
[    1.302572] DMAR: dmar6: reg_base_addr c5ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    1.302573] DMAR: DRHD base: 0x0000009d7fc000 flags: 0x1
[    1.302576] DMAR: dmar7: reg_base_addr 9d7fc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    1.302577] DMAR: RMRR base: 0x0000006f60e000 end: 0x0000006f61efff
[    1.302578] DMAR: ATSR flags: 0x0
[    1.302579] DMAR: ATSR flags: 0x0
[    1.302580] DMAR: RHSA base: 0x0000009d7fc000 proximity domain: 0x0
[    1.302580] DMAR: RHSA base: 0x000000aaffc000 proximity domain: 0x0
[    1.302581] DMAR: RHSA base: 0x000000b87fc000 proximity domain: 0x0
[    1.302581] DMAR: RHSA base: 0x000000c5ffc000 proximity domain: 0x0
[    1.302582] DMAR: RHSA base: 0x000000d37fc000 proximity domain: 0x1
[    1.302582] DMAR: RHSA base: 0x000000e0ffc000 proximity domain: 0x1
[    1.302582] DMAR: RHSA base: 0x000000ee7fc000 proximity domain: 0x1
[    1.302583] DMAR: RHSA base: 0x000000fbffc000 proximity domain: 0x1
[    1.302584] DMAR-IR: IOAPIC id 12 under DRHD base  0xc5ffc000 IOMMU 6
[    1.302585] DMAR-IR: IOAPIC id 11 under DRHD base  0xb87fc000 IOMMU 5
[    1.302586] DMAR-IR: IOAPIC id 10 under DRHD base  0xaaffc000 IOMMU 4
[    1.302587] DMAR-IR: IOAPIC id 18 under DRHD base  0xfbffc000 IOMMU 3
[    1.302588] DMAR-IR: IOAPIC id 17 under DRHD base  0xee7fc000 IOMMU 2
[    1.302588] DMAR-IR: IOAPIC id 16 under DRHD base  0xe0ffc000 IOMMU 1
[    1.302589] DMAR-IR: IOAPIC id 15 under DRHD base  0xd37fc000 IOMMU 0
[    1.302590] DMAR-IR: IOAPIC id 8 under DRHD base  0x9d7fc000 IOMMU 7
[    1.302591] DMAR-IR: IOAPIC id 9 under DRHD base  0x9d7fc000 IOMMU 7
[    1.302592] DMAR-IR: HPET id 0 under DRHD base 0x9d7fc000
[    1.302593] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    1.304733] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    1.305807] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    1.319191] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x240939f1bb2, max_idle_ns: 440795263295 ns
[    1.319195] Calibrating delay loop (skipped), value calculated using timer frequency.. 5002.33 BogoMIPS (lpj=8333333)
[    1.319197] pid_max: default: 40960 minimum: 320
[    1.322213] LSM: Security Framework initializing
[    1.343100] Dentry cache hash table entries: 16777216 (order: 15, 134217728 bytes, vmalloc)
[    1.353423] Inode-cache hash table entries: 8388608 (order: 14, 67108864 bytes, vmalloc)
[    1.353768] Mount-cache hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
[    1.354078] Mountpoint-cache hash table entries: 262144 (order: 9, 2097152 bytes, vmalloc)
[    1.354539] mce: CPU0: Thermal monitoring enabled (TM1)
[    1.354621] process: using mwait in idle threads
[    1.354624] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    1.354624] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    1.354628] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    1.354630] Spectre V2 : Mitigation: Enhanced IBRS
[    1.354631] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    1.354632] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    1.354634] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    1.354634] TAA: Mitigation: TSX disabled
[    1.354926] Freeing SMP alternatives memory: 52K
[    1.355581] smpboot: CPU0: Intel(R) Xeon(R) Gold 5215 CPU @ 2.50GHz (family: 0x6, model: 0x55, stepping: 0x7)
[    1.355735] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    1.355741] ... version:                4
[    1.355741] ... bit width:              48
[    1.355742] ... generic registers:      4
[    1.355743] ... value mask:             0000ffffffffffff
[    1.355743] ... max period:             00007fffffffffff
[    1.355744] ... fixed-purpose events:   3
[    1.355744] ... event mask:             000000070000000f
[    1.355813] rcu: Hierarchical SRCU implementation.
[    1.355859] smp: Bringing up secondary CPUs ...
[    1.355859] x86: Booting SMP configuration:
[    1.355859] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9
[    1.371062] .... node  #1, CPUs:   #10
[    0.002134] smpboot: CPU 10 Converting physical 0 to logical die 1
[    1.459306]  #11 #12 #13 #14 #15 #16 #17 #18 #19
[    1.475963] .... node  #0, CPUs:   #20 #21 #22 #23 #24 #25 #26 #27 #28 #29
[    1.494384] .... node  #1, CPUs:   #30 #31 #32 #33 #34 #35 #36 #37 #38 #39
[    1.514332] smp: Brought up 2 nodes, 40 CPUs
[    1.514332] smpboot: Max logical packages: 2
[    1.514332] smpboot: Total of 40 processors activated (200120.81 BogoMIPS)
[    1.521784] devtmpfs: initialized
[    1.521784] PM: Registering ACPI NVS region [mem 0x6c4ee000-0x6d32ffff] (14950400 bytes)
[    1.522634] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    1.522666] futex hash table entries: 16384 (order: 8, 1048576 bytes, vmalloc)
[    1.522989] xor: automatically using best checksumming function   avx
[    1.523030] pinctrl core: initialized pinctrl subsystem

[    1.523118] *************************************************************
[    1.523118] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    1.523119] **                                                         **
[    1.523119] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **
[    1.523120] **                                                         **
[    1.523120] ** This means that this kernel is built to expose internal **
[    1.523120] ** IOMMU data structures, which may compromise security on **
[    1.523121] ** your system.                                            **
[    1.523121] **                                                         **
[    1.523122] ** If you see this message and you are not debugging the   **
[    1.523122] ** kernel, report this immediately to your vendor!         **
[    1.523122] **                                                         **
[    1.523123] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    1.523123] *************************************************************
[    1.523170] PM: RTC time: 00:16:21, date: 2020-06-04
[    1.523171] thermal_sys: Registered thermal governor 'fair_share'
[    1.523172] thermal_sys: Registered thermal governor 'bang_bang'
[    1.523172] thermal_sys: Registered thermal governor 'step_wise'
[    1.523173] thermal_sys: Registered thermal governor 'user_space'
[    1.523174] thermal_sys: Registered thermal governor 'power_allocator'
[    1.523427] NET: Registered protocol family 16
[    1.523597] audit: initializing netlink subsys (disabled)
[    1.523601] audit: type=2000 audit(1591229781.223:1): state=initialized audit_enabled=0 res=1
[    1.523601] cpuidle: using governor ladder
[    1.523601] cpuidle: using governor menu
[    1.523601] Detected 1 PCC Subspaces
[    1.523601] Registering PCC driver as Mailbox controller
[    1.523601] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    1.523601] ACPI: bus type PCI registered
[    1.523601] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    1.523601] dca service started, version 1.12.1
[    1.523601] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    1.523601] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
[    1.523601] pmd_set_huge: Cannot satisfy [mem 0x80000000-0x80200000] with a huge-page mapping due to MTRR override.
[    1.523601] PCI: Using configuration type 1 for base access
[    1.526033] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    1.529711] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    1.529711] cryptd: max_cpu_qlen set to 1000
[    1.535986] raid6: skip pq benchmark and using algorithm avx512x4
[    1.535986] raid6: using avx512x2 recovery algorithm
[    1.536093] ACPI: Added _OSI(Module Device)
[    1.536094] ACPI: Added _OSI(Processor Device)
[    1.536095] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.536095] ACPI: Added _OSI(Processor Aggregator Device)
[    1.536096] ACPI: Added _OSI(Linux-Dell-Video)
[    1.536097] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    1.536099] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    1.584999] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    1.588752] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    1.611204] ACPI: Interpreter enabled
[    1.611223] ACPI: (supports S0 S3 S4 S5)
[    1.611224] ACPI: Using IOAPIC for interrupt routing
[    1.612559] HEST: Table parsing has been initialized.
[    1.612559] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.615864] ACPI: Enabled 6 GPEs in block 00 to 7F
[    1.642527] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 40/0x7f00 ignored.
[    1.642527] ACPI: Unable to map lapic to logical cpu number
[    1.642540] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 41/0x7f02 ignored.
[    1.642540] ACPI: Unable to map lapic to logical cpu number
[    1.642540] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 42/0x7f04 ignored.
[    1.642540] ACPI: Unable to map lapic to logical cpu number
[    1.642540] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 43/0x7f06 ignored.
[    1.642540] ACPI: Unable to map lapic to logical cpu number
[    1.642624] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 44/0x7f08 ignored.
[    1.642625] ACPI: Unable to map lapic to logical cpu number
[    1.642859] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 45/0x7f10 ignored.
[    1.642860] ACPI: Unable to map lapic to logical cpu number
[    1.643092] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 46/0x7f12 ignored.
[    1.643092] ACPI: Unable to map lapic to logical cpu number
[    1.643326] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 47/0x7f14 ignored.
[    1.643327] ACPI: Unable to map lapic to logical cpu number
[    1.643559] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 48/0x7f16 ignored.
[    1.643559] ACPI: Unable to map lapic to logical cpu number
[    1.643792] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 49/0x7f18 ignored.
[    1.643793] ACPI: Unable to map lapic to logical cpu number
[    1.644024] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 50/0x7f01 ignored.
[    1.644025] ACPI: Unable to map lapic to logical cpu number
[    1.644258] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 51/0x7f03 ignored.
[    1.644259] ACPI: Unable to map lapic to logical cpu number
[    1.644493] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 52/0x7f05 ignored.
[    1.644493] ACPI: Unable to map lapic to logical cpu number
[    1.644724] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 53/0x7f07 ignored.
[    1.644725] ACPI: Unable to map lapic to logical cpu number
[    1.645861] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 54/0x7f09 ignored.
[    1.645861] ACPI: Unable to map lapic to logical cpu number
[    1.645870] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 55/0x7f11 ignored.
[    1.645870] ACPI: Unable to map lapic to logical cpu number
[    1.645871] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 56/0x7f13 ignored.
[    1.645871] ACPI: Unable to map lapic to logical cpu number
[    1.645871] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 57/0x7f15 ignored.
[    1.645871] ACPI: Unable to map lapic to logical cpu number
[    1.645899] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 58/0x7f17 ignored.
[    1.645899] ACPI: Unable to map lapic to logical cpu number
[    1.646133] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 59/0x7f19 ignored.
[    1.646133] ACPI: Unable to map lapic to logical cpu number
[    1.647047] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 60/0x7f20 ignored.
[    1.647048] ACPI: Unable to map lapic to logical cpu number
[    1.647280] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 61/0x7f22 ignored.
[    1.647280] ACPI: Unable to map lapic to logical cpu number
[    1.647514] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 62/0x7f24 ignored.
[    1.647514] ACPI: Unable to map lapic to logical cpu number
[    1.647747] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 63/0x7f26 ignored.
[    1.647747] ACPI: Unable to map lapic to logical cpu number
[    1.647981] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 64/0x7f28 ignored.
[    1.647981] ACPI: Unable to map lapic to logical cpu number
[    1.649193] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 65/0x7f30 ignored.
[    1.649193] ACPI: Unable to map lapic to logical cpu number
[    1.649204] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 66/0x7f32 ignored.
[    1.649204] ACPI: Unable to map lapic to logical cpu number
[    1.649204] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 67/0x7f34 ignored.
[    1.649204] ACPI: Unable to map lapic to logical cpu number
[    1.649204] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 68/0x7f36 ignored.
[    1.649204] ACPI: Unable to map lapic to logical cpu number
[    1.649204] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 69/0x7f38 ignored.
[    1.649204] ACPI: Unable to map lapic to logical cpu number
[    1.649385] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 70/0x7f21 ignored.
[    1.649385] ACPI: Unable to map lapic to logical cpu number
[    1.649618] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 71/0x7f23 ignored.
[    1.649618] ACPI: Unable to map lapic to logical cpu number
[    1.649850] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 72/0x7f25 ignored.
[    1.649850] ACPI: Unable to map lapic to logical cpu number
[    1.650082] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 73/0x7f27 ignored.
[    1.650082] ACPI: Unable to map lapic to logical cpu number
[    1.650314] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 74/0x7f29 ignored.
[    1.650315] ACPI: Unable to map lapic to logical cpu number
[    1.650547] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 75/0x7f31 ignored.
[    1.650547] ACPI: Unable to map lapic to logical cpu number
[    1.650779] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 76/0x7f33 ignored.
[    1.650780] ACPI: Unable to map lapic to logical cpu number
[    1.651011] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 77/0x7f35 ignored.
[    1.651011] ACPI: Unable to map lapic to logical cpu number
[    1.651244] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 78/0x7f37 ignored.
[    1.651244] ACPI: Unable to map lapic to logical cpu number
[    1.651475] APIC: NR_CPUS/possible_cpus limit of 40 reached. Processor 79/0x7f39 ignored.
[    1.651475] ACPI: Unable to map lapic to logical cpu number
[    1.652539] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-16])
[    1.652539] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.652539] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER LTR]
[    1.652588] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    1.652589] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.653026] PCI host bridge to bus 0000:00
[    1.653027] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    1.653029] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    1.653030] pci_bus 0000:00: root bus resource [io  0x03b0-0x03bb window]
[    1.653031] pci_bus 0000:00: root bus resource [io  0x03c0-0x03df window]
[    1.653032] pci_bus 0000:00: root bus resource [io  0x1000-0x3fff window]
[    1.653033] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.653034] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    1.653035] pci_bus 0000:00: root bus resource [mem 0xfe010000-0xfe010fff window]
[    1.653036] pci_bus 0000:00: root bus resource [mem 0x90000000-0x9d7fffff window]
[    1.653037] pci_bus 0000:00: root bus resource [mem 0x380000000000-0x383fffffffff window]
[    1.653038] pci_bus 0000:00: root bus resource [bus 00-16]
[    1.653047] pci 0000:00:00.0: [8086:2020] type 00 class 0x060000
[    1.653228] pci 0000:00:04.0: [8086:2021] type 00 class 0x088000
[    1.653239] pci 0000:00:04.0: reg 0x10: [mem 0x383ffff40000-0x383ffff43fff 64bit]
[    1.653372] pci 0000:00:04.1: [8086:2021] type 00 class 0x088000
[    1.653381] pci 0000:00:04.1: reg 0x10: [mem 0x383ffff3c000-0x383ffff3ffff 64bit]
[    1.653513] pci 0000:00:04.2: [8086:2021] type 00 class 0x088000
[    1.653522] pci 0000:00:04.2: reg 0x10: [mem 0x383ffff38000-0x383ffff3bfff 64bit]
[    1.653653] pci 0000:00:04.3: [8086:2021] type 00 class 0x088000
[    1.653662] pci 0000:00:04.3: reg 0x10: [mem 0x383ffff34000-0x383ffff37fff 64bit]
[    1.653793] pci 0000:00:04.4: [8086:2021] type 00 class 0x088000
[    1.653801] pci 0000:00:04.4: reg 0x10: [mem 0x383ffff30000-0x383ffff33fff 64bit]
[    1.653930] pci 0000:00:04.5: [8086:2021] type 00 class 0x088000
[    1.653939] pci 0000:00:04.5: reg 0x10: [mem 0x383ffff2c000-0x383ffff2ffff 64bit]
[    1.654068] pci 0000:00:04.6: [8086:2021] type 00 class 0x088000
[    1.654077] pci 0000:00:04.6: reg 0x10: [mem 0x383ffff28000-0x383ffff2bfff 64bit]
[    1.654209] pci 0000:00:04.7: [8086:2021] type 00 class 0x088000
[    1.654218] pci 0000:00:04.7: reg 0x10: [mem 0x383ffff24000-0x383ffff27fff 64bit]
[    1.654347] pci 0000:00:05.0: [8086:2024] type 00 class 0x088000
[    1.654467] pci 0000:00:05.1: [8086:2022] type 00 class 0x088000
[    1.655871] pci 0000:00:05.2: [8086:2025] type 00 class 0x088000
[    1.655871] pci 0000:00:05.4: [8086:2026] type 00 class 0x080020
[    1.655871] pci 0000:00:05.4: reg 0x10: [mem 0x9d30a000-0x9d30afff]
[    1.655871] pci 0000:00:05.6: [8086:2027] type 00 class 0x110100
[    1.655873] pci 0000:00:07.0: [8086:2028] type 00 class 0x088000
[    1.655873] pci 0000:00:07.4: [8086:202c] type 00 class 0x088000
[    1.655873] pci 0000:00:07.7: [8086:202d] type 00 class 0x088000
[    1.655873] pci 0000:00:08.0: [8086:2014] type 00 class 0x088000
[    1.655874] pci 0000:00:08.1: [8086:2015] type 00 class 0x110100
[    1.655874] pci 0000:00:08.2: [8086:2016] type 00 class 0x088000
[    1.655874] pci 0000:00:11.0: [8086:a1ec] type 00 class 0xff0000
[    1.655874] pci 0000:00:11.1: [8086:a1ed] type 00 class 0xff0000
[    1.656022] pci 0000:00:11.5: [8086:a1d2] type 00 class 0x010601
[    1.656038] pci 0000:00:11.5: reg 0x10: [mem 0x9d306000-0x9d307fff]
[    1.656044] pci 0000:00:11.5: reg 0x14: [mem 0x9d309000-0x9d3090ff]
[    1.656051] pci 0000:00:11.5: reg 0x18: [io  0x3070-0x3077]
[    1.656057] pci 0000:00:11.5: reg 0x1c: [io  0x3060-0x3063]
[    1.656064] pci 0000:00:11.5: reg 0x20: [io  0x3020-0x303f]
[    1.656070] pci 0000:00:11.5: reg 0x24: [mem 0x9d280000-0x9d2fffff]
[    1.656106] pci 0000:00:11.5: PME# supported from D3hot
[    1.656256] pci 0000:00:14.0: [8086:a1af] type 00 class 0x0c0330
[    1.656276] pci 0000:00:14.0: reg 0x10: [mem 0x383ffff10000-0x383ffff1ffff 64bit]
[    1.656336] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    1.656471] pci 0000:00:14.2: [8086:a1b1] type 00 class 0x118000
[    1.656491] pci 0000:00:14.2: reg 0x10: [mem 0x383ffff47000-0x383ffff47fff 64bit]
[    1.656660] pci 0000:00:16.0: [8086:a1ba] type 00 class 0x078000
[    1.656687] pci 0000:00:16.0: reg 0x10: [mem 0x383ffff46000-0x383ffff46fff 64bit]
[    1.656768] pci 0000:00:16.0: PME# supported from D3hot
[    1.656882] pci 0000:00:16.1: [8086:a1bb] type 00 class 0x078000
[    1.656909] pci 0000:00:16.1: reg 0x10: [mem 0x383ffff45000-0x383ffff45fff 64bit]
[    1.656989] pci 0000:00:16.1: PME# supported from D3hot
[    1.657106] pci 0000:00:16.4: [8086:a1be] type 00 class 0x078000
[    1.657133] pci 0000:00:16.4: reg 0x10: [mem 0x383ffff44000-0x383ffff44fff 64bit]
[    1.657212] pci 0000:00:16.4: PME# supported from D3hot
[    1.657331] pci 0000:00:17.0: [8086:a182] type 00 class 0x010601
[    1.657346] pci 0000:00:17.0: reg 0x10: [mem 0x9d304000-0x9d305fff]
[    1.657353] pci 0000:00:17.0: reg 0x14: [mem 0x9d308000-0x9d3080ff]
[    1.657359] pci 0000:00:17.0: reg 0x18: [io  0x3050-0x3057]
[    1.657366] pci 0000:00:17.0: reg 0x1c: [io  0x3040-0x3043]
[    1.657372] pci 0000:00:17.0: reg 0x20: [io  0x3000-0x301f]
[    1.657378] pci 0000:00:17.0: reg 0x24: [mem 0x9d200000-0x9d27ffff]
[    1.657413] pci 0000:00:17.0: PME# supported from D3hot
[    1.657558] pci 0000:00:1c.0: [8086:a190] type 01 class 0x060400
[    1.657624] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.657791] pci 0000:00:1c.2: [8086:a192] type 01 class 0x060400
[    1.657863] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    1.659205] pci 0000:00:1c.5: [8086:a195] type 01 class 0x060400
[    1.659205] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    1.659208] pci 0000:00:1f.0: [8086:a1c1] type 00 class 0x060100
[    1.659208] pci 0000:00:1f.2: [8086:a1a1] type 00 class 0x058000
[    1.659208] pci 0000:00:1f.2: reg 0x10: [mem 0x9d300000-0x9d303fff]
[    1.659208] pci 0000:00:1f.3: [8086:a1f0] type 00 class 0x040300
[    1.659208] pci 0000:00:1f.3: reg 0x10: [mem 0x383ffff20000-0x383ffff23fff 64bit]
[    1.659208] pci 0000:00:1f.3: reg 0x20: [mem 0x383ffff00000-0x383ffff0ffff 64bit]
[    1.659208] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    1.659208] pci 0000:00:1f.4: [8086:a1a3] type 00 class 0x0c0500
[    1.659208] pci 0000:00:1f.4: reg 0x10: [mem 0x00000000-0x000000ff 64bit]
[    1.659208] pci 0000:00:1f.4: reg 0x20: [io  0x0780-0x079f]
[    1.659208] pci 0000:00:1f.5: [8086:a1a4] type 00 class 0x0c8000
[    1.659208] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    1.659270] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.659384] pci 0000:02:00.0: [1b21:2142] type 00 class 0x0c0330
[    1.659411] pci 0000:02:00.0: reg 0x10: [mem 0x9d100000-0x9d107fff 64bit]
[    1.659458] pci 0000:02:00.0: enabling Extended Tags
[    1.659521] pci 0000:02:00.0: PME# supported from D0
[    1.659693] pci 0000:00:1c.2: PCI bridge to [bus 02]
[    1.659697] pci 0000:00:1c.2:   bridge window [mem 0x9d100000-0x9d1fffff]
[    1.659750] pci 0000:03:00.0: [1a03:1150] type 01 class 0x060400
[    1.659806] pci 0000:03:00.0: enabling Extended Tags
[    1.659865] pci 0000:03:00.0: supports D1 D2
[    1.659866] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.659970] pci 0000:00:1c.5: PCI bridge to [bus 03-04]
[    1.659973] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
[    1.659975] pci 0000:00:1c.5:   bridge window [mem 0x9c000000-0x9d0fffff]
[    1.660012] pci_bus 0000:04: extended config space not accessible
[    1.660039] pci 0000:04:00.0: [1a03:2000] type 00 class 0x030000
[    1.660059] pci 0000:04:00.0: reg 0x10: [mem 0x9c000000-0x9cffffff]
[    1.660069] pci 0000:04:00.0: reg 0x14: [mem 0x9d000000-0x9d01ffff]
[    1.660080] pci 0000:04:00.0: reg 0x18: [io  0x2000-0x207f]
[    1.660165] pci 0000:04:00.0: supports D1 D2
[    1.660166] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.660264] pci 0000:03:00.0: PCI bridge to [bus 04]
[    1.660269] pci 0000:03:00.0:   bridge window [io  0x2000-0x2fff]
[    1.660273] pci 0000:03:00.0:   bridge window [mem 0x9c000000-0x9d0fffff]
[    1.660296] pci_bus 0000:00: on NUMA node 0
[    1.660909] ACPI: PCI Root Bridge [PC01] (domain 0000 [bus 17-39])
[    1.660913] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.661266] acpi PNP0A08:01: _OSC: platform does not support [SHPCHotplug AER LTR]
[    1.661466] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    1.661467] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.661630] PCI host bridge to bus 0000:17
[    1.661632] pci_bus 0000:17: root bus resource [io  0x4000-0x5fff window]
[    1.661633] pci_bus 0000:17: root bus resource [mem 0x9d800000-0xaaffffff window]
[    1.661634] pci_bus 0000:17: root bus resource [mem 0x384000000000-0x387fffffffff window]
[    1.661636] pci_bus 0000:17: root bus resource [bus 17-39]
[    1.661644] pci 0000:17:00.0: [8086:2030] type 01 class 0x060400
[    1.661670] pci 0000:17:00.0: enabling Extended Tags
[    1.661700] pci 0000:17:00.0: PME# supported from D0 D3hot D3cold
[    1.662540] pci 0000:17:05.0: [8086:2034] type 00 class 0x088000
[    1.662567] pci 0000:17:05.2: [8086:2035] type 00 class 0x088000
[    1.662567] pci 0000:17:05.4: [8086:2036] type 00 class 0x080020
[    1.662567] pci 0000:17:05.4: reg 0x10: [mem 0xaaf00000-0xaaf00fff]
[    1.662567] pci 0000:17:05.6: [8086:2037] type 00 class 0x110100
[    1.662567] pci 0000:17:07.0: [8086:2038] type 00 class 0x088000
[    1.662567] pci 0000:17:07.1: [8086:2039] type 00 class 0x088000
[    1.662567] pci 0000:17:07.2: [8086:203a] type 00 class 0x088000
[    1.662567] pci 0000:17:07.3: [8086:203b] type 00 class 0x088000
[    1.662567] pci 0000:17:07.4: [8086:203c] type 00 class 0x088000
[    1.662567] pci 0000:17:07.7: [8086:203d] type 00 class 0x088000
[    1.662606] pci 0000:17:08.0: [8086:208d] type 00 class 0x088000
[    1.662677] pci 0000:17:08.1: [8086:208d] type 00 class 0x088000
[    1.662732] pci 0000:17:08.2: [8086:208d] type 00 class 0x088000
[    1.662786] pci 0000:17:08.3: [8086:208d] type 00 class 0x088000
[    1.662840] pci 0000:17:08.4: [8086:208d] type 00 class 0x088000
[    1.662895] pci 0000:17:08.5: [8086:208d] type 00 class 0x088000
[    1.662950] pci 0000:17:08.6: [8086:208d] type 00 class 0x088000
[    1.663007] pci 0000:17:08.7: [8086:208d] type 00 class 0x088000
[    1.663062] pci 0000:17:09.0: [8086:208d] type 00 class 0x088000
[    1.663128] pci 0000:17:09.1: [8086:208d] type 00 class 0x088000
[    1.663183] pci 0000:17:09.2: [8086:208d] type 00 class 0x088000
[    1.663239] pci 0000:17:09.3: [8086:208d] type 00 class 0x088000
[    1.663294] pci 0000:17:09.4: [8086:208d] type 00 class 0x088000
[    1.663349] pci 0000:17:09.5: [8086:208d] type 00 class 0x088000
[    1.663404] pci 0000:17:09.6: [8086:208d] type 00 class 0x088000
[    1.663459] pci 0000:17:09.7: [8086:208d] type 00 class 0x088000
[    1.663514] pci 0000:17:0a.0: [8086:208d] type 00 class 0x088000
[    1.663579] pci 0000:17:0a.1: [8086:208d] type 00 class 0x088000
[    1.663637] pci 0000:17:0e.0: [8086:208e] type 00 class 0x088000
[    1.663707] pci 0000:17:0e.1: [8086:208e] type 00 class 0x088000
[    1.663762] pci 0000:17:0e.2: [8086:208e] type 00 class 0x088000
[    1.663816] pci 0000:17:0e.3: [8086:208e] type 00 class 0x088000
[    1.663873] pci 0000:17:0e.4: [8086:208e] type 00 class 0x088000
[    1.663927] pci 0000:17:0e.5: [8086:208e] type 00 class 0x088000
[    1.663979] pci 0000:17:0e.6: [8086:208e] type 00 class 0x088000
[    1.664032] pci 0000:17:0e.7: [8086:208e] type 00 class 0x088000
[    1.664087] pci 0000:17:0f.0: [8086:208e] type 00 class 0x088000
[    1.664156] pci 0000:17:0f.1: [8086:208e] type 00 class 0x088000
[    1.664211] pci 0000:17:0f.2: [8086:208e] type 00 class 0x088000
[    1.664266] pci 0000:17:0f.3: [8086:208e] type 00 class 0x088000
[    1.664325] pci 0000:17:0f.4: [8086:208e] type 00 class 0x088000
[    1.664378] pci 0000:17:0f.5: [8086:208e] type 00 class 0x088000
[    1.664430] pci 0000:17:0f.6: [8086:208e] type 00 class 0x088000
[    1.664484] pci 0000:17:0f.7: [8086:208e] type 00 class 0x088000
[    1.664540] pci 0000:17:10.0: [8086:208e] type 00 class 0x088000
[    1.664608] pci 0000:17:10.1: [8086:208e] type 00 class 0x088000
[    1.665863] pci 0000:17:14.0: [8086:208f] type 00 class 0x088000
[    1.665881] pci 0000:17:14.1: [8086:208f] type 00 class 0x088000
[    1.665881] pci 0000:17:14.2: [8086:208f] type 00 class 0x088000
[    1.665881] pci 0000:17:14.3: [8086:208f] type 00 class 0x088000
[    1.665881] pci 0000:17:14.4: [8086:208f] type 00 class 0x088000
[    1.665881] pci 0000:17:14.5: [8086:208f] type 00 class 0x088000
[    1.665881] pci 0000:17:14.6: [8086:208f] type 00 class 0x088000
[    1.665881] pci 0000:17:14.7: [8086:208f] type 00 class 0x088000
[    1.665881] pci 0000:17:15.0: [8086:208f] type 00 class 0x088000
[    1.665881] pci 0000:17:15.1: [8086:208f] type 00 class 0x088000
[    1.665881] pci 0000:17:15.2: [8086:208f] type 00 class 0x088000
[    1.665881] pci 0000:17:15.3: [8086:208f] type 00 class 0x088000
[    1.665881] pci 0000:17:15.4: [8086:208f] type 00 class 0x088000
[    1.665881] pci 0000:17:15.5: [8086:208f] type 00 class 0x088000
[    1.665881] pci 0000:17:15.6: [8086:208f] type 00 class 0x088000
[    1.665881] pci 0000:17:15.7: [8086:208f] type 00 class 0x088000
[    1.665881] pci 0000:17:16.0: [8086:208f] type 00 class 0x088000
[    1.665881] pci 0000:17:16.1: [8086:208f] type 00 class 0x088000
[    1.665881] pci 0000:17:1d.0: [8086:2054] type 00 class 0x088000
[    1.665881] pci 0000:17:1d.1: [8086:2055] type 00 class 0x088000
[    1.665881] pci 0000:17:1d.2: [8086:2056] type 00 class 0x088000
[    1.665881] pci 0000:17:1d.3: [8086:2057] type 00 class 0x088000
[    1.665929] pci 0000:17:1e.0: [8086:2080] type 00 class 0x088000
[    1.665996] pci 0000:17:1e.1: [8086:2081] type 00 class 0x088000
[    1.666053] pci 0000:17:1e.2: [8086:2082] type 00 class 0x088000
[    1.666107] pci 0000:17:1e.3: [8086:2083] type 00 class 0x088000
[    1.666265] pci 0000:17:1e.4: [8086:2084] type 00 class 0x088000
[    1.666321] pci 0000:17:1e.5: [8086:2085] type 00 class 0x088000
[    1.666377] pci 0000:17:1e.6: [8086:2086] type 00 class 0x088000
[    1.666434] pci 0000:17:1f.0: [8086:2078] type 00 class 0x088000
[    1.666507] pci 0000:17:1f.1: [8086:2079] type 00 class 0x088000
[    1.666561] pci 0000:17:1f.2: [8086:207a] type 00 class 0x088000
[    1.666614] pci 0000:17:1f.3: [8086:207b] type 00 class 0x088000
[    1.666668] pci 0000:17:1f.4: [8086:207c] type 00 class 0x088000
[    1.666722] pci 0000:17:1f.5: [8086:207d] type 00 class 0x088000
[    1.666777] pci 0000:17:1f.6: [8086:207e] type 00 class 0x088000
[    1.666831] pci 0000:17:1f.7: [8086:207f] type 00 class 0x088000
[    1.666929] pci 0000:18:00.0: [8086:1528] type 00 class 0x020000
[    1.666948] pci 0000:18:00.0: reg 0x10: [mem 0xaa800000-0xaa9fffff 64bit pref]
[    1.666963] pci 0000:18:00.0: reg 0x20: [mem 0xaaa00000-0xaaa03fff 64bit pref]
[    1.666968] pci 0000:18:00.0: reg 0x30: [mem 0xaac00000-0xaac7ffff pref]
[    1.667020] pci 0000:18:00.0: PME# supported from D0 D3hot
[    1.667042] pci 0000:18:00.0: reg 0x184: [mem 0xaad80000-0xaad83fff 64bit]
[    1.667043] pci 0000:18:00.0: VF(n) BAR0 space: [mem 0xaad80000-0xaae7ffff 64bit] (contains BAR0 for 64 VFs)
[    1.667052] pci 0000:18:00.0: reg 0x190: [mem 0xaac80000-0xaac83fff 64bit]
[    1.667053] pci 0000:18:00.0: VF(n) BAR3 space: [mem 0xaac80000-0xaad7ffff 64bit] (contains BAR3 for 64 VFs)
[    1.667242] pci 0000:17:00.0: PCI bridge to [bus 18]
[    1.667245] pci 0000:17:00.0:   bridge window [mem 0xaac00000-0xaaefffff]
[    1.667247] pci 0000:17:00.0:   bridge window [mem 0xaa800000-0xaaafffff 64bit pref]
[    1.667254] pci_bus 0000:17: on NUMA node 0
[    1.667373] ACPI: PCI Root Bridge [PC02] (domain 0000 [bus 3a-5c])
[    1.667376] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.667724] acpi PNP0A08:02: _OSC: platform does not support [SHPCHotplug AER LTR]
[    1.667909] acpi PNP0A08:02: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    1.667910] acpi PNP0A08:02: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.668047] PCI host bridge to bus 0000:3a
[    1.668048] pci_bus 0000:3a: root bus resource [io  0x6000-0x7fff window]
[    1.668049] pci_bus 0000:3a: root bus resource [mem 0xab000000-0xb87fffff window]
[    1.668050] pci_bus 0000:3a: root bus resource [mem 0x388000000000-0x38bfffffffff window]
[    1.668051] pci_bus 0000:3a: root bus resource [bus 3a-5c]
[    1.668060] pci 0000:3a:00.0: [8086:2030] type 01 class 0x060400
[    1.668085] pci 0000:3a:00.0: enabling Extended Tags
[    1.668114] pci 0000:3a:00.0: PME# supported from D0 D3hot D3cold
[    1.669204] pci 0000:3a:01.0: [8086:2031] type 01 class 0x060400
[    1.669204] pci 0000:3a:01.0: enabling Extended Tags
[    1.669204] pci 0000:3a:01.0: PME# supported from D0 D3hot D3cold
[    1.669214] pci 0000:3a:02.0: [8086:2032] type 01 class 0x060400
[    1.669214] pci 0000:3a:02.0: enabling Extended Tags
[    1.669214] pci 0000:3a:02.0: PME# supported from D0 D3hot D3cold
[    1.669219] pci 0000:3a:03.0: [8086:2033] type 01 class 0x060400
[    1.669219] pci 0000:3a:03.0: enabling Extended Tags
[    1.669219] pci 0000:3a:03.0: PME# supported from D0 D3hot D3cold
[    1.669219] pci 0000:3a:05.0: [8086:2034] type 00 class 0x088000
[    1.669219] pci 0000:3a:05.2: [8086:2035] type 00 class 0x088000
[    1.669219] pci 0000:3a:05.4: [8086:2036] type 00 class 0x080020
[    1.669219] pci 0000:3a:05.4: reg 0x10: [mem 0xb8700000-0xb8700fff]
[    1.669219] pci 0000:3a:05.6: [8086:2037] type 00 class 0x110100
[    1.669219] pci 0000:3a:07.0: [8086:2038] type 00 class 0x088000
[    1.669219] pci 0000:3a:07.1: [8086:2039] type 00 class 0x088000
[    1.669219] pci 0000:3a:07.2: [8086:203a] type 00 class 0x088000
[    1.669219] pci 0000:3a:07.3: [8086:203b] type 00 class 0x088000
[    1.669219] pci 0000:3a:07.4: [8086:203c] type 00 class 0x088000
[    1.669288] pci 0000:3a:07.7: [8086:203d] type 00 class 0x088000
[    1.669356] pci 0000:3a:08.0: [8086:2066] type 00 class 0x088000
[    1.669432] pci 0000:3a:08.1: [8086:2067] type 00 class 0x088000
[    1.669486] pci 0000:3a:09.0: [8086:2066] type 00 class 0x088000
[    1.669559] pci 0000:3a:09.1: [8086:2067] type 00 class 0x088000
[    1.669612] pci 0000:3a:0a.0: [8086:2040] type 00 class 0x088000
[    1.669683] pci 0000:3a:0a.1: [8086:2041] type 00 class 0x088000
[    1.669743] pci 0000:3a:0a.2: [8086:2042] type 00 class 0x088000
[    1.669802] pci 0000:3a:0a.3: [8086:2043] type 00 class 0x088000
[    1.669863] pci 0000:3a:0a.4: [8086:2044] type 00 class 0x088000
[    1.669922] pci 0000:3a:0a.5: [8086:2045] type 00 class 0x088000
[    1.669983] pci 0000:3a:0a.6: [8086:2046] type 00 class 0x088000
[    1.670043] pci 0000:3a:0a.7: [8086:2047] type 00 class 0x088000
[    1.670103] pci 0000:3a:0b.0: [8086:2048] type 00 class 0x088000
[    1.670175] pci 0000:3a:0b.1: [8086:2049] type 00 class 0x088000
[    1.670234] pci 0000:3a:0b.2: [8086:204a] type 00 class 0x088000
[    1.670294] pci 0000:3a:0b.3: [8086:204b] type 00 class 0x088000
[    1.670355] pci 0000:3a:0c.0: [8086:2040] type 00 class 0x088000
[    1.670428] pci 0000:3a:0c.1: [8086:2041] type 00 class 0x088000
[    1.670490] pci 0000:3a:0c.2: [8086:2042] type 00 class 0x088000
[    1.670557] pci 0000:3a:0c.3: [8086:2043] type 00 class 0x088000
[    1.670618] pci 0000:3a:0c.4: [8086:2044] type 00 class 0x088000
[    1.670679] pci 0000:3a:0c.5: [8086:2045] type 00 class 0x088000
[    1.670738] pci 0000:3a:0c.6: [8086:2046] type 00 class 0x088000
[    1.670797] pci 0000:3a:0c.7: [8086:2047] type 00 class 0x088000
[    1.670861] pci 0000:3a:0d.0: [8086:2048] type 00 class 0x088000
[    1.670937] pci 0000:3a:0d.1: [8086:2049] type 00 class 0x088000
[    1.671000] pci 0000:3a:0d.2: [8086:204a] type 00 class 0x088000
[    1.671065] pci 0000:3a:0d.3: [8086:204b] type 00 class 0x088000
[    1.671170] pci 0000:3a:00.0: PCI bridge to [bus 3b]
[    1.671204] pci 0000:3a:01.0: PCI bridge to [bus 3c]
[    1.671247] pci 0000:3d:00.0: [144d:a808] type 00 class 0x010802
[    1.671267] pci 0000:3d:00.0: reg 0x10: [mem 0xb8600000-0xb8603fff 64bit]
[    1.671427] pci 0000:3a:02.0: PCI bridge to [bus 3d]
[    1.671430] pci 0000:3a:02.0:   bridge window [mem 0xb8600000-0xb86fffff]
[    1.672543] pci 0000:3e:00.0: [144d:a808] type 00 class 0x010802
[    1.672543] pci 0000:3e:00.0: reg 0x10: [mem 0xb8500000-0xb8503fff 64bit]
[    1.672543] pci 0000:3a:03.0: PCI bridge to [bus 3e]
[    1.672543] pci 0000:3a:03.0:   bridge window [mem 0xb8500000-0xb85fffff]
[    1.672543] pci_bus 0000:3a: on NUMA node 0
[    1.672543] ACPI: PCI Root Bridge [PC03] (domain 0000 [bus 5d-7f])
[    1.672543] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.672543] acpi PNP0A08:03: _OSC: platform does not support [SHPCHotplug AER LTR]
[    1.672543] acpi PNP0A08:03: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    1.672543] acpi PNP0A08:03: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.672543] PCI host bridge to bus 0000:5d
[    1.672543] pci_bus 0000:5d: root bus resource [io  0x8000-0x9fff window]
[    1.672543] pci_bus 0000:5d: root bus resource [mem 0xb8800000-0xc5ffffff window]
[    1.672543] pci_bus 0000:5d: root bus resource [mem 0x38c000000000-0x38ffffffffff window]
[    1.672543] pci_bus 0000:5d: root bus resource [bus 5d-7f]
[    1.672543] pci 0000:5d:02.0: [8086:2032] type 01 class 0x060400
[    1.672543] pci 0000:5d:02.0: enabling Extended Tags
[    1.672543] pci 0000:5d:02.0: PME# supported from D0 D3hot D3cold
[    1.672616] pci 0000:5d:03.0: [8086:2033] type 01 class 0x060400
[    1.672641] pci 0000:5d:03.0: enabling Extended Tags
[    1.672672] pci 0000:5d:03.0: PME# supported from D0 D3hot D3cold
[    1.672762] pci 0000:5d:05.0: [8086:2034] type 00 class 0x088000
[    1.672835] pci 0000:5d:05.2: [8086:2035] type 00 class 0x088000
[    1.672911] pci 0000:5d:05.4: [8086:2036] type 00 class 0x080020
[    1.672920] pci 0000:5d:05.4: reg 0x10: [mem 0xc4400000-0xc4400fff]
[    1.672997] pci 0000:5d:05.5: [8086:201d] type 00 class 0x010400
[    1.673008] pci 0000:5d:05.5: reg 0x10: [mem 0x38fffc000000-0x38fffdffffff 64bit pref]
[    1.673012] pci 0000:5d:05.5: reg 0x18: [mem 0xc2000000-0xc3ffffff]
[    1.673021] pci 0000:5d:05.5: reg 0x20: [mem 0x38fffff00000-0x38ffffffffff 64bit]
[    1.673076] pci 0000:5d:05.6: [8086:2037] type 00 class 0x110100
[    1.673150] pci 0000:5d:07.0: [8086:2038] type 00 class 0x088000
[    1.673223] pci 0000:5d:07.1: [8086:2039] type 00 class 0x088000
[    1.673293] pci 0000:5d:07.2: [8086:203a] type 00 class 0x088000
[    1.673363] pci 0000:5d:07.3: [8086:203b] type 00 class 0x088000
[    1.673435] pci 0000:5d:07.4: [8086:203c] type 00 class 0x088000
[    1.673510] pci 0000:5d:07.7: [8086:203d] type 00 class 0x088000
[    1.673584] pci 0000:5d:0e.0: [8086:2058] type 00 class 0x110100
[    1.673662] pci 0000:5d:0e.1: [8086:2059] type 00 class 0x088000
[    1.673720] pci 0000:5d:0e.2: [8086:205a] type 00 class 0x088000
[    1.673776] pci 0000:5d:0e.3: [8086:205b] type 00 class 0x088000
[    1.673835] pci 0000:5d:0f.0: [8086:2058] type 00 class 0x110100
[    1.673909] pci 0000:5d:0f.1: [8086:2059] type 00 class 0x088000
[    1.673968] pci 0000:5d:0f.2: [8086:205a] type 00 class 0x088000
[    1.674031] pci 0000:5d:12.0: [8086:204c] type 00 class 0x110100
[    1.674106] pci 0000:5d:12.1: [8086:204d] type 00 class 0x110100
[    1.674153] pci 0000:5d:12.2: [8086:204e] type 00 class 0x088000
[    1.674200] pci 0000:5d:12.3: [8086:204f] type 00 class 0x088000
[    1.674255] pci 0000:5d:15.0: [8086:2018] type 00 class 0x088000
[    1.674318] pci 0000:5d:15.1: [8086:2088] type 00 class 0x110100
[    1.674365] pci 0000:5d:15.3: [8086:2019] type 00 class 0x088000
[    1.674412] pci 0000:5d:16.0: [8086:2018] type 00 class 0x088000
[    1.674473] pci 0000:5d:16.1: [8086:2088] type 00 class 0x110100
[    1.674521] pci 0000:5d:16.3: [8086:2019] type 00 class 0x088000
[    1.674567] pci 0000:5d:16.4: [8086:2018] type 00 class 0x088000
[    1.674615] pci 0000:5d:16.5: [8086:2088] type 00 class 0x110100
[    1.674662] pci 0000:5d:16.7: [8086:2019] type 00 class 0x088000
[    1.675871] pci 0000:5e:00.0: [144d:a808] type 00 class 0x010802
[    1.675871] pci 0000:5e:00.0: reg 0x10: [mem 0xc4300000-0xc4303fff 64bit]
[    1.675875] pci 0000:5d:02.0: PCI bridge to [bus 5e]
[    1.675875] pci 0000:5d:02.0:   bridge window [mem 0xc4300000-0xc43fffff]
[    1.675875] pci 0000:5f:00.0: [8086:37c0] type 01 class 0x060400
[    1.675875] pci 0000:5f:00.0: reg 0x10: [mem 0xc4200000-0xc421ffff 64bit]
[    1.675875] pci 0000:5f:00.0: reg 0x38: [mem 0xc4000000-0xc40fffff pref]
[    1.675875] pci 0000:5f:00.0: PME# supported from D0 D3hot D3cold
[    1.675875] pci 0000:5d:03.0: PCI bridge to [bus 5f-61]
[    1.675875] pci 0000:5d:03.0:   bridge window [mem 0xc4000000-0xc42fffff]
[    1.675875] pci 0000:5d:03.0:   bridge window [mem 0xbf000000-0xc19fffff 64bit pref]
[    1.675875] pci 0000:60:03.0: [8086:37c5] type 01 class 0x060400
[    1.675875] pci 0000:60:03.0: PME# supported from D0 D3hot D3cold
[    1.675875] pci 0000:5f:00.0: PCI bridge to [bus 60-61]
[    1.675875] pci 0000:5f:00.0:   bridge window [mem 0xc4100000-0xc41fffff]
[    1.675875] pci 0000:5f:00.0:   bridge window [mem 0xbf000000-0xc19fffff 64bit pref]
[    1.675875] pci 0000:61:00.0: [8086:37d1] type 00 class 0x020000
[    1.675875] pci 0000:61:00.0: reg 0x10: [mem 0xc0000000-0xc0ffffff 64bit pref]
[    1.675875] pci 0000:61:00.0: reg 0x1c: [mem 0xc1808000-0xc180ffff 64bit pref]
[    1.675875] pci 0000:61:00.0: reg 0x30: [mem 0xc4180000-0xc41fffff pref]
[    1.675875] pci 0000:61:00.0: enabling Extended Tags
[    1.675875] pci 0000:61:00.0: PME# supported from D0 D3hot D3cold
[    1.675875] pci 0000:61:00.0: reg 0x184: [mem 0xc1400000-0xc141ffff 64bit pref]
[    1.675875] pci 0000:61:00.0: VF(n) BAR0 space: [mem 0xc1400000-0xc17fffff 64bit pref] (contains BAR0 for 32 VFs)
[    1.675875] pci 0000:61:00.0: reg 0x190: [mem 0xc1890000-0xc1893fff 64bit pref]
[    1.675875] pci 0000:61:00.0: VF(n) BAR3 space: [mem 0xc1890000-0xc190ffff 64bit pref] (contains BAR3 for 32 VFs)
[    1.675875] pci 0000:61:00.1: [8086:37d1] type 00 class 0x020000
[    1.675875] pci 0000:61:00.1: reg 0x10: [mem 0xbf000000-0xbfffffff 64bit pref]
[    1.675875] pci 0000:61:00.1: reg 0x1c: [mem 0xc1800000-0xc1807fff 64bit pref]
[    1.675875] pci 0000:61:00.1: reg 0x30: [mem 0xc4100000-0xc417ffff pref]
[    1.675875] pci 0000:61:00.1: enabling Extended Tags
[    1.675875] pci 0000:61:00.1: PME# supported from D0 D3hot D3cold
[    1.675875] pci 0000:61:00.1: reg 0x184: [mem 0xc1000000-0xc101ffff 64bit pref]
[    1.675875] pci 0000:61:00.1: VF(n) BAR0 space: [mem 0xc1000000-0xc13fffff 64bit pref] (contains BAR0 for 32 VFs)
[    1.675875] pci 0000:61:00.1: reg 0x190: [mem 0xc1810000-0xc1813fff 64bit pref]
[    1.675875] pci 0000:61:00.1: VF(n) BAR3 space: [mem 0xc1810000-0xc188ffff 64bit pref] (contains BAR3 for 32 VFs)
[    1.675999] pci 0000:60:03.0: PCI bridge to [bus 61]
[    1.676003] pci 0000:60:03.0:   bridge window [mem 0xc4100000-0xc41fffff]
[    1.676007] pci 0000:60:03.0:   bridge window [mem 0xbf000000-0xc19fffff 64bit pref]
[    1.676024] pci_bus 0000:5d: on NUMA node 0
[    1.676175] ACPI: PCI Root Bridge [PC06] (domain 0000 [bus 80-84])
[    1.676178] acpi PNP0A08:06: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.676373] acpi PNP0A08:06: _OSC: platform does not support [SHPCHotplug AER LTR]
[    1.676513] acpi PNP0A08:06: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    1.676514] acpi PNP0A08:06: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.676642] PCI host bridge to bus 0000:80
[    1.676643] pci_bus 0000:80: root bus resource [io  0xa000-0xbfff window]
[    1.676644] pci_bus 0000:80: root bus resource [mem 0xc6000000-0xd37fffff window]
[    1.676646] pci_bus 0000:80: root bus resource [mem 0x390000000000-0x393fffffffff window]
[    1.676647] pci_bus 0000:80: root bus resource [bus 80-84]
[    1.676663] pci 0000:80:00.0: [8086:2030] type 01 class 0x060400
[    1.676690] pci 0000:80:00.0: enabling Extended Tags
[    1.676725] pci 0000:80:00.0: PME# supported from D0 D3hot D3cold
[    1.676823] pci 0000:80:04.0: [8086:2021] type 00 class 0x088000
[    1.676834] pci 0000:80:04.0: reg 0x10: [mem 0x393ffff1c000-0x393ffff1ffff 64bit]
[    1.676923] pci 0000:80:04.1: [8086:2021] type 00 class 0x088000
[    1.676934] pci 0000:80:04.1: reg 0x10: [mem 0x393ffff18000-0x393ffff1bfff 64bit]
[    1.677020] pci 0000:80:04.2: [8086:2021] type 00 class 0x088000
[    1.677030] pci 0000:80:04.2: reg 0x10: [mem 0x393ffff14000-0x393ffff17fff 64bit]
[    1.677120] pci 0000:80:04.3: [8086:2021] type 00 class 0x088000
[    1.677130] pci 0000:80:04.3: reg 0x10: [mem 0x393ffff10000-0x393ffff13fff 64bit]
[    1.677220] pci 0000:80:04.4: [8086:2021] type 00 class 0x088000
[    1.677230] pci 0000:80:04.4: reg 0x10: [mem 0x393ffff0c000-0x393ffff0ffff 64bit]
[    1.677318] pci 0000:80:04.5: [8086:2021] type 00 class 0x088000
[    1.677328] pci 0000:80:04.5: reg 0x10: [mem 0x393ffff08000-0x393ffff0bfff 64bit]
[    1.677415] pci 0000:80:04.6: [8086:2021] type 00 class 0x088000
[    1.677425] pci 0000:80:04.6: reg 0x10: [mem 0x393ffff04000-0x393ffff07fff 64bit]
[    1.677509] pci 0000:80:04.7: [8086:2021] type 00 class 0x088000
[    1.677519] pci 0000:80:04.7: reg 0x10: [mem 0x393ffff00000-0x393ffff03fff 64bit]
[    1.677604] pci 0000:80:05.0: [8086:2024] type 00 class 0x088000
[    1.677679] pci 0000:80:05.1: [8086:2022] type 00 class 0x088000
[    1.677781] pci 0000:80:05.2: [8086:2025] type 00 class 0x088000
[    1.677860] pci 0000:80:05.4: [8086:2026] type 00 class 0x080020
[    1.677869] pci 0000:80:05.4: reg 0x10: [mem 0xd3700000-0xd3700fff]
[    1.677949] pci 0000:80:05.6: [8086:2027] type 00 class 0x110100
[    1.679195] pci 0000:80:07.0: [8086:2028] type 00 class 0x088000
[    1.679205] pci 0000:80:07.4: [8086:202c] type 00 class 0x088000
[    1.679205] pci 0000:80:07.7: [8086:202d] type 00 class 0x088000
[    1.679205] pci 0000:80:08.0: [8086:2014] type 00 class 0x088000
[    1.679205] pci 0000:80:08.1: [8086:2015] type 00 class 0x110100
[    1.679205] pci 0000:80:08.2: [8086:2016] type 00 class 0x088000
[    1.679205] pci 0000:80:00.0: PCI bridge to [bus 81]
[    1.679205] pci_bus 0000:80: on NUMA node 1
[    1.679205] ACPI: PCI Root Bridge [PC07] (domain 0000 [bus 85-ad])
[    1.679205] acpi PNP0A08:07: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.679205] acpi PNP0A08:07: _OSC: platform does not support [SHPCHotplug AER LTR]
[    1.679205] acpi PNP0A08:07: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    1.679205] acpi PNP0A08:07: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.679307] PCI host bridge to bus 0000:85
[    1.679308] pci_bus 0000:85: root bus resource [io  0xc000-0xdfff window]
[    1.679310] pci_bus 0000:85: root bus resource [mem 0xd3800000-0xe0ffffff window]
[    1.679311] pci_bus 0000:85: root bus resource [mem 0x394000000000-0x397fffffffff window]
[    1.679312] pci_bus 0000:85: root bus resource [bus 85-ad]
[    1.679321] pci 0000:85:00.0: [8086:2030] type 01 class 0x060400
[    1.679349] pci 0000:85:00.0: enabling Extended Tags
[    1.679384] pci 0000:85:00.0: PME# supported from D0 D3hot D3cold
[    1.679508] pci 0000:85:02.0: [8086:2032] type 01 class 0x060400
[    1.679536] pci 0000:85:02.0: enabling Extended Tags
[    1.679570] pci 0000:85:02.0: PME# supported from D0 D3hot D3cold
[    1.679684] pci 0000:85:05.0: [8086:2034] type 00 class 0x088000
[    1.679770] pci 0000:85:05.2: [8086:2035] type 00 class 0x088000
[    1.679852] pci 0000:85:05.4: [8086:2036] type 00 class 0x080020
[    1.679860] pci 0000:85:05.4: reg 0x10: [mem 0xe0f00000-0xe0f00fff]
[    1.679945] pci 0000:85:05.6: [8086:2037] type 00 class 0x110100
[    1.680027] pci 0000:85:07.0: [8086:2038] type 00 class 0x088000
[    1.680107] pci 0000:85:07.1: [8086:2039] type 00 class 0x088000
[    1.680188] pci 0000:85:07.2: [8086:203a] type 00 class 0x088000
[    1.680271] pci 0000:85:07.3: [8086:203b] type 00 class 0x088000
[    1.680351] pci 0000:85:07.4: [8086:203c] type 00 class 0x088000
[    1.680432] pci 0000:85:07.7: [8086:203d] type 00 class 0x088000
[    1.680509] pci 0000:85:08.0: [8086:208d] type 00 class 0x088000
[    1.680578] pci 0000:85:08.1: [8086:208d] type 00 class 0x088000
[    1.680634] pci 0000:85:08.2: [8086:208d] type 00 class 0x088000
[    1.680693] pci 0000:85:08.3: [8086:208d] type 00 class 0x088000
[    1.680749] pci 0000:85:08.4: [8086:208d] type 00 class 0x088000
[    1.680805] pci 0000:85:08.5: [8086:208d] type 00 class 0x088000
[    1.680861] pci 0000:85:08.6: [8086:208d] type 00 class 0x088000
[    1.680918] pci 0000:85:08.7: [8086:208d] type 00 class 0x088000
[    1.680974] pci 0000:85:09.0: [8086:208d] type 00 class 0x088000
[    1.681042] pci 0000:85:09.1: [8086:208d] type 00 class 0x088000
[    1.681098] pci 0000:85:09.2: [8086:208d] type 00 class 0x088000
[    1.681154] pci 0000:85:09.3: [8086:208d] type 00 class 0x088000
[    1.681210] pci 0000:85:09.4: [8086:208d] type 00 class 0x088000
[    1.681267] pci 0000:85:09.5: [8086:208d] type 00 class 0x088000
[    1.681323] pci 0000:85:09.6: [8086:208d] type 00 class 0x088000
[    1.682540] pci 0000:85:09.7: [8086:208d] type 00 class 0x088000
[    1.682542] pci 0000:85:0a.0: [8086:208d] type 00 class 0x088000
[    1.682542] pci 0000:85:0a.1: [8086:208d] type 00 class 0x088000
[    1.682542] pci 0000:85:0e.0: [8086:208e] type 00 class 0x088000
[    1.682542] pci 0000:85:0e.1: [8086:208e] type 00 class 0x088000
[    1.682542] pci 0000:85:0e.2: [8086:208e] type 00 class 0x088000
[    1.682542] pci 0000:85:0e.3: [8086:208e] type 00 class 0x088000
[    1.682542] pci 0000:85:0e.4: [8086:208e] type 00 class 0x088000
[    1.682542] pci 0000:85:0e.5: [8086:208e] type 00 class 0x088000
[    1.682542] pci 0000:85:0e.6: [8086:208e] type 00 class 0x088000
[    1.682542] pci 0000:85:0e.7: [8086:208e] type 00 class 0x088000
[    1.682542] pci 0000:85:0f.0: [8086:208e] type 00 class 0x088000
[    1.682542] pci 0000:85:0f.1: [8086:208e] type 00 class 0x088000
[    1.682542] pci 0000:85:0f.2: [8086:208e] type 00 class 0x088000
[    1.682542] pci 0000:85:0f.3: [8086:208e] type 00 class 0x088000
[    1.682542] pci 0000:85:0f.4: [8086:208e] type 00 class 0x088000
[    1.682542] pci 0000:85:0f.5: [8086:208e] type 00 class 0x088000
[    1.682542] pci 0000:85:0f.6: [8086:208e] type 00 class 0x088000
[    1.682542] pci 0000:85:0f.7: [8086:208e] type 00 class 0x088000
[    1.682542] pci 0000:85:10.0: [8086:208e] type 00 class 0x088000
[    1.682553] pci 0000:85:10.1: [8086:208e] type 00 class 0x088000
[    1.682618] pci 0000:85:14.0: [8086:208f] type 00 class 0x088000
[    1.682687] pci 0000:85:14.1: [8086:208f] type 00 class 0x088000
[    1.682743] pci 0000:85:14.2: [8086:208f] type 00 class 0x088000
[    1.682799] pci 0000:85:14.3: [8086:208f] type 00 class 0x088000
[    1.682854] pci 0000:85:14.4: [8086:208f] type 00 class 0x088000
[    1.682909] pci 0000:85:14.5: [8086:208f] type 00 class 0x088000
[    1.682964] pci 0000:85:14.6: [8086:208f] type 00 class 0x088000
[    1.683021] pci 0000:85:14.7: [8086:208f] type 00 class 0x088000
[    1.683077] pci 0000:85:15.0: [8086:208f] type 00 class 0x088000
[    1.683146] pci 0000:85:15.1: [8086:208f] type 00 class 0x088000
[    1.683204] pci 0000:85:15.2: [8086:208f] type 00 class 0x088000
[    1.683259] pci 0000:85:15.3: [8086:208f] type 00 class 0x088000
[    1.683318] pci 0000:85:15.4: [8086:208f] type 00 class 0x088000
[    1.683373] pci 0000:85:15.5: [8086:208f] type 00 class 0x088000
[    1.683429] pci 0000:85:15.6: [8086:208f] type 00 class 0x088000
[    1.683484] pci 0000:85:15.7: [8086:208f] type 00 class 0x088000
[    1.683541] pci 0000:85:16.0: [8086:208f] type 00 class 0x088000
[    1.683610] pci 0000:85:16.1: [8086:208f] type 00 class 0x088000
[    1.683677] pci 0000:85:1d.0: [8086:2054] type 00 class 0x088000
[    1.683745] pci 0000:85:1d.1: [8086:2055] type 00 class 0x088000
[    1.683801] pci 0000:85:1d.2: [8086:2056] type 00 class 0x088000
[    1.683857] pci 0000:85:1d.3: [8086:2057] type 00 class 0x088000
[    1.683916] pci 0000:85:1e.0: [8086:2080] type 00 class 0x088000
[    1.683986] pci 0000:85:1e.1: [8086:2081] type 00 class 0x088000
[    1.684043] pci 0000:85:1e.2: [8086:2082] type 00 class 0x088000
[    1.684100] pci 0000:85:1e.3: [8086:2083] type 00 class 0x088000
[    1.684159] pci 0000:85:1e.4: [8086:2084] type 00 class 0x088000
[    1.684215] pci 0000:85:1e.5: [8086:2085] type 00 class 0x088000
[    1.684271] pci 0000:85:1e.6: [8086:2086] type 00 class 0x088000
[    1.684327] pci 0000:85:1f.0: [8086:2078] type 00 class 0x088000
[    1.684396] pci 0000:85:1f.1: [8086:2079] type 00 class 0x088000
[    1.684454] pci 0000:85:1f.2: [8086:207a] type 00 class 0x088000
[    1.684510] pci 0000:85:1f.3: [8086:207b] type 00 class 0x088000
[    1.684567] pci 0000:85:1f.4: [8086:207c] type 00 class 0x088000
[    1.684627] pci 0000:85:1f.5: [8086:207d] type 00 class 0x088000
[    1.685861] pci 0000:85:1f.6: [8086:207e] type 00 class 0x088000
[    1.685872] pci 0000:85:1f.7: [8086:207f] type 00 class 0x088000
[    1.685877] pci 0000:85:00.0: PCI bridge to [bus 86]
[    1.685877] pci 0000:85:02.0: PCI bridge to [bus 87]
[    1.685877] pci_bus 0000:85: on NUMA node 1
[    1.685877] ACPI: PCI Root Bridge [PC08] (domain 0000 [bus ae-d6])
[    1.685877] acpi PNP0A08:08: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.685877] acpi PNP0A08:08: _OSC: platform does not support [SHPCHotplug AER LTR]
[    1.685877] acpi PNP0A08:08: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    1.685877] acpi PNP0A08:08: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.685877] PCI host bridge to bus 0000:ae
[    1.685877] pci_bus 0000:ae: root bus resource [io  0xe000-0xefff window]
[    1.685877] pci_bus 0000:ae: root bus resource [mem 0xe1000000-0xee7fffff window]
[    1.685877] pci_bus 0000:ae: root bus resource [mem 0x398000000000-0x39bfffffffff window]
[    1.685877] pci_bus 0000:ae: root bus resource [bus ae-d6]
[    1.685877] pci 0000:ae:00.0: [8086:2030] type 01 class 0x060400
[    1.685877] pci 0000:ae:00.0: PME# supported from D0 D3hot D3cold
[    1.685877] pci 0000:ae:05.0: [8086:2034] type 00 class 0x088000
[    1.685948] pci 0000:ae:05.2: [8086:2035] type 00 class 0x088000
[    1.686022] pci 0000:ae:05.4: [8086:2036] type 00 class 0x080020
[    1.686031] pci 0000:ae:05.4: reg 0x10: [mem 0xee700000-0xee700fff]
[    1.686108] pci 0000:ae:05.6: [8086:2037] type 00 class 0x110100
[    1.686183] pci 0000:ae:07.0: [8086:2038] type 00 class 0x088000
[    1.686255] pci 0000:ae:07.1: [8086:2039] type 00 class 0x088000
[    1.686328] pci 0000:ae:07.2: [8086:203a] type 00 class 0x088000
[    1.686399] pci 0000:ae:07.3: [8086:203b] type 00 class 0x088000
[    1.686473] pci 0000:ae:07.4: [8086:203c] type 00 class 0x088000
[    1.686546] pci 0000:ae:07.7: [8086:203d] type 00 class 0x088000
[    1.686618] pci 0000:ae:08.0: [8086:2066] type 00 class 0x088000
[    1.686694] pci 0000:ae:08.1: [8086:2067] type 00 class 0x088000
[    1.686748] pci 0000:ae:09.0: [8086:2066] type 00 class 0x088000
[    1.686820] pci 0000:ae:09.1: [8086:2067] type 00 class 0x088000
[    1.686875] pci 0000:ae:0a.0: [8086:2040] type 00 class 0x088000
[    1.686951] pci 0000:ae:0a.1: [8086:2041] type 00 class 0x088000
[    1.687016] pci 0000:ae:0a.2: [8086:2042] type 00 class 0x088000
[    1.687085] pci 0000:ae:0a.3: [8086:2043] type 00 class 0x088000
[    1.687150] pci 0000:ae:0a.4: [8086:2044] type 00 class 0x088000
[    1.687215] pci 0000:ae:0a.5: [8086:2045] type 00 class 0x088000
[    1.687279] pci 0000:ae:0a.6: [8086:2046] type 00 class 0x088000
[    1.687343] pci 0000:ae:0a.7: [8086:2047] type 00 class 0x088000
[    1.687407] pci 0000:ae:0b.0: [8086:2048] type 00 class 0x088000
[    1.687485] pci 0000:ae:0b.1: [8086:2049] type 00 class 0x088000
[    1.687552] pci 0000:ae:0b.2: [8086:204a] type 00 class 0x088000
[    1.687618] pci 0000:ae:0b.3: [8086:204b] type 00 class 0x088000
[    1.687685] pci 0000:ae:0c.0: [8086:2040] type 00 class 0x088000
[    1.687762] pci 0000:ae:0c.1: [8086:2041] type 00 class 0x088000
[    1.687827] pci 0000:ae:0c.2: [8086:2042] type 00 class 0x088000
[    1.687893] pci 0000:ae:0c.3: [8086:2043] type 00 class 0x088000
[    1.687959] pci 0000:ae:0c.4: [8086:2044] type 00 class 0x088000
[    1.688024] pci 0000:ae:0c.5: [8086:2045] type 00 class 0x088000
[    1.689206] pci 0000:ae:0c.6: [8086:2046] type 00 class 0x088000
[    1.689206] pci 0000:ae:0c.7: [8086:2047] type 00 class 0x088000
[    1.689206] pci 0000:ae:0d.0: [8086:2048] type 00 class 0x088000
[    1.689206] pci 0000:ae:0d.1: [8086:2049] type 00 class 0x088000
[    1.689206] pci 0000:ae:0d.2: [8086:204a] type 00 class 0x088000
[    1.689207] pci 0000:ae:0d.3: [8086:204b] type 00 class 0x088000
[    1.689207] pci 0000:af:00.0: [1002:1478] type 01 class 0x060400
[    1.689207] pci 0000:af:00.0: reg 0x10: [mem 0xee600000-0xee603fff]
[    1.689207] pci 0000:af:00.0: PME# supported from D0 D3hot D3cold
[    1.689207] pci 0000:af:00.0: 63.008 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x8 link at 0000:ae:00.0 (capable of 126.024 Gb/s with 16.0 GT/s PCIe x8 link)
[    1.689212] pci 0000:ae:00.0: PCI bridge to [bus af-b1]
[    1.689212] pci 0000:ae:00.0:   bridge window [io  0xe000-0xefff]
[    1.689212] pci 0000:ae:00.0:   bridge window [mem 0xee500000-0xee6fffff]
[    1.689212] pci 0000:ae:00.0:   bridge window [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.689212] pci 0000:b0:00.0: [1002:1479] type 01 class 0x060400
[    1.689212] pci 0000:b0:00.0: PME# supported from D0 D3hot D3cold
[    1.689212] pci 0000:af:00.0: PCI bridge to [bus b0-b1]
[    1.689212] pci 0000:af:00.0:   bridge window [io  0xe000-0xefff]
[    1.689212] pci 0000:af:00.0:   bridge window [mem 0xee500000-0xee5fffff]
[    1.689212] pci 0000:af:00.0:   bridge window [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.689212] pci 0000:b1:00.0: [1002:7340] type 00 class 0x030000
[    1.689212] pci 0000:b1:00.0: reg 0x10: [mem 0x39bfe0000000-0x39bfefffffff 64bit pref]
[    1.689212] pci 0000:b1:00.0: reg 0x18: [mem 0x39bff0000000-0x39bff01fffff 64bit pref]
[    1.689212] pci 0000:b1:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    1.689212] pci 0000:b1:00.0: reg 0x24: [mem 0xee500000-0xee57ffff]
[    1.689212] pci 0000:b1:00.0: reg 0x30: [mem 0xee580000-0xee59ffff pref]
[    1.689212] pci 0000:b1:00.0: BAR 0: assigned to efifb
[    1.689259] pci 0000:b1:00.0: PME# supported from D1 D2 D3hot D3cold
[    1.689325] pci 0000:b1:00.0: 63.008 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x8 link at 0000:ae:00.0 (capable of 252.048 Gb/s with 16.0 GT/s PCIe x16 link)
[    1.689368] pci 0000:b1:00.1: [1002:ab38] type 00 class 0x040300
[    1.689384] pci 0000:b1:00.1: reg 0x10: [mem 0xee5a0000-0xee5a3fff]
[    1.689462] pci 0000:b1:00.1: PME# supported from D1 D2 D3hot D3cold
[    1.689562] pci 0000:b0:00.0: PCI bridge to [bus b1]
[    1.689566] pci 0000:b0:00.0:   bridge window [io  0xe000-0xefff]
[    1.689569] pci 0000:b0:00.0:   bridge window [mem 0xee500000-0xee5fffff]
[    1.689573] pci 0000:b0:00.0:   bridge window [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.689589] pci_bus 0000:ae: on NUMA node 1
[    1.689686] ACPI: PCI Root Bridge [PC09] (domain 0000 [bus d7-ff])
[    1.689688] acpi PNP0A08:09: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.690031] acpi PNP0A08:09: _OSC: platform does not support [SHPCHotplug AER LTR]
[    1.690217] acpi PNP0A08:09: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    1.690217] acpi PNP0A08:09: FADT indicates ASPM is unsupported, using BIOS configuration
[    1.690375] PCI host bridge to bus 0000:d7
[    1.690376] pci_bus 0000:d7: root bus resource [io  0xf000-0xffff window]
[    1.690377] pci_bus 0000:d7: root bus resource [mem 0xee800000-0xfbffffff window]
[    1.690379] pci_bus 0000:d7: root bus resource [mem 0x39c000000000-0x39ffffffffff window]
[    1.690380] pci_bus 0000:d7: root bus resource [bus d7-ff]
[    1.690389] pci 0000:d7:00.0: [8086:2030] type 01 class 0x060400
[    1.690418] pci 0000:d7:00.0: enabling Extended Tags
[    1.690453] pci 0000:d7:00.0: PME# supported from D0 D3hot D3cold
[    1.690567] pci 0000:d7:05.0: [8086:2034] type 00 class 0x088000
[    1.690647] pci 0000:d7:05.2: [8086:2035] type 00 class 0x088000
[    1.690722] pci 0000:d7:05.4: [8086:2036] type 00 class 0x080020
[    1.690731] pci 0000:d7:05.4: reg 0x10: [mem 0xfbf00000-0xfbf00fff]
[    1.690813] pci 0000:d7:05.6: [8086:2037] type 00 class 0x110100
[    1.690889] pci 0000:d7:07.0: [8086:2038] type 00 class 0x088000
[    1.690969] pci 0000:d7:07.1: [8086:2039] type 00 class 0x088000
[    1.691045] pci 0000:d7:07.2: [8086:203a] type 00 class 0x088000
[    1.691120] pci 0000:d7:07.3: [8086:203b] type 00 class 0x088000
[    1.691196] pci 0000:d7:07.4: [8086:203c] type 00 class 0x088000
[    1.691270] pci 0000:d7:07.7: [8086:203d] type 00 class 0x088000
[    1.691347] pci 0000:d7:0e.0: [8086:2058] type 00 class 0x110100
[    1.692539] pci 0000:d7:0e.1: [8086:2059] type 00 class 0x088000
[    1.692539] pci 0000:d7:0e.2: [8086:205a] type 00 class 0x088000
[    1.692539] pci 0000:d7:0e.3: [8086:205b] type 00 class 0x088000
[    1.692539] pci 0000:d7:0f.0: [8086:2058] type 00 class 0x110100
[    1.692539] pci 0000:d7:0f.1: [8086:2059] type 00 class 0x088000
[    1.692546] pci 0000:d7:0f.2: [8086:205a] type 00 class 0x088000
[    1.692546] pci 0000:d7:12.0: [8086:204c] type 00 class 0x110100
[    1.692546] pci 0000:d7:12.1: [8086:204d] type 00 class 0x110100
[    1.692546] pci 0000:d7:12.2: [8086:204e] type 00 class 0x088000
[    1.692546] pci 0000:d7:12.3: [8086:204f] type 00 class 0x088000
[    1.692546] pci 0000:d7:15.0: [8086:2018] type 00 class 0x088000
[    1.692546] pci 0000:d7:15.1: [8086:2088] type 00 class 0x110100
[    1.692546] pci 0000:d7:15.3: [8086:2019] type 00 class 0x088000
[    1.692546] pci 0000:d7:16.0: [8086:2018] type 00 class 0x088000
[    1.692546] pci 0000:d7:16.1: [8086:2088] type 00 class 0x110100
[    1.692546] pci 0000:d7:16.3: [8086:2019] type 00 class 0x088000
[    1.692546] pci 0000:d7:16.4: [8086:2018] type 00 class 0x088000
[    1.692547] pci 0000:d7:16.5: [8086:2088] type 00 class 0x110100
[    1.692547] pci 0000:d7:16.7: [8086:2019] type 00 class 0x088000
[    1.692611] pci 0000:d8:00.0: [8086:24fd] type 00 class 0x028000
[    1.692651] pci 0000:d8:00.0: reg 0x10: [mem 0xfbe00000-0xfbe01fff 64bit]
[    1.692804] pci 0000:d8:00.0: PME# supported from D0 D3hot D3cold
[    1.692962] pci 0000:d7:00.0: PCI bridge to [bus d8]
[    1.692965] pci 0000:d7:00.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    1.692974] pci_bus 0000:d7: on NUMA node 1
[    1.693333] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    1.693379] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[    1.693424] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.693468] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.693511] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    1.693555] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    1.693599] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    1.693643] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    1.694022] iommu: Default domain type: Translated
[    1.694035] pci 0000:04:00.0: vgaarb: setting as boot VGA device
[    1.694035] pci 0000:04:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.694035] pci 0000:b1:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    1.694035] pci 0000:04:00.0: vgaarb: bridge control possible
[    1.694035] pci 0000:b1:00.0: vgaarb: bridge control possible
[    1.694035] pci 0000:b1:00.0: vgaarb: overriding boot device
[    1.694035] vgaarb: loaded
[    1.694035] SCSI subsystem initialized
[    1.694035] libata version 3.00 loaded.
[    1.694035] ACPI: bus type USB registered
[    1.694035] usbcore: registered new interface driver usbfs
[    1.694035] usbcore: registered new interface driver hub
[    1.694035] usbcore: registered new device driver usb
[    1.694035] mc: Linux media interface: v0.10
[    1.694035] videodev: Linux video capture interface: v2.00
[    1.694035] pps_core: LinuxPPS API ver. 1 registered
[    1.694035] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.694035] PTP clock support registered
[    1.695861] EDAC MC: Ver: 3.0.0
[    1.695932] Registered efivars operations
[    1.695975] Advanced Linux Sound Architecture Driver Initialized.
[    1.695975] PCI: Using ACPI for IRQ routing
[    1.699145] PCI: pci_cache_line_size set to 64 bytes
[    1.699583] e820: reserve RAM buffer [mem 0x0003e000-0x0003ffff]
[    1.699585] e820: reserve RAM buffer [mem 0x64261000-0x67ffffff]
[    1.699586] e820: reserve RAM buffer [mem 0x69eb6000-0x6bffffff]
[    1.699586] e820: reserve RAM buffer [mem 0x6c4ee000-0x6fffffff]
[    1.699715] Bluetooth: Core ver 2.22
[    1.699721] NET: Registered protocol family 31
[    1.699721] Bluetooth: HCI device and connection manager initialized
[    1.699722] Bluetooth: HCI socket layer initialized
[    1.699723] Bluetooth: L2CAP socket layer initialized
[    1.699725] Bluetooth: SCO socket layer initialized
[    1.699733] NetLabel: Initializing
[    1.699733] NetLabel:  domain hash size = 128
[    1.699734] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.699746] NetLabel:  unlabeled traffic allowed by default
[    1.699946] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.699949] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    1.702610] clocksource: Switched to clocksource tsc-early
[    1.735473] VFS: Disk quotas dquot_6.6.0
[    1.735531] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.735590] FS-Cache: Loaded
[    1.735720] CacheFiles: Loaded
[    1.735748] pnp: PnP ACPI init
[    1.739086] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.739455] system 00:01: [io  0x0500-0x05fe] has been reserved
[    1.739456] system 00:01: [io  0x0400-0x047f] has been reserved
[    1.739457] system 00:01: [io  0x0600-0x061f] has been reserved
[    1.739459] system 00:01: [io  0x0880-0x0883] has been reserved
[    1.739460] system 00:01: [io  0x0800-0x081f] has been reserved
[    1.739464] system 00:01: [mem 0xfed1c000-0xfed3ffff] could not be reserved
[    1.739465] system 00:01: [mem 0xfed45000-0xfed8bfff] has been reserved
[    1.739466] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
[    1.739467] system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
[    1.739468] system 00:01: [mem 0xfed12000-0xfed1200f] has been reserved
[    1.739469] system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
[    1.739470] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
[    1.739476] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.740000] system 00:02: [io  0x0a00-0x0a0f] has been reserved
[    1.740001] system 00:02: [io  0x0a10-0x0a1f] has been reserved
[    1.740002] system 00:02: [io  0x0a20-0x0a2f] has been reserved
[    1.740003] system 00:02: [io  0x0a30-0x0a3f] has been reserved
[    1.740004] system 00:02: [io  0x0a40-0x0a4f] has been reserved
[    1.740011] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.740257] pnp 00:03: [dma 0 disabled]
[    1.740293] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.740563] system 00:04: [mem 0xfd000000-0xfdabffff] has been reserved
[    1.740566] system 00:04: [mem 0xfdad0000-0xfdadffff] has been reserved
[    1.740567] system 00:04: [mem 0xfdb00000-0xfdffffff] has been reserved
[    1.740568] system 00:04: [mem 0xfe000000-0xfe00ffff] has been reserved
[    1.740569] system 00:04: [mem 0xfe011000-0xfe01ffff] has been reserved
[    1.740570] system 00:04: [mem 0xfe036000-0xfe03bfff] has been reserved
[    1.740571] system 00:04: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    1.740573] system 00:04: [mem 0xfe410000-0xfe7fffff] has been reserved
[    1.740578] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.740931] system 00:05: [io  0x0f00-0x0ffe] has been reserved
[    1.740937] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.741668] pnp: PnP ACPI: found 6 devices
[    1.747788] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.747861] pci 0000:00:1f.4: BAR 0: assigned [mem 0x380000000000-0x3800000000ff 64bit]
[    1.747871] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    1.747879] pci 0000:00:1c.2: PCI bridge to [bus 02]
[    1.747883] pci 0000:00:1c.2:   bridge window [mem 0x9d100000-0x9d1fffff]
[    1.747889] pci 0000:03:00.0: PCI bridge to [bus 04]
[    1.747891] pci 0000:03:00.0:   bridge window [io  0x2000-0x2fff]
[    1.747896] pci 0000:03:00.0:   bridge window [mem 0x9c000000-0x9d0fffff]
[    1.747904] pci 0000:00:1c.5: PCI bridge to [bus 03-04]
[    1.747906] pci 0000:00:1c.5:   bridge window [io  0x2000-0x2fff]
[    1.747909] pci 0000:00:1c.5:   bridge window [mem 0x9c000000-0x9d0fffff]
[    1.747915] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    1.747916] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    1.747917] pci_bus 0000:00: resource 6 [io  0x03b0-0x03bb window]
[    1.747918] pci_bus 0000:00: resource 7 [io  0x03c0-0x03df window]
[    1.747919] pci_bus 0000:00: resource 8 [io  0x1000-0x3fff window]
[    1.747920] pci_bus 0000:00: resource 9 [mem 0x000a0000-0x000bffff window]
[    1.747921] pci_bus 0000:00: resource 10 [mem 0x000c4000-0x000c7fff window]
[    1.747922] pci_bus 0000:00: resource 11 [mem 0xfe010000-0xfe010fff window]
[    1.747922] pci_bus 0000:00: resource 12 [mem 0x90000000-0x9d7fffff window]
[    1.747923] pci_bus 0000:00: resource 13 [mem 0x380000000000-0x383fffffffff window]
[    1.747925] pci_bus 0000:02: resource 1 [mem 0x9d100000-0x9d1fffff]
[    1.747926] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
[    1.747927] pci_bus 0000:03: resource 1 [mem 0x9c000000-0x9d0fffff]
[    1.747928] pci_bus 0000:04: resource 0 [io  0x2000-0x2fff]
[    1.747929] pci_bus 0000:04: resource 1 [mem 0x9c000000-0x9d0fffff]
[    1.748021] pci 0000:17:00.0: PCI bridge to [bus 18]
[    1.748024] pci 0000:17:00.0:   bridge window [mem 0xaac00000-0xaaefffff]
[    1.748026] pci 0000:17:00.0:   bridge window [mem 0xaa800000-0xaaafffff 64bit pref]
[    1.748031] pci_bus 0000:17: resource 4 [io  0x4000-0x5fff window]
[    1.748032] pci_bus 0000:17: resource 5 [mem 0x9d800000-0xaaffffff window]
[    1.748033] pci_bus 0000:17: resource 6 [mem 0x384000000000-0x387fffffffff window]
[    1.748034] pci_bus 0000:18: resource 1 [mem 0xaac00000-0xaaefffff]
[    1.748035] pci_bus 0000:18: resource 2 [mem 0xaa800000-0xaaafffff 64bit pref]
[    1.748056] pci 0000:3a:00.0: PCI bridge to [bus 3b]
[    1.748062] pci 0000:3a:01.0: PCI bridge to [bus 3c]
[    1.748067] pci 0000:3a:02.0: PCI bridge to [bus 3d]
[    1.748070] pci 0000:3a:02.0:   bridge window [mem 0xb8600000-0xb86fffff]
[    1.748074] pci 0000:3a:03.0: PCI bridge to [bus 3e]
[    1.748076] pci 0000:3a:03.0:   bridge window [mem 0xb8500000-0xb85fffff]
[    1.748081] pci_bus 0000:3a: resource 4 [io  0x6000-0x7fff window]
[    1.748082] pci_bus 0000:3a: resource 5 [mem 0xab000000-0xb87fffff window]
[    1.748083] pci_bus 0000:3a: resource 6 [mem 0x388000000000-0x38bfffffffff window]
[    1.748084] pci_bus 0000:3d: resource 1 [mem 0xb8600000-0xb86fffff]
[    1.748085] pci_bus 0000:3e: resource 1 [mem 0xb8500000-0xb85fffff]
[    1.748102] pci 0000:5d:02.0: PCI bridge to [bus 5e]
[    1.748105] pci 0000:5d:02.0:   bridge window [mem 0xc4300000-0xc43fffff]
[    1.748110] pci 0000:60:03.0: PCI bridge to [bus 61]
[    1.748113] pci 0000:60:03.0:   bridge window [mem 0xc4100000-0xc41fffff]
[    1.748116] pci 0000:60:03.0:   bridge window [mem 0xbf000000-0xc19fffff 64bit pref]
[    1.748121] pci 0000:5f:00.0: PCI bridge to [bus 60-61]
[    1.748124] pci 0000:5f:00.0:   bridge window [mem 0xc4100000-0xc41fffff]
[    1.748126] pci 0000:5f:00.0:   bridge window [mem 0xbf000000-0xc19fffff 64bit pref]
[    1.748130] pci 0000:5d:03.0: PCI bridge to [bus 5f-61]
[    1.748132] pci 0000:5d:03.0:   bridge window [mem 0xc4000000-0xc42fffff]
[    1.748134] pci 0000:5d:03.0:   bridge window [mem 0xbf000000-0xc19fffff 64bit pref]
[    1.748138] pci_bus 0000:5d: resource 4 [io  0x8000-0x9fff window]
[    1.748139] pci_bus 0000:5d: resource 5 [mem 0xb8800000-0xc5ffffff window]
[    1.748140] pci_bus 0000:5d: resource 6 [mem 0x38c000000000-0x38ffffffffff window]
[    1.748141] pci_bus 0000:5e: resource 1 [mem 0xc4300000-0xc43fffff]
[    1.748142] pci_bus 0000:5f: resource 1 [mem 0xc4000000-0xc42fffff]
[    1.748143] pci_bus 0000:5f: resource 2 [mem 0xbf000000-0xc19fffff 64bit pref]
[    1.748144] pci_bus 0000:60: resource 1 [mem 0xc4100000-0xc41fffff]
[    1.748145] pci_bus 0000:60: resource 2 [mem 0xbf000000-0xc19fffff 64bit pref]
[    1.748146] pci_bus 0000:61: resource 1 [mem 0xc4100000-0xc41fffff]
[    1.748147] pci_bus 0000:61: resource 2 [mem 0xbf000000-0xc19fffff 64bit pref]
[    1.748163] pci 0000:80:00.0: PCI bridge to [bus 81]
[    1.748168] pci_bus 0000:80: resource 4 [io  0xa000-0xbfff window]
[    1.748169] pci_bus 0000:80: resource 5 [mem 0xc6000000-0xd37fffff window]
[    1.748170] pci_bus 0000:80: resource 6 [mem 0x390000000000-0x393fffffffff window]
[    1.748186] pci 0000:85:00.0: PCI bridge to [bus 86]
[    1.748191] pci 0000:85:02.0: PCI bridge to [bus 87]
[    1.748198] pci_bus 0000:85: resource 4 [io  0xc000-0xdfff window]
[    1.748199] pci_bus 0000:85: resource 5 [mem 0xd3800000-0xe0ffffff window]
[    1.748200] pci_bus 0000:85: resource 6 [mem 0x394000000000-0x397fffffffff window]
[    1.748221] pci 0000:b0:00.0: PCI bridge to [bus b1]
[    1.748223] pci 0000:b0:00.0:   bridge window [io  0xe000-0xefff]
[    1.748226] pci 0000:b0:00.0:   bridge window [mem 0xee500000-0xee5fffff]
[    1.748228] pci 0000:b0:00.0:   bridge window [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.748232] pci 0000:af:00.0: PCI bridge to [bus b0-b1]
[    1.748234] pci 0000:af:00.0:   bridge window [io  0xe000-0xefff]
[    1.748237] pci 0000:af:00.0:   bridge window [mem 0xee500000-0xee5fffff]
[    1.748240] pci 0000:af:00.0:   bridge window [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.748244] pci 0000:ae:00.0: PCI bridge to [bus af-b1]
[    1.748245] pci 0000:ae:00.0:   bridge window [io  0xe000-0xefff]
[    1.748248] pci 0000:ae:00.0:   bridge window [mem 0xee500000-0xee6fffff]
[    1.748249] pci 0000:ae:00.0:   bridge window [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.748253] pci_bus 0000:ae: resource 4 [io  0xe000-0xefff window]
[    1.748254] pci_bus 0000:ae: resource 5 [mem 0xe1000000-0xee7fffff window]
[    1.748255] pci_bus 0000:ae: resource 6 [mem 0x398000000000-0x39bfffffffff window]
[    1.748256] pci_bus 0000:af: resource 0 [io  0xe000-0xefff]
[    1.748257] pci_bus 0000:af: resource 1 [mem 0xee500000-0xee6fffff]
[    1.748258] pci_bus 0000:af: resource 2 [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.748259] pci_bus 0000:b0: resource 0 [io  0xe000-0xefff]
[    1.748259] pci_bus 0000:b0: resource 1 [mem 0xee500000-0xee5fffff]
[    1.748260] pci_bus 0000:b0: resource 2 [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.748261] pci_bus 0000:b1: resource 0 [io  0xe000-0xefff]
[    1.748262] pci_bus 0000:b1: resource 1 [mem 0xee500000-0xee5fffff]
[    1.748263] pci_bus 0000:b1: resource 2 [mem 0x39bfe0000000-0x39bff01fffff 64bit pref]
[    1.748278] pci 0000:d7:00.0: PCI bridge to [bus d8]
[    1.748281] pci 0000:d7:00.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    1.748286] pci_bus 0000:d7: resource 4 [io  0xf000-0xffff window]
[    1.748287] pci_bus 0000:d7: resource 5 [mem 0xee800000-0xfbffffff window]
[    1.748288] pci_bus 0000:d7: resource 6 [mem 0x39c000000000-0x39ffffffffff window]
[    1.748289] pci_bus 0000:d8: resource 1 [mem 0xfbe00000-0xfbefffff]
[    1.748382] NET: Registered protocol family 2
[    1.748873] tcp_listen_portaddr_hash hash table entries: 65536 (order: 8, 1048576 bytes, vmalloc)
[    1.749132] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc)
[    1.749716] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, vmalloc)
[    1.749843] TCP: Hash tables configured (established 524288 bind 65536)
[    1.750161] UDP hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
[    1.750488] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes, vmalloc)
[    1.750872] NET: Registered protocol family 1
[    1.751001] NET: Registered protocol family 44
[    1.751377] pci 0000:02:00.0: PME# does not work under D0, disabling it
[    1.751525] pci 0000:17:05.0: disabled boot interrupts on device [8086:2034]
[    1.751641] pci 0000:18:00.0: CLS mismatch (64 != 32), using 64 bytes
[    1.751648] pci 0000:3a:05.0: disabled boot interrupts on device [8086:2034]
[    1.751692] pci 0000:5d:05.0: disabled boot interrupts on device [8086:2034]
[    1.751751] pci 0000:85:05.0: disabled boot interrupts on device [8086:2034]
[    1.751835] pci 0000:ae:05.0: disabled boot interrupts on device [8086:2034]
[    1.751876] pci 0000:b1:00.0: disabling ATS
[    1.751937] pci 0000:b1:00.1: D0 power state depends on 0000:b1:00.0
[    1.751943] pci 0000:d7:05.0: disabled boot interrupts on device [8086:2034]
[    1.751998] Unpacking initramfs...
[    7.573187] Freeing initrd memory: 341128K
[    7.574017] DMAR: dmar6: Using Queued invalidation
[    7.574023] DMAR: dmar5: Using Queued invalidation
[    7.574028] DMAR: dmar4: Using Queued invalidation
[    7.574032] DMAR: dmar3: Using Queued invalidation
[    7.574039] DMAR: dmar2: Using Queued invalidation
[    7.574045] DMAR: dmar1: Using Queued invalidation
[    7.574050] DMAR: dmar0: Using Queued invalidation
[    7.574057] DMAR: dmar7: Using Queued invalidation
[    7.575193] pci 0000:00:00.0: Adding to iommu group 0
[    7.576258] pci 0000:00:04.0: Adding to iommu group 1
[    7.576325] pci 0000:00:04.1: Adding to iommu group 1
[    7.576393] pci 0000:00:04.2: Adding to iommu group 1
[    7.576458] pci 0000:00:04.3: Adding to iommu group 1
[    7.576523] pci 0000:00:04.4: Adding to iommu group 1
[    7.576588] pci 0000:00:04.5: Adding to iommu group 1
[    7.576653] pci 0000:00:04.6: Adding to iommu group 1
[    7.576718] pci 0000:00:04.7: Adding to iommu group 1
[    7.577627] pci 0000:00:05.0: Adding to iommu group 2
[    7.577696] pci 0000:00:05.1: Adding to iommu group 2
[    7.577761] pci 0000:00:05.2: Adding to iommu group 2
[    7.577827] pci 0000:00:05.4: Adding to iommu group 2
[    7.577892] pci 0000:00:05.6: Adding to iommu group 2
[    7.578697] pci 0000:00:07.0: Adding to iommu group 3
[    7.578765] pci 0000:00:07.4: Adding to iommu group 3
[    7.578830] pci 0000:00:07.7: Adding to iommu group 3
[    7.579444] pci 0000:00:08.0: Adding to iommu group 4
[    7.579511] pci 0000:00:08.1: Adding to iommu group 4
[    7.579577] pci 0000:00:08.2: Adding to iommu group 4
[    7.580240] pci 0000:00:11.0: Adding to iommu group 5
[    7.580307] pci 0000:00:11.1: Adding to iommu group 5
[    7.580373] pci 0000:00:11.5: Adding to iommu group 5
[    7.581088] pci 0000:00:14.0: Adding to iommu group 6
[    7.581156] pci 0000:00:14.2: Adding to iommu group 6
[    7.581750] pci 0000:00:16.0: Adding to iommu group 7
[    7.581817] pci 0000:00:16.1: Adding to iommu group 7
[    7.581883] pci 0000:00:16.4: Adding to iommu group 7
[    7.582478] pci 0000:00:17.0: Adding to iommu group 8
[    7.582966] pci 0000:00:1c.0: Adding to iommu group 9
[    7.583441] pci 0000:00:1c.2: Adding to iommu group 10
[    7.584056] pci 0000:00:1c.5: Adding to iommu group 11
[    7.585652] pci 0000:00:1f.0: Adding to iommu group 12
[    7.585721] pci 0000:00:1f.2: Adding to iommu group 12
[    7.585791] pci 0000:00:1f.3: Adding to iommu group 12
[    7.585859] pci 0000:00:1f.4: Adding to iommu group 12
[    7.585932] pci 0000:00:1f.5: Adding to iommu group 12
[    7.586541] pci 0000:02:00.0: Adding to iommu group 13
[    7.587118] pci 0000:03:00.0: Adding to iommu group 14
[    7.587126] pci 0000:04:00.0: Adding to iommu group 14
[    7.587527] pci 0000:17:00.0: Adding to iommu group 15
[    7.588302] pci 0000:17:05.0: Adding to iommu group 16
[    7.588375] pci 0000:17:05.2: Adding to iommu group 16
[    7.588444] pci 0000:17:05.4: Adding to iommu group 16
[    7.588513] pci 0000:17:05.6: Adding to iommu group 16
[    7.589461] pci 0000:17:07.0: Adding to iommu group 17
[    7.589533] pci 0000:17:07.1: Adding to iommu group 17
[    7.589602] pci 0000:17:07.2: Adding to iommu group 17
[    7.589674] pci 0000:17:07.3: Adding to iommu group 17
[    7.589744] pci 0000:17:07.4: Adding to iommu group 17
[    7.589813] pci 0000:17:07.7: Adding to iommu group 17
[    7.590726] pci 0000:17:08.0: Adding to iommu group 18
[    7.590798] pci 0000:17:08.1: Adding to iommu group 18
[    7.590869] pci 0000:17:08.2: Adding to iommu group 18
[    7.590939] pci 0000:17:08.3: Adding to iommu group 18
[    7.591009] pci 0000:17:08.4: Adding to iommu group 18
[    7.591078] pci 0000:17:08.5: Adding to iommu group 18
[    7.591148] pci 0000:17:08.6: Adding to iommu group 18
[    7.591218] pci 0000:17:08.7: Adding to iommu group 18
[    7.592270] pci 0000:17:09.0: Adding to iommu group 19
[    7.592343] pci 0000:17:09.1: Adding to iommu group 19
[    7.592414] pci 0000:17:09.2: Adding to iommu group 19
[    7.592484] pci 0000:17:09.3: Adding to iommu group 19
[    7.592556] pci 0000:17:09.4: Adding to iommu group 19
[    7.592626] pci 0000:17:09.5: Adding to iommu group 19
[    7.592699] pci 0000:17:09.6: Adding to iommu group 19
[    7.592769] pci 0000:17:09.7: Adding to iommu group 19
[    7.593496] pci 0000:17:0a.0: Adding to iommu group 20
[    7.593570] pci 0000:17:0a.1: Adding to iommu group 20
[    7.594619] pci 0000:17:0e.0: Adding to iommu group 21
[    7.594694] pci 0000:17:0e.1: Adding to iommu group 21
[    7.594766] pci 0000:17:0e.2: Adding to iommu group 21
[    7.594838] pci 0000:17:0e.3: Adding to iommu group 21
[    7.594909] pci 0000:17:0e.4: Adding to iommu group 21
[    7.594981] pci 0000:17:0e.5: Adding to iommu group 21
[    7.595052] pci 0000:17:0e.6: Adding to iommu group 21
[    7.595126] pci 0000:17:0e.7: Adding to iommu group 21
[    7.596079] pci 0000:17:0f.0: Adding to iommu group 22
[    7.596155] pci 0000:17:0f.1: Adding to iommu group 22
[    7.596228] pci 0000:17:0f.2: Adding to iommu group 22
[    7.596301] pci 0000:17:0f.3: Adding to iommu group 22
[    7.596373] pci 0000:17:0f.4: Adding to iommu group 22
[    7.596447] pci 0000:17:0f.5: Adding to iommu group 22
[    7.596522] pci 0000:17:0f.6: Adding to iommu group 22
[    7.596595] pci 0000:17:0f.7: Adding to iommu group 22
[    7.597282] pci 0000:17:10.0: Adding to iommu group 23
[    7.597359] pci 0000:17:10.1: Adding to iommu group 23
[    7.598432] pci 0000:17:14.0: Adding to iommu group 24
[    7.598509] pci 0000:17:14.1: Adding to iommu group 24
[    7.598584] pci 0000:17:14.2: Adding to iommu group 24
[    7.598659] pci 0000:17:14.3: Adding to iommu group 24
[    7.598733] pci 0000:17:14.4: Adding to iommu group 24
[    7.598807] pci 0000:17:14.5: Adding to iommu group 24
[    7.598883] pci 0000:17:14.6: Adding to iommu group 24
[    7.598957] pci 0000:17:14.7: Adding to iommu group 24
[    7.599884] pci 0000:17:15.0: Adding to iommu group 25
[    7.599962] pci 0000:17:15.1: Adding to iommu group 25
[    7.600037] pci 0000:17:15.2: Adding to iommu group 25
[    7.600113] pci 0000:17:15.3: Adding to iommu group 25
[    7.600193] pci 0000:17:15.4: Adding to iommu group 25
[    7.600268] pci 0000:17:15.5: Adding to iommu group 25
[    7.600343] pci 0000:17:15.6: Adding to iommu group 25
[    7.600418] pci 0000:17:15.7: Adding to iommu group 25
[    7.600976] pci 0000:17:16.0: Adding to iommu group 26
[    7.601058] pci 0000:17:16.1: Adding to iommu group 26
[    7.601896] pci 0000:17:1d.0: Adding to iommu group 27
[    7.601976] pci 0000:17:1d.1: Adding to iommu group 27
[    7.602053] pci 0000:17:1d.2: Adding to iommu group 27
[    7.602129] pci 0000:17:1d.3: Adding to iommu group 27
[    7.603043] pci 0000:17:1e.0: Adding to iommu group 28
[    7.603124] pci 0000:17:1e.1: Adding to iommu group 28
[    7.603201] pci 0000:17:1e.2: Adding to iommu group 28
[    7.603278] pci 0000:17:1e.3: Adding to iommu group 28
[    7.603355] pci 0000:17:1e.4: Adding to iommu group 28
[    7.603431] pci 0000:17:1e.5: Adding to iommu group 28
[    7.603507] pci 0000:17:1e.6: Adding to iommu group 28
[    7.604414] pci 0000:17:1f.0: Adding to iommu group 29
[    7.604495] pci 0000:17:1f.1: Adding to iommu group 29
[    7.604574] pci 0000:17:1f.2: Adding to iommu group 29
[    7.604652] pci 0000:17:1f.3: Adding to iommu group 29
[    7.604730] pci 0000:17:1f.4: Adding to iommu group 29
[    7.604809] pci 0000:17:1f.5: Adding to iommu group 29
[    7.604886] pci 0000:17:1f.6: Adding to iommu group 29
[    7.604964] pci 0000:17:1f.7: Adding to iommu group 29
[    7.605366] pci 0000:18:00.0: Adding to iommu group 30
[    7.605805] pci 0000:3a:00.0: Adding to iommu group 31
[    7.606413] pci 0000:3a:01.0: Adding to iommu group 32
[    7.607034] pci 0000:3a:02.0: Adding to iommu group 33
[    7.607434] pci 0000:3a:03.0: Adding to iommu group 34
[    7.608072] pci 0000:3a:05.0: Adding to iommu group 35
[    7.608157] pci 0000:3a:05.2: Adding to iommu group 35
[    7.608238] pci 0000:3a:05.4: Adding to iommu group 35
[    7.608319] pci 0000:3a:05.6: Adding to iommu group 35
[    7.609124] pci 0000:3a:07.0: Adding to iommu group 36
[    7.609211] pci 0000:3a:07.1: Adding to iommu group 36
[    7.609293] pci 0000:3a:07.2: Adding to iommu group 36
[    7.609375] pci 0000:3a:07.3: Adding to iommu group 36
[    7.609455] pci 0000:3a:07.4: Adding to iommu group 36
[    7.609535] pci 0000:3a:07.7: Adding to iommu group 36
[    7.610033] pci 0000:3a:08.0: Adding to iommu group 37
[    7.610119] pci 0000:3a:08.1: Adding to iommu group 37
[    7.610718] pci 0000:3a:09.0: Adding to iommu group 38
[    7.610803] pci 0000:3a:09.1: Adding to iommu group 38
[    7.611651] pci 0000:3a:0a.0: Adding to iommu group 39
[    7.611737] pci 0000:3a:0a.1: Adding to iommu group 39
[    7.611821] pci 0000:3a:0a.2: Adding to iommu group 39
[    7.611902] pci 0000:3a:0a.3: Adding to iommu group 39
[    7.611985] pci 0000:3a:0a.4: Adding to iommu group 39
[    7.612066] pci 0000:3a:0a.5: Adding to iommu group 39
[    7.612148] pci 0000:3a:0a.6: Adding to iommu group 39
[    7.612230] pci 0000:3a:0a.7: Adding to iommu group 39
[    7.612872] pci 0000:3a:0b.0: Adding to iommu group 40
[    7.612959] pci 0000:3a:0b.1: Adding to iommu group 40
[    7.613043] pci 0000:3a:0b.2: Adding to iommu group 40
[    7.613127] pci 0000:3a:0b.3: Adding to iommu group 40
[    7.614116] pci 0000:3a:0c.0: Adding to iommu group 41
[    7.614206] pci 0000:3a:0c.1: Adding to iommu group 41
[    7.614290] pci 0000:3a:0c.2: Adding to iommu group 41
[    7.614373] pci 0000:3a:0c.3: Adding to iommu group 41
[    7.614457] pci 0000:3a:0c.4: Adding to iommu group 41
[    7.614540] pci 0000:3a:0c.5: Adding to iommu group 41
[    7.614623] pci 0000:3a:0c.6: Adding to iommu group 41
[    7.614706] pci 0000:3a:0c.7: Adding to iommu group 41
[    7.615554] pci 0000:3a:0d.0: Adding to iommu group 42
[    7.615643] pci 0000:3a:0d.1: Adding to iommu group 42
[    7.615729] pci 0000:3a:0d.2: Adding to iommu group 42
[    7.615815] pci 0000:3a:0d.3: Adding to iommu group 42
[    7.616400] pci 0000:3d:00.0: Adding to iommu group 43
[    7.616827] pci 0000:3e:00.0: Adding to iommu group 44
[    7.617236] pci 0000:5d:02.0: Adding to iommu group 45
[    7.617655] pci 0000:5d:03.0: Adding to iommu group 46
[    7.618415] pci 0000:5d:05.0: Adding to iommu group 47
[    7.618505] pci 0000:5d:05.2: Adding to iommu group 47
[    7.618592] pci 0000:5d:05.4: Adding to iommu group 47
[    7.618677] pci 0000:5d:05.5: Adding to iommu group 47
[    7.618762] pci 0000:5d:05.6: Adding to iommu group 47
[    7.619511] pci 0000:5d:07.0: Adding to iommu group 48
[    7.619603] pci 0000:5d:07.1: Adding to iommu group 48
[    7.619689] pci 0000:5d:07.2: Adding to iommu group 48
[    7.619776] pci 0000:5d:07.3: Adding to iommu group 48
[    7.619862] pci 0000:5d:07.4: Adding to iommu group 48
[    7.619949] pci 0000:5d:07.7: Adding to iommu group 48
[    7.620569] pci 0000:5d:0e.0: Adding to iommu group 49
[    7.620661] pci 0000:5d:0e.1: Adding to iommu group 49
[    7.620750] pci 0000:5d:0e.2: Adding to iommu group 49
[    7.620837] pci 0000:5d:0e.3: Adding to iommu group 49
[    7.621497] pci 0000:5d:0f.0: Adding to iommu group 50
[    7.621589] pci 0000:5d:0f.1: Adding to iommu group 50
[    7.621680] pci 0000:5d:0f.2: Adding to iommu group 50
[    7.622492] pci 0000:5d:12.0: Adding to iommu group 51
[    7.622587] pci 0000:5d:12.1: Adding to iommu group 51
[    7.622676] pci 0000:5d:12.2: Adding to iommu group 51
[    7.622764] pci 0000:5d:12.3: Adding to iommu group 51
[    7.623542] pci 0000:5d:15.0: Adding to iommu group 52
[    7.623635] pci 0000:5d:15.1: Adding to iommu group 52
[    7.623725] pci 0000:5d:15.3: Adding to iommu group 52
[    7.624662] pci 0000:5d:16.0: Adding to iommu group 53
[    7.624756] pci 0000:5d:16.1: Adding to iommu group 53
[    7.624848] pci 0000:5d:16.3: Adding to iommu group 53
[    7.624938] pci 0000:5d:16.4: Adding to iommu group 53
[    7.625028] pci 0000:5d:16.5: Adding to iommu group 53
[    7.625118] pci 0000:5d:16.7: Adding to iommu group 53
[    7.625691] pci 0000:5e:00.0: Adding to iommu group 54
[    7.626108] pci 0000:5f:00.0: Adding to iommu group 55
[    7.626547] pci 0000:60:03.0: Adding to iommu group 56
[    7.627186] pci 0000:61:00.0: Adding to iommu group 57
[    7.627771] pci 0000:61:00.1: Adding to iommu group 58
[    7.628193] pci 0000:80:00.0: Adding to iommu group 59
[    7.629105] pci 0000:80:04.0: Adding to iommu group 60
[    7.629204] pci 0000:80:04.1: Adding to iommu group 60
[    7.629297] pci 0000:80:04.2: Adding to iommu group 60
[    7.629389] pci 0000:80:04.3: Adding to iommu group 60
[    7.629482] pci 0000:80:04.4: Adding to iommu group 60
[    7.629574] pci 0000:80:04.5: Adding to iommu group 60
[    7.629666] pci 0000:80:04.6: Adding to iommu group 60
[    7.629758] pci 0000:80:04.7: Adding to iommu group 60
[    7.630477] pci 0000:80:05.0: Adding to iommu group 61
[    7.630578] pci 0000:80:05.1: Adding to iommu group 61
[    7.630676] pci 0000:80:05.2: Adding to iommu group 61
[    7.630770] pci 0000:80:05.4: Adding to iommu group 61
[    7.630862] pci 0000:80:05.6: Adding to iommu group 61
[    7.631439] pci 0000:80:07.0: Adding to iommu group 62
[    7.631537] pci 0000:80:07.4: Adding to iommu group 62
[    7.631632] pci 0000:80:07.7: Adding to iommu group 62
[    7.632273] pci 0000:80:08.0: Adding to iommu group 63
[    7.632370] pci 0000:80:08.1: Adding to iommu group 63
[    7.632466] pci 0000:80:08.2: Adding to iommu group 63
[    7.632981] pci 0000:85:00.0: Adding to iommu group 64
[    7.633381] pci 0000:85:02.0: Adding to iommu group 65
[    7.634029] pci 0000:85:05.0: Adding to iommu group 66
[    7.634129] pci 0000:85:05.2: Adding to iommu group 66
[    7.634225] pci 0000:85:05.4: Adding to iommu group 66
[    7.634323] pci 0000:85:05.6: Adding to iommu group 66
[    7.635056] pci 0000:85:07.0: Adding to iommu group 67
[    7.635156] pci 0000:85:07.1: Adding to iommu group 67
[    7.635254] pci 0000:85:07.2: Adding to iommu group 67
[    7.635351] pci 0000:85:07.3: Adding to iommu group 67
[    7.635447] pci 0000:85:07.4: Adding to iommu group 67
[    7.635544] pci 0000:85:07.7: Adding to iommu group 67
[    7.636456] pci 0000:85:08.0: Adding to iommu group 68
[    7.636556] pci 0000:85:08.1: Adding to iommu group 68
[    7.636654] pci 0000:85:08.2: Adding to iommu group 68
[    7.636751] pci 0000:85:08.3: Adding to iommu group 68
[    7.636848] pci 0000:85:08.4: Adding to iommu group 68
[    7.636947] pci 0000:85:08.5: Adding to iommu group 68
[    7.637046] pci 0000:85:08.6: Adding to iommu group 68
[    7.637143] pci 0000:85:08.7: Adding to iommu group 68
[    7.638192] pci 0000:85:09.0: Adding to iommu group 69
[    7.638292] pci 0000:85:09.1: Adding to iommu group 69
[    7.638393] pci 0000:85:09.2: Adding to iommu group 69
[    7.638492] pci 0000:85:09.3: Adding to iommu group 69
[    7.638591] pci 0000:85:09.4: Adding to iommu group 69
[    7.638692] pci 0000:85:09.5: Adding to iommu group 69
[    7.638790] pci 0000:85:09.6: Adding to iommu group 69
[    7.638889] pci 0000:85:09.7: Adding to iommu group 69
[    7.639622] pci 0000:85:0a.0: Adding to iommu group 70
[    7.639725] pci 0000:85:0a.1: Adding to iommu group 70
[    7.640775] pci 0000:85:0e.0: Adding to iommu group 71
[    7.640878] pci 0000:85:0e.1: Adding to iommu group 71
[    7.640979] pci 0000:85:0e.2: Adding to iommu group 71
[    7.641082] pci 0000:85:0e.3: Adding to iommu group 71
[    7.641183] pci 0000:85:0e.4: Adding to iommu group 71
[    7.641284] pci 0000:85:0e.5: Adding to iommu group 71
[    7.641386] pci 0000:85:0e.6: Adding to iommu group 71
[    7.641486] pci 0000:85:0e.7: Adding to iommu group 71
[    7.642561] pci 0000:85:0f.0: Adding to iommu group 72
[    7.642667] pci 0000:85:0f.1: Adding to iommu group 72
[    7.642770] pci 0000:85:0f.2: Adding to iommu group 72
[    7.642873] pci 0000:85:0f.3: Adding to iommu group 72
[    7.642975] pci 0000:85:0f.4: Adding to iommu group 72
[    7.643077] pci 0000:85:0f.5: Adding to iommu group 72
[    7.643180] pci 0000:85:0f.6: Adding to iommu group 72
[    7.643285] pci 0000:85:0f.7: Adding to iommu group 72
[    7.643996] pci 0000:85:10.0: Adding to iommu group 73
[    7.644101] pci 0000:85:10.1: Adding to iommu group 73
[    7.645166] pci 0000:85:14.0: Adding to iommu group 74
[    7.645272] pci 0000:85:14.1: Adding to iommu group 74
[    7.645379] pci 0000:85:14.2: Adding to iommu group 74
[    7.645484] pci 0000:85:14.3: Adding to iommu group 74
[    7.645590] pci 0000:85:14.4: Adding to iommu group 74
[    7.645694] pci 0000:85:14.5: Adding to iommu group 74
[    7.645798] pci 0000:85:14.6: Adding to iommu group 74
[    7.645906] pci 0000:85:14.7: Adding to iommu group 74
[    7.646956] pci 0000:85:15.0: Adding to iommu group 75
[    7.647063] pci 0000:85:15.1: Adding to iommu group 75
[    7.647170] pci 0000:85:15.2: Adding to iommu group 75
[    7.647275] pci 0000:85:15.3: Adding to iommu group 75
[    7.647381] pci 0000:85:15.4: Adding to iommu group 75
[    7.647486] pci 0000:85:15.5: Adding to iommu group 75
[    7.647594] pci 0000:85:15.6: Adding to iommu group 75
[    7.647699] pci 0000:85:15.7: Adding to iommu group 75
[    7.648420] pci 0000:85:16.0: Adding to iommu group 76
[    7.648527] pci 0000:85:16.1: Adding to iommu group 76
[    7.649374] pci 0000:85:1d.0: Adding to iommu group 77
[    7.649484] pci 0000:85:1d.1: Adding to iommu group 77
[    7.649591] pci 0000:85:1d.2: Adding to iommu group 77
[    7.649699] pci 0000:85:1d.3: Adding to iommu group 77
[    7.650598] pci 0000:85:1e.0: Adding to iommu group 78
[    7.650706] pci 0000:85:1e.1: Adding to iommu group 78
[    7.650815] pci 0000:85:1e.2: Adding to iommu group 78
[    7.650924] pci 0000:85:1e.3: Adding to iommu group 78
[    7.651032] pci 0000:85:1e.4: Adding to iommu group 78
[    7.651140] pci 0000:85:1e.5: Adding to iommu group 78
[    7.651247] pci 0000:85:1e.6: Adding to iommu group 78
[    7.652286] pci 0000:85:1f.0: Adding to iommu group 79
[    7.652399] pci 0000:85:1f.1: Adding to iommu group 79
[    7.652509] pci 0000:85:1f.2: Adding to iommu group 79
[    7.652621] pci 0000:85:1f.3: Adding to iommu group 79
[    7.652730] pci 0000:85:1f.4: Adding to iommu group 79
[    7.652839] pci 0000:85:1f.5: Adding to iommu group 79
[    7.652948] pci 0000:85:1f.6: Adding to iommu group 79
[    7.653057] pci 0000:85:1f.7: Adding to iommu group 79
[    7.653517] pci 0000:ae:00.0: Adding to iommu group 80
[    7.654168] pci 0000:ae:05.0: Adding to iommu group 81
[    7.654279] pci 0000:ae:05.2: Adding to iommu group 81
[    7.654390] pci 0000:ae:05.4: Adding to iommu group 81
[    7.654502] pci 0000:ae:05.6: Adding to iommu group 81
[    7.655244] pci 0000:ae:07.0: Adding to iommu group 82
[    7.655356] pci 0000:ae:07.1: Adding to iommu group 82
[    7.655468] pci 0000:ae:07.2: Adding to iommu group 82
[    7.655579] pci 0000:ae:07.3: Adding to iommu group 82
[    7.655690] pci 0000:ae:07.4: Adding to iommu group 82
[    7.655802] pci 0000:ae:07.7: Adding to iommu group 82
[    7.656390] pci 0000:ae:08.0: Adding to iommu group 83
[    7.656503] pci 0000:ae:08.1: Adding to iommu group 83
[    7.657014] pci 0000:ae:09.0: Adding to iommu group 84
[    7.657126] pci 0000:ae:09.1: Adding to iommu group 84
[    7.658122] pci 0000:ae:0a.0: Adding to iommu group 85
[    7.658235] pci 0000:ae:0a.1: Adding to iommu group 85
[    7.658348] pci 0000:ae:0a.2: Adding to iommu group 85
[    7.658461] pci 0000:ae:0a.3: Adding to iommu group 85
[    7.658574] pci 0000:ae:0a.4: Adding to iommu group 85
[    7.658691] pci 0000:ae:0a.5: Adding to iommu group 85
[    7.658804] pci 0000:ae:0a.6: Adding to iommu group 85
[    7.658917] pci 0000:ae:0a.7: Adding to iommu group 85
[    7.659662] pci 0000:ae:0b.0: Adding to iommu group 86
[    7.659778] pci 0000:ae:0b.1: Adding to iommu group 86
[    7.659894] pci 0000:ae:0b.2: Adding to iommu group 86
[    7.660009] pci 0000:ae:0b.3: Adding to iommu group 86
[    7.660889] pci 0000:ae:0c.0: Adding to iommu group 87
[    7.661005] pci 0000:ae:0c.1: Adding to iommu group 87
[    7.661119] pci 0000:ae:0c.2: Adding to iommu group 87
[    7.661234] pci 0000:ae:0c.3: Adding to iommu group 87
[    7.661349] pci 0000:ae:0c.4: Adding to iommu group 87
[    7.661466] pci 0000:ae:0c.5: Adding to iommu group 87
[    7.661581] pci 0000:ae:0c.6: Adding to iommu group 87
[    7.661696] pci 0000:ae:0c.7: Adding to iommu group 87
[    7.662464] pci 0000:ae:0d.0: Adding to iommu group 88
[    7.662582] pci 0000:ae:0d.1: Adding to iommu group 88
[    7.662700] pci 0000:ae:0d.2: Adding to iommu group 88
[    7.662817] pci 0000:ae:0d.3: Adding to iommu group 88
[    7.663420] pci 0000:af:00.0: Adding to iommu group 89
[    7.664066] pci 0000:b0:00.0: Adding to iommu group 90
[    7.664494] pci 0000:b1:00.0: Adding to iommu group 91
[    7.665121] pci 0000:b1:00.1: Adding to iommu group 92
[    7.665528] pci 0000:d7:00.0: Adding to iommu group 93
[    7.666181] pci 0000:d7:05.0: Adding to iommu group 94
[    7.666301] pci 0000:d7:05.2: Adding to iommu group 94
[    7.666418] pci 0000:d7:05.4: Adding to iommu group 94
[    7.666537] pci 0000:d7:05.6: Adding to iommu group 94
[    7.667279] pci 0000:d7:07.0: Adding to iommu group 95
[    7.667398] pci 0000:d7:07.1: Adding to iommu group 95
[    7.667516] pci 0000:d7:07.2: Adding to iommu group 95
[    7.667636] pci 0000:d7:07.3: Adding to iommu group 95
[    7.667754] pci 0000:d7:07.4: Adding to iommu group 95
[    7.667872] pci 0000:d7:07.7: Adding to iommu group 95
[    7.668519] pci 0000:d7:0e.0: Adding to iommu group 96
[    7.668638] pci 0000:d7:0e.1: Adding to iommu group 96
[    7.668759] pci 0000:d7:0e.2: Adding to iommu group 96
[    7.668878] pci 0000:d7:0e.3: Adding to iommu group 96
[    7.669450] pci 0000:d7:0f.0: Adding to iommu group 97
[    7.669570] pci 0000:d7:0f.1: Adding to iommu group 97
[    7.669691] pci 0000:d7:0f.2: Adding to iommu group 97
[    7.670362] pci 0000:d7:12.0: Adding to iommu group 98
[    7.670483] pci 0000:d7:12.1: Adding to iommu group 98
[    7.670604] pci 0000:d7:12.2: Adding to iommu group 98
[    7.670725] pci 0000:d7:12.3: Adding to iommu group 98
[    7.671364] pci 0000:d7:15.0: Adding to iommu group 99
[    7.671486] pci 0000:d7:15.1: Adding to iommu group 99
[    7.671608] pci 0000:d7:15.3: Adding to iommu group 99
[    7.672477] pci 0000:d7:16.0: Adding to iommu group 100
[    7.672602] pci 0000:d7:16.1: Adding to iommu group 100
[    7.672722] pci 0000:d7:16.3: Adding to iommu group 100
[    7.672843] pci 0000:d7:16.4: Adding to iommu group 100
[    7.672966] pci 0000:d7:16.5: Adding to iommu group 100
[    7.673087] pci 0000:d7:16.7: Adding to iommu group 100
[    7.673690] pci 0000:d8:00.0: Adding to iommu group 101
[    7.673704] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    7.676749] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 655360 ms ovfl timer
[    7.676750] RAPL PMU: hw unit of domain package 2^-14 Joules
[    7.676751] RAPL PMU: hw unit of domain dram 2^-16 Joules
[    7.800195] Initialise system trusted keyrings
[    7.800205] Key type blacklist registered
[    7.800254] workingset: timestamp_bits=56 max_order=26 bucket_order=0
[    7.801853] fuse: init (API version 7.31)
[    7.801987] SGI XFS with ACLs, security attributes, realtime, scrub, quota, no debug enabled
[    7.808038] NET: Registered protocol family 38
[    7.809184] async_tx: api initialized (async)
[    7.809186] Key type asymmetric registered
[    7.809186] Asymmetric key parser 'x509' registered
[    7.809187] Asymmetric key parser 'pkcs8' registered
[    7.809196] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 244)
[    7.809197] io scheduler mq-deadline registered
[    7.810644] pcieport 0000:00:1c.0: PME: Signaling with IRQ 24
[    7.810793] pcieport 0000:00:1c.2: PME: Signaling with IRQ 25
[    7.810989] pcieport 0000:00:1c.5: PME: Signaling with IRQ 26
[    7.811271] pcieport 0000:17:00.0: PME: Signaling with IRQ 28
[    7.811510] pcieport 0000:3a:00.0: PME: Signaling with IRQ 30
[    7.811715] pcieport 0000:3a:01.0: PME: Signaling with IRQ 31
[    7.811917] pcieport 0000:3a:02.0: PME: Signaling with IRQ 32
[    7.812126] pcieport 0000:3a:03.0: PME: Signaling with IRQ 33
[    7.812383] pcieport 0000:5d:02.0: PME: Signaling with IRQ 35
[    7.812606] pcieport 0000:5d:03.0: PME: Signaling with IRQ 36
[    7.813204] pcieport 0000:80:00.0: PME: Signaling with IRQ 40
[    7.813572] pcieport 0000:85:00.0: PME: Signaling with IRQ 42
[    7.813884] pcieport 0000:85:02.0: PME: Signaling with IRQ 43
[    7.814216] pcieport 0000:ae:00.0: PME: Signaling with IRQ 45
[    7.814824] pcieport 0000:d7:00.0: PME: Signaling with IRQ 49
[    7.815344] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    7.816299] vmd 0000:5d:05.5: PCI host bridge to bus 10000:00
[    7.816302] pci_bus 10000:00: root bus resource [bus 00-1f]
[    7.816303] pci_bus 10000:00: root bus resource [mem 0xc2000000-0xc3ffffff]
[    7.816304] pci_bus 10000:00: root bus resource [mem 0x38fffff02000-0x38ffffffffff 64bit]
[    7.816312] pci 10000:00:00.0: [8086:2030] type 01 class 0x060400
[    7.816339] pci 10000:00:00.0: enabling Extended Tags
[    7.816369] pci 10000:00:00.0: PME# supported from D0 D3hot D3cold
[    7.816439] pci 10000:00:00.0: Adding to iommu group 47
[    7.816451] pci 10000:00:01.0: [8086:2031] type 01 class 0x060400
[    7.816477] pci 10000:00:01.0: enabling Extended Tags
[    7.816504] pci 10000:00:01.0: PME# supported from D0 D3hot D3cold
[    7.816558] pci 10000:00:01.0: Adding to iommu group 47
[    7.816592] pci 10000:00:00.0: PCI bridge to [bus 01]
[    7.816594] pci 10000:00:00.0:   bridge window [io  0x0000-0x8fff]
[    7.816617] pci 10000:00:01.0: PCI bridge to [bus 02]
[    7.816618] pci 10000:00:01.0:   bridge window [io  0x0000-0x9fff]
[    7.816630] pci 10000:00:00.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
[    7.816631] pci 10000:00:00.0: bridge window [mem 0x00100000-0x000fffff] to [bus 01] add_size 200000 add_align 100000
[    7.816633] pci 10000:00:01.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
[    7.816634] pci 10000:00:01.0: bridge window [mem 0x00100000-0x000fffff] to [bus 02] add_size 200000 add_align 100000
[    7.816638] pci 10000:00:00.0: BAR 14: assigned [mem 0xc2000000-0xc21fffff]
[    7.816641] pci 10000:00:00.0: BAR 15: assigned [mem 0xc2200000-0xc23fffff 64bit pref]
[    7.816642] pci 10000:00:01.0: BAR 14: assigned [mem 0xc2400000-0xc25fffff]
[    7.816643] pci 10000:00:01.0: BAR 15: assigned [mem 0xc2600000-0xc27fffff 64bit pref]
[    7.816645] pci 10000:00:00.0: BAR 13: no space for [io  size 0x9000]
[    7.816646] pci 10000:00:00.0: BAR 13: failed to assign [io  size 0x9000]
[    7.816647] pci 10000:00:01.0: BAR 13: no space for [io  size 0xa000]
[    7.816647] pci 10000:00:01.0: BAR 13: failed to assign [io  size 0xa000]
[    7.816650] pci 10000:00:00.0: BAR 13: no space for [io  size 0x9000]
[    7.816650] pci 10000:00:00.0: BAR 13: failed to assign [io  size 0x9000]
[    7.816651] pci 10000:00:01.0: BAR 13: no space for [io  size 0xa000]
[    7.816652] pci 10000:00:01.0: BAR 13: failed to assign [io  size 0xa000]
[    7.816654] pci 10000:00:00.0: PCI bridge to [bus 01]
[    7.816657] pci 10000:00:00.0:   bridge window [mem 0xc2000000-0xc21fffff]
[    7.816659] pci 10000:00:00.0:   bridge window [mem 0xc2200000-0xc23fffff 64bit pref]
[    7.816663] pci 10000:00:01.0: PCI bridge to [bus 02]
[    7.816665] pci 10000:00:01.0:   bridge window [mem 0xc2400000-0xc25fffff]
[    7.816667] pci 10000:00:01.0:   bridge window [mem 0xc2600000-0xc27fffff 64bit pref]
[    7.816709] pcieport 10000:00:00.0: can't derive routing for PCI INT A
[    7.816710] pcieport 10000:00:00.0: PCI INT A: no GSI
[    7.816760] pcieport 10000:00:00.0: PME: Signaling with IRQ 83
[    7.816809] pcieport 10000:00:00.0: AER: enabled with IRQ 83
[    7.816833] pcieport 10000:00:00.0: pciehp: Slot #89 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    7.816947] pcieport 10000:00:01.0: can't derive routing for PCI INT A
[    7.816948] pcieport 10000:00:01.0: PCI INT A: no GSI
[    7.816994] pcieport 10000:00:01.0: PME: Signaling with IRQ 84
[    7.817041] pcieport 10000:00:01.0: AER: enabled with IRQ 84
[    7.817058] pcieport 10000:00:01.0: pciehp: Slot #90 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- IbPresDis- LLActRep+ (with Cmd Compl erratum)
[    7.817158] vmd 0000:5d:05.5: Bound to PCI domain 10000
[    7.817286] intel_idle: MWAIT substates: 0x2020
[    7.817287] intel_idle: ACPI _CST not found or not usable
[    7.817288] intel_idle: v0.5.1 model 0x55
[    7.819352] intel_idle: Local APIC timer is reliable in all C-states
[    7.819354] IPMI message handler: version 39.2
[    7.819380] ipmi device interface
[    7.819406] ipmi_si: IPMI System Interface driver
[    7.819422] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
[    7.819426] ipmi_platform: ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[    7.819429] ipmi_si: Adding SMBIOS-specified kcs state machine
[    7.819515] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
[    7.819621] ipmi_si IPI0001:00: ipmi_platform: [io  0x0ca2] regsize 1 spacing 1 irq 0
[    7.819623] ipmi_si dmi-ipmi-si.0: Removing SMBIOS-specified kcs state machine in favor of ACPI
[    7.819624] ipmi_si: Adding ACPI-specified kcs state machine
[    7.819683] ipmi_si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
[    8.072629] ipmi_si IPI0001:00: The BMC does not support clearing the recv irq bit, compensating, but the BMC needs to be fixed.
[    8.137626] ipmi_si IPI0001:00: IPMI message handler: Found new BMC (man_id: 0x002a7c, prod_id: 0x097a, dev_id: 0x20)
[    8.176268] ipmi_si IPI0001:00: IPMI kcs interface initialized
[    8.176271] ipmi_ssif: IPMI SSIF Interface driver
[    8.182598] IPMI Watchdog: driver initialized
[    8.182600] IPMI poweroff: Copyright (C) 2004 MontaVista Software - IPMI Powerdown via sys_reboot
[    8.189200] IPMI poweroff: ATCA Detect mfg 0x2A7C prod 0x97A
[    8.189202] IPMI poweroff: Found a chassis style poweroff function
[    8.189554] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    8.189595] ACPI: Power Button [PWRF]
[    8.190548] ERST: Error Record Serialization Table (ERST) support is initialized.
[    8.190549] pstore: Registered erst as persistent store backend
[    8.191158] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[    8.191359] ioatdma: Intel(R) QuickData Technology Driver 5.00
[    8.191380] ioatdma 0000:00:04.0: enabling device (0004 -> 0006)
[    8.200624] ioatdma 0000:00:04.1: enabling device (0004 -> 0006)
[    8.207642] ioatdma 0000:00:04.2: enabling device (0004 -> 0006)
[    8.214612] ioatdma 0000:00:04.3: enabling device (0004 -> 0006)
[    8.221522] ioatdma 0000:00:04.4: enabling device (0004 -> 0006)
[    8.228421] ioatdma 0000:00:04.5: enabling device (0004 -> 0006)
[    8.235306] ioatdma 0000:00:04.6: enabling device (0004 -> 0006)
[    8.242186] ioatdma 0000:00:04.7: enabling device (0004 -> 0006)
[    8.249187] ioatdma 0000:80:04.0: enabling device (0004 -> 0006)
[    8.258746] ioatdma 0000:80:04.1: enabling device (0004 -> 0006)
[    8.266162] ioatdma 0000:80:04.2: enabling device (0004 -> 0006)
[    8.273383] ioatdma 0000:80:04.3: enabling device (0004 -> 0006)
[    8.280442] ioatdma 0000:80:04.4: enabling device (0004 -> 0006)
[    8.287480] ioatdma 0000:80:04.5: enabling device (0004 -> 0006)
[    8.294437] ioatdma 0000:80:04.6: enabling device (0004 -> 0006)
[    8.301291] ioatdma 0000:80:04.7: enabling device (0004 -> 0006)
[    8.308371] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    8.308658] 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    8.311943] Non-volatile memory driver v1.3
[    8.311945] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
[    8.311946] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    8.311947] AMD-Vi: AMD IOMMUv2 functionality not available on this system
[    8.312064] [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
[    8.312073] usbcore: registered new interface driver udl
[    8.315453] lpc_ich 0000:00:1f.0: I/O space for ACPI uninitialized
[    8.315456] lpc_ich 0000:00:1f.0: No MFD cells added
[    8.316008] nvme nvme0: pci function 0000:3d:00.0
[    8.316070] nvme nvme1: pci function 0000:3e:00.0
[    8.316138] nvme nvme2: pci function 0000:5e:00.0
[    8.316199] ahci 0000:00:11.5: version 3.0
[    8.322904] nvme nvme2: missing or invalid SUBNQN field.
[    8.322925] nvme nvme2: Shutdown timeout set to 8 seconds
[    8.322942] nvme nvme1: missing or invalid SUBNQN field.
[    8.322963] nvme nvme1: Shutdown timeout set to 8 seconds
[    8.326438] ahci 0000:00:11.5: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    8.326441] ahci 0000:00:11.5: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst
[    8.329739] nvme nvme0: missing or invalid SUBNQN field.
[    8.329760] nvme nvme0: Shutdown timeout set to 8 seconds
[    8.350408] nvme nvme2: 2/28/2 default/read/poll queues
[    8.350429] nvme nvme1: 2/28/2 default/read/poll queues
[    8.356418]  nvme2n1: p1 p2 p3
[    8.358208] nvme nvme0: 2/28/2 default/read/poll queues
[    8.379940] scsi host0: ahci
[    8.380099] scsi host1: ahci
[    8.380180] scsi host2: ahci
[    8.380256] scsi host3: ahci
[    8.380389] scsi host4: ahci
[    8.380469] scsi host5: ahci
[    8.380507] ata1: SATA max UDMA/133 abar m524288@0x9d280000 port 0x9d280100 irq 119
[    8.380508] ata2: SATA max UDMA/133 abar m524288@0x9d280000 port 0x9d280180 irq 119
[    8.380510] ata3: SATA max UDMA/133 abar m524288@0x9d280000 port 0x9d280200 irq 119
[    8.380512] ata4: SATA max UDMA/133 abar m524288@0x9d280000 port 0x9d280280 irq 119
[    8.380513] ata5: SATA max UDMA/133 abar m524288@0x9d280000 port 0x9d280300 irq 119
[    8.380515] ata6: SATA max UDMA/133 abar m524288@0x9d280000 port 0x9d280380 irq 119
[    8.390927] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0xff impl SATA mode
[    8.390929] ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst
[    8.460033] scsi host6: ahci
[    8.460124] scsi host7: ahci
[    8.460204] scsi host8: ahci
[    8.460283] scsi host9: ahci
[    8.460443] scsi host10: ahci
[    8.460536] scsi host11: ahci
[    8.460628] scsi host12: ahci
[    8.460717] scsi host13: ahci
[    8.460755] ata7: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200100 irq 210
[    8.460757] ata8: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200180 irq 210
[    8.460758] ata9: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200200 irq 210
[    8.460760] ata10: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200280 irq 210
[    8.460761] ata11: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200300 irq 210
[    8.460763] ata12: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200380 irq 210
[    8.460764] ata13: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200400 irq 210
[    8.460765] ata14: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200480 irq 210
[    8.461273] tun: Universal TUN/TAP device driver, 1.6
[    8.461391] usbcore: registered new interface driver usb-storage
[    8.461415] i8042: PNP: No PS/2 controller found.
[    8.461467] mousedev: PS/2 mouse device common for all mice
[    8.461520] usbcore: registered new interface driver synaptics_usb
[    8.461591] input: PC Speaker as /devices/platform/pcspkr/input/input1
[    8.461736] rtc_cmos 00:00: RTC can wake from S4
[    8.462034] rtc_cmos 00:00: registered as rtc0
[    8.462093] rtc_cmos 00:00: setting system clock to 2020-06-04T00:16:28 UTC (1591229788)
[    8.462108] rtc_cmos 00:00: alarms up to one month, 114 bytes nvram, hpet irqs
[    8.462121] i2c /dev entries driver
[    8.462156] i801_smbus 0000:00:1f.4: enabling device (0001 -> 0003)
[    8.462231] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    8.462248] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    8.682555] tsc: Refined TSC clocksource calibration: 2499.999 MHz
[    8.682589] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x240938fe3e8, max_idle_ns: 440795307177 ns
[    8.682687] clocksource: Switched to clocksource tsc
[    8.693464] ata3: SATA link down (SStatus 0 SControl 300)
[    8.693486] ata6: SATA link down (SStatus 0 SControl 300)
[    8.693508] ata4: SATA link down (SStatus 0 SControl 300)
[    8.693532] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    8.693557] ata2: SATA link down (SStatus 0 SControl 300)
[    8.693581] ata5: SATA link down (SStatus 0 SControl 300)
[    8.693771] ata1.00: ATAPI: ATAPI   iHAS324   A, BL1P, max UDMA/100
[    8.694430] ata1.00: configured for UDMA/100
[    8.696098] scsi 0:0:0:0: CD-ROM            ATAPI    iHAS324   A      BL1P PQ: 0 ANSI: 5
[    8.768811] sr 0:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    8.768813] cdrom: Uniform CD-ROM driver Revision: 3.20
[    8.769366] sr 0:0:0:0: Attached scsi CD-ROM sr0
[    8.769460] sr 0:0:0:0: Attached scsi generic sg0 type 5
[    8.773277] ata9: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    8.773302] ata11: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    8.773327] ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    8.773353] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    8.773378] ata14: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    8.773404] ata12: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    8.773429] ata10: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    8.773449] ata13: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    8.773663] ata7.00: supports DRM functions and may not be fully accessible
[    8.774541] ata7.00: ATA-11: Samsung SSD 860 PRO 4TB, RVM01B6Q, max UDMA/133
[    8.774545] ata7.00: 8001573552 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    8.774875] ata11.00: ATA-8: HGST HDS724040ALE640, MJAOA580, max UDMA/133
[    8.774877] ata11.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    8.774987] ata12.00: ATA-8: HGST HDS724040ALE640, MJAOA580, max UDMA/133
[    8.774989] ata12.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    8.774997] ata10.00: ATA-8: HGST HDS724040ALE640, MJAOA580, max UDMA/133
[    8.774998] ata10.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    8.775222] ata9.00: supports DRM functions and may not be fully accessible
[    8.775268] ata8.00: supports DRM functions and may not be fully accessible
[    8.776500] ata11.00: configured for UDMA/133
[    8.776641] ata10.00: configured for UDMA/133
[    8.776665] ata12.00: configured for UDMA/133
[    8.776971] ata7.00: supports DRM functions and may not be fully accessible
[    8.779789] ata14.00: ATA-9: HGST HUS726T4TALA6L4, VLGNW460, max UDMA/133
[    8.779793] ata14.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    8.779846] ata7.00: configured for UDMA/133
[    8.779903] ata13.00: ATA-9: HGST HUS726T4TALA6L4, VLGNW460, max UDMA/133
[    8.779904] ata13.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    8.779931] scsi 6:0:0:0: Direct-Access     ATA      Samsung SSD 860  1B6Q PQ: 0 ANSI: 5
[    8.779932] ata9.00: disabling queued TRIM support
[    8.779934] ata9.00: ATA-9: Samsung SSD 850 PRO 1TB, EXM04B6Q, max UDMA/133
[    8.779935] ata9.00: 2000409264 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    8.779991] random: fast init done
[    8.780013] ata8.00: disabling queued TRIM support
[    8.780015] ata8.00: ATA-9: Samsung SSD 850 PRO 1TB, EXM04B6Q, max UDMA/133
[    8.780016] ata8.00: 2000409264 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    8.780039] sd 6:0:0:0: Attached scsi generic sg1 type 0
[    8.780079] ata7.00: Enabling discard_zeroes_data
[    8.780106] sd 6:0:0:0: [sda] 8001573552 512-byte logical blocks: (4.10 TB/3.73 TiB)
[    8.780111] sd 6:0:0:0: [sda] Write Protect is off
[    8.780112] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    8.780119] sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    8.780262] ata7.00: Enabling discard_zeroes_data
[    8.780849] ata7.00: Enabling discard_zeroes_data
[    8.782123] sd 6:0:0:0: [sda] supports TCG Opal
[    8.782126] sd 6:0:0:0: [sda] Attached SCSI disk
[    8.784989] ata9.00: supports DRM functions and may not be fully accessible
[    8.785023] ata8.00: supports DRM functions and may not be fully accessible
[    8.789292] ata14.00: configured for UDMA/133
[    8.789320] ata13.00: configured for UDMA/133
[    8.789758] ata9.00: disabling queued TRIM support
[    8.789784] ata8.00: disabling queued TRIM support
[    8.794627] ata9.00: configured for UDMA/133
[    8.794675] ata8.00: configured for UDMA/133
[    8.794797] scsi 7:0:0:0: Direct-Access     ATA      Samsung SSD 850  4B6Q PQ: 0 ANSI: 5
[    8.794905] sd 7:0:0:0: Attached scsi generic sg2 type 0
[    8.794973] sd 7:0:0:0: [sdb] 2000409264 512-byte logical blocks: (1.02 TB/954 GiB)
[    8.794978] sd 7:0:0:0: [sdb] Write Protect is off
[    8.794979] sd 7:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    8.794989] sd 7:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    8.795000] scsi 8:0:0:0: Direct-Access     ATA      Samsung SSD 850  4B6Q PQ: 0 ANSI: 5
[    8.795130] sd 8:0:0:0: Attached scsi generic sg3 type 0
[    8.795148] sd 8:0:0:0: [sdc] 2000409264 512-byte logical blocks: (1.02 TB/954 GiB)
[    8.795153] sd 8:0:0:0: [sdc] Write Protect is off
[    8.795155] sd 8:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    8.795162] sd 8:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    8.795249] scsi 9:0:0:0: Direct-Access     ATA      HGST HDS724040AL A580 PQ: 0 ANSI: 5
[    8.795400] sd 9:0:0:0: Attached scsi generic sg4 type 0
[    8.795420] sd 9:0:0:0: [sdd] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    8.795422] sd 9:0:0:0: [sdd] 4096-byte physical blocks
[    8.795429] sd 9:0:0:0: [sdd] Write Protect is off
[    8.795431] sd 9:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    8.795442] sd 9:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    8.795499] scsi 10:0:0:0: Direct-Access     ATA      HGST HDS724040AL A580 PQ: 0 ANSI: 5
[    8.795651] sd 10:0:0:0: Attached scsi generic sg5 type 0
[    8.795666] sd 10:0:0:0: [sde] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    8.795668] sd 10:0:0:0: [sde] 4096-byte physical blocks
[    8.795673] sd 10:0:0:0: [sde] Write Protect is off
[    8.795674] sd 10:0:0:0: [sde] Mode Sense: 00 3a 00 00
[    8.795681] sd 10:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    8.795754] scsi 11:0:0:0: Direct-Access     ATA      HGST HDS724040AL A580 PQ: 0 ANSI: 5
[    8.795874] sd 11:0:0:0: Attached scsi generic sg6 type 0
[    8.795897] sd 11:0:0:0: [sdf] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    8.795899] sd 11:0:0:0: [sdf] 4096-byte physical blocks
[    8.795905] sd 11:0:0:0: [sdf] Write Protect is off
[    8.795906] sd 11:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[    8.795910] sd 7:0:0:0: [sdb] supports TCG Opal
[    8.795912] sd 7:0:0:0: [sdb] Attached SCSI disk
[    8.795917] sd 11:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    8.795968] scsi 12:0:0:0: Direct-Access     ATA      HGST HUS726T4TAL W460 PQ: 0 ANSI: 5
[    8.796105] sd 12:0:0:0: [sdg] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    8.796109] sd 12:0:0:0: [sdg] Write Protect is off
[    8.796110] sd 12:0:0:0: Attached scsi generic sg7 type 0
[    8.796112] sd 12:0:0:0: [sdg] Mode Sense: 00 3a 00 00
[    8.796122] sd 12:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    8.796179] sd 8:0:0:0: [sdc] supports TCG Opal
[    8.796180] sd 8:0:0:0: [sdc] Attached SCSI disk
[    8.796209] scsi 13:0:0:0: Direct-Access     ATA      HGST HUS726T4TAL W460 PQ: 0 ANSI: 5
[    8.796312] sd 13:0:0:0: Attached scsi generic sg8 type 0
[    8.796325] sd 13:0:0:0: [sdh] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[    8.796330] sd 13:0:0:0: [sdh] Write Protect is off
[    8.796331] sd 13:0:0:0: [sdh] Mode Sense: 00 3a 00 00
[    8.796338] sd 13:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    8.805763] sd 11:0:0:0: [sdf] Attached SCSI disk
[    8.811116] sd 10:0:0:0: [sde] Attached SCSI disk
[    8.813032] sd 9:0:0:0: [sdd] Attached SCSI disk
[    8.837312]  sdg: sdg1
[    8.837767] sd 12:0:0:0: [sdg] Attached SCSI disk
[    8.839171]  sdh: sdh1
[    8.839710] sd 13:0:0:0: [sdh] Attached SCSI disk
[    9.529353] power_meter ACPI000D:00: Found ACPI power meter.
[    9.529396] power_meter ACPI000D:00: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    9.529631] device-mapper: uevent: version 1.0.3
[    9.529720] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised: dm-devel@redhat.com
[    9.530776] EDAC MC0: Giving out device to module skx_edac controller Skylake Socket#0 IMC#0: DEV 0000:3a:0a.0 (INTERRUPT)
[    9.530819] EDAC MC1: Giving out device to module skx_edac controller Skylake Socket#0 IMC#1: DEV 0000:3a:0c.0 (INTERRUPT)
[    9.530866] EDAC MC2: Giving out device to module skx_edac controller Skylake Socket#1 IMC#0: DEV 0000:ae:0a.0 (INTERRUPT)
[    9.530909] EDAC MC3: Giving out device to module skx_edac controller Skylake Socket#1 IMC#1: DEV 0000:ae:0c.0 (INTERRUPT)
[    9.530913] intel_pstate: Intel P-state driver initializing
[    9.533994] intel_pstate: HWP enabled
[    9.536046] ledtrig-cpu: registered to indicate activity on CPUs
[    9.536366] hid: raw HID events driver (C) Jiri Kosina
[    9.536401] usbcore: registered new interface driver usbhid
[    9.536401] usbhid: USB HID core driver
[    9.536858] intel_rapl_common: Found RAPL domain package
[    9.536865] intel_rapl_common: Found RAPL domain dram
[    9.536867] intel_rapl_common: DRAM domain energy unit 15300pj
[    9.537403] intel_rapl_common: Found RAPL domain package
[    9.537409] intel_rapl_common: Found RAPL domain dram
[    9.537412] intel_rapl_common: DRAM domain energy unit 15300pj
[    9.539344] GACT probability on
[    9.539347] Mirror/redirect action on
[    9.539357] Simple TC action Loaded
[    9.539564] netem: version 1.3
[    9.539581] u32 classifier
[    9.539582]     Performance counters on
[    9.539583]     input device check on
[    9.539584]     Actions configured
[    9.540092] xt_time: kernel timezone is -0000
[    9.540158] ipip: IPv4 and MPLS over IPv4 tunneling driver
[    9.540274] IPv4 over IPsec tunneling driver
[    9.540988] ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
[    9.541125] Initializing XFRM netlink socket
[    9.541283] NET: Registered protocol family 10
[    9.554994] Segment Routing with IPv6
[    9.555051] mip6: Mobile IPv6
[    9.556145] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    9.557350] bpfilter: Loaded bpfilter_umh pid 3727
[    9.557515] NET: Registered protocol family 17
[    9.557525] NET: Registered protocol family 15
[    9.557552] Bridge firewalling registered
[    9.557820] Bluetooth: RFCOMM TTY layer initialized
[    9.557823] Bluetooth: RFCOMM socket layer initialized
[    9.557832] Bluetooth: RFCOMM ver 1.11
[    9.557836] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    9.557837] Bluetooth: BNEP filters: protocol multicast
[    9.557840] Bluetooth: BNEP socket layer initialized
[    9.557841] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    9.557843] Bluetooth: HIDP socket layer initialized
[    9.557881] 8021q: 802.1Q VLAN Support v1.8
[    9.557913] sctp: Hash tables configured (bind 4096/4096)
[    9.558068] Key type dns_resolver registered
[    9.558147] NET: Registered protocol family 40
[    9.563092] microcode: sig=0x50657, pf=0x80, revision=0x500002c
[    9.564722] microcode: Microcode Update Driver: v2.2.
[    9.566885] resctrl: MB allocation detected
[    9.566886] resctrl: L3 monitoring detected
[    9.566891] IPI shorthand broadcast: enabled
[    9.566899] AVX2 version of gcm_enc/dec engaged.
[    9.566900] AES CTR mode by8 optimization enabled
[    9.595782] sched_clock: Marking stable (9596966834, -1198551)->(9637764416, -41996133)
[    9.596237] registered taskstats version 1
[    9.596252] Loading compiled-in X.509 certificates
[    9.596430] Key type ._fscrypt registered
[    9.596432] Key type .fscrypt registered
[    9.596434] Key type fscrypt-provisioning registered
[    9.596902] Btrfs loaded, crc32c=crc32c-intel
[    9.596943] pstore: Using crash dump compression: lz4hc
[    9.604857] Key type big_key registered
[    9.607980] PM:   Magic number: 8:16:253
[    9.608329] acpi device:92: hash matches
[    9.608435] printk: console [netcon0] enabled
[    9.608436] netconsole: network logging started
[    9.610969] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    9.613123] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    9.613191] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    9.613194] cfg80211: failed to load regulatory.db
[    9.613233] ALSA device list:
[    9.613236]   No soundcards found.
[    9.616373] Freeing unused kernel image (initmem) memory: 1784K
[    9.639277] Write protecting the kernel read-only data: 38912k
[    9.640329] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    9.640841] Freeing unused kernel image (rodata/data gap) memory: 1092K
[    9.663206] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    9.663208] Run /init as init process
[    9.663209]   with arguments:
[    9.663210]     /init
[    9.663210]   with environment:
[    9.663211]     HOME=/
[    9.663211]     TERM=linux
[    9.663212]     BOOT_IMAGE=/vmlinuz-5.7.0-rc7-andres-00133-gc8707bf69395
[    9.663212]     apparmor=0
[    9.663213]     intel_iommu=on
[    9.901534] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    9.901948] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    9.903066] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000009810
[    9.903071] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    9.903449] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.07
[    9.903450] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.903452] usb usb1: Product: xHCI Host Controller
[    9.903453] usb usb1: Manufacturer: Linux 5.7.0-rc7-andres-00133-gc8707bf69395 xhci-hcd
[    9.903454] usb usb1: SerialNumber: 0000:00:14.0
[    9.905105] hub 1-0:1.0: USB hub found
[    9.905124] hub 1-0:1.0: 16 ports detected
[    9.908810] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    9.908840] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    9.908843] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    9.908866] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.07
[    9.908867] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.908868] usb usb2: Product: xHCI Host Controller
[    9.908868] usb usb2: Manufacturer: Linux 5.7.0-rc7-andres-00133-gc8707bf69395 xhci-hcd
[    9.908869] usb usb2: SerialNumber: 0000:00:14.0
[    9.908949] hub 2-0:1.0: USB hub found
[    9.908963] hub 2-0:1.0: 10 ports detected
[    9.909417] usb: port power management may be unreliable
[    9.909656] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    9.909811] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 3
[    9.920547] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 5.1.0-k
[    9.920549] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    9.928630] i40e: Intel(R) Ethernet Connection XL710 Network Driver - version 2.8.20-k
[    9.928631] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
[    9.964732] xhci_hcd 0000:02:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x0000000000000010
[    9.964985] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.07
[    9.964986] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    9.964987] usb usb3: Product: xHCI Host Controller
[    9.964988] usb usb3: Manufacturer: Linux 5.7.0-rc7-andres-00133-gc8707bf69395 xhci-hcd
[    9.964989] usb usb3: SerialNumber: 0000:02:00.0
[    9.965159] [drm] P2A bridge disabled, using default configuration
[    9.965159] [drm] AST 2500 detected
[    9.965165] [drm] Analog VGA only
[    9.965172] [drm] dram MCLK=800 Mhz type=1 bus_width=16 size=01000000
[    9.965183] ixgbe 0000:18:00.0: enabling device (0140 -> 0142)
[    9.968972] md127: detected capacity change from 0 to 12001954234368
[    9.972839] [TTM] Zone  kernel: Available graphics memory: 98372568 KiB
[    9.972840] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[    9.972841] [TTM] Initializing pool allocator
[    9.972844] [TTM] Initializing DMA pool allocator
[    9.989284] i40e 0000:61:00.0: fw 3.1.55727 api 1.5 nvm 3.31 0x80000cd9 1.1747.0 [8086:37d1] [15d9:37d1]
[    9.993028] i40e 0000:61:00.0: MAC address: 00:25:90:be:7e:20
[    9.993179] i40e 0000:61:00.0: FW LLDP is enabled
[    9.998026] hub 3-0:1.0: USB hub found
[    9.998033] hub 3-0:1.0: 2 ports detected
[    9.998242] xhci_hcd 0000:02:00.0: xHCI Host Controller
[   10.001306] Console: switching to colour frame buffer device 128x48
[   10.002432] ast 0000:04:00.0: fb0: astdrmfb frame buffer device
[   10.002441] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 4
[   10.002444] xhci_hcd 0000:02:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[   10.002470] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[   10.002483] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.07
[   10.002484] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   10.002485] usb usb4: Product: xHCI Host Controller
[   10.002486] usb usb4: Manufacturer: Linux 5.7.0-rc7-andres-00133-gc8707bf69395 xhci-hcd
[   10.002487] usb usb4: SerialNumber: 0000:02:00.0
[   10.004077] hub 4-0:1.0: USB hub found
[   10.004082] hub 4-0:1.0: 2 ports detected
[   10.005083] i40e 0000:61:00.0 eth0: NIC Link is Up, 1000 Mbps Full Duplex, Flow Control: None
[   10.014982] i40e 0000:61:00.0: Added LAN device PF0 bus=0x61 dev=0x00 func=0x00
[   10.015506] i40e 0000:61:00.0: Features: PF-id[0] VFs: 32 VSIs: 34 QP: 40 RSS FD_ATR FD_SB NTUPLE DCB VxLAN Geneve PTP VEPA
[   10.030218] i40e 0000:61:00.1: fw 3.1.55727 api 1.5 nvm 3.31 0x80000cd9 1.1747.0 [8086:37d1] [15d9:37d1]
[   10.033533] i40e 0000:61:00.1: MAC address: 00:25:90:be:7e:21
[   10.033686] i40e 0000:61:00.1: FW LLDP is enabled
[   10.040600] [drm] amdgpu kernel modesetting enabled.
[   10.040788] CRAT table not found
[   10.040789] Virtual CRAT table created for CPU
[   10.040790] Parsing CRAT table with 2 nodes
[   10.040791] Creating topology SYSFS entries
[   10.040802] Topology: Add CPU node
[   10.040802] Finished initializing topology
[   10.041146] amdgpu 0000:b1:00.0: vgaarb: deactivate vga console
[   10.041169] amdgpu 0000:b1:00.0: enabling device (0146 -> 0147)
[   10.041304] [drm] initializing kernel modesetting (NAVI14 0x1002:0x7340 0x1DA2:0xE421 0xC5).
[   10.041337] [drm] register mmio base: 0xEE500000
[   10.041338] [drm] register mmio size: 524288
[   10.042740] i40e 0000:61:00.1: Added LAN device PF1 bus=0x61 dev=0x00 func=0x01
[   10.043264] i40e 0000:61:00.1: Features: PF-id[1] VFs: 32 VSIs: 34 QP: 40 RSS FD_ATR FD_SB NTUPLE DCB VxLAN Geneve PTP VEPA
[   10.045852] random: crng init done
[   10.056621] [drm] add ip block number 0 <nv_common>
[   10.056623] [drm] add ip block number 1 <gmc_v10_0>
[   10.056624] [drm] add ip block number 2 <navi10_ih>
[   10.056625] [drm] add ip block number 3 <psp>
[   10.056626] [drm] add ip block number 4 <smu>
[   10.056627] [drm] add ip block number 5 <dm>
[   10.056628] [drm] add ip block number 6 <gfx_v10_0>
[   10.056629] [drm] add ip block number 7 <sdma_v5_0>
[   10.056630] [drm] add ip block number 8 <vcn_v2_0>
[   10.056631] [drm] add ip block number 9 <jpeg_v2_0>
[   10.056833] ATOM BIOS: 113-E4210SM-U03
[   10.056848] [drm] VCN decode is enabled in VM mode
[   10.056849] [drm] VCN encode is enabled in VM mode
[   10.056850] [drm] JPEG decode is enabled in VM mode
[   10.056906] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[   10.056913] amdgpu 0000:b1:00.0: VRAM: 8176M 0x0000008000000000 - 0x00000081FEFFFFFF (8176M used)
[   10.056916] amdgpu 0000:b1:00.0: GART: 512M 0x0000000000000000 - 0x000000001FFFFFFF
[   10.056928] [drm] Detected VRAM RAM=8176M, BAR=256M
[   10.056930] [drm] RAM width 128bits GDDR6
[   10.057430] [drm] amdgpu: 8176M of VRAM memory ready
[   10.057439] [drm] amdgpu: 8176M of GTT memory ready.
[   10.057452] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   10.057545] [drm] PCIE GART of 512M enabled (table at 0x0000008000300000).
[   10.057895] amdgpu 0000:b1:00.0: Direct firmware load for amdgpu/navi14_ta.bin failed with error -2
[   10.057898] amdgpu 0000:b1:00.0: psp v11.0: Failed to load firmware "amdgpu/navi14_ta.bin"
[   10.058795] i40e 0000:61:00.1 eno2: renamed from eth1
[   10.059942] [drm] use_doorbell being set to: [true]
[   10.060001] [drm] use_doorbell being set to: [true]
[   10.060201] [drm] Found VCN firmware Version ENC: 1.7 DEC: 4 VEP: 0 Revision: 13
[   10.060205] [drm] PSP loading VCN firmware
[   10.073035] md0: detected capacity change from 0 to 8001299677184
[   10.242608] ixgbe 0000:18:00.0: Multiqueue Enabled: Rx Queue count = 40, Tx Queue count = 40 XDP Queue count = 0
[   10.249264] usb 1-4: new high-speed USB device number 2 using xhci_hcd
[   10.324743] ixgbe 0000:18:00.0: 32.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x8 link)
[   10.396044] usb 1-4: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= b.b3
[   10.396048] usb 1-4: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   10.396678] hub 1-4:1.0: USB hub found
[   10.396703] hub 1-4:1.0: 4 ports detected
[   10.398137] power_meter ACPI000D:00: Found ACPI power meter.
[   10.398187] power_meter ACPI000D:00: Ignoring unsafe software power cap!
[   10.418055] ixgbe 0000:18:00.0: MAC: 3, PHY: 0, PBA No: G54042-008
[   10.418058] ixgbe 0000:18:00.0: 00:1b:21:e2:59:80
[   10.439424] [drm] Initialized ast 0.1.0 20120228 for 0000:04:00.0 on minor 1
[   10.505971] [drm] reserve 0x900000 from 0x81fe400000 for PSP TMR
[   10.506425] i40e 0000:61:00.0 eno1: renamed from eth0
[   10.519223] usb 1-7: new high-speed USB device number 3 using xhci_hcd
[   10.591901] ixgbe 0000:18:00.0: Intel(R) 10 Gigabit Network Connection
[   10.598123] libphy: ixgbe-mdio: probed
[   10.613730] ixgbe 0000:18:00.0 eth10gbe: renamed from eth0
[   10.666552] usb 1-7: New USB device found, idVendor=0557, idProduct=7000, bcdDevice= 0.00
[   10.666556] usb 1-7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   10.667345] hub 1-7:1.0: USB hub found
[   10.667535] hub 1-7:1.0: 4 ports detected
[   10.702663] use vbios provided pptable
[   10.702787] smu driver if version = 0x00000036, smu fw if version = 0x00000034, smu fw version = 0x00351600 (53.22.0)
[   10.702787] SMU driver if version not matched
[   10.739262] usb 1-4.2: new low-speed USB device number 4 using xhci_hcd
[   10.740666] SMU is initialized successfully!
[   10.741006] [drm] Display Core initialized with v3.2.76!
[   10.839466] usb 1-4.2: New USB device found, idVendor=17ef, idProduct=6009, bcdDevice= 1.27
[   10.839470] usb 1-4.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   10.839473] usb 1-4.2: Product: ThinkPad USB Keyboard with TrackPoint
[   10.839475] usb 1-4.2: Manufacturer: Lite-On Technology Corp.
[   10.859253] input: Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.2/1-4.2:1.0/0003:17EF:6009.0001/input/input2
[   10.916212] lenovo 0003:17EF:6009.0001: input,hidraw0: USB HID v1.10 Keyboard [Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint] on usb-0000:00:14.0-4.2/input0
[   10.916966] input: Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.2/1-4.2:1.1/0003:17EF:6009.0002/input/input3
[   10.942597] usb 1-4.3: new full-speed USB device number 5 using xhci_hcd
[   10.976275] lenovo 0003:17EF:6009.0002: input,hiddev0,hidraw1: USB HID v1.10 Mouse [Lite-On Technology Corp. ThinkPad USB Keyboard with TrackPoint] on usb-0000:00:14.0-4.2/input1
[   11.068853] usb 1-4.3: New USB device found, idVendor=0a12, idProduct=0001, bcdDevice=88.91
[   11.068857] usb 1-4.3: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[   11.068859] usb 1-4.3: Product: CSR8510 A10
[   11.070959] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   11.071820] [drm] kiq ring mec 2 pipe 1 q 0
[   11.079799] [drm] VCN decode and encode initialized successfully(under DPG Mode).
[   11.079849] [drm] JPEG decode initialized successfully.
[   11.081599] kfd kfd: Allocated 3969056 bytes on gart
[   11.082463] Virtual CRAT table created for GPU
[   11.082464] Parsing CRAT table with 1 nodes
[   11.082471] Creating topology SYSFS entries
[   11.082607] Topology: Add dGPU node [0x7340:0x1002]
[   11.082611] kfd kfd: added device 1002:7340
[   11.086692] [drm] fb mappable at 0x39BFE04C1000
[   11.086694] [drm] vram apper at 0x39BFE0000000
[   11.086695] [drm] size 14745600
[   11.086696] [drm] fb depth is 24
[   11.086697] [drm]    pitch is 10240
[   11.086837] fbcon: amdgpudrmfb (fb1) is primary device
[   11.086839] fbcon: Remapping primary device, fb1, to tty 1-63
[   11.130704] [drm:mod_hdcp_add_display_to_topology [amdgpu]] *ERROR* Failed to add display topology, DTM TA is not initialized.
[   11.130706] [drm] [Link 0] WARNING MOD_HDCP_STATUS_FAILURE IN STATE HDCP_UNINITIALIZED STAY COUNT 0
[   11.159273] usb 1-7.1: new low-speed USB device number 6 using xhci_hcd
[   11.185810] [drm:mod_hdcp_add_display_to_topology [amdgpu]] *ERROR* Failed to add display topology, DTM TA is not initialized.
[   11.185812] [drm] [Link 0] WARNING MOD_HDCP_STATUS_FAILURE IN STATE HDCP_UNINITIALIZED STAY COUNT 0
[   11.242508] [drm:mod_hdcp_add_display_to_topology [amdgpu]] *ERROR* Failed to add display topology, DTM TA is not initialized.
[   11.242511] [drm] [Link 0] WARNING MOD_HDCP_STATUS_FAILURE IN STATE HDCP_UNINITIALIZED STAY COUNT 0
[   11.277455] usb 1-7.1: New USB device found, idVendor=0557, idProduct=2419, bcdDevice= 1.00
[   11.277459] usb 1-7.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   11.284077] input: HID 0557:2419 as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7.1/1-7.1:1.0/0003:0557:2419.0003/input/input4
[   11.339626] hid-generic 0003:0557:2419.0003: input,hidraw2: USB HID v1.00 Keyboard [HID 0557:2419] on usb-0000:00:14.0-7.1/input0
[   11.341497] input: HID 0557:2419 as /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7.1/1-7.1:1.1/0003:0557:2419.0004/input/input5
[   11.342243] hid-generic 0003:0557:2419.0004: input,hidraw3: USB HID v1.00 Mouse [HID 0557:2419] on usb-0000:00:14.0-7.1/input1
[   11.352602] usb 1-4.4: new full-speed USB device number 7 using xhci_hcd
[   11.447182] usb 1-4.4: New USB device found, idVendor=046d, idProduct=c52b, bcdDevice=12.11
[   11.447186] usb 1-4.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   11.447188] usb 1-4.4: Product: USB Receiver
[   11.447190] usb 1-4.4: Manufacturer: Logitech
[   11.457619] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.4/1-4.4:1.0/0003:046D:C52B.0005/input/input6
[   11.512964] hid-generic 0003:046D:C52B.0005: input,hidraw4: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-0000:00:14.0-4.4/input0
[   11.516569] input: Logitech USB Receiver Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.4/1-4.4:1.1/0003:046D:C52B.0006/input/input7
[   11.516791] input: Logitech USB Receiver Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.4/1-4.4:1.1/0003:046D:C52B.0006/input/input8
[   11.572802] input: Logitech USB Receiver System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.4/1-4.4:1.1/0003:046D:C52B.0006/input/input9
[   11.572942] hid-generic 0003:046D:C52B.0006: input,hiddev1,hidraw5: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:14.0-4.4/input1
[   11.575514] hid-generic 0003:046D:C52B.0007: hiddev2,hidraw6: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-4.4/input2
[   11.916817] logitech-djreceiver 0003:046D:C52B.0007: hiddev1,hidraw4: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-4.4/input2
[   12.032183] input: Logitech Unifying Device. Wireless PID:4069 Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.4/1-4.4:1.2/0003:046D:C52B.0007/0003:046D:4069.0008/input/input11
[   12.032934] input: Logitech Unifying Device. Wireless PID:4069 Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.4/1-4.4:1.2/0003:046D:C52B.0007/0003:046D:4069.0008/input/input12
[   12.033079] input: Logitech Unifying Device. Wireless PID:4069 Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.4/1-4.4:1.2/0003:046D:C52B.0007/0003:046D:4069.0008/input/input13
[   12.033427] input: Logitech Unifying Device. Wireless PID:4069 System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.4/1-4.4:1.2/0003:046D:C52B.0007/0003:046D:4069.0008/input/input14
[   12.033764] hid-generic 0003:046D:4069.0008: input,hidraw5: USB HID v1.11 Keyboard [Logitech Unifying Device. Wireless PID:4069] on usb-0000:00:14.0-4.4/input2:1
[   12.373268] input: Logitech MX Master 2S as /devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.4/1-4.4:1.2/0003:046D:C52B.0007/0003:046D:4069.0008/input/input18
[   12.373575] logitech-hidpp-device 0003:046D:4069.0008: input,hidraw5: USB HID v1.11 Keyboard [Logitech MX Master 2S] on usb-0000:00:14.0-4.4/input2:1
[   12.932048] amdgpu 0000:b1:00.0: fb1: amdgpudrmfb frame buffer device
[   12.932126] amdgpu 0000:b1:00.0: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[   12.932127] amdgpu 0000:b1:00.0: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[   12.932128] amdgpu 0000:b1:00.0: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[   12.932129] amdgpu 0000:b1:00.0: ring comp_1.2.0 uses VM inv eng 5 on hub 0
[   12.932130] amdgpu 0000:b1:00.0: ring comp_1.3.0 uses VM inv eng 6 on hub 0
[   12.932131] amdgpu 0000:b1:00.0: ring comp_1.0.1 uses VM inv eng 7 on hub 0
[   12.932131] amdgpu 0000:b1:00.0: ring comp_1.1.1 uses VM inv eng 8 on hub 0
[   12.932132] amdgpu 0000:b1:00.0: ring comp_1.2.1 uses VM inv eng 9 on hub 0
[   12.932133] amdgpu 0000:b1:00.0: ring comp_1.3.1 uses VM inv eng 10 on hub 0
[   12.932133] amdgpu 0000:b1:00.0: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
[   12.932134] amdgpu 0000:b1:00.0: ring sdma0 uses VM inv eng 12 on hub 0
[   12.932135] amdgpu 0000:b1:00.0: ring sdma1 uses VM inv eng 13 on hub 0
[   12.932136] amdgpu 0000:b1:00.0: ring vcn_dec uses VM inv eng 0 on hub 1
[   12.932137] amdgpu 0000:b1:00.0: ring vcn_enc0 uses VM inv eng 1 on hub 1
[   12.932137] amdgpu 0000:b1:00.0: ring vcn_enc1 uses VM inv eng 4 on hub 1
[   12.932138] amdgpu 0000:b1:00.0: ring jpeg_dec uses VM inv eng 5 on hub 1
[   12.932677] [drm] Initialized amdgpu 3.37.0 20150101 for 0000:b1:00.0 on minor 2
[   13.040037] process '/usr/bin/ipconfig' started with executable stack
[   13.126514] 8021q: adding VLAN 0 to HW filter on device eno2
[   13.336369] pps pps0: new PPS source ptp2
[   13.336428] ixgbe 0000:18:00.0: registered PHC device on eth10gbe
[   13.472425] 8021q: adding VLAN 0 to HW filter on device eth10gbe
[   13.538113] 8021q: adding VLAN 0 to HW filter on device eno1
[   13.538151] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready
[   18.630132] ixgbe 0000:18:00.0 eth10gbe: NIC Link is Up 10 Gbps, Flow Control: None
[   18.630303] IPv6: ADDRCONF(NETDEV_CHANGE): eth10gbe: link becomes ready
[   20.815167] PM: Image not found (code -22)
[   20.875759] EXT4-fs (dm-2): mounted filesystem with ordered data mode. Opts: (null)
[   21.038733] ixgbe 0000:18:00.0: removed PHC on eth10gbe
[   21.618382] systemd[1]: systemd 245.5-3 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[   21.632754] systemd[1]: Detected architecture x86-64.
[   21.632995] systemd[1]: Set hostname to <awork3>.
[   21.894279] systemd[1]: Created slice Virtual Machine and Container Slice.
[   21.894468] systemd[1]: Created slice system-getty.slice.
[   21.894558] systemd[1]: Created slice system-modprobe.slice.
[   21.894643] systemd[1]: Created slice system-postfix.slice.
[   21.894734] systemd[1]: Created slice system-serial\x2dgetty.slice.
[   21.894819] systemd[1]: Created slice Cryptsetup Units Slice.
[   21.894905] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   21.894976] systemd[1]: Created slice User and Session Slice.
[   21.895025] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   21.895174] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   21.895243] systemd[1]: Reached target User and Group Name Lookups.
[   21.895254] systemd[1]: Reached target Remote File Systems.
[   21.895264] systemd[1]: Reached target Slices.
[   21.895283] systemd[1]: Reached target Libvirt guests shutdown.
[   21.895335] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   21.895409] systemd[1]: Listening on LVM2 poll daemon socket.
[   21.895468] systemd[1]: Listening on Syslog Socket.
[   21.895524] systemd[1]: Listening on fsck to fsckd communication Socket.
[   21.895555] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   21.896083] systemd[1]: Listening on Journal Audit Socket.
[   21.896126] systemd[1]: Listening on Journal Socket (/dev/log).
[   21.896185] systemd[1]: Listening on Journal Socket.
[   21.896237] systemd[1]: Listening on udev Control Socket.
[   21.896266] systemd[1]: Listening on udev Kernel Socket.
[   21.896764] systemd[1]: Mounting Huge Pages File System...
[   21.897295] systemd[1]: Mounting POSIX Message Queue File System...
[   21.897942] systemd[1]: Mounting Kernel Debug File System...
[   21.898553] systemd[1]: Mounting Kernel Trace File System...
[   21.899183] systemd[1]: Starting Availability of block devices...
[   21.899797] systemd[1]: Starting Set the console keyboard layout...
[   21.902701] systemd[1]: Starting Create list of static device nodes for the current kernel...
[   21.903740] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[   21.903810] systemd[1]: Condition check resulted in Load Kernel Module drm being skipped.
[   21.904871] systemd[1]: Started Nameserver information manager.
[   21.905151] systemd[1]: Reached target Network (Pre).
[   21.905701] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
[   21.905777] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
[   21.908066] systemd[1]: Starting Journal Service...
[   21.909661] systemd[1]: Starting Load Kernel Modules...
[   21.910664] systemd[1]: Starting Remount Root and Kernel File Systems...
[   21.911804] systemd[1]: Starting udev Coldplug all Devices...
[   21.914372] systemd[1]: Mounted Huge Pages File System.
[   21.914581] systemd[1]: Mounted POSIX Message Queue File System.
[   21.914762] systemd[1]: Mounted Kernel Debug File System.
[   21.914934] systemd[1]: Mounted Kernel Trace File System.
[   21.915292] systemd[1]: Finished Availability of block devices.
[   21.915725] systemd[1]: Finished Set the console keyboard layout.
[   21.916020] systemd[1]: Finished Create list of static device nodes for the current kernel.
[   21.932416] EXT4-fs (dm-2): re-mounted. Opts: errors=remount-ro
[   21.933894] systemd[1]: Finished Remount Root and Kernel File Systems.
[   21.934335] systemd[1]: Finished Load Kernel Modules.
[   21.935336] systemd[1]: Mounting FUSE Control File System...
[   21.936279] systemd[1]: Mounting Kernel Configuration File System...
[   21.937139] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
[   21.937208] systemd[1]: Condition check resulted in Platform Persistent Storage Archival being skipped.
[   21.938142] systemd[1]: Starting Load/Save Random Seed...
[   21.939110] systemd[1]: Starting Apply Kernel Variables...
[   21.940143] systemd[1]: Starting Create System Users...
[   21.942401] systemd[1]: Mounted FUSE Control File System.
[   21.942671] systemd[1]: Mounted Kernel Configuration File System.
[   21.954418] systemd[1]: Finished Load/Save Random Seed.
[   21.957451] systemd[1]: Finished Apply Kernel Variables.
[   21.960015] systemd[1]: Finished Create System Users.
[   21.961071] systemd[1]: Starting Create Static Device Nodes in /dev...
[   21.975201] systemd[1]: Finished Create Static Device Nodes in /dev.
[   21.976655] systemd[1]: Starting udev Kernel Device Manager...
[   22.017901] systemd[1]: Finished Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling.
[   22.018154] systemd[1]: Reached target Local File Systems (Pre).
[   22.019395] systemd[1]: Mounting Mount unit for chromium, revision 1143...
[   22.020624] systemd[1]: Mounting Mount unit for chromium, revision 1165...
[   22.022025] systemd[1]: Mounting Mount unit for core18, revision 1705...
[   22.023302] systemd[1]: Mounting Mount unit for core18, revision 1754...
[   22.024577] systemd[1]: Mounting Mount unit for gtk-common-themes, revision 1502...
[   22.025744] systemd[1]: Mounting Mount unit for gtk-common-themes, revision 1506...
[   22.026945] systemd[1]: Mounting Mount unit for kde-frameworks-5-qt-5-14-core18, revision 4...
[   22.028488] systemd[1]: Mounting Mount unit for kdenlive, revision 24...
[   22.029788] systemd[1]: Mounting Mount unit for snapd, revision 7264...
[   22.031095] systemd[1]: Mounting Mount unit for snapd, revision 7777...
[   22.032226] systemd[1]: Mounting Mount unit for zoom-client, revision 83...
[   22.033309] systemd[1]: Mounting Mount unit for zoom-client, revision 84...
[   22.033384] systemd[1]: Condition check resulted in Virtual Machine and Container Storage (Compatibility) being skipped.
[   22.033434] systemd[1]: Reached target Containers.
[   22.052754] systemd[1]: Finished udev Coldplug all Devices.
[   22.054052] systemd[1]: Starting Helper to synchronize boot up for ifupdown...
[   22.056979] systemd[1]: Started udev Kernel Device Manager.
[   22.058030] systemd[1]: Starting Show Plymouth Boot Screen...
[   22.080367] systemd[1]: Started Show Plymouth Boot Screen.
[   22.080540] systemd[1]: Condition check resulted in Dispatch Password Requests to Console Directory Watch being skipped.
[   22.080640] systemd[1]: Started Forward Password Requests to Plymouth Directory Watch.
[   22.215803] mei_me 0000:00:16.0: Device doesn't have valid ME Interface
[   22.233260] iTCO_vendor_support: vendor-support=0
[   22.237024] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   22.237209] iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
[   22.273687] systemd[1]: Found device Samsung_SSD_860_PRO_4TB awork3-boring-crypt.
[   22.276579] systemd[1]: Starting Cryptography Setup for awork3-boring_crypt...
[   22.303532] systemd[1]: Found device SAMSUNG MZVLB1T0HBLR-000L7.
[   22.326468] systemd[1]: Found device Samsung SSD 970 PRO 1TB.
[   22.333198] systemd[1]: Found device Samsung SSD 970 PRO 1TB awork3-root-crypt.
[   22.334191] systemd[1]: Condition check resulted in Dispatch Password Requests to Console Directory Watch being skipped.
[   22.336288] systemd[1]: Started Forward Password Requests to Plymouth.
[   22.336522] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
[   22.338624] systemd[1]: Starting Cryptography Setup for nvme0n1p3_crypt...
[   22.338657] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
[   22.341285] systemd[1]: Starting File System Check on /dev/disk/by-uuid/0d38984e-69ab-485a-9bf8-f8ef937eb986...
[   22.345223] systemd[1]: Starting File System Check on /dev/disk/by-uuid/61565612-356a-4e94-9485-4fe5993532ed...
[   22.345291] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
[   22.345478] systemd[1]: Condition check resulted in Platform Persistent Storage Archival being skipped.
[   22.352815] systemd[1]: Finished Cryptography Setup for nvme0n1p3_crypt.
[   22.356865] systemd[1]: Found device Samsung SSD 970 PRO 1TB 1.
[   22.357788] EFI Variables Facility v0.08 2004-May-17
[   22.365604] systemd[1]: Found device Samsung SSD 970 PRO 1TB boot.
[   22.370601] systemd[1]: Found device /dev/ttyS1.
[   22.373784] systemd[1]: Finished File System Check on /dev/disk/by-uuid/0d38984e-69ab-485a-9bf8-f8ef937eb986.
[   22.374818] systemd[1]: Finished File System Check on /dev/disk/by-uuid/61565612-356a-4e94-9485-4fe5993532ed.
[   22.375840] usbcore: registered new interface driver btusb
[   22.378136] Intel(R) Wireless WiFi driver for Linux
[   22.378137] Copyright(c) 2003- 2015 Intel Corporation
[   22.378590] systemd[1]: Reached target Block Device Preparation for /dev/mapper/nvme0n1p3_crypt.
[   22.378788] iwlwifi 0000:d8:00.0: enabling device (0140 -> 0142)
[   22.379761] snd_hda_intel 0000:00:1f.3: enabling device (0140 -> 0142)
[   22.379923] systemd[1]: Mounting /home/andres/other...
[   22.380311] snd_hda_intel 0000:b1:00.1: enabling device (0140 -> 0142)
[   22.380564] snd_hda_intel 0000:b1:00.1: Force to non-snoop mode
[   22.380729] systemd[1]: Mounting /srv/dev...
[   22.381609] systemd[1]: Starting File System Check on /dev/disk/by-uuid/626c74ab-3a73-4c1f-84bd-5f35703272a3...
[   22.381962] XFS (nvme0n1): Mounting V5 Filesystem
[   22.382627] systemd[1]: Starting File System Check on /dev/disk/by-uuid/8450-27D6...
[   22.383149] XFS (nvme1n1): Mounting V5 Filesystem
[   22.383292] systemd[1]: Started File System Check Daemon to report status.
[   22.385088] systemd[1]: Found device Ethernet Controller 10-Gigabit X540-AT2 (Ethernet Converged Network Adapter X540-T1).
[   22.385717] iwlwifi 0000:d8:00.0: loaded firmware version 36.8fd77bb3.0 8265-36.ucode op_mode iwlmvm
[   22.385742] iwlwifi 0000:d8:00.0: Direct firmware load for iwl-debug-yoyo.bin failed with error -2
[   22.390830] XFS (nvme0n1): Ending clean mount
[   22.392132] snd_hda_intel 0000:b1:00.1: bound 0000:b1:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[   22.392259] xfs filesystem being mounted at /home/andres/other supports timestamps until 2038 (0x7fffffff)
[   22.392777] XFS (nvme1n1): Ending clean mount
[   22.393353] systemd[1]: Mounted /home/andres/other.
[   22.393425] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:ae/0000:ae:00.0/0000:af:00.0/0000:b0:00.0/0000:b1:00.1/sound/card1/input19
[   22.393622] input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:ae/0000:ae:00.0/0000:af:00.0/0000:b0:00.0/0000:b1:00.1/sound/card1/input20
[   22.393803] input: HDA ATI HDMI HDMI/DP,pcm=8 as /devices/pci0000:ae/0000:ae:00.0/0000:af:00.0/0000:b0:00.0/0000:b1:00.1/sound/card1/input21
[   22.393994] input: HDA ATI HDMI HDMI/DP,pcm=9 as /devices/pci0000:ae/0000:ae:00.0/0000:af:00.0/0000:b0:00.0/0000:b1:00.1/sound/card1/input22
[   22.394025] input: HDA ATI HDMI HDMI/DP,pcm=10 as /devices/pci0000:ae/0000:ae:00.0/0000:af:00.0/0000:b0:00.0/0000:b1:00.1/sound/card1/input23
[   22.394199] input: HDA ATI HDMI HDMI/DP,pcm=11 as /devices/pci0000:ae/0000:ae:00.0/0000:af:00.0/0000:b0:00.0/0000:b1:00.1/sound/card1/input24
[   22.394585] xfs filesystem being mounted at /srv/dev supports timestamps until 2038 (0x7fffffff)
[   22.396384] systemd[1]: Mounted /srv/dev.
[   22.397457] systemd[1]: Found device Ethernet Connection X722 for 1GbE.
[   22.398345] systemd[1]: Found device Ethernet Connection X722 for 1GbE.
[   22.409528] systemd[1]: Finished File System Check on /dev/disk/by-uuid/626c74ab-3a73-4c1f-84bd-5f35703272a3.
[   22.410567] systemd[1]: Mounting /boot...
[   22.411431] systemd[1]: Finished File System Check on /dev/disk/by-uuid/8450-27D6.
[   22.415824] EXT4-fs (nvme2n1p2): mounted filesystem with ordered data mode. Opts: (null)
[   22.418119] systemd[1]: Mounted /boot.
[   22.419573] systemd[1]: Mounting /boot/efi...
[   22.499115] systemd[1]: Started Journal Service.
[   22.517094] systemd-journald[4352]: Received client request to flush runtime journal.
[   22.550161] loop: module loaded
[   22.577849] iwlwifi 0000:d8:00.0: Detected Intel(R) Dual Band Wireless AC 8265, REV=0x230
[   22.582595] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC888-VD: line_outs=3 (0x14/0x15/0x16/0x0/0x0) type:line
[   22.582599] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   22.582602] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   22.582603] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   22.582605] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x11/0x1e
[   22.582607] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   22.582610] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[   22.582612] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[   22.582614] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[   22.582615] snd_hda_codec_realtek hdaudioC0D0:    dig-in=0x1f
[   22.593364] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   22.635873] iwlwifi 0000:d8:00.0: base HW address: a0:a4:c5:6a:5c:c0
[   22.647306] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input25
[   22.647399] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input26
[   22.647473] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.3/sound/card0/input27
[   22.647545] input: HDA Intel PCH Line Out Front as /devices/pci0000:00/0000:00:1f.3/sound/card0/input28
[   22.647617] input: HDA Intel PCH Line Out Surround as /devices/pci0000:00/0000:00:1f.3/sound/card0/input29
[   22.647686] input: HDA Intel PCH Line Out CLFE as /devices/pci0000:00/0000:00:1f.3/sound/card0/input30
[   22.647761] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input31
[   22.710906] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[   22.711577] thermal thermal_zone2: failed to read out thermal zone (-61)
[   24.426735] ata7.00: Enabling discard_zeroes_data
[   25.795938] Adding 62496764k swap on /dev/mapper/awork3--vg-swap.  Priority:-2 extents:1 across:62496764k SSFS
[   25.946209] iwlwifi 0000:d8:00.0 wifi0: renamed from wlan0
[   25.962177] EXT4-fs (md0): mounted filesystem with ordered data mode. Opts: (null)
[   26.325767] EXT4-fs (dm-5): mounted filesystem with ordered data mode. Opts: errors=remount-ro
[   26.406771] irq 347: Affinity broken due to vector space exhaustion.
[   26.406790] irq 348: Affinity broken due to vector space exhaustion.
[   26.406807] irq 349: Affinity broken due to vector space exhaustion.
[   26.406823] irq 350: Affinity broken due to vector space exhaustion.
[   26.406839] irq 351: Affinity broken due to vector space exhaustion.
[   26.406855] irq 352: Affinity broken due to vector space exhaustion.
[   26.406872] irq 353: Affinity broken due to vector space exhaustion.
[   26.406888] irq 354: Affinity broken due to vector space exhaustion.
[   26.406904] irq 355: Affinity broken due to vector space exhaustion.
[   26.406920] irq 356: Affinity broken due to vector space exhaustion.
[   26.407064] irq 367: Affinity broken due to vector space exhaustion.
[   26.407090] irq 368: Affinity broken due to vector space exhaustion.
[   26.407106] irq 369: Affinity broken due to vector space exhaustion.
[   26.407122] irq 370: Affinity broken due to vector space exhaustion.
[   26.407138] irq 371: Affinity broken due to vector space exhaustion.
[   26.407153] irq 372: Affinity broken due to vector space exhaustion.
[   26.407171] irq 373: Affinity broken due to vector space exhaustion.
[   26.407187] irq 374: Affinity broken due to vector space exhaustion.
[   26.407203] irq 375: Affinity broken due to vector space exhaustion.
[   26.407219] irq 376: Affinity broken due to vector space exhaustion.
[   26.407829] 8021q: adding VLAN 0 to HW filter on device eno2
[   26.419529] irq 232: Affinity broken due to vector space exhaustion.
[   26.419545] irq 233: Affinity broken due to vector space exhaustion.
[   26.419561] irq 234: Affinity broken due to vector space exhaustion.
[   26.419576] irq 235: Affinity broken due to vector space exhaustion.
[   26.419591] irq 236: Affinity broken due to vector space exhaustion.
[   26.419606] irq 237: Affinity broken due to vector space exhaustion.
[   26.419622] irq 238: Affinity broken due to vector space exhaustion.
[   26.419637] irq 239: Affinity broken due to vector space exhaustion.
[   26.419653] irq 240: Affinity broken due to vector space exhaustion.
[   26.419668] irq 241: Affinity broken due to vector space exhaustion.
[   26.419805] irq 252: Affinity broken due to vector space exhaustion.
[   26.419820] irq 253: Affinity broken due to vector space exhaustion.
[   26.419835] irq 254: Affinity broken due to vector space exhaustion.
[   26.419850] irq 255: Affinity broken due to vector space exhaustion.
[   26.419866] irq 256: Affinity broken due to vector space exhaustion.
[   26.419881] irq 257: Affinity broken due to vector space exhaustion.
[   26.419897] irq 258: Affinity broken due to vector space exhaustion.
[   26.419912] irq 259: Affinity broken due to vector space exhaustion.
[   26.419927] irq 260: Affinity broken due to vector space exhaustion.
[   26.419942] irq 261: Affinity broken due to vector space exhaustion.
[   26.420612] 8021q: adding VLAN 0 to HW filter on device eno1
[   26.585107] irq 472: Affinity broken due to vector space exhaustion.
[   26.585123] irq 473: Affinity broken due to vector space exhaustion.
[   26.585137] irq 474: Affinity broken due to vector space exhaustion.
[   26.585150] irq 475: Affinity broken due to vector space exhaustion.
[   26.585164] irq 476: Affinity broken due to vector space exhaustion.
[   26.585179] irq 477: Affinity broken due to vector space exhaustion.
[   26.585193] irq 478: Affinity broken due to vector space exhaustion.
[   26.585206] irq 479: Affinity broken due to vector space exhaustion.
[   26.585220] irq 480: Affinity broken due to vector space exhaustion.
[   26.585234] irq 481: Affinity broken due to vector space exhaustion.
[   26.585248] irq 482: Affinity broken due to vector space exhaustion.
[   26.585262] irq 483: Affinity broken due to vector space exhaustion.
[   26.585276] irq 484: Affinity broken due to vector space exhaustion.
[   26.585289] irq 485: Affinity broken due to vector space exhaustion.
[   26.585303] irq 486: Affinity broken due to vector space exhaustion.
[   26.585316] irq 487: Affinity broken due to vector space exhaustion.
[   26.585329] irq 488: Affinity broken due to vector space exhaustion.
[   26.585342] irq 489: Affinity broken due to vector space exhaustion.
[   26.585355] irq 490: Affinity broken due to vector space exhaustion.
[   26.585369] irq 491: Affinity broken due to vector space exhaustion.
[   26.585530] pps pps0: new PPS source ptp2
[   26.585589] ixgbe 0000:18:00.0: registered PHC device on eth10gbe
[   26.708082] 8021q: adding VLAN 0 to HW filter on device eth10gbe
[   26.708279] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready
[   31.633829] ixgbe 0000:18:00.0 eth10gbe: NIC Link is Up 10 Gbps, Flow Control: None
[   31.634015] IPv6: ADDRCONF(NETDEV_CHANGE): eth10gbe: link becomes ready
[   31.638410] ixgbe 0000:18:00.0 eth10gbe: NIC Link is Down
[   32.946004] ixgbe 0000:18:00.0 eth10gbe: NIC Link is Up 10 Gbps, Flow Control: None
[   33.342040] wifi0: authenticate with 16:91:82:b8:29:61
[   33.347275] wifi0: send auth to 16:91:82:b8:29:61 (try 1/3)
[   33.352345] wifi0: authenticated
[   33.355925] wifi0: associate with 16:91:82:b8:29:61 (try 1/3)
[   33.385075] wifi0: RX AssocResp from 16:91:82:b8:29:61 (capab=0x11 status=0 aid=2)
[   33.387318] wifi0: associated
[   33.419695] IPv6: ADDRCONF(NETDEV_CHANGE): wifi0: link becomes ready
[   39.800564] rfkill: input handler disabled
[  125.526092] tee (7775): drop_caches: 3
[  146.264327] kill_fasync: bad magic number in fasync_struct!
[  146.264327] kill_fasync: bad magic number in fasync_struct!
[  146.285175] kill_fasync: bad magic number in fasync_struct!
[  146.290793] kill_fasync: bad magic number in fasync_struct!
[  146.285175] kill_fasync: bad magic number in fasync_struct!
[  146.290793] kill_fasync: bad magic number in fasync_struct!
[  157.071979] BUG: kernel NULL pointer dereference, address: 0000000000000020
[  157.078945] #PF: supervisor read access in kernel mode
[  157.084082] #PF: error_code(0x0000) - not-present page
[  157.089225] PGD 0 P4D 0
[  157.091763] Oops: 0000 [#1] SMP NOPTI
[  157.095429] CPU: 3 PID: 7756 Comm: postgres Not tainted 5.7.0-rc7-andres-00133-gc8707bf69395 #41
[  157.104208] Hardware name: Supermicro SYS-7049A-T/X11DAi-N, BIOS 3.2 11/13/2019
[  157.111518] RIP: 0010:xfs_log_commit_cil+0x356/0x7f0
[  157.116478] Code: 00 00 48 89 7e 08 49 89 76 30 48 89 11 48 89 4a 08 8b 4c 24 2c 48 89 85 c0 00 00 00 48 89 85 c8 00 00 00 49 8b 46 20 45 31 c9 <8b> 70 20 85 f6 0f 84 d9 02 00 00 45 31 c0 85 c9 7e 4f 41 8b 46 2c
[  157.135226] RSP: 0018:ffffc90021fefb00 EFLAGS: 00010246
[  157.140452] RAX: 0000000000000000 RBX: ffff8897a9ea80b0 RCX: 0000000000000458
[  157.147582] RDX: ffff8897a9ea80c0 RSI: ffff88afc39a1200 RDI: ffff88afb1ae2c18
[  157.154715] RBP: ffff8897a9ea8000 R08: ffffc90021fefb30 R09: 0000000000000000
[  157.161848] R10: 0000000000000084 R11: 0000000000000012 R12: ffff8897721bd400
[  157.168983] R13: ffff88afb1ae2c00 R14: ffff88afb19860c0 R15: ffff8897a9ea80a0
[  157.176115] FS:  00007ffbbe9a1980(0000) GS:ffff8897e0cc0000(0000) knlGS:0000000000000000
[  157.184199] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  157.189946] CR2: 0000000000000020 CR3: 000000179c0ac005 CR4: 00000000007606e0
[  157.197081] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  157.204212] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  157.211343] PKRU: 55555554
[  157.214048] Call Trace:
[  157.216498]  __xfs_trans_commit+0xa1/0x340
[  157.220596]  xfs_create+0x4cc/0x5e0
[  157.224087]  xfs_generic_create+0x241/0x310
[  157.228274]  path_openat+0xdb7/0x1020
[  157.231940]  do_filp_open+0x91/0x100
[  157.235518]  ? __sys_recvfrom+0xe4/0x170
[  157.239444]  ? _cond_resched+0x19/0x30
[  157.243196]  do_sys_openat2+0x215/0x2d0
[  157.247037]  do_sys_open+0x44/0x80
[  157.250443]  do_syscall_64+0x48/0x130
[  157.254108]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  157.259161] RIP: 0033:0x7ffbc0ded307
[  157.262738] Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85 c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 33 0c 25
[  157.281485] RSP: 002b:00007fff520a4940 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[  157.289052] RAX: ffffffffffffffda RBX: 00005561dc02eca0 RCX: 00007ffbc0ded307
[  157.296185] RDX: 0000000000000241 RSI: 00005561dc013470 RDI: 00000000ffffff9c
[  157.303317] RBP: 00005561dc013470 R08: 0000000000000004 R09: 0000000000000001
[  157.310447] R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000241
[  157.317575] R13: 00005561dc02eca0 R14: 0000000000000001 R15: 0000000000000000
[  157.324705] Modules linked in: isst_if_common squashfs nls_iso8859_1 nls_cp437 snd_hda_codec_realtek vfat snd_hda_codec_generic fat iwlmvm ledtrig_audio snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp snd_hda_intel snd_intel_dspcfg iwlwifi efi_pstore btusb snd_hda_codec btrtl btbcm efivars snd_hwdep btintel snd_hda_core iTCO_wdt iTCO_vendor_support mei_me mei loop coretemp hid_logitech_hidpp hid_logitech_dj hid_lenovo amdgpu gpu_sched i40e ixgbe ast drm_vram_helper drm_ttm_helper ttm mdio xhci_pci xhci_hcd
[  157.370249] CR2: 0000000000000020
[  157.373569] ---[ end trace 563634e2f1b39798 ]---
[  158.079256] RIP: 0010:xfs_log_commit_cil+0x356/0x7f0
[  158.084219] Code: 00 00 48 89 7e 08 49 89 76 30 48 89 11 48 89 4a 08 8b 4c 24 2c 48 89 85 c0 00 00 00 48 89 85 c8 00 00 00 49 8b 46 20 45 31 c9 <8b> 70 20 85 f6 0f 84 d9 02 00 00 45 31 c0 85 c9 7e 4f 41 8b 46 2c
[  158.102964] RSP: 0018:ffffc90021fefb00 EFLAGS: 00010246
[  158.108192] RAX: 0000000000000000 RBX: ffff8897a9ea80b0 RCX: 0000000000000458
[  158.115322] RDX: ffff8897a9ea80c0 RSI: ffff88afc39a1200 RDI: ffff88afb1ae2c18
[  158.122455] RBP: ffff8897a9ea8000 R08: ffffc90021fefb30 R09: 0000000000000000
[  158.129590] R10: 0000000000000084 R11: 0000000000000012 R12: ffff8897721bd400
[  158.136722] R13: ffff88afb1ae2c00 R14: ffff88afb19860c0 R15: ffff8897a9ea80a0
[  158.143855] FS:  00007ffbbe9a1980(0000) GS:ffff8897e0cc0000(0000) knlGS:0000000000000000
[  158.151939] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  158.157685] CR2: 0000000000000020 CR3: 000000179c0ac005 CR4: 00000000007606e0
[  158.164810] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  158.171942] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  158.179074] PKRU: 55555554
[  157.071979] BUG: kernel NULL pointer dereference, address: 0000000000000020
[  157.078945] #PF: supervisor read access in kernel mode
[  157.084082] #PF: error_code(0x0000) - not-present page
[  157.089225] PGD 0 P4D 0
[  157.091763] Oops: 0000 [#1] SMP NOPTI
[  157.095429] CPU: 3 PID: 7756 Comm: postgres Not tainted 5.7.0-rc7-andres-00133-gc8707bf69395 #41
[  157.104208] Hardware name: Supermicro SYS-7049A-T/X11DAi-N, BIOS 3.2 11/13/2019
[  157.111518] RIP: 0010:xfs_log_commit_cil+0x356/0x7f0
[  157.116478] Code: 00 00 48 89 7e 08 49 89 76 30 48 89 11 48 89 4a 08 8b 4c 24 2c 48 89 85 c0 00 00 00 48 89 85[  158.235406] BUG: unable to handle page fault for address: 0000000000843f70
 c8[ 00 00 00 49   158.242834] #PF: supervisor write access in kernel mode
[  158.249442] #PF: error_code(0x0002) - not-present page
8b 46 20 45 31 c[  158.254582] PGD 0 P4D 0
[  158.258500] Oops: 0002 [#2] SMP NOPTI
9 <[8b> 70 20 85   158.262167] CPU: 21 PID: 7839 Comm: postgres Tainted: G      D           5.7.0-rc7-andres-00133-gc8707bf69395 #41
[  158.273804] Hardware name: Supermicro SYS-7049A-T/X11DAi-N, BIOS 3.2 11/13/2019
f6 0f 84 d9 02 0[  158.281116] RIP: 0010:queued_spin_lock_slowpath+0x16c/0x1a0
[  158.288064] Code: 8b 02 48 85 c0 74 f6 48 89 c6 eb e5 c1 ee 12 83 e0 03 83 ee 01 48 c1 e0 04 48 63 f6 48 05 c0 c1 02 00 48 03 04 f5 c0 86 fc 82 <48> 89 10 8b 42 08 85 c0 75 09 f3 90 8b 42 08 85 c0 74 f7 48 8b 02
0 0[0 45 31 c0 85  158.306810] RSP: 0018:ffffc9002116fe20 EFLAGS: 00010002
[  158.313421] RAX: 0000000000843f70 RBX: ffff8897d87924e0 RCX: 0000000000580000
 c[9 7e 4f 41 8b   158.320555] RDX: ffff8897e0eec1c0 RSI: 0000000000001201 RDI: ffff88afd7957a60
[  158.329073] RBP: ffff88afd7957a60 R08: 0000000000580000 R09: 0000000000000000
46[ 2c
[  157.13  158.336207] R10: ffff88afd70bfce0 R11: 0000000000000000 R12: 0000000000000286
[  158.344724] R13: dead000000000122 R14: dead000000000100 R15: ffff88afd639e000
522[6] RSP: 0018:  158.351860] FS:  00007ffbbe9a1980(0000) GS:ffff8897e0ec0000(0000) knlGS:0000000000000000
[  158.361331] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
ff[ffc90021fefb00  158.367078] CR2: 0000000000843f70 CR3: 0000002fd67a2004 CR4: 00000000007606e0
[  158.375598] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 E[FLAGS: 0001024  158.382737] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  158.391256] PKRU: 55555554
6[
[  157.140452  158.393968] Call Trace:
] R[AX: 000000000  158.397813]  _raw_spin_lock_irqsave+0x25/0x30
00[00000 RBX: fff  158.403559]  remove_wait_queue+0x12/0x50
f8[897a9ea80b0 RC  158.408873]  ep_unregister_pollwait.isra.0+0x5e/0x80
X:[ 0000000000000  158.415235]  ep_free+0x4e/0xd0
[  158.419684]  ep_eventpoll_release+0x16/0x20
458
[  157.1475[  158.423874]  __fput+0xda/0x240
82[] RDX: ffff889  158.428312]  task_work_run+0x5f/0x90
7a[9ea80c0 RSI: f  158.433285]  exit_to_usermode_loop+0xbd/0xe0
ff[f88afc39a1200   158.438944]  do_syscall_64+0xf2/0x130
RD[I: ffff88afb1a  158.443998]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  158.450437] RIP: 0033:0x7ffbc1aa0f13
e2c[18
[  157.15  158.454012] Code: 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
[  158.474138] RSP: 002b:00007fff520a4a48 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
471[5] RBP: ffff8  158.481705] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 00007ffbc1aa0f13
[  158.490222] RDX: 0000000000000002 RSI: 00005561dc0333c0 RDI: 0000000000000005
897[a9ea8000 R08:  158.497354] RBP: 00007fff520a4ab0 R08: 0000000005000007 R09: 0000000000000003
[  158.505867] R10: 00000000ffffffff R11: 0000000000000246 R12: 00005561dc033348
 ff[ffc90021fefb3  158.513000] R13: 0000000000000002 R14: ffffffffffffffff R15: 00005561da52b2c8
0 R09: 000000000[  158.521520] Modules linked in: isst_if_common squashfs nls_iso8859_1 nls_cp437 snd_hda_codec_realtek vfat snd_hda_codec_generic fat iwlmvm ledtrig_audio snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp snd_hda_intel snd_intel_dspcfg iwlwifi efi_pstore btusb snd_hda_codec btrtl btbcm efivars snd_hwdep btintel snd_hda_core iTCO_wdt iTCO_vendor_support mei_me mei loop coretemp hid_logitech_hidpp hid_logitech_dj hid_lenovo amdgpu gpu_sched i40e ixgbe ast drm_vram_helper drm_ttm_helper ttm mdio xhci_pci xhci_hcd
[  158.568431] CR2: 0000000000843f70
0000000
[  157.[  158.571751] ---[ end trace 563634e2f1b39799 ]---
161848] R10: 0000000000000084 R11: 0000000000000012 R12: ffff8897721bd400
[  157.168983] R13: ffff88afb1ae2c00 R14: ffff88afb19[  158.639843] RIP: 0010:xfs_log_commit_cil+0x356/0x7f0
[  158.646009] Code: 00 00 48 89 7e 08 49 89 76 30 48 89 11 48 89 4a 08 8b 4c 24 2c 48 89 85 c0 00 00 00 48 89 85 c8 00 00 00 49 8b 46 20 45 31 c9 <8b> 70 20 85 f6 0f 84 d9 02 00 00 45 31 c0 85 c9 7e 4f 41 8b 46 2c
860c0 R15: ffff8[  158.664754] RSP: 0018:ffffc90021fefb00 EFLAGS: 00010246
[  158.671356] RAX: 0000000000000000 RBX: ffff8897a9ea80b0 RCX: 0000000000000458
897a9ea80a0
[  [  158.678488] RDX: ffff8897a9ea80c0 RSI: ffff88afc39a1200 RDI: ffff88afb1ae2c18
[  158.686999] RBP: ffff8897a9ea8000 R08: ffffc90021fefb30 R09: 0000000000000000
157.176115] FS: [  158.694132] R10: 0000000000000084 R11: 0000000000000012 R12: ffff8897721bd400
[  158.702643] R13: ffff88afb1ae2c00 R14: ffff88afb19860c0 R15: ffff8897a9ea80a0
 00007ffbbe9a198[  158.709776] FS:  00007ffbbe9a1980(0000) GS:ffff8897e0ec0000(0000) knlGS:0000000000000000
[  158.719241] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
0(0000) GS:ffff8[  158.724985] CR2: 0000000000843f70 CR3: 0000002fd67a2004 CR4: 00000000007606e0
[  158.733498] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
897e0cc0000(0000[  158.740631] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  158.749142] PKRU: 55555554
) knlGS:00000000[  158.752176] BUG: unable to handle page fault for address: 00007ffb48196038
[  158.760116] #PF: supervisor read access in kernel mode
00[000000
[  157  158.765254] #PF: error_code(0x0000) - not-present page
[  158.771778] PGD 0 P4D 0
.1[84199] CS:  00  158.774319] Oops: 0000 [#3] SMP NOPTI
[  158.779373] CPU: 21 PID: 7839 Comm: postgres Tainted: G      D           5.7.0-rc7-andres-00133-gc8707bf69395 #41
10[ DS: 0000 ES:   158.789623] Hardware name: Supermicro SYS-7049A-T/X11DAi-N, BIOS 3.2 11/13/2019
[  158.798320] RIP: 0010:__mutex_lock.isra.0+0x16f/0x4d0
00[00 CR0: 000000  158.803368] Code: 41 c6 45 08 00 31 c0 48 8b 7c 24 68 65 48 33 3c 25 28 00 00 00 0f 85 66 03 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <8b> 50 38 85 d2 74 08 8b 40 3c e9 fe fe ff ff 65 48 8b 04 25 80 7d
[  158.823502] RSP: 0018:ffffc9002116fdb0 EFLAGS: 00010206
00[80050033
[  1  158.828728] RAX: 00007ffb48196000 RBX: ffff8897ad21f200 RCX: 0000000000000001
[  158.837248] RDX: 00007ffb48196000 RSI: ffff88afb7b98000 RDI: ffff88afd7957a40
57[.189946] CR2:   158.844381] RBP: ffffc9002116fe50 R08: 0000000000000000 R09: 0000000000000000
[  158.852900] R10: ffff88afbab4d0f0 R11: 0000000000000018 R12: ffff88afbab4d0f0
00[00000000000020  158.860030] R13: ffff88afd7957a40 R14: ffff88afd7908160 R15: ffff88afc8508300
[  158.868552] FS:  00007ffbbe9a1980(0000) GS:ffff8897e0ec0000(0000) knlGS:0000000000000000
 C[R3: 000000179c  158.876638] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  158.883771] CR2: 00007ffb48196038 CR3: 000000000660a005 CR4: 00000000007606e0
0a[c005 CR4: 0000  158.890902] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  158.899421] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
00[00007606e0
[   158.906553] PKRU: 55555554
[  158.910654] Call Trace:
 15[7.197081] DR0  158.913110]  ? __schedule+0x29f/0x700
[  158.918162]  pipe_release+0x1e/0xd0
: [00000000000000  158.921655]  __fput+0xda/0x240
[  158.926102]  task_work_run+0x5f/0x90
00[ DR1: 00000000  158.929681]  do_exit+0x34f/0xa60
[  158.934300]  ? exit_to_usermode_loop+0xbd/0xe0
000[00000 DR2: 00  158.938744]  rewind_stack_do_exit+0x17/0x20
[  158.944309] RIP: 0033:0x7ffbc1aa0f13
000[00000000000
  158.947890] Code: Bad RIP value.
[  158.952505] RSP: 002b:00007fff520a4a48 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[ [ 157.204212] D  158.960070] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 00007ffbc1aa0f13
[  158.968592] RDX: 0000000000000002 RSI: 00005561dc0333c0 RDI: 0000000000000005
R3[: 000000000000  158.975725] RBP: 00007fff520a4ab0 R08: 0000000005000007 R09: 0000000000000003
[  158.984243] R10: 00000000ffffffff R11: 0000000000000246 R12: 00005561dc033348
00[00 DR6: 000000  158.991378] R13: 0000000000000002 R14: ffffffffffffffff R15: 00005561da52b2c8
00fffe0ff0 DR7: [  158.999899] Modules linked in: isst_if_common squashfs nls_iso8859_1 nls_cp437 snd_hda_codec_realtek vfat snd_hda_codec_generic fat iwlmvm ledtrig_audio snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp snd_hda_intel snd_intel_dspcfg iwlwifi efi_pstore btusb snd_hda_codec btrtl btbcm efivars snd_hwdep btintel snd_hda_core iTCO_wdt iTCO_vendor_support mei_me mei loop coretemp hid_logitech_hidpp hid_logitech_dj hid_lenovo amdgpu gpu_sched i40e ixgbe ast drm_vram_helper drm_ttm_helper ttm mdio xhci_pci xhci_hcd
[  159.046811] CR2: 00007ffb48196038
0000000000000400[  159.050131] ---[ end trace 563634e2f1b3979a ]---

[  157.211343] PKRU: 55555554
[  157.214048] Call Trace:
[  157.216498]  __xfs_trans_commit+0xa1/0x340
[  157.220596]  xfs_[  159.119169] RIP: 0010:xfs_log_commit_cil+0x356/0x7f0
create+0x4cc/0x5[  159.124205] Code: 00 00 48 89 7e 08 49 89 76 30 48 89 11 48 89 4a 08 8b 4c 24 2c 48 89 85 c0 00 00 00 48 89 85 c8 00 00 00 49 8b 46 20 45 31 c9 <8b> 70 20 85 f6 0f 84 d9 02 00 00 45 31 c0 85 c9 7e 4f 41 8b 46 2c
[  159.144326] RSP: 0018:ffffc90021fefb00 EFLAGS: 00010246
e0
[  157.22408[  159.149553] RAX: 0000000000000000 RBX: ffff8897a9ea80b0 RCX: 0000000000000458
[  159.158066] RDX: ffff8897a9ea80c0 RSI: ffff88afc39a1200 RDI: ffff88afb1ae2c18
7]  xfs_generic_[  159.165197] RBP: ffff8897a9ea8000 R08: ffffc90021fefb30 R09: 0000000000000000
[  159.173707] R10: 0000000000000084 R11: 0000000000000012 R12: ffff8897721bd400
create+0x241/0x3[  159.180839] R13: ffff88afb1ae2c00 R14: ffff88afb19860c0 R15: ffff8897a9ea80a0
[  159.189353] FS:  00007ffbbe9a1980(0000) GS:ffff8897e0ec0000(0000) knlGS:0000000000000000
10
[  157.22827[  159.197436] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  159.204562] CR2: 00007ffbc1aa0ee9 CR3: 000000000660a005 CR4: 00000000007606e0
4]  path_openat+[  159.211695] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  159.220203] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
0xdb7/0x1020
[ [  159.227339] PKRU: 55555554
[  159.231430] Fixing recursive fault but reboot is needed!
 157.231940]  do_filp_open+0x91/0x100
[  157.235518]  ? __sys_recvfrom+0xe4/0x170
[  157.239444]  ? _cond_resched+0x19/0x30
[  157.243196]  do_sys_openat2+0x215/0x2d0
[  157.247037]  do_sys_open+0x44/0x80
[  157.250443]  do_syscall_64+0x48/0x130
[  157.254108]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  157.259161] RIP: 0033:0x7ffbc0ded307
[  157.262738] Code: 25 00 00 41 00 3d 00 00 41 00 74 47 64 8b 04 25 18 00 00 00 85 c0 75 6b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 95 00 00 00 48 8b 4c 24 28 64 48 33 0c 25
[  157.281485] RSP: 002b:00007fff520a4940 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[  157.289052] RAX: ffffffffffffffda RBX: 00005561dc02eca0 RCX: 00007ffbc0ded307
[  157.296185] RDX: 0000000000000241 RSI: 00005561dc013470 RDI: 00000000ffffff9c
[  157.303317] RBP: 00005561dc013470 R08: 0000000000000004 R09: 0000000000000001
[  157.310447] R10: 00000000000001b6 R11: 0000000000000246 R12: 0000000000000241
[  157.317575] R13: 00005561dc02eca0 R14: 0000000000000001 R15: 0000000000000000
[  157.324705] Modules linked in: isst_if_common squashfs nls_iso8859_1 nls_cp437 snd_hda_codec_realtek vfat snd_hda_codec_generic fat iwlmvm ledtrig_audio snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp snd_hda_intel snd_intel_dspcfg iwlwifi efi_pstore btusb snd_hda_codec btrtl btbcm efivars snd_hwdep btintel snd_hda_core iTCO_wdt iTCO_vendor_support mei_me mei loop coretemp hid_logitech_hidpp hid_logitech_dj hid_lenovo amdgpu gpu_sched i40e ixgbe ast drm_vram_helper drm_ttm_helper ttm mdio xhci_pci xhci_hcd
[  157.370249] CR2: 0000000000000020
[  157.373569] ---[ end trace 563634e2f1b39798 ]---
[  158.079256] RIP: 0010:xfs_log_commit_cil+0x356/0x7f0
[  158.084219] Code: 00 00 48 89 7e 08 49 89 76 30 48 89 11 48 89 4a 08 8b 4c 24 2c 48 89 85 c0 00 00 00 48 89 85 c8 00 00 00 49 8b 46 20 45 31 c9 <8b> 70 20 85 f6 0f 84 d9 02 00 00 45 31 c0 85 c9 7e 4f 41 8b 46 2c
[  158.102964] RSP: 0018:ffffc90021fefb00 EFLAGS: 00010246
[  158.108192] RAX: 0000000000000000 RBX: ffff8897a9ea80b0 RCX: 0000000000000458
[  158.115322] RDX: ffff8897a9ea80c0 RSI: ffff88afc39a1200 RDI: ffff88afb1ae2c18
[  158.122455] RBP: ffff8897a9ea8000 R08: ffffc90021fefb30 R09: 0000000000000000
[  158.129590] R10: 0000000000000084 R11: 0000000000000012 R12: ffff8897721bd400
[  158.136722] R13: ffff88afb1ae2c00 R14: ffff88afb19860c0 R15: ffff8897a9ea80a0
[  158.143855] FS:  00007ffbbe9a1980(0000) GS:ffff8897e0cc0000(0000) knlGS:0000000000000000
[  158.151939] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  158.157685] CR2: 0000000000000020 CR3: 000000179c0ac005 CR4: 00000000007606e0
[  158.164810] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  158.171942] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  158.179074] PKRU: 55555554
[  158.235406] BUG: unable to handle page fault for address: 0000000000843f70
[  158.242834] #PF: supervisor write access in kernel mode
[  158.249442] #PF: error_code(0x0002) - not-present page
[  158.254582] PGD 0 P4D 0
[  158.258500] Oops: 0002 [#2] SMP NOPTI
[  158.262167] CPU: 21 PID: 7839 Comm: postgres Tainted: G      D           5.7.0-rc7-andres-00133-gc8707bf69395 #41
[  158.273804] Hardware name: Supermicro SYS-7049A-T/X11DAi-N, BIOS 3.2 11/13/2019
[  158.281116] RIP: 0010:queued_spin_lock_slowpath+0x16c/0x1a0
[  158.288064] Code: 8b 02 48 85 c0 74 f6 48 89 c6 eb e5 c1 ee 12 83 e0 03 83 ee 01 48 c1 e0 04 48 63 f6 48 05 c0 c1 02 00 48 03 04 f5 c0 86 fc 82 <48> 89 10 8b 42 08 85 c0 75 09 f3 90 8b 42 08 85 c0 74 f7 48 8b 02
[  158.306810] RSP: 0018:ffffc9002116fe20 EFLAGS: 00010002
[  158.313421] RAX: 0000000000843f70 RBX: ffff8897d87924e0 RCX: 0000000000580000
[  158.320555] RDX: ffff8897e0eec1c0 RSI: 0000000000001201 RDI: ffff88afd7957a60
[  158.329073] RBP: ffff88afd7957a60 R08: 0000000000580000 R09: 0000000000000000
[  158.336207] R10: ffff88afd70bfce0 R11: 0000000000000000 R12: 0000000000000286
[  158.344724] R13: dead000000000122 R14: dead000000000100 R15: ffff88afd639e000
[  158.351860] FS:  00007ffbbe9a1980(0000) GS:ffff8897e0ec0000(0000) knlGS:0000000000000000
[  158.361331] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  158.367078] CR2: 0000000000843f70 CR3: 0000002fd67a2004 CR4: 00000000007606e0
[  158.375598] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  158.382737] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  158.391256] PKRU: 55555554
[  158.393968] Call Trace:
[  158.397813]  _raw_spin_lock_irqsave+0x25/0x30
[  158.403559]  remove_wait_queue+0x12/0x50
[  158.408873]  ep_unregister_pollwait.isra.0+0x5e/0x80
[  158.415235]  ep_free+0x4e/0xd0
[  158.419684]  ep_eventpoll_release+0x16/0x20
[  158.423874]  __fput+0xda/0x240
[  158.428312]  task_work_run+0x5f/0x90
[  158.433285]  exit_to_usermode_loop+0xbd/0xe0
[  158.438944]  do_syscall_64+0xf2/0x130
[  158.443998]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  158.450437] RIP: 0033:0x7ffbc1aa0f13
[  158.454012] Code: 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
[  158.474138] RSP: 002b:00007fff520a4a48 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  158.481705] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 00007ffbc1aa0f13
[  158.490222] RDX: 0000000000000002 RSI: 00005561dc0333c0 RDI: 0000000000000005
[  158.497354] RBP: 00007fff520a4ab0 R08: 0000000005000007 R09: 0000000000000003
[  158.505867] R10: 00000000ffffffff R11: 0000000000000246 R12: 00005561dc033348
[  158.513000] R13: 0000000000000002 R14: ffffffffffffffff R15: 00005561da52b2c8
[  158.521520] Modules linked in: isst_if_common squashfs nls_iso8859_1 nls_cp437 snd_hda_codec_realtek vfat snd_hda_codec_generic fat iwlmvm ledtrig_audio snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp snd_hda_intel snd_intel_dspcfg iwlwifi efi_pstore btusb snd_hda_codec btrtl btbcm efivars snd_hwdep btintel snd_hda_core iTCO_wdt iTCO_vendor_support mei_me mei loop coretemp hid_logitech_hidpp hid_logitech_dj hid_lenovo amdgpu gpu_sched i40e ixgbe ast drm_vram_helper drm_ttm_helper ttm mdio xhci_pci xhci_hcd
[  158.568431] CR2: 0000000000843f70
[  158.571751] ---[ end trace 563634e2f1b39799 ]---
[  158.639843] RIP: 0010:xfs_log_commit_cil+0x356/0x7f0
[  158.646009] Code: 00 00 48 89 7e 08 49 89 76 30 48 89 11 48 89 4a 08 8b 4c 24 2c 48 89 85 c0 00 00 00 48 89 85 c8 00 00 00 49 8b 46 20 45 31 c9 <8b> 70 20 85 [  159.807838] general protection fault, probably for non-canonical address 0x16152f0de31ca0e2: 0000 [#4] SMP NOPTI
f6 [0f 84 d9 02 0  159.818219] CPU: 37 PID: 6847 Comm: gnome-shell Tainted: G      D           5.7.0-rc7-andres-00133-gc8707bf69395 #41
0 [00 45 31 c0 85  159.830115] Hardware name: Supermicro SYS-7049A-T/X11DAi-N, BIOS 3.2 11/13/2019
 c9[ 7e 4f 41 8b   159.838822] RIP: 0010:kmem_cache_alloc_trace+0x78/0x1c0
[  159.845430] Code: 00 00 4c 8b 45 00 65 49 8b 50 08 65 4c 03 05 37 9c c9 7e 4d 8b 38 4d 85 ff 0f 84 2d 01 00 00 8b 45 20 48 8d 4a 01 48 8b 7d 00 <49> 8b 1c 07 4c 89 f8 65 48 0f c7 0f 0f 94 c0 84 c0 74 c5 8b 45 20
46 [2c
[  158.66  159.864174] RSP: 0018:ffffc9000eb9bc98 EFLAGS: 00010202
[  159.870785] RAX: 0000000000000080 RBX: 0000000000000001 RCX: 00000000000006a2
47[54] RSP: 0018:  159.877919] RDX: 00000000000006a1 RSI: 0000000000000dc0 RDI: 000000000002e900
[  159.886439] RBP: ffff8897e0803700 R08: ffff88afdfc6e900 R09: ffff8897d51a7560
ff[ffc90021fefb00  159.893571] R10: 0000000000000000 R11: ffff88afbc711840 R12: 0000000000000dc0
[  159.902088] R13: 00000000000000d0 R14: ffffffffa0265697 R15: 16152f0de31ca062
 E[FLAGS: 0001024  159.909223] FS:  00007f58af13fcc0(0000) GS:ffff88afdfc40000(0000) knlGS:0000000000000000
[  159.918696] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
6[
[  158.671356  159.924441] CR2: 0000558a26e64ab8 CR3: 00000017a49ba001 CR4: 00000000007606e0
[  159.932959] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
] [RAX: 000000000  159.940092] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  159.948614] PKRU: 55555554
00[00000 RBX: fff  159.951328] Call Trace:
f8897a9ea80b0 RC[  159.955238]  amdgpu_display_user_framebuffer_create+0x67/0xc0 [amdgpu]
X:[ 0000000000000  159.963085]  drm_internal_framebuffer_create+0x37c/0x4c0
45[8
[  158.6784  159.969793]  drm_mode_addfb2+0x2b/0xb0
[  159.974937]  ? drm_mode_addfb_ioctl+0x10/0x10
88] RDX: ffff889[  159.979297]  drm_ioctl_kernel+0xab/0xf0
[  159.984514]  drm_ioctl+0x1e1/0x362
7a9[ea80c0 RSI: f  159.987919]  ? drm_mode_addfb_ioctl+0x10/0x10
fff88afc39a1200 [  159.993728]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
RD[I: ffff88afb1a  159.999673]  ksys_ioctl+0x82/0xc0
e2[c18
[  158.68  160.004379]  __x64_sys_ioctl+0x16/0x20
[  160.009528]  do_syscall_64+0x48/0x130
6999] RBP: ffff8[  160.013202]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  160.019630] RIP: 0033:0x7f58b5152427
897[a9ea8000 R08:  160.023210] Code: 00 00 90 48 8b 05 69 7a 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 7a 0c 00 f7 d8 64 89 01 48
[  160.043342] RSP: 002b:00007ffd208c6708 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
 f[fffc90021fefb3  160.050906] RAX: ffffffffffffffda RBX: 00007ffd208c6740 RCX: 00007f58b5152427
[  160.059427] RDX: 00007ffd208c6740 RSI: 00000000c06864b8 RDI: 000000000000000a
0 [R09: 000000000  160.066559] RBP: 00000000c06864b8 R08: 00007ffd208c688c R09: 00007ffd208c68ac
[  160.075077] R10: 000000000000000a R11: 0000000000000246 R12: 00000000000005a0
00[00000
[  158.  160.082212] R13: 000000000000000a R14: 00007ffd208c682c R15: 0000000000000000
694132] R10: 000[  160.090734] Modules linked in: isst_if_common squashfs nls_iso8859_1 nls_cp437 snd_hda_codec_realtek vfat snd_hda_codec_generic fat iwlmvm ledtrig_audio snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp snd_hda_intel snd_intel_dspcfg iwlwifi efi_pstore btusb snd_hda_codec btrtl btbcm efivars snd_hwdep btintel snd_hda_core iTCO_wdt iTCO_vendor_support mei_me mei loop coretemp hid_logitech_hidpp hid_logitech_dj hid_lenovo amdgpu gpu_sched i40e ixgbe ast drm_vram_helper drm_ttm_helper ttm mdio xhci_pci xhci_hcd
0000000000084 R1[  160.137675] ---[ end trace 563634e2f1b3979b ]---
1: 0000000000000012 R12: ffff8897721bd400
[  158.702643] R13: ffff88afb1ae2c00 R14: ffff88afb19860c0 R15: ffff8897a9ea80a0
[  158.709776] FS: [  160.211222] RIP: 0010:xfs_log_commit_cil+0x356/0x7f0
 00007ffbbe9a198[  160.217572] Code: 00 00 48 89 7e 08 49 89 76 30 48 89 11 48 89 4a 08 8b 4c 24 2c 48 89 85 c0 00 00 00 48 89 85 c8 00 00 00 49 8b 46 20 45 31 c9 <8b> 70 20 85 f6 0f 84 d9 02 00 00 45 31 c0 85 c9 7e 4f 41 8b 46 2c
0(0000) GS:ffff8[  160.237717] RSP: 0018:ffffc90021fefb00 EFLAGS: 00010246
897e0ec0000(0000[  160.244322] RAX: 0000000000000000 RBX: ffff8897a9ea80b0 RCX: 0000000000000458
) knlGS:00000000[  160.252842] RDX: ffff8897a9ea80c0 RSI: ffff88afc39a1200 RDI: ffff88afb1ae2c18
00000000
[  158[  160.261365] RBP: ffff8897a9ea8000 R08: ffffc90021fefb30 R09: 0000000000000000
.719241] CS:  00[  160.269881] R10: 0000000000000084 R11: 0000000000000012 R12: ffff8897721bd400
10 DS: 0000 ES: [  160.278399] R13: ffff88afb1ae2c00 R14: ffff88afb19860c0 R15: ffff8897a9ea80a0
0000 CR0: 000000[  160.286921] FS:  00007f58af13fcc0(0000) GS:ffff88afdfc40000(0000) knlGS:0000000000000000
0080050033
[  1[  160.296388] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
58.724985] CR2: [  160.303523] CR2: 0000558a26e64ab8 CR3: 00000017a49ba001 CR4: 00000000007606e0
0000000000843f70[  160.312045] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 CR3: 0000002fd6[  160.320560] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
7a2004 CR4: 0000[  160.329078] PKRU: 55555554
0000007606e0
[  158.733498] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  158.740631] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  158.749142] PKRU: 55555554
[  158.752176] BUG: unable to handle page fault for address: 00007ffb48196038
[  158.760116] #PF: supervisor read access in kernel mode
[  158.765254] #PF: error_code(0x0000) - not-present page
[  158.771778] PGD 0 P4D 0
[  158.774319] Oops: 0000 [#3] SMP NOPTI
[  158.779373] CPU: 21 PID: 7839 Comm: postgres Tainted: G      D           5.7.0-rc7-andres-00133-gc8707bf69395 #41
[  158.789623] Hardware name: Supermicro SYS-7049A-T/X11DAi-N, BIOS 3.2 11/13/2019
[  158.798320] RIP: 0010:__mutex_lock.isra.0+0x16f/0x4d0
[  158.803368] Code: 41 c6 45 08 00 31 c0 48 8b 7c 24 68 65 48 33 3c 25 28 00 00 00 0f 85 66 03 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <8b> 50 38 85 d2 74 08 8b 40 3c e9 fe fe ff ff 65 48 8b 04 25 80 7d
[  158.823502] RSP: 0018:ffffc9002116fdb0 EFLAGS: 00010206
[  158.828728] RAX: 00007ffb48196000 RBX: ffff8897ad21f200 RCX: 0000000000000001
[  158.837248] RDX: 00007ffb48196000 RSI: ffff88afb7b98000 RDI: ffff88afd7957a40
[  158.844381] RBP: ffffc9002116fe50 R08: 0000000000000000 R09: 0000000000000000
[  158.852900] R10: ffff88afbab4d0f0 R11: 0000000000000018 R12: ffff88afbab4d0f0
[  158.860030] R13: ffff88afd7957a40 R14: ffff88afd7908160 R15: ffff88afc8508300
[  158.868552] FS:  00007ffbbe9a1980(0000) GS:ffff8897e0ec0000(0000) knlGS:0000000000000000
[  158.876638] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  158.883771] CR2: 00007ffb48196038 CR3: 000000000660a005 CR4: 00000000007606e0
[  158.890902] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  158.899421] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  158.906553] PKRU: 55555554
[  158.910654] Call Trace:
[  158.913110]  ? __schedule+0x29f/0x700
[  158.918162]  pipe_release+0x1e/0xd0
[  158.921655]  __fput+0xda/0x240
[  158.926102]  task_work_run+0x5f/0x90
[  158.929681]  do_exit+0x34f/0xa60
[  158.934300]  ? exit_to_usermode_loop+0xbd/0xe0
[  158.938744]  rewind_stack_do_exit+0x17/0x20
[  158.944309] RIP: 0033:0x7ffbc1aa0f13
[  158.947890] Code: Bad RIP value.
[  158.952505] RSP: 002b:00007fff520a4a48 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  158.960070] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 00007ffbc1aa0f13
[  158.968592] RDX: 0000000000000002 RSI: 00005561dc0333c0 RDI: 0000000000000005
[  158.975725] RBP: 00007fff520a4ab0 R08: 0000000005000007 R09: 0000000000000003
[  158.984243] R10: 00000000ffffffff R11: 0000000000000246 R12: 00005561dc033348
[  158.991378] R13: 0000000000000002 R14: ffffffffffffffff R15: 00005561da52b2c8
[  158.999899] Modules linked in: isst_if_common squashfs nls_iso8859_1 nls_cp437 snd_hda_codec_realtek vfat snd_hda_codec_generic fat iwlmvm ledtrig_audio snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp snd_hda_intel snd_intel_dspcfg iwlwifi efi_pstore btusb snd_hda_codec btrtl btbcm efivars snd_hwdep btintel snd_hda_core iTCO_wdt iTCO_vendor_support mei_me mei loop coretemp hid_logitech_hidpp hid_logitech_dj hid_lenovo amdgpu gpu_sched i40e ixgbe ast drm_vram_helper drm_ttm_helper ttm mdio xhci_pci xhci_hcd
[  159.046811] CR2: 00007ffb48196038
[  159.050131] ---[ end trace 563634e2f1b3979a ]---
[  159.119169] RIP: 0010:xfs_log_commit_cil+0x356/0x7f0
[  159.124205] Code: 00 00 48 89 7e 08 49 89 76 30 48 89 11 48 89 4a 08 8b 4c 24 2c 48 89 85 c0 00 00 00 48 89 85 c8 00 00 00 49 8b 46 20 45 31 c9 <8b> 70 20 85 f6 0f 84 d9 02 00 00 45 31 c0 85 c9 7e 4f 41 8b 46 2c
[  159.144326] RSP: 0018:ffffc90021fefb00 EFLAGS: 00010246
[  159.149553] RAX: 0000000000000000 RBX: ffff8897a9ea80b0 RCX: 0000000000000458
[  159.158066] RDX: ffff8897a9ea80c0 RSI: ffff88afc39a1200 RDI: ffff88afb1ae2c18
[  159.165197] RBP: ffff8897a9ea8000 R08: ffffc90021fefb30 R09: 0000000000000000
[  159.173707] R10: 0000000000000084 R11: 0000000000000012 R12: ffff8897721bd400
[  159.180839] R13: ffff88afb1ae2c00 R14: ffff88afb19860c0 R15: ffff8897a9ea80a0
[  159.189353] FS:  00007ffbbe9a1980(0000) GS:ffff8897e0ec0000(0000) knlGS:0000000000000000
[  159.197436] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  159.204562] CR2: 00007ffbc1aa0ee9 CR3: 000000000660a005 CR4: 00000000007606e0
[  159.211695] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  159.220203] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  159.227339] PKRU: 55555554
[  159.231430] Fixing recursive fault but reboot is needed!
[  159.807838] general protection fault, probably for non-canonical address 0x16152f0de31ca0e2: 0000 [#4] SMP NOPTI
[  159.818219] CPU: 37 PID: 6847 Comm: gnome-shell Tainted: G      D           5.7.0-rc7-andres-00133-gc8707bf69395 #41
[  159.830115] Hardware name: Supermicro SYS-7049A-T/X11DAi-N, BIOS 3.2 11/13/2019
[  159.838822] RIP: 0010:kmem_cache_alloc_trace+0x78/0x1c0
[  159.845430] Code: 00 00 4c 8b 45 00 65 49 8b 50 08 65 4c 03 05 37 9c c9 7e 4d 8b 38 4d 85 ff 0f 84 2d 01 00 00 8b 45 20 48 8d 4a 01 48 8b 7d 00 <49> 8b 1c 07 4c 89 f8 65 48 0f c7 0f 0f 94 c0 84 c0 74 c5 8b 45 20
[  159.864174] RSP: 0018:ffffc9000eb9bc98 EFLAGS: 00010202
[  159.870785] RAX: 0000000000000080 RBX: 0000000000000001 RCX: 00000000000006a2
[  159.877919] RDX: 00000000000006a1 RSI: 0000000000000dc0 RDI: 000000000002e900
[  159.886439] RBP: ffff8897e0803700 R08: ffff88afdfc6e900 R09: ffff8897d51a7560
[  159.893571] R10: 0000000000000000 R11: ffff88afbc711840 R12: 0000000000000dc0
[  159.902088] R13: 00000000000000d0 R14: ffffffffa0265697 R15: 16152f0de31ca062
[  159.909223] FS:  00007f58af13fcc0(0000) GS:ffff88afdfc40000(0000) knlGS:0000000000000000
[  159.918696] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  159.924441] CR2: 0000558a26e64ab8 CR3: 00000017a49ba001 CR4: 00000000007606e0
[  159.932959] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  159.940092] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  159.948614] PKRU: 55555554
[  159.951328] Call Trace:
[  159.955238]  amdgpu_display_user_framebuffer_create+0x67/0xc0 [amdgpu]
[  159.963085]  drm_internal_framebuffer_create+0x37c/0x4c0
[  159.969793]  drm_mode_addfb2+0x2b/0xb0
[  159.974937]  ? drm_mode_addfb_ioctl+0x10/0x10
[  159.979297]  drm_ioctl_kernel+0xab/0xf0
[  159.984514]  drm_ioctl+0x1e1/0x362
[  159.987919]  ? drm_mode_addfb_ioctl+0x10/0x10
[  159.993728]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
[  159.999673]  ksys_ioctl+0x82/0xc0
[  160.004379]  __x64_sys_ioctl+0x16/0x20
[  160.009528]  do_syscall_64+0x48/0x130
[  160.013202]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  160.019630] RIP: 0033:0x7f58b5152427
[  160.023210] Code: 00 00 90 48 8b 05 69 7a 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 7a 0c 00 f7 d8 64 89 01 48
[  160.043342] RSP: 002b:00007ffd208c6708 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  160.050906] RAX: ffffffffffffffda RBX: 00007ffd208c6740 RCX: 00007f58b5152427
[  160.059427] RDX: 00007ffd208c6740 RSI: 00000000c06864b8 RDI: 000000000000000a
[  160.066559] RBP: 00000000c06864b8 R08: 00007ffd208c688c R09: 00007ffd208c68ac
[  160.075077] R10: 000000000000000a R11: 0000000000000246 R12: 00000000000005a0
[  160.082212] R13: 000000000000000a R14: 00007ffd208c682c R15: 0000000000000000
[  160.090734] Modules linked in: isst_if_common squashfs nls_iso8859_1 nls_cp437 snd_hda_codec_realtek vfat snd_hda_codec_generic fat iwlmvm ledtrig_audio snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp snd_hda_intel snd_intel_dspcfg iwlwifi efi_pstore btusb snd_hda_codec btrtl btbcm efivars snd_hwdep btintel snd_hda_core iTCO_wdt iTCO_vendor_support mei_me mei loop coretemp hid_logitech_hidpp hid_logitech_dj hid_lenovo amdgpu gpu_sched i40e ixgbe ast drm_vram_helper drm_ttm_helper ttm mdio xhci_pci xhci_hcd
[  160.137675] ---[ end trace 563634e2f1b3979b ]---
[  160.211222] RIP: 0010:xfs_log_commit_cil+0x356/0x7f0
[  160.217572] Code: 00 00 48 89 7e 08 49 89 76[  161.041289] BUG: unable to handle page fault for address: 0000000000002000
[  161.048635] #PF: supervisor instruction fetch in kernel mode
 3[0 48 89 11 48   161.054292] #PF: error_code(0x0010) - not-present page
[  161.060818] PGD 0 P4D 0
89[ 4a 08 8b 4c 2  161.063357] Oops: 0010 [#5] SMP NOPTI
[  161.068412] CPU: 22 PID: 0 Comm: swapper/22 Tainted: G      D           5.7.0-rc7-andres-00133-gc8707bf69395 #41
4 [2c 48 89 85 c0  161.078577] Hardware name: Supermicro SYS-7049A-T/X11DAi-N, BIOS 3.2 11/13/2019
[  161.087278] RIP: 0010:0x2000
 0[0 00 00 48 89   161.090164] Code: Bad RIP value.
[  161.094784] RSP: 0018:ffffc9000ccd0f20 EFLAGS: 00010006
85[ c8 00 00 00 4  161.100009] RAX: 0000000000000000 RBX: ffff8897b1dfee00 RCX: 0000000000000000
[  161.108527] RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffff8897b1dfee00
9 [8b 46 20 45 31  161.115661] RBP: ffff8897e0f1f1c0 R08: ffff8897e0f1f680 R09: 7fffffffffffffff
[  161.124179] R10: 0000002588b04191 R11: 0000000000000df5 R12: 0000000000002000
 c[9 <8b> 70 20 8  161.131323] R13: ffff8897e0f1f180 R14: ffff8897e0f1f140 R15: ffff8897e0f1f278
[  161.139840] FS:  0000000000000000(0000) GS:ffff8897e0f00000(0000) knlGS:0000000000000000
5 [f6 0f 84 d9 02  161.147927] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  161.155058] CR2: 0000000000001fd6 CR3: 0000002fb7802004 CR4: 00000000007606e0
 0[0 00 45 31 c0   161.162192] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  161.170712] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
85[ c9 7e 4f 41 8  161.177843] PKRU: 55555554
[  161.181944] Call Trace:
b [46 2c
[  160.  161.184397]  <IRQ>
23[7717] RSP: 001  161.187809]  ? __hrtimer_run_queues+0xf2/0x270
[  161.193647]  ? hrtimer_interrupt+0x106/0x220
8:f[fffc90021fefb  161.197920]  ? smp_apic_timer_interrupt+0x6c/0x130
[  161.204097]  ? apic_timer_interrupt+0xf/0x20
00[ EFLAGS: 00010  161.208369]  </IRQ>
[  161.211866]  ? cpuidle_enter_state+0xae/0x380
24[6
[  160.2443  161.216221]  ? cpuidle_enter+0x29/0x40
[  161.221361]  ? do_idle+0x1cc/0x240
22[] RAX: 0000000  161.224768]  ? cpu_startup_entry+0x19/0x20
[  161.230254]  ? start_secondary+0x15c/0x1b0
000[000000 RBX: f  161.234355]  ? secondary_startup_64+0xa4/0xb0
fff8897a9ea80b0 [  161.240098] Modules linked in: isst_if_common squashfs nls_iso8859_1 nls_cp437 snd_hda_codec_realtek vfat snd_hda_codec_generic fat iwlmvm ledtrig_audio snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp snd_hda_intel snd_intel_dspcfg iwlwifi efi_pstore btusb snd_hda_codec btrtl btbcm efivars snd_hwdep btintel snd_hda_core iTCO_wdt iTCO_vendor_support mei_me mei loop coretemp hid_logitech_hidpp hid_logitech_dj hid_lenovo amdgpu gpu_sched i40e ixgbe ast drm_vram_helper drm_ttm_helper ttm mdio xhci_pci xhci_hcd
[  161.287011] CR2: 0000000000002000
RCX: 00000000000[  161.290342] ---[ end trace 563634e2f1b3979c ]---
[  161.294667] BUG: unable to handle page fault for address: 0000000000850b48
00[458
[  160.25  161.294672] ------------[ cut here ]------------
[  161.294683] WARNING: CPU: 21 PID: 7852 at kernel/workqueue.c:951 worker_thread+0x38f/0x3c0
28[42] RDX: ffff8  161.294685] Modules linked in: isst_if_common squashfs nls_iso8859_1 nls_cp437 snd_hda_codec_realtek vfat snd_hda_codec_generic fat iwlmvm ledtrig_audio snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp snd_hda_intel snd_intel_dspcfg iwlwifi efi_pstore btusb snd_hda_codec btrtl btbcm efivars snd_hwdep btintel snd_hda_core iTCO_wdt iTCO_vendor_support mei_me mei loop coretemp hid_logitech_hidpp hid_logitech_dj hid_lenovo amdgpu gpu_sched i40e ixgbe ast drm_vram_helper drm_ttm_helper ttm mdio xhci_pci xhci_hcd
[  161.294724] CPU: 21 PID: 7852 Comm: kworker/21:2 Tainted: G      D           5.7.0-rc7-andres-00133-gc8707bf69395 #41
89[7a9ea80c0 RSI:  161.294727] Hardware name: Supermicro SYS-7049A-T/X11DAi-N, BIOS 3.2 11/13/2019
[  161.294738] Workqueue:  0x0 (mm_percpu_wq)
 f[fff88afc39a120  161.294746] RIP: 0010:worker_thread+0x38f/0x3c0
[  161.294750] Code: ff ff e9 33 fd ff ff 0f 0b e9 99 fd ff ff 0f 0b 48 8b 4c 24 08 49 39 4f 38 41 8b 47 60 0f 84 d2 fd ff ff 0f 0b e9 cb fd ff ff <0f> 0b e9 e8 fc ff ff 0f 0b e9 4f fd ff ff 8b 73 34 85 f6 0f 84 06
0 [RDI: ffff88afb  161.294752] RSP: 0018:ffffc900211ebec0 EFLAGS: 00010087
[  161.294757] RAX: ffff8897a4334a00 RBX: ffff8897e0eeaf00 RCX: ffff8897e0eeff60
1ae[2c18
[  160.  161.294759] RDX: ffff8897e0eeff60 RSI: 0000000000000000 RDI: ffff8897e0eeff00
[  161.294761] RBP: ffff8897e0eeaf00 R08: ffff8897e0ee8f08 R09: ffff8897e0ee8f20
26[1365] RBP: fff  161.294763] R10: 0000000000000000 R11: 0000000000000018 R12: ffff8897d8f919a8
[  161.294765] R13: ffff8897e0eeaf20 R14: ffff8897d8f91980 R15: ffff8897d8f91980
f8[897a9ea8000 R0  161.294768] FS:  0000000000000000(0000) GS:ffff8897e0ec0000(0000) knlGS:0000000000000000
[  161.294771] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
8:[ ffffc90021fef  161.294773] CR2: 00000000000000b0 CR3: 0000002fb7a70003 CR4: 00000000007606e0
[  161.294775] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
b3[0 R09: 0000000  161.294777] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  161.294778] PKRU: 55555554
00[0000000
[  16  161.294780] Call Trace:
[  161.294788]  kthread+0xfb/0x130
[  161.294794]  ? process_one_work+0x3a0/0x3a0
[  161.294798]  ? kthread_park+0x90/0x90
[  161.294805]  ret_from_fork+0x1f/0x40
[  161.294810] ---[ end trace 563634e2f1b3979d ]---
[  161.348061] RIP: 0010:xfs_log_commit_cil+0x356/0x7f0
[  161.349898] #PF: supervisor write access in kernel mode
[  161.355907] Code: 00 00 48 89 7e 08 49 89 76 30 48 89 11 48 89 4a 08 8b 4c 24 2c 48 89 85 c0 00 00 00 48 89 85 c8 00 00 00 49 8b 46 20 45 31 c9 <8b> 70 20 85 f6 0f 84 d9 02 00 00 45 31 c0 85 c9 7e 4f 41 8b 46 2c
[  161.364162] #PF: error_code(0x0002) - not-present page
[  161.364164] PGD 0 P4D 0
[  161.411076] RSP: 0018:ffffc90021fefb00 EFLAGS: 00010246
[  161.421679] Oops: 0002 [#6] SMP NOPTI
[  161.430369] RAX: 0000000000000000 RBX: ffff8897a9ea80b0 RCX: 0000000000000458
[  161.430372] RDX: ffff8897a9ea80c0 RSI: ffff88afc39a1200 RDI: ffff88afb1ae2c18
[  161.434470] CPU: 12 PID: 7750 Comm: postgres Tainted: G      D W         5.7.0-rc7-andres-00133-gc8707bf69395 #41
[  161.440390] RBP: ffff8897a9ea8000 R08: ffffc90021fefb30 R09: 0000000000000000
[  161.459134] Hardware name: Supermicro SYS-7049A-T/X11DAi-N, BIOS 3.2 11/13/2019
[  161.459142] RIP: 0010:queued_spin_lock_slowpath+0x16c/0x1a0
[  161.465746] R10: 0000000000000084 R11: 0000000000000012 R12: ffff8897721bd400
[  161.465748] R13: ffff88afb1ae2c00 R14: ffff88afb19860c0 R15: ffff8897a9ea80a0
[  161.472879] Code: 8b 02 48 85 c0 74 f6 48 89 c6 eb e5 c1 ee 12 83 e0 03 83 ee 01 48 c1 e0 04 48 63 f6 48 05 c0 c1 02 00 48 03 04 f5 c0 86 fc 82 <48> 89 10 8b 42 08 85 c0 75 09 f3 90 8b 42 08 85 c0 74 f7 48 8b 02
[  161.472881] RSP: 0018:ffffc9000cac8bb8 EFLAGS: 00010006
[  161.481392] FS:  0000000000000000(0000) GS:ffff8897e0f00000(0000) knlGS:0000000000000000
[  161.481394] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  161.488522] RAX: 0000000000850b48 RBX: ffff8897d8f919b8 RCX: 0000000000340000
[  161.488524] RDX: ffff88afdf8ac1c0 RSI: 000000000000290b RDI: ffff8897d8f919b8
[  161.497043] CR2: 0000000000001fd6 CR3: 0000002fb7802004 CR4: 00000000007606e0
[  161.497045] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  161.504175] RBP: ffff8897d5a18100 R08: 0000000000340000 R09: ffffc9000cac8ce0
[  161.504177] R10: 0100000000000000 R11: 00000000c827dcec R12: 0000000000000046
[  161.513647] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  161.513649] PKRU: 55555554
[  161.519394] R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000003
[  161.519397] FS:  00007ffbbe9a1980(0000) GS:ffff88afdf880000(0000) knlGS:0000000000000000
[  161.527913] Kernel panic - not syncing: Fatal exception in interrupt
[  161.535045] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  161.535047] CR2: 0000000000850b48 CR3: 000000179c01e005 CR4: 00000000007606e0
[  161.798465] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  161.805597] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  161.812729] PKRU: 55555554
[  161.815440] Call Trace:
[  161.817897]  <IRQ>
[  161.819915]  _raw_spin_lock_irqsave+0x25/0x30
[  161.824275]  __wake_up_common_lock+0x62/0xc0
[  161.828548]  ep_poll_callback+0x111/0x2b0
[  161.832557]  __wake_up_common+0x7a/0x140
[  161.836486]  __wake_up_common_lock+0x7c/0xc0
[  161.840760]  sock_def_readable+0x37/0x60
[  161.844685]  __udp_enqueue_schedule_skb+0x159/0x250
[  161.849568]  udpv6_queue_rcv_one_skb+0x284/0x3c0
[  161.854183]  udp6_unicast_rcv_skb.isra.0+0x44/0xa0
[  161.858976]  ip6_protocol_deliver_rcu+0x235/0x4b0
[  161.863682]  ip6_input_finish+0x11/0x20
[  161.867520]  ip6_input+0xa2/0xb0
[  161.870752]  ? ip6_protocol_deliver_rcu+0x4b0/0x4b0
[  161.875631]  ipv6_rcv+0xc0/0xd0
[  161.878780]  ? ip6_rcv_finish_core.isra.0+0xd0/0xd0
[  161.883659]  __netif_receive_skb_one_core+0x63/0xa0
[  161.888538]  process_backlog+0x98/0x130
[  161.892377]  net_rx_action+0x13a/0x370
[  161.896132]  __do_softirq+0xe0/0x2ca
[  161.899710]  do_softirq_own_stack+0x2a/0x40
[  161.903896]  </IRQ>
[  161.906001]  do_softirq.part.0+0x2b/0x30
[  161.909926]  __local_bh_enable_ip+0x4b/0x50
[  161.914116]  ip6_finish_output2+0x264/0x5b0
[  161.918299]  ip6_output+0x73/0x120
[  161.921705]  ? __ip6_finish_output+0x110/0x110
[  161.926152]  ip6_send_skb+0x1e/0x60
[  161.929646]  udp_v6_send_skb.isra.0+0x197/0x460
[  161.934177]  udpv6_sendmsg+0xb4f/0xdb0
[  161.937931]  ? ip_reply_glue_bits+0x40/0x40
[  161.942118]  ? touch_atime+0x33/0xd0
[  161.945695]  ? __sys_sendto+0x108/0x190
[  161.949533]  __sys_sendto+0x108/0x190
[  161.953203]  ? __fput+0x1a5/0x240
[  161.956519]  ? _cond_resched+0x19/0x30
[  161.960271]  ? task_work_run+0x64/0x90
[  161.964026]  __x64_sys_sendto+0x25/0x30
[  161.967865]  do_syscall_64+0x48/0x130
[  161.971529]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  161.976584] RIP: 0033:0x7ffbc1aa126c
[  161.980161] Code: c0 ff ff ff ff eb b9 0f 1f 80 00 00 00 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 19 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 64 c3 0f 1f 00 55 48 83 ec 20 48 89 54 24 10
[  161.998907] RSP: 002b:00007fff520a50c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[  162.006475] RAX: ffffffffffffffda RBX: 00000000000000c0 RCX: 00007ffbc1aa126c
[  162.013608] RDX: 0000000000000020 RSI: 00007fff520a50f0 RDI: 0000000000000009
[  162.020741] RBP: 00007fff520a5140 R08: 0000000000000000 R09: 0000000000000000
[  162.027873] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[  162.035005] R13: 00007fff520a50f0 R14: 0000000000000000 R15: 00007fff520a50e8
[  162.042140] Modules linked in: isst_if_common squashfs nls_iso8859_1 nls_cp437 snd_hda_codec_realtek vfat snd_hda_codec_generic fat iwlmvm ledtrig_audio snd_hda_codec_hdmi x86_pkg_temp_thermal intel_powerclamp snd_hda_intel snd_intel_dspcfg iwlwifi efi_pstore btusb snd_hda_codec btrtl btbcm efivars snd_hwdep btintel snd_hda_core iTCO_wdt iTCO_vendor_support mei_me mei loop coretemp hid_logitech_hidpp hid_logitech_dj hid_lenovo amdgpu gpu_sched i40e ixgbe ast drm_vram_helper drm_ttm_helper ttm mdio xhci_pci xhci_hcd
[  162.087682] CR2: 0000000000850b48
[  162.091002] ---[ end trace 563634e2f1b3979e ]---
[  162.101634] RIP: 0010:xfs_log_commit_cil+0x356/0x7f0
[  162.106602] Code: 00 00 48 89 7e 08 49 89 76 30 48 89 11 48 89 4a 08 8b 4c 24 2c 48 89 85 c0 00 00 00 48 89 85 c8 00 00 00 49 8b 46 20 45 31 c9 <8b> 70 20 85 f6 0f 84 d9 02 00 00 45 31 c0 85 c9 7e 4f 41 8b 46 2c
[  162.125348] RSP: 0018:ffffc90021fefb00 EFLAGS: 00010246
[  162.130572] RAX: 0000000000000000 RBX: ffff8897a9ea80b0 RCX: 0000000000000458
[  162.137705] RDX: ffff8897a9ea80c0 RSI: ffff88afc39a1200 RDI: ffff88afb1ae2c18
[  162.144838] RBP: ffff8897a9ea8000 R08: ffffc90021fefb30 R09: 0000000000000000
[  162.151971] R10: 0000000000000084 R11: 0000000000000012 R12: ffff8897721bd400
[  162.159103] R13: ffff88afb1ae2c00 R14: ffff88afb19860c0 R15: ffff8897a9ea80a0
[  162.166235] FS:  00007ffbbe9a1980(0000) GS:ffff88afdf880000(0000) knlGS:0000000000000000
[  162.174322] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  162.180068] CR2: 0000000000850b48 CR3: 000000179c01e005 CR4: 00000000007606e0
[  162.187200] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  162.194326] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  162.201458] PKRU: 55555554
[  162.567356] Shutting down cpus with NMI
[  162.571201] Kernel Offset: disabled
[  162.580776] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

--phl2npw7hpcjbj6l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 5.7.0-rc7 Kernel Configuration
#

#
# Compiler: gcc (Debian 9.3.0-13) 9.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=234000000
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_UAPI_HEADER_TEST is not set
CONFIG_LOCALVERSION="-andres"
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_SCHED_THERMAL_PRESSURE is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_BOOT_CONFIG=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
# CONFIG_BPF_JIT_ALWAYS_ON is not set
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
# CONFIG_X86_MPPARSE is not set
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
# CONFIG_HYPERVISOR_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
CONFIG_MCORE2=y
# CONFIG_MATOM is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_P6_NOP=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=512
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=512
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
# CONFIG_X86_MCE_INJECT is not set
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
# CONFIG_MICROCODE_OLD_INTERFACE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x200000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x1000000
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
CONFIG_COMPAT_VDSO=y
# CONFIG_LEGACY_VSYSCALL_EMULATE is not set
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
CONFIG_LEGACY_VSYSCALL_NONE=y
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE=""
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# CONFIG_LIVEPATCH is not set
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_AUTOSLEEP=y
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
CONFIG_PM_TEST_SUSPEND=y
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
CONFIG_ENERGY_MODEL=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=y
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=y
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_HMAT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=m
CONFIG_DPTF_POWER=m
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=y
CONFIG_ACPI_ADXL=y
CONFIG_PMIC_OPREGION=y
CONFIG_BXT_WC_PMIC_OPREGION=y
CONFIG_CHT_DC_TI_PMIC_OPREGION=y
CONFIG_ACPI_CONFIGFS=y
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
# CONFIG_X86_P4_CLOCKMOD is not set

#
# shared options
#
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
CONFIG_X86_SYSFB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
# CONFIG_FW_CFG_SYSFS is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=m
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=m
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_SOFT_RESERVE=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=m
CONFIG_EFI_CAPSULE_LOADER=m
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_EFI_RCI2_TABLE=y
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
CONFIG_KVM_INTEL=y
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_MMU_AUDIT is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODVERSIONS=y
CONFIG_ASM_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y
CONFIG_SYSV68_PARTITION=y
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=m
CONFIG_IOSCHED_BFQ=m
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
# CONFIG_CLEANCACHE is not set
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
# CONFIG_ZSWAP is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_HMM_MIRROR=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=y
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=y
CONFIG_NET_KEY=y
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
CONFIG_XDP_SOCKETS_DIAG=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=y
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_ESP_OFFLOAD=y
CONFIG_INET_ESPINTCP=y
CONFIG_INET_IPCOMP=y
CONFIG_INET_XFRM_TUNNEL=y
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=y
CONFIG_INET_RAW_DIAG=y
CONFIG_INET_DIAG_DESTROY=y
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=y
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=y
CONFIG_TCP_CONG_HTCP=y
CONFIG_TCP_CONG_HSTCP=y
CONFIG_TCP_CONG_HYBLA=y
CONFIG_TCP_CONG_VEGAS=y
CONFIG_TCP_CONG_NV=y
CONFIG_TCP_CONG_SCALABLE=y
CONFIG_TCP_CONG_LP=y
CONFIG_TCP_CONG_VENO=y
CONFIG_TCP_CONG_YEAH=y
CONFIG_TCP_CONG_ILLINOIS=y
CONFIG_TCP_CONG_DCTCP=y
CONFIG_TCP_CONG_CDG=y
CONFIG_TCP_CONG_BBR=y
# CONFIG_DEFAULT_BIC is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_HTCP is not set
# CONFIG_DEFAULT_HYBLA is not set
# CONFIG_DEFAULT_VEGAS is not set
# CONFIG_DEFAULT_VENO is not set
# CONFIG_DEFAULT_WESTWOOD is not set
# CONFIG_DEFAULT_DCTCP is not set
# CONFIG_DEFAULT_CDG is not set
# CONFIG_DEFAULT_BBR is not set
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=y
CONFIG_INET6_ESP=y
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=y
CONFIG_IPV6_MIP6=y
CONFIG_IPV6_ILA=y
CONFIG_INET6_XFRM_TUNNEL=y
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=y
CONFIG_IPV6_SIT=y
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_MPTCP_IPV6=y
# CONFIG_MPTCP_HMAC_TEST is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=y

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=y
CONFIG_NETFILTER_NETLINK_QUEUE=y
CONFIG_NETFILTER_NETLINK_LOG=y
CONFIG_NETFILTER_NETLINK_OSF=y
CONFIG_NF_CONNTRACK=y
CONFIG_NF_LOG_COMMON=y
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=y
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
# CONFIG_NF_CONNTRACK_ZONES is not set
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
# CONFIG_NF_CT_PROTO_DCCP is not set
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
# CONFIG_NF_CONNTRACK_AMANDA is not set
CONFIG_NF_CONNTRACK_FTP=y
# CONFIG_NF_CONNTRACK_H323 is not set
# CONFIG_NF_CONNTRACK_IRC is not set
CONFIG_NF_CONNTRACK_BROADCAST=y
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
CONFIG_NF_CONNTRACK_SNMP=y
CONFIG_NF_CONNTRACK_PPTP=y
CONFIG_NF_CONNTRACK_SANE=y
CONFIG_NF_CONNTRACK_SIP=y
CONFIG_NF_CONNTRACK_TFTP=y
CONFIG_NF_CT_NETLINK=y
# CONFIG_NF_CT_NETLINK_TIMEOUT is not set
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=y
CONFIG_NF_NAT_FTP=y
CONFIG_NF_NAT_SIP=y
CONFIG_NF_NAT_TFTP=y
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=y
CONFIG_NF_TABLES=y
CONFIG_NF_TABLES_INET=y
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=y
CONFIG_NFT_COUNTER=y
CONFIG_NFT_CONNLIMIT=y
CONFIG_NFT_LOG=y
CONFIG_NFT_LIMIT=y
# CONFIG_NFT_MASQ is not set
# CONFIG_NFT_REDIR is not set
CONFIG_NFT_NAT=y
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
CONFIG_NFT_QUEUE=y
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=y
CONFIG_NFT_REJECT_INET=y
CONFIG_NFT_COMPAT=y
CONFIG_NFT_HASH=y
CONFIG_NFT_FIB=y
# CONFIG_NFT_FIB_INET is not set
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=y
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
CONFIG_NFT_SYNPROXY=y
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=y
CONFIG_NETFILTER_XT_CONNMARK=y
CONFIG_NETFILTER_XT_SET=y

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=y
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=y
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=y
CONFIG_NETFILTER_XT_TARGET_CONNMARK=y
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
CONFIG_NETFILTER_XT_TARGET_CT=y
CONFIG_NETFILTER_XT_TARGET_DSCP=y
CONFIG_NETFILTER_XT_TARGET_HL=y
CONFIG_NETFILTER_XT_TARGET_HMARK=y
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=y
CONFIG_NETFILTER_XT_TARGET_LED=y
CONFIG_NETFILTER_XT_TARGET_LOG=y
CONFIG_NETFILTER_XT_TARGET_MARK=y
CONFIG_NETFILTER_XT_NAT=y
CONFIG_NETFILTER_XT_TARGET_NETMAP=y
CONFIG_NETFILTER_XT_TARGET_NFLOG=y
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=y
# CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
CONFIG_NETFILTER_XT_TARGET_RATEEST=y
CONFIG_NETFILTER_XT_TARGET_REDIRECT=y
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=y
CONFIG_NETFILTER_XT_TARGET_TEE=y
CONFIG_NETFILTER_XT_TARGET_TPROXY=y
CONFIG_NETFILTER_XT_TARGET_TRACE=y
CONFIG_NETFILTER_XT_TARGET_SECMARK=y
CONFIG_NETFILTER_XT_TARGET_TCPMSS=y
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=y

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
CONFIG_NETFILTER_XT_MATCH_BPF=y
CONFIG_NETFILTER_XT_MATCH_CGROUP=y
CONFIG_NETFILTER_XT_MATCH_CLUSTER=y
CONFIG_NETFILTER_XT_MATCH_COMMENT=y
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=y
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=y
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=y
CONFIG_NETFILTER_XT_MATCH_CONNMARK=y
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
CONFIG_NETFILTER_XT_MATCH_CPU=y
CONFIG_NETFILTER_XT_MATCH_DCCP=y
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=y
CONFIG_NETFILTER_XT_MATCH_DSCP=y
CONFIG_NETFILTER_XT_MATCH_ECN=y
CONFIG_NETFILTER_XT_MATCH_ESP=y
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=y
CONFIG_NETFILTER_XT_MATCH_HELPER=y
CONFIG_NETFILTER_XT_MATCH_HL=y
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=y
CONFIG_NETFILTER_XT_MATCH_L2TP=y
CONFIG_NETFILTER_XT_MATCH_LENGTH=y
CONFIG_NETFILTER_XT_MATCH_LIMIT=y
CONFIG_NETFILTER_XT_MATCH_MAC=y
CONFIG_NETFILTER_XT_MATCH_MARK=y
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
CONFIG_NETFILTER_XT_MATCH_NFACCT=y
CONFIG_NETFILTER_XT_MATCH_OSF=y
CONFIG_NETFILTER_XT_MATCH_OWNER=y
CONFIG_NETFILTER_XT_MATCH_POLICY=y
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=y
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=y
CONFIG_NETFILTER_XT_MATCH_QUOTA=y
CONFIG_NETFILTER_XT_MATCH_RATEEST=y
CONFIG_NETFILTER_XT_MATCH_REALM=y
CONFIG_NETFILTER_XT_MATCH_RECENT=y
CONFIG_NETFILTER_XT_MATCH_SCTP=y
CONFIG_NETFILTER_XT_MATCH_SOCKET=y
CONFIG_NETFILTER_XT_MATCH_STATE=y
CONFIG_NETFILTER_XT_MATCH_STATISTIC=y
CONFIG_NETFILTER_XT_MATCH_STRING=y
CONFIG_NETFILTER_XT_MATCH_TCPMSS=y
CONFIG_NETFILTER_XT_MATCH_TIME=y
CONFIG_NETFILTER_XT_MATCH_U32=y
# end of Core Netfilter Configuration

CONFIG_IP_SET=y
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=y
CONFIG_IP_SET_BITMAP_IPMAC=y
CONFIG_IP_SET_BITMAP_PORT=y
CONFIG_IP_SET_HASH_IP=y
CONFIG_IP_SET_HASH_IPMARK=y
CONFIG_IP_SET_HASH_IPPORT=y
CONFIG_IP_SET_HASH_IPPORTIP=y
CONFIG_IP_SET_HASH_IPPORTNET=y
# CONFIG_IP_SET_HASH_IPMAC is not set
# CONFIG_IP_SET_HASH_MAC is not set
CONFIG_IP_SET_HASH_NETPORTNET=y
CONFIG_IP_SET_HASH_NET=y
CONFIG_IP_SET_HASH_NETNET=y
CONFIG_IP_SET_HASH_NETPORT=y
CONFIG_IP_SET_HASH_NETIFACE=y
CONFIG_IP_SET_LIST_SET=y
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=y
CONFIG_NF_SOCKET_IPV4=y
CONFIG_NF_TPROXY_IPV4=y
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=y
CONFIG_NFT_DUP_IPV4=y
CONFIG_NFT_FIB_IPV4=y
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=y
CONFIG_NF_LOG_ARP=y
CONFIG_NF_LOG_IPV4=y
CONFIG_NF_REJECT_IPV4=y
CONFIG_NF_NAT_SNMP_BASIC=y
CONFIG_NF_NAT_PPTP=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_AH=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_RPFILTER=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_SYNPROXY=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_NETMAP=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_CLUSTERIP=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_TTL=y
CONFIG_IP_NF_RAW=y
CONFIG_IP_NF_SECURITY=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=y
CONFIG_NF_TPROXY_IPV6=y
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=y
CONFIG_NFT_DUP_IPV6=y
CONFIG_NFT_FIB_IPV6=y
CONFIG_NF_DUP_IPV6=y
CONFIG_NF_REJECT_IPV6=y
CONFIG_NF_LOG_IPV6=y
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_AH=y
CONFIG_IP6_NF_MATCH_EUI64=y
CONFIG_IP6_NF_MATCH_FRAG=y
CONFIG_IP6_NF_MATCH_OPTS=y
CONFIG_IP6_NF_MATCH_HL=y
CONFIG_IP6_NF_MATCH_IPV6HEADER=y
CONFIG_IP6_NF_MATCH_MH=y
CONFIG_IP6_NF_MATCH_RPFILTER=y
CONFIG_IP6_NF_MATCH_RT=y
CONFIG_IP6_NF_MATCH_SRH=y
CONFIG_IP6_NF_TARGET_HL=y
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_REJECT=y
CONFIG_IP6_NF_TARGET_SYNPROXY=y
CONFIG_IP6_NF_MANGLE=y
CONFIG_IP6_NF_RAW=y
CONFIG_IP6_NF_SECURITY=y
CONFIG_IP6_NF_NAT=y
CONFIG_IP6_NF_TARGET_MASQUERADE=y
CONFIG_IP6_NF_TARGET_NPT=y
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=y
CONFIG_NF_TABLES_BRIDGE=y
CONFIG_NFT_BRIDGE_META=y
CONFIG_NFT_BRIDGE_REJECT=y
CONFIG_NF_LOG_BRIDGE=y
CONFIG_NF_CONNTRACK_BRIDGE=y
CONFIG_BRIDGE_NF_EBTABLES=y
CONFIG_BRIDGE_EBT_BROUTE=y
CONFIG_BRIDGE_EBT_T_FILTER=y
CONFIG_BRIDGE_EBT_T_NAT=y
CONFIG_BRIDGE_EBT_802_3=y
CONFIG_BRIDGE_EBT_AMONG=y
CONFIG_BRIDGE_EBT_ARP=y
CONFIG_BRIDGE_EBT_IP=y
CONFIG_BRIDGE_EBT_IP6=y
CONFIG_BRIDGE_EBT_LIMIT=y
CONFIG_BRIDGE_EBT_MARK=y
CONFIG_BRIDGE_EBT_PKTTYPE=y
CONFIG_BRIDGE_EBT_STP=y
CONFIG_BRIDGE_EBT_VLAN=y
CONFIG_BRIDGE_EBT_ARPREPLY=y
CONFIG_BRIDGE_EBT_DNAT=y
CONFIG_BRIDGE_EBT_MARK_T=y
CONFIG_BRIDGE_EBT_REDIRECT=y
CONFIG_BRIDGE_EBT_SNAT=y
CONFIG_BRIDGE_EBT_LOG=y
CONFIG_BRIDGE_EBT_NFLOG=y
CONFIG_BPFILTER=y
CONFIG_BPFILTER_UMH=y
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=y
# CONFIG_SCTP_DBG_OBJCNT is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=y
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_MULTIQ=y
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFB=y
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_CBS=y
CONFIG_NET_SCH_ETF=y
CONFIG_NET_SCH_TAPRIO=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=y
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=y
CONFIG_NET_SCH_MQPRIO=y
CONFIG_NET_SCH_SKBPRIO=y
CONFIG_NET_SCH_CHOKE=y
CONFIG_NET_SCH_QFQ=y
CONFIG_NET_SCH_CODEL=y
CONFIG_NET_SCH_FQ_CODEL=y
CONFIG_NET_SCH_CAKE=y
CONFIG_NET_SCH_FQ=y
CONFIG_NET_SCH_HHF=y
CONFIG_NET_SCH_PIE=y
CONFIG_NET_SCH_FQ_PIE=y
CONFIG_NET_SCH_INGRESS=y
# CONFIG_NET_SCH_PLUG is not set
CONFIG_NET_SCH_ETS=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
CONFIG_NET_CLS_TCINDEX=y
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=y
CONFIG_NET_CLS_FLOW=y
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=y
CONFIG_NET_CLS_FLOWER=y
CONFIG_NET_CLS_MATCHALL=y
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=y
CONFIG_NET_EMATCH_NBYTE=y
CONFIG_NET_EMATCH_U32=y
CONFIG_NET_EMATCH_META=y
CONFIG_NET_EMATCH_TEXT=y
CONFIG_NET_EMATCH_IPSET=y
CONFIG_NET_EMATCH_IPT=y
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
CONFIG_NET_ACT_GACT=y
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=y
CONFIG_NET_ACT_SAMPLE=y
CONFIG_NET_ACT_IPT=y
CONFIG_NET_ACT_NAT=y
CONFIG_NET_ACT_PEDIT=y
CONFIG_NET_ACT_SIMP=y
CONFIG_NET_ACT_SKBEDIT=y
CONFIG_NET_ACT_CSUM=y
CONFIG_NET_ACT_MPLS=y
CONFIG_NET_ACT_VLAN=y
CONFIG_NET_ACT_BPF=y
CONFIG_NET_ACT_CONNMARK=y
CONFIG_NET_ACT_CTINFO=y
CONFIG_NET_ACT_SKBMOD=y
CONFIG_NET_ACT_IFE=y
CONFIG_NET_ACT_TUNNEL_KEY=y
CONFIG_NET_IFE_SKBMARK=y
CONFIG_NET_IFE_SKBPRIO=y
CONFIG_NET_IFE_SKBTCINDEX=y
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=y
CONFIG_VSOCKETS_DIAG=y
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
CONFIG_NETLINK_DIAG=y
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
CONFIG_BT=y
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=y
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=y
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=y
CONFIG_BT_HS=y
CONFIG_BT_LE=y
CONFIG_BT_LEDS=y
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_QCA=m
CONFIG_BT_HCIBTUSB=m
CONFIG_BT_HCIBTUSB_AUTOSUSPEND=y
CONFIG_BT_HCIBTUSB_BCM=y
CONFIG_BT_HCIBTUSB_MTK=y
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_SERDEV=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_NOKIA=m
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
CONFIG_BT_HCIUART_LL=y
CONFIG_BT_HCIUART_3WIRE=y
CONFIG_BT_HCIUART_INTEL=y
CONFIG_BT_HCIUART_BCM=y
CONFIG_BT_HCIUART_RTL=y
CONFIG_BT_HCIUART_QCA=y
CONFIG_BT_HCIUART_AG6XX=y
CONFIG_BT_HCIUART_MRVL=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
CONFIG_BT_MTKSDIO=m
CONFIG_BT_MTKUART=m
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_SPY=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=y
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
CONFIG_CFG80211_DEBUGFS=y
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_CFG80211_WEXT_EXPORT=y
CONFIG_LIB80211=m
CONFIG_LIB80211_CRYPT_WEP=m
CONFIG_LIB80211_CRYPT_CCMP=m
CONFIG_LIB80211_CRYPT_TKIP=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=y
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_FAILOVER=y
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
CONFIG_PCIE_PTM=y
CONFIG_PCIE_BW=y
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=m
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
CONFIG_PCI_MESON=y
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

CONFIG_PCCARD=m
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_FW_LOADER_COMPRESS=y
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=m
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=m
CONFIG_FTL=m
CONFIG_NFTL=m
CONFIG_NFTL_RW=y
CONFIG_INFTL=m
CONFIG_RFD_FTL=m
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
CONFIG_MTD_OOPS=m
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
# CONFIG_MTD_PHYSMAP_COMPAT is not set
# CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
# CONFIG_MTD_SBC_GXX is not set
# CONFIG_MTD_AMD76XROM is not set
# CONFIG_MTD_ICHXROM is not set
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_L440GX is not set
CONFIG_MTD_PCI=m
CONFIG_MTD_PCMCIA=m
# CONFIG_MTD_PCMCIA_ANONYMOUS is not set
CONFIG_MTD_INTEL_VR_NOR=m
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
CONFIG_MTD_SST25L=m
CONFIG_MTD_SLRAM=m
CONFIG_MTD_PHRAM=m
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=m

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

CONFIG_MTD_NAND_CORE=m
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_NAND_ECC_SW_HAMMING=m
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
CONFIG_MTD_RAW_NAND=m
# CONFIG_MTD_NAND_ECC_SW_BCH is not set

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_CAFE is not set
# CONFIG_MTD_NAND_MXIC is not set
# CONFIG_MTD_NAND_GPIO is not set
# CONFIG_MTD_NAND_PLATFORM is not set

#
# Misc
#
# CONFIG_MTD_NAND_NANDSIM is not set
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=m
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
# CONFIG_SPI_INTEL_SPI_PCI is not set
# CONFIG_SPI_INTEL_SPI_PLATFORM is not set
# CONFIG_MTD_UBI is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=y
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
CONFIG_NVME_TCP=m
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
CONFIG_NVME_TARGET_TCP=m
# end of NVME Support

#
# Misc devices
#
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
CONFIG_PVPANIC=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_AT25=m
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_93XX46=m
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
CONFIG_INTEL_MEI_TXE=m
CONFIG_INTEL_MEI_HDCP=m
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#
CONFIG_INTEL_MIC_BUS=m
CONFIG_SCIF_BUS=m
CONFIG_VOP_BUS=m
CONFIG_INTEL_MIC_HOST=m
CONFIG_INTEL_MIC_CARD=m
CONFIG_SCIF=m
CONFIG_MIC_COSM=m
CONFIG_VOP=m
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
CONFIG_MISC_RTSX_USB=m
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
CONFIG_SCSI_FDOMAIN=m
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_GDTH=m
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_LOWLEVEL_PCMCIA=y
CONFIG_PCMCIA_AHA152X=m
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_PCMCIA_QLOGIC=m
CONFIG_PCMCIA_SYM53C500=m
CONFIG_SCSI_DH=y
# CONFIG_SCSI_DH_RDAC is not set
# CONFIG_SCSI_DH_HP_SW is not set
# CONFIG_SCSI_DH_EMC is not set
# CONFIG_SCSI_DH_ALUA is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_ZPODD=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
# CONFIG_ATA_SFF is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_AUTODETECT is not set
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=y
CONFIG_MD_MULTIPATH=y
CONFIG_MD_FAULTY=y
CONFIG_BCACHE=m
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
CONFIG_DM_UNSTRIPED=y
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
CONFIG_DM_ERA=m
CONFIG_DM_CLONE=m
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
CONFIG_DM_DUST=m
CONFIG_DM_INIT=y
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
CONFIG_DM_VERITY_FEC=y
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_ZONED=m
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=m
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
CONFIG_WIREGUARD=m
# CONFIG_WIREGUARD_DEBUG is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=y
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=y
CONFIG_MACVTAP=y
CONFIG_IPVLAN_L3S=y
CONFIG_IPVLAN=y
CONFIG_IPVTAP=y
# CONFIG_VXLAN is not set
CONFIG_GENEVE=m
# CONFIG_BAREUDP is not set
CONFIG_GTP=m
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=y
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=y
CONFIG_TAP=y
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=y
CONFIG_NLMON=y
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=m
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_NET_VENDOR_AURORA is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_CADENCE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_NET_VENDOR_CORTINA is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
# CONFIG_NET_VENDOR_FUJITSU is not set
# CONFIG_NET_VENDOR_GOOGLE is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=m
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
CONFIG_IGB_HWMON=y
CONFIG_IGB_DCA=y
CONFIG_IGBVF=m
CONFIG_IXGB=m
CONFIG_IXGBE=m
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCA=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBE_IPSEC=y
CONFIG_IXGBEVF=m
CONFIG_IXGBEVF_IPSEC=y
CONFIG_I40E=m
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETERION is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NI is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_ETHOC is not set
# CONFIG_NET_VENDOR_PACKET_ENGINES is not set
# CONFIG_NET_VENDOR_PENSANDO is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
# CONFIG_NET_VENDOR_XIRCOM is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set
# CONFIG_MDIO_XPCS is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y

#
# MII PHY device drivers
#
# CONFIG_ADIN_PHY is not set
# CONFIG_AMD_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
CONFIG_FIXED_PHY=m
# CONFIG_ICPLUS_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MICREL_PHY is not set
CONFIG_MICROCHIP_PHY=m
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_AT803X_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
# CONFIG_SLIP is not set
CONFIG_SLHC=m
CONFIG_USB_NET_DRIVERS=m
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_RTL8152=m
CONFIG_USB_LAN78XX=m
CONFIG_USB_USBNET=m
CONFIG_USB_NET_AX8817X=m
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=m
CONFIG_USB_NET_CDC_EEM=m
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=m
CONFIG_USB_NET_SR9700=m
CONFIG_USB_NET_SR9800=m
CONFIG_USB_NET_SMSC75XX=m
CONFIG_USB_NET_SMSC95XX=m
CONFIG_USB_NET_GL620A=m
CONFIG_USB_NET_NET1080=m
CONFIG_USB_NET_PLUSB=m
CONFIG_USB_NET_MCS7830=m
CONFIG_USB_NET_RNDIS_HOST=m
CONFIG_USB_NET_CDC_SUBSET_ENABLE=m
CONFIG_USB_NET_CDC_SUBSET=m
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=m
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=m
CONFIG_USB_IPHETH=m
CONFIG_USB_SIERRA_NET=m
CONFIG_USB_VL600=m
CONFIG_USB_NET_CH9200=m
CONFIG_USB_NET_AQC111=m
CONFIG_WLAN=y
# CONFIG_WLAN_VENDOR_ADMTEK is not set
# CONFIG_WLAN_VENDOR_ATH is not set
# CONFIG_WLAN_VENDOR_ATMEL is not set
# CONFIG_WLAN_VENDOR_BROADCOM is not set
# CONFIG_WLAN_VENDOR_CISCO is not set
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_IPW2100=m
CONFIG_IPW2100_MONITOR=y
CONFIG_IPW2100_DEBUG=y
CONFIG_IPW2200=m
CONFIG_IPW2200_MONITOR=y
CONFIG_IPW2200_RADIOTAP=y
CONFIG_IPW2200_PROMISCUOUS=y
CONFIG_IPW2200_QOS=y
# CONFIG_IPW2200_DEBUG is not set
CONFIG_LIBIPW=m
# CONFIG_LIBIPW_DEBUG is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
# CONFIG_IWLEGACY_DEBUG is not set
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

# CONFIG_WLAN_VENDOR_INTERSIL is not set
# CONFIG_WLAN_VENDOR_MARVELL is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
# CONFIG_WLAN_VENDOR_RALINK is not set
# CONFIG_WLAN_VENDOR_REALTEK is not set
# CONFIG_WLAN_VENDOR_RSI is not set
# CONFIG_WLAN_VENDOR_ST is not set
# CONFIG_WLAN_VENDOR_TI is not set
# CONFIG_WLAN_VENDOR_ZYDAS is not set
# CONFIG_WLAN_VENDOR_QUANTENNA is not set
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_PCMCIA_WL3501 is not set
# CONFIG_MAC80211_HWSIM is not set
CONFIG_USB_NET_RNDIS_WLAN=m
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_USB4_NET=m
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=y
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
# CONFIG_MOUSE_CYAPA is not set
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=y
CONFIG_MOUSE_SYNAPTICS_USB=y
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=m
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=m
CONFIG_JOYSTICK_IFORCE_232=m
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_ZHENHUA=m
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=m
CONFIG_JOYSTICK_XPAD=m
CONFIG_JOYSTICK_XPAD_FF=y
CONFIG_JOYSTICK_XPAD_LEDS=y
CONFIG_JOYSTICK_PSXPAD_SPI=m
CONFIG_JOYSTICK_PSXPAD_SPI_FF=y
CONFIG_JOYSTICK_PXRC=m
CONFIG_JOYSTICK_FSIA6B=m
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_APANEL is not set
# CONFIG_INPUT_GP2A is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SPI=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_GPIO_PS2=m
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_NR_UARTS=48
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_ISI is not set
# CONFIG_N_HDLC is not set
# CONFIG_N_GSM is not set
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_HVC_DRIVER=y
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
CONFIG_IPMB_DEVICE_INTERFACE=m
CONFIG_HW_RANDOM=m
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
# CONFIG_APPLICOM is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
# CONFIG_SCR24X is not set
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y
CONFIG_NVRAM=y
# CONFIG_RAW_DRIVER is not set
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=m
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_SPI_CR50=y
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=m
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
CONFIG_TCG_TIS_ST33ZP24_SPI=m
# CONFIG_TELCLOCK is not set
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_AMD_MP2=y
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
CONFIG_I2C_ISMT=y
CONFIG_I2C_PIIX4=y
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
CONFIG_I2C_NVIDIA_GPU=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PCI=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
CONFIG_I2C_EMEV2=m
CONFIG_I2C_GPIO=m
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_ROBOTFUZZ_OSIF=m
CONFIG_I2C_TAOS_EVM=m
CONFIG_I2C_TINY_USB=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=m
CONFIG_CDNS_I3C_MASTER=m
CONFIG_DW_I3C_MASTER=m
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=m
CONFIG_SPI_AXI_SPI_ENGINE=m
CONFIG_SPI_BITBANG=m
CONFIG_SPI_CADENCE=m
CONFIG_SPI_DESIGNWARE=m
CONFIG_SPI_DW_PCI=m
# CONFIG_SPI_DW_MID_DMA is not set
CONFIG_SPI_DW_MMIO=m
CONFIG_SPI_NXP_FLEXSPI=m
CONFIG_SPI_GPIO=m
CONFIG_SPI_OC_TINY=m
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
CONFIG_SPI_ROCKCHIP=m
CONFIG_SPI_SC18IS602=m
CONFIG_SPI_SIFIVE=m
CONFIG_SPI_MXIC=m
CONFIG_SPI_XCOMM=m
CONFIG_SPI_XILINX=m
CONFIG_SPI_ZYNQMP_GQSPI=m

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=m
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=m
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=m
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=m
CONFIG_SPMI=m
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
CONFIG_PINCTRL_MCP23S08=m
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=m
CONFIG_PINCTRL_LYNXPOINT=m
CONFIG_PINCTRL_INTEL=m
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_GEMINILAKE=m
CONFIG_PINCTRL_ICELAKE=m
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_PINCTRL_TIGERLAKE=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
CONFIG_GPIO_DWAPB=m
CONFIG_GPIO_EXAR=m
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_ICH=m
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_VX855=m
CONFIG_GPIO_XILINX=m
CONFIG_GPIO_AMD_FCH=m
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=m
CONFIG_GPIO_IT87=m
CONFIG_GPIO_SCH=m
CONFIG_GPIO_SCH311X=m
CONFIG_GPIO_WINBOND=m
CONFIG_GPIO_WS16C48=m
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_WHISKEY_COVE=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=m
CONFIG_GPIO_BT8XX=m
CONFIG_GPIO_ML_IOH=m
CONFIG_GPIO_PCI_IDIO_16=m
CONFIG_GPIO_PCIE_IDIO_24=m
CONFIG_GPIO_RDC321X=m
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_MAX3191X=m
CONFIG_GPIO_MAX7301=m
CONFIG_GPIO_MC33880=m
CONFIG_GPIO_PISOSR=m
CONFIG_GPIO_XRA1403=m
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

# CONFIG_GPIO_MOCKUP is not set
CONFIG_W1=m
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2490 is not set
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
# CONFIG_W1_SLAVE_DS2408 is not set
# CONFIG_W1_SLAVE_DS2413 is not set
# CONFIG_W1_SLAVE_DS2406 is not set
# CONFIG_W1_SLAVE_DS2423 is not set
# CONFIG_W1_SLAVE_DS2805 is not set
# CONFIG_W1_SLAVE_DS2430 is not set
# CONFIG_W1_SLAVE_DS2431 is not set
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2438 is not set
# CONFIG_W1_SLAVE_DS250X is not set
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

CONFIG_POWER_AVS=y
CONFIG_QCOM_CPR=m
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=m
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=m
CONFIG_BATTERY_DS2782=m
CONFIG_BATTERY_SBS=m
CONFIG_CHARGER_SBS=m
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=m
CONFIG_BATTERY_MAX1721X=m
CONFIG_CHARGER_ISP1704=m
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=m
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_SMB347=m
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_CHARGER_RT9455=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
CONFIG_SENSORS_AD7314=m
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM1177=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7310=m
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_AS370=m
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ASPEED=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DRIVETEMP=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
CONFIG_SENSORS_LTC2947_SPI=m
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX1111=m
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=m
CONFIG_SENSORS_MAX31730=m
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_ADCXX=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
CONFIG_SENSORS_NPCM7XX=m
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
CONFIG_SENSORS_BEL_PFE=m
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_INSPUR_IPSPS=m
CONFIG_SENSORS_IR35221=m
CONFIG_SENSORS_IR38064=m
CONFIG_SENSORS_IRPS5401=m
CONFIG_SENSORS_ISL68137=m
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=m
CONFIG_SENSORS_MAX16064=m
CONFIG_SENSORS_MAX20730=m
CONFIG_SENSORS_MAX20751=m
CONFIG_SENSORS_MAX31785=m
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
CONFIG_SENSORS_PXE1610=m
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_ADS7871=m
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP513=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
CONFIG_SENSORS_XGENE=m

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_CLOCK_THERMAL=y
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
CONFIG_INTEL_SOC_DTS_THERMAL=m

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
CONFIG_INT3406_THERMAL=m
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_BXT_PMIC_THERMAL=m
CONFIG_INTEL_PCH_THERMAL=m
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
# CONFIG_SBC_FITPC2_WATCHDOG is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=m
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=m
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
# CONFIG_HP_WATCHDOG is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
# CONFIG_SMSC_SCH311X_WDT is not set
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
# CONFIG_VIA_WDT is not set
# CONFIG_W83627HF_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=m
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC_BXTWC=m
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=m
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
CONFIG_MFD_INTEL_LPSS_PCI=m
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
CONFIG_MFD_RDC321X=m
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=m
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_RAVE_SP_CORE is not set
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=m
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_ACT8865 is not set
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=m
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LTC3589 is not set
# CONFIG_REGULATOR_LTC3676 is not set
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8952 is not set
CONFIG_REGULATOR_MP8859=m
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
# CONFIG_REGULATOR_PV88060 is not set
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_PWM=m
# CONFIG_REGULATOR_QCOM_SPMI is not set
# CONFIG_REGULATOR_SLG51000 is not set
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_CEC_CORE=y
# CONFIG_RC_CORE is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_MEDIA_CONTROLLER=y
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_V4L2_I2C=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
# CONFIG_V4L2_FLASH_LED_CLASS is not set
CONFIG_V4L2_FWNODE=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_VMALLOC=m

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
# CONFIG_USB_M5602 is not set
# CONFIG_USB_STV06XX is not set
# CONFIG_USB_GL860 is not set
# CONFIG_USB_GSPCA_BENQ is not set
# CONFIG_USB_GSPCA_CONEX is not set
# CONFIG_USB_GSPCA_CPIA1 is not set
# CONFIG_USB_GSPCA_DTCS033 is not set
# CONFIG_USB_GSPCA_ETOMS is not set
# CONFIG_USB_GSPCA_FINEPIX is not set
# CONFIG_USB_GSPCA_JEILINJ is not set
# CONFIG_USB_GSPCA_JL2005BCD is not set
# CONFIG_USB_GSPCA_KINECT is not set
# CONFIG_USB_GSPCA_KONICA is not set
# CONFIG_USB_GSPCA_MARS is not set
# CONFIG_USB_GSPCA_MR97310A is not set
# CONFIG_USB_GSPCA_NW80X is not set
# CONFIG_USB_GSPCA_OV519 is not set
# CONFIG_USB_GSPCA_OV534 is not set
# CONFIG_USB_GSPCA_OV534_9 is not set
# CONFIG_USB_GSPCA_PAC207 is not set
# CONFIG_USB_GSPCA_PAC7302 is not set
# CONFIG_USB_GSPCA_PAC7311 is not set
# CONFIG_USB_GSPCA_SE401 is not set
# CONFIG_USB_GSPCA_SN9C2028 is not set
# CONFIG_USB_GSPCA_SN9C20X is not set
# CONFIG_USB_GSPCA_SONIXB is not set
# CONFIG_USB_GSPCA_SONIXJ is not set
# CONFIG_USB_GSPCA_SPCA500 is not set
# CONFIG_USB_GSPCA_SPCA501 is not set
# CONFIG_USB_GSPCA_SPCA505 is not set
# CONFIG_USB_GSPCA_SPCA506 is not set
# CONFIG_USB_GSPCA_SPCA508 is not set
# CONFIG_USB_GSPCA_SPCA561 is not set
# CONFIG_USB_GSPCA_SPCA1528 is not set
# CONFIG_USB_GSPCA_SQ905 is not set
# CONFIG_USB_GSPCA_SQ905C is not set
# CONFIG_USB_GSPCA_SQ930X is not set
# CONFIG_USB_GSPCA_STK014 is not set
# CONFIG_USB_GSPCA_STK1135 is not set
# CONFIG_USB_GSPCA_STV0680 is not set
# CONFIG_USB_GSPCA_SUNPLUS is not set
# CONFIG_USB_GSPCA_T613 is not set
# CONFIG_USB_GSPCA_TOPRO is not set
# CONFIG_USB_GSPCA_TOUPTEK is not set
# CONFIG_USB_GSPCA_TV8532 is not set
# CONFIG_USB_GSPCA_VC032X is not set
# CONFIG_USB_GSPCA_VICAM is not set
# CONFIG_USB_GSPCA_XIRLINK_CIT is not set
# CONFIG_USB_GSPCA_ZC3XX is not set
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
CONFIG_VIDEO_CPIA2=m
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
CONFIG_VIDEO_USBTV=m

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
CONFIG_VIDEO_EM28XX_V4L2=m
CONFIG_VIDEO_EM28XX_ALSA=m

#
# Software defined radio USB devices
#
CONFIG_USB_AIRSPY=m
CONFIG_USB_HACKRF=m
CONFIG_USB_MSI2500=m

#
# USB HDMI CEC adapters
#
CONFIG_USB_PULSE8_CEC=m
CONFIG_USB_RAINSHADOW_CEC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set
CONFIG_VIDEO_IPU3_CIO2=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_CEC_PLATFORM_DRIVERS is not set
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
CONFIG_RADIO_SI470X=m
CONFIG_USB_SI470X=m
CONFIG_I2C_SI470X=m
CONFIG_RADIO_SI4713=m
CONFIG_USB_SI4713=m
CONFIG_PLATFORM_SI4713=m
CONFIG_I2C_SI4713=m
CONFIG_USB_MR800=m
CONFIG_USB_DSBR=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_SHARK=m
CONFIG_RADIO_SHARK2=m
CONFIG_USB_KEENE=m
CONFIG_USB_RAREMONO=m
CONFIG_USB_MA901=m
CONFIG_RADIO_TEA5764=m
CONFIG_RADIO_SAA7706H=m
CONFIG_RADIO_TEF6862=m
CONFIG_RADIO_WL1273=m

#
# Texas Instruments WL128x FM driver (ST based)
#
# end of Texas Instruments WL128x FM driver (ST based)

CONFIG_VIDEO_TVEEPROM=m
# CONFIG_CYPRESS_FIRMWARE is not set
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=m

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y
CONFIG_MEDIA_ATTACH=y

#
# I2C drivers hidden by 'Autoselect ancillary drivers'
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_MSP3400=m

#
# RDS decoders
#

#
# Video decoders
#
CONFIG_VIDEO_SAA711X=m
CONFIG_VIDEO_TVP5150=m

#
# Video and audio decoders
#

#
# Video encoders
#

#
# Camera sensor devices
#
CONFIG_VIDEO_OV2640=m
CONFIG_VIDEO_MT9V011=m

#
# Lens drivers
#

#
# Flash devices
#

#
# Video improvement chips
#

#
# Audio/Video compression chips
#

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#

#
# SPI drivers hidden by 'Autoselect ancillary drivers'
#

#
# Media SPI Adapters
#
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Tuner drivers hidden by 'Autoselect ancillary drivers'
#
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
CONFIG_MEDIA_TUNER_TEA5767=y
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MC44S803=y

#
# DVB Frontend drivers hidden by 'Autoselect ancillary drivers'
#

#
# Tools to develop new frontends
#

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=m
CONFIG_DRM_TTM_DMA_PAGE_POOL=y
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

CONFIG_DRM_RADEON=m
CONFIG_DRM_RADEON_USERPTR=y
CONFIG_DRM_AMDGPU=m
CONFIG_DRM_AMDGPU_SI=y
CONFIG_DRM_AMDGPU_CIK=y
CONFIG_DRM_AMDGPU_USERPTR=y
# CONFIG_DRM_AMDGPU_GART_DEBUGFS is not set

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_AMD_ACP=y
# end of ACP (Audio CoProcessor) Configuration

#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=y
CONFIG_DRM_AMD_DC_DCN=y
CONFIG_DRM_AMD_DC_HDCP=y
# CONFIG_DEBUG_KERNEL_DC is not set
# end of Display Engine Configuration

CONFIG_HSA_AMD=y
CONFIG_DRM_NOUVEAU=m
# CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT is not set
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
# CONFIG_NOUVEAU_DEBUG_MMU is not set
CONFIG_DRM_NOUVEAU_BACKLIGHT=y
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE="*"
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
# CONFIG_DRM_I915_GVT_KVMGT is not set
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
CONFIG_DRM_VGEM=y
CONFIG_DRM_VKMS=m
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
CONFIG_DRM_UDL=y
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
# CONFIG_DRM_QXL is not set
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=m
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_RADEON_BACKLIGHT=y
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SMSCUFX is not set
CONFIG_FB_UDL=m
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_L4F00242T03=m
CONFIG_LCD_LMS283GF05=m
CONFIG_LCD_LTV350QV=m
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=m
CONFIG_LCD_VGG2432A4=m
CONFIG_LCD_PLATFORM=m
CONFIG_LCD_AMS369FG06=m
CONFIG_LCD_LMS501KF03=m
CONFIG_LCD_HX8357=m
CONFIG_LCD_OTM3225A=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=m
CONFIG_BACKLIGHT_PWM=m
CONFIG_BACKLIGHT_APPLE=m
CONFIG_BACKLIGHT_QCOM_WLED=m
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=m
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=m
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
# CONFIG_SND_PCSP is not set
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=10
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
# CONFIG_SND_USB_UA101 is not set
# CONFIG_SND_USB_USX2Y is not set
# CONFIG_SND_USB_CAIAQ is not set
# CONFIG_SND_USB_US122L is not set
# CONFIG_SND_USB_6FIRE is not set
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
# CONFIG_SND_PCMCIA is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_PCI=m
CONFIG_SND_SST_IPC_ACPI=m
CONFIG_SND_SOC_INTEL_SST_ACPI=m
CONFIG_SND_SOC_INTEL_SST=m
CONFIG_SND_SOC_INTEL_SST_FIRMWARE=m
CONFIG_SND_SOC_INTEL_HASWELL=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
CONFIG_SND_SOC_INTEL_CML_H=m
CONFIG_SND_SOC_INTEL_CML_LP=m
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC=y
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=y
CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
CONFIG_SND_SOC_INTEL_BDW_RT5650_MACH=m
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH=m
# CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
CONFIG_SND_SOC_AC97_CODEC=m
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_CX2072X=m
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
CONFIG_SND_SOC_HDAC_HDA=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
CONFIG_SND_SOC_MAX98373=m
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_ANALOG is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5660=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
CONFIG_SND_SOC_SPDIF=m
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2770 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
# CONFIG_SND_SOC_TLV320ADCX140 is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_MT6660 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_ASUS is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LED is not set
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEAM=m
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=m
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER=m
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=m
CONFIG_USB_CONN_GPIO=m
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_OTG=y
CONFIG_USB_OTG_WHITELIST=y
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_OTG_FSM=m
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
CONFIG_USB_XHCI_HCD=m
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=m
CONFIG_USB_XHCI_PLATFORM=m
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=m
CONFIG_USB_EHCI_FSL=m
CONFIG_USB_EHCI_HCD_PLATFORM=m
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=m
CONFIG_USB_FOTG210_HCD=m
CONFIG_USB_MAX3421_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_PCI=m
CONFIG_USB_OHCI_HCD_PLATFORM=m
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_U132_HCD=m
CONFIG_USB_SL811_HCD=m
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_SL811_CS=m
CONFIG_USB_R8A66597_HCD=m
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
CONFIG_USBIP_VHCI_HCD=m
CONFIG_USBIP_VHCI_HC_PORTS=8
CONFIG_USBIP_VHCI_NR_HCS=1
CONFIG_USBIP_HOST=m
# CONFIG_USBIP_DEBUG is not set
CONFIG_USB_CDNS3=m
CONFIG_USB_CDNS3_HOST=y
CONFIG_USB_CDNS3_PCI_WRAP=m
CONFIG_USB_MUSB_HDRC=m
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
CONFIG_USB_DWC3=m
CONFIG_USB_DWC3_ULPI=y
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=m
CONFIG_USB_DWC3_HAPS=m
CONFIG_USB_DWC2=m
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
CONFIG_USB_DWC2_PCI=m
# CONFIG_USB_DWC2_DEBUG is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
CONFIG_USB_CHIPIDEA=m
CONFIG_USB_CHIPIDEA_PCI=m
# CONFIG_USB_CHIPIDEA_HOST is not set
CONFIG_USB_ISP1760=m
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_SIMPLE=m
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_F81232=m
CONFIG_USB_SERIAL_F8153X=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_METRO=m
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7840=m
CONFIG_USB_SERIAL_MXUPORT=m
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
CONFIG_USB_SERIAL_WISHBONE=m
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
CONFIG_USB_SERIAL_UPD78F0730=m
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_CYPRESS_CY7C63=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
# CONFIG_APPLE_MFI_FASTCHARGE is not set
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
CONFIG_USB_TRANCEVIBRATOR=m
CONFIG_USB_IOWARRIOR=m
CONFIG_USB_TEST=m
CONFIG_USB_EHSET_TEST_FIXTURE=m
CONFIG_USB_ISIGHTFW=m
CONFIG_USB_YUREX=m
CONFIG_USB_EZUSB_FX2=m
CONFIG_USB_HUB_USB251XB=m
CONFIG_USB_HSIC_USB3503=m
CONFIG_USB_HSIC_USB4604=m
CONFIG_USB_LINK_LAYER_TEST=m
CONFIG_USB_CHAOSKEY=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=m
CONFIG_USB_GPIO_VBUS=m
CONFIG_USB_ISP1301=m
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=m
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_TCPCI=m
CONFIG_TYPEC_RT1711H=m
CONFIG_TYPEC_FUSB302=m
CONFIG_TYPEC_UCSI=m
CONFIG_UCSI_CCG=m
CONFIG_UCSI_ACPI=m
CONFIG_TYPEC_HD3SS3220=m
CONFIG_TYPEC_TPS6598X=m

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=m
# CONFIG_TYPEC_MUX_INTEL_PMC is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=m
CONFIG_TYPEC_NVIDIA_ALTMODE=m
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=m
CONFIG_USB_ROLES_INTEL_XHCI=m
CONFIG_MMC=y
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
CONFIG_MMC_WBSD=m
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_SDRICOH_CS=m
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_REALTEK_PCI=m
CONFIG_MMC_REALTEK_USB=m
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_MEMSTICK_REALTEK_PCI=m
CONFIG_MEMSTICK_REALTEK_USB=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
# CONFIG_LEDS_AS3645A is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_LM3601X is not set
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=m
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=m
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
CONFIG_LEDS_USER=m
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=m
CONFIG_LEDS_TRIGGER_PATTERN=m
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=y
CONFIG_EDAC_I82975X=y
CONFIG_EDAC_I3000=y
CONFIG_EDAC_I3200=y
CONFIG_EDAC_IE31200=y
CONFIG_EDAC_X38=y
CONFIG_EDAC_I5400=y
CONFIG_EDAC_I7CORE=y
CONFIG_EDAC_I5000=y
CONFIG_EDAC_I5100=y
CONFIG_EDAC_I7300=y
CONFIG_EDAC_SBRIDGE=y
CONFIG_EDAC_SKX=y
CONFIG_EDAC_I10NM=y
CONFIG_EDAC_PND2=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=y
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=y
# CONFIG_INTEL_MIC_X100_DMA is not set
# CONFIG_PLX_DMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
# CONFIG_DW_DMAC is not set
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=y
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI=m
CONFIG_VFIO_PCI_VGA=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI_IGD=y
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VBOXGUEST=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=y
CONFIG_VHOST_RING=m
CONFIG_VHOST_DPN=y
CONFIG_VHOST=y
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=y
CONFIG_VHOST_SCSI=m
CONFIG_VHOST_VSOCK=y
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# end of Android

# CONFIG_LTE_GDM724X is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
# CONFIG_WMI_BMOF is not set
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_HUAWEI_WMI is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=y
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACER_WMI is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ASUS_WMI is not set
# CONFIG_EEEPC_LAPTOP is not set
# CONFIG_DCDBAS is not set
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_RBTN is not set
# CONFIG_DELL_RBU is not set
# CONFIG_DELL_SMO8800 is not set
# CONFIG_DELL_WMI_AIO is not set
# CONFIG_DELL_WMI_LED is not set
# CONFIG_AMILO_RFKILL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_HP_WMI is not set
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
CONFIG_THINKPAD_ACPI_DEBUG=y
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_CHT_INT33FE=m
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_INT0002_VGPIO=m
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_OAKTRAIL is not set
CONFIG_INTEL_VBTN=m
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_MSI_LAPTOP is not set
# CONFIG_MSI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_SAMSUNG_LAPTOP is not set
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_COMPAL_LAPTOP is not set
# CONFIG_LG_LAPTOP is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_SONY_LAPTOP is not set
# CONFIG_SYSTEM76_ACPI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
CONFIG_I2C_MULTI_INSTANTIATE=m
# CONFIG_MLX_PLATFORM is not set
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=m
CONFIG_INTEL_SMARTCONNECT=m

#
# Intel Speed Select Technology interface support
#
CONFIG_INTEL_SPEED_SELECT_INTERFACE=m
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TURBO_MAX_3=y
CONFIG_INTEL_UNCORE_FREQ_CONTROL=m
CONFIG_INTEL_BXTWC_PMIC_TMU=m
# CONFIG_INTEL_CHTDC_TI_PWRBTN is not set
CONFIG_INTEL_PMC_CORE=m
CONFIG_INTEL_PMC_IPC=m
CONFIG_INTEL_PUNIT_IPC=m
CONFIG_INTEL_TELEMETRY=m
CONFIG_PMC_ATOM=y
# CONFIG_MFD_CROS_EC is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

CONFIG_IOMMU_DEBUGFS=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=y
CONFIG_AMD_IOMMU_DEBUGFS=y
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_DEBUGFS=y
CONFIG_INTEL_IOMMU_SVM=y
CONFIG_INTEL_IOMMU_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
CONFIG_DEVFREQ_GOV_POWERSAVE=m
CONFIG_DEVFREQ_GOV_USERSPACE=m
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_FSA9480 is not set
# CONFIG_EXTCON_GPIO is not set
# CONFIG_EXTCON_INTEL_INT3496 is not set
# CONFIG_EXTCON_MAX3355 is not set
# CONFIG_EXTCON_PTN5150 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_MEMORY=y
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
# CONFIG_AD7124 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7292 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_CC10001_ADC is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2496 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_QCOM_SPMI_IADC is not set
# CONFIG_QCOM_SPMI_VADC is not set
# CONFIG_QCOM_SPMI_ADC5 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_PMS7003 is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5770R is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_FXOS8700_I2C is not set
# CONFIG_FXOS8700_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP002 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_HRTIMER_TRIGGER is not set
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
# CONFIG_HP03 is not set
# CONFIG_ICP10100 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_LTC2983 is not set
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
CONFIG_PWM_PCA9685=m

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_BRCMSTB_RESCAL is not set
# CONFIG_RESET_TI_SYSCON is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=m
CONFIG_PHY_CPCAP_USB=m
CONFIG_PHY_QCOM_USB_HS=m
CONFIG_PHY_QCOM_USB_HSIC=m
CONFIG_PHY_SAMSUNG_USB2=m
CONFIG_PHY_TUSB1210=m
CONFIG_PHY_INTEL_EMMC=m
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=y
CONFIG_INTEL_RAPL=y
CONFIG_IDLE_INJECT=y
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_USB4=m

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=y
CONFIG_ND_BLK=y
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=y
CONFIG_BTT=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_HMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_SPMI_SDAM=m

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_VIRTIO_FS=y
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=y
CONFIG_FSCACHE_STATS=y
CONFIG_FSCACHE_HISTOGRAM=y
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=y
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_EXFAT_FS=m
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=m
CONFIG_ECRYPT_FS_MESSAGING=y
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
CONFIG_PSTORE_LZO_COMPRESS=m
CONFIG_PSTORE_LZ4_COMPRESS=m
CONFIG_PSTORE_LZ4HC_COMPRESS=y
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lz4hc"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
# CONFIG_PSTORE_RAM is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
# CONFIG_VBOXSF_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V2=m
CONFIG_NFS_V3=m
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
CONFIG_NFS_SWAP=y
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
CONFIG_NFS_V4_1_MIGRATION=y
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_NFS_FSCACHE=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
CONFIG_NFSD_BLOCKLAYOUT=y
CONFIG_NFSD_SCSILAYOUT=y
CONFIG_NFSD_FLEXFILELAYOUT=y
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=m
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_SUNRPC_SWAP=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=m
CONFIG_ENCRYPTED_KEYS=m
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_PATH is not set
# CONFIG_INTEL_TXT is not set
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
# CONFIG_INTEGRITY_TRUSTED_KEYRING is not set
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="yama,loadpin,safesetid,integrity"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
CONFIG_ASYNC_RAID6_RECOV=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_CURVE25519=y
CONFIG_CRYPTO_CURVE25519_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_BLAKE2S=y
CONFIG_CRYPTO_BLAKE2S_X86=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_STATS=y
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_BLAKE2S=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=y
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=m
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
# CONFIG_TPM_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=y
CONFIG_TEXTSEARCH_BM=y
CONFIG_TEXTSEARCH_FSM=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=y
CONFIG_DEBUG_INFO_BTF=y
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_EFI_PGT_DUMP is not set
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--phl2npw7hpcjbj6l--
