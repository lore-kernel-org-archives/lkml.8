Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30C6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87EBC20E65
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592321819;
	bh=qbjFp3mx16T80Cvs+TRI69TmGM1espN6i4MH6KsISO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sf0ESdRuGAH3X3RrLRegbG3GlyOf9QTmLsvt7fR81FYX/RFIMzoNk1TdCa2k5rjmN
	 2HD790lVurVWGT3ByyBabqR3Saa9o4MsD2jimlutDGhwv71NX8fh4zx1606D+Ib/KQ
	 tMwpWTjGbnx5A0XpjguQGcvDn1JKtI7I0K/kVhic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbgFPPg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:36:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730139AbgFPPg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:36:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CD7D2098B;
        Tue, 16 Jun 2020 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592321816;
        bh=qbjFp3mx16T80Cvs+TRI69TmGM1espN6i4MH6KsISO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mk/S6iMSf/nIBQ3CllzAtjilVJ2Ww80LsidpQOnsWFnaI6FEY1ZlX7d5hew6oh/fB
         lIO+57VceLbubLLcjhcEi5ciSca8AIwCoSjOkCpoWqWdsgN9jtEkHTAeYgLucoC0C5
         1Qk8rk+imN5kkE0niSJTbcei7JB5By8AM5THNpfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 027/134] PCI/PM: Adjust pcie_wait_for_link_delay() for caller delay
Date:   Tue, 16 Jun 2020 17:33:31 +0200
Message-Id: <20200616153102.067648603@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153100.633279950@linuxfoundation.org>
References: <20200616153100.633279950@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit f044baaff1eb7ae5aa7a36f1b7ad5bd8eeb672c4 ]

The caller of pcie_wait_for_link_delay() specifies the time to wait after
the link becomes active.  When the downstream port doesn't support link
active reporting, obviously we can't tell when the link becomes active, so
we waited the worst-case time (1000 ms) plus 100 ms, ignoring the delay
from the caller.

Instead, wait for 1000 ms + the delay from the caller.

Fixes: 4827d63891b6 ("PCI/PM: Add pcie_wait_for_link_delay()")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 779132aef0fb..c73e8095a849 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4621,10 +4621,10 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 
 	/*
 	 * Some controllers might not implement link active reporting. In this
-	 * case, we wait for 1000 + 100 ms.
+	 * case, we wait for 1000 ms + any delay requested by the caller.
 	 */
 	if (!pdev->link_active_reporting) {
-		msleep(1100);
+		msleep(timeout + delay);
 		return true;
 	}
 
-- 
2.25.1



