Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E1DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 09:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD4B20727
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 09:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRb/Zgw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbgEWJUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 05:20:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38210 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387678AbgEWJUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 05:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590225618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v2HqYWn32ojgMJUK1B5kab4+BInPalnUTf44nc+cAcI=;
        b=hRb/Zgw03NN0yr8PCFvxvCDd/1ZxxeI19/D5Ox4zXqOVXk1kFEMErECl499IFHx/oSvEc/
        JOa3sazty2t+DBxyT25+bANl4LsKdlhYY8jPpU/qe/F769rWz982TgJ429ZwEk5aQW96kk
        Dmdz4bYBib+ZfUQe0sggOFF8/3FIpyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-SHbqOi6NMxG2uVui6f3o2A-1; Sat, 23 May 2020 05:20:14 -0400
X-MC-Unique: SHbqOi6NMxG2uVui6f3o2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C6D3107ACCA;
        Sat, 23 May 2020 09:20:13 +0000 (UTC)
Received: from krava (unknown [10.40.192.99])
        by smtp.corp.redhat.com (Postfix) with SMTP id AC51E78B58;
        Sat, 23 May 2020 09:20:11 +0000 (UTC)
Date:   Sat, 23 May 2020 11:20:10 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        syzbot+bb4935a5c09b5ff79940@syzkaller.appspotmail.com,
        Barret Rhoden <brho@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Subject: Re: [tip: perf/core] perf: Add cond_resched() to task_function_call()
Message-ID: <20200523092010.GA78388@krava>
References: <20200414222920.121401-1-brho@google.com>
 <158835732594.8414.10249310108330671272.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158835732594.8414.10249310108330671272.tip-bot2@tip-bot2>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 06:22:05PM -0000, tip-bot2 for Barret Rhoden wrote:
> The following commit has been merged into the perf/core branch of tip:
> 
> Commit-ID:     2ed6edd33a214bca02bd2b45e3fc3038a059436b
> Gitweb:        https://git.kernel.org/tip/2ed6edd33a214bca02bd2b45e3fc3038a059436b
> Author:        Barret Rhoden <brho@google.com>
> AuthorDate:    Tue, 14 Apr 2020 18:29:20 -04:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Thu, 30 Apr 2020 20:14:36 +02:00
> 
> perf: Add cond_resched() to task_function_call()
> 
> Under rare circumstances, task_function_call() can repeatedly fail and
> cause a soft lockup.
> 
> There is a slight race where the process is no longer running on the cpu
> we targeted by the time remote_function() runs.  The code will simply
> try again.  If we are very unlucky, this will continue to fail, until a
> watchdog fires.  This can happen in a heavily loaded, multi-core virtual
> machine.
> 
> Reported-by: syzbot+bb4935a5c09b5ff79940@syzkaller.appspotmail.com
> Signed-off-by: Barret Rhoden <brho@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20200414222920.121401-1-brho@google.com

hi,
this gives me warning below and the machine gets stuck,
if I revert it seems to be ok, running this:

  # while :; do ./perf stat -e cycles ./perf bench sched messaging; done

jirka


---
[ 1782.995609] WARNING: CPU: 20 PID: 0 at kernel/smp.c:127 flush_smp_call_function_queue+0x86/0xf0
[ 1783.004301] Modules linked in: intel_rapl_msr intel_rapl_common skx_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10d
if_pclmul crc32_pclmul ipmi_ssif ghash_clmulni_intel intel_cstate dell_smbios intel_uncore dell_wmi_descriptor iTCO_wdt dcdbas mei_me wmi_bmof iTCO_vendor_supp
ort ipmi_si mei lpc_ich ipmi_devintf i2c_i801 wmi ipmi_msghandler acpi_power_meter xfs libcrc32c mgag200 drm_kms_helper cec drm_vram_helper drm_ttm_helper ttm 
drm tg3 megaraid_sas crc32c_intel i2c_algo_bit
[ 1783.049855] CPU: 20 PID: 0 Comm: swapper/20 Tainted: G          I       5.7.0-rc6+ #57
[ 1783.057763] Hardware name: Dell Inc. PowerEdge R440/08CYF7, BIOS 1.7.0 12/14/2018
[ 1783.065250] RIP: 0010:flush_smp_call_function_queue+0x86/0xf0
[ 1783.070991] Code: 00 00 48 85 ed 75 d3 48 83 c4 08 5b 5d 41 5c e9 80 06 07 00 a8 01 74 12 c7 43 18 00 00 00 00 e8 d0 24 c8 00 eb af 0f 0b eb d1 <0f> 0b eb e
a 65 8b 05 9f 3b e9 7e 89 c0 48 0f a3 05 c5 a8 7c 01 72
[ 1783.089736] RSP: 0018:ffffc900068b0dd0 EFLAGS: 00010046
[ 1783.094962] RAX: 0000000000000000 RBX: ffff888c10eaab80 RCX: 0000000000000007
[ 1783.102095] RDX: ffffffff81108ab0 RSI: 0000000000000000 RDI: ffff888c10eaab40
[ 1783.109225] RBP: ffff888c10eaab80 R08: 0000019f228b1c77 R09: 0000000000000000
[ 1783.116359] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[ 1783.123491] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 1783.130624] FS:  0000000000000000(0000) GS:ffff888c10e80000(0000) knlGS:0000000000000000
[ 1783.138711] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1783.144457] CR2: 00007fc8501b29f0 CR3: 0000000be6ac8001 CR4: 00000000007606e0
[ 1783.151589] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1783.158721] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1783.165854] PKRU: 55555554
[ 1783.168566] Call Trace:
[ 1783.171019]  <IRQ>
[ 1783.173041]  ? irqtime_account_irq+0x32/0xa0
[ 1783.177317]  smp_call_function_single_interrupt+0x3e/0xf0
[ 1783.182712]  call_function_single_interrupt+0xf/0x20
[ 1783.187678] RIP: 0010:_nohz_idle_balance+0x57/0x210
[ 1783.192556] Code: 60 ea 00 00 89 f0 83 e0 03 89 74 24 28 89 54 24 2c 83 f8 01 0f 84 9a 01 00 00 c7 05 4b 5f e9 01 00 00 00 00 f0 83 44 24 fc 00 <65> 48 8b 0
4 25 c0 8b 01 00 48 89 04 24 41 bf ff ff ff ff 45 31 ed
[ 1783.211303] RSP: 0018:ffffc900068b0ed0 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff04
[ 1783.218869] RAX: 0000000000000003 RBX: 00000001001780ff RCX: 0000000000000003
[ 1783.226000] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffff888c10eaab40
[ 1783.233131] RBP: 0000000000000014 R08: 0000000000000003 R09: 0000000000000100
[ 1783.240258] R10: 0000019ea6c791d9 R11: 0000000000000394 R12: ffffffff82805138
[ 1783.247390] R13: 0000000000000007 R14: 0000000000000007 R15: ffffffff82805110
[ 1783.254523]  ? call_function_single_interrupt+0xa/0x20
[ 1783.259667]  __do_softirq+0xee/0x313
[ 1783.263243]  ? clockevents_program_event+0x8d/0xf0
[ 1783.268036]  ? sched_clock+0x5/0x10
[ 1783.271531]  irq_exit+0xe6/0xf0
[ 1783.274675]  smp_apic_timer_interrupt+0x7a/0x150
[ 1783.279292]  apic_timer_interrupt+0xf/0x20
[ 1783.283391]  </IRQ>
[ 1783.285500] RIP: 0010:finish_task_switch+0x7b/0x290
[ 1783.290377] Code: 44 00 00 65 48 8b 1c 25 c0 8b 01 00 e9 89 00 00 00 0f 1f 44 00 00 41 c7 45 38 00 00 00 00 41 c6 04 24 00 fb 66 0f 1f 44 00 00 <65> 48 8b 0
4 25 c0 8b 01 00 0f 1f 44 00 00 4d 85 f6 74 21 65 48 8b
[ 1783.309122] RSP: 0018:ffffc9000649be28 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
[ 1783.316687] RAX: 0000000000000000 RBX: ffff888c0c602580 RCX: 0000000000000000
[ 1783.323820] RDX: 0000000000000000 RSI: ffff888c0c602580 RDI: ffff888be6c48000
[ 1783.330953] RBP: ffffc9000649be50 R08: ffff888c10ea7c00 R09: ffff888be8a1e800
[ 1783.338085] R10: 0000000000000000 R11: 000000000000000c R12: ffff888c10eaab40
[ 1783.345219] R13: ffff888be6c48000 R14: 0000000000000000 R15: 0000000000000001
[ 1783.352354]  ? finish_task_switch+0xf6/0x290
[ 1783.356624]  __schedule+0x2c8/0x750
[ 1783.360118]  ? recalibrate_cpu_khz+0x10/0x10
[ 1783.364389]  schedule_idle+0x28/0x40
[ 1783.367970]  do_idle+0x169/0x260
[ 1783.371201]  cpu_startup_entry+0x19/0x20
[ 1783.375128]  start_secondary+0x169/0x1c0
[ 1783.379058]  secondary_startup_64+0xa4/0xb0
[ 1783.383240] ---[ end trace 5ec3d41605e082c2 ]---
[ 1783.387861] ------------[ cut here ]------------
[ 1783.392481] WARNING: CPU: 20 PID: 0 at kernel/smp.c:127 flush_smp_call_function_queue+0x86/0xf0
[ 1783.401169] Modules linked in: intel_rapl_msr intel_rapl_common skx_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ipmi_ssif ghash_clmulni_intel intel_cstate dell_smbios intel_uncore dell_wmi_descriptor iTCO_wdt dcdbas mei_me wmi_bmof iTCO_vendor_support ipmi_si mei lpc_ich ipmi_devintf i2c_i801 wmi ipmi_msghandler acpi_power_meter xfs libcrc32c mgag200 drm_kms_helper cec drm_vram_helper drm_ttm_helper ttm drm tg3 megaraid_sas crc32c_intel i2c_algo_bit
[ 1783.446705] CPU: 20 PID: 0 Comm: swapper/20 Tainted: G        W I       5.7.0-rc6+ #57
[ 1783.454618] Hardware name: Dell Inc. PowerEdge R440/08CYF7, BIOS 1.7.0 12/14/2018
[ 1783.462098] RIP: 0010:flush_smp_call_function_queue+0x86/0xf0
[ 1783.467842] Code: 00 00 48 85 ed 75 d3 48 83 c4 08 5b 5d 41 5c e9 80 06 07 00 a8 01 74 12 c7 43 18 00 00 00 00 e8 d0 24 c8 00 eb af 0f 0b eb d1 <0f> 0b eb ea 65 8b 05 9f 3b e9 7e 89 c0 48 0f a3 05 c5 a8 7c 01 72
[ 1783.486587] RSP: 0018:ffffc900068b0dd0 EFLAGS: 00010046
[ 1783.491814] RAX: 0000000000000000 RBX: ffff888c10eaab80 RCX: ffff888c10e80000
[ 1783.498948] RDX: ffffffff81108ab0 RSI: 0000000000000001 RDI: ffff888c10eaab40
[ 1783.506079] RBP: ffff888c10eaab80 R08: 0000019f228b1c77 R09: 0000000000000000
[ 1783.513212] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
[ 1783.520346] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 1783.527477] FS:  0000000000000000(0000) GS:ffff888c10e80000(0000) knlGS:0000000000000000
[ 1783.535564] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1783.541308] CR2: 00007fc8501b29f0 CR3: 0000000be6ac8001 CR4: 00000000007606e0
[ 1783.548435] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1783.555566] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1783.562699] PKRU: 55555554
[ 1783.565411] Call Trace:
[ 1783.567863]  <IRQ>
[ 1783.569883]  ? irqtime_account_irq+0x32/0xa0
[ 1783.574157]  smp_call_function_single_interrupt+0x3e/0xf0
[ 1783.579556]  call_function_single_interrupt+0xf/0x20
[ 1783.584522] RIP: 0010:_nohz_idle_balance+0x57/0x210
[ 1783.589401] Code: 60 ea 00 00 89 f0 83 e0 03 89 74 24 28 89 54 24 2c 83 f8 01 0f 84 9a 01 00 00 c7 05 4b 5f e9 01 00 00 00 00 f0 83 44 24 fc 00 <65> 48 8b 04 25 c0 8b 01 00 48 89 04 24 41 bf ff ff ff ff 45 31 ed
[ 1783.608146] RSP: 0018:ffffc900068b0ed0 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff04
[ 1783.615713] RAX: 0000000000000003 RBX: 00000001001780ff RCX: 0000000000000003
[ 1783.622844] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffff888c10eaab40
[ 1783.629978] RBP: 0000000000000014 R08: 0000000000000003 R09: 0000000000000100
[ 1783.637111] R10: 0000019ea6c791d9 R11: 0000000000000394 R12: ffffffff82805138
[ 1783.644243] R13: 0000000000000007 R14: 0000000000000007 R15: ffffffff82805110
[ 1783.651378]  ? call_function_single_interrupt+0xa/0x20
[ 1783.656519]  __do_softirq+0xee/0x313
[ 1783.660094]  ? clockevents_program_event+0x8d/0xf0
[ 1783.664887]  ? sched_clock+0x5/0x10
[ 1783.668382]  irq_exit+0xe6/0xf0
[ 1783.671528]  smp_apic_timer_interrupt+0x7a/0x150
[ 1783.676146]  apic_timer_interrupt+0xf/0x20
[ 1783.680243]  </IRQ>
[ 1783.682351] RIP: 0010:finish_task_switch+0x7b/0x290
[ 1783.687231] Code: 44 00 00 65 48 8b 1c 25 c0 8b 01 00 e9 89 00 00 00 0f 1f 44 00 00 41 c7 45 38 00 00 00 00 41 c6 04 24 00 fb 66 0f 1f 44 00 00 <65> 48 8b 04 25 c0 8b 01 00 0f 1f 44 00 00 4d 85 f6 74 21 65 48 8b
[ 1783.705974] RSP: 0018:ffffc9000649be28 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
[ 1783.713542] RAX: 0000000000000000 RBX: ffff888c0c602580 RCX: 0000000000000000
[ 1783.720673] RDX: 0000000000000000 RSI: ffff888c0c602580 RDI: ffff888be6c48000
[ 1783.727807] RBP: ffffc9000649be50 R08: ffff888c10ea7c00 R09: ffff888be8a1e800
[ 1783.734938] R10: 0000000000000000 R11: 000000000000000c R12: ffff888c10eaab40
[ 1783.742070] R13: ffff888be6c48000 R14: 0000000000000000 R15: 0000000000000001
[ 1783.749199]  ? finish_task_switch+0xf6/0x290
[ 1783.753469]  __schedule+0x2c8/0x750
[ 1783.756961]  ? recalibrate_cpu_khz+0x10/0x10
[ 1783.761234]  schedule_idle+0x28/0x40
[ 1783.764814]  do_idle+0x169/0x260
[ 1783.768047]  cpu_startup_entry+0x19/0x20
[ 1783.771973]  start_secondary+0x169/0x1c0
[ 1783.775897]  secondary_startup_64+0xa4/0xb0
[ 1783.780085] ---[ end trace 5ec3d41605e082c3 ]---
[ 1783.784704] ------------[ cut here ]------------
[ 1783.789323] WARNING: CPU: 20 PID: 0 at kernel/smp.c:127 flush_smp_call_function_queue+0x86/0xf0
[ 1783.798015] Modules linked in: intel_rapl_msr intel_rapl_common skx_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ipmi_ssif ghash_clmulni_intel intel_cstate dell_smbios intel_uncore dell_wmi_descriptor iTCO_wdt dcdbas mei_me wmi_bmof iTCO_vendor_support ipmi_si mei lpc_ich ipmi_devintf i2c_i801 wmi ipmi_msghandler acpi_power_meter xfs libcrc32c mgag200 drm_kms_helper cec drm_vram_helper drm_ttm_helper ttm drm tg3 megaraid_sas crc32c_intel i2c_algo_bit
[ 1783.843543] CPU: 20 PID: 0 Comm: swapper/20 Tainted: G        W I       5.7.0-rc6+ #57
[ 1783.851452] Hardware name: Dell Inc. PowerEdge R440/08CYF7, BIOS 1.7.0 12/14/2018
[ 1783.858933] RIP: 0010:flush_smp_call_function_queue+0x86/0xf0
[ 1783.864680] Code: 00 00 48 85 ed 75 d3 48 83 c4 08 5b 5d 41 5c e9 80 06 07 00 a8 01 74 12 c7 43 18 00 00 00 00 e8 d0 24 c8 00 eb af 0f 0b eb d1 <0f> 0b eb ea 65 8b 05 9f 3b e9 7e 89 c0 48 0f a3 05 c5 a8 7c 01 72
[ 1783.883425] RSP: 0018:ffffc900068b0dd0 EFLAGS: 00010046
...

