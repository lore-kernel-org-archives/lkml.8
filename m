Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A100DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B85121475
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322193;
	bh=GYKceUWiKTWd7buFEwn0Zq8KbhSyUZuX2hidA0mNV9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GpHihAIj06tuzUaIvFMdgeYCUpDA06UVV0YIi/X50lrEBwUL6aVfiRxm8ncu9MNYD
	 zuKC9lCD6Q7DjBHmV/Vjj3fjRSWCpgfVdSMAiVYH02TyrMP5TqtLP1p0ivfQ6ckrSa
	 oPMiRBoZQfVLyFP6iX39L/EkU2IWdqnKKJ+MTMZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731745AbgFPPnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730511AbgFPPnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:43:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 748E320C56;
        Tue, 16 Jun 2020 15:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322180;
        bh=GYKceUWiKTWd7buFEwn0Zq8KbhSyUZuX2hidA0mNV9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqoOMXbBBNrgkGuWOwSDLhd1h8ucAs7nTHzDfEmqHo5nVcfuoCHToGKr/6q+/ASbH
         OIFeAwDxUZjo5Vi91Y4hIEOtbru1ibD/4aLnW5duSTvm6iQwCHOclnNOmW70etRXKu
         vXMHV9eLgfYLpHeq6013ZO4rSyaU6naXQ9VIwDbw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 032/163] PCI/PM: Adjust pcie_wait_for_link_delay() for caller delay
Date:   Tue, 16 Jun 2020 17:33:26 +0200
Message-Id: <20200616153108.409749996@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
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
index 595fcf59843f..6d3234f75692 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4673,10 +4673,10 @@ static bool pcie_wait_for_link_delay(struct pci_dev *pdev, bool active,
 
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



