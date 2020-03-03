Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FCCC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E60206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258054;
	bh=mYVq59/icy0FJB4PO/fo2pWze3ZggxVI6qyA2COpnic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hqAWSKX3B9ZFI4nYLjfhnH/h8HF0PNmpilt0S11Q21iB+X69v858Oacah5x1tRBGA
	 tx0M9pPAJIh0oPuJmm8t72LAgS1GbL1QddJnfuKttpG9yf/pt2CHxi78DQbEJcmxiH
	 XRSa7iE5WQ/PTWPI/SHnrpruHd/7F8loP4ditgSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbgCCRyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:54:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:35272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732492AbgCCRyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:54:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AAB0206D5;
        Tue,  3 Mar 2020 17:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258051;
        bh=mYVq59/icy0FJB4PO/fo2pWze3ZggxVI6qyA2COpnic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CddN4VYR1WWun4netlMcM0Lx6Sc4sx+IBie29oOF7bXE1TKCkaxqTJcaqxH7RLtZQ
         IWSaeE+f7HPTRHBoNuxSc+p/Ir25sLUlVjDfBsRaCKHHVUcqnA3d5B0VKVzCsN6SFv
         1yEl3bcufWLVTPZaiPZ96axd8OjOnw9gMxRWUtLU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 015/152] bnxt_en: Improve device shutdown method.
Date:   Tue,  3 Mar 2020 18:41:53 +0100
Message-Id: <20200303174304.229062032@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174302.523080016@linuxfoundation.org>
References: <20200303174302.523080016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasundhara Volam <vasundhara-v.volam@broadcom.com>

[ Upstream commit 5567ae4a8d569d996d0d88d0eceb76205e4c7ce5 ]

Especially when bnxt_shutdown() is called during kexec, we need to
disable MSIX and disable Bus Master to completely quiesce the device.
Make these 2 calls unconditionally in the shutdown method.

Fixes: c20dc142dd7b ("bnxt_en: Disable bus master during PCI shutdown and driver unload.")
Signed-off-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11908,10 +11908,10 @@ static void bnxt_shutdown(struct pci_dev
 		dev_close(dev);
 
 	bnxt_ulp_shutdown(bp);
+	bnxt_clear_int_mode(bp);
+	pci_disable_device(pdev);
 
 	if (system_state == SYSTEM_POWER_OFF) {
-		bnxt_clear_int_mode(bp);
-		pci_disable_device(pdev);
 		pci_wake_from_d3(pdev, bp->wol);
 		pci_set_power_state(pdev, PCI_D3hot);
 	}


