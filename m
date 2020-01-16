Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC7EC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12A52073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217902;
	bh=CS1XRDACWBXXeycLKvho87XDFgutnA8XGJnE6lEdYBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k8HgcplJki6V5JOGcktiXgpXx75eqf/1zyHI/5hgza6aNBodH8q5p9ovQ2PNh/vLF
	 7nnpcJH/Lcc7klS50VPY/llwNa4ZaLiFksPJHS+pGr5Brb4el9Wu1hl5LeRCZssIco
	 3oX4Pj6bM1MQIlfmzb/bdsjqCeTn0wMya35poLDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404041AbgAPXiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:38:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391272AbgAPX33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:29:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA60F2082F;
        Thu, 16 Jan 2020 23:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217369;
        bh=CS1XRDACWBXXeycLKvho87XDFgutnA8XGJnE6lEdYBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NhyNopf76GBSL2K6yTZbdxGtQTFKI/5gA61g81YuIysvqLOy8yOcUJFBkG0/Jhske
         INuFNZoa7AK4fdAMk37LKShvzQ1iLv2WcZqM6ICrGtM/OTHXw1sgjGeMmBy/kzQDVd
         aSila0Byoe9YZKxQiTmcL5SNWO5ENJz+y+0Wnfnc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH 4.19 54/84] PCI: dwc: Fix find_next_bit() usage
Date:   Fri, 17 Jan 2020 00:18:28 +0100
Message-Id: <20200116231720.175036407@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231713.087649517@linuxfoundation.org>
References: <20200116231713.087649517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@linaro.org>

commit 1137e61dcb99f7f8b54e77ed83f68b5b485a3e34 upstream.

find_next_bit() takes a parameter of size long, and performs arithmetic
that assumes that the argument is of size long.

Therefore we cannot pass a u32, since this will cause find_next_bit()
to read outside the stack buffer and will produce the following print:
BUG: KASAN: stack-out-of-bounds in find_next_bit+0x38/0xb0

Fixes: 1b497e6493c4 ("PCI: dwc: Fix uninitialized variable in dw_handle_msi_irq()")
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/dwc/pcie-designware-host.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -78,7 +78,8 @@ static struct msi_domain_info dw_pcie_ms
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
 {
 	int i, pos, irq;
-	u32 val, num_ctrls;
+	unsigned long val;
+	u32 status, num_ctrls;
 	irqreturn_t ret = IRQ_NONE;
 
 	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
@@ -86,14 +87,14 @@ irqreturn_t dw_handle_msi_irq(struct pci
 	for (i = 0; i < num_ctrls; i++) {
 		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS +
 					(i * MSI_REG_CTRL_BLOCK_SIZE),
-				    4, &val);
-		if (!val)
+				    4, &status);
+		if (!status)
 			continue;
 
 		ret = IRQ_HANDLED;
+		val = status;
 		pos = 0;
-		while ((pos = find_next_bit((unsigned long *) &val,
-					    MAX_MSI_IRQS_PER_CTRL,
+		while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
 					    pos)) != MAX_MSI_IRQS_PER_CTRL) {
 			irq = irq_find_mapping(pp->irq_domain,
 					       (i * MAX_MSI_IRQS_PER_CTRL) +


