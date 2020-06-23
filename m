Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EBFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2591A2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944666;
	bh=Y7FAiX8CURS11zx9KBYS3lzd3Tvh+mY6DZ2CwCmsM7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XVnBkywJnme06WR0o+Ir/UYAiCdn5h4OOIAw38NyYLcpfXHaGDgHla+FOmrSvzyrM
	 KHYH+th0VeywbYfiufvdGe4brfiQ4BtGRwtHwpHKyqzjcvEOBpfBtqOi7w0/8++WKj
	 OCC8pVAFfvHoieEDmk/vbzOnXHf3PTu/fduCsCFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391877AbgFWUhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:32776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391863AbgFWUhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:37:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A47BD20781;
        Tue, 23 Jun 2020 20:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944652;
        bh=Y7FAiX8CURS11zx9KBYS3lzd3Tvh+mY6DZ2CwCmsM7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aCob0pbZemgeqJxDcqE1cCUJ37dGUTC1QsCiZ5W6yYUktFQ5g1s81YIcwQ15bBmjl
         1wZt0Z+h97CLLioaIjP+8MGNhJIp6Qm2VGLFyh9Ho6WTviR8nAVl6kfVdQmqv7ign9
         6cpixtTkpicl3/Qu25w/xxKtW/RvAsR459L8IXx0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 073/206] PCI: rcar: Fix incorrect programming of OB windows
Date:   Tue, 23 Jun 2020 21:56:41 +0200
Message-Id: <20200623195320.547670274@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Murray <andrew.murray@arm.com>

[ Upstream commit 2b9f217433e31d125fb697ca7974d3de3ecc3e92 ]

The outbound windows (PCIEPAUR(x), PCIEPALR(x)) describe a mapping between
a CPU address (which is determined by the window number 'x') and a
programmed PCI address - Thus allowing the controller to translate CPU
accesses into PCI accesses.

However the existing code incorrectly writes the CPU address - lets fix
this by writing the PCI address instead.

For memory transactions, existing DT users describe a 1:1 identity mapping
and thus this change should have no effect. However the same isn't true for
I/O.

Link: https://lore.kernel.org/r/20191004132941.6660-1-andrew.murray@arm.com
Fixes: c25da4778803 ("PCI: rcar: Add Renesas R-Car PCIe driver")
Tested-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-rcar.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 333ab6092f174..00296c5eacb9c 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -335,11 +335,12 @@ static struct pci_ops rcar_pcie_ops = {
 };
 
 static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie,
-				   struct resource *res)
+				   struct resource_entry *window)
 {
 	/* Setup PCIe address space mappings for each resource */
 	resource_size_t size;
 	resource_size_t res_start;
+	struct resource *res = window->res;
 	u32 mask;
 
 	rcar_pci_write_reg(pcie, 0x00000000, PCIEPTCTLR(win));
@@ -353,9 +354,9 @@ static void rcar_pcie_setup_window(int win, struct rcar_pcie *pcie,
 	rcar_pci_write_reg(pcie, mask << 7, PCIEPAMR(win));
 
 	if (res->flags & IORESOURCE_IO)
-		res_start = pci_pio_to_address(res->start);
+		res_start = pci_pio_to_address(res->start) - window->offset;
 	else
-		res_start = res->start;
+		res_start = res->start - window->offset;
 
 	rcar_pci_write_reg(pcie, upper_32_bits(res_start), PCIEPAUR(win));
 	rcar_pci_write_reg(pcie, lower_32_bits(res_start) & ~0x7F,
@@ -384,7 +385,7 @@ static int rcar_pcie_setup(struct list_head *resource, struct rcar_pcie *pci)
 		switch (resource_type(res)) {
 		case IORESOURCE_IO:
 		case IORESOURCE_MEM:
-			rcar_pcie_setup_window(i, pci, res);
+			rcar_pcie_setup_window(i, pci, win);
 			i++;
 			break;
 		case IORESOURCE_BUS:
-- 
2.25.1



