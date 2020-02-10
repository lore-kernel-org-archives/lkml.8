Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A48C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9492070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339973;
	bh=ERMBUPI2b+Utm9Kh81/B4lVCmtApptrrQn2lLHq7HNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bm+MU+pdNG0l8qMGTUW2fHneRohtUKFeBJGI5qvYK6cjiMUN+szkc1exIYECs4on5
	 5SnU98FPW9rgT49/IySxvz/4MoaOp0N50QqSGriW5GkOxpfwEGecviniYg5OkKTPzr
	 orxEAQ+XVoiYvW1wy2K4BGLWHdIJF20xda6pCgRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbgBJNGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbgBJMj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:56 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38C8420842;
        Mon, 10 Feb 2020 12:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338396;
        bh=ERMBUPI2b+Utm9Kh81/B4lVCmtApptrrQn2lLHq7HNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FXRzeQD3cJba+A03VvpoJC/Pe6Y5TzX1BNM2C+EncLnS4ZZZzc4spSTTVWkgpolBe
         78pEmlfeINE7qY6B0jtOpKt/VkDEXV9MwWq+5hcbQuKrK4FqjZEjhJlMh62KQJ11GB
         bUmRfRwmjKAtHSZbeXu0uThJvAuEDdKT/T3mt+ZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yurii Monakov <monakov.y@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 5.5 091/367] PCI: keystone: Fix outbound region mapping
Date:   Mon, 10 Feb 2020 04:30:04 -0800
Message-Id: <20200210122432.772864661@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yurii Monakov <monakov.y@gmail.com>

commit 2d0c3fbe43fa0e6fcb7a6c755c5f4cd702c0d2f4 upstream.

The Keystone outbound Address Translation Unit (ATU) maps PCI MMIO space in
8 MB windows.  When programming the ATU windows, we previously incremented
the starting address by 8, not 8 MB, so all the windows were mapped to the
first 8 MB.  Therefore, only 8 MB of MMIO space was accessible.

Update the loop so it increments the starting address by 8 MB, not 8, so
more MMIO space is accessible.

Fixes: e75043ad9792 ("PCI: keystone: Cleanup outbound window configuration")
Link: https://lore.kernel.org/r/20191004154811.GA31397@monakov-y.office.kontur-niirs.ru
Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Andrew Murray <andrew.murray@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Cc: stable@vger.kernel.org	# v4.20+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/dwc/pci-keystone.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -422,7 +422,7 @@ static void ks_pcie_setup_rc_app_regs(st
 				   lower_32_bits(start) | OB_ENABLEN);
 		ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i),
 				   upper_32_bits(start));
-		start += OB_WIN_SIZE;
+		start += OB_WIN_SIZE * SZ_1M;
 	}
 
 	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);


