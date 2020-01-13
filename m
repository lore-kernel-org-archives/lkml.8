Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07E7C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 01:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9449121744
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 01:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZMBoBpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732930AbgAMB6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 20:58:00 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52866 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgAMB6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 20:58:00 -0500
Received: by mail-pj1-f67.google.com with SMTP id a6so3472404pjh.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 17:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fsSYVvDn0gP0P9g4UK5TLs4bJ/PjeNAVwcza35uYJHY=;
        b=DZMBoBpcuaOslafbsKaEKNLAJ9c+sNtIyIJKdDJSDmWNP/CGEWREqW8umsZbsSWnUg
         TjD+xR1xebaWbfwD2xRQKLYMw45rg1CWTWgvYVxQJv/rzsgGuugUwNvWW1VijhntC7MM
         wxwGcXYNU/kLqifxeDmgvDrhvQFGjZ0HZO4O6tGTVX5VpRrAargSHW0yd+hoLgVb2z8d
         udUrBf0cI02OQuu9WvO3fhWYhfAadhVTasAN63kFQfmV9MmKjaNNfFYpLRTvN0EPoKvt
         670a+Z5XbNg9DpOSYyVCXqGaH+qlQ9YN6xpUU33zgV74QngWC/mXExtLbkjBVq18J0rc
         h83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fsSYVvDn0gP0P9g4UK5TLs4bJ/PjeNAVwcza35uYJHY=;
        b=dSEJm/vMFNAL3zg3aEu38Haj+JEeyhbQbUWac1TVuv+8kFbn10L8F0k2LCm2dBO2nM
         KIRQphhLLy92tsb8Wl/s1ra97kgXw6n65SiRENCsnFRFHPobc1SYhrScGkG48Q/zF3fm
         W+UdnqfoHP/f8hyqe9PKqOq/4s3ejdGb0cH/VG3u3fKNHnVPWnURiGyosGYwNpnDSMNR
         CnS4pMSzgPmLunZZA4NRX8A6B0NTnh6eiqSepJvswnXGFVMmDooUSeBRq1Kv0ehkdRrv
         /Lnyqq4UK3XZm01QDXKIZbjfJcGcnq7cgMHQJkUZLLCBLCLz2dbF+R5niYnIWAxkkFrU
         /7pA==
X-Gm-Message-State: APjAAAXK8fhqbHvyMywudu21QcX5N+i0kXBJcWw56lRgjPIYGaUIuXzu
        LLQpe4XgFXbA/W9RW6/8oiljvg==
X-Google-Smtp-Source: APXvYqy9qjUgqX7CI05LKngKzBIxnEJBHdeNPjUKh4oRCGRfX83OIkTU/8pnPZC/c7LyVuZvU9M4yQ==
X-Received: by 2002:a17:90a:1ae9:: with SMTP id p96mr20079623pjp.8.1578880679100;
        Sun, 12 Jan 2020 17:57:59 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id n1sm11849722pfd.47.2020.01.12.17.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 17:57:58 -0800 (PST)
Date:   Sun, 12 Jan 2020 17:57:57 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Holger Kiehl <Holger.Kiehl@dwd.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Dave Airlie <airlied@redhat.com>
cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Lockup with kernel 5.5.0-rc5
In-Reply-To: <alpine.LRH.2.21.2001122012080.11995@diagnostix.dwd.de>
Message-ID: <alpine.DEB.2.21.2001121750260.11981@chino.kir.corp.google.com>
References: <alpine.LRH.2.21.2001122012080.11995@diagnostix.dwd.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2020, Holger Kiehl wrote:

> Hello,
> 
> on a Broadwell CPU Xeon E3-1285L (with L4-Cache 128MB eDRAM) I got
> the following Oops:
> 
> [ 7759.828500] general protection fault: 0000 [#1] SMP PTI
> [ 7759.828506] CPU: 1 PID: 2114 Comm: Xorg Not tainted 5.5.0-rc5 #1
> [ 7759.828508] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./C226M WS, BIOS L2.32 05/16/2019
> [ 7759.828515] RIP: 0010:kmem_cache_alloc+0x7a/0x210
> [ 7759.828518] Code: 65 48 8b 51 08 65 48 03 0d f3 6a d8 7c 4c 8b 21 4d 85 e4 0f 84 7c 01 00 00 41 8b 5e 20 48 8d 4a 01 4c 89 e0 49 8b 3e 4c 01 e3 <48> 33 1b 49 33 9e 70 01 00 00 65 48 0f c7 0f 0f 94 c0 84 c0 74 bd
> [ 7759.828520] RSP: 0018:ffffa72744a2ba28 EFLAGS: 00010206
> [ 7759.828522] RAX: 0b1b4d50ef46eaf3 RBX: 0b1b4d50ef46eaf3 RCX: 000000000001b5a9
> [ 7759.828524] RDX: 000000000001b5a8 RSI: 0000000000000cc0 RDI: 000000000002ff20
> [ 7759.828525] RBP: 0000000000000cc0 R08: 0000000000000000 R09: ffff9be2339e3c80
> [ 7759.828527] R10: 000000000000a000 R11: ffff9be3872118e8 R12: 0b1b4d50ef46eaf3
> [ 7759.828529] R13: ffffffffc039ddce R14: ffff9be38b823640 R15: ffff9be38b823640
> [ 7759.828531] FS:  00007fa28d224f00(0000) GS:ffff9be38ec40000(0000) knlGS:0000000000000000
> [ 7759.828533] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 7759.828534] CR2: 00007fa28818b000 CR3: 00000007df1d8005 CR4: 00000000003606e0
> [ 7759.828536] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 7759.828537] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 7759.828539] Call Trace:
> [ 7759.828577]  i915_active_ref+0x5e/0x170 [i915]
> [ 7759.828609]  i915_vma_move_to_active+0x24/0x150 [i915]
> [ 7759.828636]  i915_gem_do_execbuffer+0xd3f/0x1880 [i915]
> [ 7759.828644]  ? unix_stream_read_generic+0x1fe/0x990
> [ 7759.828647]  ? xas_load+0x5/0x70
> [ 7759.828651]  ? find_get_entry+0xb3/0x170
> [ 7759.828657]  ? shmem_getpage_gfp+0xf1/0x8f0
> [ 7759.828661]  ? __kmalloc+0x174/0x260
> [ 7759.828688]  i915_gem_execbuffer2_ioctl+0xee/0x3b0 [i915]
> [ 7759.828718]  ? i915_gem_madvise_ioctl+0x10f/0x2c0 [i915]
> [ 7759.828744]  ? i915_gem_execbuffer_ioctl+0x2c0/0x2c0 [i915]
> [ 7759.828748]  drm_ioctl_kernel+0xab/0xf0
> [ 7759.828753]  drm_ioctl+0x200/0x3a0
> [ 7759.828793]  ? i915_gem_execbuffer_ioctl+0x2c0/0x2c0 [i915]
> [ 7759.828801]  do_vfs_ioctl+0x447/0x6c0
> [ 7759.828807]  ? handle_mm_fault+0xae/0x1e0
> [ 7759.828812]  ksys_ioctl+0x5e/0x90
> [ 7759.828817]  __x64_sys_ioctl+0x16/0x20
> [ 7759.828821]  do_syscall_64+0x55/0x1a0
> [ 7759.828826]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 7759.828831] RIP: 0033:0x7fa28d69b34b
> [ 7759.828835] Code: 0f 1e fa 48 8b 05 3d 9b 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0d 9b 0c 00 f7 d8 64 89 01 48
> [ 7759.828838] RSP: 002b:00007ffc1ae65108 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [ 7759.828842] RAX: ffffffffffffffda RBX: 00007ffc1ae65150 RCX: 00007fa28d69b34b
> [ 7759.828845] RDX: 00007ffc1ae65150 RSI: 0000000040406469 RDI: 0000000000000010
> [ 7759.828848] RBP: 0000000040406469 R08: 00005557e3a829a0 R09: 0000000000000000
> [ 7759.828850] R10: 0000000000000000 R11: 0000000000000246 R12: 00005557e3a40100
> [ 7759.828853] R13: 0000000000000010 R14: ffffffffffffffff R15: 00007fa28cb34a68
> [ 7759.828858] Modules linked in: xt_CHECKSUM xt_MASQUERADE nf_nat_tftp nf_conntrack_tftp tun bridge stp llc nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT ip6t_REJECT nf_reject_ipv6 ip6t_rpfilter xt_conntrack ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set nfnetlink ebtable_filter ebtables x86_pkg_temp_thermal ip6table_filter kvm_intel ip6_tables kvm irqbypass bpfilter iTCO_wdt iTCO_vendor_support snd_hda_codec_realtek crct10dif_pclmul snd_hda_codec_generic snd_hda_codec_hdmi crc32_pclmul snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core nct6775 hwmon_vid ghash_clmulni_intel i2c_i801 snd_seq jc42 lpc_ich bfq mfd_core coretemp snd_seq_device snd_pcm snd_timer snd mei_me mei soundcore acpi_pad sunrpc vfat fat sch_fq_codel i915 crc32c_intel igb dca video fuse ecryptfs
> [ 7759.828934] ---[ end trace f5069fc029a440f1 ]---
> [ 7759.929159] RIP: 0010:kmem_cache_alloc+0x7a/0x210
> [ 7759.929162] Code: 65 48 8b 51 08 65 48 03 0d f3 6a d8 7c 4c 8b 21 4d 85 e4 0f 84 7c 01 00 00 41 8b 5e 20 48 8d 4a 01 4c 89 e0 49 8b 3e 4c 01 e3 <48> 33 1b 49 33 9e 70 01 00 00 65 48 0f c7 0f 0f 94 c0 84 c0 74 bd
> [ 7759.929163] RSP: 0018:ffffa72744a2ba28 EFLAGS: 00010206
> [ 7759.929165] RAX: 0b1b4d50ef46eaf3 RBX: 0b1b4d50ef46eaf3 RCX: 000000000001b5a9
> [ 7759.929166] RDX: 000000000001b5a8 RSI: 0000000000000cc0 RDI: 000000000002ff20
> [ 7759.929167] RBP: 0000000000000cc0 R08: 0000000000000000 R09: ffff9be2339e3c80
> [ 7759.929168] R10: 000000000000a000 R11: ffff9be3872118e8 R12: 0b1b4d50ef46eaf3
> [ 7759.929169] R13: ffffffffc039ddce R14: ffff9be38b823640 R15: ffff9be38b823640
> [ 7759.929171] FS:  00007fa28d224f00(0000) GS:ffff9be38ec40000(0000) knlGS:0000000000000000
> [ 7759.929172] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 7759.929173] CR2: 00007fa28818b000 CR3: 00000007df1d8005 CR4: 00000000003606e0
> [ 7759.929174] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 7759.929175] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 

This must be the kmem_cache_alloc(global.slab_cache) in active_instance().  
Adding Chris and Dave.

> It cannot be reproduced, but it has happened now the second time with
> a 5.5.0-rc kernel. Before this system was stable if one does not enable
> C6 power saving. It is limited to C3.
> 
> Regards,
> Holger
> 
