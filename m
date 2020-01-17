Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A49C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084412073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cU8IVfRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgAQP1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:27:55 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46025 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgAQP1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:27:54 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so26354004ioi.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 07:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XVdygMIHFAaiFSG8d/3CQxdGHHwWnUxhJO9uamYI81Q=;
        b=cU8IVfRwTPSl7jU6/z35Xrc9hralL3AMFW46G5ghfvhfUH0P7lNpX8+nagq59TI1d4
         hXvvb1Iz1YVcA1JvOcLm8rHPK6N6GHb09dQYlGirw37hhH4qEQN7RH46KC/0iW52EwSc
         5WhHl36ElTauojLw/xUXWJPbQz5zlIqEUIwCy0gs3zKDdEtniT7LTXh3dvbEP92f8hzN
         /ec5pMLLezb6Qnq8IsQeD0NNujZvyVz7EY+jXSGecfHDfF6OxI1DdnGiDm6yLfaoCKvW
         ae5S+K9OT1wEujoJUYLFwdb1/XQ2YKjmG+RGZJMxx0gvTKieHJNQ7xip75/HeKYB5Ava
         JlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XVdygMIHFAaiFSG8d/3CQxdGHHwWnUxhJO9uamYI81Q=;
        b=V1GlIBSRlk57TmxZDcc82Fmv04acl+qqvv8qwH/YNfshHrO4gAsUid5u2UA9xm+EJ7
         Z/4mUTIYt+dFgddhyeXiWTpHfOHBFPaJSj9hiukWZoAMcoW5CknWcOWyblf2OY8bKRNR
         23nuXS4gsgxl1HhsRTCQyyyDv95ANHnVa9mas3GLXtwAFpWs5uxC9cqXHdU2a5bQizpZ
         ACcjnVn4s9gp+U35h6FqtIysd9SEKCb6nOYcfCE0xz6gdozskcp8s0D3ETOQ+FxzFNNb
         1ACIOKuFnX+btM4naPVfYQjv4rZK1I1r7ppcgZOTyCu7IcVr7J8eANrN6fXWgB5Y9nlQ
         VK2Q==
X-Gm-Message-State: APjAAAUGDWga978rggzFU+z7qCYjGv7ADWjVhwz5U0TIGX/8JD+wIK5H
        LoQiOpx5uoM1uUjUxqIZBJ1JsQ==
X-Google-Smtp-Source: APXvYqzTBvrLXxbBehuVQYjfou/CIQQCXp/CiR7KNxYH/5Et28IXmRqQA5SjbcVC7m8YaWyv0a1ytQ==
X-Received: by 2002:a6b:8f11:: with SMTP id r17mr31937859iod.50.1579274873746;
        Fri, 17 Jan 2020 07:27:53 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i11sm5818687ion.1.2020.01.17.07.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 07:27:53 -0800 (PST)
Subject: Re: [blk] fdb4635422: WARNING:at_kernel/sched/core.c:#__might_sleep
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
        lkp@lists.01.org
References: <20200117094502.GA12406@shao2-debian>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <54c999dd-dab1-632c-8477-30d1ca62d0df@kernel.dk>
Date:   Fri, 17 Jan 2020 08:27:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200117094502.GA12406@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/20 2:45 AM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: fdb4635422b2d888fa9427c48308a3b74edd7e33 ("blk-mq: allocate tags in batches")
> https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-5.6/block-test
> 
> in testcase: xfstests
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: xfs
> 	test: xfs-group12
> 
> test-description: xfstests is a regression test suite for xfs and other files ystems.
> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +-----------------------------------------------+------------+------------+
> |                                               | bb2d58c57d | fdb4635422 |
> +-----------------------------------------------+------------+------------+
> | boot_successes                                | 4          | 3          |
> | boot_failures                                 | 0          | 12         |
> | WARNING:at_kernel/sched/core.c:#__might_sleep | 0          | 12         |
> | RIP:__might_sleep                             | 0          | 12         |
> +-----------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> [   36.455650] WARNING: CPU: 1 PID: 30 at kernel/sched/core.c:6751 __might_sleep+0x71/0x80
> [   36.458249] Modules linked in: xfs libcrc32c dm_mod bochs_drm drm_vram_helper sr_mod drm_ttm_helper cdrom sg ttm ata_generic intel_rapl_msr intel_rapl_common pata_acpi snd_pcm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel snd_timer ppdev drm aesni_intel snd crypto_simd cryptd glue_helper soundcore joydev pcspkr ata_piix serio_raw libata i2c_piix4 floppy parport_pc parport ip_tables
> [   36.471885] CPU: 1 PID: 30 Comm: kworker/u4:1 Not tainted 5.5.0-rc2-00198-gfdb4635422b2d #4
> [   36.479095] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   36.481801] Workqueue: writeback wb_workfn (flush-253:48)
> [   36.483922] RIP: 0010:__might_sleep+0x71/0x80
> [   36.486024] Code: 5c 41 5d 5d e9 90 fe ff ff 48 8b 90 00 22 00 00 48 8b 70 10 48 c7 c7 28 06 73 85 c6 05 78 03 73 01 01 48 89 d1 e8 cf 0b fd ff <0f> 0b eb c7 66 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90 8b 05
> [   36.491504] RSP: 0018:ffffa0e240107908 EFLAGS: 00010282
> [   36.493610] RAX: 0000000000000000 RBX: ffffffff8572bc98 RCX: 0000000000000000
> [   36.496099] RDX: 0000000000000001 RSI: ffff8d183fd19b38 RDI: ffff8d183fd19b38
> [   36.498446] RBP: ffffa0e240107920 R08: 00000000000003dc R09: 0000000000aaaaaa
> [   36.500886] R10: ffffa0e240107af0 R11: ffff8d1817ddf290 R12: 0000000000000026
> [   36.503176] R13: 0000000000000000 R14: ffff8d17e0692e00 R15: ffff8d17be0586c8
> [   36.505602] FS:  0000000000000000(0000) GS:ffff8d183fd00000(0000) knlGS:0000000000000000
> [   36.507179] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   36.508428] CR2: 00007efd8bad9000 CR3: 00000001d269a000 CR4: 00000000000406e0
> [   36.509863] Call Trace:
> [   36.510870]  ? blk_mq_tag_ctx_flush_batch+0x70/0x70
> [   36.512105]  cpus_read_lock+0x18/0x50
> [   36.513173]  blk_mq_tag_flush_batches+0x42/0x80
> [   36.514317]  blk_mq_get_tag+0x221/0x310
> [   36.515404]  ? finish_wait+0x80/0x80
> [   36.516497]  blk_mq_get_request+0xd3/0x370
> [   36.517640]  blk_mq_make_request+0x10f/0x600
> [   36.518742]  generic_make_request+0x121/0x310
> [   36.519843]  ? submit_bio+0x3c/0x160
> [   36.520932]  submit_bio+0x3c/0x160
> [   36.522009]  iomap_submit_ioend+0x48/0x70
> [   36.523307]  xfs_vm_writepages+0x6b/0x90 [xfs]
> [   36.524429]  do_writepages+0x4b/0xf0
> [   36.525446]  ? __blk_mq_run_hw_queue+0x60/0x130
> [   36.526646]  ? reschedule_interrupt+0xa/0x20
> [   36.527743]  ? __writeback_single_inode+0x3d/0x370
> [   36.528861]  __writeback_single_inode+0x3d/0x370
> [   36.529979]  writeback_sb_inodes+0x1f5/0x4d0
> [   36.531075]  wb_writeback+0xfe/0x330
> [   36.532114]  ? wb_workfn+0xdf/0x430
> [   36.533117]  wb_workfn+0xdf/0x430
> [   36.534120]  process_one_work+0x1ae/0x3d0
> [   36.535180]  worker_thread+0x3c/0x3b0
> [   36.536242]  ? process_one_work+0x3d0/0x3d0
> [   36.537354]  kthread+0x11e/0x140
> [   36.538332]  ? kthread_park+0x90/0x90
> [   36.539319]  ret_from_fork+0x35/0x40
> [   36.540289] ---[ end trace aa7b87584ce25e83 ]---
> 

Thanks, we need to flush the batch a bit sooner, before changing the
runstate of the task. I folded in the fix.

-- 
Jens Axboe

