Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48086C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 250502078E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947877;
	bh=Qfg61+DghFr5+2ESybLHRKHDHYvGzAuFLIkZ6bl/Bgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HGr+yt28knHUBaV4NA0u7VNMvfDvycIqgwWZAjgqG4Xa7s+w9tXRGjq1GqdQGIszs
	 dfyS1/0st6EUYI/C7DwCytmXBZrbCnYs0tBLHxrWnOldfP0vG9bEDEJzkzJHOBvgJN
	 muSQ9807TFe5VOJC6xSuoLwpA6S9RTGtV01+f8m0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393658AbgFWVbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389058AbgFWUNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:13:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E51520707;
        Tue, 23 Jun 2020 20:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943192;
        bh=Qfg61+DghFr5+2ESybLHRKHDHYvGzAuFLIkZ6bl/Bgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fBNIbJVyPPqD5qDdYKcHUc3Z4mBPn+30fhDmCgnNr4gxPB8+5k0EP47w2bZompzxu
         Ln4UUd3bzND0Km4hfEqkLQBO9U3qQRoECQIUErNTUDCVF0bAxyqEtCqgwmgCfbmvRk
         /J/B4oZF7NMhKAcZOuzsX6bHtbNeVVugHdOgYJrk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, huhai <huhai@tj.kylinos.cn>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 295/477] powerpc/4xx: Dont unmap NULL mbase
Date:   Tue, 23 Jun 2020 21:54:52 +0200
Message-Id: <20200623195421.499947081@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: huhai <huhai@tj.kylinos.cn>

[ Upstream commit bcec081ecc940fc38730b29c743bbee661164161 ]

Signed-off-by: huhai <huhai@tj.kylinos.cn>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200521072648.1254699-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/4xx/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/4xx/pci.c b/arch/powerpc/platforms/4xx/pci.c
index e6e2adcc7b64c..c13d64c3b0194 100644
--- a/arch/powerpc/platforms/4xx/pci.c
+++ b/arch/powerpc/platforms/4xx/pci.c
@@ -1242,7 +1242,7 @@ static void __init ppc460sx_pciex_check_link(struct ppc4xx_pciex_port *port)
 	if (mbase == NULL) {
 		printk(KERN_ERR "%pOF: Can't map internal config space !",
 			port->node);
-		goto done;
+		return;
 	}
 
 	while (attempt && (0 == (in_le32(mbase + PECFG_460SX_DLLSTA)
@@ -1252,9 +1252,7 @@ static void __init ppc460sx_pciex_check_link(struct ppc4xx_pciex_port *port)
 	}
 	if (attempt)
 		port->link = 1;
-done:
 	iounmap(mbase);
-
 }
 
 static struct ppc4xx_pciex_hwops ppc460sx_pcie_hwops __initdata = {
-- 
2.25.1



