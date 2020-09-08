Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD69C2D0A7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34CE1208FE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731922AbgIHUPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:15:16 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:36344 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729741AbgIHPKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:10:42 -0400
Subject: Re: gcc crashes with general protection faults in
 5.9.0-rc3-00091-ge28f0104343d
From:   Meelis Roos <mroos@linux.ee>
To:     LKML <linux-kernel@vger.kernel.org>
References: <9883f24e-7ea4-ffe1-e284-8583a3407c94@linux.ee>
Message-ID: <70778c21-8039-5011-e885-221c2cb06220@linux.ee>
Date:   Tue, 8 Sep 2020 15:25:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <9883f24e-7ea4-ffe1-e284-8583a3407c94@linux.ee>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to myself:
> This is 5.9.0-rc3-00091-ge28f0104343d on Lenovo t460s that has ran fine up to 5.8.0.

Now I reproduced the same problem with 5.9.0-rc3 on a HP desktop with Core2Quad CPU. The call trace is very similar and it's crashing gcc again while compiling 5.9-rc4.

But it seems 5.9-rc4 cures it here as well - whatever the reason might have been.

[  814.959665] general protection fault, probably for non-canonical address 0xdead000000000400: 0000 [#1] SMP PTI
[  814.959671] CPU: 2 PID: 14496 Comm: cc1 Not tainted 5.9.0-rc3 #51
[  814.959672] Hardware name: Hewlett-Packard HP Compaq 6000 Pro MT PC/3048h, BIOS 786G2 v02.03 10/19/2015
[  814.959678] RIP: 0010:ext4_readpage+0xa/0x50
[  814.959680] Code: 60 01 fb 44 89 ca 4c 89 c6 e8 32 50 03 00 85 c0 79 ea 0f 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00 41 54 49 89 f4 55 48 8b 46 18 <48> 8b 28 48 8b 85 68 ff ff ff a9 00 00 00 10 74 1b 66 83 bd d2 02
[  814.959681] RSP: 0000:ffffbcd4cb73fd68 EFLAGS: 00010286
[  814.959683] RAX: dead000000000400 RBX: ffffbcd4cb73fe40 RCX: 0000000000000000
[  814.959685] RDX: 0000000000000001 RSI: ffffe51507178c40 RDI: ffff9ff63f9e8e00
[  814.959686] RBP: ffffe51507178c40 R08: 0000000000000002 R09: ffff9ff653d21d90
[  814.959687] R10: ffff9ff64fee2c00 R11: ffff9ff63f9e8e00 R12: ffffe51507178c40
[  814.959688] R13: 0000000000000a31 R14: ffff9ff640b8ee98 R15: ffff9ff640b8f008
[  814.959690] FS:  00007f9ac1c64f00(0000) GS:ffff9ff653d00000(0000) knlGS:0000000000000000
[  814.959692] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  814.959693] CR2: 0000000000e31ff0 CR3: 00000001d99de000 CR4: 00000000000406e0
[  814.959694] Call Trace:
[  814.959700]  filemap_fault+0x193/0x7c0
[  814.959703]  ext4_filemap_fault+0x28/0x3a
[  814.959706]  __do_fault+0x31/0xf0
[  814.959708]  handle_mm_fault+0xf0e/0x14c0
[  814.959712]  do_user_addr_fault+0x18c/0x380
[  814.959715]  exc_page_fault+0x5b/0x80
[  814.959718]  ? asm_exc_page_fault+0x8/0x30
[  814.959720]  asm_exc_page_fault+0x1e/0x30
[  814.959722] RIP: 0033:0xe31ff0
[  814.959725] Code: Bad RIP value.
[  814.959727] RSP: 002b:00007ffc2515f458 EFLAGS: 00010246
[  814.959728] RAX: 0000000000000000 RBX: 00007f9ac0118798 RCX: 0000000000000070
[  814.959730] RDX: 00007ffc2515f4a0 RSI: 00007f9ac1500b28 RDI: 00007ffc2515f510
[  814.959731] RBP: 00007f9ac00d4ea0 R08: 0000000000000000 R09: 0000000000000008
[  814.959732] R10: 0000000000000000 R11: 0000000002807fe0 R12: 0000000000861300
[  814.959733] R13: 00007f9ac1500b28 R14: 00007f9ac0118798 R15: 00007ffc2515f4a0
[  814.959735] Modules linked in: 8021q garp stp mrp llc iptable_nat nf_nat nf_conntrack bluetooth libaes nf_defrag_ipv6 jitterentropy_rng nf_defrag_ipv4 libcrc32c iptable_mangle bpfilter drbg iptable_filter ecdh_generic ecc snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio iTCO_wdt mei_wdt iTCO_vendor_support wmi_bmof kvm_intel snd_hda_intel snd_intel_dspcfg snd_hda_codec pcspkr kvm snd_hwdep snd_hda_core irqbypass snd_pcm mei_me snd_timer snd lpc_ich mfd_core mei soundcore 8250_pci tpm_infineon tpm_tis tpm_tis_core tpm rng_core wmi coretemp hwmon ip_tables x_tables autofs4
[  814.959762] ---[ end trace 9b16ba743f2d455c ]---
[  814.959764] RIP: 0010:ext4_readpage+0xa/0x50
[  814.959766] Code: 60 01 fb 44 89 ca 4c 89 c6 e8 32 50 03 00 85 c0 79 ea 0f 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00 41 54 49 89 f4 55 48 8b 46 18 <48> 8b 28 48 8b 85 68 ff ff ff a9 00 00 00 10 74 1b 66 83 bd d2 02
[  814.959769] RSP: 0000:ffffbcd4cb73fd68 EFLAGS: 00010286
[  814.959771] RAX: dead000000000400 RBX: ffffbcd4cb73fe40 RCX: 0000000000000000
[  814.959772] RDX: 0000000000000001 RSI: ffffe51507178c40 RDI: ffff9ff63f9e8e00
[  814.959774] RBP: ffffe51507178c40 R08: 0000000000000002 R09: ffff9ff653d21d90
[  814.959776] R10: ffff9ff64fee2c00 R11: ffff9ff63f9e8e00 R12: ffffe51507178c40
[  814.959778] R13: 0000000000000a31 R14: ffff9ff640b8ee98 R15: ffff9ff640b8f008
[  814.959780] FS:  00007f9ac1c64f00(0000) GS:ffff9ff653d00000(0000) knlGS:0000000000000000
[  814.959782] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  814.959784] CR2: 0000000000e31fc6 CR3: 00000001d99de000 CR4: 00000000000406e0



> Today I tried reproducing my linking problem with git kernel on my laptop and got segmentation faults in gcc. This is probably the corresponding dmesg part:
> 
> 0xdead000000000400 loks like some kind of poisoning.
> 
> [307299.392045] general protection fault, probably for non-canonical address 0xdead000000000400: 0000 [#1] SMP PTI
> [307299.392050] CPU: 1 PID: 165374 Comm: cc1 Not tainted 5.9.0-rc3-00091-ge28f0104343d #207
> [307299.392051] Hardware name: LENOVO 20F9003SMS/20F9003SMS, BIOS N1CET71W (1.39 ) 09/04/2018
> [307299.392055] RIP: 0010:ext4_readpage+0xb/0x90
> [307299.392057] Code: 9b a3 a6 e8 57 82 fe ff f0 80 63 01 df f0 80 63 01 bf 5b c3 c3 f0 80 0e 01 eb d7 0f 1f 40 00 41 54 49 89 f4 55 53 48 8b 46 18 <48> 8b 28 0f 1f 44 00 00 48 8b 85 68 ff ff ff a9 00 00 00 10 74 1f
> [307299.392058] RSP: 0018:ffffa08308d03d58 EFLAGS: 00010286
> [307299.392060] RAX: dead000000000400 RBX: ffffa08308d03e38 RCX: 0000000000000000
> [307299.392061] RDX: 0000000000000001 RSI: ffffde94c0d00ec0 RDI: ffff9661c786ca00
> [307299.392062] RBP: ffffde94c0d00ec0 R08: 0000000000000001 R09: 0000000000000000
> [307299.392063] R10: 0000000000000071 R11: ffff9661c786ca00 R12: ffffde94c0d00ec0
> [307299.392064] R13: 000000000000063b R14: ffff96636d3aaea0 R15: ffff96636d3ab018
> [307299.392065] FS:  00007f7871446f00(0000) GS:ffff966396c80000(0000) knlGS:0000000000000000
> [307299.392067] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [307299.392068] CR2: 0000000000a3b1f0 CR3: 000000006c3e2003 CR4: 00000000003706e0
> [307299.392069] Call Trace:
> [307299.392073]  filemap_fault+0x193/0x7c0
> [307299.392075]  ext4_filemap_fault+0x28/0x3a
> [307299.392078]  __do_fault+0x31/0xf0
> [307299.392080]  handle_mm_fault+0xf1a/0x14c0
> [307299.392084]  do_user_addr_fault+0x1b3/0x3e0
> [307299.392087]  exc_page_fault+0x61/0x130
> [307299.392089]  ? asm_exc_page_fault+0x8/0x30
> [307299.392091]  asm_exc_page_fault+0x1e/0x30
> [307299.392093] RIP: 0033:0xa3b620
> [307299.392096] Code: Bad RIP value.
> [307299.392097] RSP: 002b:00007ffe4b382018 EFLAGS: 00010202
> [307299.392099] RAX: 00007f786fd32980 RBX: 00007f786fd32a18 RCX: 0000000000000000
> [307299.392100] RDX: 0000000000000002 RSI: 0000000000000001 RDI: 00007f786fd4ee70
> [307299.392101] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000000c0
> [307299.392102] R10: 0000000000000140 R11: 000000000000002f R12: 0000000000000001
> [307299.392103] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000-- 
Meelis Roos <mroos@linux.ee>
