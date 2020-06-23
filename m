Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B151C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2840620780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943792;
	bh=bwz6D8FBQD9hPc5U0y0YPLANP4AYBqfGkOSytfzbCVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R4EwdgzzfnIIkTHJN0pJE1qz1yET7klo7Is4Dm9w4WNQDxizQHbfMxe2K2p8sKX9q
	 S1Eft71R+29d9dS9nm3qAEbmnVnB84xLbpDuc/B1FMSlnWPhBLoayjo5jrRAkod/92
	 sTpuCUJUIimQ7IPohs+yKNbYVLu1DMAsQ2HWBQuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390265AbgFWUXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:23:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390196AbgFWUXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:23:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5088B206C3;
        Tue, 23 Jun 2020 20:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943786;
        bh=bwz6D8FBQD9hPc5U0y0YPLANP4AYBqfGkOSytfzbCVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bCLoU0i0dftNApTAklj5e22jLSgqoNZGKt7BYrlvolyjslcFXpcGihY5GRBWFWlbF
         w7UFeO2bpHHIF5xiE3eR9dzHyZ1OC31WLfA6DbkIaiA/sq2btPqAcaqSeS5rikbi3L
         1FU0WNjgvftRnKL35SZD8JFR8lScjn3OhDsZRrzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 050/314] m68k/PCI: Fix a memory leak in an error handling path
Date:   Tue, 23 Jun 2020 21:54:05 +0200
Message-Id: <20200623195341.209368381@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit c3f4ec050f56eeab7c1f290321f9b762c95bd332 ]

If 'ioremap' fails, we must free 'bridge', as done in other error handling
path bellow.

Fixes: 19cc4c843f40 ("m68k/PCI: Replace pci_fixup_irqs() call with host bridge IRQ mapping hooks")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/m68k/coldfire/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/coldfire/pci.c b/arch/m68k/coldfire/pci.c
index 62b0eb6cf69a3..84eab0f5e00af 100644
--- a/arch/m68k/coldfire/pci.c
+++ b/arch/m68k/coldfire/pci.c
@@ -216,8 +216,10 @@ static int __init mcf_pci_init(void)
 
 	/* Keep a virtual mapping to IO/config space active */
 	iospace = (unsigned long) ioremap(PCI_IO_PA, PCI_IO_SIZE);
-	if (iospace == 0)
+	if (iospace == 0) {
+		pci_free_host_bridge(bridge);
 		return -ENODEV;
+	}
 	pr_info("Coldfire: PCI IO/config window mapped to 0x%x\n",
 		(u32) iospace);
 
-- 
2.25.1



