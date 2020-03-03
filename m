Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58EEC3F2D2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF4D217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583204401;
	bh=WjVkyx4bAcEUcr024KxWqAaqorwRD6jLBAOrJiAw1OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s+0ufpWLN9tMKj+qY8Dg0Ztfa6uvnwkobxWZ5yOq2xWq76NxUNdLhef761nY+QBTN
	 8tCGzlISOCkKBCNzzrLHw5XlG9EUCBWRneF9owy4Ign9Ghwf7aS7M7FlHeMkF9kZKz
	 un3xTV0MKOQXPfdmVAxhGYINvxDNGolKVuM1bVdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgCCC77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:59:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbgCCCr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:47:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C132246A1;
        Tue,  3 Mar 2020 02:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203648;
        bh=WjVkyx4bAcEUcr024KxWqAaqorwRD6jLBAOrJiAw1OY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sM3dTi6qDSqKsKXz9sIFlS33+Eux/34CeC7nnjY64Y8VKdVF5588jz2snSK31wmKj
         170Rs8rZAqEFNSXmLNrezWtratkKMP3O7L02YaMzaMDNtgDum5Ro9UIYttmaG9Y6RP
         3km1JSUMSeg0yeRM8ZrU3do6aBYWY8BzNIePRxf4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 58/66] bnxt_en: Improve device shutdown method.
Date:   Mon,  2 Mar 2020 21:46:07 -0500
Message-Id: <20200303024615.8889-58-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024615.8889-1-sashal@kernel.org>
References: <20200303024615.8889-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9d62200b6c335..1a90118370ea1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11972,10 +11972,10 @@ static void bnxt_shutdown(struct pci_dev *pdev)
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
-- 
2.20.1

