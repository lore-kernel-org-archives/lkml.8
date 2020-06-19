Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ACBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F95206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584928;
	bh=+OqL3g/sf9U353eb2k/SFrF3QoYc+2uS+3VyI8316Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EwRKFZXdjYdycxooxvYMwot6vowHYY9Tok7KbBKBbTEBaO8BcGbGM+Ne7hPRv/X7J
	 y/SiIdj23b04sefgH95JqzgEVWRCqK+NdOnFQU8Dsy9x0GaY3pVa2wiT8cGrd4Q5xs
	 Hz5itiEin5tylIy16Lglt72Wdf0hDZ11NXcsOyRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388055AbgFSOoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:44:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388511AbgFSOoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:44:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 996B821582;
        Fri, 19 Jun 2020 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577857;
        bh=+OqL3g/sf9U353eb2k/SFrF3QoYc+2uS+3VyI8316Iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N2H65OzxyJbjLM77SvZhmXldshMhHvAB0Uvs4GOdbIzR57cQcqLFmrThSguwm4898
         EQaAjj+xEWagi+h/Q1p4Z7Bs5S6qgPC/Q77E/rbMAs2wM0Q+DUGMK4v80KC1n4CRj8
         Xp+n1R1XuG5m28WpbUZiO5/UrVsZbwer5cWg6jzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 090/128] PCI: Dont disable decoding when mmio_always_on is set
Date:   Fri, 19 Jun 2020 16:33:04 +0200
Message-Id: <20200619141624.900323124@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141620.148019466@linuxfoundation.org>
References: <20200619141620.148019466@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

[ Upstream commit b6caa1d8c80cb71b6162cb1f1ec13aa655026c9f ]

Don't disable MEM/IO decoding when a device have both non_compliant_bars
and mmio_always_on.

That would allow us quirk devices with junk in BARs but can't disable
their decoding.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Acked-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 16611cf3aba4..be63f008167b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1251,7 +1251,7 @@ int pci_setup_device(struct pci_dev *dev)
 	/* device class may be changed after fixup */
 	class = dev->class >> 8;
 
-	if (dev->non_compliant_bars) {
+	if (dev->non_compliant_bars && !dev->mmio_always_on) {
 		pci_read_config_word(dev, PCI_COMMAND, &cmd);
 		if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
 			dev_info(&dev->dev, "device has non-compliant BARs; disabling IO/MEM decoding\n");
-- 
2.25.1



