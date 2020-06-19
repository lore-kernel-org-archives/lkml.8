Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99D6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 06:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA48620809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 06:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgFSGuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 02:50:10 -0400
Received: from verein.lst.de ([213.95.11.211]:52193 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgFSGuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 02:50:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 91CA76736F; Fri, 19 Jun 2020 08:50:07 +0200 (CEST)
Date:   Fri, 19 Jun 2020 08:50:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Commit 25f12ae45fc1 ("maccess: rename probe_kernel_address to
 get_kernel_nofault") causing several OOPSes
Message-ID: <20200619065007.GA3041@lst.de>
References: <alpine.DEB.2.22.394.2006181751270.9276@xps-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006181751270.9276@xps-7390>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That is indeed really strange, as that commit is just a rename.
Well, Linus also added swapping of the argument order, but again it
shouldn't change much.  Do you see any compiler warnings or something
odd in the kernel log before the actual crash?

On Thu, Jun 18, 2020 at 06:21:37PM -0700, Kenneth R. Crudup wrote:
> 
> My system oopses in all manner of places with it in when/if my Thunderbolt
> adapter is connected (and clears up if I revert just this).
> 
> Here's a couple examples:
> 
> ----
> <6>[   43.136942][   T37] r8152 6-2.1.2:1.0 eth0: carrier on
> <4>[   45.400675][  T235] general protection fault, probably for non-canonical address 0xdead000000000122: 0000 [#1] PREEMPT SMP NOPTI
> <4>[   45.400680][  T235] CPU: 6 PID: 235 Comm: kworker/u16:4 Tainted: G     U            5.8.0-rc1-XPS-Kenny+ #29
> <4>[   45.400681][  T235] Hardware name: Dell Inc. XPS 13 7390 2-in-1/06CDVY, BIOS 1.3.1 03/02/2020
> <4>[   45.400719][  T235] Workqueue: i915-dp i915_digport_work_func [i915]
> <4>[   45.400723][  T235] RIP: 0010:drm_dp_mst_hpd_irq+0x7a8/0x1040
> <4>[   45.400725][  T235] Code: 7d c0 4c 89 55 b8 e8 a7 c3 ff ff 4c 8b 55 b8 4c 89 d7 e8 7b 89 57 00 49 8b 17 49 8b 47 08 41 c7 47 14 03 00 00 00 48 89 42 08 <48> 89 10 48 b8 00 01 00 00 00 00 ad de 49 89 07 48 83 c0 22 4c 8b
> Oops#1 Part1
> <4>[   45.400727][  T235] RSP: 0018:ffff978d808c7d70 EFLAGS: 00010246
> <4>[   45.400728][  T235] RAX: dead000000000122 RBX: ffff8b49230cc7e8 RCX: 0000000000000002
> <4>[   45.400729][  T235] RDX: ffff8b48ba9df140 RSI: ffffffff9ad85a32 RDI: ffff8b49230ccb68
> <4>[   45.400730][  T235] RBP: ffff978d808c7dc0 R08: 0000000000000006 R09: ffffffff9ad85e70
> <4>[   45.400731][  T235] R10: ffff8b49230ccb68 R11: 0000000000000014 R12: ffff978d808c7df2
> <4>[   45.400732][  T235] R13: ffff978d808c7df1 R14: 0000000000000140 R15: ffff8b48ba9dc140
> <4>[   45.400733][  T235] FS:  0000000000000000(0000) GS:ffff8b492f780000(0000) knlGS:0000000000000000
> <4>[   45.400734][  T235] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[   45.400735][  T235] CR2: 00007f3d3f1ebd90 CR3: 000000082460c006 CR4: 0000000000760ee0
> <4>[   45.400736][  T235] PKRU: 55555554
> <4>[   45.400737][  T235] Call Trace:
> <4>[   45.400762][  T235]  ? intel_dp_hpd_pulse+0x2b8/0x440 [i915]
> <4>[   45.400785][  T235]  intel_dp_hpd_pulse+0x2b8/0x440 [i915]
> <4>[   45.400809][  T235]  i915_digport_work_func+0xcb/0x160 [i915]
> <4>[   45.400814][  T235]  process_one_work+0x1ac/0x300
> <4>[   45.400815][  T235]  worker_thread+0x49/0x3c0
> <4>[   45.400817][  T235]  ? process_one_work+0x300/0x300
> <4>[   45.400819][  T235]  kthread+0x10e/0x150
> <4>[   45.400821][  T235]  ? kthread_park+0x90/0x90
> <4>[   45.400823][  T235]  ret_from_fork+0x1f/0x30
> <4>[   45.400825][  T235] Modules linked in: r8152 snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic btusb btintel vmw_vmci iwlmvm mac80211 snd_hda_intel iwlwifi snd_intel_dspcfg snd_hda_codec snd_hda_core cfg80211 mei_hdcp i915 intel_gtt
> <4>[   45.400834][  T235] ---[ end trace e3e9561107d7861e ]---
> ----
> 
> ----
> <3>[   93.961454][   T32] i915 0000:00:02.0: [drm] *ERROR* failed to enable link training
> <4>[  104.048809][   T47] general protection fault, probably for non-canonical address 0xdead000000000100: 0000 [#1] PRE
> EMPT SMP NOPTI
> <4>[  104.051127][   T47] CPU: 7 PID: 47 Comm: kworker/7:0 Tainted: G     U            5.8.0-rc1-XPS-Kenny+ #29
> <4>[  104.052493][   T47] Hardware name: Dell Inc. XPS 13 7390 2-in-1/06CDVY, BIOS 1.3.1 03/02/2020
> <4>[  104.054387][   T47] Workqueue: events drm_dp_delayed_destroy_work
> Oops#1 Part1
> <4>[  104.055639][   T47] RIP: 0010:drm_dp_delayed_destroy_work+0x16b/0x2d0
> <4>[  104.056924][   T47] Code: 00 00 48 89 f1 48 8b 34 24 48 3b b2 38 01 00 00 75 32 48 8b ba 40 01 00 00 48 8b b2 48 0
> 1 00 00 c7 82 54 01 00 00 04 00 00 00 <48> 89 77 08 48 89 3e 4c 89 aa 40 01 00 00 4c 89 a2 48 01 00 00 bb
> <4>[  104.058343][   T47] RSP: 0018:ffffb68100257e18 EFLAGS: 00010246
> <4>[  104.059857][   T47] RAX: ffff916c625f2b88 RBX: 0000000000000001 RCX: deacffffffffffc0
> <4>[  104.061593][   T47] RDX: ffff916c47ae1800 RSI: dead000000000122 RDI: dead000000000100
> <4>[  104.064004][   T47] RBP: ffff916c625f2c50 R08: 0000000000000001 R09: ffff916c6c006a00
> <4>[  104.066821][   T47] R10: ffff916c6a4d4000 R11: ffff916c6bc00e48 R12: dead000000000122
> <4>[  104.069857][   T47] R13: dead000000000100 R14: ffff916c625f2af8 R15: ffff916c52259a28
> <4>[  104.072820][   T47] FS:  0000000000000000(0000) GS:ffff916c6f7c0000(0000) knlGS:0000000000000000
> <4>[  104.075671][   T47] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[  104.078493][   T47] CR2: 000055f3668bf058 CR3: 00000008407de003 CR4: 0000000000760ee0
> <4>[  104.081331][   T47] PKRU: 55555554
> <4>[  104.084125][   T47] Call Trace:
> <4>[  104.086726][   T47]  process_one_work+0x1ac/0x300
> <4>[  104.089355][   T47]  worker_thread+0x49/0x3c0
> <4>[  104.091899][   T47]  ? process_one_work+0x300/0x300
> <4>[  104.094377][   T47]  kthread+0x10e/0x150
> <4>[  104.096662][   T47]  ? kthread_park+0x90/0x90
> <4>[  104.098952][   T47]  ret_from_fork+0x1f/0x30
> <4>[  104.101248][   T47] Modules linked in: r8152 snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic btusb btintel vmw_vmci iwlmvm snd_hda_intel mac80211 snd_intel_dspcfg mei_hdcp snd_hda_codec iwlwifi snd_hda_core i915 cfg80211 intel_gtt
> <4>[  104.106196][   T47] ---[ end trace 9d53a6fd1074c5d2 ]---
> ----
> 
> ----
> <6>[   39.395350][  T935] usb 5-2.1.4: new high-speed USB device number 10 using xhci_hcd
> <0>[   39.447609][   T17] BUG: stack guard page was hit at 000000001d3357a4 (stack is 00000000d8c3d9e8..000000009e4ee10e)
> <4>[   39.447619][   T17] kernel stack overflow (page fault): 0000 [#1] PREEMPT SMP NOPTI
> Oops#1 Part1
> <4>[   39.447625][   T17] CPU: 1 PID: 17 Comm: kworker/1:0 Tainted: G     U            5.8.0-rc1-XPS-Kenny+ #29
> <4>[   39.447628][   T17] Hardware name: Dell Inc. XPS 13 7390 2-in-1/06CDVY, BIOS 1.3.1 03/02/2020
> <4>[   39.447637][   T17] Workqueue: events_long drm_dp_tx_work
> <4>[   39.447644][   T17] RIP: 0010:process_single_tx_qlock+0x3bb/0x5f0
> <4>[   39.447649][   T17] Code: 48 83 e0 e0 48 89 c2 31 c0 4d 8b 0c 03 4d 8b 44 03 08 49 8b 7c 03 10 49 8b 74 03 18 4c 89 0c 01 4c 89 44 01 08 48 89 7c 01 10 <48> 89 74 01 18 48 83 c0 20 48 39 d0 72 d1 e9 b5 fe ff ff 48 8b 4f
> <4>[   39.447652][   T17] RSP: 0018:ffffbb0a0014fd98 EFLAGS: 00010203
> <4>[   39.447656][   T17] RAX: 0000000000000200 RBX: 00000000fffffffc RCX: ffffbb0a0014fde8
> <4>[   39.447660][   T17] RDX: ffffffffffffffe0 RSI: 0000000000000000 RDI: 0000000000000000
> <4>[   39.447662][   T17] RBP: ffff9c87712ea800 R08: 0000000000000000 R09: 0000000000000000
> <4>[   39.447665][   T17] R10: 0000000000000000 R11: ffff9c87712ea809 R12: ffff9c87a3b417e8
> <4>[   39.447668][   T17] R13: 0000000000000000 R14: 0000000000000003 R15: ffffbb0a0014fde3
> <4>[   39.447672][   T17] FS:  0000000000000000(0000) GS:ffff9c87af640000(0000) knlGS:0000000000000000
> <4>[   39.447675][   T17] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[   39.447679][   T17] CR2: ffffbb0a00150000 CR3: 000000025760a001 CR4: 0000000000760ee0
> <4>[   39.447682][   T17] PKRU: 55555554
> <4>[   39.447684][   T17] Call Trace:
> <4>[   39.447693][   T17] Modules linked in: r8152 snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic btusb btintel vmw_vmci iwlmvm mei_hdcp snd_hda_intel mac80211 snd_intel_dspcfg snd_hda_codec snd_hda_core i915 iwlwifi cfg80211 intel_gtt
> <4>[   39.447712][   T17] ---[ end trace 60af41073edc305f ]---
> ----
> 
> ----
> <0>[   38.555935][   T76] BUG: stack guard page was hit at 00000000244b28bd (stack is 000000000d692c63..00000000613959ea)
> <4>[   38.555949][   T76] kernel stack overflow (page fault): 0000 [#1] PREEMPT SMP NOPTI
> Panic#2 Part1
> <4>[   38.556022][   T76] PKRU: 55555554
> <4>[   38.556025][   T76] Call Trace:
> <4>[   38.556036][   T76] Modules linked in: r8152 snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic btusb btintel vmw_vmci iwlmvm snd_hda_intel snd_intel_dspcfg mac80211 snd_hda_codec snd_hda_core iwlwifi i915 mei_hdcp cfg80211 intel_gtt
> <4>[   38.556058][   T76] ---[ end trace d76b60500c18efde ]---
> <4>[   38.920175][   T76] RIP: 0010:process_single_tx_qlock+0x329/0x480
> <4>[   38.920181][   T76] Code: c0 01 89 44 24 04 eb 8e 4a 8b 54 30 f8 49 89 54 07 f8 48 83 e8 01 48 83 f8 08 0f 82 38 ff ff ff 48 83 e0 f8 31 d2 49 8b 0c 16 <49> 89 0c 17 48 83 c2 08 48 39 c2 72 ef e9 1c ff ff ff c6 44 24 3e
> <4>[   38.920184][   T76] RSP: 0018:ffffc170c0347da0 EFLAGS: 00010203
> <4>[   38.920188][   T76] RAX: fffffffffffffff8 RBX: 00000000fffffffc RCX: 0000000000000000
> <4>[   38.920191][   T76] RDX: 0000000000000218 RSI: 0000000000000000 RDI: ffffc170c0347de0
> <4>[   38.920193][   T76] RBP: ffff9fa7c34b4000 R08: 0000000000000002 R09: 000000000000000a
> <4>[   38.920195][   T76] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9fa80a3007e8
> <4>[   38.920197][   T76] R13: 0000000000000003 R14: ffff9fa7c34b4004 R15: ffffc170c0347de3
> <4>[   38.920200][   T76] FS:  0000000000000000(0000) GS:ffff9fa80f440000(0000) knlGS:0000000000000000
> <4>[   38.920202][   T76] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[   38.920203][   T76] CR2: ffffc170c0348000 CR3: 000000084872e004 CR4: 0000000000760ee0
> <4>[   38.920205][   T76] PKRU: 55555554
> <0>[   38.920207][   T76] Kernel panic - not syncing: Fatal exception
> <0>[   38.920218][   T76] Kernel Offset: 0x9200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> Oops#1 Part1
> <4>[   38.555956][   T76] CPU: 1 PID: 76 Comm: kworker/1:1 Tainted: G     U            5.8.0-rc1-XPS-Kenny+ #32
> <4>[   38.555960][   T76] Hardware name: Dell Inc. XPS 13 7390 2-in-1/06CDVY, BIOS 1.3.1 03/02/2020
> <4>[   38.555971][   T76] Workqueue: events_long drm_dp_tx_work
> <4>[   38.555980][   T76] RIP: 0010:process_single_tx_qlock+0x329/0x480
> <4>[   38.555985][   T76] Code: c0 01 89 44 24 04 eb 8e 4a 8b 54 30 f8 49 89 54 07 f8 48 83 e8 01 48 83 f8 08 0f 82 38 ff ff ff 48 83 e0 f8 31 d2 49 8b 0c 16 <49> 89 0c 17 48 83 c2 08 48 39 c2 72 ef e9 1c ff ff ff c6 44 24 3e
> <4>[   38.555990][   T76] RSP: 0018:ffffc170c0347da0 EFLAGS: 00010203
> <4>[   38.555995][   T76] RAX: fffffffffffffff8 RBX: 00000000fffffffc RCX: 0000000000000000
> <4>[   38.555998][   T76] RDX: 0000000000000218 RSI: 0000000000000000 RDI: ffffc170c0347de0
> <4>[   38.556001][   T76] RBP: ffff9fa7c34b4000 R08: 0000000000000002 R09: 000000000000000a
> <4>[   38.556004][   T76] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9fa80a3007e8
> <4>[   38.556007][   T76] R13: 0000000000000003 R14: ffff9fa7c34b4004 R15: ffffc170c0347de3
> <4>[   38.556012][   T76] FS:  0000000000000000(0000) GS:ffff9fa80f440000(0000) knlGS:0000000000000000
> <4>[   38.556015][   T76] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[   38.556019][   T76] CR2: ffffc170c0348000 CR3: 000000084872e004 CR4: 0000000000760ee0
> <4>[   38.556022][   T76] PKRU: 55555554
> <4>[   38.556025][   T76] Call Trace:
> <4>[   38.556036][   T76] Modules linked in: r8152 snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic btusb btintel vmw_vmci iwlmvm snd_hda_intel snd_intel_dspcfg mac80211 snd_hda_codec snd_hda_core iwlwifi i915 mei_hdcp cfg80211 intel_gtt
> <4>[   38.556058][   T76] ---[ end trace d76b60500c18efde ]---
> ---
> 
> 	-Kenny
> 
> -- 
> Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
---end quoted text---
