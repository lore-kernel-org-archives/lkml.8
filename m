Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB839C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDC120719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiNWTQ9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgCZX4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:56:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54297 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCZX4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:56:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id c81so9692853wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 16:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=gAEr5jp2XEj7VVG3HdFY5SCH2utiDXPEK5tBvBMTU7k=;
        b=FiNWTQ9YItu+elqTtRpQQWir9JgQ+DTVA5NvlhVY3EJXbdVAuLbop4pt0P8Urq98Fq
         JQbczruHkvbdY1DUcSZZHJsL9MiNUzkyTQONPlZ4Rx86JrUk4Hcaqy1HttTOx2S1VPWR
         vItBUypGihPgL0woaheD7LlWbm6YJZBL1rruct8F3jrVZXEZsZzk1+Sz+3WybMNYhgfM
         dWpiRhUALgVbLtoAIM3JghABbG1AAs3HuMeY0YG1m7pyKOhnx9xDx2hR2BYJ19MG3ajZ
         gY+nL6lWVVrnXTZNb2UPnT4EUbPyg9sNigUiK3QhCSIAL3X9zkxFAaChVa+YQsWRAxyM
         a9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=gAEr5jp2XEj7VVG3HdFY5SCH2utiDXPEK5tBvBMTU7k=;
        b=j0olUc7umTJuuH30ApJUbJ9cQdDn/hP7zJ4AwQ+kSZmWp6k/PY2/juMieHOG7Oo/jd
         LxumFBmnhL9HF8doYHfj/3WVfY4K1S8G9XDIaQLw+ww4Esi7CzaAWiXaTMxEJ+pt3qek
         mPYjZwXZQao/IVXjffiSnMbUEcO5GVsNCOIsrLNk3pYU8kBg5MAjBaO86S7U4ZPurWBI
         q/3+Cf3qXJ2n1cPxBnMbV7PH7cidCf9OjLuSuQC5UGUktavZQZLI6ej2GwfvH68isI0o
         xWl/fS4mHn+hUV8Qt2A860Tpc9ZwIWvLHoi3OeYFZEKN/GAoLL0ugDaUeAafw9xIAmo1
         9FfA==
X-Gm-Message-State: ANhLgQ0bFNTz9RquPGSDOkLP6xe9k62f1XvppQf9UkkonL+C3FwCAisU
        uBfp4ms7YU9lgAphTpyGNvnj5gBz
X-Google-Smtp-Source: ADFU+vuthp4JtJwgFKaB9PfsFJgru1LE7g4aWnDrxTBRsTZ9Cijwhz/qr1e0E3KSjdKUTH/IjGP+7A==
X-Received: by 2002:a1c:5544:: with SMTP id j65mr2462534wmb.60.1585267002172;
        Thu, 26 Mar 2020 16:56:42 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f29:6000:d031:3b7b:1a72:8f94? (p200300EA8F296000D0313B7B1A728F94.dip0.t-ipconnect.de. [2003:ea:8f29:6000:d031:3b7b:1a72:8f94])
        by smtp.googlemail.com with ESMTPSA id t10sm5790867wrx.38.2020.03.26.16.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 16:56:41 -0700 (PDT)
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: BUG: sleeping function called from invalid context at
 include/linux/percpu-rwsem.h:49
Message-ID: <13ef34ef-edf7-67d3-693b-0d18b68ddd70@gmail.com>
Date:   Fri, 27 Mar 2020 00:56:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just got the following on linux-next from March 25th. You dealt last with
include/linux/percpu-rwsem.h, so you may have an idea where to look for the
root cause.


Mar 26 23:29:51 zotac kernel: BUG: kernel NULL pointer dereference, address: 0000000000000000
Mar 26 23:29:51 zotac kernel: #PF: supervisor read access in kernel mode
Mar 26 23:29:51 zotac kernel: #PF: error_code(0x0000) - not-present page
Mar 26 23:29:51 zotac kernel: PGD 0 P4D 0
Mar 26 23:29:51 zotac kernel: Oops: 0000 [#1] SMP
Mar 26 23:29:51 zotac kernel: CPU: 2 PID: 2404 Comm: resolvconf Not tainted 5.6.0-rc7-next-20200325+ #1
Mar 26 23:29:51 zotac kernel: Hardware name: NA ZBOX-CI327NANO-GS-01/ZBOX-CI327NANO-GS-01, BIOS 5.12 04/26/2018
Mar 26 23:29:51 zotac kernel: RIP: 0010:link_path_walk.part.0+0x1c5/0x350
Mar 26 23:29:51 zotac kernel: Code: 41 83 ef 01 31 f6 4c 89 f7 49 63 c7 48 8d 04 40 48 c1 e0 04 49 03 46 58 4c 8b 68 20 e8 84 fc ff ff 48 85 c0 75 5f 49 8b 46 08 <8b> 00 25 00 00 70 00 3d 00 00 20 00 0f 84 a5 fe ff ff 41 f6 46 38
Mar 26 23:29:51 zotac kernel: RSP: 0018:ffffb272403c7ba8 EFLAGS: 00010246
Mar 26 23:29:51 zotac kernel: RAX: 0000000000000000 RBX: fefefefefefefeff RCX: 0000000000000000
Mar 26 23:29:51 zotac kernel: RDX: ffff9f21bab88000 RSI: ffffffffbea46aa0 RDI: ffff9f21bab88858
Mar 26 23:29:51 zotac kernel: RBP: ffffb272403c7bf0 R08: 0000000000000001 R09: 0000000000000000
Mar 26 23:29:51 zotac kernel: R10: 80800000007fffff R11: 0000000000000000 R12: 2f2f2f2f2f2f2f2f
Mar 26 23:29:51 zotac kernel: R13: ffff9f21b9476243 R14: ffffb272403c7c30 R15: 0000000000000001
Mar 26 23:29:51 zotac kernel: FS:  00007f464ebc8b80(0000) GS:ffff9f21bbd00000(0000) knlGS:0000000000000000
Mar 26 23:29:51 zotac kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 26 23:29:51 zotac kernel: CR2: 0000000000000000 CR3: 0000000178b7d000 CR4: 00000000003406e0
Mar 26 23:29:51 zotac kernel: Call Trace:
Mar 26 23:29:51 zotac kernel:  path_lookupat.isra.0+0x3b/0x150
Mar 26 23:29:51 zotac kernel:  filename_lookup+0xb4/0x140
Mar 26 23:29:51 zotac kernel:  ? rcu_read_lock_sched_held+0x4a/0x80
Mar 26 23:29:51 zotac kernel:  ? kmem_cache_alloc+0x24c/0x280
Mar 26 23:29:51 zotac kernel:  kern_path+0x31/0x40
Mar 26 23:29:51 zotac kernel:  unix_find_other+0x4f/0x2b0
Mar 26 23:29:51 zotac kernel:  unix_stream_connect+0x115/0x6c4
Mar 26 23:29:51 zotac kernel:  __sys_connect+0xec/0x110
Mar 26 23:29:51 zotac kernel:  ? lockdep_hardirqs_on+0xf2/0x1a0
Mar 26 23:29:51 zotac kernel:  __x64_sys_connect+0x19/0x20
Mar 26 23:29:51 zotac kernel:  do_syscall_64+0x50/0x1e0
Mar 26 23:29:51 zotac kernel:  entry_SYSCALL_64_after_hwframe+0x49/0xb3
Mar 26 23:29:51 zotac kernel: RIP: 0033:0x7f464ed3b447
Mar 26 23:29:51 zotac kernel: Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 18 89 54 24 0c 48 89 34 24 89
Mar 26 23:29:51 zotac kernel: RSP: 002b:00007ffd3daa5d88 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
Mar 26 23:29:51 zotac kernel: RAX: ffffffffffffffda RBX: 00007ffd3daa5d90 RCX: 00007f464ed3b447
Mar 26 23:29:51 zotac kernel: RDX: 000000000000006e RSI: 00007ffd3daa5de0 RDI: 0000000000000003
Mar 26 23:29:51 zotac kernel: RBP: 00007ffd3daa5e90 R08: 0000563ef84d0370 R09: 0000000000000400
Mar 26 23:29:51 zotac kernel: R10: 0000000000000410 R11: 0000000000000246 R12: 0000000000000013
Mar 26 23:29:51 zotac kernel: R13: 00007f464edc92a8 R14: 0000000000000003 R15: 0000000000000007
Mar 26 23:29:51 zotac kernel: Modules linked in: snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic vfat fat x86_pkg_temp_thermal coretemp aesni_intel glue_helper crypto_simd cryptd snd_hda_intel i915 snd_intel_dspcfg snd_hda_code>
Mar 26 23:29:51 zotac kernel: CR2: 0000000000000000
Mar 26 23:29:51 zotac kernel: ---[ end trace 5cf9f2658df059d3 ]---
Mar 26 23:29:51 zotac kernel: RIP: 0010:link_path_walk.part.0+0x1c5/0x350
Mar 26 23:29:51 zotac kernel: Code: 41 83 ef 01 31 f6 4c 89 f7 49 63 c7 48 8d 04 40 48 c1 e0 04 49 03 46 58 4c 8b 68 20 e8 84 fc ff ff 48 85 c0 75 5f 49 8b 46 08 <8b> 00 25 00 00 70 00 3d 00 00 20 00 0f 84 a5 fe ff ff 41 f6 46 38
Mar 26 23:29:51 zotac kernel: RSP: 0018:ffffb272403c7ba8 EFLAGS: 00010246
Mar 26 23:29:51 zotac kernel: RAX: 0000000000000000 RBX: fefefefefefefeff RCX: 0000000000000000
Mar 26 23:29:51 zotac kernel: RDX: ffff9f21bab88000 RSI: ffffffffbea46aa0 RDI: ffff9f21bab88858
Mar 26 23:29:51 zotac kernel: RBP: ffffb272403c7bf0 R08: 0000000000000001 R09: 0000000000000000
Mar 26 23:29:51 zotac kernel: R10: 80800000007fffff R11: 0000000000000000 R12: 2f2f2f2f2f2f2f2f
Mar 26 23:29:51 zotac kernel: R13: ffff9f21b9476243 R14: ffffb272403c7c30 R15: 0000000000000001
Mar 26 23:29:51 zotac kernel: FS:  00007f464ebc8b80(0000) GS:ffff9f21bbd00000(0000) knlGS:0000000000000000
Mar 26 23:29:51 zotac kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 26 23:29:51 zotac kernel: CR2: 0000000000000000 CR3: 0000000178b7d000 CR4: 00000000003406e0
Mar 26 23:29:51 zotac kernel: BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
Mar 26 23:29:51 zotac kernel: in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 2404, name: resolvconf
Mar 26 23:29:51 zotac kernel: INFO: lockdep is turned off.
Mar 26 23:29:51 zotac kernel: irq event stamp: 2606
Mar 26 23:29:51 zotac kernel: hardirqs last  enabled at (2605): [<ffffffffbdc52a5d>] handle_dots.part.0+0x1ad/0x5f0
Mar 26 23:29:51 zotac kernel: hardirqs last disabled at (2606): [<ffffffffbda01e5d>] trace_hardirqs_off_thunk+0x1a/0x1c
Mar 26 23:29:51 zotac kernel: softirqs last  enabled at (2598): [<ffffffffbe0c8c9b>] unix_create1+0x6b/0x210
Mar 26 23:29:51 zotac kernel: softirqs last disabled at (2596): [<ffffffffbe0c8c9b>] unix_create1+0x6b/0x210
Mar 26 23:29:51 zotac kernel: CPU: 2 PID: 2404 Comm: resolvconf Tainted: G      D           5.6.0-rc7-next-20200325+ #1
Mar 26 23:29:51 zotac kernel: Hardware name: NA ZBOX-CI327NANO-GS-01/ZBOX-CI327NANO-GS-01, BIOS 5.12 04/26/2018
Mar 26 23:29:51 zotac kernel: Call Trace:
Mar 26 23:29:51 zotac kernel:  dump_stack+0x7a/0xb0
Mar 26 23:29:51 zotac kernel:  ___might_sleep.cold+0xa6/0xb7
Mar 26 23:29:51 zotac kernel:  __might_sleep+0x46/0x80
Mar 26 23:29:51 zotac kernel:  exit_signals+0x2f/0x300
Mar 26 23:29:51 zotac kernel:  do_exit+0xa4/0xb00
Mar 26 23:29:51 zotac kernel:  rewind_stack_do_exit+0x17/0x20
Mar 26 23:29:51 zotac kernel: RIP: 0033:0x7f464ed3b447
Mar 26 23:29:51 zotac kernel: Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 18 89 54 24 0c 48 89 34 24 89
Mar 26 23:29:51 zotac kernel: RSP: 002b:00007ffd3daa5d88 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
Mar 26 23:29:51 zotac kernel: RAX: ffffffffffffffda RBX: 00007ffd3daa5d90 RCX: 00007f464ed3b447
Mar 26 23:29:51 zotac kernel: RDX: 000000000000006e RSI: 00007ffd3daa5de0 RDI: 0000000000000003
Mar 26 23:29:51 zotac kernel: RBP: 00007ffd3daa5e90 R08: 0000563ef84d0370 R09: 0000000000000400
Mar 26 23:29:51 zotac kernel: R10: 0000000000000410 R11: 0000000000000246 R12: 0000000000000013
Mar 26 23:29:51 zotac kernel: R13: 00007f464edc92a8 R14: 0000000000000003 R15: 0000000000000007
