Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84228C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7F22469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbgB0Q6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:58:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:25677 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbgB0Q6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:58:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 08:58:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,492,1574150400"; 
   d="scan'208";a="317844982"
Received: from skuppusw-desk.jf.intel.com ([10.7.201.16])
  by orsmga001.jf.intel.com with ESMTP; 27 Feb 2020 08:58:08 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v1 1/1] x86/apic/vector: Fix NULL pointer exception in irq_complete_move()
Date:   Thu, 27 Feb 2020 08:55:16 -0800
Message-Id: <f54208d62407901b5de15ce8c3d078c70fc7a1d0.1582313239.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

If an IRQ is scheduled using generic_handle_irq() function in a non IRQ
path, the irq_regs per CPU variable will not be set. Hence calling
irq_complete_move() function in this scenario leads to NULL pointer
de-reference exception. One example for this issue is, triggering fake
AER errors using PCIe aer_inject framework. So add addition check for
irq_regs NULL pointer in irq_complete_move() function.

[   58.368226] aer 0000:00:1c.0:pcie002: aer_inject: Injecting errors
00000040/00000000 into device 0000:01:00.0
[   58.368234] BUG: unable to handle kernel NULL pointer dereference at
0000000000000078
[   58.368235] #PF error: [normal kernel read fault]
[   58.368236] PGD 455bb6067 P4D 455bb6067 PUD 45cc18067 PMD 0
[   58.368239] Oops: 0000 [#1] SMP NOPTI
[   58.368241] CPU: 7 PID: 22295 Comm: aer-inject Not tainted 5.0.0 #1
[   58.368242] Hardware name: Intel Corporation CooperCity/CooperCity,
BIOS WLYDCRB1.SYS.0014.D94.2001301835 01/30/2020
[   58.368249] RIP: 0010:apic_ack_edge+0x1e/0x40
[   58.368251] Code: 1b 01 e8 65 f8 11 00 eb e3 0f 1f 00 0f 1f 44 00 00
48 85 ff 53 48 89 fb 74 21 e8 3d ec ff ff 48 89 c7 65 48 8b 15 6a 40 fc
43 <48> 8b 72 78 f7 d6 e8 f7 ea ff ff 48 89 df 5b eb a1 31 ff eb e3 0f
[   58.368252] RSP: 0018:ffffb8d74705bd88 EFLAGS: 00010046
[   58.368253] RAX: ffff996b6cda7540 RBX: ffff996b6cda7500 RCX:
0000000000000000
[   58.368254] RDX: 0000000000000000 RSI: 0000000000000018 RDI:
ffff996b6cda7540
[   58.368255] RBP: ffff996b6a7c5118 R08: ffff996b6f000920 R09:
ffff996b6f000a08
[   58.368256] R10: 0000000000000000 R11: ffffffffbda660e0 R12:
0000000000000020
[   58.368257] R13: ffff996b65e45200 R14: 0000000000000000 R15:
ffff996b69e29000
[   58.368258] FS:  00007f994cf74740(0000) GS:ffff996b6f9c0000(0000)
knlGS:0000000000000000
[   58.368259] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.368259] CR2: 0000000000000078 CR3: 0000000455576004 CR4:
00000000007606e0
[   58.368260] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   58.368261] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   58.368261] PKRU: 55555554
[   58.368262] Call Trace:
[   58.368269]  handle_edge_irq+0x7d/0x1e0
[   58.368272]  generic_handle_irq+0x27/0x30
[   58.368278]  aer_inject_write+0x53a/0x720
[   58.368283]  __vfs_write+0x36/0x1b0
[   58.368289]  ? common_file_perm+0x47/0x130
[   58.368293]  ? security_file_permission+0x2e/0xf0
[   58.368295]  vfs_write+0xa5/0x180
[   58.368296]  ksys_write+0x52/0xc0
[   58.368300]  do_syscall_64+0x48/0x120
[   58.368307]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   58.368309] RIP: 0033:0x7f994cb65680
[   58.368310] Code: 89 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
84 00 00 00 00 00 0f 1f 00 83 3d 69 cd 20 00 00 75 10 b8 01 00 00 00 0f
05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 4e fd ff ff 48 89 04 24
[   58.368311] RSP: 002b:00007ffffcd356d8 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[   58.368312] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f994cb65680
[   58.368313] RDX: 0000000000000020 RSI: 00000000006063e0 RDI:
0000000000000004
[   58.368314] RBP: 00007ffffcd35700 R08: 00007ffffcd355b0 R09:
00007f994cf74740
[   58.368314] R10: 00007ffffcd34ae0 R11: 0000000000000246 R12:
0000000000400ef0
[   58.368315] R13: 00007ffffcd36080 R14: 0000000000000000 R15:
0000000000000000
[   58.368316] Modules linked in: fuse xt_CHECKSUM iptable_mangle
ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat xt_conntrack nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 xt_tcpudp tun
bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables
iptable_filter intel_rapl skx_edac nfit iTCO_wdt iTCO_vendor_support
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
intel_spi_pci intel_spi spi_nor i2c_i801 mtd mei_me mei ioatdma dca wmi
acpi_power_meter joydev ip_tables x_tables crc32c_intel ast ttm
[   58.368335] CR2: 0000000000000078
[   58.368336] ---[ end trace f0e610fab8685be7 ]---
[   58.390416] RIP: 0010:apic_ack_edge+0x1e/0x40
[   58.390421] Code: 1b 01 e8 65 f8 11 00 eb e3 0f 1f 00 0f 1f 44 00 00
48 85 ff 53 48 89 fb 74 21 e8 3d ec ff ff 48 89 c7 65 48 8b 15 6a 40 fc
43 <48> 8b 72 78 f7 d6 e8 f7 ea ff ff 48 89 df 5b eb a1 31 ff eb e3 0f
[   58.390423] RSP: 0018:ffffb8d74705bd88 EFLAGS: 00010046
[   58.390424] RAX: ffff996b6cda7540 RBX: ffff996b6cda7500 RCX:
0000000000000000
[   58.390425] RDX: 0000000000000000 RSI: 0000000000000018 RDI:
ffff996b6cda7540
[   58.390426] RBP: ffff996b6a7c5118 R08: ffff996b6f000920 R09:
ffff996b6f000a08
[   58.390427] R10: 0000000000000000 R11: ffffffffbda660e0 R12:
0000000000000020
[   58.390428] R13: ffff996b65e45200 R14: 0000000000000000 R15:
ffff996b69e29000
[   58.390429] FS:  00007f994cf74740(0000) GS:ffff996b6f9c0000(0000)
knlGS:0000000000000000
[   58.390430] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   58.390431] CR2: 0000000000000078 CR3: 0000000455576004 CR4:
00000000007606e0
[   58.390431] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   58.390432] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   58.390433] PKRU: 55555554

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/kernel/apic/vector.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 2c5676b0a6e7..5cf11dcf28d9 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -926,6 +926,10 @@ static void __irq_complete_move(struct irq_cfg *cfg, unsigned vector)
 
 void irq_complete_move(struct irq_cfg *cfg)
 {
+	/* if irq_regs per CPU variable is not set, just return */
+	if (!get_irq_regs())
+		return;
+
 	__irq_complete_move(cfg, ~get_irq_regs()->orig_ax);
 }
 
-- 
2.21.0

