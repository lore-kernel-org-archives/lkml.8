Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D78C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE58120772
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgFEIga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 04:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgFEIg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 04:36:27 -0400
Received: from trent.utfs.org (trent.utfs.org [IPv6:2a03:3680:0:3::67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C916C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 01:36:27 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 76A4760125;
        Fri,  5 Jun 2020 10:36:21 +0200 (CEST)
Date:   Fri, 5 Jun 2020 01:36:21 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     linux-kernel@vger.kernel.org
cc:     xen-devel@lists.xenproject.org
Subject: 5.7.0 / BUG: kernel NULL pointer dereference / setup_cpu_watcher
Message-ID: <alpine.DEB.2.22.395.2006050059530.13291@trent.utfs.org>
User-Agent: Alpine 2.22 (DEB 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running a small Xen PVH domain and upgrading from vanilla 5.6.0 to 
5.7.0 caused the splat below, really early during boot. The configuration 
has not changed, all new "make oldconfig" prompts have been answered with 
"N". Old and new config, dmesg are here:

  http://nerdbynature.de/bits/5.7.0/

Searching the interwebs for similar reports didn't return much:

 * drm_sched_get_cleanup_job: BUG: kernel NULL pointer dereference
   https://bugzilla.redhat.com/show_bug.cgi?id=1822984  -- but this 
   appears to be really DRM related. - https://lkml.org/lkml/2020/4/10/545

 * A recent mm/vmstat patch, mentioning "device_offline" in its output
   https://patchwork.kernel.org/patch/11563009/

But other than a few overlapping strings, I guess all of that is totally 
unrelated :(

Thanks,
Christian.


Note: that "Xen Platform PCI: unrecognised magic value" on the top appears 
in 5.6 kernels as well, but no ill effects so far.

---------------------------------------------------------------
Xen Platform PCI: unrecognised magic value
ACPI: No IOAPIC entries present
BUG: kernel NULL pointer dereference, address: 00000000000002d0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] SMP PTI
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0 #2
RIP: 0010:device_offline+0x8/0xf0
Code: 48 89 e7 e8 3a ee f3 ff 4c 89 e0 48 83 c4 10 5b 41 5c c3 45 31 e4 48 83 c4 10 4c 89 e0 5b 41 5c c3 90 41 54 55 53 48 83 ec 10 <f6> 87 d0 02 00 00 01 0f 85 ca 00 00 00 48 89 fb 48 8b 7f 48 48 85
RSP: 0000:ffffbd9100013e78 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000820001fa
RDX: ffff9c9c3dd00000 RSI: 00000000820001fa RDI: 0000000000000000
RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000000000000
R10: ffff9c9c3d5072a8 R11: 0000000000000000 R12: ffff9c9c3d594720
R13: ffffffff8a57e5a8 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff9c9c3dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000002d0 CR3: 000000006b00a001 CR4: 00000000001606b0
Call Trace:
 setup_cpu_watcher+0x44/0x60
 ? plt_clk_driver_init+0xe/0xe
 setup_vcpu_hotplug_event+0x23/0x26
 do_one_initcall+0x47/0x180
 kernel_init_freeable+0x13b/0x19d
 ? rest_init+0x95/0x95
 kernel_init+0x5/0xeb
 ret_from_fork+0x35/0x40
Modules linked in:
CR2: 00000000000002d0
---[ end trace b0cc587db609787f ]---

-- 
BOFH excuse #440:

Cache miss - please take better aim next time
