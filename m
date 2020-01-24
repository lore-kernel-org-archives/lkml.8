Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFC3C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EDF2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404135AbgAXTL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:11:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43065 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403988AbgAXTLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:11:25 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iv4MS-0007f4-N0; Fri, 24 Jan 2020 20:11:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3F29E1C1A60;
        Fri, 24 Jan 2020 20:11:12 +0100 (CET)
Date:   Fri, 24 Jan 2020 19:11:12 -0000
From:   "tip-bot2 for John Garry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/mbigen: Set driver .suppress_bind_attrs to
 avoid remove problems
Cc:     John Garry <john.garry@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1579196323-180137-1-git-send-email-john.garry@huawei.com>
References: <1579196323-180137-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Message-ID: <157989307202.396.10033194386520544016.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d6152e6ec9e2171280436f7b31a571509b9287e1
Gitweb:        https://git.kernel.org/tip/d6152e6ec9e2171280436f7b31a571509b9287e1
Author:        John Garry <john.garry@huawei.com>
AuthorDate:    Fri, 17 Jan 2020 01:38:43 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 20 Jan 2020 19:10:04 

irqchip/mbigen: Set driver .suppress_bind_attrs to avoid remove problems

The following crash can be seen for setting
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y for DT FW (which some people still use):

Hisilicon MBIGEN-V2 60080000.interrupt-controller: Failed to create mbi-gen irqdomain
Hisilicon MBIGEN-V2: probe of 60080000.interrupt-controller failed with error -12

[...]

Unable to handle kernel paging request at virtual address 0000000000005008
 Mem abort info:
   ESR = 0x96000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
 Data abort info:
   ISV = 0, ISS = 0x00000004
   CM = 0, WnR = 0
 user pgtable: 4k pages, 48-bit VAs, pgdp=0000041fb9990000
 [0000000000005008] pgd=0000000000000000
 Internal error: Oops: 96000004 [#1] PREEMPT SMP
 Modules linked in:
 CPU: 7 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc6-00002-g3fc42638a506-dirty #1622
 Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21 Nemo 2.0 RC0 04/18/2018
 pstate: 40000085 (nZcv daIf -PAN -UAO)
 pc : mbigen_set_type+0x38/0x60
 lr : __irq_set_trigger+0x6c/0x188
 sp : ffff800014b4b400
 x29: ffff800014b4b400 x28: 0000000000000007
 x27: 0000000000000000 x26: 0000000000000000
 x25: ffff041fd83bd0d4 x24: ffff041fd83bd188
 x23: 0000000000000000 x22: ffff80001193ce00
 x21: 0000000000000004 x20: 0000000000000000
 x19: ffff041fd83bd000 x18: ffffffffffffffff
 x17: 0000000000000000 x16: 0000000000000000
 x15: ffff8000119098c8 x14: ffff041fb94ec91c
 x13: ffff041fb94ec1a1 x12: 0000000000000030
 x11: 0101010101010101 x10: 0000000000000040
 x9 : 0000000000000000 x8 : ffff041fb98c6680
 x7 : ffff800014b4b380 x6 : ffff041fd81636c8
 x5 : 0000000000000000 x4 : 000000000000025f
 x3 : 0000000000005000 x2 : 0000000000005008
 x1 : 0000000000000004 x0 : 0000000080000000
 Call trace:
  mbigen_set_type+0x38/0x60
  __setup_irq+0x744/0x900
  request_threaded_irq+0xe0/0x198
  pcie_pme_probe+0x98/0x118
  pcie_port_probe_service+0x38/0x78
  really_probe+0xa0/0x3e0
  driver_probe_device+0x58/0x100
  __device_attach_driver+0x90/0xb0
  bus_for_each_drv+0x64/0xc8
  __device_attach+0xd8/0x138
  device_initial_probe+0x10/0x18
  bus_probe_device+0x90/0x98
  device_add+0x4c4/0x770
  device_register+0x1c/0x28
  pcie_port_device_register+0x1e4/0x4f0
  pcie_portdrv_probe+0x34/0xd8
  local_pci_probe+0x3c/0xa0
  pci_device_probe+0x128/0x1c0
  really_probe+0xa0/0x3e0
  driver_probe_device+0x58/0x100
  __device_attach_driver+0x90/0xb0
  bus_for_each_drv+0x64/0xc8
  __device_attach+0xd8/0x138
  device_attach+0x10/0x18
  pci_bus_add_device+0x4c/0xb8
  pci_bus_add_devices+0x38/0x88
  pci_host_probe+0x3c/0xc0
  pci_host_common_probe+0xf0/0x208
  hisi_pcie_almost_ecam_probe+0x24/0x30
  platform_drv_probe+0x50/0xa0
  really_probe+0xa0/0x3e0
  driver_probe_device+0x58/0x100
  device_driver_attach+0x6c/0x90
  __driver_attach+0x84/0xc8
  bus_for_each_dev+0x74/0xc8
  driver_attach+0x20/0x28
  bus_add_driver+0x148/0x1f0
  driver_register+0x60/0x110
  __platform_driver_register+0x40/0x48
  hisi_pcie_almost_ecam_driver_init+0x1c/0x24

The specific problem here is that the mbigen driver real probe has failed
as the mbigen_of_create_domain()->of_platform_device_create() call fails,
the reason for that being that we never destroyed the platform device
created during the remove test dry run and there is some conflict.

Since we generally would never want to unbind this driver, and to save
adding a driver tear down path for that, just set the driver
.suppress_bind_attrs member to avoid this possibility.

Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Link: https://lore.kernel.org/r/1579196323-180137-1-git-send-email-john.garry@huawei.com
---
 drivers/irqchip/irq-mbigen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 3f09f65..6b566bb 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -374,6 +374,7 @@ static struct platform_driver mbigen_platform_driver = {
 		.name		= "Hisilicon MBIGEN-V2",
 		.of_match_table	= mbigen_of_match,
 		.acpi_match_table = ACPI_PTR(mbigen_acpi_match),
+		.suppress_bind_attrs = true,
 	},
 	.probe			= mbigen_device_probe,
 };
