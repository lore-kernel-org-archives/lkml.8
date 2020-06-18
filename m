Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1D1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91697221EB
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443563;
	bh=7tbR37TlDsxb2DvWezaDQ8YEVSOAqo98BHGh0rZj/rE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FG4T3nYaSPIYODymG99WFk/griLhT1JSnCLd+i9E2eVCau55W/kzcbEeTGZUnvYj0
	 Kb2jalmqOa+nZrb/HrW8OGwm0czWg8nGdaJ/9IHAmV/kXk3VuOPpRwuKett2yVM3D3
	 co3ea1bEgTdN+lwao4i1TRuRXR/vJvhE9IhvlQY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbgFRB0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:26:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730885AbgFRBW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:22:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B763A20663;
        Thu, 18 Jun 2020 01:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443378;
        bh=7tbR37TlDsxb2DvWezaDQ8YEVSOAqo98BHGh0rZj/rE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pd2G8YRE7ZGoKcg0FL8BkH4lsroCH4NMZA/S5j3Ff8c6ateqYBAc+cVHki1SA4RJd
         ifww6MRyoILcose5/WP6yEXJEgQ0DTp4+8fCQAhvIKSEtxlZrLO7HQOMEWILVvF+px
         o74DfZj+JkBKfToHSbopp2a+VaJabDSS85y+xVtE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH AUTOSEL 4.19 030/172] m68k/PCI: Fix a memory leak in an error handling path
Date:   Wed, 17 Jun 2020 21:19:56 -0400
Message-Id: <20200618012218.607130-30-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 62b0eb6cf69a..84eab0f5e00a 100644
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

