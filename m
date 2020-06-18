Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ADDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E984B221FC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443709;
	bh=ucPRTRAWMCzG01CKxJA0bFF6v+FaYv16oCiGiLdMngA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T2YcB7KVYNpdyJxBDproGswbcOSN/5bE4NoDGNlORzcrRQh/5WVtgr+i4gqucuduK
	 w6ilA7KG93jjb9I2+zDdViLMIoWKazvKv7e2/0E5W4NUQgJ1rCHrF/2+XWS+i0UmQ0
	 Ye9beDv6QpXd6mIh94eRSrGZyvLMVQA6nnvmk23U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbgFRB21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:28:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731356AbgFRBZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:25:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4435221F0;
        Thu, 18 Jun 2020 01:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443506;
        bh=ucPRTRAWMCzG01CKxJA0bFF6v+FaYv16oCiGiLdMngA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rf83RWc9kLOvKBORelAmg9aZWUKZZ7/Dc5bL+8s6vHvg4V+2PMQ6AZpyGoKus/tGU
         twj6g7LPGquVQR1vbhYJY9yVAyTRKwvPqpyNeZQc5anLZPxdI3S75kMFDRV67mT4LS
         0k3HaE7Unr16wE/XZKF149+0KyvV/K3arCJWcUK0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     huhai <huhai@tj.kylinos.cn>, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 131/172] powerpc/4xx: Don't unmap NULL mbase
Date:   Wed, 17 Jun 2020 21:21:37 -0400
Message-Id: <20200618012218.607130-131-sashal@kernel.org>
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
index 5aca523551ae..2f237027fdcc 100644
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

