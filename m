Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516CBC10F25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 23:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A05206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 23:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOfdjY/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgCGXfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 18:35:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52557 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726180AbgCGXfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 18:35:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583624099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MC8apsGOpphabSR5XgDZNLHlrUNE2JXwiM3SmZulSA4=;
        b=IOfdjY/OINS5mylp98OabjH7UyaDultq0WJ62gnFopFF0bHYhwx0X0l16P8/ZL0qh+9cRU
        D5vm239g7RFy0a3j9kLmXy31NRo4rE44QyvAGLC7p0AqCpYuhD+QzIL+Iv9/hXjXASev5j
        7NlLu9rUbeaLPuFxrou65+7SPmqCysA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-2HHPA9RFOgy0otFEzA1A0g-1; Sat, 07 Mar 2020 18:34:57 -0500
X-MC-Unique: 2HHPA9RFOgy0otFEzA1A0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3322107ACC7;
        Sat,  7 Mar 2020 23:34:55 +0000 (UTC)
Received: from rhp50.localdomain (ovpn-120-185.rdu2.redhat.com [10.10.120.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A03CF1001B2C;
        Sat,  7 Mar 2020 23:34:55 +0000 (UTC)
From:   Mark Salter <msalter@redhat.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip/gic-v3: avoid reading typer2 if GICv3
Date:   Sat,  7 Mar 2020 18:34:42 -0500
Message-Id: <20200307233442.958122-1-msalter@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to boot v5.6-rc1 on a ThunderX platform leads to
a SEA splat when trying to read the GICv4 TYPER2 register:

[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] Internal error: synchronous external abort: 96000210 [#1] =
SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.5.0-rc4+ #11
[    0.000000] Hardware name: Cavium ThunderX CN88XX board (DT)
[    0.000000] pstate: 60400085 (nZCv daIf +PAN -UAO)
[    0.000000] pc : __raw_readl+0x0/0x8
[    0.000000] lr : gic_init_bases+0x110/0x4b0
[    0.000000] sp : ffff800011973dd0
[    0.000000] x29: ffff800011973dd0 x28: 0000000002150018
[    0.000000] x27: 0000000000000018 x26: 0000000000000000
[    0.000000] x25: 0000000000000002 x24: ffff010fe7ef6700
[    0.000000] x23: 0000000000000000 x22: ffff800010dc3b90
[    0.000000] x21: ffff010fef138020 x20: 00000000009b0404
[    0.000000] x19: ffff80001198c508 x18: 0000000000000005
[    0.000000] x17: 000000006fc20c07 x16: 0000000000000001
[    0.000000] x15: 0000000000000010 x14: ffffffffffffffff
[    0.000000] x13: ffff800091973b4f x12: ffff800011973b5c
[    0.000000] x11: ffff800011989000 x10: 0000000000000080
[    0.000000] x9 : ffff8000101991e4 x8 : 0000000000040000
[    0.000000] x7 : 000000000000413d x6 : 0000000000000000
[    0.000000] x5 : 0000000000000000 x4 : 0000000000000000
[    0.000000] x3 : 0000000000000080 x2 : ffff8000119c1f10
[    0.000000] x1 : ffff800011991a40 x0 : ffff800013c9000c
[    0.000000] Call trace:
[    0.000000]  __raw_readl+0x0/0x8
[    0.000000]  gic_of_init+0x170/0x1f8
[    0.000000]  of_irq_init+0x1e4/0x3c4
[    0.000000]  irqchip_init+0x1c/0x40
[    0.000000]  init_IRQ+0x164/0x194
[    0.000000]  start_kernel+0x334/0x4cc

So avoid reading TYPER2 on GICv3.

Fixes: f2d834092ee2 ("irqchip/gic-v3: Add GICv4.1 VPEID size discovery")
Signed-off-by: Mark Salter <msalter@redhat.com>
---
 drivers/irqchip/irq-gic-v3.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c1f7af9d9ae7..cd9a6c8fe68a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1550,7 +1550,7 @@ static int __init gic_init_bases(void __iomem *dist=
_base,
 				 u64 redist_stride,
 				 struct fwnode_handle *handle)
 {
-	u32 typer;
+	u32 typer, pidr2;
 	int err;
=20
 	if (!is_hyp_mode_available())
@@ -1577,7 +1577,9 @@ static int __init gic_init_bases(void __iomem *dist=
_base,
 	pr_info("%d SPIs implemented\n", GIC_LINE_NR - 32);
 	pr_info("%d Extended SPIs implemented\n", GIC_ESPI_NR);
=20
-	gic_data.rdists.gicd_typer2 =3D readl_relaxed(gic_data.dist_base + GICD=
_TYPER2);
+	pidr2 =3D readl_relaxed(dist_base + GICD_PIDR2) & GIC_PIDR2_ARCH_MASK;
+	if (pidr2 !=3D GIC_PIDR2_ARCH_GICv3)
+		gic_data.rdists.gicd_typer2 =3D readl_relaxed(gic_data.dist_base + GIC=
D_TYPER2);
=20
 	gic_data.domain =3D irq_domain_create_tree(handle, &gic_irq_domain_ops,
 						 &gic_data);
--=20
2.24.1

